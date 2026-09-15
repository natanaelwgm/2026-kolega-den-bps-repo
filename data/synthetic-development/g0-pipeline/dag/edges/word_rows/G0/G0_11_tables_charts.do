* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Source-record-year -> within-wave safe-sample summaries. Unweighted observed denominators.
use "$G0D/G0_main_candidate.dta", clear
local measures "export_flag export_flag_conditional export_binary_assumed_flag workers production_workers gross_output_nominal value_added_nominal intermediate_inputs_nominal capital_nominal capital_stock_nominal capital_additions_nominal ln_capital_stock_nominal ln_capital_additions_nominal capital_stock_per_worker capital_additions_per_worker import_value_nominal export_share_pct foreign_ownership_pct rd_cost_nominal labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal energy_expenditure_rp000 energy_intensity_monetary gj_fuel_s1 gj_electricity total_gj_s1 co2_scope1_s1 co2_scope2_s1 co2_total_s1"
tempname h
postfile `h' int source_year str40 variable long total_rows observed zero negative double mean p25 median p75 p99 using "$G0D/G0_variable_coverage.dta", replace
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local n=r(N)
    foreach v of local measures {
        quietly count if source_year==`y' & `v'==0
        local z=r(N)
        quietly count if source_year==`y' & `v'<0
        local neg=r(N)
        quietly summarize `v' if source_year==`y', detail
        post `h' (`y') ("`v'") (`n') (r(N)) (`z') (`neg') (r(mean)) (r(p25)) (r(p50)) (r(p75)) (r(p99))
    }
}
postclose `h'
preserve
use "$G0D/G0_variable_coverage.dta", clear
generate str80 definition_status="see_field_map_and_source_states"
replace definition_status="UNCERTIFIED mixed prior stock/flow alias; not stock intensity" if inlist(variable,"capital_nominal","capital_per_worker_nominal","ln_capital_nominal")
replace definition_status=cond(source_year<=2012,"capital stock/additions: questionnaire definition verified","capital stock/additions: same-code candidate only; unverified") if strpos(variable,"capital_stock") | strpos(variable,"capital_additions")
generate long missing_rows=total_rows-observed
generate double observed_pct=100*observed/total_rows
export delimited using "$G0R/variable_coverage.csv", replace
restore
* Every numeric mapping receives a six-state table, including structurally absent cells.
tempname s
postfile `s' int source_year str32 variable byte source_state long observations using "$G0D/G0_source_states.dta", replace
ds st_*
local states `r(varlist)'
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    foreach v of local states {
        forvalues k=0/10 {
            quietly count if source_year==`y' & `v'==`k'
            post `s' (`y') ("`v'") (`k') (r(N))
        }
    }
}
postclose `s'
preserve
use "$G0D/G0_source_states.dta", clear
export delimited using "$G0R/source_state_counts.csv", replace
restore
* Core annual rows plus supported denominators; no sample sum labelled national.
preserve
generate byte one=1
generate byte output_n=!missing(gross_output_nominal)
generate byte export_main_n=!missing(export_flag)
generate byte export_conditional_n=!missing(export_flag_conditional)
generate byte energy_n=!missing(total_gj_s1)
generate byte co2_n=!missing(co2_total_s1)
generate byte complete_energy_n=!missing(total_gj_complete)
generate byte rd_n=!missing(rd_cost_nominal)
generate byte no_worker_ratio=worker_denominator_state!=0
collapse (sum) observations=one output_n export_main_n export_conditional_n energy_n co2_n complete_energy_n rd_n energy_outliers=energy_outlier_flag legacy_energy_outliers=energy_outlier_flag_legacy no_worker_ratio (p50) workers_median=workers nominal_output_median=gross_output_nominal nominal_va_median=value_added_nominal energy_share_median=energy_intensity_monetary (p25) workers_p25=workers (p75) workers_p75=workers, by(source_year)
assert observations>0
generate double energy_observed_pct=100*energy_n/observations
generate double complete_energy_pct=100*complete_energy_n/observations
save "$G0D/G0_year_summary.dta", replace
export delimited using "$G0R/year_summary.csv", replace
set scheme s2color
twoway (rcap workers_p25 workers_p75 source_year, lcolor(navy)) (scatter workers_median source_year, mcolor(navy)), title("Pekerja dalam sampel aman SI") subtitle("Median dan persentil 25-75; tidak dibobot") xtitle("Tahun sumber") ytitle("Jumlah pekerja per catatan") xlabel(2010(1)2022, angle(45)) legend(order(1 "P25-P75" 2 "Median") rows(1)) note("2016 tidak tersedia. Ini distribusi sampel; bukan estimasi nasional.", size(vsmall)) graphregion(color(white)) name(G0_workers, replace)
graph export "$G0R/G0_workers_distribution.png", replace width(1800)
graph save "$G0D/G0_workers_distribution.gph", replace
twoway (connected energy_observed_pct source_year, lcolor(navy) mcolor(navy)) (connected complete_energy_pct source_year, lcolor(maroon) mcolor(maroon)), title("Cakupan konstruksi energi") subtitle("Persentase catatan sampel per tahun") xtitle("Tahun sumber") ytitle("Persen catatan") xlabel(2010(1)2022, angle(45)) ylabel(0(20)100) legend(order(1 "Komponen teramati tersedia" 2 "9 bahan bakar + 2 listrik lengkap") rows(2)) note("Variabel bahan bakar yang tidak ada tidak dianggap nol. Pemetaan unit pasca-2014 bersyarat.", size(vsmall)) graphregion(color(white)) name(G0_coverage, replace)
graph export "$G0R/G0_energy_coverage.png", replace width(1800)
graph save "$G0D/G0_energy_coverage.gph", replace
restore
preserve
keep if source_year==2022 & energy_intensity_monetary>0 & !missing(energy_intensity_monetary)
generate double ln_energy_share=ln(energy_intensity_monetary)
quietly count
local chartn=r(N)
histogram ln_energy_share, percent width(.5) color(navy*.7) title("Biaya energi / output: sampel 2022") subtitle("Log rasio nominal positif; n=`chartn'") xtitle("ln[(bahan bakar + listrik dibeli) / output]") ytitle("Persen catatan") note("Total bahan bakar dilaporkan + listrik sekali. Pencilan tetap disertakan; tidak dideflasi.", size(vsmall)) graphregion(color(white)) name(G0_energy_share, replace)
graph export "$G0R/G0_energy_intensity_2022.png", replace width(1800)
graph save "$G0D/G0_energy_intensity_2022.gph", replace
restore
* Reconciliation statuses expose both preserved legacy component list and added source fuels.
preserve
generate byte gap_nonzero=abs(fuel_reconciliation_gap)>.000001 if !missing(fuel_reconciliation_gap)
generate byte gap_extended_nonzero=abs(fuel_reconciliation_gap_extended)>.000001 if !missing(fuel_reconciliation_gap_extended)
generate byte reported_basis=fuel_expenditure_basis=="reported_total"
generate byte scope2_complete=electricity_n_observed==2
collapse (count) observations=source_row accounting_n=accounting_gap fuel_gap_n=fuel_reconciliation_gap (sum) accounting_pass=accounting_identity_valid fuel_gap_nonzero=gap_nonzero fuel_gap_ext_nonzero=gap_extended_nonzero reported_basis scope2_complete nine_fuels_complete extra_fuel_positive own_generation_reported (p50) fuel_gap_median=fuel_reconciliation_gap fuel_gap_extended_median=fuel_reconciliation_gap_extended, by(source_year)
export delimited using "$G0R/energy_accounting_reconciliation.csv", replace
restore
* Named raw indicators are left as codes; frequencies aid dictionary review.
tempname f
postfile `f' int source_year str32 variable double code long observations using "$G0D/G0_code_frequencies.dta", replace
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
 foreach v in export_binary_raw rd_indicator_raw innovation_raw innovation_product_raw innovation_process_raw innovation_marketing_raw innovation_org_raw amdal_raw pplihi_raw spplhi_raw inspli_raw sowste_raw liwste_raw b3wste_raw {
  quietly levelsof `v' if source_year==`y', local(codes) missing
  foreach c of local codes {
   quietly count if source_year==`y' & `v'==`c'
   post `f' (`y') ("`v'") (`c') (r(N))
  }
 }
}
postclose `f'
preserve
use "$G0D/G0_code_frequencies.dta", clear
export delimited using "$G0R/code_frequencies.csv", replace
restore
preserve
clear
set obs 13
generate int source_year=2009+_n
generate str64 source_status=cond(source_year==2016,"source_wave_not_supplied","safe_sample_present")
generate str80 panel_status="crosswave_ID_not_connected; full_panel_feasibility_not_rejected"
generate str80 price_status="uploaded_WPI_not_located; price/industry_mapping_unverified"
generate str80 energy_status=cond(source_year<=2014,"legacy_units; partial_fuel_coverage","post2014_units_conditional; additional_fuels_unconverted")
replace energy_status="source_wave_not_supplied" if source_year==2016
export delimited using "$G0R/missing_input_status.csv", replace
restore
display as result "G0_TABLES_CHARTS_SUCCESS"
