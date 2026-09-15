* Tujuan: Hitung jumlah baris per tahun dari master analisis, tandai wave yang tersedia, dan pastikan tahun 2016 tidak ada. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/annual_sample.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L1:step-version" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L1:step-version" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L2:step-do" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L2:step-do" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L3:step-g0c_begin" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X02"
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L3:step-g0c_begin" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L4:step-use" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
use source_year source_row using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L4:step-use" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L5:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L5:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L6:step-collapse" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
collapse (sum) rows, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L6:step-collapse" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L7:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
generate str25 availability="supplied_actual_wave"
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L7:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L8:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
generate byte row_key_verified=1
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L8:step-generate" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L9:step-assert" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
assert source_year!=2016
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L9:step-assert" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L10:step-isid" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
isid source_year
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L10:step-isid" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L11:step-save" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
save "corrections/reports/annual_sample.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L11:step-save" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L12:step-display" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X02"
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L12:step-display" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X02_annual_sample.do:L13:step-log" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L13:step-log" "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X02_annual_sample.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
