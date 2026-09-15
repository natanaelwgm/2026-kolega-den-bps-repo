* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
set varabbrev off
set maxvar 10000
args runroot
cd "`runroot'"
capture log close
log using "report/evidence/G0_report_analysis.log", text replace
use "dag/data/word_data/G0/G0_analysis_ready.dta", clear
isid source_year source_row
assert _N==33049
assert identity_mode=="off" & identity_is_dummy==0 & identity_real_link_verified==0
assert missing(selected_firm_id) & missing(dummy_firm_id)
assert source_year!=2016
do "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do"
* Correct the dated missing-source message: WPI package now exists but no real classification bridge is certified.
replace deflator_status="WPI_reference_available; real_KBLI_ISIC_bridge_not_verified; not_applied"
replace candidate_status="actual_masked_sample; original_G0_reexecuted; real_panel_unverified"
label variable co2_total_complete "Complete for nine-modelled-fuel subset + purchased electricity ONLY"
label variable total_gj_complete "Complete for nine-modelled-fuel subset + purchased electricity ONLY"
* Explicit sidecar flags distinguish actual observations from simulated development fixtures.
generate byte company_data_is_synthetic=0
generate byte wpi_reference_available=1
generate byte wpi_company_bridge_verified=0
label variable company_data_is_synthetic "0 actual supplied masked sample; NOT a population completeness claim"
label variable wpi_company_bridge_verified "0: no certified annual KBLI-to-WPI bridge applied to actual companies"
* Recompute potentially stale domain-safe derivatives after annual correction. Never modify nominal inputs.
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "gross_output_nominal ln_output_nominal" "value_added_nominal ln_va_nominal" "workers ln_workers" "capital_stock_nominal ln_capital_stock_nominal" "capital_additions_nominal ln_capital_additions_nominal" "rd_cost_nominal ln_rd_cost_nominal" "total_gj_s1 ln_total_gj_s1" "co2_total_s1 ln_co2_total_s1" {
 gettoken value logvar : pair
 replace `logvar'=.
 replace `logvar'=ln(`value') if `value'>0 & !missing(`value')
 assert missing(`logvar') if `value'<=0 | missing(`value')
}
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "value_added_nominal labor_productivity_nominal" "gross_output_nominal output_per_worker_nominal" "capital_stock_nominal capital_stock_per_worker" "capital_additions_nominal capital_additions_per_worker" "intermediate_inputs_nominal inputs_per_worker_nominal" "rd_cost_nominal rd_cost_per_worker_nominal" "total_gj_s1 total_gj_per_worker" "co2_total_s1 co2_per_worker" {
 gettoken value ratio : pair
 replace `ratio'=.
 replace `ratio'=`value'/workers if workers>0 & !missing(workers,`value')
 assert missing(`ratio') if workers<=0 | missing(workers)
}
assert reldif(gross_output_nominal-intermediate_inputs_nominal,value_added_nominal)<1e-8 if !missing(gross_output_nominal,intermediate_inputs_nominal,value_added_nominal)
assert reldif(co2_total_s1,co2_scope1_s1+co2_scope2_s1)<1e-8 if !missing(co2_total_s1)
assert reldif(total_gj_s1,gj_fuel_s1+gj_electricity)<1e-8 if !missing(total_gj_s1)
assert own_generation_added==0
assert missing(gross_output_real) & missing(value_added_real) & deflator_applied==0
sort source_year source_row
save "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", replace
