* Tujuan: Bandingkan total biaya bahan bakar yang dilaporkan dengan komponen bahan bakar/listrik yang lolos status dan hitung lengkapnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/energy_cost_reconciliation.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X23"
use source_year source_row fuel_total_reported_rp000 st_fuel_total_reported_rp000 fuel_expenditure_basis elec_pln_rp000 elec_nonpln_rp000 st_elec_pln_rp000 st_elec_nonpln_rp000 energy_cost_reported_n energy_cost_reported_partial energy_cost_reported_complete energy_exp_observed_repaired using "data/analysis/G0_analysis_ready.dta", clear
generate long rows=1
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long reported_fuel_total_n=fuel_total_reported_rp000>=0 & !missing(fuel_total_reported_rp000) & inlist(st_fuel_total_reported_rp000,0,1)
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long purchase_component_n=(elec_pln_rp000>=0 & !missing(elec_pln_rp000) & inlist(st_elec_pln_rp000,0,1))+(elec_nonpln_rp000>=0 & !missing(elec_nonpln_rp000) & inlist(st_elec_nonpln_rp000,0,1))
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long subtotal_n=!missing(energy_exp_observed_repaired)
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long three_component_complete_n=energy_cost_reported_complete
generate long partial_component_n=energy_cost_reported_partial
generate long legacy_fallback_n=fuel_expenditure_basis=="observed_components_fallback"
collapse (sum) rows reported_fuel_total_n purchase_component_n subtotal_n three_component_complete_n partial_component_n legacy_fallback_n (mean) mean_reported_subtotal=energy_exp_observed_repaired, by(source_year)
local storage : type mean_reported_subtotal
assert "`storage'"=="double"
generate long gap_n=.
generate str65 purchase_count_scope="observed purchase source fields; denominator is twice annual rows"
generate str120 gap_status="Reported fuel cost plus purchases once; component-gap error test unavailable when candidate categories overlap"
save "corrections/reports/energy_cost_reconciliation.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X23"
capture log close G0CHILD
