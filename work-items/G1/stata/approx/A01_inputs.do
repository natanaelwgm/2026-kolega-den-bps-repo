version 17.0
* WFDOC: Separately registered approximate-real DEVELOPMENT sensitivity, not primary real TFP.
* WFDOC: Run prepare_approx.py first. Its new external run contains frozen prices and narrow adapter inputs.
* WFDOC: Stock and additions use only coherent preserved raw nonland components; no jitter-factor recovery.
* WFDOC: Keep2010 history, production2011–2012, and exact annual lags. No estimation occurs in this file.
if "$G1_RUN"=="" exit 198

capture program drop g1_apr_parse
program define g1_apr_parse
    version 17.0
    syntax varname(string), Generate(name) Status(name) [SOURCEYear(integer 0)]
    tempvar text syntax_ok
    gen strL `text'=strtrim(`varlist')
    gen byte `status'=2
    replace `status'=0 if `text'==""
    replace `status'=1 if ustrregexm(`text',"^[.][a-z]?$")
    gen byte `syntax_ok'=ustrregexm(`text',"^[+-]?(([0-9]+([.][0-9]*)?)|([.][0-9]+)|([0-9]{1,3}(,[0-9]{3})+([.][0-9]*)?))([eE][+-]?[0-9]+)?$")
    gen double `generate'=real(subinstr(`text',",","",.)) if `syntax_ok'
    replace `status'=3 if `syntax_ok' & missing(`generate')
    replace `status'=4 if `syntax_ok' & `generate'==0
    replace `status'=5 if `syntax_ok' & `generate'<0
    replace `status'=6 if `syntax_ok' & `generate'>0 & !missing(`generate')
    if `sourceyear'!=0 {
        replace `status'=7 if source_year!=`sourceyear'
        replace `generate'=. if source_year!=`sourceyear'
    }
    label variable `status' "0blank 1missing-marker 2malformed 3overflow 4zero 5negative 6positive 7other-year"
end

* WFDOC: The table is a hash-verified copy made before parsing/fitting, base2005=100.
import delimited using "$G1_RUN/approx/prices.csv", clear varnames(1)
assert _N==3
isid source_year
assert inrange(source_year,2010,2012)
foreach p in apr_p_y apr_p_m apr_p_k_ann apr_p_k_dec {
    confirm numeric variable `p'
    assert `p'>0 & !missing(`p')
}
tempfile prices
save `prices'

use "$G1_RUN/approx/S01_input.dta", clear
assert inrange(source_year,2010,2012)
assert psid_status=="synthetic_development"
assert !missing(obs_id,psid,source_year)
isid obs_id
isid psid source_year
merge m:1 source_year using `prices', assert(match) nogen

* WFDOC: A zero component is an observed zero; a missing/negative component invalidates the sum.
g1_apr_parse raw_v1103, generate(apr_k_building) status(apr_parse_k_building)
g1_apr_parse raw_v1106, generate(apr_k_machine) status(apr_parse_k_machine)
g1_apr_parse raw_v1109, generate(apr_k_vehicle) status(apr_parse_k_vehicle)
g1_apr_parse raw_v1112, generate(apr_k_other) status(apr_parse_k_other)
gen byte apr_stock_complete=!missing(apr_k_building,apr_k_machine,apr_k_vehicle,apr_k_other)
gen byte apr_stock_nonnegative=apr_stock_complete & apr_k_building>=0 & apr_k_machine>=0 & apr_k_vehicle>=0 & apr_k_other>=0
gen double apr_k_end_nominal=apr_k_building+apr_k_machine+apr_k_vehicle+apr_k_other if apr_stock_nonnegative
gen byte apr_stock_sum_overflow=apr_stock_nonnegative & missing(apr_k_end_nominal)

gen double apr_i_nominal=.
gen byte apr_i_complete=0
gen byte apr_i_nonnegative=0
gen byte apr_i_sum_overflow=0
foreach year in 2010 2011 2012 {
    local yy=substr("`year'",3,2)
    foreach asset in cb cm cv co {
        g1_apr_parse raw_`asset'ttcu`yy', generate(apr_i_`asset'`yy') status(apr_parse_i_`asset'`yy') sourceyear(`year')
    }
    replace apr_i_complete=!missing(apr_i_cb`yy',apr_i_cm`yy',apr_i_cv`yy',apr_i_co`yy') if source_year==`year'
    replace apr_i_nonnegative=apr_i_complete & apr_i_cb`yy'>=0 & apr_i_cm`yy'>=0 & apr_i_cv`yy'>=0 & apr_i_co`yy'>=0 if source_year==`year'
    replace apr_i_nominal=apr_i_cb`yy'+apr_i_cm`yy'+apr_i_cv`yy'+apr_i_co`yy' if source_year==`year' & apr_i_nonnegative
    replace apr_i_sum_overflow=apr_i_nonnegative & missing(apr_i_nominal) if source_year==`year'
}

* WFDOC: Documentary concept flags describe this branch's source years only; they are not primary real admission.
gen byte apr_stock_concept=inrange(source_year,2010,2012)
gen byte apr_i_concept=inrange(source_year,2010,2012)
gen double apr_va_deflated=value_added_nominal/(apr_p_y/100)
gen double apr_m_deflated=val_rtlvcu/(apr_p_m/100)
gen double apr_i_deflated=apr_i_nominal/(apr_p_k_ann/100)
gen double apr_k_end_deflated=apr_k_end_nominal/(apr_p_k_dec/100)
xtset psid source_year, delta(1)
gen double apr_k_begin=L.apr_k_end_deflated
gen byte apr_k_concept=L.apr_stock_concept==1
gen double apr_y=ln(apr_va_deflated) if apr_va_deflated>0 & !missing(apr_va_deflated)
gen double apr_l=ln(workers) if workers>0 & !missing(workers)
gen double apr_k=ln(apr_k_begin) if apr_k_begin>0 & !missing(apr_k_begin) & apr_k_concept
gen double apr_i=ln(apr_i_deflated) if apr_i_deflated>0 & !missing(apr_i_deflated) & apr_i_concept
gen double apr_m=ln(apr_m_deflated) if apr_m_deflated>0 & !missing(apr_m_deflated)
gen str2 apr_sector=substr(industry_code,1,2)
gen byte apr_production=inrange(source_year,2011,2012) & ustrregexm(industry_code,"^[0-9]{5}$") & inrange(real(apr_sector),10,33)
gen byte apr_domain_op=apr_production & !missing(apr_y,apr_l,apr_k,apr_i)
gen byte apr_domain_lp=apr_production & !missing(apr_y,apr_l,apr_k,apr_m)
gen byte apr_domain_acf=apr_domain_lp
gen byte apr_domain_wrdg=apr_domain_lp
gen byte apr_domain_common=apr_domain_op & apr_domain_lp
gen byte apr_primary_real_admitted=0
gen str40 apr_specification_id="G1_DEV_APPROX_REAL_NONLAND_2010_2012_V1"
gen str32 apr_measurement_mode="approximate_real_development"
label data "G0.5 DEVELOPMENT approximate-real nonland sensitivity; not empirical TFP"
save "$G1_RUN/approx/A01_source.dta", replace
capture program drop g1_apr_parse
