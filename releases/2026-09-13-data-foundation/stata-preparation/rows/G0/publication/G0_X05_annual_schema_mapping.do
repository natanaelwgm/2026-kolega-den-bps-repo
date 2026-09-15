* Tujuan: Impor peta nama sumber-ke-kanonik per tahun dan pastikan satu nama kanonik hanya muncul sekali per wave. // WFDOC-INJECTED
* Input: corrections/metadata/annual_schema_mapping.csv // WFDOC-INJECTED
* Output: corrections/reports/annual_schema_mapping.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:step-version" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:step-version" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L2:step-do" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L2:step-do" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L3:step-g0c_begin" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X05"
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L3:step-g0c_begin" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L4:step-import" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/annual_schema_mapping.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L4:step-import" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L5:step-rename" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
rename source_year __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L5:step-rename" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L6:step-generate" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
generate double source_year=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L6:step-generate" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L7:step-assert" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
assert !missing(source_year) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L7:step-assert" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L8:step-drop" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L8:step-drop" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L9:step-isid" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
isid source_year canonical_name
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L9:step-isid" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L10:step-generate" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
generate strL evidence_ref=child_path
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L10:step-generate" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L11:step-save" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
save "corrections/reports/annual_schema_mapping.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L11:step-save" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L12:step-display" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X05"
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L12:step-display" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X05_annual_schema_mapping.do:L13:step-log" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L13:step-log" "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X05_annual_schema_mapping.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
