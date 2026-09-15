* Tujuan: Ringkas listrik PLN/non-PLN, total pembelian dan konversi GJ, terpisah dari indikator own-generation. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/electricity_and_own_generation.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X21"
use source_year source_row cl_elec_pln_kwh cl_elec_nonpln_kwh r_elec_purchased_kwh r_gj_electricity own_gen_positive_reported own_generation_added using "data/analysis/G0_analysis_ready.dta", clear
generate long rows=1
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long pln_n=!missing(cl_elec_pln_kwh)
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long nonpln_n=!missing(cl_elec_nonpln_kwh)
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long purchased_n=!missing(r_elec_purchased_kwh)
* Hitung ketersediaan listrik PLN/non-PLN dan total pembelian; ini terpisah dari own-generation. // WFDOC-INJECTED
generate long purchased_gj_n=!missing(r_gj_electricity)
generate long own_positive_n=own_gen_positive_reported==1
generate long own_zero_n=own_gen_positive_reported==0
generate long own_unknown_n=missing(own_gen_positive_reported)
generate long own_added_n=own_generation_added==1
collapse (sum) rows pln_n nonpln_n purchased_n purchased_gj_n own_positive_n own_zero_n own_unknown_n own_added_n, by(source_year)
assert own_positive_n+own_zero_n+own_unknown_n==rows
assert own_added_n==0
generate str120 scope="PLN/non-PLN are inherited-clean candidates; own generation separate, unknown retained, no energy/carbon addition"
save "corrections/reports/electricity_and_own_generation.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X21"
capture log close G0CHILD
