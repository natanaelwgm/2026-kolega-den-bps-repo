* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_economic_fields.dta; dag/data/word_data/G0/G0_energy_emissions.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_derived_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:step-use" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 1 46 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_economic_fields.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:step-use" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 1 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L2:step-merge" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 2 46 `=_rc' // WFLOG-INJECTED
merge 1:1 source_year source_row using "$G0D/G0_energy_emissions.dta", assert(match) nogen
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L2:step-merge" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 2 46 `=_rc' // WFLOG-INJECTED
* Domain-safe status definitions; no invalid code interpreted as observed no.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L4:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 3 46 `=_rc' // WFLOG-INJECTED
generate byte export_share_valid=inrange(export_share_pct,0,100)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L4:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 3 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L5:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 4 46 `=_rc' // WFLOG-INJECTED
generate byte export_binary_valid=inlist(export_binary_raw,0,1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L5:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 4 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L6:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 5 46 `=_rc' // WFLOG-INJECTED
generate byte export_flag_conditional=export_share_pct>0 if export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L6:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 5 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L7:step-replace" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 6 46 `=_rc' // WFLOG-INJECTED
replace export_flag_conditional=export_binary_raw==1 if missing(export_flag_conditional) & export_binary_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L7:step-replace" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 6 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L8:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 7 46 `=_rc' // WFLOG-INJECTED
generate byte export_definition_conflict=export_flag_conditional!=(export_binary_raw==1) if export_share_valid & export_binary_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L8:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 7 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L9:step-replace" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 8 46 `=_rc' // WFLOG-INJECTED
replace export_flag_conditional=. if export_definition_conflict==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L9:step-replace" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 8 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L10:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 9 46 `=_rc' // WFLOG-INJECTED
generate byte export_binary_assumed_flag=export_binary_raw==1 if export_binary_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L10:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 9 46 `=_rc' // WFLOG-INJECTED
* Main definition uses verified numeric percentage domain only. Binary codes are unverified sensitivity.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L12:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 10 46 `=_rc' // WFLOG-INJECTED
generate byte export_flag=export_share_pct>0 if export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L12:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 10 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L13:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 11 46 `=_rc' // WFLOG-INJECTED
generate byte export_observed=!missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L13:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 11 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L14:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 12 46 `=_rc' // WFLOG-INJECTED
generate str80 export_definition_status=cond(export_share_valid,"valid_numeric_share_only","main_unavailable; binary_interpretation_unverified")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L14:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 12 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L15:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 13 46 `=_rc' // WFLOG-INJECTED
label variable export_flag_conditional "Sensitivity: assumed binary 0/2=no 1=yes, combined with share"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L15:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 13 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L16:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 14 46 `=_rc' // WFLOG-INJECTED
label variable export_binary_assumed_flag "Sensitivity only: unverified binary 0/1/2 interpretation"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L16:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 14 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L17:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 15 46 `=_rc' // WFLOG-INJECTED
label variable export_definition_conflict "Diagnostic disagreement under assumed binary code; not certified error"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L17:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 15 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L18:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 16 46 `=_rc' // WFLOG-INJECTED
label variable export_binary_valid "In assumed 0/1/2 domain; source code meanings not validated"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L18:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 16 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L19:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 17 46 `=_rc' // WFLOG-INJECTED
generate byte import_flag=import_value_nominal>0 if import_value_nominal>=0 & !missing(import_value_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L19:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 17 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L20:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 18 46 `=_rc' // WFLOG-INJECTED
generate byte import_observed=!missing(import_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L20:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 18 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L21:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 19 46 `=_rc' // WFLOG-INJECTED
generate byte fdi_any_flag=foreign_ownership_pct>0 if inrange(foreign_ownership_pct,0,100)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L21:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 19 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L22:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 20 46 `=_rc' // WFLOG-INJECTED
generate byte fdi_10_flag=foreign_ownership_pct>=10 if inrange(foreign_ownership_pct,0,100)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L22:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 20 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L23:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 21 46 `=_rc' // WFLOG-INJECTED
generate byte fdi_observed=!missing(fdi_10_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L23:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 21 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L24:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 22 46 `=_rc' // WFLOG-INJECTED
generate byte large_gt100_flag=workers>100 if workers>=0 & !missing(workers)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L24:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 22 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L25:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 23 46 `=_rc' // WFLOG-INJECTED
generate double accounting_gap=gross_output_nominal-value_added_nominal-intermediate_inputs_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L25:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 23 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L26:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 24 46 `=_rc' // WFLOG-INJECTED
generate byte accounting_identity_valid=abs(accounting_gap)<.000001 if !missing(accounting_gap)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L26:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 24 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L27:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 25 46 `=_rc' // WFLOG-INJECTED
generate str80 inputs_definition_status="IINPUT reported total inputs; not a validated TFP materials proxy"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L27:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 25 46 `=_rc' // WFLOG-INJECTED
* Owner/manager capital correction grounded in original questionnaires 2010-2012.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L29:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 26 46 `=_rc' // WFLOG-INJECTED
generate double capital_prior_mixed_nominal=capital_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L29:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 26 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L30:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 27 46 `=_rc' // WFLOG-INJECTED
generate byte capital_stock_verified=inrange(source_year,2010,2012) & st_capital_stock_nominal!=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L30:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 27 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L31:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 28 46 `=_rc' // WFLOG-INJECTED
generate byte capital_additions_verified=inrange(source_year,2010,2012) & st_capital_additions_nominal!=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L31:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 28 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L32:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 29 46 `=_rc' // WFLOG-INJECTED
generate str80 capital_definition_status=cond(source_year<=2012,"stock_V1115_and_additions_CTTTCU_verified_questionnaire","later_same_code_candidates_unverified_questionnaire")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L32:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 29 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L33:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 30 46 `=_rc' // WFLOG-INJECTED
generate str80 capital_prior_status="uncertified_mixed_prior_map; not_capital_stock_intensity"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L33:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 30 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L34:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 31 46 `=_rc' // WFLOG-INJECTED
generate byte worker_denominator_state=cond(missing(workers),3,cond(workers==0,1,cond(workers<0,2,0)))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L34:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 31 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L35:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 32 46 `=_rc' // WFLOG-INJECTED
local numerators "value_added_nominal gross_output_nominal capital_nominal intermediate_inputs_nominal rd_cost_nominal energy_expenditure_rp000 total_gj_s1 co2_total_s1"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L35:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 32 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L36:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 33 46 `=_rc' // WFLOG-INJECTED
local outputs "labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal inputs_per_worker_nominal rd_cost_per_worker_nominal energy_cost_per_worker total_gj_per_worker co2_per_worker"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L36:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 33 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:step-forvalues" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 34 46 `=_rc' "forvalues" `"1/8"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 8. // WFDOC-INJECTED
forvalues i=1/8 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L38:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
    local v: word `i' of `numerators'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L38:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L39:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
    local t: word `i' of `outputs'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L39:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L40:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
    generate double `t'=`v'/workers if worker_denominator_state==0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L40:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L37:step-forvalues" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 34 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 35 46 `=_rc' "in" `"stock additions"' // WFLOG-INJECTED
* Ulangi blok untuk v: stock, additions. // WFDOC-INJECTED
foreach v in stock additions {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L43:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
    generate double capital_`v'_per_worker=capital_`v'_nominal/workers if worker_denominator_state==0 & !missing(capital_`v'_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L43:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 1 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L44:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
    generate double ln_capital_`v'_nominal=ln(capital_`v'_nominal) if capital_`v'_nominal>0 & !missing(capital_`v'_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L44:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L45:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
    label variable capital_`v'_nominal "Capital `v' candidate; definition verified 2010-2012 only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L45:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L46:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
    label variable capital_`v'_per_worker "Capital `v' candidate / worker; definition verified 2010-2012 only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L46:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L47:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
    label variable ln_capital_`v'_nominal "ln capital `v' candidate; positive values; verified 2010-2012 only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L47:step-label" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L42:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 35 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L49:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 36 46 `=_rc' // WFLOG-INJECTED
generate double value_added_share_of_output=value_added_nominal/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,value_added_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L49:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 36 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L50:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 37 46 `=_rc' // WFLOG-INJECTED
generate double energy_intensity_monetary=energy_expenditure_rp000/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,energy_expenditure_rp000)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L50:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 37 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L51:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 38 46 `=_rc' // WFLOG-INJECTED
generate double energy_intensity_gj_nominal=total_gj_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,total_gj_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L51:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 38 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L52:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 39 46 `=_rc' // WFLOG-INJECTED
generate double co2_intensity_nominal=co2_total_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,co2_total_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L52:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 39 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L53:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 40 46 `=_rc' // WFLOG-INJECTED
local vals "gross_output_nominal value_added_nominal capital_nominal intermediate_inputs_nominal workers total_gj_s1 co2_total_s1 energy_expenditure_rp000 import_value_nominal rd_cost_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L53:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 40 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L54:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 41 46 `=_rc' // WFLOG-INJECTED
local logs "ln_output_nominal ln_va_nominal ln_capital_nominal ln_inputs_nominal ln_workers ln_total_gj_s1 ln_co2_total_s1 ln_energy_expenditure ln_import_nominal ln_rd_cost_nominal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L54:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 41 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:step-forvalues" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 42 46 `=_rc' "forvalues" `"1/10"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 10. // WFDOC-INJECTED
forvalues i=1/10 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L56:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
    local v: word `i' of `vals'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L56:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L57:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
    local l: word `i' of `logs'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L57:step-local" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L58:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
    generate double `l'=ln(`v') if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L58:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L59:step-assert" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
    assert missing(`l') if `v'<=0 | missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L59:step-assert" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L55:step-forvalues" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 42 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 43 46 `=_rc' "varlist" `"val_*"' // WFLOG-INJECTED
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist val_* {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L62:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    generate double ln_`v'=ln(`v') if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L62:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L63:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    generate double pw_`v'=`v'/workers if worker_denominator_state==0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L63:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L61:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 43 46 `=_rc' // WFLOG-INJECTED
* Diagnose economic tails within year; do not delete or winsorize.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 44 46 `=_rc' "in" `"gross_output_nominal value_added_nominal capital_nominal workers"' // WFLOG-INJECTED
* Ulangi blok untuk v: gross_output_nominal, value_added_nominal, capital_nominal, workers. // WFDOC-INJECTED
foreach v in gross_output_nominal value_added_nominal capital_nominal workers {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L67:step-bysort" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
    bysort source_year: egen double __p99=pctile(`v'), p(99)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L67:step-bysort" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L68:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
    generate byte out_`v'=`v'>10*__p99 & !missing(`v',__p99) & __p99>0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L68:step-generate" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L69:step-drop" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
    drop __p99
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L69:step-drop" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:iteration-body" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L66:step-foreach" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "loop" 44 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L71:step-isid" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 45 46 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L71:step-isid" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 45 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L72:step-save" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 46 46 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_derived_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L72:step-save" "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "statement" 46 46 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
