* Tujuan: Tampilkan statistik output, nilai tambah, dan input antara sebagai kandidat laporan; identitas akuntansi input antara tidak disahkan. // WFDOC-INJECTED
* Input: corrections/reports/core_descriptive_statistics.dta // WFDOC-INJECTED
* Output: corrections/reports/reported_accounting_diagnostics.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X07"
use "corrections/reports/core_descriptive_statistics.dta", clear
keep if inlist(variable,"gross_output_nominal","value_added_nominal","intermediate_inputs_nominal")
generate str80 gap_status="reported income/output and expenditure candidates; IINPUT identity not certified"
save "corrections/reports/reported_accounting_diagnostics.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X07"
capture log close G0CHILD
