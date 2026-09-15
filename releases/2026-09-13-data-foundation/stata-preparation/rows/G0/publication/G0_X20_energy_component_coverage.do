* Tujuan: Hitung kelengkapan komponen energi dan listrik; tandai jumlah komponen lengkap/parsial serta tes kuantitas yang belum teramati. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/energy_component_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:step-version" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 1 35 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:step-version" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 1 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L2:step-do" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 2 35 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L2:step-do" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 2 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 3 35 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X20"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 3 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L4:step-use" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 4 35 `=_rc' // WFLOG-INJECTED
use source_year source_row co2_scope1_nfuels_s1 electricity_n_observed energy_all_sources_complete n_quantity_tests n_quantity_unknown all_applicable_tests_observed using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L4:step-use" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 4 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L5:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 5 35 `=_rc' // WFLOG-INJECTED
* Verifikasi flag kelengkapan sumber energi tidak pernah menjadi 1 pada data ini. // WFDOC-INJECTED
assert energy_all_sources_complete==0
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L5:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 5 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L6:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 6 35 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L6:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 6 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L7:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 7 35 `=_rc' // WFLOG-INJECTED
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_nine_fuel_complete=co2_scope1_nfuels_s1==9
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L7:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 7 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L8:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 8 35 `=_rc' // WFLOG-INJECTED
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_two_purchase_complete=electricity_n_observed==2
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L8:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 8 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L9:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 9 35 `=_rc' // WFLOG-INJECTED
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_nine_fuel_partial=co2_scope1_nfuels_s1>0 & co2_scope1_nfuels_s1<9
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L9:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 9 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L10:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 10 35 `=_rc' // WFLOG-INJECTED
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_two_purchase_partial=electricity_n_observed>0 & electricity_n_observed<2
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L10:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 10 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L11:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 11 35 `=_rc' // WFLOG-INJECTED
generate long n_nine_fuel_none=co2_scope1_nfuels_s1==0
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L11:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 11 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L12:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 12 35 `=_rc' // WFLOG-INJECTED
generate long n_two_purchase_none=electricity_n_observed==0
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L12:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 12 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L13:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 13 35 `=_rc' // WFLOG-INJECTED
assert inrange(co2_scope1_nfuels_s1,0,9) & inrange(electricity_n_observed,0,2)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L13:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 13 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L14:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 14 35 `=_rc' // WFLOG-INJECTED
generate long n_selected_partial=co2_scope1_nfuels_s1<9 | electricity_n_observed<2
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L14:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 14 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L15:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 15 35 `=_rc' // WFLOG-INJECTED
generate long n_all_sources_complete=energy_all_sources_complete
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L15:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 15 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L16:step-recast" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 16 35 `=_rc' // WFLOG-INJECTED
recast double co2_scope1_nfuels_s1 electricity_n_observed n_quantity_tests n_quantity_unknown
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L16:step-recast" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 16 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L17:step-collapse" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 17 35 `=_rc' // WFLOG-INJECTED
collapse (sum) rows n_nine_fuel_complete n_two_purchase_complete n_nine_fuel_partial n_two_purchase_partial n_nine_fuel_none n_two_purchase_none n_selected_partial n_all_sources_complete (mean) mean_observed_fuel_fields=co2_scope1_nfuels_s1 mean_observed_purchase_fields=electricity_n_observed mean_quantity_tests=n_quantity_tests mean_quantity_unknown=n_quantity_unknown, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L17:step-collapse" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 17 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:step-foreach" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "loop" 18 35 `=_rc' "in" `"mean_observed_fuel_fields mean_observed_purchase_fields mean_quantity_tests mean_quantity_unknown"' // WFLOG-INJECTED
* Ulangi blok untuk v: mean_observed_fuel_fields, mean_observed_purchase_fields, mean_quantity_tests, mean_quantity_unknown. // WFDOC-INJECTED
foreach v in mean_observed_fuel_fields mean_observed_purchase_fields mean_quantity_tests mean_quantity_unknown {
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L19:step-local" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    local storage : type `v'
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L19:step-local" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L20:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    assert "`storage'"=="double"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L20:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:iteration-body" "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L18:step-foreach" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "loop" 18 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L22:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 19 35 `=_rc' // WFLOG-INJECTED
generate str110 scope="Nine inherited fuel fields and two purchase fields; not all observed fuels; test count is not distinct fuels"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L22:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 19 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L23:step-expand" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 20 35 `=_rc' // WFLOG-INJECTED
expand 2
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L23:step-expand" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 20 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L24:step-bysort" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 21 35 `=_rc' // WFLOG-INJECTED
bysort source_year: generate byte set_id=_n
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L24:step-bysort" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 21 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L25:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 22 35 `=_rc' // WFLOG-INJECTED
generate str35 component_set=cond(set_id==1,"legacy_nine_fuel_fields","legacy_two_purchase_fields")
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L25:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 22 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L26:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 23 35 `=_rc' // WFLOG-INJECTED
generate byte required_test_fields=cond(set_id==1,9,2)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L26:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 23 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L27:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 24 35 `=_rc' // WFLOG-INJECTED
generate double observed_test_fields=cond(set_id==1,mean_observed_fuel_fields,mean_observed_purchase_fields)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L27:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 24 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L28:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 25 35 `=_rc' // WFLOG-INJECTED
generate long n_complete_in_set=cond(set_id==1,n_nine_fuel_complete,n_two_purchase_complete)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L28:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 25 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L29:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 26 35 `=_rc' // WFLOG-INJECTED
generate long n_partial=cond(set_id==1,n_nine_fuel_partial,n_two_purchase_partial)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L29:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 26 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L30:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 27 35 `=_rc' // WFLOG-INJECTED
generate long n_none_observed=cond(set_id==1,n_nine_fuel_none,n_two_purchase_none)
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L30:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 27 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L31:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 28 35 `=_rc' // WFLOG-INJECTED
assert n_partial+n_none_observed+n_complete_in_set==rows
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L31:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 28 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L32:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 29 35 `=_rc' // WFLOG-INJECTED
generate byte all_sources_complete=0
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L32:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 29 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L33:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 30 35 `=_rc' // WFLOG-INJECTED
generate str65 observed_count_scope="Mean observed source fields per observation within specified set"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L33:step-generate" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 30 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L34:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 31 35 `=_rc' // WFLOG-INJECTED
assert observed_test_fields>=0 & observed_test_fields<=required_test_fields
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L34:step-assert" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 31 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L35:step-isid" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 32 35 `=_rc' // WFLOG-INJECTED
isid source_year component_set
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L35:step-isid" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 32 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L36:step-save" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 33 35 `=_rc' // WFLOG-INJECTED
save "corrections/reports/energy_component_coverage.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L36:step-save" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 33 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L37:step-display" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 34 35 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X20"
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L37:step-display" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 34 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X20_energy_component_coverage.do:L38:step-log" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 35 35 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L38:step-log" "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "statement" 35 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X20_energy_component_coverage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
