* Tujuan: Bandingkan cakupan stok modal dengan penambahan modal; field capital_nominal campuran tidak diberi definisi stok. // WFDOC-INJECTED
* Input: corrections/reports/core_descriptive_statistics.dta // WFDOC-INJECTED
* Output: corrections/reports/capital_definition_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:step-version" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:step-version" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L2:step-do" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L2:step-do" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X09"
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L4:step-use" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
use "corrections/reports/core_descriptive_statistics.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L4:step-use" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L5:step-keep" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
keep if inlist(variable,"capital_stock_nominal","capital_additions_nominal","capital_stock_per_worker","capital_additions_per_worker")
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L5:step-keep" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L6:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
generate str90 definition_status="Separate stock/additions candidates. Mixed capital_nominal is never certified stock."
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L6:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L7:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
generate str32 concept=variable
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L7:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L8:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
generate long observed_n=n
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L8:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L9:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
generate long verified_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L9:step-generate" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L10:step-save" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
save "corrections/reports/capital_definition_coverage.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L10:step-save" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L11:step-display" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X09"
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L11:step-display" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X09_capital_definition_coverage.do:L12:step-log" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L12:step-log" "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X09_capital_definition_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
