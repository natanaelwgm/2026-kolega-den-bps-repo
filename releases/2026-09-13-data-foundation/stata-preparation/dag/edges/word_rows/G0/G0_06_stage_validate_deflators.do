* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_economic_fields.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_deflator_fields.dta; dag/reports/word_data/G0/deflator_coverage.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Independently blocked price branch. Legacy files located; new uploaded input not verified.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L2:step-use" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_economic_fields.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L2:step-use" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L3:step-keep" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
keep source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L3:step-keep" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:step-foreach" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "loop" 3 12 `=_rc' "in" `"deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:iteration-body" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L5:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    generate double `v'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L5:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:iteration-body" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L4:step-foreach" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "loop" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L7:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
generate byte deflator_applied=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L7:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L8:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
generate str80 deflator_status="pending_uploaded_WPI_and_revision_bridge; no_real_values"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L8:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L9:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
generate byte legacy_output_wpi_year_exists=source_year<=2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L9:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L10:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
generate byte legacy_input_wpi_year_exists=source_year<=2016
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L10:step-generate" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L11:step-save" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_deflator_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L11:step-save" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L12:step-preserve" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L12:step-preserve" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L13:step-collapse" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
collapse (count) observations=source_row (sum) real_rows=deflator_applied, by(source_year deflator_status legacy_output_wpi_year_exists legacy_input_wpi_year_exists)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L13:step-collapse" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L14:step-export" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
export delimited using "$G0R/deflator_coverage.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L14:step-export" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L15:step-restore" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L15:step-restore" "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
