* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:step-version" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 1 34 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:step-version" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 1 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L2:step-clear" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 2 34 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L2:step-clear" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 2 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L3:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 3 34 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L3:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 3 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L4:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 4 34 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L4:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 4 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L5:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 5 34 `=_rc' // WFLOG-INJECTED
set maxvar 10000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L5:step-set" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 5 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L6:step-args" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 6 34 `=_rc' // WFLOG-INJECTED
args runroot
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L6:step-args" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 6 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L7:step-cd" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 7 34 `=_rc' // WFLOG-INJECTED
cd "`runroot'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L7:step-cd" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 7 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L8:step-log" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 8 34 `=_rc' // WFLOG-INJECTED
capture log close _all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L8:step-log" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 8 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L9:step-log" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 9 34 `=_rc' // WFLOG-INJECTED
log using "report/evidence/G0_report_analysis.log", text replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L9:step-log" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 9 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L10:step-use" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 10 34 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L10:step-use" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 10 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L11:step-isid" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 11 34 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L11:step-isid" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 11 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L12:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 12 34 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L12:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 12 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L13:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 13 34 `=_rc' // WFLOG-INJECTED
assert identity_mode=="off" & identity_is_dummy==0 & identity_real_link_verified==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L13:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 13 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L14:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 14 34 `=_rc' // WFLOG-INJECTED
assert missing(selected_firm_id) & missing(dummy_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L14:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 14 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L15:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 15 34 `=_rc' // WFLOG-INJECTED
assert source_year!=2016
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L15:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 15 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L16:step-do" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 16 34 `=_rc' // WFLOG-INJECTED
do "dag/edges/word_rows/G0/G0_refresh_preparation_actual.do"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L16:step-do" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 16 34 `=_rc' // WFLOG-INJECTED
* Correct the dated missing-source message: WPI package now exists but no real classification bridge is certified.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L18:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 17 34 `=_rc' // WFLOG-INJECTED
replace deflator_status="WPI_reference_available; real_KBLI_ISIC_bridge_not_verified; not_applied"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L18:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 17 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L19:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 18 34 `=_rc' // WFLOG-INJECTED
replace candidate_status="actual_masked_sample; original_G0_reexecuted; real_panel_unverified"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L19:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 18 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L20:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 19 34 `=_rc' // WFLOG-INJECTED
label variable co2_total_complete "Complete for nine-modelled-fuel subset + purchased electricity ONLY"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L20:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 19 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L21:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 20 34 `=_rc' // WFLOG-INJECTED
label variable total_gj_complete "Complete for nine-modelled-fuel subset + purchased electricity ONLY"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L21:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 20 34 `=_rc' // WFLOG-INJECTED
* Explicit sidecar flags distinguish actual observations from simulated development fixtures.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L23:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 21 34 `=_rc' // WFLOG-INJECTED
generate byte company_data_is_synthetic=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L23:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 21 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L24:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 22 34 `=_rc' // WFLOG-INJECTED
generate byte wpi_reference_available=1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L24:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 22 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L25:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 23 34 `=_rc' // WFLOG-INJECTED
generate byte wpi_company_bridge_verified=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L25:step-generate" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 23 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L26:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 24 34 `=_rc' // WFLOG-INJECTED
label variable company_data_is_synthetic "0 actual supplied masked sample; NOT a population completeness claim"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L26:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 24 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L27:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 25 34 `=_rc' // WFLOG-INJECTED
label variable wpi_company_bridge_verified "0: no certified annual KBLI-to-WPI bridge applied to actual companies"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L27:step-label" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 25 34 `=_rc' // WFLOG-INJECTED
* Recompute potentially stale domain-safe derivatives after annual correction. Never modify nominal inputs.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:step-foreach" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "loop" 26 34 `=_rc' "in" `""gross_output_nominal ln_output_nominal" "value_added_nominal ln_va_nominal" "workers ln_workers" "capital_stock_nominal ln_capital_stock_nominal" "capital_additions_nominal ln_capital_additions_nominal" "rd_cost_nominal ln_rd_cost_nominal" "total_gj_s1 ln_total_gj_s1" "co2_total_s1 ln_co2_total_s1""' // WFLOG-INJECTED
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "gross_output_nominal ln_output_nominal" "value_added_nominal ln_va_nominal" "workers ln_workers" "capital_stock_nominal ln_capital_stock_nominal" "capital_additions_nominal ln_capital_additions_nominal" "rd_cost_nominal ln_rd_cost_nominal" "total_gj_s1 ln_total_gj_s1" "co2_total_s1 ln_co2_total_s1" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L30:step-gettoken" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
 gettoken value logvar : pair
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L30:step-gettoken" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L31:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
 replace `logvar'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L31:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L32:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
 replace `logvar'=ln(`value') if `value'>0 & !missing(`value')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L32:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L33:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
 assert missing(`logvar') if `value'<=0 | missing(`value')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L33:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:iteration-body" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L29:step-foreach" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "loop" 26 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:step-foreach" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "loop" 27 34 `=_rc' "in" `""value_added_nominal labor_productivity_nominal" "gross_output_nominal output_per_worker_nominal" "capital_stock_nominal capital_stock_per_worker" "capital_additions_nominal capital_additions_per_worker" "intermediate_inputs_nominal inputs_per_worker_nominal" "rd_cost_nominal rd_cost_per_worker_nominal" "total_gj_s1 total_gj_per_worker" "co2_total_s1 co2_per_worker""' // WFLOG-INJECTED
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "value_added_nominal labor_productivity_nominal" "gross_output_nominal output_per_worker_nominal" "capital_stock_nominal capital_stock_per_worker" "capital_additions_nominal capital_additions_per_worker" "intermediate_inputs_nominal inputs_per_worker_nominal" "rd_cost_nominal rd_cost_per_worker_nominal" "total_gj_s1 total_gj_per_worker" "co2_total_s1 co2_per_worker" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L36:step-gettoken" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
 gettoken value ratio : pair
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L36:step-gettoken" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L37:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
 replace `ratio'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L37:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L38:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
 replace `ratio'=`value'/workers if workers>0 & !missing(workers,`value')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L38:step-replace" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L39:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
 assert missing(`ratio') if workers<=0 | missing(workers)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L39:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:iteration-body" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L35:step-foreach" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "loop" 27 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L41:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 28 34 `=_rc' // WFLOG-INJECTED
assert reldif(gross_output_nominal-intermediate_inputs_nominal,value_added_nominal)<1e-8 if !missing(gross_output_nominal,intermediate_inputs_nominal,value_added_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L41:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 28 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L42:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 29 34 `=_rc' // WFLOG-INJECTED
assert reldif(co2_total_s1,co2_scope1_s1+co2_scope2_s1)<1e-8 if !missing(co2_total_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L42:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 29 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L43:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 30 34 `=_rc' // WFLOG-INJECTED
assert reldif(total_gj_s1,gj_fuel_s1+gj_electricity)<1e-8 if !missing(total_gj_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L43:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 30 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L44:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 31 34 `=_rc' // WFLOG-INJECTED
assert own_generation_added==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L44:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 31 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L45:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 32 34 `=_rc' // WFLOG-INJECTED
assert missing(gross_output_real) & missing(value_added_real) & deflator_applied==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L45:step-assert" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 32 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L46:step-sort" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 33 34 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L46:step-sort" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 33 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L47:step-save" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 34 34 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L47:step-save" "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "statement" 34 34 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_local_prepare_numeric.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
