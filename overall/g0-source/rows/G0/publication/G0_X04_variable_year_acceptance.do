* Tujuan: Gabungkan cakupan lama per variabel/tahun dengan status penerimaan dan metadata aturan terbaru; status lama tetap dibedakan dari gerbang baru. // WFDOC-INJECTED
* Input: report/tables/all_variable_year_coverage.csv; data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__new_coverage.dta; corrections/reports/variable_year_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X04"
import delimited using "report/tables/all_variable_year_coverage.csv", varnames(1) asdouble clear encoding("UTF-8")
rename year source_year
rename zeros zero
generate str35 release_status="immutable_legacy_candidate"
tempfile old
save `old'
use "data/analysis/G0_analysis_ready.dta", clear
keep source_year source_row all_applicable_tests_observed any_negative_decision any_negative_observed carbon_changed carbon_den_state carbon_eligible carbon_legacy_ratio carbon_num_state ci_co2_output_repaired cq001_applicable cq002_applicable cq003_applicable cq004_applicable cq005_applicable cq006_applicable cq007_applicable cq008_applicable cq009_applicable cq010_applicable cq011_applicable cq012_applicable cq013_applicable cq014_applicable cq015_applicable cq016_applicable cq017_applicable cq018_applicable cq019_applicable cq020_applicable cq021_applicable cr001_state cr002_state cr003_state cr004_state cr005_state cr010_state cr171_state ei_gj_output_repaired ei_money_output_repaired energy_changed energy_cost_reported_complete energy_cost_reported_n energy_cost_reported_partial energy_den_state energy_eligible energy_exp_observed_repaired energy_legacy_ratio energy_num_state legacy_price_tail_flag monetary_changed monetary_den_state monetary_eligible monetary_legacy_ratio monetary_num_state n_quantity_tests n_quantity_unknown output_share_changed output_share_den_state output_share_eligible output_share_legacy_ratio output_share_num_state own_gen_flag_changed own_gen_legacy_flag own_gen_observed_valid own_gen_positive_reported own_gen_source_state own_gen_unknown price_tail_evaluated_n price_tail_source_gate qn_elec_nonpln_kwh qn_elec_owngen_kwh qn_elec_pln_kwh qn_fuel_biodiesel_ltr qn_fuel_biomass_kg qn_fuel_charcoal_kg qn_fuel_citygas_m3 qn_fuel_coal_kg qn_fuel_coalbriq_kg qn_fuel_coke_kg qn_fuel_diesel_ltr qn_fuel_dieseloil_ltr qn_fuel_firewood_kg qn_fuel_fueloil_ltr qn_fuel_kerosene_ltr qn_fuel_lpg_kg qn_fuel_lubricant_ltr qn_fuel_natgas_kg qn_fuel_natgas_mmbtu qn_fuel_othergas_m3 qn_fuel_petrol_ltr qs_elec_nonpln_kwh qs_elec_owngen_kwh qs_elec_pln_kwh qs_fuel_biodiesel_ltr qs_fuel_biomass_kg qs_fuel_charcoal_kg qs_fuel_citygas_m3 qs_fuel_coal_kg qs_fuel_coalbriq_kg qs_fuel_coke_kg qs_fuel_diesel_ltr qs_fuel_dieseloil_ltr qs_fuel_firewood_kg qs_fuel_fueloil_ltr qs_fuel_kerosene_ltr qs_fuel_lpg_kg qs_fuel_lubricant_ltr qs_fuel_natgas_kg qs_fuel_natgas_mmbtu qs_fuel_othergas_m3 qs_fuel_petrol_ltr r_capital_additions_per_worker r_capital_per_worker_nominal r_capital_stock_per_worker r_capital_stock_per_worker_state r_co2_per_worker r_co2_per_worker_state r_co2_scope1_s1 r_co2_scope1_s1_n r_co2_scope2_s1 r_co2_scope2_s1_n r_co2_total_s1 r_co2_total_s1_n r_elec_purchased_kwh r_elec_purchased_kwh_n r_energy_cost_per_worker r_energy_cost_per_worker_state r_gj_electricity r_gj_electricity_n r_gj_fuel_s1 r_gj_fuel_s1_n r_inputs_per_worker_nominal r_labor_productivity_nominal r_ln_capital_additions_nominal r_ln_capital_nominal r_ln_capital_nominal_state r_ln_capital_stock_nominal r_ln_capital_stock_nominal_state r_ln_co2_total_s1 r_ln_co2_total_s1_state r_ln_energy_expenditure r_ln_energy_expenditure_state r_ln_import_nominal r_ln_import_nominal_state r_ln_inputs_nominal r_ln_inputs_nominal_state r_ln_output_nominal r_ln_output_nominal_state r_ln_rd_cost_nominal r_ln_rd_cost_nominal_state r_ln_total_gj_s1 r_ln_total_gj_s1_state r_ln_va_nominal r_ln_va_nominal_state r_ln_val_cbdacu r_ln_val_cbdacu_state r_ln_val_cbfpcu r_ln_val_cbfpcu_state r_ln_val_cbsacu r_ln_val_cbsacu_state r_ln_val_cbttcu r_ln_val_cbttcu_state r_ln_val_cldacu r_ln_val_cldacu_state r_ln_val_clfpcu r_ln_val_clfpcu_state r_ln_val_clsacu r_ln_val_clsacu_state r_ln_val_clttcu r_ln_val_clttcu_state r_ln_val_cmdacu r_ln_val_cmdacu_state r_ln_val_cmfpcu r_ln_val_cmfpcu_state r_ln_val_cmsacu r_ln_val_cmsacu_state r_ln_val_cmttcu r_ln_val_cmttcu_state r_ln_val_codacu r_ln_val_codacu_state r_ln_val_cofpcu r_ln_val_cofpcu_state r_ln_val_cosacu r_ln_val_cosacu_state r_ln_val_costrd r_ln_val_costrd_state r_ln_val_cottcu r_ln_val_cottcu_state r_ln_val_csdacu r_ln_val_csdacu_state r_ln_val_csfpcu r_ln_val_csfpcu_state r_ln_val_cssacu r_ln_val_cssacu_state r_ln_val_csttcu r_ln_val_csttcu_state r_ln_val_ctdacu r_ln_val_ctdacu_state r_ln_val_ctfpcu r_ln_val_ctfpcu_state r_ln_val_ctsacu r_ln_val_ctsacu_state r_ln_val_cttcu r_ln_val_cttcu_state r_ln_val_ctttcu r_ln_val_ctttcu_state r_ln_val_cvdacu r_ln_val_cvdacu_state r_ln_val_cvfpcu r_ln_val_cvfpcu_state r_ln_val_cvsacu r_ln_val_cvsacu_state r_ln_val_cvttcu r_ln_val_cvttcu_state r_ln_val_devvcu r_ln_val_devvcu_state r_ln_val_ecavce r_ln_val_ecavce_state r_ln_val_ecavcu r_ln_val_ecavcu_state r_ln_val_ecbvce r_ln_val_ecbvce_state r_ln_val_ecbvcu r_ln_val_ecbvcu_state r_ln_val_eckvce r_ln_val_eckvce_state r_ln_val_eckvcu r_ln_val_eckvcu_state r_ln_val_eclvce r_ln_val_eclvce_state r_ln_val_eclvcu r_ln_val_eclvcu_state r_ln_val_edivce r_ln_val_edivce_state r_ln_val_edivcu r_ln_val_edivcu_state r_ln_val_efovce r_ln_val_efovce_state r_ln_val_efovcu r_ln_val_efovcu_state r_ln_val_efuvce r_ln_val_efuvce_state r_ln_val_efuvcu r_ln_val_efuvcu_state r_ln_val_egavce r_ln_val_egavce_state r_ln_val_egavcu r_ln_val_egavcu_state r_ln_val_egovce r_ln_val_egovce_state r_ln_val_egovcu r_ln_val_egovcu_state r_ln_val_elpvce r_ln_val_elpvce_state r_ln_val_elpvcu r_ln_val_elpvcu_state r_ln_val_eluvce r_ln_val_eluvce_state r_ln_val_eluvcu r_ln_val_eluvcu_state r_ln_val_encvce r_ln_val_encvce_state r_ln_val_encvcu r_ln_val_encvcu_state r_ln_val_engvce r_ln_val_engvce_state r_ln_val_engvcu r_ln_val_engvcu_state r_ln_val_enpvcu r_ln_val_enpvcu_state r_ln_val_eoivce r_ln_val_eoivce_state r_ln_val_eoivcu r_ln_val_eoivcu_state r_ln_val_epevce r_ln_val_epevce_state r_ln_val_epevcu r_ln_val_epevcu_state r_ln_val_eplvcu r_ln_val_eplvcu_state r_ln_val_esdvce r_ln_val_esdvce_state r_ln_val_esdvcu r_ln_val_esdvcu_state r_ln_val_esovce r_ln_val_esovce_state r_ln_val_esovcu r_ln_val_esovcu_state r_ln_val_ibrvcu r_ln_val_ibrvcu_state r_ln_val_icovcu r_ln_val_icovcu_state r_ln_val_idevcu r_ln_val_idevcu_state r_ln_val_iinput r_ln_val_iinput_state r_ln_val_iinvcu r_ln_val_iinvcu_state r_ln_val_iisfov r_ln_val_iisfov_state r_ln_val_iislov r_ln_val_iislov_state r_ln_val_iisvcu r_ln_val_iisvcu_state r_ln_val_ikivcu r_ln_val_ikivcu_state r_ln_val_iklvcu r_ln_val_iklvcu_state r_ln_val_ikovcu r_ln_val_ikovcu_state r_ln_val_ilrvcu r_ln_val_ilrvcu_state r_ln_val_insvcu r_ln_val_insvcu_state r_ln_val_intvcu r_ln_val_intvcu_state r_ln_val_iotvcu r_ln_val_iotvcu_state r_ln_val_ipkvcu r_ln_val_ipkvcu_state r_ln_val_iprvcu r_ln_val_iprvcu_state r_ln_val_irdvcu r_ln_val_irdvcu_state r_ln_val_irevcu r_ln_val_irevcu_state r_ln_val_irrvcu r_ln_val_irrvcu_state r_ln_val_itxvcu r_ln_val_itxvcu_state r_ln_val_iuwvcu r_ln_val_iuwvcu_state r_ln_val_nopvcu r_ln_val_nopvcu_state r_ln_val_othvcu r_ln_val_othvcu_state r_ln_val_output r_ln_val_output_state r_ln_val_rdnvcu r_ln_val_rdnvcu_state r_ln_val_renvcu r_ln_val_renvcu_state r_ln_val_rimvcu r_ln_val_rimvcu_state r_ln_val_rtlvcu r_ln_val_rtlvcu_state r_ln_val_sfbvcu r_ln_val_sfbvcu_state r_ln_val_sfcvcu r_ln_val_sfcvcu_state r_ln_val_sfdvcu r_ln_val_sfdvcu_state r_ln_val_sfgvcu r_ln_val_sfgvcu_state r_ln_val_sfjvcu r_ln_val_sfjvcu_state r_ln_val_sfkvcu r_ln_val_sfkvcu_state r_ln_val_sfnvcu r_ln_val_sfnvcu_state r_ln_val_sfovcu r_ln_val_sfovcu_state r_ln_val_sfrvcu r_ln_val_sfrvcu_state r_ln_val_sfsvcu r_ln_val_sfsvcu_state r_ln_val_sfuvcu r_ln_val_sfuvcu_state r_ln_val_shdvcu r_ln_val_shdvcu_state r_ln_val_shfvcu r_ln_val_shfvcu_state r_ln_val_shjvcu r_ln_val_shjvcu_state r_ln_val_srdvcu r_ln_val_srdvcu_state r_ln_val_srjvcu r_ln_val_srjvcu_state r_ln_val_srmvcu r_ln_val_srmvcu_state r_ln_val_stdvcu r_ln_val_stdvcu_state r_ln_val_stjvcu r_ln_val_stjvcu_state r_ln_val_stlvcu r_ln_val_stlvcu_state r_ln_val_vtlvcu r_ln_val_vtlvcu_state r_ln_val_yelvcu r_ln_val_yelvcu_state r_ln_val_yisvcu r_ln_val_yisvcu_state r_ln_val_yisvdo r_ln_val_yisvdo_state r_ln_val_yisvfo r_ln_val_yisvfo_state r_ln_val_ykdvcu r_ln_val_ykdvcu_state r_ln_val_ykfvcu r_ln_val_ykfvcu_state r_ln_val_ykivcu r_ln_val_ykivcu_state r_ln_val_yprvcu r_ln_val_yprvcu_state r_ln_val_yrnvcu r_ln_val_yrnvcu_state r_ln_val_yrsvcu r_ln_val_yrsvcu_state r_ln_val_ysnvcu r_ln_val_ysnvcu_state r_ln_val_ytovcu r_ln_val_ytovcu_state r_ln_val_znavcu r_ln_val_znavcu_state r_ln_val_zndvcu r_ln_val_zndvcu_state r_ln_val_znevcu r_ln_val_znevcu_state r_ln_val_znhvcu r_ln_val_znhvcu_state r_ln_val_znivcu r_ln_val_znivcu_state r_ln_val_znovcu r_ln_val_znovcu_state r_ln_val_znpvcu r_ln_val_znpvcu_state r_ln_val_znrvcu r_ln_val_znrvcu_state r_ln_val_znsvcu r_ln_val_znsvcu_state r_ln_val_zntvcu r_ln_val_zntvcu_state r_ln_val_zpavcu r_ln_val_zpavcu_state r_ln_val_zpdvcu r_ln_val_zpdvcu_state r_ln_val_zpevcu r_ln_val_zpevcu_state r_ln_val_zphvcu r_ln_val_zphvcu_state r_ln_val_zpivcu r_ln_val_zpivcu_state r_ln_val_zpovcu r_ln_val_zpovcu_state r_ln_val_zppvcu r_ln_val_zppvcu_state r_ln_val_zprvcu r_ln_val_zprvcu_state r_ln_val_zpsvcu r_ln_val_zpsvcu_state r_ln_val_zptvcu r_ln_val_zptvcu_state r_ln_workers r_ln_workers_state r_output_per_worker_nominal r_pw_val_cbdacu r_pw_val_cbdacu_state r_pw_val_cbfpcu r_pw_val_cbfpcu_state r_pw_val_cbsacu r_pw_val_cbsacu_state r_pw_val_cbttcu r_pw_val_cbttcu_state r_pw_val_cldacu r_pw_val_cldacu_state r_pw_val_clfpcu r_pw_val_clfpcu_state r_pw_val_clsacu r_pw_val_clsacu_state r_pw_val_clttcu r_pw_val_clttcu_state r_pw_val_cmdacu r_pw_val_cmdacu_state r_pw_val_cmfpcu r_pw_val_cmfpcu_state r_pw_val_cmsacu r_pw_val_cmsacu_state r_pw_val_cmttcu r_pw_val_cmttcu_state r_pw_val_codacu r_pw_val_codacu_state r_pw_val_cofpcu r_pw_val_cofpcu_state r_pw_val_cosacu r_pw_val_cosacu_state r_pw_val_costrd r_pw_val_costrd_state r_pw_val_cottcu r_pw_val_cottcu_state r_pw_val_csdacu r_pw_val_csdacu_state r_pw_val_csfpcu r_pw_val_csfpcu_state r_pw_val_cssacu r_pw_val_cssacu_state r_pw_val_csttcu r_pw_val_csttcu_state r_pw_val_ctdacu r_pw_val_ctdacu_state r_pw_val_ctfpcu r_pw_val_ctfpcu_state r_pw_val_ctsacu r_pw_val_ctsacu_state r_pw_val_cttcu r_pw_val_cttcu_state r_pw_val_ctttcu r_pw_val_ctttcu_state r_pw_val_cvdacu r_pw_val_cvdacu_state r_pw_val_cvfpcu r_pw_val_cvfpcu_state r_pw_val_cvsacu r_pw_val_cvsacu_state r_pw_val_cvttcu r_pw_val_cvttcu_state r_pw_val_devvcu r_pw_val_devvcu_state r_pw_val_ecavce r_pw_val_ecavce_state r_pw_val_ecavcu r_pw_val_ecavcu_state r_pw_val_ecbvce r_pw_val_ecbvce_state r_pw_val_ecbvcu r_pw_val_ecbvcu_state r_pw_val_eckvce r_pw_val_eckvce_state r_pw_val_eckvcu r_pw_val_eckvcu_state r_pw_val_eclvce r_pw_val_eclvce_state r_pw_val_eclvcu r_pw_val_eclvcu_state r_pw_val_edivce r_pw_val_edivce_state r_pw_val_edivcu r_pw_val_edivcu_state r_pw_val_efovce r_pw_val_efovce_state r_pw_val_efovcu r_pw_val_efovcu_state r_pw_val_efuvce r_pw_val_efuvce_state r_pw_val_efuvcu r_pw_val_efuvcu_state r_pw_val_egavce r_pw_val_egavce_state r_pw_val_egavcu r_pw_val_egavcu_state r_pw_val_egovce r_pw_val_egovce_state r_pw_val_egovcu r_pw_val_egovcu_state r_pw_val_elpvce r_pw_val_elpvce_state r_pw_val_elpvcu r_pw_val_elpvcu_state r_pw_val_eluvce r_pw_val_eluvce_state r_pw_val_eluvcu r_pw_val_eluvcu_state r_pw_val_encvce r_pw_val_encvce_state r_pw_val_encvcu r_pw_val_encvcu_state r_pw_val_engvce r_pw_val_engvce_state r_pw_val_engvcu r_pw_val_engvcu_state r_pw_val_enpvcu r_pw_val_enpvcu_state r_pw_val_eoivce r_pw_val_eoivce_state r_pw_val_eoivcu r_pw_val_eoivcu_state r_pw_val_epevce r_pw_val_epevce_state r_pw_val_epevcu r_pw_val_epevcu_state r_pw_val_eplvcu r_pw_val_eplvcu_state r_pw_val_esdvce r_pw_val_esdvce_state r_pw_val_esdvcu r_pw_val_esdvcu_state r_pw_val_esovce r_pw_val_esovce_state r_pw_val_esovcu r_pw_val_esovcu_state r_pw_val_ibrvcu r_pw_val_ibrvcu_state r_pw_val_icovcu r_pw_val_icovcu_state r_pw_val_idevcu r_pw_val_idevcu_state r_pw_val_iinput r_pw_val_iinput_state r_pw_val_iinvcu r_pw_val_iinvcu_state r_pw_val_iisfov r_pw_val_iisfov_state r_pw_val_iislov r_pw_val_iislov_state r_pw_val_iisvcu r_pw_val_iisvcu_state r_pw_val_ikivcu r_pw_val_ikivcu_state r_pw_val_iklvcu r_pw_val_iklvcu_state r_pw_val_ikovcu r_pw_val_ikovcu_state r_pw_val_ilrvcu r_pw_val_ilrvcu_state r_pw_val_insvcu r_pw_val_insvcu_state r_pw_val_intvcu r_pw_val_intvcu_state r_pw_val_iotvcu r_pw_val_iotvcu_state r_pw_val_ipkvcu r_pw_val_ipkvcu_state r_pw_val_iprvcu r_pw_val_iprvcu_state r_pw_val_irdvcu r_pw_val_irdvcu_state r_pw_val_irevcu r_pw_val_irevcu_state r_pw_val_irrvcu r_pw_val_irrvcu_state r_pw_val_itxvcu r_pw_val_itxvcu_state r_pw_val_iuwvcu r_pw_val_iuwvcu_state r_pw_val_nopvcu r_pw_val_nopvcu_state r_pw_val_othvcu r_pw_val_othvcu_state r_pw_val_output r_pw_val_output_state r_pw_val_rdnvcu r_pw_val_rdnvcu_state r_pw_val_renvcu r_pw_val_renvcu_state r_pw_val_rimvcu r_pw_val_rimvcu_state r_pw_val_rtlvcu r_pw_val_rtlvcu_state r_pw_val_sfbvcu r_pw_val_sfbvcu_state r_pw_val_sfcvcu r_pw_val_sfcvcu_state r_pw_val_sfdvcu r_pw_val_sfdvcu_state r_pw_val_sfgvcu r_pw_val_sfgvcu_state r_pw_val_sfjvcu r_pw_val_sfjvcu_state r_pw_val_sfkvcu r_pw_val_sfkvcu_state r_pw_val_sfnvcu r_pw_val_sfnvcu_state r_pw_val_sfovcu r_pw_val_sfovcu_state r_pw_val_sfrvcu r_pw_val_sfrvcu_state r_pw_val_sfsvcu r_pw_val_sfsvcu_state r_pw_val_sfuvcu r_pw_val_sfuvcu_state r_pw_val_shdvcu r_pw_val_shdvcu_state r_pw_val_shfvcu r_pw_val_shfvcu_state r_pw_val_shjvcu r_pw_val_shjvcu_state r_pw_val_srdvcu r_pw_val_srdvcu_state r_pw_val_srjvcu r_pw_val_srjvcu_state r_pw_val_srmvcu r_pw_val_srmvcu_state r_pw_val_stdvcu r_pw_val_stdvcu_state r_pw_val_stjvcu r_pw_val_stjvcu_state r_pw_val_stlvcu r_pw_val_stlvcu_state r_pw_val_vtlvcu r_pw_val_vtlvcu_state r_pw_val_yelvcu r_pw_val_yelvcu_state r_pw_val_yisvcu r_pw_val_yisvcu_state r_pw_val_yisvdo r_pw_val_yisvdo_state r_pw_val_yisvfo r_pw_val_yisvfo_state r_pw_val_ykdvcu r_pw_val_ykdvcu_state r_pw_val_ykfvcu r_pw_val_ykfvcu_state r_pw_val_ykivcu r_pw_val_ykivcu_state r_pw_val_yprvcu r_pw_val_yprvcu_state r_pw_val_yrnvcu r_pw_val_yrnvcu_state r_pw_val_yrsvcu r_pw_val_yrsvcu_state r_pw_val_ysnvcu r_pw_val_ysnvcu_state r_pw_val_ytovcu r_pw_val_ytovcu_state r_pw_val_znavcu r_pw_val_znavcu_state r_pw_val_zndvcu r_pw_val_zndvcu_state r_pw_val_znevcu r_pw_val_znevcu_state r_pw_val_znhvcu r_pw_val_znhvcu_state r_pw_val_znivcu r_pw_val_znivcu_state r_pw_val_znovcu r_pw_val_znovcu_state r_pw_val_znpvcu r_pw_val_znpvcu_state r_pw_val_znrvcu r_pw_val_znrvcu_state r_pw_val_znsvcu r_pw_val_znsvcu_state r_pw_val_zntvcu r_pw_val_zntvcu_state r_pw_val_zpavcu r_pw_val_zpavcu_state r_pw_val_zpdvcu r_pw_val_zpdvcu_state r_pw_val_zpevcu r_pw_val_zpevcu_state r_pw_val_zphvcu r_pw_val_zphvcu_state r_pw_val_zpivcu r_pw_val_zpivcu_state r_pw_val_zpovcu r_pw_val_zpovcu_state r_pw_val_zppvcu r_pw_val_zppvcu_state r_pw_val_zprvcu r_pw_val_zprvcu_state r_pw_val_zpsvcu r_pw_val_zpsvcu_state r_pw_val_zptvcu r_pw_val_zptvcu_state r_rd_cost_per_worker_nominal r_total_gj_per_worker r_total_gj_per_worker_state r_total_gj_s1 r_total_gj_s1_n va_abs_tail_flag va_log_positive va_missing_reason va_share_output_repaired va_signed_eligible va_signed_nominal va_signed_per_worker va_signed_tail_sensitivity va_source_state
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' str32 variable int source_year long rows long observed long missing_rows long zero long negative str35 release_status using "corrections/reports/__new_coverage.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(all_applicable_tests_observed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable all_applicable_tests_observed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & all_applicable_tests_observed==0
        local zero=r(N)
        quietly count if source_year==`y' & all_applicable_tests_observed<0 & !missing(all_applicable_tests_observed)
        local neg=r(N)
    }
    post `p' ("all_applicable_tests_observed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(any_negative_decision)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable any_negative_decision
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & any_negative_decision==0
        local zero=r(N)
        quietly count if source_year==`y' & any_negative_decision<0 & !missing(any_negative_decision)
        local neg=r(N)
    }
    post `p' ("any_negative_decision") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(any_negative_observed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable any_negative_observed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & any_negative_observed==0
        local zero=r(N)
        quietly count if source_year==`y' & any_negative_observed<0 & !missing(any_negative_observed)
        local neg=r(N)
    }
    post `p' ("any_negative_observed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(carbon_changed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable carbon_changed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & carbon_changed==0
        local zero=r(N)
        quietly count if source_year==`y' & carbon_changed<0 & !missing(carbon_changed)
        local neg=r(N)
    }
    post `p' ("carbon_changed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(carbon_den_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable carbon_den_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & carbon_den_state==0
        local zero=r(N)
        quietly count if source_year==`y' & carbon_den_state<0 & !missing(carbon_den_state)
        local neg=r(N)
    }
    post `p' ("carbon_den_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(carbon_eligible)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable carbon_eligible
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & carbon_eligible==0
        local zero=r(N)
        quietly count if source_year==`y' & carbon_eligible<0 & !missing(carbon_eligible)
        local neg=r(N)
    }
    post `p' ("carbon_eligible") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(carbon_legacy_ratio)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable carbon_legacy_ratio
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & carbon_legacy_ratio==0
        local zero=r(N)
        quietly count if source_year==`y' & carbon_legacy_ratio<0 & !missing(carbon_legacy_ratio)
        local neg=r(N)
    }
    post `p' ("carbon_legacy_ratio") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(carbon_num_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable carbon_num_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & carbon_num_state==0
        local zero=r(N)
        quietly count if source_year==`y' & carbon_num_state<0 & !missing(carbon_num_state)
        local neg=r(N)
    }
    post `p' ("carbon_num_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(ci_co2_output_repaired)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable ci_co2_output_repaired
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & ci_co2_output_repaired==0
        local zero=r(N)
        quietly count if source_year==`y' & ci_co2_output_repaired<0 & !missing(ci_co2_output_repaired)
        local neg=r(N)
    }
    post `p' ("ci_co2_output_repaired") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq001_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq001_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq001_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq001_applicable<0 & !missing(cq001_applicable)
        local neg=r(N)
    }
    post `p' ("cq001_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq002_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq002_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq002_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq002_applicable<0 & !missing(cq002_applicable)
        local neg=r(N)
    }
    post `p' ("cq002_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq003_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq003_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq003_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq003_applicable<0 & !missing(cq003_applicable)
        local neg=r(N)
    }
    post `p' ("cq003_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq004_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq004_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq004_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq004_applicable<0 & !missing(cq004_applicable)
        local neg=r(N)
    }
    post `p' ("cq004_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq005_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq005_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq005_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq005_applicable<0 & !missing(cq005_applicable)
        local neg=r(N)
    }
    post `p' ("cq005_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq006_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq006_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq006_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq006_applicable<0 & !missing(cq006_applicable)
        local neg=r(N)
    }
    post `p' ("cq006_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq007_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq007_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq007_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq007_applicable<0 & !missing(cq007_applicable)
        local neg=r(N)
    }
    post `p' ("cq007_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq008_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq008_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq008_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq008_applicable<0 & !missing(cq008_applicable)
        local neg=r(N)
    }
    post `p' ("cq008_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq009_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq009_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq009_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq009_applicable<0 & !missing(cq009_applicable)
        local neg=r(N)
    }
    post `p' ("cq009_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq010_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq010_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq010_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq010_applicable<0 & !missing(cq010_applicable)
        local neg=r(N)
    }
    post `p' ("cq010_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq011_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq011_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq011_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq011_applicable<0 & !missing(cq011_applicable)
        local neg=r(N)
    }
    post `p' ("cq011_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq012_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq012_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq012_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq012_applicable<0 & !missing(cq012_applicable)
        local neg=r(N)
    }
    post `p' ("cq012_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq013_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq013_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq013_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq013_applicable<0 & !missing(cq013_applicable)
        local neg=r(N)
    }
    post `p' ("cq013_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq014_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq014_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq014_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq014_applicable<0 & !missing(cq014_applicable)
        local neg=r(N)
    }
    post `p' ("cq014_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq015_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq015_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq015_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq015_applicable<0 & !missing(cq015_applicable)
        local neg=r(N)
    }
    post `p' ("cq015_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq016_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq016_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq016_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq016_applicable<0 & !missing(cq016_applicable)
        local neg=r(N)
    }
    post `p' ("cq016_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq017_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq017_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq017_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq017_applicable<0 & !missing(cq017_applicable)
        local neg=r(N)
    }
    post `p' ("cq017_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq018_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq018_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq018_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq018_applicable<0 & !missing(cq018_applicable)
        local neg=r(N)
    }
    post `p' ("cq018_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq019_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq019_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq019_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq019_applicable<0 & !missing(cq019_applicable)
        local neg=r(N)
    }
    post `p' ("cq019_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq020_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq020_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq020_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq020_applicable<0 & !missing(cq020_applicable)
        local neg=r(N)
    }
    post `p' ("cq020_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cq021_applicable)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cq021_applicable
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cq021_applicable==0
        local zero=r(N)
        quietly count if source_year==`y' & cq021_applicable<0 & !missing(cq021_applicable)
        local neg=r(N)
    }
    post `p' ("cq021_applicable") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr001_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr001_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr001_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr001_state<0 & !missing(cr001_state)
        local neg=r(N)
    }
    post `p' ("cr001_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr002_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr002_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr002_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr002_state<0 & !missing(cr002_state)
        local neg=r(N)
    }
    post `p' ("cr002_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr003_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr003_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr003_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr003_state<0 & !missing(cr003_state)
        local neg=r(N)
    }
    post `p' ("cr003_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr004_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr004_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr004_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr004_state<0 & !missing(cr004_state)
        local neg=r(N)
    }
    post `p' ("cr004_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr005_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr005_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr005_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr005_state<0 & !missing(cr005_state)
        local neg=r(N)
    }
    post `p' ("cr005_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr010_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr010_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr010_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr010_state<0 & !missing(cr010_state)
        local neg=r(N)
    }
    post `p' ("cr010_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(cr171_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable cr171_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & cr171_state==0
        local zero=r(N)
        quietly count if source_year==`y' & cr171_state<0 & !missing(cr171_state)
        local neg=r(N)
    }
    post `p' ("cr171_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(ei_gj_output_repaired)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable ei_gj_output_repaired
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & ei_gj_output_repaired==0
        local zero=r(N)
        quietly count if source_year==`y' & ei_gj_output_repaired<0 & !missing(ei_gj_output_repaired)
        local neg=r(N)
    }
    post `p' ("ei_gj_output_repaired") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(ei_money_output_repaired)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable ei_money_output_repaired
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & ei_money_output_repaired==0
        local zero=r(N)
        quietly count if source_year==`y' & ei_money_output_repaired<0 & !missing(ei_money_output_repaired)
        local neg=r(N)
    }
    post `p' ("ei_money_output_repaired") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_changed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_changed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_changed==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_changed<0 & !missing(energy_changed)
        local neg=r(N)
    }
    post `p' ("energy_changed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_cost_reported_complete)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_cost_reported_complete
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_cost_reported_complete==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_cost_reported_complete<0 & !missing(energy_cost_reported_complete)
        local neg=r(N)
    }
    post `p' ("energy_cost_reported_complete") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_cost_reported_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_cost_reported_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_cost_reported_n==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_cost_reported_n<0 & !missing(energy_cost_reported_n)
        local neg=r(N)
    }
    post `p' ("energy_cost_reported_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_cost_reported_partial)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_cost_reported_partial
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_cost_reported_partial==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_cost_reported_partial<0 & !missing(energy_cost_reported_partial)
        local neg=r(N)
    }
    post `p' ("energy_cost_reported_partial") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_den_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_den_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_den_state==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_den_state<0 & !missing(energy_den_state)
        local neg=r(N)
    }
    post `p' ("energy_den_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_eligible)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_eligible
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_eligible==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_eligible<0 & !missing(energy_eligible)
        local neg=r(N)
    }
    post `p' ("energy_eligible") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_exp_observed_repaired)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_exp_observed_repaired
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_exp_observed_repaired==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_exp_observed_repaired<0 & !missing(energy_exp_observed_repaired)
        local neg=r(N)
    }
    post `p' ("energy_exp_observed_repaired") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_legacy_ratio)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_legacy_ratio
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_legacy_ratio==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_legacy_ratio<0 & !missing(energy_legacy_ratio)
        local neg=r(N)
    }
    post `p' ("energy_legacy_ratio") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(energy_num_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable energy_num_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & energy_num_state==0
        local zero=r(N)
        quietly count if source_year==`y' & energy_num_state<0 & !missing(energy_num_state)
        local neg=r(N)
    }
    post `p' ("energy_num_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(legacy_price_tail_flag)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable legacy_price_tail_flag
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & legacy_price_tail_flag==0
        local zero=r(N)
        quietly count if source_year==`y' & legacy_price_tail_flag<0 & !missing(legacy_price_tail_flag)
        local neg=r(N)
    }
    post `p' ("legacy_price_tail_flag") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(monetary_changed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable monetary_changed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & monetary_changed==0
        local zero=r(N)
        quietly count if source_year==`y' & monetary_changed<0 & !missing(monetary_changed)
        local neg=r(N)
    }
    post `p' ("monetary_changed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(monetary_den_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable monetary_den_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & monetary_den_state==0
        local zero=r(N)
        quietly count if source_year==`y' & monetary_den_state<0 & !missing(monetary_den_state)
        local neg=r(N)
    }
    post `p' ("monetary_den_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(monetary_eligible)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable monetary_eligible
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & monetary_eligible==0
        local zero=r(N)
        quietly count if source_year==`y' & monetary_eligible<0 & !missing(monetary_eligible)
        local neg=r(N)
    }
    post `p' ("monetary_eligible") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(monetary_legacy_ratio)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable monetary_legacy_ratio
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & monetary_legacy_ratio==0
        local zero=r(N)
        quietly count if source_year==`y' & monetary_legacy_ratio<0 & !missing(monetary_legacy_ratio)
        local neg=r(N)
    }
    post `p' ("monetary_legacy_ratio") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(monetary_num_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable monetary_num_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & monetary_num_state==0
        local zero=r(N)
        quietly count if source_year==`y' & monetary_num_state<0 & !missing(monetary_num_state)
        local neg=r(N)
    }
    post `p' ("monetary_num_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(n_quantity_tests)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable n_quantity_tests
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & n_quantity_tests==0
        local zero=r(N)
        quietly count if source_year==`y' & n_quantity_tests<0 & !missing(n_quantity_tests)
        local neg=r(N)
    }
    post `p' ("n_quantity_tests") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(n_quantity_unknown)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable n_quantity_unknown
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & n_quantity_unknown==0
        local zero=r(N)
        quietly count if source_year==`y' & n_quantity_unknown<0 & !missing(n_quantity_unknown)
        local neg=r(N)
    }
    post `p' ("n_quantity_unknown") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(output_share_changed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable output_share_changed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & output_share_changed==0
        local zero=r(N)
        quietly count if source_year==`y' & output_share_changed<0 & !missing(output_share_changed)
        local neg=r(N)
    }
    post `p' ("output_share_changed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(output_share_den_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable output_share_den_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & output_share_den_state==0
        local zero=r(N)
        quietly count if source_year==`y' & output_share_den_state<0 & !missing(output_share_den_state)
        local neg=r(N)
    }
    post `p' ("output_share_den_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(output_share_eligible)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable output_share_eligible
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & output_share_eligible==0
        local zero=r(N)
        quietly count if source_year==`y' & output_share_eligible<0 & !missing(output_share_eligible)
        local neg=r(N)
    }
    post `p' ("output_share_eligible") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(output_share_legacy_ratio)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable output_share_legacy_ratio
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & output_share_legacy_ratio==0
        local zero=r(N)
        quietly count if source_year==`y' & output_share_legacy_ratio<0 & !missing(output_share_legacy_ratio)
        local neg=r(N)
    }
    post `p' ("output_share_legacy_ratio") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(output_share_num_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable output_share_num_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & output_share_num_state==0
        local zero=r(N)
        quietly count if source_year==`y' & output_share_num_state<0 & !missing(output_share_num_state)
        local neg=r(N)
    }
    post `p' ("output_share_num_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_flag_changed)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_flag_changed
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_flag_changed==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_flag_changed<0 & !missing(own_gen_flag_changed)
        local neg=r(N)
    }
    post `p' ("own_gen_flag_changed") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_legacy_flag)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_legacy_flag
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_legacy_flag==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_legacy_flag<0 & !missing(own_gen_legacy_flag)
        local neg=r(N)
    }
    post `p' ("own_gen_legacy_flag") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_observed_valid)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_observed_valid
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_observed_valid==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_observed_valid<0 & !missing(own_gen_observed_valid)
        local neg=r(N)
    }
    post `p' ("own_gen_observed_valid") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_positive_reported)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_positive_reported
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_positive_reported==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_positive_reported<0 & !missing(own_gen_positive_reported)
        local neg=r(N)
    }
    post `p' ("own_gen_positive_reported") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_source_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_source_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_source_state==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_source_state<0 & !missing(own_gen_source_state)
        local neg=r(N)
    }
    post `p' ("own_gen_source_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(own_gen_unknown)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable own_gen_unknown
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & own_gen_unknown==0
        local zero=r(N)
        quietly count if source_year==`y' & own_gen_unknown<0 & !missing(own_gen_unknown)
        local neg=r(N)
    }
    post `p' ("own_gen_unknown") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(price_tail_evaluated_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable price_tail_evaluated_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & price_tail_evaluated_n==0
        local zero=r(N)
        quietly count if source_year==`y' & price_tail_evaluated_n<0 & !missing(price_tail_evaluated_n)
        local neg=r(N)
    }
    post `p' ("price_tail_evaluated_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(price_tail_source_gate)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable price_tail_source_gate
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & price_tail_source_gate==0
        local zero=r(N)
        quietly count if source_year==`y' & price_tail_source_gate<0 & !missing(price_tail_source_gate)
        local neg=r(N)
    }
    post `p' ("price_tail_source_gate") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_elec_nonpln_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_elec_nonpln_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_elec_nonpln_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_elec_nonpln_kwh<0 & !missing(qn_elec_nonpln_kwh)
        local neg=r(N)
    }
    post `p' ("qn_elec_nonpln_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_elec_owngen_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_elec_owngen_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_elec_owngen_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_elec_owngen_kwh<0 & !missing(qn_elec_owngen_kwh)
        local neg=r(N)
    }
    post `p' ("qn_elec_owngen_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_elec_pln_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_elec_pln_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_elec_pln_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_elec_pln_kwh<0 & !missing(qn_elec_pln_kwh)
        local neg=r(N)
    }
    post `p' ("qn_elec_pln_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_biodiesel_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_biodiesel_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_biodiesel_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_biodiesel_ltr<0 & !missing(qn_fuel_biodiesel_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_biodiesel_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_biomass_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_biomass_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_biomass_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_biomass_kg<0 & !missing(qn_fuel_biomass_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_biomass_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_charcoal_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_charcoal_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_charcoal_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_charcoal_kg<0 & !missing(qn_fuel_charcoal_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_charcoal_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_citygas_m3)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_citygas_m3
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_citygas_m3==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_citygas_m3<0 & !missing(qn_fuel_citygas_m3)
        local neg=r(N)
    }
    post `p' ("qn_fuel_citygas_m3") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_coal_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_coal_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_coal_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_coal_kg<0 & !missing(qn_fuel_coal_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_coal_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_coalbriq_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_coalbriq_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_coalbriq_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_coalbriq_kg<0 & !missing(qn_fuel_coalbriq_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_coalbriq_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_coke_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_coke_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_coke_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_coke_kg<0 & !missing(qn_fuel_coke_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_coke_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_diesel_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_diesel_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_diesel_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_diesel_ltr<0 & !missing(qn_fuel_diesel_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_diesel_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_dieseloil_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_dieseloil_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_dieseloil_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_dieseloil_ltr<0 & !missing(qn_fuel_dieseloil_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_dieseloil_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_firewood_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_firewood_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_firewood_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_firewood_kg<0 & !missing(qn_fuel_firewood_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_firewood_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_fueloil_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_fueloil_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_fueloil_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_fueloil_ltr<0 & !missing(qn_fuel_fueloil_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_fueloil_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_kerosene_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_kerosene_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_kerosene_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_kerosene_ltr<0 & !missing(qn_fuel_kerosene_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_kerosene_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_lpg_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_lpg_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_lpg_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_lpg_kg<0 & !missing(qn_fuel_lpg_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_lpg_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_lubricant_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_lubricant_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_lubricant_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_lubricant_ltr<0 & !missing(qn_fuel_lubricant_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_lubricant_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_natgas_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_natgas_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_natgas_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_natgas_kg<0 & !missing(qn_fuel_natgas_kg)
        local neg=r(N)
    }
    post `p' ("qn_fuel_natgas_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_natgas_mmbtu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_natgas_mmbtu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_natgas_mmbtu==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_natgas_mmbtu<0 & !missing(qn_fuel_natgas_mmbtu)
        local neg=r(N)
    }
    post `p' ("qn_fuel_natgas_mmbtu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_othergas_m3)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_othergas_m3
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_othergas_m3==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_othergas_m3<0 & !missing(qn_fuel_othergas_m3)
        local neg=r(N)
    }
    post `p' ("qn_fuel_othergas_m3") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qn_fuel_petrol_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qn_fuel_petrol_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qn_fuel_petrol_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qn_fuel_petrol_ltr<0 & !missing(qn_fuel_petrol_ltr)
        local neg=r(N)
    }
    post `p' ("qn_fuel_petrol_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_elec_nonpln_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_elec_nonpln_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_elec_nonpln_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_elec_nonpln_kwh<0 & !missing(qs_elec_nonpln_kwh)
        local neg=r(N)
    }
    post `p' ("qs_elec_nonpln_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_elec_owngen_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_elec_owngen_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_elec_owngen_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_elec_owngen_kwh<0 & !missing(qs_elec_owngen_kwh)
        local neg=r(N)
    }
    post `p' ("qs_elec_owngen_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_elec_pln_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_elec_pln_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_elec_pln_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_elec_pln_kwh<0 & !missing(qs_elec_pln_kwh)
        local neg=r(N)
    }
    post `p' ("qs_elec_pln_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_biodiesel_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_biodiesel_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_biodiesel_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_biodiesel_ltr<0 & !missing(qs_fuel_biodiesel_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_biodiesel_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_biomass_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_biomass_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_biomass_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_biomass_kg<0 & !missing(qs_fuel_biomass_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_biomass_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_charcoal_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_charcoal_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_charcoal_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_charcoal_kg<0 & !missing(qs_fuel_charcoal_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_charcoal_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_citygas_m3)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_citygas_m3
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_citygas_m3==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_citygas_m3<0 & !missing(qs_fuel_citygas_m3)
        local neg=r(N)
    }
    post `p' ("qs_fuel_citygas_m3") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_coal_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_coal_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_coal_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_coal_kg<0 & !missing(qs_fuel_coal_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_coal_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_coalbriq_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_coalbriq_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_coalbriq_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_coalbriq_kg<0 & !missing(qs_fuel_coalbriq_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_coalbriq_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_coke_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_coke_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_coke_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_coke_kg<0 & !missing(qs_fuel_coke_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_coke_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_diesel_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_diesel_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_diesel_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_diesel_ltr<0 & !missing(qs_fuel_diesel_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_diesel_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_dieseloil_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_dieseloil_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_dieseloil_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_dieseloil_ltr<0 & !missing(qs_fuel_dieseloil_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_dieseloil_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_firewood_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_firewood_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_firewood_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_firewood_kg<0 & !missing(qs_fuel_firewood_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_firewood_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_fueloil_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_fueloil_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_fueloil_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_fueloil_ltr<0 & !missing(qs_fuel_fueloil_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_fueloil_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_kerosene_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_kerosene_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_kerosene_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_kerosene_ltr<0 & !missing(qs_fuel_kerosene_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_kerosene_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_lpg_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_lpg_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_lpg_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_lpg_kg<0 & !missing(qs_fuel_lpg_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_lpg_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_lubricant_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_lubricant_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_lubricant_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_lubricant_ltr<0 & !missing(qs_fuel_lubricant_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_lubricant_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_natgas_kg)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_natgas_kg
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_natgas_kg==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_natgas_kg<0 & !missing(qs_fuel_natgas_kg)
        local neg=r(N)
    }
    post `p' ("qs_fuel_natgas_kg") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_natgas_mmbtu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_natgas_mmbtu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_natgas_mmbtu==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_natgas_mmbtu<0 & !missing(qs_fuel_natgas_mmbtu)
        local neg=r(N)
    }
    post `p' ("qs_fuel_natgas_mmbtu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_othergas_m3)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_othergas_m3
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_othergas_m3==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_othergas_m3<0 & !missing(qs_fuel_othergas_m3)
        local neg=r(N)
    }
    post `p' ("qs_fuel_othergas_m3") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(qs_fuel_petrol_ltr)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable qs_fuel_petrol_ltr
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & qs_fuel_petrol_ltr==0
        local zero=r(N)
        quietly count if source_year==`y' & qs_fuel_petrol_ltr<0 & !missing(qs_fuel_petrol_ltr)
        local neg=r(N)
    }
    post `p' ("qs_fuel_petrol_ltr") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_capital_additions_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_capital_additions_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_capital_additions_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & r_capital_additions_per_worker<0 & !missing(r_capital_additions_per_worker)
        local neg=r(N)
    }
    post `p' ("r_capital_additions_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_capital_per_worker_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_capital_per_worker_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_capital_per_worker_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_capital_per_worker_nominal<0 & !missing(r_capital_per_worker_nominal)
        local neg=r(N)
    }
    post `p' ("r_capital_per_worker_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_capital_stock_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_capital_stock_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_capital_stock_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & r_capital_stock_per_worker<0 & !missing(r_capital_stock_per_worker)
        local neg=r(N)
    }
    post `p' ("r_capital_stock_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_capital_stock_per_worker_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_capital_stock_per_worker_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_capital_stock_per_worker_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_capital_stock_per_worker_state<0 & !missing(r_capital_stock_per_worker_state)
        local neg=r(N)
    }
    post `p' ("r_capital_stock_per_worker_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_per_worker<0 & !missing(r_co2_per_worker)
        local neg=r(N)
    }
    post `p' ("r_co2_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_per_worker_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_per_worker_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_per_worker_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_per_worker_state<0 & !missing(r_co2_per_worker_state)
        local neg=r(N)
    }
    post `p' ("r_co2_per_worker_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_scope1_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_scope1_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_scope1_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_scope1_s1<0 & !missing(r_co2_scope1_s1)
        local neg=r(N)
    }
    post `p' ("r_co2_scope1_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_scope1_s1_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_scope1_s1_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_scope1_s1_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_scope1_s1_n<0 & !missing(r_co2_scope1_s1_n)
        local neg=r(N)
    }
    post `p' ("r_co2_scope1_s1_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_scope2_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_scope2_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_scope2_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_scope2_s1<0 & !missing(r_co2_scope2_s1)
        local neg=r(N)
    }
    post `p' ("r_co2_scope2_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_scope2_s1_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_scope2_s1_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_scope2_s1_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_scope2_s1_n<0 & !missing(r_co2_scope2_s1_n)
        local neg=r(N)
    }
    post `p' ("r_co2_scope2_s1_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_total_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_total_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_total_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_total_s1<0 & !missing(r_co2_total_s1)
        local neg=r(N)
    }
    post `p' ("r_co2_total_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_co2_total_s1_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_co2_total_s1_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_co2_total_s1_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_co2_total_s1_n<0 & !missing(r_co2_total_s1_n)
        local neg=r(N)
    }
    post `p' ("r_co2_total_s1_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_elec_purchased_kwh)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_elec_purchased_kwh
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_elec_purchased_kwh==0
        local zero=r(N)
        quietly count if source_year==`y' & r_elec_purchased_kwh<0 & !missing(r_elec_purchased_kwh)
        local neg=r(N)
    }
    post `p' ("r_elec_purchased_kwh") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_elec_purchased_kwh_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_elec_purchased_kwh_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_elec_purchased_kwh_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_elec_purchased_kwh_n<0 & !missing(r_elec_purchased_kwh_n)
        local neg=r(N)
    }
    post `p' ("r_elec_purchased_kwh_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_energy_cost_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_energy_cost_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_energy_cost_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & r_energy_cost_per_worker<0 & !missing(r_energy_cost_per_worker)
        local neg=r(N)
    }
    post `p' ("r_energy_cost_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_energy_cost_per_worker_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_energy_cost_per_worker_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_energy_cost_per_worker_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_energy_cost_per_worker_state<0 & !missing(r_energy_cost_per_worker_state)
        local neg=r(N)
    }
    post `p' ("r_energy_cost_per_worker_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_gj_electricity)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_gj_electricity
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_gj_electricity==0
        local zero=r(N)
        quietly count if source_year==`y' & r_gj_electricity<0 & !missing(r_gj_electricity)
        local neg=r(N)
    }
    post `p' ("r_gj_electricity") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_gj_electricity_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_gj_electricity_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_gj_electricity_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_gj_electricity_n<0 & !missing(r_gj_electricity_n)
        local neg=r(N)
    }
    post `p' ("r_gj_electricity_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_gj_fuel_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_gj_fuel_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_gj_fuel_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_gj_fuel_s1<0 & !missing(r_gj_fuel_s1)
        local neg=r(N)
    }
    post `p' ("r_gj_fuel_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_gj_fuel_s1_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_gj_fuel_s1_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_gj_fuel_s1_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_gj_fuel_s1_n<0 & !missing(r_gj_fuel_s1_n)
        local neg=r(N)
    }
    post `p' ("r_gj_fuel_s1_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_inputs_per_worker_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_inputs_per_worker_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_inputs_per_worker_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_inputs_per_worker_nominal<0 & !missing(r_inputs_per_worker_nominal)
        local neg=r(N)
    }
    post `p' ("r_inputs_per_worker_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_labor_productivity_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_labor_productivity_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_labor_productivity_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_labor_productivity_nominal<0 & !missing(r_labor_productivity_nominal)
        local neg=r(N)
    }
    post `p' ("r_labor_productivity_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_capital_additions_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_capital_additions_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_capital_additions_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_capital_additions_nominal<0 & !missing(r_ln_capital_additions_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_capital_additions_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_capital_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_capital_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_capital_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_capital_nominal<0 & !missing(r_ln_capital_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_capital_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_capital_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_capital_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_capital_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_capital_nominal_state<0 & !missing(r_ln_capital_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_capital_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_capital_stock_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_capital_stock_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_capital_stock_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_capital_stock_nominal<0 & !missing(r_ln_capital_stock_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_capital_stock_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_capital_stock_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_capital_stock_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_capital_stock_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_capital_stock_nominal_state<0 & !missing(r_ln_capital_stock_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_capital_stock_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_co2_total_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_co2_total_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_co2_total_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_co2_total_s1<0 & !missing(r_ln_co2_total_s1)
        local neg=r(N)
    }
    post `p' ("r_ln_co2_total_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_co2_total_s1_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_co2_total_s1_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_co2_total_s1_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_co2_total_s1_state<0 & !missing(r_ln_co2_total_s1_state)
        local neg=r(N)
    }
    post `p' ("r_ln_co2_total_s1_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_energy_expenditure)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_energy_expenditure
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_energy_expenditure==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_energy_expenditure<0 & !missing(r_ln_energy_expenditure)
        local neg=r(N)
    }
    post `p' ("r_ln_energy_expenditure") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_energy_expenditure_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_energy_expenditure_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_energy_expenditure_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_energy_expenditure_state<0 & !missing(r_ln_energy_expenditure_state)
        local neg=r(N)
    }
    post `p' ("r_ln_energy_expenditure_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_import_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_import_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_import_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_import_nominal<0 & !missing(r_ln_import_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_import_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_import_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_import_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_import_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_import_nominal_state<0 & !missing(r_ln_import_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_import_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_inputs_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_inputs_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_inputs_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_inputs_nominal<0 & !missing(r_ln_inputs_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_inputs_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_inputs_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_inputs_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_inputs_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_inputs_nominal_state<0 & !missing(r_ln_inputs_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_inputs_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_output_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_output_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_output_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_output_nominal<0 & !missing(r_ln_output_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_output_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_output_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_output_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_output_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_output_nominal_state<0 & !missing(r_ln_output_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_output_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_rd_cost_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_rd_cost_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_rd_cost_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_rd_cost_nominal<0 & !missing(r_ln_rd_cost_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_rd_cost_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_rd_cost_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_rd_cost_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_rd_cost_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_rd_cost_nominal_state<0 & !missing(r_ln_rd_cost_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_rd_cost_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_total_gj_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_total_gj_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_total_gj_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_total_gj_s1<0 & !missing(r_ln_total_gj_s1)
        local neg=r(N)
    }
    post `p' ("r_ln_total_gj_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_total_gj_s1_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_total_gj_s1_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_total_gj_s1_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_total_gj_s1_state<0 & !missing(r_ln_total_gj_s1_state)
        local neg=r(N)
    }
    post `p' ("r_ln_total_gj_s1_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_va_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_va_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_va_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_va_nominal<0 & !missing(r_ln_va_nominal)
        local neg=r(N)
    }
    post `p' ("r_ln_va_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_va_nominal_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_va_nominal_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_va_nominal_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_va_nominal_state<0 & !missing(r_ln_va_nominal_state)
        local neg=r(N)
    }
    post `p' ("r_ln_va_nominal_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbdacu<0 & !missing(r_ln_val_cbdacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbdacu_state<0 & !missing(r_ln_val_cbdacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbfpcu<0 & !missing(r_ln_val_cbfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbfpcu_state<0 & !missing(r_ln_val_cbfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbsacu<0 & !missing(r_ln_val_cbsacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbsacu_state<0 & !missing(r_ln_val_cbsacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbttcu<0 & !missing(r_ln_val_cbttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cbttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cbttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cbttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cbttcu_state<0 & !missing(r_ln_val_cbttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cbttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cldacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cldacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cldacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cldacu<0 & !missing(r_ln_val_cldacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cldacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cldacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cldacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cldacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cldacu_state<0 & !missing(r_ln_val_cldacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cldacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clfpcu<0 & !missing(r_ln_val_clfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clfpcu_state<0 & !missing(r_ln_val_clfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clsacu<0 & !missing(r_ln_val_clsacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clsacu_state<0 & !missing(r_ln_val_clsacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clttcu<0 & !missing(r_ln_val_clttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_clttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_clttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_clttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_clttcu_state<0 & !missing(r_ln_val_clttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_clttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmdacu<0 & !missing(r_ln_val_cmdacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmdacu_state<0 & !missing(r_ln_val_cmdacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmfpcu<0 & !missing(r_ln_val_cmfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmfpcu_state<0 & !missing(r_ln_val_cmfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmsacu<0 & !missing(r_ln_val_cmsacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmsacu_state<0 & !missing(r_ln_val_cmsacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmttcu<0 & !missing(r_ln_val_cmttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cmttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cmttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cmttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cmttcu_state<0 & !missing(r_ln_val_cmttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cmttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_codacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_codacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_codacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_codacu<0 & !missing(r_ln_val_codacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_codacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_codacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_codacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_codacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_codacu_state<0 & !missing(r_ln_val_codacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_codacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cofpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cofpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cofpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cofpcu<0 & !missing(r_ln_val_cofpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cofpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cofpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cofpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cofpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cofpcu_state<0 & !missing(r_ln_val_cofpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cofpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cosacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cosacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cosacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cosacu<0 & !missing(r_ln_val_cosacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cosacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cosacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cosacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cosacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cosacu_state<0 & !missing(r_ln_val_cosacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cosacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_costrd)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_costrd
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_costrd==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_costrd<0 & !missing(r_ln_val_costrd)
        local neg=r(N)
    }
    post `p' ("r_ln_val_costrd") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_costrd_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_costrd_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_costrd_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_costrd_state<0 & !missing(r_ln_val_costrd_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_costrd_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cottcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cottcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cottcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cottcu<0 & !missing(r_ln_val_cottcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cottcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cottcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cottcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cottcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cottcu_state<0 & !missing(r_ln_val_cottcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cottcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csdacu<0 & !missing(r_ln_val_csdacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csdacu_state<0 & !missing(r_ln_val_csdacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csfpcu<0 & !missing(r_ln_val_csfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csfpcu_state<0 & !missing(r_ln_val_csfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cssacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cssacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cssacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cssacu<0 & !missing(r_ln_val_cssacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cssacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cssacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cssacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cssacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cssacu_state<0 & !missing(r_ln_val_cssacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cssacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csttcu<0 & !missing(r_ln_val_csttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_csttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_csttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_csttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_csttcu_state<0 & !missing(r_ln_val_csttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_csttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctdacu<0 & !missing(r_ln_val_ctdacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctdacu_state<0 & !missing(r_ln_val_ctdacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctfpcu<0 & !missing(r_ln_val_ctfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctfpcu_state<0 & !missing(r_ln_val_ctfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctsacu<0 & !missing(r_ln_val_ctsacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctsacu_state<0 & !missing(r_ln_val_ctsacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cttcu<0 & !missing(r_ln_val_cttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cttcu_state<0 & !missing(r_ln_val_cttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctttcu<0 & !missing(r_ln_val_ctttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ctttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ctttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ctttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ctttcu_state<0 & !missing(r_ln_val_ctttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ctttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvdacu<0 & !missing(r_ln_val_cvdacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvdacu_state<0 & !missing(r_ln_val_cvdacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvfpcu<0 & !missing(r_ln_val_cvfpcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvfpcu_state<0 & !missing(r_ln_val_cvfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvsacu<0 & !missing(r_ln_val_cvsacu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvsacu_state<0 & !missing(r_ln_val_cvsacu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvttcu<0 & !missing(r_ln_val_cvttcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_cvttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_cvttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_cvttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_cvttcu_state<0 & !missing(r_ln_val_cvttcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_cvttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_devvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_devvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_devvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_devvcu<0 & !missing(r_ln_val_devvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_devvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_devvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_devvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_devvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_devvcu_state<0 & !missing(r_ln_val_devvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_devvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecavce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecavce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecavce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecavce<0 & !missing(r_ln_val_ecavce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecavce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecavce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecavce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecavce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecavce_state<0 & !missing(r_ln_val_ecavce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecavce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecavcu<0 & !missing(r_ln_val_ecavcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecavcu_state<0 & !missing(r_ln_val_ecavcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecbvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecbvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecbvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecbvce<0 & !missing(r_ln_val_ecbvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecbvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecbvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecbvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecbvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecbvce_state<0 & !missing(r_ln_val_ecbvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecbvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecbvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecbvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecbvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecbvcu<0 & !missing(r_ln_val_ecbvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecbvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ecbvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ecbvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ecbvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ecbvcu_state<0 & !missing(r_ln_val_ecbvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ecbvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eckvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eckvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eckvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eckvce<0 & !missing(r_ln_val_eckvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eckvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eckvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eckvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eckvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eckvce_state<0 & !missing(r_ln_val_eckvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eckvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eckvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eckvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eckvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eckvcu<0 & !missing(r_ln_val_eckvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eckvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eckvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eckvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eckvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eckvcu_state<0 & !missing(r_ln_val_eckvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eckvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eclvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eclvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eclvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eclvce<0 & !missing(r_ln_val_eclvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eclvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eclvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eclvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eclvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eclvce_state<0 & !missing(r_ln_val_eclvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eclvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eclvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eclvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eclvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eclvcu<0 & !missing(r_ln_val_eclvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eclvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eclvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eclvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eclvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eclvcu_state<0 & !missing(r_ln_val_eclvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eclvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_edivce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_edivce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_edivce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_edivce<0 & !missing(r_ln_val_edivce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_edivce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_edivce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_edivce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_edivce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_edivce_state<0 & !missing(r_ln_val_edivce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_edivce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_edivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_edivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_edivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_edivcu<0 & !missing(r_ln_val_edivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_edivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_edivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_edivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_edivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_edivcu_state<0 & !missing(r_ln_val_edivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_edivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efovce<0 & !missing(r_ln_val_efovce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efovce_state<0 & !missing(r_ln_val_efovce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efovcu<0 & !missing(r_ln_val_efovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efovcu_state<0 & !missing(r_ln_val_efovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efuvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efuvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efuvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efuvce<0 & !missing(r_ln_val_efuvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efuvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efuvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efuvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efuvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efuvce_state<0 & !missing(r_ln_val_efuvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efuvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efuvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efuvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efuvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efuvcu<0 & !missing(r_ln_val_efuvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efuvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_efuvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_efuvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_efuvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_efuvcu_state<0 & !missing(r_ln_val_efuvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_efuvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egavce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egavce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egavce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egavce<0 & !missing(r_ln_val_egavce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egavce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egavce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egavce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egavce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egavce_state<0 & !missing(r_ln_val_egavce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egavce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egavcu<0 & !missing(r_ln_val_egavcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egavcu_state<0 & !missing(r_ln_val_egavcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egovce<0 & !missing(r_ln_val_egovce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egovce_state<0 & !missing(r_ln_val_egovce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egovcu<0 & !missing(r_ln_val_egovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_egovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_egovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_egovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_egovcu_state<0 & !missing(r_ln_val_egovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_egovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_elpvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_elpvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_elpvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_elpvce<0 & !missing(r_ln_val_elpvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_elpvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_elpvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_elpvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_elpvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_elpvce_state<0 & !missing(r_ln_val_elpvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_elpvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_elpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_elpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_elpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_elpvcu<0 & !missing(r_ln_val_elpvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_elpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_elpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_elpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_elpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_elpvcu_state<0 & !missing(r_ln_val_elpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_elpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eluvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eluvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eluvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eluvce<0 & !missing(r_ln_val_eluvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eluvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eluvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eluvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eluvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eluvce_state<0 & !missing(r_ln_val_eluvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eluvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eluvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eluvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eluvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eluvcu<0 & !missing(r_ln_val_eluvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eluvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eluvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eluvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eluvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eluvcu_state<0 & !missing(r_ln_val_eluvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eluvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_encvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_encvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_encvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_encvce<0 & !missing(r_ln_val_encvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_encvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_encvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_encvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_encvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_encvce_state<0 & !missing(r_ln_val_encvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_encvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_encvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_encvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_encvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_encvcu<0 & !missing(r_ln_val_encvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_encvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_encvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_encvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_encvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_encvcu_state<0 & !missing(r_ln_val_encvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_encvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_engvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_engvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_engvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_engvce<0 & !missing(r_ln_val_engvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_engvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_engvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_engvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_engvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_engvce_state<0 & !missing(r_ln_val_engvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_engvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_engvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_engvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_engvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_engvcu<0 & !missing(r_ln_val_engvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_engvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_engvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_engvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_engvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_engvcu_state<0 & !missing(r_ln_val_engvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_engvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_enpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_enpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_enpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_enpvcu<0 & !missing(r_ln_val_enpvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_enpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_enpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_enpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_enpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_enpvcu_state<0 & !missing(r_ln_val_enpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_enpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eoivce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eoivce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eoivce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eoivce<0 & !missing(r_ln_val_eoivce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eoivce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eoivce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eoivce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eoivce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eoivce_state<0 & !missing(r_ln_val_eoivce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eoivce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eoivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eoivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eoivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eoivcu<0 & !missing(r_ln_val_eoivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eoivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eoivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eoivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eoivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eoivcu_state<0 & !missing(r_ln_val_eoivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eoivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_epevce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_epevce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_epevce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_epevce<0 & !missing(r_ln_val_epevce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_epevce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_epevce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_epevce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_epevce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_epevce_state<0 & !missing(r_ln_val_epevce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_epevce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_epevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_epevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_epevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_epevcu<0 & !missing(r_ln_val_epevcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_epevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_epevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_epevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_epevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_epevcu_state<0 & !missing(r_ln_val_epevcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_epevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eplvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eplvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eplvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eplvcu<0 & !missing(r_ln_val_eplvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eplvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_eplvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_eplvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_eplvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_eplvcu_state<0 & !missing(r_ln_val_eplvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_eplvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esdvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esdvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esdvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esdvce<0 & !missing(r_ln_val_esdvce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esdvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esdvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esdvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esdvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esdvce_state<0 & !missing(r_ln_val_esdvce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esdvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esdvcu<0 & !missing(r_ln_val_esdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esdvcu_state<0 & !missing(r_ln_val_esdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esovce<0 & !missing(r_ln_val_esovce)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esovce_state<0 & !missing(r_ln_val_esovce_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esovcu<0 & !missing(r_ln_val_esovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_esovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_esovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_esovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_esovcu_state<0 & !missing(r_ln_val_esovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_esovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ibrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ibrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ibrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ibrvcu<0 & !missing(r_ln_val_ibrvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ibrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ibrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ibrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ibrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ibrvcu_state<0 & !missing(r_ln_val_ibrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ibrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_icovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_icovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_icovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_icovcu<0 & !missing(r_ln_val_icovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_icovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_icovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_icovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_icovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_icovcu_state<0 & !missing(r_ln_val_icovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_icovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_idevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_idevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_idevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_idevcu<0 & !missing(r_ln_val_idevcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_idevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_idevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_idevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_idevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_idevcu_state<0 & !missing(r_ln_val_idevcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_idevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iinput)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iinput
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iinput==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iinput<0 & !missing(r_ln_val_iinput)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iinput") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iinput_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iinput_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iinput_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iinput_state<0 & !missing(r_ln_val_iinput_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iinput_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iinvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iinvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iinvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iinvcu<0 & !missing(r_ln_val_iinvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iinvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iinvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iinvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iinvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iinvcu_state<0 & !missing(r_ln_val_iinvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iinvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iisfov)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iisfov
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iisfov==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iisfov<0 & !missing(r_ln_val_iisfov)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iisfov") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iisfov_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iisfov_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iisfov_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iisfov_state<0 & !missing(r_ln_val_iisfov_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iisfov_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iislov)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iislov
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iislov==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iislov<0 & !missing(r_ln_val_iislov)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iislov") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iislov_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iislov_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iislov_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iislov_state<0 & !missing(r_ln_val_iislov_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iislov_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iisvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iisvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iisvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iisvcu<0 & !missing(r_ln_val_iisvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iisvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iisvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iisvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iisvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iisvcu_state<0 & !missing(r_ln_val_iisvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iisvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ikivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ikivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ikivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ikivcu<0 & !missing(r_ln_val_ikivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ikivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ikivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ikivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ikivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ikivcu_state<0 & !missing(r_ln_val_ikivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ikivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iklvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iklvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iklvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iklvcu<0 & !missing(r_ln_val_iklvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iklvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iklvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iklvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iklvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iklvcu_state<0 & !missing(r_ln_val_iklvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iklvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ikovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ikovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ikovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ikovcu<0 & !missing(r_ln_val_ikovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ikovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ikovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ikovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ikovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ikovcu_state<0 & !missing(r_ln_val_ikovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ikovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ilrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ilrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ilrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ilrvcu<0 & !missing(r_ln_val_ilrvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ilrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ilrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ilrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ilrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ilrvcu_state<0 & !missing(r_ln_val_ilrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ilrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_insvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_insvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_insvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_insvcu<0 & !missing(r_ln_val_insvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_insvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_insvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_insvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_insvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_insvcu_state<0 & !missing(r_ln_val_insvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_insvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_intvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_intvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_intvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_intvcu<0 & !missing(r_ln_val_intvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_intvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_intvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_intvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_intvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_intvcu_state<0 & !missing(r_ln_val_intvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_intvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iotvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iotvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iotvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iotvcu<0 & !missing(r_ln_val_iotvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iotvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iotvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iotvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iotvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iotvcu_state<0 & !missing(r_ln_val_iotvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iotvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ipkvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ipkvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ipkvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ipkvcu<0 & !missing(r_ln_val_ipkvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ipkvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ipkvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ipkvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ipkvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ipkvcu_state<0 & !missing(r_ln_val_ipkvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ipkvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iprvcu<0 & !missing(r_ln_val_iprvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iprvcu_state<0 & !missing(r_ln_val_iprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irdvcu<0 & !missing(r_ln_val_irdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irdvcu_state<0 & !missing(r_ln_val_irdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irevcu<0 & !missing(r_ln_val_irevcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irevcu_state<0 & !missing(r_ln_val_irevcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irrvcu<0 & !missing(r_ln_val_irrvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_irrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_irrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_irrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_irrvcu_state<0 & !missing(r_ln_val_irrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_irrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_itxvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_itxvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_itxvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_itxvcu<0 & !missing(r_ln_val_itxvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_itxvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_itxvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_itxvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_itxvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_itxvcu_state<0 & !missing(r_ln_val_itxvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_itxvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iuwvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iuwvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iuwvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iuwvcu<0 & !missing(r_ln_val_iuwvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iuwvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_iuwvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_iuwvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_iuwvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_iuwvcu_state<0 & !missing(r_ln_val_iuwvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_iuwvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_nopvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_nopvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_nopvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_nopvcu<0 & !missing(r_ln_val_nopvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_nopvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_nopvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_nopvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_nopvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_nopvcu_state<0 & !missing(r_ln_val_nopvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_nopvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_othvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_othvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_othvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_othvcu<0 & !missing(r_ln_val_othvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_othvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_othvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_othvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_othvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_othvcu_state<0 & !missing(r_ln_val_othvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_othvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_output)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_output
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_output==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_output<0 & !missing(r_ln_val_output)
        local neg=r(N)
    }
    post `p' ("r_ln_val_output") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_output_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_output_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_output_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_output_state<0 & !missing(r_ln_val_output_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_output_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rdnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rdnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rdnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rdnvcu<0 & !missing(r_ln_val_rdnvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rdnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rdnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rdnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rdnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rdnvcu_state<0 & !missing(r_ln_val_rdnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rdnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_renvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_renvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_renvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_renvcu<0 & !missing(r_ln_val_renvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_renvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_renvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_renvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_renvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_renvcu_state<0 & !missing(r_ln_val_renvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_renvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rimvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rimvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rimvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rimvcu<0 & !missing(r_ln_val_rimvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rimvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rimvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rimvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rimvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rimvcu_state<0 & !missing(r_ln_val_rimvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rimvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rtlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rtlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rtlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rtlvcu<0 & !missing(r_ln_val_rtlvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rtlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_rtlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_rtlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_rtlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_rtlvcu_state<0 & !missing(r_ln_val_rtlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_rtlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfbvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfbvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfbvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfbvcu<0 & !missing(r_ln_val_sfbvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfbvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfbvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfbvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfbvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfbvcu_state<0 & !missing(r_ln_val_sfbvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfbvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfcvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfcvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfcvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfcvcu<0 & !missing(r_ln_val_sfcvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfcvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfcvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfcvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfcvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfcvcu_state<0 & !missing(r_ln_val_sfcvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfcvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfdvcu<0 & !missing(r_ln_val_sfdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfdvcu_state<0 & !missing(r_ln_val_sfdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfgvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfgvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfgvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfgvcu<0 & !missing(r_ln_val_sfgvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfgvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfgvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfgvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfgvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfgvcu_state<0 & !missing(r_ln_val_sfgvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfgvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfjvcu<0 & !missing(r_ln_val_sfjvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfjvcu_state<0 & !missing(r_ln_val_sfjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfkvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfkvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfkvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfkvcu<0 & !missing(r_ln_val_sfkvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfkvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfkvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfkvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfkvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfkvcu_state<0 & !missing(r_ln_val_sfkvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfkvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfnvcu<0 & !missing(r_ln_val_sfnvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfnvcu_state<0 & !missing(r_ln_val_sfnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfovcu<0 & !missing(r_ln_val_sfovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfovcu_state<0 & !missing(r_ln_val_sfovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfrvcu<0 & !missing(r_ln_val_sfrvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfrvcu_state<0 & !missing(r_ln_val_sfrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfsvcu<0 & !missing(r_ln_val_sfsvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfsvcu_state<0 & !missing(r_ln_val_sfsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfuvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfuvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfuvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfuvcu<0 & !missing(r_ln_val_sfuvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfuvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_sfuvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_sfuvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_sfuvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_sfuvcu_state<0 & !missing(r_ln_val_sfuvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_sfuvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shdvcu<0 & !missing(r_ln_val_shdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shdvcu_state<0 & !missing(r_ln_val_shdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shfvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shfvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shfvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shfvcu<0 & !missing(r_ln_val_shfvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shfvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shfvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shfvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shfvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shfvcu_state<0 & !missing(r_ln_val_shfvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shfvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shjvcu<0 & !missing(r_ln_val_shjvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_shjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_shjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_shjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_shjvcu_state<0 & !missing(r_ln_val_shjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_shjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srdvcu<0 & !missing(r_ln_val_srdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srdvcu_state<0 & !missing(r_ln_val_srdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srjvcu<0 & !missing(r_ln_val_srjvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srjvcu_state<0 & !missing(r_ln_val_srjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srmvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srmvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srmvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srmvcu<0 & !missing(r_ln_val_srmvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srmvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_srmvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_srmvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_srmvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_srmvcu_state<0 & !missing(r_ln_val_srmvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_srmvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stdvcu<0 & !missing(r_ln_val_stdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stdvcu_state<0 & !missing(r_ln_val_stdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stjvcu<0 & !missing(r_ln_val_stjvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stjvcu_state<0 & !missing(r_ln_val_stjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stlvcu<0 & !missing(r_ln_val_stlvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_stlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_stlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_stlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_stlvcu_state<0 & !missing(r_ln_val_stlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_stlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_vtlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_vtlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_vtlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_vtlvcu<0 & !missing(r_ln_val_vtlvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_vtlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_vtlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_vtlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_vtlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_vtlvcu_state<0 & !missing(r_ln_val_vtlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_vtlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yelvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yelvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yelvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yelvcu<0 & !missing(r_ln_val_yelvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yelvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yelvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yelvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yelvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yelvcu_state<0 & !missing(r_ln_val_yelvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yelvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvcu<0 & !missing(r_ln_val_yisvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvcu_state<0 & !missing(r_ln_val_yisvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvdo)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvdo
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvdo==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvdo<0 & !missing(r_ln_val_yisvdo)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvdo") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvdo_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvdo_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvdo_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvdo_state<0 & !missing(r_ln_val_yisvdo_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvdo_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvfo)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvfo
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvfo==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvfo<0 & !missing(r_ln_val_yisvfo)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvfo") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yisvfo_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yisvfo_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yisvfo_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yisvfo_state<0 & !missing(r_ln_val_yisvfo_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yisvfo_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykdvcu<0 & !missing(r_ln_val_ykdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykdvcu_state<0 & !missing(r_ln_val_ykdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykfvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykfvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykfvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykfvcu<0 & !missing(r_ln_val_ykfvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykfvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykfvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykfvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykfvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykfvcu_state<0 & !missing(r_ln_val_ykfvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykfvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykivcu<0 & !missing(r_ln_val_ykivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ykivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ykivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ykivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ykivcu_state<0 & !missing(r_ln_val_ykivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ykivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yprvcu<0 & !missing(r_ln_val_yprvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yprvcu_state<0 & !missing(r_ln_val_yprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yrnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yrnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yrnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yrnvcu<0 & !missing(r_ln_val_yrnvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yrnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yrnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yrnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yrnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yrnvcu_state<0 & !missing(r_ln_val_yrnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yrnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yrsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yrsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yrsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yrsvcu<0 & !missing(r_ln_val_yrsvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yrsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_yrsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_yrsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_yrsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_yrsvcu_state<0 & !missing(r_ln_val_yrsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_yrsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ysnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ysnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ysnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ysnvcu<0 & !missing(r_ln_val_ysnvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ysnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ysnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ysnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ysnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ysnvcu_state<0 & !missing(r_ln_val_ysnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ysnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ytovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ytovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ytovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ytovcu<0 & !missing(r_ln_val_ytovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ytovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_ytovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_ytovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_ytovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_ytovcu_state<0 & !missing(r_ln_val_ytovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_ytovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znavcu<0 & !missing(r_ln_val_znavcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znavcu_state<0 & !missing(r_ln_val_znavcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zndvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zndvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zndvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zndvcu<0 & !missing(r_ln_val_zndvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zndvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zndvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zndvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zndvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zndvcu_state<0 & !missing(r_ln_val_zndvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zndvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znevcu<0 & !missing(r_ln_val_znevcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znevcu_state<0 & !missing(r_ln_val_znevcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znhvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znhvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znhvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znhvcu<0 & !missing(r_ln_val_znhvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znhvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znhvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znhvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znhvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znhvcu_state<0 & !missing(r_ln_val_znhvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znhvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znivcu<0 & !missing(r_ln_val_znivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znivcu_state<0 & !missing(r_ln_val_znivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znovcu<0 & !missing(r_ln_val_znovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znovcu_state<0 & !missing(r_ln_val_znovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znpvcu<0 & !missing(r_ln_val_znpvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znpvcu_state<0 & !missing(r_ln_val_znpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znrvcu<0 & !missing(r_ln_val_znrvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znrvcu_state<0 & !missing(r_ln_val_znrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znsvcu<0 & !missing(r_ln_val_znsvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_znsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_znsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_znsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_znsvcu_state<0 & !missing(r_ln_val_znsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_znsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zntvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zntvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zntvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zntvcu<0 & !missing(r_ln_val_zntvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zntvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zntvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zntvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zntvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zntvcu_state<0 & !missing(r_ln_val_zntvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zntvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpavcu<0 & !missing(r_ln_val_zpavcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpavcu_state<0 & !missing(r_ln_val_zpavcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpdvcu<0 & !missing(r_ln_val_zpdvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpdvcu_state<0 & !missing(r_ln_val_zpdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpevcu<0 & !missing(r_ln_val_zpevcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpevcu_state<0 & !missing(r_ln_val_zpevcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zphvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zphvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zphvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zphvcu<0 & !missing(r_ln_val_zphvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zphvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zphvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zphvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zphvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zphvcu_state<0 & !missing(r_ln_val_zphvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zphvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpivcu<0 & !missing(r_ln_val_zpivcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpivcu_state<0 & !missing(r_ln_val_zpivcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpovcu<0 & !missing(r_ln_val_zpovcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpovcu_state<0 & !missing(r_ln_val_zpovcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zppvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zppvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zppvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zppvcu<0 & !missing(r_ln_val_zppvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zppvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zppvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zppvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zppvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zppvcu_state<0 & !missing(r_ln_val_zppvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zppvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zprvcu<0 & !missing(r_ln_val_zprvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zprvcu_state<0 & !missing(r_ln_val_zprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpsvcu<0 & !missing(r_ln_val_zpsvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zpsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zpsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zpsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zpsvcu_state<0 & !missing(r_ln_val_zpsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zpsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zptvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zptvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zptvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zptvcu<0 & !missing(r_ln_val_zptvcu)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zptvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_val_zptvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_val_zptvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_val_zptvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_val_zptvcu_state<0 & !missing(r_ln_val_zptvcu_state)
        local neg=r(N)
    }
    post `p' ("r_ln_val_zptvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_workers)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_workers
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_workers==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_workers<0 & !missing(r_ln_workers)
        local neg=r(N)
    }
    post `p' ("r_ln_workers") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_ln_workers_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_ln_workers_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_ln_workers_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_ln_workers_state<0 & !missing(r_ln_workers_state)
        local neg=r(N)
    }
    post `p' ("r_ln_workers_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_output_per_worker_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_output_per_worker_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_output_per_worker_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_output_per_worker_nominal<0 & !missing(r_output_per_worker_nominal)
        local neg=r(N)
    }
    post `p' ("r_output_per_worker_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbdacu<0 & !missing(r_pw_val_cbdacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbdacu_state<0 & !missing(r_pw_val_cbdacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbfpcu<0 & !missing(r_pw_val_cbfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbfpcu_state<0 & !missing(r_pw_val_cbfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbsacu<0 & !missing(r_pw_val_cbsacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbsacu_state<0 & !missing(r_pw_val_cbsacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbttcu<0 & !missing(r_pw_val_cbttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cbttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cbttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cbttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cbttcu_state<0 & !missing(r_pw_val_cbttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cbttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cldacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cldacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cldacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cldacu<0 & !missing(r_pw_val_cldacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cldacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cldacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cldacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cldacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cldacu_state<0 & !missing(r_pw_val_cldacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cldacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clfpcu<0 & !missing(r_pw_val_clfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clfpcu_state<0 & !missing(r_pw_val_clfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clsacu<0 & !missing(r_pw_val_clsacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clsacu_state<0 & !missing(r_pw_val_clsacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clttcu<0 & !missing(r_pw_val_clttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_clttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_clttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_clttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_clttcu_state<0 & !missing(r_pw_val_clttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_clttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmdacu<0 & !missing(r_pw_val_cmdacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmdacu_state<0 & !missing(r_pw_val_cmdacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmfpcu<0 & !missing(r_pw_val_cmfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmfpcu_state<0 & !missing(r_pw_val_cmfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmsacu<0 & !missing(r_pw_val_cmsacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmsacu_state<0 & !missing(r_pw_val_cmsacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmttcu<0 & !missing(r_pw_val_cmttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cmttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cmttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cmttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cmttcu_state<0 & !missing(r_pw_val_cmttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cmttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_codacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_codacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_codacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_codacu<0 & !missing(r_pw_val_codacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_codacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_codacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_codacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_codacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_codacu_state<0 & !missing(r_pw_val_codacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_codacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cofpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cofpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cofpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cofpcu<0 & !missing(r_pw_val_cofpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cofpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cofpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cofpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cofpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cofpcu_state<0 & !missing(r_pw_val_cofpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cofpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cosacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cosacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cosacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cosacu<0 & !missing(r_pw_val_cosacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cosacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cosacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cosacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cosacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cosacu_state<0 & !missing(r_pw_val_cosacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cosacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_costrd)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_costrd
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_costrd==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_costrd<0 & !missing(r_pw_val_costrd)
        local neg=r(N)
    }
    post `p' ("r_pw_val_costrd") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_costrd_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_costrd_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_costrd_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_costrd_state<0 & !missing(r_pw_val_costrd_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_costrd_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cottcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cottcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cottcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cottcu<0 & !missing(r_pw_val_cottcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cottcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cottcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cottcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cottcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cottcu_state<0 & !missing(r_pw_val_cottcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cottcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csdacu<0 & !missing(r_pw_val_csdacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csdacu_state<0 & !missing(r_pw_val_csdacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csfpcu<0 & !missing(r_pw_val_csfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csfpcu_state<0 & !missing(r_pw_val_csfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cssacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cssacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cssacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cssacu<0 & !missing(r_pw_val_cssacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cssacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cssacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cssacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cssacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cssacu_state<0 & !missing(r_pw_val_cssacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cssacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csttcu<0 & !missing(r_pw_val_csttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_csttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_csttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_csttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_csttcu_state<0 & !missing(r_pw_val_csttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_csttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctdacu<0 & !missing(r_pw_val_ctdacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctdacu_state<0 & !missing(r_pw_val_ctdacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctfpcu<0 & !missing(r_pw_val_ctfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctfpcu_state<0 & !missing(r_pw_val_ctfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctsacu<0 & !missing(r_pw_val_ctsacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctsacu_state<0 & !missing(r_pw_val_ctsacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cttcu<0 & !missing(r_pw_val_cttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cttcu_state<0 & !missing(r_pw_val_cttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctttcu<0 & !missing(r_pw_val_ctttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ctttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ctttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ctttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ctttcu_state<0 & !missing(r_pw_val_ctttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ctttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvdacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvdacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvdacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvdacu<0 & !missing(r_pw_val_cvdacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvdacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvdacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvdacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvdacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvdacu_state<0 & !missing(r_pw_val_cvdacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvdacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvfpcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvfpcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvfpcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvfpcu<0 & !missing(r_pw_val_cvfpcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvfpcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvfpcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvfpcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvfpcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvfpcu_state<0 & !missing(r_pw_val_cvfpcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvfpcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvsacu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvsacu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvsacu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvsacu<0 & !missing(r_pw_val_cvsacu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvsacu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvsacu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvsacu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvsacu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvsacu_state<0 & !missing(r_pw_val_cvsacu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvsacu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvttcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvttcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvttcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvttcu<0 & !missing(r_pw_val_cvttcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvttcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_cvttcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_cvttcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_cvttcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_cvttcu_state<0 & !missing(r_pw_val_cvttcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_cvttcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_devvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_devvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_devvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_devvcu<0 & !missing(r_pw_val_devvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_devvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_devvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_devvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_devvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_devvcu_state<0 & !missing(r_pw_val_devvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_devvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecavce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecavce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecavce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecavce<0 & !missing(r_pw_val_ecavce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecavce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecavce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecavce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecavce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecavce_state<0 & !missing(r_pw_val_ecavce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecavce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecavcu<0 & !missing(r_pw_val_ecavcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecavcu_state<0 & !missing(r_pw_val_ecavcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecbvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecbvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecbvce<0 & !missing(r_pw_val_ecbvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecbvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecbvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecbvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecbvce_state<0 & !missing(r_pw_val_ecbvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecbvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecbvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecbvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecbvcu<0 & !missing(r_pw_val_ecbvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecbvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ecbvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ecbvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ecbvcu_state<0 & !missing(r_pw_val_ecbvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ecbvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eckvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eckvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eckvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eckvce<0 & !missing(r_pw_val_eckvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eckvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eckvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eckvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eckvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eckvce_state<0 & !missing(r_pw_val_eckvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eckvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eckvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eckvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eckvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eckvcu<0 & !missing(r_pw_val_eckvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eckvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eckvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eckvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eckvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eckvcu_state<0 & !missing(r_pw_val_eckvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eckvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eclvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eclvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eclvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eclvce<0 & !missing(r_pw_val_eclvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eclvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eclvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eclvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eclvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eclvce_state<0 & !missing(r_pw_val_eclvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eclvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eclvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eclvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eclvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eclvcu<0 & !missing(r_pw_val_eclvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eclvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eclvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eclvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eclvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eclvcu_state<0 & !missing(r_pw_val_eclvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eclvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_edivce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_edivce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_edivce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_edivce<0 & !missing(r_pw_val_edivce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_edivce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_edivce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_edivce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_edivce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_edivce_state<0 & !missing(r_pw_val_edivce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_edivce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_edivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_edivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_edivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_edivcu<0 & !missing(r_pw_val_edivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_edivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_edivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_edivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_edivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_edivcu_state<0 & !missing(r_pw_val_edivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_edivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efovce<0 & !missing(r_pw_val_efovce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efovce_state<0 & !missing(r_pw_val_efovce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efovcu<0 & !missing(r_pw_val_efovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efovcu_state<0 & !missing(r_pw_val_efovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efuvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efuvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efuvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efuvce<0 & !missing(r_pw_val_efuvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efuvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efuvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efuvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efuvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efuvce_state<0 & !missing(r_pw_val_efuvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efuvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efuvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efuvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efuvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efuvcu<0 & !missing(r_pw_val_efuvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efuvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_efuvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_efuvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_efuvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_efuvcu_state<0 & !missing(r_pw_val_efuvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_efuvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egavce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egavce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egavce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egavce<0 & !missing(r_pw_val_egavce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egavce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egavce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egavce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egavce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egavce_state<0 & !missing(r_pw_val_egavce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egavce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egavcu<0 & !missing(r_pw_val_egavcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egavcu_state<0 & !missing(r_pw_val_egavcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egovce<0 & !missing(r_pw_val_egovce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egovce_state<0 & !missing(r_pw_val_egovce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egovcu<0 & !missing(r_pw_val_egovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_egovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_egovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_egovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_egovcu_state<0 & !missing(r_pw_val_egovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_egovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_elpvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_elpvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_elpvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_elpvce<0 & !missing(r_pw_val_elpvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_elpvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_elpvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_elpvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_elpvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_elpvce_state<0 & !missing(r_pw_val_elpvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_elpvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_elpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_elpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_elpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_elpvcu<0 & !missing(r_pw_val_elpvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_elpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_elpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_elpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_elpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_elpvcu_state<0 & !missing(r_pw_val_elpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_elpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eluvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eluvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eluvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eluvce<0 & !missing(r_pw_val_eluvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eluvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eluvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eluvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eluvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eluvce_state<0 & !missing(r_pw_val_eluvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eluvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eluvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eluvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eluvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eluvcu<0 & !missing(r_pw_val_eluvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eluvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eluvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eluvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eluvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eluvcu_state<0 & !missing(r_pw_val_eluvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eluvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_encvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_encvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_encvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_encvce<0 & !missing(r_pw_val_encvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_encvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_encvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_encvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_encvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_encvce_state<0 & !missing(r_pw_val_encvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_encvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_encvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_encvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_encvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_encvcu<0 & !missing(r_pw_val_encvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_encvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_encvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_encvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_encvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_encvcu_state<0 & !missing(r_pw_val_encvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_encvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_engvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_engvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_engvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_engvce<0 & !missing(r_pw_val_engvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_engvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_engvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_engvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_engvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_engvce_state<0 & !missing(r_pw_val_engvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_engvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_engvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_engvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_engvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_engvcu<0 & !missing(r_pw_val_engvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_engvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_engvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_engvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_engvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_engvcu_state<0 & !missing(r_pw_val_engvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_engvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_enpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_enpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_enpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_enpvcu<0 & !missing(r_pw_val_enpvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_enpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_enpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_enpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_enpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_enpvcu_state<0 & !missing(r_pw_val_enpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_enpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eoivce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eoivce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eoivce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eoivce<0 & !missing(r_pw_val_eoivce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eoivce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eoivce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eoivce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eoivce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eoivce_state<0 & !missing(r_pw_val_eoivce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eoivce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eoivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eoivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eoivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eoivcu<0 & !missing(r_pw_val_eoivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eoivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eoivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eoivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eoivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eoivcu_state<0 & !missing(r_pw_val_eoivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eoivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_epevce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_epevce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_epevce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_epevce<0 & !missing(r_pw_val_epevce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_epevce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_epevce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_epevce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_epevce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_epevce_state<0 & !missing(r_pw_val_epevce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_epevce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_epevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_epevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_epevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_epevcu<0 & !missing(r_pw_val_epevcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_epevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_epevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_epevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_epevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_epevcu_state<0 & !missing(r_pw_val_epevcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_epevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eplvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eplvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eplvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eplvcu<0 & !missing(r_pw_val_eplvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eplvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_eplvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_eplvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_eplvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_eplvcu_state<0 & !missing(r_pw_val_eplvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_eplvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esdvce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esdvce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esdvce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esdvce<0 & !missing(r_pw_val_esdvce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esdvce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esdvce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esdvce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esdvce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esdvce_state<0 & !missing(r_pw_val_esdvce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esdvce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esdvcu<0 & !missing(r_pw_val_esdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esdvcu_state<0 & !missing(r_pw_val_esdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esovce)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esovce
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esovce==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esovce<0 & !missing(r_pw_val_esovce)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esovce") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esovce_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esovce_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esovce_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esovce_state<0 & !missing(r_pw_val_esovce_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esovce_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esovcu<0 & !missing(r_pw_val_esovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_esovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_esovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_esovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_esovcu_state<0 & !missing(r_pw_val_esovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_esovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ibrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ibrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ibrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ibrvcu<0 & !missing(r_pw_val_ibrvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ibrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ibrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ibrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ibrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ibrvcu_state<0 & !missing(r_pw_val_ibrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ibrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_icovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_icovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_icovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_icovcu<0 & !missing(r_pw_val_icovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_icovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_icovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_icovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_icovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_icovcu_state<0 & !missing(r_pw_val_icovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_icovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_idevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_idevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_idevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_idevcu<0 & !missing(r_pw_val_idevcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_idevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_idevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_idevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_idevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_idevcu_state<0 & !missing(r_pw_val_idevcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_idevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iinput)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iinput
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iinput==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iinput<0 & !missing(r_pw_val_iinput)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iinput") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iinput_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iinput_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iinput_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iinput_state<0 & !missing(r_pw_val_iinput_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iinput_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iinvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iinvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iinvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iinvcu<0 & !missing(r_pw_val_iinvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iinvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iinvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iinvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iinvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iinvcu_state<0 & !missing(r_pw_val_iinvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iinvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iisfov)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iisfov
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iisfov==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iisfov<0 & !missing(r_pw_val_iisfov)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iisfov") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iisfov_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iisfov_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iisfov_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iisfov_state<0 & !missing(r_pw_val_iisfov_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iisfov_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iislov)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iislov
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iislov==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iislov<0 & !missing(r_pw_val_iislov)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iislov") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iislov_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iislov_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iislov_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iislov_state<0 & !missing(r_pw_val_iislov_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iislov_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iisvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iisvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iisvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iisvcu<0 & !missing(r_pw_val_iisvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iisvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iisvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iisvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iisvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iisvcu_state<0 & !missing(r_pw_val_iisvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iisvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ikivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ikivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ikivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ikivcu<0 & !missing(r_pw_val_ikivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ikivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ikivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ikivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ikivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ikivcu_state<0 & !missing(r_pw_val_ikivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ikivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iklvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iklvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iklvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iklvcu<0 & !missing(r_pw_val_iklvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iklvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iklvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iklvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iklvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iklvcu_state<0 & !missing(r_pw_val_iklvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iklvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ikovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ikovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ikovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ikovcu<0 & !missing(r_pw_val_ikovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ikovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ikovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ikovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ikovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ikovcu_state<0 & !missing(r_pw_val_ikovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ikovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ilrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ilrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ilrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ilrvcu<0 & !missing(r_pw_val_ilrvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ilrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ilrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ilrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ilrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ilrvcu_state<0 & !missing(r_pw_val_ilrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ilrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_insvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_insvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_insvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_insvcu<0 & !missing(r_pw_val_insvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_insvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_insvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_insvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_insvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_insvcu_state<0 & !missing(r_pw_val_insvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_insvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_intvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_intvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_intvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_intvcu<0 & !missing(r_pw_val_intvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_intvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_intvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_intvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_intvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_intvcu_state<0 & !missing(r_pw_val_intvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_intvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iotvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iotvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iotvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iotvcu<0 & !missing(r_pw_val_iotvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iotvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iotvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iotvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iotvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iotvcu_state<0 & !missing(r_pw_val_iotvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iotvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ipkvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ipkvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ipkvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ipkvcu<0 & !missing(r_pw_val_ipkvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ipkvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ipkvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ipkvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ipkvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ipkvcu_state<0 & !missing(r_pw_val_ipkvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ipkvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iprvcu<0 & !missing(r_pw_val_iprvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iprvcu_state<0 & !missing(r_pw_val_iprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irdvcu<0 & !missing(r_pw_val_irdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irdvcu_state<0 & !missing(r_pw_val_irdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irevcu<0 & !missing(r_pw_val_irevcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irevcu_state<0 & !missing(r_pw_val_irevcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irrvcu<0 & !missing(r_pw_val_irrvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_irrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_irrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_irrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_irrvcu_state<0 & !missing(r_pw_val_irrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_irrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_itxvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_itxvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_itxvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_itxvcu<0 & !missing(r_pw_val_itxvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_itxvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_itxvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_itxvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_itxvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_itxvcu_state<0 & !missing(r_pw_val_itxvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_itxvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iuwvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iuwvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iuwvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iuwvcu<0 & !missing(r_pw_val_iuwvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iuwvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_iuwvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_iuwvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_iuwvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_iuwvcu_state<0 & !missing(r_pw_val_iuwvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_iuwvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_nopvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_nopvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_nopvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_nopvcu<0 & !missing(r_pw_val_nopvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_nopvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_nopvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_nopvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_nopvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_nopvcu_state<0 & !missing(r_pw_val_nopvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_nopvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_othvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_othvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_othvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_othvcu<0 & !missing(r_pw_val_othvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_othvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_othvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_othvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_othvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_othvcu_state<0 & !missing(r_pw_val_othvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_othvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_output)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_output
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_output==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_output<0 & !missing(r_pw_val_output)
        local neg=r(N)
    }
    post `p' ("r_pw_val_output") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_output_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_output_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_output_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_output_state<0 & !missing(r_pw_val_output_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_output_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rdnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rdnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rdnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rdnvcu<0 & !missing(r_pw_val_rdnvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rdnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rdnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rdnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rdnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rdnvcu_state<0 & !missing(r_pw_val_rdnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rdnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_renvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_renvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_renvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_renvcu<0 & !missing(r_pw_val_renvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_renvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_renvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_renvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_renvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_renvcu_state<0 & !missing(r_pw_val_renvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_renvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rimvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rimvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rimvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rimvcu<0 & !missing(r_pw_val_rimvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rimvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rimvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rimvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rimvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rimvcu_state<0 & !missing(r_pw_val_rimvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rimvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rtlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rtlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rtlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rtlvcu<0 & !missing(r_pw_val_rtlvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rtlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_rtlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_rtlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_rtlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_rtlvcu_state<0 & !missing(r_pw_val_rtlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_rtlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfbvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfbvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfbvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfbvcu<0 & !missing(r_pw_val_sfbvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfbvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfbvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfbvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfbvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfbvcu_state<0 & !missing(r_pw_val_sfbvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfbvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfcvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfcvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfcvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfcvcu<0 & !missing(r_pw_val_sfcvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfcvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfcvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfcvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfcvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfcvcu_state<0 & !missing(r_pw_val_sfcvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfcvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfdvcu<0 & !missing(r_pw_val_sfdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfdvcu_state<0 & !missing(r_pw_val_sfdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfgvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfgvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfgvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfgvcu<0 & !missing(r_pw_val_sfgvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfgvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfgvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfgvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfgvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfgvcu_state<0 & !missing(r_pw_val_sfgvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfgvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfjvcu<0 & !missing(r_pw_val_sfjvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfjvcu_state<0 & !missing(r_pw_val_sfjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfkvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfkvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfkvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfkvcu<0 & !missing(r_pw_val_sfkvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfkvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfkvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfkvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfkvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfkvcu_state<0 & !missing(r_pw_val_sfkvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfkvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfnvcu<0 & !missing(r_pw_val_sfnvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfnvcu_state<0 & !missing(r_pw_val_sfnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfovcu<0 & !missing(r_pw_val_sfovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfovcu_state<0 & !missing(r_pw_val_sfovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfrvcu<0 & !missing(r_pw_val_sfrvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfrvcu_state<0 & !missing(r_pw_val_sfrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfsvcu<0 & !missing(r_pw_val_sfsvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfsvcu_state<0 & !missing(r_pw_val_sfsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfuvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfuvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfuvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfuvcu<0 & !missing(r_pw_val_sfuvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfuvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_sfuvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_sfuvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_sfuvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_sfuvcu_state<0 & !missing(r_pw_val_sfuvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_sfuvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shdvcu<0 & !missing(r_pw_val_shdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shdvcu_state<0 & !missing(r_pw_val_shdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shfvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shfvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shfvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shfvcu<0 & !missing(r_pw_val_shfvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shfvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shfvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shfvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shfvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shfvcu_state<0 & !missing(r_pw_val_shfvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shfvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shjvcu<0 & !missing(r_pw_val_shjvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_shjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_shjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_shjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_shjvcu_state<0 & !missing(r_pw_val_shjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_shjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srdvcu<0 & !missing(r_pw_val_srdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srdvcu_state<0 & !missing(r_pw_val_srdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srjvcu<0 & !missing(r_pw_val_srjvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srjvcu_state<0 & !missing(r_pw_val_srjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srmvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srmvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srmvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srmvcu<0 & !missing(r_pw_val_srmvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srmvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_srmvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_srmvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_srmvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_srmvcu_state<0 & !missing(r_pw_val_srmvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_srmvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stdvcu<0 & !missing(r_pw_val_stdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stdvcu_state<0 & !missing(r_pw_val_stdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stjvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stjvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stjvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stjvcu<0 & !missing(r_pw_val_stjvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stjvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stjvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stjvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stjvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stjvcu_state<0 & !missing(r_pw_val_stjvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stjvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stlvcu<0 & !missing(r_pw_val_stlvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_stlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_stlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_stlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_stlvcu_state<0 & !missing(r_pw_val_stlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_stlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_vtlvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_vtlvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_vtlvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_vtlvcu<0 & !missing(r_pw_val_vtlvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_vtlvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_vtlvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_vtlvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_vtlvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_vtlvcu_state<0 & !missing(r_pw_val_vtlvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_vtlvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yelvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yelvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yelvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yelvcu<0 & !missing(r_pw_val_yelvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yelvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yelvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yelvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yelvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yelvcu_state<0 & !missing(r_pw_val_yelvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yelvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvcu<0 & !missing(r_pw_val_yisvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvcu_state<0 & !missing(r_pw_val_yisvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvdo)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvdo
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvdo==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvdo<0 & !missing(r_pw_val_yisvdo)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvdo") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvdo_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvdo_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvdo_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvdo_state<0 & !missing(r_pw_val_yisvdo_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvdo_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvfo)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvfo
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvfo==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvfo<0 & !missing(r_pw_val_yisvfo)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvfo") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yisvfo_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yisvfo_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yisvfo_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yisvfo_state<0 & !missing(r_pw_val_yisvfo_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yisvfo_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykdvcu<0 & !missing(r_pw_val_ykdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykdvcu_state<0 & !missing(r_pw_val_ykdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykfvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykfvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykfvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykfvcu<0 & !missing(r_pw_val_ykfvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykfvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykfvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykfvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykfvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykfvcu_state<0 & !missing(r_pw_val_ykfvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykfvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykivcu<0 & !missing(r_pw_val_ykivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ykivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ykivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ykivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ykivcu_state<0 & !missing(r_pw_val_ykivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ykivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yprvcu<0 & !missing(r_pw_val_yprvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yprvcu_state<0 & !missing(r_pw_val_yprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yrnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yrnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yrnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yrnvcu<0 & !missing(r_pw_val_yrnvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yrnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yrnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yrnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yrnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yrnvcu_state<0 & !missing(r_pw_val_yrnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yrnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yrsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yrsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yrsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yrsvcu<0 & !missing(r_pw_val_yrsvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yrsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_yrsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_yrsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_yrsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_yrsvcu_state<0 & !missing(r_pw_val_yrsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_yrsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ysnvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ysnvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ysnvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ysnvcu<0 & !missing(r_pw_val_ysnvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ysnvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ysnvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ysnvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ysnvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ysnvcu_state<0 & !missing(r_pw_val_ysnvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ysnvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ytovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ytovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ytovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ytovcu<0 & !missing(r_pw_val_ytovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ytovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_ytovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_ytovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_ytovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_ytovcu_state<0 & !missing(r_pw_val_ytovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_ytovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znavcu<0 & !missing(r_pw_val_znavcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znavcu_state<0 & !missing(r_pw_val_znavcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zndvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zndvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zndvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zndvcu<0 & !missing(r_pw_val_zndvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zndvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zndvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zndvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zndvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zndvcu_state<0 & !missing(r_pw_val_zndvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zndvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znevcu<0 & !missing(r_pw_val_znevcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znevcu_state<0 & !missing(r_pw_val_znevcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znhvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znhvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znhvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znhvcu<0 & !missing(r_pw_val_znhvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znhvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znhvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znhvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znhvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znhvcu_state<0 & !missing(r_pw_val_znhvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znhvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znivcu<0 & !missing(r_pw_val_znivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znivcu_state<0 & !missing(r_pw_val_znivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znovcu<0 & !missing(r_pw_val_znovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znovcu_state<0 & !missing(r_pw_val_znovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znpvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znpvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znpvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znpvcu<0 & !missing(r_pw_val_znpvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znpvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znpvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znpvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znpvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znpvcu_state<0 & !missing(r_pw_val_znpvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znpvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znrvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znrvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znrvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znrvcu<0 & !missing(r_pw_val_znrvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znrvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znrvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znrvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znrvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znrvcu_state<0 & !missing(r_pw_val_znrvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znrvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znsvcu<0 & !missing(r_pw_val_znsvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_znsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_znsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_znsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_znsvcu_state<0 & !missing(r_pw_val_znsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_znsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zntvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zntvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zntvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zntvcu<0 & !missing(r_pw_val_zntvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zntvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zntvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zntvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zntvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zntvcu_state<0 & !missing(r_pw_val_zntvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zntvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpavcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpavcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpavcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpavcu<0 & !missing(r_pw_val_zpavcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpavcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpavcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpavcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpavcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpavcu_state<0 & !missing(r_pw_val_zpavcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpavcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpdvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpdvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpdvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpdvcu<0 & !missing(r_pw_val_zpdvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpdvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpdvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpdvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpdvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpdvcu_state<0 & !missing(r_pw_val_zpdvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpdvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpevcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpevcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpevcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpevcu<0 & !missing(r_pw_val_zpevcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpevcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpevcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpevcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpevcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpevcu_state<0 & !missing(r_pw_val_zpevcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpevcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zphvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zphvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zphvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zphvcu<0 & !missing(r_pw_val_zphvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zphvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zphvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zphvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zphvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zphvcu_state<0 & !missing(r_pw_val_zphvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zphvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpivcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpivcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpivcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpivcu<0 & !missing(r_pw_val_zpivcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpivcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpivcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpivcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpivcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpivcu_state<0 & !missing(r_pw_val_zpivcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpivcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpovcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpovcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpovcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpovcu<0 & !missing(r_pw_val_zpovcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpovcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpovcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpovcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpovcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpovcu_state<0 & !missing(r_pw_val_zpovcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpovcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zppvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zppvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zppvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zppvcu<0 & !missing(r_pw_val_zppvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zppvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zppvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zppvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zppvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zppvcu_state<0 & !missing(r_pw_val_zppvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zppvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zprvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zprvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zprvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zprvcu<0 & !missing(r_pw_val_zprvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zprvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zprvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zprvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zprvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zprvcu_state<0 & !missing(r_pw_val_zprvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zprvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpsvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpsvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpsvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpsvcu<0 & !missing(r_pw_val_zpsvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpsvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zpsvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zpsvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zpsvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zpsvcu_state<0 & !missing(r_pw_val_zpsvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zpsvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zptvcu)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zptvcu
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zptvcu==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zptvcu<0 & !missing(r_pw_val_zptvcu)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zptvcu") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_pw_val_zptvcu_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_pw_val_zptvcu_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_pw_val_zptvcu_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_pw_val_zptvcu_state<0 & !missing(r_pw_val_zptvcu_state)
        local neg=r(N)
    }
    post `p' ("r_pw_val_zptvcu_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_rd_cost_per_worker_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_rd_cost_per_worker_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_rd_cost_per_worker_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & r_rd_cost_per_worker_nominal<0 & !missing(r_rd_cost_per_worker_nominal)
        local neg=r(N)
    }
    post `p' ("r_rd_cost_per_worker_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_total_gj_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_total_gj_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_total_gj_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & r_total_gj_per_worker<0 & !missing(r_total_gj_per_worker)
        local neg=r(N)
    }
    post `p' ("r_total_gj_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_total_gj_per_worker_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_total_gj_per_worker_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_total_gj_per_worker_state==0
        local zero=r(N)
        quietly count if source_year==`y' & r_total_gj_per_worker_state<0 & !missing(r_total_gj_per_worker_state)
        local neg=r(N)
    }
    post `p' ("r_total_gj_per_worker_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_total_gj_s1)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_total_gj_s1
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_total_gj_s1==0
        local zero=r(N)
        quietly count if source_year==`y' & r_total_gj_s1<0 & !missing(r_total_gj_s1)
        local neg=r(N)
    }
    post `p' ("r_total_gj_s1") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(r_total_gj_s1_n)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable r_total_gj_s1_n
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & r_total_gj_s1_n==0
        local zero=r(N)
        quietly count if source_year==`y' & r_total_gj_s1_n<0 & !missing(r_total_gj_s1_n)
        local neg=r(N)
    }
    post `p' ("r_total_gj_s1_n") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_abs_tail_flag)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_abs_tail_flag
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_abs_tail_flag==0
        local zero=r(N)
        quietly count if source_year==`y' & va_abs_tail_flag<0 & !missing(va_abs_tail_flag)
        local neg=r(N)
    }
    post `p' ("va_abs_tail_flag") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_log_positive)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_log_positive
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_log_positive==0
        local zero=r(N)
        quietly count if source_year==`y' & va_log_positive<0 & !missing(va_log_positive)
        local neg=r(N)
    }
    post `p' ("va_log_positive") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_missing_reason)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_missing_reason
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_missing_reason==0
        local zero=r(N)
        quietly count if source_year==`y' & va_missing_reason<0 & !missing(va_missing_reason)
        local neg=r(N)
    }
    post `p' ("va_missing_reason") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_share_output_repaired)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_share_output_repaired
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_share_output_repaired==0
        local zero=r(N)
        quietly count if source_year==`y' & va_share_output_repaired<0 & !missing(va_share_output_repaired)
        local neg=r(N)
    }
    post `p' ("va_share_output_repaired") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_signed_eligible)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_signed_eligible
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_signed_eligible==0
        local zero=r(N)
        quietly count if source_year==`y' & va_signed_eligible<0 & !missing(va_signed_eligible)
        local neg=r(N)
    }
    post `p' ("va_signed_eligible") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_signed_nominal)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_signed_nominal
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_signed_nominal==0
        local zero=r(N)
        quietly count if source_year==`y' & va_signed_nominal<0 & !missing(va_signed_nominal)
        local neg=r(N)
    }
    post `p' ("va_signed_nominal") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_signed_per_worker)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_signed_per_worker
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_signed_per_worker==0
        local zero=r(N)
        quietly count if source_year==`y' & va_signed_per_worker<0 & !missing(va_signed_per_worker)
        local neg=r(N)
    }
    post `p' ("va_signed_per_worker") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_signed_tail_sensitivity)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_signed_tail_sensitivity
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_signed_tail_sensitivity==0
        local zero=r(N)
        quietly count if source_year==`y' & va_signed_tail_sensitivity<0 & !missing(va_signed_tail_sensitivity)
        local neg=r(N)
    }
    post `p' ("va_signed_tail_sensitivity") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & !missing(va_source_state)
    local n=r(N)
    local zero=.
    local neg=.
    capture confirm numeric variable va_source_state
* Isi blok hanya dijalankan bila bukan _rc. // WFDOC-INJECTED
    if !_rc {
        quietly count if source_year==`y' & va_source_state==0
        local zero=r(N)
        quietly count if source_year==`y' & va_source_state<0 & !missing(va_source_state)
        local neg=r(N)
    }
    post `p' ("va_source_state") (`y') (`total') (`n') (`total'-`n') (`zero') (`neg') ("arithmetic_companion; no_admission")
}
postclose `p'
use "corrections/reports/__new_coverage.dta", clear
append using `old'
isid variable source_year
assert observed+missing_rows==rows
generate long verified_definition_n=.
generate long numeric_domain_n=.
generate long provisional_n=.
generate long absent_n=.
generate str50 source_gate="numeric_presence_is_not_semantic_verification"
generate str120 domain_status="Global numeric/semantic/absence domains unavailable without field-specific accepted registry; counts not inferred"
save "corrections/reports/variable_year_acceptance.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X04"
capture log close G0CHILD
