* Tujuan: Ringkas faktor jaringan dan jumlah kandidat emisi cakupan 2; tidak ada faktor baru yang diterima hanya dari adanya angka. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/grid_assumption_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:step-version" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:step-version" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L2:step-do" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L2:step-do" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X22"
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L4:step-use" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
use source_year source_row grid_factor_s1 grid_factor_s2 grid_factor_is_carried r_co2_scope2_s1 using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L4:step-use" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L5:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
generate long scope2_candidate_n=!missing(r_co2_scope2_s1)
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L5:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L6:step-collapse" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
collapse (firstnm) grid_factor_s1 grid_factor_s2 grid_factor_is_carried (sum) scope2_candidate_n, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L6:step-collapse" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L7:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
* Catat jumlah faktor jaringan yang diterima; adanya nilai faktor saja tidak menaikkan hitungan penerimaan. // WFDOC-INJECTED
generate long accepted_factor_n=0
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L7:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L8:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
rename grid_factor_s1 factor_s1
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L8:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L9:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
rename grid_factor_s2 factor_s2
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L9:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L10:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
rename grid_factor_is_carried carry_flag
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L10:step-rename" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:step-foreach" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "loop" 11 15 `=_rc' "in" `"factor_s1 factor_s2"' // WFLOG-INJECTED
* Ulangi blok untuk v: factor_s1, factor_s2. // WFDOC-INJECTED
foreach v in factor_s1 factor_s2 {
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L12:step-local" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    local storage : type `v'
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L12:step-local" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L13:step-assert" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    assert "`storage'"=="double"
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L13:step-assert" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:iteration-body" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L11:step-foreach" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "loop" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L15:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
generate str100 source_status="Inherited factor candidate, post-2014 carry disclosed; no new annual factor admission"
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L15:step-generate" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L16:step-save" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
save "corrections/reports/grid_assumption_coverage.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L16:step-save" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L17:step-display" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X22"
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L17:step-display" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L18:step-log" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L18:step-log" "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X22_grid_assumption_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
