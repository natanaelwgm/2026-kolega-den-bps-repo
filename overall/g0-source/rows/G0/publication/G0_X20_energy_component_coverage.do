* Tujuan: Hitung kelengkapan komponen energi dan listrik; tandai jumlah komponen lengkap/parsial serta tes kuantitas yang belum teramati. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/energy_component_coverage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X20"
use source_year source_row co2_scope1_nfuels_s1 electricity_n_observed energy_all_sources_complete n_quantity_tests n_quantity_unknown all_applicable_tests_observed using "data/analysis/G0_analysis_ready.dta", clear
* Verifikasi flag kelengkapan sumber energi tidak pernah menjadi 1 pada data ini. // WFDOC-INJECTED
assert energy_all_sources_complete==0
generate long rows=1
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_nine_fuel_complete=co2_scope1_nfuels_s1==9
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_two_purchase_complete=electricity_n_observed==2
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_nine_fuel_partial=co2_scope1_nfuels_s1>0 & co2_scope1_nfuels_s1<9
* Hitung terpisah wave yang lengkap/parsial pada komponen yang disebut; partial bukan nol dan bukan lengkap. // WFDOC-INJECTED
generate long n_two_purchase_partial=electricity_n_observed>0 & electricity_n_observed<2
generate long n_nine_fuel_none=co2_scope1_nfuels_s1==0
generate long n_two_purchase_none=electricity_n_observed==0
assert inrange(co2_scope1_nfuels_s1,0,9) & inrange(electricity_n_observed,0,2)
generate long n_selected_partial=co2_scope1_nfuels_s1<9 | electricity_n_observed<2
generate long n_all_sources_complete=energy_all_sources_complete
recast double co2_scope1_nfuels_s1 electricity_n_observed n_quantity_tests n_quantity_unknown
collapse (sum) rows n_nine_fuel_complete n_two_purchase_complete n_nine_fuel_partial n_two_purchase_partial n_nine_fuel_none n_two_purchase_none n_selected_partial n_all_sources_complete (mean) mean_observed_fuel_fields=co2_scope1_nfuels_s1 mean_observed_purchase_fields=electricity_n_observed mean_quantity_tests=n_quantity_tests mean_quantity_unknown=n_quantity_unknown, by(source_year)
* Ulangi blok untuk v: mean_observed_fuel_fields, mean_observed_purchase_fields, mean_quantity_tests, mean_quantity_unknown. // WFDOC-INJECTED
foreach v in mean_observed_fuel_fields mean_observed_purchase_fields mean_quantity_tests mean_quantity_unknown {
    local storage : type `v'
    assert "`storage'"=="double"
}
generate str110 scope="Nine inherited fuel fields and two purchase fields; not all observed fuels; test count is not distinct fuels"
expand 2
bysort source_year: generate byte set_id=_n
generate str35 component_set=cond(set_id==1,"legacy_nine_fuel_fields","legacy_two_purchase_fields")
generate byte required_test_fields=cond(set_id==1,9,2)
generate double observed_test_fields=cond(set_id==1,mean_observed_fuel_fields,mean_observed_purchase_fields)
generate long n_complete_in_set=cond(set_id==1,n_nine_fuel_complete,n_two_purchase_complete)
generate long n_partial=cond(set_id==1,n_nine_fuel_partial,n_two_purchase_partial)
generate long n_none_observed=cond(set_id==1,n_nine_fuel_none,n_two_purchase_none)
assert n_partial+n_none_observed+n_complete_in_set==rows
generate byte all_sources_complete=0
generate str65 observed_count_scope="Mean observed source fields per observation within specified set"
assert observed_test_fields>=0 & observed_test_fields<=required_test_fields
isid source_year component_set
save "corrections/reports/energy_component_coverage.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X20"
capture log close G0CHILD
