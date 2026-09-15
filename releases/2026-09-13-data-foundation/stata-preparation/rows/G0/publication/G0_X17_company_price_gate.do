* Tujuan: Catat baris per tahun; tidak ada pencocokan harga perusahaan yang diterima dan jumlah yang belum dicoba sama dengan jumlah baris. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/company_price_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L1:step-version" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L1:step-version" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L2:step-do" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L2:step-do" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X17"
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L4:step-use" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
use source_year source_row using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L4:step-use" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L5:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L5:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L6:step-collapse" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
collapse (sum) rows, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L6:step-collapse" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L7:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long accepted_match_n=0
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L7:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L8:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long not_attempted_n=rows
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L8:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L9:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long ambiguous_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L9:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L10:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
generate long unmatched_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L10:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L11:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
generate str100 gate_status="Price matching not attempted: annual vintage/national bridge/price concept unaccepted"
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L11:step-generate" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L12:step-save" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
save "corrections/reports/company_price_gate.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L12:step-save" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L13:step-display" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X17"
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L13:step-display" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X17_company_price_gate.do:L14:step-log" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L14:step-log" "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X17_company_price_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
