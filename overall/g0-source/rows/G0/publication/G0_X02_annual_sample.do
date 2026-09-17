* Tujuan: Hitung jumlah baris per tahun dari master analisis, tandai wave yang tersedia, dan pastikan tahun 2016 tidak ada. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/annual_sample.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X02"
use source_year source_row using "data/analysis/G0_analysis_ready.dta", clear
generate long rows=1
collapse (sum) rows, by(source_year)
generate str25 availability="supplied_actual_wave"
generate byte row_key_verified=1
assert source_year!=2016
isid source_year
save "corrections/reports/annual_sample.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X02"
capture log close G0CHILD
