* SYNTHETIC ONLY. Supplied IDs are the linkage; never randomise or truncate them.
log using "dag/logs/G0_fixture_identity.log", text replace
use "dag/data/word_data/G0/G0_main_candidate.dta", clear
assert _N==1200
isid source_year source_row
assert strlen(source_id_raw)==6
assert inrange(real(source_id_raw),800001,800100)
generate double selected_firm_id=real(source_id_raw)
generate long dummy_firm_id=selected_firm_id
isid selected_firm_id source_year
bysort selected_firm_id: assert _N==12
assert selected_firm_id==800000+source_row
generate str8 identity_mode="dummy"
generate byte identity_is_dummy=1
generate byte identity_real_link_verified=0
generate byte identity_xtset_ready=1
generate str64 selected_district_code="SYNTHETIC_P"+province_code+"_D"+district_code
generate str64 dummy_district_code=selected_district_code
generate str80 identity_eligibility="SYNTHETIC_only; supplied_fictional_links; no_real_firm_inference"
generate str80 identity_district_status="SYNTHETIC_source_codes; not_real_BPS_geography"
generate byte dummy_district_count=.
generate long identity_seed=.
generate str80 identity_method="SYNTHETIC_Excel_ID_preserved_verbatim; no_random_linkage"
generate str2 demo_province=province_code
generate str2 demo_industry2=substr(industry_code,1,2)
generate long demo_slot=selected_firm_id-800000
generate byte demo_district_slot=.
replace panel_status="SYNTHETIC_supplied_firm_links; not_real_panel"
replace candidate_status="SYNTHETIC_G0_actual_WPI; VA_single_deflator_proxy"
replace g0_schema_version="SYNTHETIC_WPI_3837_v2"
replace analysis_contract="SYNTHETIC calculated input; fixed names; explicit provisional and missing sources"
label data "SYNTHETIC G0 CALCULATED FROM EXCEL; NOT REAL COMPANY OBSERVATIONS"
label variable source_id_raw "SYNTHETIC supplied six-digit firm ID preserved verbatim"
label variable selected_firm_id "SYNTHETIC supplied firm ID 800001-800100; fixed across years"
label variable selected_district_code "SYNTHETIC geography from supplied Excel codes; not BPS geography"
assert real_panel_ready==0 & identity_real_link_verified==0
xtset selected_firm_id source_year
do "dag/edges/G0_enforce_target_schema.do"
sort source_year source_row
save "results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta", replace
export delimited using "results/G0_analysis_ready_SYNTHETIC_CALCULATED.csv", replace nolabel
preserve
describe, replace clear
export delimited using "results/actual_schema.csv", replace
restore
display "SYNTHETIC_ID_PRESERVATION_PASS 1200 records; 100 supplied firms"
log close
