* Tujuan: Catat baris per tahun; tidak ada pencocokan harga perusahaan yang diterima dan jumlah yang belum dicoba sama dengan jumlah baris. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/company_price_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X17"
use source_year source_row using "data/analysis/G0_analysis_ready.dta", clear
generate long rows=1
collapse (sum) rows, by(source_year)
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long accepted_match_n=0
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long not_attempted_n=rows
* Laporkan secara terpisah jumlah pencocokan yang diterima, belum dicoba, dan masih ambigu; tidak ada rasio harga yang dibuat di sini. // WFDOC-INJECTED
generate long ambiguous_n=.
generate long unmatched_n=.
generate str100 gate_status="Price matching not attempted: annual vintage/national bridge/price concept unaccepted"
save "corrections/reports/company_price_gate.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X17"
capture log close G0CHILD
