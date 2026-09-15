* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta; dag/data/word_data/G0/G0_derived_fields.dta; dan 3 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:step-use" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 1 36 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:step-use" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 1 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:step-foreach" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "loop" 2 36 `=_rc' "in" `"derived_fields identifier_fields classification_fields deflator_fields"' // WFLOG-INJECTED
* Ulangi blok untuk part: derived_fields, identifier_fields, classification_fields, deflator_fields. // WFDOC-INJECTED
foreach part in derived_fields identifier_fields classification_fields deflator_fields {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:iteration-body" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L3:step-merge" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    merge 1:1 source_year source_row using "$G0D/G0_`part'.dta", assert(match) nogen
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L3:step-merge" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:iteration-body" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L2:step-foreach" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "loop" 2 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L5:step-generate" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 3 36 `=_rc' // WFLOG-INJECTED
generate str80 money_unit_status="nominal_Rp000_existing_package_map; no_real_deflation"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L5:step-generate" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 3 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L6:step-generate" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 4 36 `=_rc' // WFLOG-INJECTED
generate str80 candidate_status="safe_sample_only; raw_preserved; conditional_energy; no_real_panel"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L6:step-generate" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 4 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L7:step-order" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 5 36 `=_rc' // WFLOG-INJECTED
order source_year source_row workers gross_output_nominal value_added_nominal intermediate_inputs_nominal capital_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L7:step-order" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 5 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L8:step-sort" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 6 36 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L8:step-sort" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 6 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L9:step-isid" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 7 36 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L9:step-isid" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 7 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L10:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 8 36 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L10:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 8 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L11:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 9 36 `=_rc' // WFLOG-INJECTED
assert missing(gross_output_real) & deflator_applied==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L11:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 9 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L12:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 10 36 `=_rc' // WFLOG-INJECTED
assert !inlist(source_year,2016)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L12:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 10 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L13:step-confirm" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 11 36 `=_rc' // WFLOG-INJECTED
capture confirm variable firm_id
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L13:step-confirm" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 11 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L14:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 12 36 `=_rc' // WFLOG-INJECTED
assert _rc==111
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L14:step-assert" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 12 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L15:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 13 36 `=_rc' // WFLOG-INJECTED
label variable gross_output_nominal "Gross output, nominal Rp000, existing SI mapping"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L15:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 13 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L16:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 14 36 `=_rc' // WFLOG-INJECTED
label variable value_added_nominal "Value added, nominal Rp000, existing SI mapping"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L16:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 14 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L17:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 15 36 `=_rc' // WFLOG-INJECTED
label variable intermediate_inputs_nominal "Reported IINPUT, nominal Rp000; proxy definition not certified"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L17:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 15 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L18:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 16 36 `=_rc' // WFLOG-INJECTED
label variable capital_nominal "UNCERTIFIED prior alias: mixes additions CTTTCU and stock V1115"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L18:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 16 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L19:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 17 36 `=_rc' // WFLOG-INJECTED
label variable capital_prior_mixed_nominal "Trace alias of capital_nominal: uncertified mixed stock/flow mapping"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L19:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 17 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L20:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 18 36 `=_rc' // WFLOG-INJECTED
label variable capital_per_worker_nominal "UNCERTIFIED mixed prior capital/worker; NOT validated stock intensity"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L20:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 18 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L21:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 19 36 `=_rc' // WFLOG-INJECTED
label variable ln_capital_nominal "ln UNCERTIFIED mixed prior capital alias; NOT verified stock log"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L21:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 19 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L22:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 20 36 `=_rc' // WFLOG-INJECTED
label variable out_capital_nominal "Tail diagnostic on UNCERTIFIED mixed prior capital alias"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L22:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 20 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L23:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 21 36 `=_rc' // WFLOG-INJECTED
label variable workers "Reported total workers, source record"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L23:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 21 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L24:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 22 36 `=_rc' // WFLOG-INJECTED
label variable co2_scope1_s1 "tCO2: observed legacy fuel components; partial coverage"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L24:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 22 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L25:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 23 36 `=_rc' // WFLOG-INJECTED
label variable co2_scope2_s1 "tCO2: purchased electricity; carried grid factor after 2014"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L25:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 23 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L26:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 24 36 `=_rc' // WFLOG-INJECTED
label variable co2_total_s1 "tCO2: observed Scope 1+2; NOT certified complete-fuel total"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L26:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 24 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L27:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 25 36 `=_rc' // WFLOG-INJECTED
label variable gj_fuel_s1 "GJ: observed legacy fuel components; partial coverage"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L27:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 25 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L28:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 26 36 `=_rc' // WFLOG-INJECTED
label variable gj_electricity "GJ: purchased electricity; excludes own generation"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L28:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 26 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L29:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 27 36 `=_rc' // WFLOG-INJECTED
label variable total_gj_s1 "GJ: observed fuel plus purchased electricity; partial coverage"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L29:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 27 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L30:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 28 36 `=_rc' // WFLOG-INJECTED
label variable energy_expenditure_rp000 "Nominal Rp000: reported fuel total + purchased electricity once"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L30:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 28 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L31:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 29 36 `=_rc' // WFLOG-INJECTED
label variable total_gj_complete "GJ only when all 9 fuels and 2 electricity quantities observed"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L31:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 29 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L32:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 30 36 `=_rc' // WFLOG-INJECTED
label variable co2_total_complete "tCO2 only when all 9 fuels and 2 electricity quantities observed"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L32:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 30 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L33:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 31 36 `=_rc' // WFLOG-INJECTED
label variable fuel_reconciliation_gap_extended "Reported fuel total less all mapped fuel costs (incl. added fuels)"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L33:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 31 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L34:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 32 36 `=_rc' // WFLOG-INJECTED
label variable energy_outlier_flag "Expanded annual price/quantity diagnostic; rows retained"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L34:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 32 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L35:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 33 36 `=_rc' // WFLOG-INJECTED
label variable energy_outlier_flag_legacy "Exact current E008 annual diagnostic; comparison only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L35:step-label" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 33 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L36:step-compress" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 34 36 `=_rc' // WFLOG-INJECTED
compress
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L36:step-compress" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 34 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L37:step-save" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 35 36 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_main_candidate.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L37:step-save" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 35 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L38:step-display" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 36 36 `=_rc' // WFLOG-INJECTED
display as result "G0_CANDIDATE_PUBLISHED rows=" _N " fields=" c(k)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L38:step-display" "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "statement" 36 36 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
