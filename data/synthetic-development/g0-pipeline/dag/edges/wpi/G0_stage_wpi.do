* Actual macro price reference only. Reconstruct Toar's extension; no company inputs.
log using "dag/logs/G0_wpi_reference.log", text replace name(wpi)
local src "references/toar-wpi-20260910"
use "`src'/data/wpio_extended_2000_2022.dta", clear
isid isic
assert _N==131
assert abs(wpi2000-100)<1e-10
assert missing(wpi2016)
forvalues y=1983/2022 {
    if `y'!=2016 assert wpi`y'>0 & !missing(wpi`y')
}
rename isic isic4
save "dag/data/references/WPI_source_wide.dta", replace
* Check source CSV agrees within its published decimal precision.
preserve
reshape long wpi, i(isic4) j(year)
rename wpi wpi_dta
tempfile reference_long
save `reference_long'
import delimited "`src'/data/wpio_extended_2000_2022_long.csv", clear
rename isic isic4
isid isic4 year
merge 1:1 isic4 year using `reference_long', assert(match) nogen
assert missing(wpi)==missing(wpi_dta)
assert reldif(wpi,wpi_dta)<1e-6 if !missing(wpi)
restore
* Reuse the delivered IHPB primary/secondary semantic concordance.
import delimited "`src'/source/ihpb_annual_averages_2013_2022.csv", clear
isid ihpb_sub
assert _N==50
tempfile averages
save `averages'
import delimited "`src'/source/ihpb_isic4_concordance.csv", stringcols(_all) clear
isid isic4
destring isic4, replace
generate byte cagr_flag=ihpb_sub=="CAGR"
destring ihpb_sub, generate(sub1) force
assert !missing(real(ihpb_sub2)) if ihpb_sub2!=""
destring ihpb_sub2, generate(sub2) force
assert missing(sub1)==cagr_flag
keep isic4 sub1 sub2 cagr_flag
merge 1:1 isic4 using "dag/data/references/WPI_source_wide.dta", assert(match) nogen
rename sub1 ihpb_sub
merge m:1 ihpb_sub using `averages', keep(master match) generate(m1)
assert m1==3 if !cagr_flag
drop m1
rename ihpb_sub sub1
foreach y in 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
 rename ihpb`y' ihpb`y'_1
}
capture drop ihpb_sub_name
rename sub2 ihpb_sub
merge m:1 ihpb_sub using `averages', keep(master match) generate(m2)
assert m2==3 if !missing(ihpb_sub)
drop m2
rename ihpb_sub sub2
tempfile reconstruction
postfile rc int source_year double max_abs_diff max_relative_diff using `reconstruction'
foreach y in 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
 generate double rebuilt`y'=wpi2010*ihpb`y'_1/100 if !cagr_flag
 replace rebuilt`y'=wpi2010*(ihpb`y'_1+ihpb`y')/200 if !cagr_flag & !missing(sub2,ihpb`y')
 replace rebuilt`y'=wpi2012*(wpi2012/wpi2010)^((`y'-2012)/2) if cagr_flag
 generate double delta=abs(rebuilt`y'-wpi`y')
 generate double rel=reldif(rebuilt`y',wpi`y')
 quietly summarize delta
 local ad=r(max)
 quietly summarize rel
 post rc (`y') (`ad') (r(max))
 assert rel<1e-6
 drop delta rel
}
postclose rc
preserve
use `reconstruction', clear
export delimited "results/wpi_reconstruction_checks.csv", replace
restore
keep isic4 wpi* cagr_flag
reshape long wpi, i(isic4) j(source_year)
rename wpi wpi_output_index
isid isic4 source_year
keep if inrange(source_year,2010,2022)
generate byte wpi_spliced=source_year>=2020
generate byte wpi_cagr=cagr_flag & source_year>2012 & source_year!=2016
drop cagr_flag
generate int wpi_base_year=2000
label variable wpi_output_index "Output WPI index; base 2000=100; source ISIC Rev3/3.1 four digit"
save "dag/data/references/WPI_output_lookup.dta", replace
preserve
collapse (count) observed=wpi_output_index (min) minimum=wpi_output_index (max) maximum=wpi_output_index, by(source_year wpi_spliced)
export delimited "results/wpi_reference_coverage.csv", replace
restore
* Explicit synthetic-sector bridge; no automatic prefix or arbitrary many-to-many choice.
import delimited "contracts/synthetic-industry-wpi-bridge.csv", stringcols(_all) clear
isid industry_code
destring isic4, replace
keep industry_code isic4 wpi_mapping_status
save "dag/data/references/WPI_fixture_bridge.dta", replace
display "G0_WPI_REFERENCE_RECONSTRUCTION_PASS 1179 extended index values"
log close wpi
