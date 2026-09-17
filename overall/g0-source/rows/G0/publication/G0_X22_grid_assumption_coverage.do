* Tujuan: Ringkas faktor jaringan dan jumlah kandidat emisi cakupan 2; tidak ada faktor baru yang diterima hanya dari adanya angka. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/grid_assumption_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X22"
use source_year source_row grid_factor_s1 grid_factor_s2 grid_factor_is_carried r_co2_scope2_s1 using "data/analysis/G0_analysis_ready.dta", clear
generate long scope2_candidate_n=!missing(r_co2_scope2_s1)
collapse (firstnm) grid_factor_s1 grid_factor_s2 grid_factor_is_carried (sum) scope2_candidate_n, by(source_year)
* Catat jumlah faktor jaringan yang diterima; adanya nilai faktor saja tidak menaikkan hitungan penerimaan. // WFDOC-INJECTED
generate long accepted_factor_n=0
rename grid_factor_s1 factor_s1
rename grid_factor_s2 factor_s2
rename grid_factor_is_carried carry_flag
* Ulangi blok untuk v: factor_s1, factor_s2. // WFDOC-INJECTED
foreach v in factor_s1 factor_s2 {
    local storage : type `v'
    assert "`storage'"=="double"
}
generate str100 source_status="Inherited factor candidate, post-2014 carry disclosed; no new annual factor admission"
save "corrections/reports/grid_assumption_coverage.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X22"
capture log close G0CHILD
