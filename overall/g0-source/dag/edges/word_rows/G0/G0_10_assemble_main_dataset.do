* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta; dag/data/word_data/G0/G0_derived_fields.dta; dan 3 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
* Ulangi blok untuk part: derived_fields, identifier_fields, classification_fields, deflator_fields. // WFDOC-INJECTED
foreach part in derived_fields identifier_fields classification_fields deflator_fields {
    merge 1:1 source_year source_row using "$G0D/G0_`part'.dta", assert(match) nogen
}
generate str80 money_unit_status="nominal_Rp000_existing_package_map; no_real_deflation"
generate str80 candidate_status="safe_sample_only; raw_preserved; conditional_energy; no_real_panel"
order source_year source_row workers gross_output_nominal value_added_nominal intermediate_inputs_nominal capital_nominal
sort source_year source_row
isid source_year source_row
assert _N==33049
assert missing(gross_output_real) & deflator_applied==0
assert !inlist(source_year,2016)
capture confirm variable firm_id
assert _rc==111
label variable gross_output_nominal "Gross output, nominal Rp000, existing SI mapping"
label variable value_added_nominal "Value added, nominal Rp000, existing SI mapping"
label variable intermediate_inputs_nominal "Reported IINPUT, nominal Rp000; proxy definition not certified"
label variable capital_nominal "UNCERTIFIED prior alias: mixes additions CTTTCU and stock V1115"
label variable capital_prior_mixed_nominal "Trace alias of capital_nominal: uncertified mixed stock/flow mapping"
label variable capital_per_worker_nominal "UNCERTIFIED mixed prior capital/worker; NOT validated stock intensity"
label variable ln_capital_nominal "ln UNCERTIFIED mixed prior capital alias; NOT verified stock log"
label variable out_capital_nominal "Tail diagnostic on UNCERTIFIED mixed prior capital alias"
label variable workers "Reported total workers, source record"
label variable co2_scope1_s1 "tCO2: observed legacy fuel components; partial coverage"
label variable co2_scope2_s1 "tCO2: purchased electricity; carried grid factor after 2014"
label variable co2_total_s1 "tCO2: observed Scope 1+2; NOT certified complete-fuel total"
label variable gj_fuel_s1 "GJ: observed legacy fuel components; partial coverage"
label variable gj_electricity "GJ: purchased electricity; excludes own generation"
label variable total_gj_s1 "GJ: observed fuel plus purchased electricity; partial coverage"
label variable energy_expenditure_rp000 "Nominal Rp000: reported fuel total + purchased electricity once"
label variable total_gj_complete "GJ only when all 9 fuels and 2 electricity quantities observed"
label variable co2_total_complete "tCO2 only when all 9 fuels and 2 electricity quantities observed"
label variable fuel_reconciliation_gap_extended "Reported fuel total less all mapped fuel costs (incl. added fuels)"
label variable energy_outlier_flag "Expanded annual price/quantity diagnostic; rows retained"
label variable energy_outlier_flag_legacy "Exact current E008 annual diagnostic; comparison only"
compress
save "$G0D/G0_main_candidate.dta", replace
display as result "G0_CANDIDATE_PUBLISHED rows=" _N " fields=" c(k)
