* SYNTHETIC final audit after all corrections, identity and schema enforcement.
log using "dag/logs/G0_final_validation.log", text replace
use "results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta", clear
assert _N==1200 & c(k)==3837
isid source_year source_row
isid selected_firm_id source_year
assert selected_firm_id==800000+source_row
assert source_id_raw==string(selected_firm_id,"%06.0f")
assert identity_is_dummy==1 & identity_real_link_verified==0
assert deflator_applied==1 & wpi_output_index>0 & !missing(wpi_output_index)
assert real_va_is_single_proxy==1 & real_va_double_deflated==0
foreach absent in deflator_inputs deflator_capital deflator_wages capital_real intermediate_inputs_real {
 assert missing(`absent')
}
assert reldif(gross_output_real,gross_output_nominal/(wpi_output_index/100))<1e-12
assert reldif(value_added_real,value_added_nominal/(wpi_output_index/100))<1e-12
assert wpi_spliced==(source_year>=2020)
assert energy_all_sources_complete==0
assert missing(co2_scope2_no_grid_carry) if source_year>2014
assert missing(gj_scope1_complete9) if inlist(source_year,2018,2019)
foreach v in stock additions {
 assert reldif(capital_`v'_per_worker,capital_`v'_nominal/workers)<1e-12 if workers>0 & !missing(workers,capital_`v'_nominal)
 assert missing(capital_`v'_per_worker) if workers<=0 | missing(workers)
}
foreach v of varlist val_* {
 assert missing(ln_`v') if `v'<=0 | missing(`v')
 assert reldif(ln_`v',ln(`v'))<1e-12 if `v'>0 & !missing(`v')
}
assert source_year!=2016
bysort selected_firm_id: assert _N==12
foreach yy in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    preserve
    keep if source_year==`yy'
    assert _N==100
    keep source_year source_row raw_*
    sort source_year source_row
    * Cross-year union contains absent raw columns: compare the staged source's columns.
    tempfile actual
    save `actual'
    use "dag/data/staged/sample_mfg`yy'_raw.dta", clear
    sort source_year source_row
    cf _all using `actual', all
    restore
}
assert abs(gross_output_nominal-value_added_nominal-intermediate_inputs_nominal)<1e-6
assert abs(labor_productivity_nominal-value_added_nominal/workers)<1e-8 if workers>0 & !missing(workers,value_added_nominal)
assert abs(output_per_worker_nominal-gross_output_nominal/workers)<1e-8 if workers>0 & !missing(workers,gross_output_nominal)
assert abs(ln_output_nominal-ln(gross_output_nominal))<1e-8 if gross_output_nominal>0 & !missing(gross_output_nominal)
assert abs(total_gj_s1-gj_fuel_s1-gj_electricity)<1e-6 if !missing(total_gj_s1)
assert abs(co2_total_s1-co2_scope1_s1-co2_scope2_s1)<1e-6 if !missing(co2_total_s1)
assert abs(energy_expenditure_rp000-fuel_total_reported_rp000-elec_pln_rp000-elec_nonpln_rp000)<1e-6 if !missing(fuel_total_reported_rp000,elec_pln_rp000,elec_nonpln_rp000)
assert missing(ln_rd_cost_nominal) if rd_cost_nominal<=0 | missing(rd_cost_nominal)
assert missing(rd_cost_per_worker_nominal) if workers<=0 | missing(workers)
assert missing(export_flag) if source_year==2022 & export_direct_flag==0 & !export_share_valid
preserve
collapse (count) rows=source_row (sum) total_workers=workers output_nominal=gross_output_nominal total_gj=total_gj_s1 co2=co2_total_s1, by(source_year)
export delimited using "results/year_summary.csv", replace
restore
tempfile coverage
postfile cv int source_year str32 variable long rows observed zeros negatives using `coverage'
quietly ds
local vars `r(varlist)'
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    foreach v of local vars {
        quietly count if source_year==`y' & !missing(`v')
        local obs=r(N)
        local zero=.
        local neg=.
        capture confirm numeric variable `v'
        if !_rc {
            quietly count if source_year==`y' & `v'==0
            local zero=r(N)
            quietly count if source_year==`y' & `v'<0
            local neg=r(N)
        }
        post cv (`y') ("`v'") (100) (`obs') (`zero') (`neg')
    }
}
postclose cv
use `coverage', clear
generate long missing_rows=rows-observed
isid source_year variable
assert _N==3837*12
export delimited using "results/coverage_by_variable_year.csv", replace
display "G0_SYNTHETIC_FINAL_VALIDATION_PASS"
log close
