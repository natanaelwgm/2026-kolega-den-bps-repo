* Tujuan: Ringkas listrik PLN/non-PLN, total pembelian dan konversi GJ, terpisah dari indikator own-generation. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/electricity_and_own_generation.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:step-version" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:step-version" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L2:step-do" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L2:step-do" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L3:step-g0c_begin" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X21"
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L3:step-g0c_begin" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L4:step-use" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
use source_year source_row cl_elec_pln_kwh cl_elec_nonpln_kwh r_elec_purchased_kwh r_gj_electricity own_gen_positive_reported own_generation_added using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L4:step-use" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L5:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L5:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L6:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long pln_n=!missing(cl_elec_pln_kwh)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L6:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L7:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long nonpln_n=!missing(cl_elec_nonpln_kwh)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L7:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L8:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long purchased_n=!missing(r_elec_purchased_kwh)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L8:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L9:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long purchased_gj_n=!missing(r_gj_electricity)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L9:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L10:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
generate long own_positive_n=own_gen_positive_reported==1
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L10:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L11:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
generate long own_zero_n=own_gen_positive_reported==0
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L11:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L12:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
generate long own_unknown_n=missing(own_gen_positive_reported)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L12:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L13:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
generate long own_added_n=own_generation_added==1
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L13:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L14:step-collapse" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
collapse (sum) rows pln_n nonpln_n purchased_n purchased_gj_n own_positive_n own_zero_n own_unknown_n own_added_n, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L14:step-collapse" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L15:step-assert" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
assert own_positive_n+own_zero_n+own_unknown_n==rows
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L15:step-assert" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L16:step-assert" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
assert own_added_n==0
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L16:step-assert" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L17:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
generate str120 scope="PLN/non-PLN are inherited-clean candidates; own generation separate, unknown retained, no energy/carbon addition"
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L17:step-generate" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L18:step-save" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
save "corrections/reports/electricity_and_own_generation.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L18:step-save" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L19:step-display" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X21"
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L19:step-display" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L20:step-log" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L20:step-log" "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X21_electricity_and_own_generation.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
