* Tujuan: Bandingkan cakupan stok modal dengan penambahan modal; field capital_nominal campuran tidak diberi definisi stok. // WFDOC-INJECTED
* Input: corrections/reports/core_descriptive_statistics.dta // WFDOC-INJECTED
* Output: corrections/reports/capital_definition_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X09"
use "corrections/reports/core_descriptive_statistics.dta", clear
keep if inlist(variable,"capital_stock_nominal","capital_additions_nominal","capital_stock_per_worker","capital_additions_per_worker")
generate str90 definition_status="Separate stock/additions candidates. Mixed capital_nominal is never certified stock."
generate str32 concept=variable
generate long observed_n=n
generate long verified_n=.
save "corrections/reports/capital_definition_coverage.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X09"
capture log close G0CHILD
