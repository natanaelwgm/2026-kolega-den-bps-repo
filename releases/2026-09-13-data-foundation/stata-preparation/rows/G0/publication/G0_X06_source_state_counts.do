* Tujuan: Susun jumlah observasi menurut tahun, variabel, dan kode status sumber; labelnya menyatakan bahwa masking tidak disimpulkan. // WFDOC-INJECTED
* Input: dag/reports/word_data/G0/source_state_counts.csv // WFDOC-INJECTED
* Output: corrections/reports/source_state_counts.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L1:step-version" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L1:step-version" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L2:step-do" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L2:step-do" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L3:step-g0c_begin" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X06"
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L3:step-g0c_begin" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L4:step-import" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
import delimited using "dag/reports/word_data/G0/source_state_counts.csv", varnames(1) asdouble clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L4:step-import" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L5:step-generate" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
generate str50 state_scope="inherited_numeric_state; masking_not_inferred"
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L5:step-generate" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L6:step-isid" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
isid source_year variable source_state
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L6:step-isid" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L7:step-rename" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
rename source_state state
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L7:step-rename" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L8:step-rename" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
rename observations count
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L8:step-rename" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L9:step-bysort" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
bysort source_year variable: egen long annual_n=total(count)
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L9:step-bysort" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L10:step-assert" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
assert annual_n>0
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L10:step-assert" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L11:step-save" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
save "corrections/reports/source_state_counts.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L11:step-save" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L12:step-display" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X06"
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L12:step-display" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X06_source_state_counts.do:L13:step-log" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L13:step-log" "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X06_source_state_counts.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
