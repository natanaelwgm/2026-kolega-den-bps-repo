* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta; dag/data/word_data/G0/variable_year/mapped_fields.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_verified_20260910.dta; dag/reports/word_data/G0/20260910-code-verification/corrected_variable_coverage.csv; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:step-version" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 1 389 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:step-version" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 1 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L2:step-clear" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 2 389 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L2:step-clear" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 2 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L3:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 3 389 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L3:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 3 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L4:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 4 389 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L4:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 4 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L5:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 5 389 `=_rc' // WFLOG-INJECTED
set maxvar 10000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L5:step-set" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 5 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L6:step-args" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 6 389 `=_rc' // WFLOG-INJECTED
args root baseline
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L6:step-args" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 6 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L7:step-cd" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 7 389 `=_rc' // WFLOG-INJECTED
cd "`root'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L7:step-cd" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 7 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:step-if" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 8 389 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila `"`baseline'"' sama dengan "". // WFDOC-INJECTED
if `"`baseline'"'=="" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L9:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
 display as error "WF_EXPLICIT_REGENERATED_BASELINE_REQUIRED"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L9:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L10:step-exit" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
 exit 198
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L10:step-exit" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:block-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L8:step-if" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 8 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L12:step-global" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 9 389 `=_rc' // WFLOG-INJECTED
global G0V "dag/reports/word_data/G0/20260910-code-verification"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L12:step-global" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 9 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L13:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 10 389 `=_rc' // WFLOG-INJECTED
capture log close _all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L13:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 10 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L14:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 11 389 `=_rc' // WFLOG-INJECTED
log using "$G0V/candidate_integration.log", text replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L14:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 11 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L15:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 12 389 `=_rc' // WFLOG-INJECTED
use "`baseline'", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L15:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 12 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L16:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 13 389 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L16:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 13 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L17:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 14 389 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L17:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 14 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L18:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 15 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_rd_cost_mislabelled=rd_cost_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L18:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 15 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L19:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 16 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_export_share_flag=export_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L19:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 16 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L20:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 17 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_total_gj_s1=total_gj_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L20:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 17 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L21:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 18 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_co2_total_s1=co2_total_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L21:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 18 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L22:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 19 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_fuel_coal_alias=fuel_coal_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L22:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 19 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L23:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 20 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_fuel_coke_alias=fuel_coke_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L23:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 20 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L24:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 21 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_fuel_natgas_alias=fuel_natgas_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L24:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 21 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L25:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 22 389 `=_rc' // WFLOG-INJECTED
clonevar legacy_fuel_charcoal_alias=fuel_charcoal_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L25:step-clonevar" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 22 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L26:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 23 389 `=_rc' // WFLOG-INJECTED
drop amdal_raw b3wste_raw capital_additions_nominal capital_nominal capital_stock_nominal district_code elec_nonpln_kwh elec_nonpln_rp000 elec_owngen_kwh elec_pln_kwh elec_pln_rp000 export_binary_raw export_share_pct foreign_ownership_pct fuel_biodiesel_ltr fuel_biodiesel_rp000 fuel_charcoal_kg fuel_charcoal_rp000 fuel_citygas_m3 fuel_citygas_rp000 fuel_coal_kg fuel_coal_rp000 fuel_coalbriq_kg fuel_coalbriq_rp000 fuel_coke_kg fuel_coke_rp000 fuel_diesel_ltr fuel_diesel_rp000 fuel_dieseloil_ltr fuel_dieseloil_rp000 fuel_firewood_kg fuel_firewood_rp000 fuel_fueloil_ltr fuel_fueloil_rp000 fuel_kerosene_ltr fuel_kerosene_rp000 fuel_lpg_kg fuel_lpg_rp000 fuel_lubricant_ltr fuel_lubricant_rp000 fuel_natgas_kg fuel_natgas_rp000 fuel_other_rp000 fuel_othergas_m3 fuel_othergas_rp000 fuel_petrol_ltr fuel_petrol_rp000 fuel_total_reported_rp000 gross_output_nominal import_value_nominal industry_code innovation_marketing_raw innovation_org_raw innovation_process_raw innovation_product_raw innovation_raw inspli_raw intermediate_inputs_nominal liwste_raw pplihi_raw production_workers province_code rd_cost_nominal rd_indicator_raw rd_workers source_id_raw sowste_raw spplhi_raw val_cbdacu val_cbfpcu val_cbsacu val_cbttcu val_cldacu val_clfpcu val_clsacu val_clttcu val_cmdacu val_cmfpcu val_cmsacu val_cmttcu val_codacu val_cofpcu val_cosacu val_costrd val_cottcu val_csdacu val_csfpcu val_cssacu val_csttcu val_ctdacu val_ctfpcu val_ctsacu val_cttcu val_ctttcu val_cvdacu val_cvfpcu val_cvsacu val_cvttcu val_devvcu val_ecavce val_ecavcu val_ecbvce val_ecbvcu val_eckvce val_eckvcu val_eclvce val_eclvcu val_edivce val_edivcu val_efovce val_efovcu val_efuvce val_efuvcu val_egavce val_egavcu val_egovce val_egovcu val_elpvce val_elpvcu val_eluvce val_eluvcu val_encvce val_encvcu val_engvce val_engvcu val_enpvcu val_eoivce val_eoivcu val_epevce val_epevcu val_eplvcu val_esdvce val_esdvcu val_esovce val_esovcu val_ibrvcu val_icovcu val_idevcu val_iinput val_iinvcu val_iisfov val_iislov val_iisvcu val_ikivcu val_iklvcu val_ikovcu val_ilrvcu val_insvcu val_intvcu val_iotvcu val_ipkvcu val_iprvcu val_irdvcu val_irevcu val_irrvcu val_itxvcu val_iuwvcu val_nopvcu val_othvcu val_output val_rdnvcu val_renvcu val_rimvcu val_rtlvcu val_sfbvcu val_sfcvcu val_sfdvcu val_sfgvcu val_sfjvcu val_sfkvcu val_sfnvcu val_sfovcu val_sfrvcu val_sfsvcu val_sfuvcu val_shdvcu val_shfvcu val_shjvcu val_srdvcu val_srjvcu val_srmvcu val_stdvcu val_stjvcu val_stlvcu val_vtlvcu val_yelvcu val_yisvcu val_yisvdo val_yisvfo val_ykdvcu val_ykfvcu val_ykivcu val_yprvcu val_yrnvcu val_yrsvcu val_ysnvcu val_ytovcu val_znavcu val_zndvcu val_znevcu val_znhvcu val_znivcu val_znovcu val_znpvcu val_znrvcu val_znsvcu val_zntvcu val_zpavcu val_zpdvcu val_zpevcu val_zphvcu val_zpivcu val_zpovcu val_zppvcu val_zprvcu val_zpsvcu val_zptvcu value_added_nominal workers
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L26:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 23 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L27:step-merge" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 24 389 `=_rc' // WFLOG-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/variable_year/mapped_fields.dta", assert(match) nogen
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L27:step-merge" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 24 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L28:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 25 389 `=_rc' // WFLOG-INJECTED
replace st_amdal_raw=vs_amdal_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L28:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 25 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L29:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 26 389 `=_rc' // WFLOG-INJECTED
replace st_b3wste_raw=vs_b3wste_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L29:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 26 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L30:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 27 389 `=_rc' // WFLOG-INJECTED
replace st_capital_additions_nominal=vs_capital_additions_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L30:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 27 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L31:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 28 389 `=_rc' // WFLOG-INJECTED
replace st_capital_nominal=vs_capital_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L31:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 28 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L32:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 29 389 `=_rc' // WFLOG-INJECTED
replace st_capital_stock_nominal=vs_capital_stock_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L32:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 29 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L33:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 30 389 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=vs_elec_nonpln_kwh
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L33:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 30 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L34:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 31 389 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=vs_elec_nonpln_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L34:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 31 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L35:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 32 389 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=vs_elec_owngen_kwh
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L35:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 32 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L36:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 33 389 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=vs_elec_pln_kwh
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L36:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 33 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L37:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 34 389 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=vs_elec_pln_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L37:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 34 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L38:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 35 389 `=_rc' // WFLOG-INJECTED
replace st_export_binary_raw=vs_export_binary_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L38:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 35 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L39:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 36 389 `=_rc' // WFLOG-INJECTED
replace st_export_share_pct=vs_export_share_pct
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L39:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 36 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L40:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 37 389 `=_rc' // WFLOG-INJECTED
replace st_foreign_ownership_pct=vs_foreign_ownership_pct
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L40:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 37 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L41:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 38 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_ltr=vs_fuel_biodiesel_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L41:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 38 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L42:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 39 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_rp000=vs_fuel_biodiesel_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L42:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 39 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L43:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 40 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=vs_fuel_charcoal_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L43:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 40 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L44:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 41 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=vs_fuel_charcoal_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L44:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 41 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L45:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 42 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=vs_fuel_citygas_m3
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L45:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 42 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L46:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 43 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=vs_fuel_citygas_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L46:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 43 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L47:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 44 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=vs_fuel_coal_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L47:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 44 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L48:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 45 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=vs_fuel_coal_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L48:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 45 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L49:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 46 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=vs_fuel_coalbriq_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L49:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 46 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L50:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 47 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=vs_fuel_coalbriq_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L50:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 47 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L51:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 48 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_kg=vs_fuel_coke_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L51:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 48 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L52:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 49 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_rp000=vs_fuel_coke_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L52:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 49 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L53:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 50 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=vs_fuel_diesel_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L53:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 50 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L54:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 51 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=vs_fuel_diesel_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L54:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 51 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L55:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 52 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=vs_fuel_dieseloil_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L55:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 52 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L56:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 53 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=vs_fuel_dieseloil_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L56:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 53 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L57:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 54 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_firewood_kg=vs_fuel_firewood_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L57:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 54 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L58:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 55 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_firewood_rp000=vs_fuel_firewood_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L58:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 55 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L59:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 56 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=vs_fuel_fueloil_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L59:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 56 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L60:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 57 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=vs_fuel_fueloil_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L60:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 57 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L61:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 58 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=vs_fuel_kerosene_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L61:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 58 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L62:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 59 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=vs_fuel_kerosene_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L62:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 59 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L63:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 60 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=vs_fuel_lpg_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L63:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 60 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L64:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 61 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=vs_fuel_lpg_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L64:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 61 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L65:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 62 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=vs_fuel_lubricant_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L65:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 62 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L66:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 63 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=vs_fuel_lubricant_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L66:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 63 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L67:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 64 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=vs_fuel_natgas_kg
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L67:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 64 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L68:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 65 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=vs_fuel_natgas_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L68:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 65 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L69:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 66 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=vs_fuel_other_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L69:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 66 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L70:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 67 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=vs_fuel_othergas_m3
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L70:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 67 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L71:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 68 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=vs_fuel_othergas_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L71:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 68 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L72:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 69 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=vs_fuel_petrol_ltr
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L72:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 69 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L73:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 70 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=vs_fuel_petrol_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L73:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 70 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L74:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 71 389 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=vs_fuel_total_reported_rp000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L74:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 71 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L75:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 72 389 `=_rc' // WFLOG-INJECTED
replace st_gross_output_nominal=vs_gross_output_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L75:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 72 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L76:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 73 389 `=_rc' // WFLOG-INJECTED
replace st_import_value_nominal=vs_import_value_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L76:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 73 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L77:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 74 389 `=_rc' // WFLOG-INJECTED
replace st_innovation_marketing_raw=vs_innovation_marketing_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L77:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 74 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L78:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 75 389 `=_rc' // WFLOG-INJECTED
replace st_innovation_org_raw=vs_innovation_org_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L78:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 75 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L79:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 76 389 `=_rc' // WFLOG-INJECTED
replace st_innovation_process_raw=vs_innovation_process_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L79:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 76 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L80:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 77 389 `=_rc' // WFLOG-INJECTED
replace st_innovation_product_raw=vs_innovation_product_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L80:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 77 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L81:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 78 389 `=_rc' // WFLOG-INJECTED
replace st_innovation_raw=vs_innovation_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L81:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 78 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L82:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 79 389 `=_rc' // WFLOG-INJECTED
replace st_inspli_raw=vs_inspli_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L82:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 79 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L83:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 80 389 `=_rc' // WFLOG-INJECTED
replace st_intermediate_inputs_nominal=vs_intermediate_inputs_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L83:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 80 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L84:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 81 389 `=_rc' // WFLOG-INJECTED
replace st_liwste_raw=vs_liwste_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L84:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 81 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L85:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 82 389 `=_rc' // WFLOG-INJECTED
replace st_pplihi_raw=vs_pplihi_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L85:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 82 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L86:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 83 389 `=_rc' // WFLOG-INJECTED
replace st_production_workers=vs_production_workers
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L86:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 83 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L87:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 84 389 `=_rc' // WFLOG-INJECTED
replace st_rd_cost_nominal=vs_rd_cost_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L87:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 84 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L88:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 85 389 `=_rc' // WFLOG-INJECTED
replace st_rd_indicator_raw=vs_rd_indicator_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L88:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 85 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L89:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 86 389 `=_rc' // WFLOG-INJECTED
replace st_rd_workers=vs_rd_workers
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L89:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 86 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L90:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 87 389 `=_rc' // WFLOG-INJECTED
replace st_sowste_raw=vs_sowste_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L90:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 87 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L91:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 88 389 `=_rc' // WFLOG-INJECTED
replace st_spplhi_raw=vs_spplhi_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L91:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 88 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L92:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 89 389 `=_rc' // WFLOG-INJECTED
replace st_val_cbdacu=vs_val_cbdacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L92:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 89 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L93:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 90 389 `=_rc' // WFLOG-INJECTED
replace st_val_cbfpcu=vs_val_cbfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L93:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 90 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L94:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 91 389 `=_rc' // WFLOG-INJECTED
replace st_val_cbsacu=vs_val_cbsacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L94:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 91 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L95:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 92 389 `=_rc' // WFLOG-INJECTED
replace st_val_cbttcu=vs_val_cbttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L95:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 92 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L96:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 93 389 `=_rc' // WFLOG-INJECTED
replace st_val_cldacu=vs_val_cldacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L96:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 93 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L97:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 94 389 `=_rc' // WFLOG-INJECTED
replace st_val_clfpcu=vs_val_clfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L97:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 94 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L98:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 95 389 `=_rc' // WFLOG-INJECTED
replace st_val_clsacu=vs_val_clsacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L98:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 95 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L99:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 96 389 `=_rc' // WFLOG-INJECTED
replace st_val_clttcu=vs_val_clttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L99:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 96 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L100:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 97 389 `=_rc' // WFLOG-INJECTED
replace st_val_cmdacu=vs_val_cmdacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L100:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 97 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L101:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 98 389 `=_rc' // WFLOG-INJECTED
replace st_val_cmfpcu=vs_val_cmfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L101:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 98 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L102:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 99 389 `=_rc' // WFLOG-INJECTED
replace st_val_cmsacu=vs_val_cmsacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L102:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 99 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L103:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 100 389 `=_rc' // WFLOG-INJECTED
replace st_val_cmttcu=vs_val_cmttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L103:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 100 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L104:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 101 389 `=_rc' // WFLOG-INJECTED
replace st_val_codacu=vs_val_codacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L104:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 101 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L105:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 102 389 `=_rc' // WFLOG-INJECTED
replace st_val_cofpcu=vs_val_cofpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L105:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 102 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L106:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 103 389 `=_rc' // WFLOG-INJECTED
replace st_val_cosacu=vs_val_cosacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L106:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 103 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L107:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 104 389 `=_rc' // WFLOG-INJECTED
replace st_val_costrd=vs_val_costrd
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L107:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 104 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L108:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 105 389 `=_rc' // WFLOG-INJECTED
replace st_val_cottcu=vs_val_cottcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L108:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 105 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L109:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 106 389 `=_rc' // WFLOG-INJECTED
replace st_val_csdacu=vs_val_csdacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L109:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 106 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L110:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 107 389 `=_rc' // WFLOG-INJECTED
replace st_val_csfpcu=vs_val_csfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L110:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 107 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L111:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 108 389 `=_rc' // WFLOG-INJECTED
replace st_val_cssacu=vs_val_cssacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L111:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 108 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L112:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 109 389 `=_rc' // WFLOG-INJECTED
replace st_val_csttcu=vs_val_csttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L112:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 109 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L113:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 110 389 `=_rc' // WFLOG-INJECTED
replace st_val_ctdacu=vs_val_ctdacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L113:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 110 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L114:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 111 389 `=_rc' // WFLOG-INJECTED
replace st_val_ctfpcu=vs_val_ctfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L114:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 111 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L115:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 112 389 `=_rc' // WFLOG-INJECTED
replace st_val_ctsacu=vs_val_ctsacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L115:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 112 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L116:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 113 389 `=_rc' // WFLOG-INJECTED
replace st_val_cttcu=vs_val_cttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L116:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 113 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L117:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 114 389 `=_rc' // WFLOG-INJECTED
replace st_val_ctttcu=vs_val_ctttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L117:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 114 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L118:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 115 389 `=_rc' // WFLOG-INJECTED
replace st_val_cvdacu=vs_val_cvdacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L118:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 115 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L119:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 116 389 `=_rc' // WFLOG-INJECTED
replace st_val_cvfpcu=vs_val_cvfpcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L119:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 116 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L120:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 117 389 `=_rc' // WFLOG-INJECTED
replace st_val_cvsacu=vs_val_cvsacu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L120:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 117 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L121:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 118 389 `=_rc' // WFLOG-INJECTED
replace st_val_cvttcu=vs_val_cvttcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L121:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 118 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L122:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 119 389 `=_rc' // WFLOG-INJECTED
replace st_val_devvcu=vs_val_devvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L122:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 119 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L123:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 120 389 `=_rc' // WFLOG-INJECTED
replace st_val_ecavce=vs_val_ecavce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L123:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 120 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L124:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 121 389 `=_rc' // WFLOG-INJECTED
replace st_val_ecavcu=vs_val_ecavcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L124:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 121 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L125:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 122 389 `=_rc' // WFLOG-INJECTED
replace st_val_ecbvce=vs_val_ecbvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L125:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 122 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L126:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 123 389 `=_rc' // WFLOG-INJECTED
replace st_val_ecbvcu=vs_val_ecbvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L126:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 123 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L127:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 124 389 `=_rc' // WFLOG-INJECTED
replace st_val_eckvce=vs_val_eckvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L127:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 124 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L128:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 125 389 `=_rc' // WFLOG-INJECTED
replace st_val_eckvcu=vs_val_eckvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L128:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 125 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L129:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 126 389 `=_rc' // WFLOG-INJECTED
replace st_val_eclvce=vs_val_eclvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L129:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 126 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L130:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 127 389 `=_rc' // WFLOG-INJECTED
replace st_val_eclvcu=vs_val_eclvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L130:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 127 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L131:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 128 389 `=_rc' // WFLOG-INJECTED
replace st_val_edivce=vs_val_edivce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L131:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 128 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L132:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 129 389 `=_rc' // WFLOG-INJECTED
replace st_val_edivcu=vs_val_edivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L132:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 129 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L133:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 130 389 `=_rc' // WFLOG-INJECTED
replace st_val_efovce=vs_val_efovce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L133:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 130 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L134:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 131 389 `=_rc' // WFLOG-INJECTED
replace st_val_efovcu=vs_val_efovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L134:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 131 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L135:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 132 389 `=_rc' // WFLOG-INJECTED
replace st_val_efuvce=vs_val_efuvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L135:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 132 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L136:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 133 389 `=_rc' // WFLOG-INJECTED
replace st_val_efuvcu=vs_val_efuvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L136:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 133 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L137:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 134 389 `=_rc' // WFLOG-INJECTED
replace st_val_egavce=vs_val_egavce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L137:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 134 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L138:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 135 389 `=_rc' // WFLOG-INJECTED
replace st_val_egavcu=vs_val_egavcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L138:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 135 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L139:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 136 389 `=_rc' // WFLOG-INJECTED
replace st_val_egovce=vs_val_egovce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L139:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 136 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L140:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 137 389 `=_rc' // WFLOG-INJECTED
replace st_val_egovcu=vs_val_egovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L140:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 137 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L141:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 138 389 `=_rc' // WFLOG-INJECTED
replace st_val_elpvce=vs_val_elpvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L141:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 138 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L142:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 139 389 `=_rc' // WFLOG-INJECTED
replace st_val_elpvcu=vs_val_elpvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L142:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 139 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L143:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 140 389 `=_rc' // WFLOG-INJECTED
replace st_val_eluvce=vs_val_eluvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L143:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 140 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L144:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 141 389 `=_rc' // WFLOG-INJECTED
replace st_val_eluvcu=vs_val_eluvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L144:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 141 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L145:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 142 389 `=_rc' // WFLOG-INJECTED
replace st_val_encvce=vs_val_encvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L145:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 142 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L146:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 143 389 `=_rc' // WFLOG-INJECTED
replace st_val_encvcu=vs_val_encvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L146:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 143 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L147:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 144 389 `=_rc' // WFLOG-INJECTED
replace st_val_engvce=vs_val_engvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L147:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 144 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L148:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 145 389 `=_rc' // WFLOG-INJECTED
replace st_val_engvcu=vs_val_engvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L148:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 145 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L149:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 146 389 `=_rc' // WFLOG-INJECTED
replace st_val_enpvcu=vs_val_enpvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L149:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 146 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L150:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 147 389 `=_rc' // WFLOG-INJECTED
replace st_val_eoivce=vs_val_eoivce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L150:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 147 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L151:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 148 389 `=_rc' // WFLOG-INJECTED
replace st_val_eoivcu=vs_val_eoivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L151:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 148 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L152:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 149 389 `=_rc' // WFLOG-INJECTED
replace st_val_epevce=vs_val_epevce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L152:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 149 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L153:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 150 389 `=_rc' // WFLOG-INJECTED
replace st_val_epevcu=vs_val_epevcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L153:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 150 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L154:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 151 389 `=_rc' // WFLOG-INJECTED
replace st_val_eplvcu=vs_val_eplvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L154:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 151 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L155:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 152 389 `=_rc' // WFLOG-INJECTED
replace st_val_esdvce=vs_val_esdvce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L155:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 152 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L156:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 153 389 `=_rc' // WFLOG-INJECTED
replace st_val_esdvcu=vs_val_esdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L156:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 153 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L157:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 154 389 `=_rc' // WFLOG-INJECTED
replace st_val_esovce=vs_val_esovce
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L157:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 154 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L158:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 155 389 `=_rc' // WFLOG-INJECTED
replace st_val_esovcu=vs_val_esovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L158:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 155 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L159:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 156 389 `=_rc' // WFLOG-INJECTED
replace st_val_ibrvcu=vs_val_ibrvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L159:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 156 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L160:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 157 389 `=_rc' // WFLOG-INJECTED
replace st_val_icovcu=vs_val_icovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L160:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 157 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L161:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 158 389 `=_rc' // WFLOG-INJECTED
replace st_val_idevcu=vs_val_idevcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L161:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 158 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L162:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 159 389 `=_rc' // WFLOG-INJECTED
replace st_val_iinput=vs_val_iinput
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L162:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 159 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L163:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 160 389 `=_rc' // WFLOG-INJECTED
replace st_val_iinvcu=vs_val_iinvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L163:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 160 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L164:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 161 389 `=_rc' // WFLOG-INJECTED
replace st_val_iisfov=vs_val_iisfov
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L164:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 161 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L165:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 162 389 `=_rc' // WFLOG-INJECTED
replace st_val_iislov=vs_val_iislov
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L165:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 162 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L166:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 163 389 `=_rc' // WFLOG-INJECTED
replace st_val_iisvcu=vs_val_iisvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L166:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 163 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L167:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 164 389 `=_rc' // WFLOG-INJECTED
replace st_val_ikivcu=vs_val_ikivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L167:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 164 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L168:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 165 389 `=_rc' // WFLOG-INJECTED
replace st_val_iklvcu=vs_val_iklvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L168:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 165 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L169:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 166 389 `=_rc' // WFLOG-INJECTED
replace st_val_ikovcu=vs_val_ikovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L169:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 166 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L170:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 167 389 `=_rc' // WFLOG-INJECTED
replace st_val_ilrvcu=vs_val_ilrvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L170:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 167 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L171:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 168 389 `=_rc' // WFLOG-INJECTED
replace st_val_insvcu=vs_val_insvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L171:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 168 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L172:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 169 389 `=_rc' // WFLOG-INJECTED
replace st_val_intvcu=vs_val_intvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L172:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 169 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L173:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 170 389 `=_rc' // WFLOG-INJECTED
replace st_val_iotvcu=vs_val_iotvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L173:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 170 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L174:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 171 389 `=_rc' // WFLOG-INJECTED
replace st_val_ipkvcu=vs_val_ipkvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L174:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 171 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L175:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 172 389 `=_rc' // WFLOG-INJECTED
replace st_val_iprvcu=vs_val_iprvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L175:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 172 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L176:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 173 389 `=_rc' // WFLOG-INJECTED
replace st_val_irdvcu=vs_val_irdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L176:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 173 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L177:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 174 389 `=_rc' // WFLOG-INJECTED
replace st_val_irevcu=vs_val_irevcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L177:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 174 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L178:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 175 389 `=_rc' // WFLOG-INJECTED
replace st_val_irrvcu=vs_val_irrvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L178:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 175 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L179:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 176 389 `=_rc' // WFLOG-INJECTED
replace st_val_itxvcu=vs_val_itxvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L179:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 176 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L180:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 177 389 `=_rc' // WFLOG-INJECTED
replace st_val_iuwvcu=vs_val_iuwvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L180:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 177 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L181:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 178 389 `=_rc' // WFLOG-INJECTED
replace st_val_nopvcu=vs_val_nopvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L181:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 178 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L182:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 179 389 `=_rc' // WFLOG-INJECTED
replace st_val_othvcu=vs_val_othvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L182:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 179 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L183:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 180 389 `=_rc' // WFLOG-INJECTED
replace st_val_output=vs_val_output
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L183:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 180 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L184:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 181 389 `=_rc' // WFLOG-INJECTED
replace st_val_rdnvcu=vs_val_rdnvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L184:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 181 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L185:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 182 389 `=_rc' // WFLOG-INJECTED
replace st_val_renvcu=vs_val_renvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L185:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 182 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L186:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 183 389 `=_rc' // WFLOG-INJECTED
replace st_val_rimvcu=vs_val_rimvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L186:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 183 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L187:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 184 389 `=_rc' // WFLOG-INJECTED
replace st_val_rtlvcu=vs_val_rtlvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L187:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 184 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L188:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 185 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfbvcu=vs_val_sfbvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L188:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 185 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L189:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 186 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfcvcu=vs_val_sfcvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L189:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 186 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L190:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 187 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfdvcu=vs_val_sfdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L190:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 187 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L191:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 188 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfgvcu=vs_val_sfgvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L191:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 188 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L192:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 189 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfjvcu=vs_val_sfjvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L192:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 189 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L193:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 190 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfkvcu=vs_val_sfkvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L193:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 190 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L194:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 191 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfnvcu=vs_val_sfnvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L194:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 191 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L195:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 192 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfovcu=vs_val_sfovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L195:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 192 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L196:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 193 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfrvcu=vs_val_sfrvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L196:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 193 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L197:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 194 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfsvcu=vs_val_sfsvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L197:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 194 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L198:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 195 389 `=_rc' // WFLOG-INJECTED
replace st_val_sfuvcu=vs_val_sfuvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L198:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 195 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L199:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 196 389 `=_rc' // WFLOG-INJECTED
replace st_val_shdvcu=vs_val_shdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L199:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 196 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L200:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 197 389 `=_rc' // WFLOG-INJECTED
replace st_val_shfvcu=vs_val_shfvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L200:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 197 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L201:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 198 389 `=_rc' // WFLOG-INJECTED
replace st_val_shjvcu=vs_val_shjvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L201:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 198 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L202:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 199 389 `=_rc' // WFLOG-INJECTED
replace st_val_srdvcu=vs_val_srdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L202:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 199 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L203:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 200 389 `=_rc' // WFLOG-INJECTED
replace st_val_srjvcu=vs_val_srjvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L203:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 200 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L204:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 201 389 `=_rc' // WFLOG-INJECTED
replace st_val_srmvcu=vs_val_srmvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L204:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 201 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L205:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 202 389 `=_rc' // WFLOG-INJECTED
replace st_val_stdvcu=vs_val_stdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L205:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 202 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L206:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 203 389 `=_rc' // WFLOG-INJECTED
replace st_val_stjvcu=vs_val_stjvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L206:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 203 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L207:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 204 389 `=_rc' // WFLOG-INJECTED
replace st_val_stlvcu=vs_val_stlvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L207:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 204 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L208:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 205 389 `=_rc' // WFLOG-INJECTED
replace st_val_vtlvcu=vs_val_vtlvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L208:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 205 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L209:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 206 389 `=_rc' // WFLOG-INJECTED
replace st_val_yelvcu=vs_val_yelvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L209:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 206 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L210:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 207 389 `=_rc' // WFLOG-INJECTED
replace st_val_yisvcu=vs_val_yisvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L210:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 207 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L211:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 208 389 `=_rc' // WFLOG-INJECTED
replace st_val_yisvdo=vs_val_yisvdo
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L211:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 208 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L212:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 209 389 `=_rc' // WFLOG-INJECTED
replace st_val_yisvfo=vs_val_yisvfo
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L212:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 209 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L213:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 210 389 `=_rc' // WFLOG-INJECTED
replace st_val_ykdvcu=vs_val_ykdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L213:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 210 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L214:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 211 389 `=_rc' // WFLOG-INJECTED
replace st_val_ykfvcu=vs_val_ykfvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L214:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 211 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L215:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 212 389 `=_rc' // WFLOG-INJECTED
replace st_val_ykivcu=vs_val_ykivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L215:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 212 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L216:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 213 389 `=_rc' // WFLOG-INJECTED
replace st_val_yprvcu=vs_val_yprvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L216:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 213 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L217:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 214 389 `=_rc' // WFLOG-INJECTED
replace st_val_yrnvcu=vs_val_yrnvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L217:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 214 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L218:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 215 389 `=_rc' // WFLOG-INJECTED
replace st_val_yrsvcu=vs_val_yrsvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L218:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 215 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L219:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 216 389 `=_rc' // WFLOG-INJECTED
replace st_val_ysnvcu=vs_val_ysnvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L219:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 216 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L220:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 217 389 `=_rc' // WFLOG-INJECTED
replace st_val_ytovcu=vs_val_ytovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L220:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 217 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L221:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 218 389 `=_rc' // WFLOG-INJECTED
replace st_val_znavcu=vs_val_znavcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L221:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 218 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L222:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 219 389 `=_rc' // WFLOG-INJECTED
replace st_val_zndvcu=vs_val_zndvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L222:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 219 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L223:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 220 389 `=_rc' // WFLOG-INJECTED
replace st_val_znevcu=vs_val_znevcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L223:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 220 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L224:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 221 389 `=_rc' // WFLOG-INJECTED
replace st_val_znhvcu=vs_val_znhvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L224:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 221 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L225:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 222 389 `=_rc' // WFLOG-INJECTED
replace st_val_znivcu=vs_val_znivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L225:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 222 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L226:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 223 389 `=_rc' // WFLOG-INJECTED
replace st_val_znovcu=vs_val_znovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L226:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 223 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L227:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 224 389 `=_rc' // WFLOG-INJECTED
replace st_val_znpvcu=vs_val_znpvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L227:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 224 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L228:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 225 389 `=_rc' // WFLOG-INJECTED
replace st_val_znrvcu=vs_val_znrvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L228:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 225 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L229:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 226 389 `=_rc' // WFLOG-INJECTED
replace st_val_znsvcu=vs_val_znsvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L229:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 226 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L230:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 227 389 `=_rc' // WFLOG-INJECTED
replace st_val_zntvcu=vs_val_zntvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L230:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 227 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L231:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 228 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpavcu=vs_val_zpavcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L231:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 228 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L232:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 229 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpdvcu=vs_val_zpdvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L232:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 229 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L233:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 230 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpevcu=vs_val_zpevcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L233:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 230 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L234:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 231 389 `=_rc' // WFLOG-INJECTED
replace st_val_zphvcu=vs_val_zphvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L234:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 231 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L235:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 232 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpivcu=vs_val_zpivcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L235:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 232 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L236:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 233 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpovcu=vs_val_zpovcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L236:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 233 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L237:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 234 389 `=_rc' // WFLOG-INJECTED
replace st_val_zppvcu=vs_val_zppvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L237:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 234 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L238:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 235 389 `=_rc' // WFLOG-INJECTED
replace st_val_zprvcu=vs_val_zprvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L238:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 235 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L239:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 236 389 `=_rc' // WFLOG-INJECTED
replace st_val_zpsvcu=vs_val_zpsvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L239:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 236 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L240:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 237 389 `=_rc' // WFLOG-INJECTED
replace st_val_zptvcu=vs_val_zptvcu
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L240:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 237 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L241:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 238 389 `=_rc' // WFLOG-INJECTED
replace st_value_added_nominal=vs_value_added_nominal
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L241:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 238 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L242:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 239 389 `=_rc' // WFLOG-INJECTED
replace st_workers=vs_workers
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L242:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 239 389 `=_rc' // WFLOG-INJECTED
* Explicit dictionary correction: monetary R&D is IRDVCU, not COSTRD.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L244:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 240 389 `=_rc' // WFLOG-INJECTED
label variable rd_cost_nominal "Reported R&D expense IRDVCU, nominal Rp000; excludes specified worker costs"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L244:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 240 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L245:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 241 389 `=_rc' // WFLOG-INJECTED
label variable legacy_rd_cost_mislabelled "ARCHIVE: COSTRD code previously mislabeled as R&D expense; do not use as money"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L245:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 241 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L246:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 242 389 `=_rc' // WFLOG-INJECTED
generate str80 rd_cost_definition_status="source_absent"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L246:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 242 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L247:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 243 389 `=_rc' // WFLOG-INJECTED
replace rd_cost_definition_status="IRDVCU reported expense, distinct from COSTRD funding indicator" if source_year>=2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L247:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 243 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L248:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 244 389 `=_rc' // WFLOG-INJECTED
replace rd_cost_per_worker_nominal=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L248:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 244 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L249:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 245 389 `=_rc' // WFLOG-INJECTED
replace rd_cost_per_worker_nominal=rd_cost_nominal/workers if workers>0 & !missing(workers,rd_cost_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L249:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 245 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L250:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 246 389 `=_rc' // WFLOG-INJECTED
replace ln_rd_cost_nominal=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L250:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 246 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L251:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 247 389 `=_rc' // WFLOG-INJECTED
replace ln_rd_cost_nominal=ln(rd_cost_nominal) if rd_cost_nominal>0 & !missing(rd_cost_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L251:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 247 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L252:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 248 389 `=_rc' // WFLOG-INJECTED
label variable val_costrd "COSTRD source code: third-party R&D funding, not an amount"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L252:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 248 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L253:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 249 389 `=_rc' // WFLOG-INJECTED
replace ln_val_costrd=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L253:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 249 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L254:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 250 389 `=_rc' // WFLOG-INJECTED
replace pw_val_costrd=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L254:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 250 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L255:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 251 389 `=_rc' // WFLOG-INJECTED
label variable ln_val_costrd "Retired: logarithm of a category code has no monetary interpretation"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L255:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 251 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L256:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 252 389 `=_rc' // WFLOG-INJECTED
label variable pw_val_costrd "Retired: category code / workers is not spending intensity"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L256:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 252 389 `=_rc' // WFLOG-INJECTED
* Broad exporter status, keeping contradictory evidence visible.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L258:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 253 389 `=_rc' // WFLOG-INJECTED
generate byte export_verified_conflict=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L258:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 253 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L259:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 254 389 `=_rc' // WFLOG-INJECTED
replace export_verified_conflict=1 if export_share_valid & !missing(export_any_binary) & (export_share_pct>0)!=export_any_binary
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L259:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 254 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L260:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 255 389 `=_rc' // WFLOG-INJECTED
replace export_verified_conflict=1 if export_share_valid & export_share_pct==0 & export_direct_flag==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L260:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 255 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L261:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 256 389 `=_rc' // WFLOG-INJECTED
replace export_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L261:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 256 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L262:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 257 389 `=_rc' // WFLOG-INJECTED
replace export_flag=export_share_pct>0 if export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L262:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 257 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L263:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 258 389 `=_rc' // WFLOG-INJECTED
replace export_flag=export_any_binary if missing(export_flag) & !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L263:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 258 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L264:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 259 389 `=_rc' // WFLOG-INJECTED
replace export_flag=1 if missing(export_flag) & export_direct_flag==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L264:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 259 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L265:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 260 389 `=_rc' // WFLOG-INJECTED
replace export_flag=. if export_verified_conflict
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L265:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 260 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L266:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 261 389 `=_rc' // WFLOG-INJECTED
replace export_observed=!missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L266:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 261 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L267:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 262 389 `=_rc' // WFLOG-INJECTED
replace export_binary_valid=inlist(export_binary_raw,1,2) & (!missing(export_any_binary) | !missing(export_direct_flag))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L267:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 262 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L268:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 263 389 `=_rc' // WFLOG-INJECTED
label variable export_binary_valid "In verified annual 1=yes/2=no domain; 2022 question is direct only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L268:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 263 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L269:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 264 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="no_supported_observation"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L269:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 264 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L270:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 265 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="share_observed; binary_annual_evidence_incomplete" if export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L270:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 265 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L271:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 266 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="verified_any_export_binary" if !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L271:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 266 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L272:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 267 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="direct_export_yes_implies_any_export_yes" if export_direct_flag==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L272:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 267 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L273:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 268 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="direct_export_no; indirect_export_unknown" if export_direct_flag==0 & !export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L273:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 268 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L274:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 269 389 `=_rc' // WFLOG-INJECTED
replace export_definition_status="conflicting_verified_sources; retained_for_review" if export_verified_conflict
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L274:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 269 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L275:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 270 389 `=_rc' // WFLOG-INJECTED
label variable export_flag "Any export: supported share/binary or direct yes; conflict and unknown missing"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L275:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 270 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L276:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 271 389 `=_rc' // WFLOG-INJECTED
label variable export_direct_flag "2022 only: direct export 1=yes 0=no; no says nothing about indirect exports"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L276:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 271 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L277:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 272 389 `=_rc' // WFLOG-INJECTED
label variable export_any_binary "Verified any-export question, 1=yes 0=no; excludes direct-only 2022"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L277:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 272 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L278:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 273 389 `=_rc' // WFLOG-INJECTED
label variable rd_activity_flag "R&D activity: 2011 general; later own R&D, annual verified code pairs"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L278:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 273 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L279:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 274 389 `=_rc' // WFLOG-INJECTED
label variable rd_external_funding_flag "Funds R&D conducted by another party, 1=yes 0=no"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L279:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 274 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L280:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 275 389 `=_rc' // WFLOG-INJECTED
label variable innovation_flag "General innovation indicator, 1=yes 0=no; annual questionnaire wording"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L280:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 275 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L281:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 276 389 `=_rc' // WFLOG-INJECTED
label variable env_amdal_flag "AMDAL present 1, not yet present 0"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L281:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 276 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L282:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 277 389 `=_rc' // WFLOG-INJECTED
label variable env_ukl_upl_flag "UKL/UPL present 1, not yet present 0; raw codes 3/4"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L282:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 277 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L283:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 278 389 `=_rc' // WFLOG-INJECTED
label variable env_sppl_flag "SPPL present 1, not yet present 0; raw codes 5/6"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L283:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 278 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L284:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 279 389 `=_rc' // WFLOG-INJECTED
label variable env_waste_treatment_flag "Waste installation 2020/21 or treatment 2022; raw codes 7/8"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L284:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 279 389 `=_rc' // WFLOG-INJECTED
* Update physical quantities and only the energy calculations that depend on them.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 280 389 `=_rc' "in" `"coal coke natgas charcoal"' // WFLOG-INJECTED
* Ulangi blok untuk f: coal, coke, natgas, charcoal. // WFDOC-INJECTED
foreach f in coal coke natgas charcoal {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L287:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
 replace cl_fuel_`f'_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L287:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L288:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
 replace cl_fuel_`f'_kg=fuel_`f'_kg if fuel_`f'_kg>=0 & !missing(fuel_`f'_kg)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L288:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L289:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
 replace price_`f'=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L289:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L290:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
 replace price_`f'=fuel_`f'_rp000/fuel_`f'_kg if fuel_`f'_kg>0 & !missing(fuel_`f'_kg,fuel_`f'_rp000) & fuel_`f'_rp000>=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L290:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L291:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
 drop p99_`f'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L291:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L292:step-bysort" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
 bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L292:step-bysort" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L286:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 280 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L294:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 281 389 `=_rc' // WFLOG-INJECTED
generate byte coal_unit_verified=inrange(source_year,2010,2015) | inlist(source_year,2017,2020,2021,2022)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L294:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 281 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L295:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 282 389 `=_rc' // WFLOG-INJECTED
generate str16 coal_source_unit=cond(source_year<=2015,"kg",cond(coal_unit_verified,"tonne","unverified"))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L295:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 282 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L296:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 283 389 `=_rc' // WFLOG-INJECTED
label variable fuel_coal_kg "Coal kg; tonnes converted where annual unit verified; check coal_unit_verified"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L296:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 283 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L297:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 284 389 `=_rc' // WFLOG-INJECTED
label variable fuel_natgas_kg "Retired for 2020–22: source unit is MMBTU; use fuel_natgas_mmbtu"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L297:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 284 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L298:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 285 389 `=_rc' // WFLOG-INJECTED
label variable fuel_charcoal_kg "Retired for 2020–22: source is mixed biomass; use fuel_biomass_kg"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L298:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 285 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L299:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 286 389 `=_rc' // WFLOG-INJECTED
label variable fuel_natgas_mmbtu "2020–22 natural gas quantity, MMBTU; not kg"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L299:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 286 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L300:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 287 389 `=_rc' // WFLOG-INJECTED
label variable fuel_biomass_kg "2020–22 mixed biomass, tonnes converted to kg; not pure charcoal"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L300:step-label" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 287 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L301:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 288 389 `=_rc' // WFLOG-INJECTED
replace unit_status="annual source units partly verified; see variable/year evidence"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L301:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 288 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L302:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 289 389 `=_rc' // WFLOG-INJECTED
drop co2_scope1_nfuels_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L302:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 289 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L303:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 290 389 `=_rc' // WFLOG-INJECTED
drop co2_scope1_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L303:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 290 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L304:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 291 389 `=_rc' // WFLOG-INJECTED
drop co2_scope1_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L304:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 291 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L305:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 292 389 `=_rc' // WFLOG-INJECTED
drop gj_fuel_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L305:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 292 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L306:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 293 389 `=_rc' // WFLOG-INJECTED
drop nine_fuels_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L306:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 293 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L307:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 294 389 `=_rc' // WFLOG-INJECTED
drop electricity_n_observed
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L307:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 294 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L308:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 295 389 `=_rc' // WFLOG-INJECTED
drop elec_purchased_kwh
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L308:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 295 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L309:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 296 389 `=_rc' // WFLOG-INJECTED
drop gj_electricity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L309:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 296 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L310:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 297 389 `=_rc' // WFLOG-INJECTED
drop co2_scope2_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L310:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 297 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L311:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 298 389 `=_rc' // WFLOG-INJECTED
drop co2_scope2_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L311:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 298 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L312:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 299 389 `=_rc' // WFLOG-INJECTED
drop co2_total_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L312:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 299 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L313:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 300 389 `=_rc' // WFLOG-INJECTED
drop co2_total_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L313:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 300 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L314:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 301 389 `=_rc' // WFLOG-INJECTED
drop total_gj_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L314:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 301 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L315:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 302 389 `=_rc' // WFLOG-INJECTED
drop co2_scope1_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L315:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 302 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L316:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 303 389 `=_rc' // WFLOG-INJECTED
drop co2_scope2_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L316:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 303 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L317:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 304 389 `=_rc' // WFLOG-INJECTED
drop co2_total_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L317:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 304 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L318:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 305 389 `=_rc' // WFLOG-INJECTED
drop total_gj_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L318:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 305 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L319:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 306 389 `=_rc' // WFLOG-INJECTED
drop co2_variant_static_grid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L319:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 306 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L320:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 307 389 `=_rc' // WFLOG-INJECTED
drop own_generation_reported
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L320:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 307 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L321:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 308 389 `=_rc' // WFLOG-INJECTED
drop own_generation_added
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L321:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 308 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L322:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 309 389 `=_rc' // WFLOG-INJECTED
drop extra_fuel_positive
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L322:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 309 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L323:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 310 389 `=_rc' // WFLOG-INJECTED
drop energy_coverage_status
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L323:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 310 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 311 389 `=_rc' "in" `"diesel petrol kerosene coal lpg citygas othergas coalbriq coke"' // WFLOG-INJECTED
* Ulangi blok untuk setiap f yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L325:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 drop co2_`f'_s1 co2_`f'_s2 gj_`f'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L325:step-drop" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L324:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 311 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L327:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 312 389 `=_rc' // WFLOG-INJECTED
local fuels "diesel petrol kerosene coal lpg citygas othergas coalbriq coke"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L327:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 312 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L328:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 313 389 `=_rc' // WFLOG-INJECTED
local units "ltr ltr ltr kg kg m3 m3 kg kg"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L328:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 313 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L329:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 314 389 `=_rc' // WFLOG-INJECTED
local c1 ".002654 .00231 .002494 .002496 .002876 .002695 .002695 .002877 .00284"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L329:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 314 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L330:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 315 389 `=_rc' // WFLOG-INJECTED
local c2 ".002978 .002479 .002616 .002448 .003293 .00219 .00219 .002032 .002907"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L330:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 315 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L331:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 316 389 `=_rc' // WFLOG-INJECTED
local gj ".035697 .033225 .034559 .0262 .045544 .048 .048 .029308 .026377"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L331:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 316 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:step-forvalues" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 317 389 `=_rc' "forvalues" `"1/9"' // WFLOG-INJECTED
* Ulangi blok untuk setiap i dari 1 sampai 9. // WFDOC-INJECTED
forvalues i=1/9 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L333:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
    local f: word `i' of `fuels'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L333:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L334:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
    local u: word `i' of `units'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L334:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L335:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
    local a: word `i' of `c1'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L335:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L336:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
    local b: word `i' of `c2'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L336:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L337:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
    local c: word `i' of `gj'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L337:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L338:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
    generate double co2_`f'_s1=cl_fuel_`f'_`u'*`a'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L338:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L339:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
    generate double co2_`f'_s2=cl_fuel_`f'_`u'*`b'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L339:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L340:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
    generate double gj_`f'=cl_fuel_`f'_`u'*`c'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L340:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:step-forvalues" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L332:step-forvalues" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 317 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L342:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 318 389 `=_rc' // WFLOG-INJECTED
egen byte co2_scope1_nfuels_s1=rownonmiss(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L342:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 318 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L343:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 319 389 `=_rc' // WFLOG-INJECTED
egen double co2_scope1_s1=rowtotal(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L343:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 319 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L344:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 320 389 `=_rc' // WFLOG-INJECTED
egen double co2_scope1_s2=rowtotal(co2_diesel_s2 co2_petrol_s2 co2_kerosene_s2 co2_coal_s2 co2_lpg_s2 co2_citygas_s2 co2_othergas_s2 co2_coalbriq_s2 co2_coke_s2), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L344:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 320 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L345:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 321 389 `=_rc' // WFLOG-INJECTED
egen double gj_fuel_s1=rowtotal(gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L345:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 321 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L346:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 322 389 `=_rc' // WFLOG-INJECTED
generate byte nine_fuels_complete=co2_scope1_nfuels_s1==9
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L346:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 322 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L347:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 323 389 `=_rc' // WFLOG-INJECTED
egen byte electricity_n_observed=rownonmiss(cl_elec_pln_kwh cl_elec_nonpln_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L347:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 323 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L348:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 324 389 `=_rc' // WFLOG-INJECTED
egen double elec_purchased_kwh=rowtotal(cl_elec_pln_kwh cl_elec_nonpln_kwh), missing
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L348:step-egen" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 324 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L349:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 325 389 `=_rc' // WFLOG-INJECTED
generate double gj_electricity=elec_purchased_kwh*.0036
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L349:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 325 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L350:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 326 389 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_s1=elec_purchased_kwh*grid_factor_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L350:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 326 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L351:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 327 389 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_s2=elec_purchased_kwh*grid_factor_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L351:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 327 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L352:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 328 389 `=_rc' // WFLOG-INJECTED
generate double co2_total_s1=co2_scope1_s1+co2_scope2_s1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L352:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 328 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L353:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 329 389 `=_rc' // WFLOG-INJECTED
generate double co2_total_s2=co2_scope1_s2+co2_scope2_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L353:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 329 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L354:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 330 389 `=_rc' // WFLOG-INJECTED
generate double total_gj_s1=gj_fuel_s1+gj_electricity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L354:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 330 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L355:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 331 389 `=_rc' // WFLOG-INJECTED
generate double co2_scope1_complete=co2_scope1_s1 if nine_fuels_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L355:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 331 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L356:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 332 389 `=_rc' // WFLOG-INJECTED
generate double co2_scope2_complete=co2_scope2_s1 if electricity_n_observed==2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L356:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 332 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L357:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 333 389 `=_rc' // WFLOG-INJECTED
generate double co2_total_complete=co2_scope1_complete+co2_scope2_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L357:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 333 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L358:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 334 389 `=_rc' // WFLOG-INJECTED
generate double total_gj_complete=total_gj_s1 if nine_fuels_complete & electricity_n_observed==2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L358:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 334 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L359:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 335 389 `=_rc' // WFLOG-INJECTED
generate double co2_variant_static_grid=co2_scope1_s1+co2_scope2_s2
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L359:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 335 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L360:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 336 389 `=_rc' // WFLOG-INJECTED
generate byte own_generation_reported=cl_elec_owngen_kwh>0 & !missing(cl_elec_owngen_kwh)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L360:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 336 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L361:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 337 389 `=_rc' // WFLOG-INJECTED
generate byte own_generation_added=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L361:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 337 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L362:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 338 389 `=_rc' // WFLOG-INJECTED
generate byte extra_fuel_positive=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L362:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 338 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 339 389 `=_rc' "in" `"fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L364:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L364:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L363:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 339 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L366:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 340 389 `=_rc' // WFLOG-INJECTED
generate str80 energy_coverage_status="observed_components_only; absent_fuels_not_assumed_zero"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L366:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 340 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L367:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 341 389 `=_rc' // WFLOG-INJECTED
replace energy_coverage_status="nine_fuels_complete; additional_fuels_and_heat_not_certified" if nine_fuels_complete
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L367:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 341 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L368:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 342 389 `=_rc' // WFLOG-INJECTED
replace total_gj_per_worker=total_gj_s1/workers if workers>0 & !missing(workers)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L368:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 342 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L369:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 343 389 `=_rc' // WFLOG-INJECTED
replace co2_per_worker=co2_total_s1/workers if workers>0 & !missing(workers)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L369:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 343 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L370:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 344 389 `=_rc' // WFLOG-INJECTED
replace energy_intensity_gj_nominal=total_gj_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L370:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 344 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L371:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 345 389 `=_rc' // WFLOG-INJECTED
replace co2_intensity_nominal=co2_total_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L371:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 345 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L372:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 346 389 `=_rc' // WFLOG-INJECTED
replace ln_total_gj_s1=ln(total_gj_s1) if total_gj_s1>0 & !missing(total_gj_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L372:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 346 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L373:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 347 389 `=_rc' // WFLOG-INJECTED
replace ln_co2_total_s1=ln(co2_total_s1) if co2_total_s1>0 & !missing(co2_total_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L373:step-replace" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 347 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L374:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 348 389 `=_rc' // WFLOG-INJECTED
generate str32 g0_schema_version="20260910_variable_year_v2"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L374:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 348 389 `=_rc' // WFLOG-INJECTED
* Exact checks against sources, including unknowns and conditional universes.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L376:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 349 389 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L376:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 349 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L377:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 350 389 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L377:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 350 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L378:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 351 389 `=_rc' // WFLOG-INJECTED
assert missing(export_any_binary) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L378:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 351 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L379:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 352 389 `=_rc' // WFLOG-INJECTED
assert missing(export_flag) if export_direct_flag==0 & !export_share_valid
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L379:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 352 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L380:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 353 389 `=_rc' // WFLOG-INJECTED
assert missing(export_flag) if export_verified_conflict
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L380:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 353 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L381:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 354 389 `=_rc' // WFLOG-INJECTED
assert missing(export_any_binary) if export_binary_raw==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L381:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 354 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L382:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 355 389 `=_rc' // WFLOG-INJECTED
assert inlist(export_flag,0,1) if !missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L382:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 355 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 356 389 `=_rc' "in" `"waste_solid_flag waste_liquid_flag waste_hazardous_flag"' // WFLOG-INJECTED
* Ulangi blok untuk f: waste_solid_flag, waste_liquid_flag, waste_hazardous_flag. // WFDOC-INJECTED
foreach f in waste_solid_flag waste_liquid_flag waste_hazardous_flag {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L384:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 assert missing(`f') if source_year!=2022 | real(raw_inspli22)!=7
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L384:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L383:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 356 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 357 389 `=_rc' "in" `"17 18 19 20 21 22"' // WFLOG-INJECTED
* Ulangi blok untuk setiap yy yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach yy in 17 18 19 20 21 22 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L387:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 assert rd_cost_nominal==real(subinstr(strtrim(raw_irdvcu`yy'),",","",.)) if source_year==2000+`yy'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L387:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L386:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 357 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 358 389 `=_rc' "in" `"2017 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk yy: 2017, 2020, 2021, 2022. // WFDOC-INJECTED
foreach yy in 2017 2020 2021 2022 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L390:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 assert fuel_coal_kg==legacy_fuel_coal_alias*1000 if source_year==`yy'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L390:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L389:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 358 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L392:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 359 389 `=_rc' // WFLOG-INJECTED
assert fuel_coke_kg==legacy_fuel_coke_alias*1000 if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L392:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 359 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L393:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 360 389 `=_rc' // WFLOG-INJECTED
assert missing(fuel_natgas_kg) & missing(fuel_charcoal_kg) if source_year>=2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L393:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 360 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L394:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 361 389 `=_rc' // WFLOG-INJECTED
assert abs(co2_total_s1-co2_scope1_s1-co2_scope2_s1)<.000001 if !missing(co2_total_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L394:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 361 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L395:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 362 389 `=_rc' // WFLOG-INJECTED
assert abs(total_gj_s1-gj_fuel_s1-gj_electricity)<.000001 if !missing(total_gj_s1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L395:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 362 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L396:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 363 389 `=_rc' // WFLOG-INJECTED
assert missing(ln_rd_cost_nominal) if rd_cost_nominal<=0 | missing(rd_cost_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L396:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 363 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L397:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 364 389 `=_rc' // WFLOG-INJECTED
assert missing(rd_cost_per_worker_nominal) if workers<=0 | missing(workers)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L397:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 364 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L398:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 365 389 `=_rc' // WFLOG-INJECTED
assert deflator_applied==0 & missing(gross_output_real,value_added_real)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L398:step-assert" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 365 389 `=_rc' // WFLOG-INJECTED
* All original raw fields must be identical, including strings and masked values.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L400:step-sort" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 366 389 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L400:step-sort" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 366 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L401:step-cf" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 367 389 `=_rc' // WFLOG-INJECTED
cf source_year source_row raw_* using "`baseline'", all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L401:step-cf" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 367 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L402:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 368 389 `=_rc' // WFLOG-INJECTED
display "G0_V2_RAW_PRESERVATION_PASS"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L402:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 368 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L403:step-save" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 369 389 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/G0_main_verified_20260910.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L403:step-save" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 369 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L404:step-tempfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 370 389 `=_rc' // WFLOG-INJECTED
tempfile final
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L404:step-tempfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 370 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L405:step-save" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 371 389 `=_rc' // WFLOG-INJECTED
save `final'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L405:step-save" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 371 389 `=_rc' // WFLOG-INJECTED
* Stata controls, per year and field, retain all observations in denominator.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L407:step-tempfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 372 389 `=_rc' // WFLOG-INJECTED
tempfile coverage
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L407:step-tempfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 372 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L408:step-postfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 373 389 `=_rc' // WFLOG-INJECTED
postfile audit int source_year str32 variable long rows observed yes zeros using `coverage', replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L408:step-postfile" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 373 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 374 389 `=_rc' "in" `"2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"' // WFLOG-INJECTED
* Ulangi blok untuk setiap yy yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach yy in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L410:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
 quietly count if source_year==`yy'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L410:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L411:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
 local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L411:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "loop" 3 3 `=_rc' "in" `"export_flag export_any_binary export_direct_flag rd_activity_flag rd_external_funding_flag innovation_flag env_amdal_flag env_ukl_upl_flag env_sppl_flag env_waste_treatment_flag waste_solid_flag waste_liquid_flag waste_hazardous_flag rd_cost_nominal fuel_coal_kg fuel_natgas_mmbtu fuel_biomass_kg"' // WFLOG-INJECTED
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
 foreach v in export_flag export_any_binary export_direct_flag rd_activity_flag rd_external_funding_flag innovation_flag env_amdal_flag env_ukl_upl_flag env_sppl_flag env_waste_treatment_flag waste_solid_flag waste_liquid_flag waste_hazardous_flag rd_cost_nominal fuel_coal_kg fuel_natgas_mmbtu fuel_biomass_kg {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L413:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
  quietly count if source_year==`yy' & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L413:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L414:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
  local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L414:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L415:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
  quietly count if source_year==`yy' & `v'>0 & !missing(`v')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L415:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L416:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
  local pos=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L416:step-local" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L417:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
  quietly count if source_year==`yy' & `v'==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L417:step-count" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L418:step-post" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
  post audit (`yy') ("`v'") (`n') (`obs') (`pos') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L418:step-post" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L412:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "loop" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:iteration-body" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L409:step-foreach" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "loop" 374 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L421:step-postclose" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 375 389 `=_rc' // WFLOG-INJECTED
postclose audit
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L421:step-postclose" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 375 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L422:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 376 389 `=_rc' // WFLOG-INJECTED
use `coverage', clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L422:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 376 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L423:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 377 389 `=_rc' // WFLOG-INJECTED
isid source_year variable
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L423:step-isid" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 377 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L424:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 378 389 `=_rc' // WFLOG-INJECTED
generate double observed_pct=100*observed/rows
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L424:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 378 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L425:step-export" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 379 389 `=_rc' // WFLOG-INJECTED
export delimited using "$G0V/corrected_variable_coverage.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L425:step-export" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 379 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L426:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 380 389 `=_rc' // WFLOG-INJECTED
use `final', clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L426:step-use" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 380 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L427:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 381 389 `=_rc' // WFLOG-INJECTED
generate byte rd_cost_observed=!missing(rd_cost_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L427:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 381 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L428:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 382 389 `=_rc' // WFLOG-INJECTED
generate byte rd_cost_positive=rd_cost_nominal>0 & !missing(rd_cost_nominal)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L428:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 382 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L429:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 383 389 `=_rc' // WFLOG-INJECTED
generate byte exporter_observed=!missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L429:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 383 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L430:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 384 389 `=_rc' // WFLOG-INJECTED
generate byte exporter_yes=export_flag==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L430:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 384 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L431:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 385 389 `=_rc' // WFLOG-INJECTED
generate double coal_conversion_delta=fuel_coal_kg-legacy_fuel_coal_alias
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L431:step-generate" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 385 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L432:step-collapse" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 386 389 `=_rc' // WFLOG-INJECTED
collapse (count) rows=source_row (sum) rd_cost_observed rd_cost_positive exporter_observed exporter_yes export_verified_conflict (mean) mean_rd_expense=rd_cost_nominal mean_coal_conversion_delta=coal_conversion_delta, by(source_year)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L432:step-collapse" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 386 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L433:step-export" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 387 389 `=_rc' // WFLOG-INJECTED
export delimited using "$G0V/correction_year_summary.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L433:step-export" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 387 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L434:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 388 389 `=_rc' // WFLOG-INJECTED
display "G0_VERIFIED_CANDIDATE_SUCCESS"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L434:step-display" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 388 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L435:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 389 389 `=_rc' // WFLOG-INJECTED
log close
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L435:step-log" "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "statement" 389 389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
