* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta; dag/data/word_data/G0/variable_year/mapped_fields.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_verified_20260910.dta; dag/reports/word_data/G0/20260910-code-verification/corrected_variable_coverage.csv; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
set varabbrev off
set maxvar 10000
args root baseline
cd "`root'"
* Isi blok hanya dijalankan bila `"`baseline'"' sama dengan "". // WFDOC-INJECTED
if `"`baseline'"'=="" {
 display as error "WF_EXPLICIT_REGENERATED_BASELINE_REQUIRED"
 exit 198
}
global G0V "dag/reports/word_data/G0/20260910-code-verification"
capture log close
log using "$G0V/candidate_integration.log", text replace
use "`baseline'", clear
isid source_year source_row
assert _N==33049
clonevar legacy_rd_cost_mislabelled=rd_cost_nominal
clonevar legacy_export_share_flag=export_flag
clonevar legacy_total_gj_s1=total_gj_s1
clonevar legacy_co2_total_s1=co2_total_s1
clonevar legacy_fuel_coal_alias=fuel_coal_kg
clonevar legacy_fuel_coke_alias=fuel_coke_kg
clonevar legacy_fuel_natgas_alias=fuel_natgas_kg
clonevar legacy_fuel_charcoal_alias=fuel_charcoal_kg
drop amdal_raw b3wste_raw capital_additions_nominal capital_nominal capital_stock_nominal district_code elec_nonpln_kwh elec_nonpln_rp000 elec_owngen_kwh elec_pln_kwh elec_pln_rp000 export_binary_raw export_share_pct foreign_ownership_pct fuel_biodiesel_ltr fuel_biodiesel_rp000 fuel_charcoal_kg fuel_charcoal_rp000 fuel_citygas_m3 fuel_citygas_rp000 fuel_coal_kg fuel_coal_rp000 fuel_coalbriq_kg fuel_coalbriq_rp000 fuel_coke_kg fuel_coke_rp000 fuel_diesel_ltr fuel_diesel_rp000 fuel_dieseloil_ltr fuel_dieseloil_rp000 fuel_firewood_kg fuel_firewood_rp000 fuel_fueloil_ltr fuel_fueloil_rp000 fuel_kerosene_ltr fuel_kerosene_rp000 fuel_lpg_kg fuel_lpg_rp000 fuel_lubricant_ltr fuel_lubricant_rp000 fuel_natgas_kg fuel_natgas_rp000 fuel_other_rp000 fuel_othergas_m3 fuel_othergas_rp000 fuel_petrol_ltr fuel_petrol_rp000 fuel_total_reported_rp000 gross_output_nominal import_value_nominal industry_code innovation_marketing_raw innovation_org_raw innovation_process_raw innovation_product_raw innovation_raw inspli_raw intermediate_inputs_nominal liwste_raw pplihi_raw production_workers province_code rd_cost_nominal rd_indicator_raw rd_workers source_id_raw sowste_raw spplhi_raw val_cbdacu val_cbfpcu val_cbsacu val_cbttcu val_cldacu val_clfpcu val_clsacu val_clttcu val_cmdacu val_cmfpcu val_cmsacu val_cmttcu val_codacu val_cofpcu val_cosacu val_costrd val_cottcu val_csdacu val_csfpcu val_cssacu val_csttcu val_ctdacu val_ctfpcu val_ctsacu val_cttcu val_ctttcu val_cvdacu val_cvfpcu val_cvsacu val_cvttcu val_devvcu val_ecavce val_ecavcu val_ecbvce val_ecbvcu val_eckvce val_eckvcu val_eclvce val_eclvcu val_edivce val_edivcu val_efovce val_efovcu val_efuvce val_efuvcu val_egavce val_egavcu val_egovce val_egovcu val_elpvce val_elpvcu val_eluvce val_eluvcu val_encvce val_encvcu val_engvce val_engvcu val_enpvcu val_eoivce val_eoivcu val_epevce val_epevcu val_eplvcu val_esdvce val_esdvcu val_esovce val_esovcu val_ibrvcu val_icovcu val_idevcu val_iinput val_iinvcu val_iisfov val_iislov val_iisvcu val_ikivcu val_iklvcu val_ikovcu val_ilrvcu val_insvcu val_intvcu val_iotvcu val_ipkvcu val_iprvcu val_irdvcu val_irevcu val_irrvcu val_itxvcu val_iuwvcu val_nopvcu val_othvcu val_output val_rdnvcu val_renvcu val_rimvcu val_rtlvcu val_sfbvcu val_sfcvcu val_sfdvcu val_sfgvcu val_sfjvcu val_sfkvcu val_sfnvcu val_sfovcu val_sfrvcu val_sfsvcu val_sfuvcu val_shdvcu val_shfvcu val_shjvcu val_srdvcu val_srjvcu val_srmvcu val_stdvcu val_stjvcu val_stlvcu val_vtlvcu val_yelvcu val_yisvcu val_yisvdo val_yisvfo val_ykdvcu val_ykfvcu val_ykivcu val_yprvcu val_yrnvcu val_yrsvcu val_ysnvcu val_ytovcu val_znavcu val_zndvcu val_znevcu val_znhvcu val_znivcu val_znovcu val_znpvcu val_znrvcu val_znsvcu val_zntvcu val_zpavcu val_zpdvcu val_zpevcu val_zphvcu val_zpivcu val_zpovcu val_zppvcu val_zprvcu val_zpsvcu val_zptvcu value_added_nominal workers
merge 1:1 source_year source_row using "dag/data/word_data/G0/variable_year/mapped_fields.dta", assert(match) nogen
replace st_amdal_raw=vs_amdal_raw
replace st_b3wste_raw=vs_b3wste_raw
replace st_capital_additions_nominal=vs_capital_additions_nominal
replace st_capital_nominal=vs_capital_nominal
replace st_capital_stock_nominal=vs_capital_stock_nominal
replace st_elec_nonpln_kwh=vs_elec_nonpln_kwh
replace st_elec_nonpln_rp000=vs_elec_nonpln_rp000
replace st_elec_owngen_kwh=vs_elec_owngen_kwh
replace st_elec_pln_kwh=vs_elec_pln_kwh
replace st_elec_pln_rp000=vs_elec_pln_rp000
replace st_export_binary_raw=vs_export_binary_raw
replace st_export_share_pct=vs_export_share_pct
replace st_foreign_ownership_pct=vs_foreign_ownership_pct
replace st_fuel_biodiesel_ltr=vs_fuel_biodiesel_ltr
replace st_fuel_biodiesel_rp000=vs_fuel_biodiesel_rp000
replace st_fuel_charcoal_kg=vs_fuel_charcoal_kg
replace st_fuel_charcoal_rp000=vs_fuel_charcoal_rp000
replace st_fuel_citygas_m3=vs_fuel_citygas_m3
replace st_fuel_citygas_rp000=vs_fuel_citygas_rp000
replace st_fuel_coal_kg=vs_fuel_coal_kg
replace st_fuel_coal_rp000=vs_fuel_coal_rp000
replace st_fuel_coalbriq_kg=vs_fuel_coalbriq_kg
replace st_fuel_coalbriq_rp000=vs_fuel_coalbriq_rp000
replace st_fuel_coke_kg=vs_fuel_coke_kg
replace st_fuel_coke_rp000=vs_fuel_coke_rp000
replace st_fuel_diesel_ltr=vs_fuel_diesel_ltr
replace st_fuel_diesel_rp000=vs_fuel_diesel_rp000
replace st_fuel_dieseloil_ltr=vs_fuel_dieseloil_ltr
replace st_fuel_dieseloil_rp000=vs_fuel_dieseloil_rp000
replace st_fuel_firewood_kg=vs_fuel_firewood_kg
replace st_fuel_firewood_rp000=vs_fuel_firewood_rp000
replace st_fuel_fueloil_ltr=vs_fuel_fueloil_ltr
replace st_fuel_fueloil_rp000=vs_fuel_fueloil_rp000
replace st_fuel_kerosene_ltr=vs_fuel_kerosene_ltr
replace st_fuel_kerosene_rp000=vs_fuel_kerosene_rp000
replace st_fuel_lpg_kg=vs_fuel_lpg_kg
replace st_fuel_lpg_rp000=vs_fuel_lpg_rp000
replace st_fuel_lubricant_ltr=vs_fuel_lubricant_ltr
replace st_fuel_lubricant_rp000=vs_fuel_lubricant_rp000
replace st_fuel_natgas_kg=vs_fuel_natgas_kg
replace st_fuel_natgas_rp000=vs_fuel_natgas_rp000
replace st_fuel_other_rp000=vs_fuel_other_rp000
replace st_fuel_othergas_m3=vs_fuel_othergas_m3
replace st_fuel_othergas_rp000=vs_fuel_othergas_rp000
replace st_fuel_petrol_ltr=vs_fuel_petrol_ltr
replace st_fuel_petrol_rp000=vs_fuel_petrol_rp000
replace st_fuel_total_reported_rp000=vs_fuel_total_reported_rp000
replace st_gross_output_nominal=vs_gross_output_nominal
replace st_import_value_nominal=vs_import_value_nominal
replace st_innovation_marketing_raw=vs_innovation_marketing_raw
replace st_innovation_org_raw=vs_innovation_org_raw
replace st_innovation_process_raw=vs_innovation_process_raw
replace st_innovation_product_raw=vs_innovation_product_raw
replace st_innovation_raw=vs_innovation_raw
replace st_inspli_raw=vs_inspli_raw
replace st_intermediate_inputs_nominal=vs_intermediate_inputs_nominal
replace st_liwste_raw=vs_liwste_raw
replace st_pplihi_raw=vs_pplihi_raw
replace st_production_workers=vs_production_workers
replace st_rd_cost_nominal=vs_rd_cost_nominal
replace st_rd_indicator_raw=vs_rd_indicator_raw
replace st_rd_workers=vs_rd_workers
replace st_sowste_raw=vs_sowste_raw
replace st_spplhi_raw=vs_spplhi_raw
replace st_val_cbdacu=vs_val_cbdacu
replace st_val_cbfpcu=vs_val_cbfpcu
replace st_val_cbsacu=vs_val_cbsacu
replace st_val_cbttcu=vs_val_cbttcu
replace st_val_cldacu=vs_val_cldacu
replace st_val_clfpcu=vs_val_clfpcu
replace st_val_clsacu=vs_val_clsacu
replace st_val_clttcu=vs_val_clttcu
replace st_val_cmdacu=vs_val_cmdacu
replace st_val_cmfpcu=vs_val_cmfpcu
replace st_val_cmsacu=vs_val_cmsacu
replace st_val_cmttcu=vs_val_cmttcu
replace st_val_codacu=vs_val_codacu
replace st_val_cofpcu=vs_val_cofpcu
replace st_val_cosacu=vs_val_cosacu
replace st_val_costrd=vs_val_costrd
replace st_val_cottcu=vs_val_cottcu
replace st_val_csdacu=vs_val_csdacu
replace st_val_csfpcu=vs_val_csfpcu
replace st_val_cssacu=vs_val_cssacu
replace st_val_csttcu=vs_val_csttcu
replace st_val_ctdacu=vs_val_ctdacu
replace st_val_ctfpcu=vs_val_ctfpcu
replace st_val_ctsacu=vs_val_ctsacu
replace st_val_cttcu=vs_val_cttcu
replace st_val_ctttcu=vs_val_ctttcu
replace st_val_cvdacu=vs_val_cvdacu
replace st_val_cvfpcu=vs_val_cvfpcu
replace st_val_cvsacu=vs_val_cvsacu
replace st_val_cvttcu=vs_val_cvttcu
replace st_val_devvcu=vs_val_devvcu
replace st_val_ecavce=vs_val_ecavce
replace st_val_ecavcu=vs_val_ecavcu
replace st_val_ecbvce=vs_val_ecbvce
replace st_val_ecbvcu=vs_val_ecbvcu
replace st_val_eckvce=vs_val_eckvce
replace st_val_eckvcu=vs_val_eckvcu
replace st_val_eclvce=vs_val_eclvce
replace st_val_eclvcu=vs_val_eclvcu
replace st_val_edivce=vs_val_edivce
replace st_val_edivcu=vs_val_edivcu
replace st_val_efovce=vs_val_efovce
replace st_val_efovcu=vs_val_efovcu
replace st_val_efuvce=vs_val_efuvce
replace st_val_efuvcu=vs_val_efuvcu
replace st_val_egavce=vs_val_egavce
replace st_val_egavcu=vs_val_egavcu
replace st_val_egovce=vs_val_egovce
replace st_val_egovcu=vs_val_egovcu
replace st_val_elpvce=vs_val_elpvce
replace st_val_elpvcu=vs_val_elpvcu
replace st_val_eluvce=vs_val_eluvce
replace st_val_eluvcu=vs_val_eluvcu
replace st_val_encvce=vs_val_encvce
replace st_val_encvcu=vs_val_encvcu
replace st_val_engvce=vs_val_engvce
replace st_val_engvcu=vs_val_engvcu
replace st_val_enpvcu=vs_val_enpvcu
replace st_val_eoivce=vs_val_eoivce
replace st_val_eoivcu=vs_val_eoivcu
replace st_val_epevce=vs_val_epevce
replace st_val_epevcu=vs_val_epevcu
replace st_val_eplvcu=vs_val_eplvcu
replace st_val_esdvce=vs_val_esdvce
replace st_val_esdvcu=vs_val_esdvcu
replace st_val_esovce=vs_val_esovce
replace st_val_esovcu=vs_val_esovcu
replace st_val_ibrvcu=vs_val_ibrvcu
replace st_val_icovcu=vs_val_icovcu
replace st_val_idevcu=vs_val_idevcu
replace st_val_iinput=vs_val_iinput
replace st_val_iinvcu=vs_val_iinvcu
replace st_val_iisfov=vs_val_iisfov
replace st_val_iislov=vs_val_iislov
replace st_val_iisvcu=vs_val_iisvcu
replace st_val_ikivcu=vs_val_ikivcu
replace st_val_iklvcu=vs_val_iklvcu
replace st_val_ikovcu=vs_val_ikovcu
replace st_val_ilrvcu=vs_val_ilrvcu
replace st_val_insvcu=vs_val_insvcu
replace st_val_intvcu=vs_val_intvcu
replace st_val_iotvcu=vs_val_iotvcu
replace st_val_ipkvcu=vs_val_ipkvcu
replace st_val_iprvcu=vs_val_iprvcu
replace st_val_irdvcu=vs_val_irdvcu
replace st_val_irevcu=vs_val_irevcu
replace st_val_irrvcu=vs_val_irrvcu
replace st_val_itxvcu=vs_val_itxvcu
replace st_val_iuwvcu=vs_val_iuwvcu
replace st_val_nopvcu=vs_val_nopvcu
replace st_val_othvcu=vs_val_othvcu
replace st_val_output=vs_val_output
replace st_val_rdnvcu=vs_val_rdnvcu
replace st_val_renvcu=vs_val_renvcu
replace st_val_rimvcu=vs_val_rimvcu
replace st_val_rtlvcu=vs_val_rtlvcu
replace st_val_sfbvcu=vs_val_sfbvcu
replace st_val_sfcvcu=vs_val_sfcvcu
replace st_val_sfdvcu=vs_val_sfdvcu
replace st_val_sfgvcu=vs_val_sfgvcu
replace st_val_sfjvcu=vs_val_sfjvcu
replace st_val_sfkvcu=vs_val_sfkvcu
replace st_val_sfnvcu=vs_val_sfnvcu
replace st_val_sfovcu=vs_val_sfovcu
replace st_val_sfrvcu=vs_val_sfrvcu
replace st_val_sfsvcu=vs_val_sfsvcu
replace st_val_sfuvcu=vs_val_sfuvcu
replace st_val_shdvcu=vs_val_shdvcu
replace st_val_shfvcu=vs_val_shfvcu
replace st_val_shjvcu=vs_val_shjvcu
replace st_val_srdvcu=vs_val_srdvcu
replace st_val_srjvcu=vs_val_srjvcu
replace st_val_srmvcu=vs_val_srmvcu
replace st_val_stdvcu=vs_val_stdvcu
replace st_val_stjvcu=vs_val_stjvcu
replace st_val_stlvcu=vs_val_stlvcu
replace st_val_vtlvcu=vs_val_vtlvcu
replace st_val_yelvcu=vs_val_yelvcu
replace st_val_yisvcu=vs_val_yisvcu
replace st_val_yisvdo=vs_val_yisvdo
replace st_val_yisvfo=vs_val_yisvfo
replace st_val_ykdvcu=vs_val_ykdvcu
replace st_val_ykfvcu=vs_val_ykfvcu
replace st_val_ykivcu=vs_val_ykivcu
replace st_val_yprvcu=vs_val_yprvcu
replace st_val_yrnvcu=vs_val_yrnvcu
replace st_val_yrsvcu=vs_val_yrsvcu
replace st_val_ysnvcu=vs_val_ysnvcu
replace st_val_ytovcu=vs_val_ytovcu
replace st_val_znavcu=vs_val_znavcu
replace st_val_zndvcu=vs_val_zndvcu
replace st_val_znevcu=vs_val_znevcu
replace st_val_znhvcu=vs_val_znhvcu
replace st_val_znivcu=vs_val_znivcu
replace st_val_znovcu=vs_val_znovcu
replace st_val_znpvcu=vs_val_znpvcu
replace st_val_znrvcu=vs_val_znrvcu
replace st_val_znsvcu=vs_val_znsvcu
replace st_val_zntvcu=vs_val_zntvcu
replace st_val_zpavcu=vs_val_zpavcu
replace st_val_zpdvcu=vs_val_zpdvcu
replace st_val_zpevcu=vs_val_zpevcu
replace st_val_zphvcu=vs_val_zphvcu
replace st_val_zpivcu=vs_val_zpivcu
replace st_val_zpovcu=vs_val_zpovcu
replace st_val_zppvcu=vs_val_zppvcu
replace st_val_zprvcu=vs_val_zprvcu
replace st_val_zpsvcu=vs_val_zpsvcu
replace st_val_zptvcu=vs_val_zptvcu
replace st_value_added_nominal=vs_value_added_nominal
replace st_workers=vs_workers
* Explicit dictionary correction: monetary R&D is IRDVCU, not COSTRD.
label variable rd_cost_nominal "Reported R&D expense IRDVCU, nominal Rp000; excludes specified worker costs"
label variable legacy_rd_cost_mislabelled "ARCHIVE: COSTRD code previously mislabeled as R&D expense; do not use as money"
generate str80 rd_cost_definition_status="source_absent"
replace rd_cost_definition_status="IRDVCU reported expense, distinct from COSTRD funding indicator" if source_year>=2017
replace rd_cost_per_worker_nominal=.
replace rd_cost_per_worker_nominal=rd_cost_nominal/workers if workers>0 & !missing(workers,rd_cost_nominal)
replace ln_rd_cost_nominal=.
replace ln_rd_cost_nominal=ln(rd_cost_nominal) if rd_cost_nominal>0 & !missing(rd_cost_nominal)
label variable val_costrd "COSTRD source code: third-party R&D funding, not an amount"
replace ln_val_costrd=.
replace pw_val_costrd=.
label variable ln_val_costrd "Retired: logarithm of a category code has no monetary interpretation"
label variable pw_val_costrd "Retired: category code / workers is not spending intensity"
* Broad exporter status, keeping contradictory evidence visible.
generate byte export_verified_conflict=0
replace export_verified_conflict=1 if export_share_valid & !missing(export_any_binary) & (export_share_pct>0)!=export_any_binary
replace export_verified_conflict=1 if export_share_valid & export_share_pct==0 & export_direct_flag==1
replace export_flag=.
replace export_flag=export_share_pct>0 if export_share_valid
replace export_flag=export_any_binary if missing(export_flag) & !missing(export_any_binary)
replace export_flag=1 if missing(export_flag) & export_direct_flag==1
replace export_flag=. if export_verified_conflict
replace export_observed=!missing(export_flag)
replace export_binary_valid=inlist(export_binary_raw,1,2) & (!missing(export_any_binary) | !missing(export_direct_flag))
label variable export_binary_valid "In verified annual 1=yes/2=no domain; 2022 question is direct only"
replace export_definition_status="no_supported_observation"
replace export_definition_status="share_observed; binary_annual_evidence_incomplete" if export_share_valid
replace export_definition_status="verified_any_export_binary" if !missing(export_any_binary)
replace export_definition_status="direct_export_yes_implies_any_export_yes" if export_direct_flag==1
replace export_definition_status="direct_export_no; indirect_export_unknown" if export_direct_flag==0 & !export_share_valid
replace export_definition_status="conflicting_verified_sources; retained_for_review" if export_verified_conflict
label variable export_flag "Any export: supported share/binary or direct yes; conflict and unknown missing"
label variable export_direct_flag "2022 only: direct export 1=yes 0=no; no says nothing about indirect exports"
label variable export_any_binary "Verified any-export question, 1=yes 0=no; excludes direct-only 2022"
label variable rd_activity_flag "R&D activity: 2011 general; later own R&D, annual verified code pairs"
label variable rd_external_funding_flag "Funds R&D conducted by another party, 1=yes 0=no"
label variable innovation_flag "General innovation indicator, 1=yes 0=no; annual questionnaire wording"
label variable env_amdal_flag "AMDAL present 1, not yet present 0"
label variable env_ukl_upl_flag "UKL/UPL present 1, not yet present 0; raw codes 3/4"
label variable env_sppl_flag "SPPL present 1, not yet present 0; raw codes 5/6"
label variable env_waste_treatment_flag "Waste installation 2020/21 or treatment 2022; raw codes 7/8"
* Update physical quantities and only the energy calculations that depend on them.
* Ulangi blok untuk f: coal, coke, natgas, charcoal. // WFDOC-INJECTED
foreach f in coal coke natgas charcoal {
 replace cl_fuel_`f'_kg=.
 replace cl_fuel_`f'_kg=fuel_`f'_kg if fuel_`f'_kg>=0 & !missing(fuel_`f'_kg)
 replace price_`f'=.
 replace price_`f'=fuel_`f'_rp000/fuel_`f'_kg if fuel_`f'_kg>0 & !missing(fuel_`f'_kg,fuel_`f'_rp000) & fuel_`f'_rp000>=0
 drop p99_`f'
 bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
}
generate byte coal_unit_verified=inrange(source_year,2010,2015) | inlist(source_year,2017,2020,2021,2022)
generate str16 coal_source_unit=cond(source_year<=2015,"kg",cond(coal_unit_verified,"tonne","unverified"))
label variable fuel_coal_kg "Coal kg; tonnes converted where annual unit verified; check coal_unit_verified"
label variable fuel_natgas_kg "Retired for 2020–22: source unit is MMBTU; use fuel_natgas_mmbtu"
label variable fuel_charcoal_kg "Retired for 2020–22: source is mixed biomass; use fuel_biomass_kg"
label variable fuel_natgas_mmbtu "2020–22 natural gas quantity, MMBTU; not kg"
label variable fuel_biomass_kg "2020–22 mixed biomass, tonnes converted to kg; not pure charcoal"
replace unit_status="annual source units partly verified; see variable/year evidence"
drop co2_scope1_nfuels_s1
drop co2_scope1_s1
drop co2_scope1_s2
drop gj_fuel_s1
drop nine_fuels_complete
drop electricity_n_observed
drop elec_purchased_kwh
drop gj_electricity
drop co2_scope2_s1
drop co2_scope2_s2
drop co2_total_s1
drop co2_total_s2
drop total_gj_s1
drop co2_scope1_complete
drop co2_scope2_complete
drop co2_total_complete
drop total_gj_complete
drop co2_variant_static_grid
drop own_generation_reported
drop own_generation_added
drop extra_fuel_positive
drop energy_coverage_status
* Ulangi blok untuk setiap f yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke {
 drop co2_`f'_s1 co2_`f'_s2 gj_`f'
}
local fuels "diesel petrol kerosene coal lpg citygas othergas coalbriq coke"
local units "ltr ltr ltr kg kg m3 m3 kg kg"
local c1 ".002654 .00231 .002494 .002496 .002876 .002695 .002695 .002877 .00284"
local c2 ".002978 .002479 .002616 .002448 .003293 .00219 .00219 .002032 .002907"
local gj ".035697 .033225 .034559 .0262 .045544 .048 .048 .029308 .026377"
* Ulangi blok untuk setiap i dari 1 sampai 9. // WFDOC-INJECTED
forvalues i=1/9 {
    local f: word `i' of `fuels'
    local u: word `i' of `units'
    local a: word `i' of `c1'
    local b: word `i' of `c2'
    local c: word `i' of `gj'
    generate double co2_`f'_s1=cl_fuel_`f'_`u'*`a'
    generate double co2_`f'_s2=cl_fuel_`f'_`u'*`b'
    generate double gj_`f'=cl_fuel_`f'_`u'*`c'
}
egen byte co2_scope1_nfuels_s1=rownonmiss(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1)
egen double co2_scope1_s1=rowtotal(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1), missing
egen double co2_scope1_s2=rowtotal(co2_diesel_s2 co2_petrol_s2 co2_kerosene_s2 co2_coal_s2 co2_lpg_s2 co2_citygas_s2 co2_othergas_s2 co2_coalbriq_s2 co2_coke_s2), missing
egen double gj_fuel_s1=rowtotal(gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke), missing
generate byte nine_fuels_complete=co2_scope1_nfuels_s1==9
egen byte electricity_n_observed=rownonmiss(cl_elec_pln_kwh cl_elec_nonpln_kwh)
egen double elec_purchased_kwh=rowtotal(cl_elec_pln_kwh cl_elec_nonpln_kwh), missing
generate double gj_electricity=elec_purchased_kwh*.0036
generate double co2_scope2_s1=elec_purchased_kwh*grid_factor_s1
generate double co2_scope2_s2=elec_purchased_kwh*grid_factor_s2
generate double co2_total_s1=co2_scope1_s1+co2_scope2_s1
generate double co2_total_s2=co2_scope1_s2+co2_scope2_s2
generate double total_gj_s1=gj_fuel_s1+gj_electricity
generate double co2_scope1_complete=co2_scope1_s1 if nine_fuels_complete
generate double co2_scope2_complete=co2_scope2_s1 if electricity_n_observed==2
generate double co2_total_complete=co2_scope1_complete+co2_scope2_complete
generate double total_gj_complete=total_gj_s1 if nine_fuels_complete & electricity_n_observed==2
generate double co2_variant_static_grid=co2_scope1_s1+co2_scope2_s2
generate byte own_generation_reported=cl_elec_owngen_kwh>0 & !missing(cl_elec_owngen_kwh)
generate byte own_generation_added=0
generate byte extra_fuel_positive=0
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg {
    replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
}
generate str80 energy_coverage_status="observed_components_only; absent_fuels_not_assumed_zero"
replace energy_coverage_status="nine_fuels_complete; additional_fuels_and_heat_not_certified" if nine_fuels_complete
replace total_gj_per_worker=total_gj_s1/workers if workers>0 & !missing(workers)
replace co2_per_worker=co2_total_s1/workers if workers>0 & !missing(workers)
replace energy_intensity_gj_nominal=total_gj_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal)
replace co2_intensity_nominal=co2_total_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal)
replace ln_total_gj_s1=ln(total_gj_s1) if total_gj_s1>0 & !missing(total_gj_s1)
replace ln_co2_total_s1=ln(co2_total_s1) if co2_total_s1>0 & !missing(co2_total_s1)
generate str32 g0_schema_version="20260910_variable_year_v2"
* Exact checks against sources, including unknowns and conditional universes.
isid source_year source_row
assert _N==33049
assert missing(export_any_binary) if source_year==2022
assert missing(export_flag) if export_direct_flag==0 & !export_share_valid
assert missing(export_flag) if export_verified_conflict
assert missing(export_any_binary) if export_binary_raw==0
assert inlist(export_flag,0,1) if !missing(export_flag)
* Ulangi blok untuk f: waste_solid_flag, waste_liquid_flag, waste_hazardous_flag. // WFDOC-INJECTED
foreach f in waste_solid_flag waste_liquid_flag waste_hazardous_flag {
 assert missing(`f') if source_year!=2022 | real(raw_inspli22)!=7
}
* Ulangi blok untuk setiap yy yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach yy in 17 18 19 20 21 22 {
 assert rd_cost_nominal==real(subinstr(strtrim(raw_irdvcu`yy'),",","",.)) if source_year==2000+`yy'
}
* Ulangi blok untuk yy: 2017, 2020, 2021, 2022. // WFDOC-INJECTED
foreach yy in 2017 2020 2021 2022 {
 assert fuel_coal_kg==legacy_fuel_coal_alias*1000 if source_year==`yy'
}
assert fuel_coke_kg==legacy_fuel_coke_alias*1000 if source_year==2022
assert missing(fuel_natgas_kg) & missing(fuel_charcoal_kg) if source_year>=2020
assert abs(co2_total_s1-co2_scope1_s1-co2_scope2_s1)<.000001 if !missing(co2_total_s1)
assert abs(total_gj_s1-gj_fuel_s1-gj_electricity)<.000001 if !missing(total_gj_s1)
assert missing(ln_rd_cost_nominal) if rd_cost_nominal<=0 | missing(rd_cost_nominal)
assert missing(rd_cost_per_worker_nominal) if workers<=0 | missing(workers)
assert deflator_applied==0 & missing(gross_output_real,value_added_real)
* All original raw fields must be identical, including strings and masked values.
sort source_year source_row
cf source_year source_row raw_* using "`baseline'", all
display "G0_V2_RAW_PRESERVATION_PASS"
save "dag/data/word_data/G0/G0_main_verified_20260910.dta", replace
tempfile final
save `final'
* Stata controls, per year and field, retain all observations in denominator.
tempfile coverage
postfile audit int source_year str32 variable long rows observed yes zeros using `coverage', replace
* Ulangi blok untuk setiap yy yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach yy in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
 quietly count if source_year==`yy'
 local n=r(N)
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
 foreach v in export_flag export_any_binary export_direct_flag rd_activity_flag rd_external_funding_flag innovation_flag env_amdal_flag env_ukl_upl_flag env_sppl_flag env_waste_treatment_flag waste_solid_flag waste_liquid_flag waste_hazardous_flag rd_cost_nominal fuel_coal_kg fuel_natgas_mmbtu fuel_biomass_kg {
  quietly count if source_year==`yy' & !missing(`v')
  local obs=r(N)
  quietly count if source_year==`yy' & `v'>0 & !missing(`v')
  local pos=r(N)
  quietly count if source_year==`yy' & `v'==0
  post audit (`yy') ("`v'") (`n') (`obs') (`pos') (r(N))
 }
}
postclose audit
use `coverage', clear
isid source_year variable
generate double observed_pct=100*observed/rows
export delimited using "$G0V/corrected_variable_coverage.csv", replace
use `final', clear
generate byte rd_cost_observed=!missing(rd_cost_nominal)
generate byte rd_cost_positive=rd_cost_nominal>0 & !missing(rd_cost_nominal)
generate byte exporter_observed=!missing(export_flag)
generate byte exporter_yes=export_flag==1
generate double coal_conversion_delta=fuel_coal_kg-legacy_fuel_coal_alias
collapse (count) rows=source_row (sum) rd_cost_observed rd_cost_positive exporter_observed exporter_yes export_verified_conflict (mean) mean_rd_expense=rd_cost_nominal mean_coal_conversion_delta=coal_conversion_delta, by(source_year)
export delimited using "$G0V/correction_year_summary.csv", replace
display "G0_VERIFIED_CANDIDATE_SUCCESS"
log close
