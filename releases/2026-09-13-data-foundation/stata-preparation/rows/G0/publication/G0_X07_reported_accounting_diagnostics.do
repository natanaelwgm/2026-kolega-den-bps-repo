* Tujuan: Tampilkan statistik output, nilai tambah, dan input antara sebagai kandidat laporan; identitas akuntansi input antara tidak disahkan. // WFDOC-INJECTED
* Input: corrections/reports/core_descriptive_statistics.dta // WFDOC-INJECTED
* Output: corrections/reports/reported_accounting_diagnostics.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:step-version" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:step-version" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L2:step-do" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L2:step-do" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L3:step-g0c_begin" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X07"
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L3:step-g0c_begin" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L4:step-use" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
use "corrections/reports/core_descriptive_statistics.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L4:step-use" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L5:step-keep" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
keep if inlist(variable,"gross_output_nominal","value_added_nominal","intermediate_inputs_nominal")
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L5:step-keep" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L6:step-generate" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
generate str80 gap_status="reported income/output and expenditure candidates; IINPUT identity not certified"
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L6:step-generate" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L7:step-save" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
save "corrections/reports/reported_accounting_diagnostics.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L7:step-save" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L8:step-display" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X07"
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L8:step-display" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L9:step-log" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L9:step-log" "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
