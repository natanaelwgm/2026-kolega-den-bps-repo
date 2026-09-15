* Tujuan: Bandingkan total biaya bahan bakar yang dilaporkan dengan komponen bahan bakar/listrik yang lolos status dan hitung lengkapnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/energy_cost_reconciliation.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:step-version" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:step-version" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L2:step-do" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L2:step-do" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L3:step-g0c_begin" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X23"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L3:step-g0c_begin" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L4:step-use" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
use source_year source_row fuel_total_reported_rp000 st_fuel_total_reported_rp000 fuel_expenditure_basis elec_pln_rp000 elec_nonpln_rp000 st_elec_pln_rp000 st_elec_nonpln_rp000 energy_cost_reported_n energy_cost_reported_partial energy_cost_reported_complete energy_exp_observed_repaired using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L4:step-use" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L5:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L5:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L6:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long reported_fuel_total_n=fuel_total_reported_rp000>=0 & !missing(fuel_total_reported_rp000) & inlist(st_fuel_total_reported_rp000,0,1)
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L6:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L7:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long purchase_component_n=(elec_pln_rp000>=0 & !missing(elec_pln_rp000) & inlist(st_elec_pln_rp000,0,1))+(elec_nonpln_rp000>=0 & !missing(elec_nonpln_rp000) & inlist(st_elec_nonpln_rp000,0,1))
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L7:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L8:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long subtotal_n=!missing(energy_exp_observed_repaired)
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L8:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L9:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
* Hitung kelengkapan tiap bagian biaya dari nilai terisi, nonnegatif, dan status sumber 0/1; total parsial dibedakan dari lengkap. // WFDOC-INJECTED
generate long three_component_complete_n=energy_cost_reported_complete
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L9:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L10:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
generate long partial_component_n=energy_cost_reported_partial
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L10:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L11:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
generate long legacy_fallback_n=fuel_expenditure_basis=="observed_components_fallback"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L11:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L12:step-collapse" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
collapse (sum) rows reported_fuel_total_n purchase_component_n subtotal_n three_component_complete_n partial_component_n legacy_fallback_n (mean) mean_reported_subtotal=energy_exp_observed_repaired, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L12:step-collapse" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L13:step-local" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
local storage : type mean_reported_subtotal
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L13:step-local" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L14:step-assert" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
assert "`storage'"=="double"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L14:step-assert" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L15:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
generate long gap_n=.
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L15:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L16:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
generate str65 purchase_count_scope="observed purchase source fields; denominator is twice annual rows"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L16:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L17:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
generate str120 gap_status="Reported fuel cost plus purchases once; component-gap error test unavailable when candidate categories overlap"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L17:step-generate" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L18:step-save" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
save "corrections/reports/energy_cost_reconciliation.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L18:step-save" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L19:step-display" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X23"
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L19:step-display" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L20:step-log" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L20:step-log" "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X23_energy_cost_reconciliation.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
