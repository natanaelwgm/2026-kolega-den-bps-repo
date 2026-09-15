* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
version 17
clear all
set more off
set varabbrev off
set maxvar 10000
args root
cd "`root'"
capture log close _all
log using "dag/reports/word_data/G0/20260910-code-verification/analysis_tunnel.log", text replace name(tunnel)
tempfile counts
postfile counts int source_year str32 variable long rows observed verified_only provisional using `counts', replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2010, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2010.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2010.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2010.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2011, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2011.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2011.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2011.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2012, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2012.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2012.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2012.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2013, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2013.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2013.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2013.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2014, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2014.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2014.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2014.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2015, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2015.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2015.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2015.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2017, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2017.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2017.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2018, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2018.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2018.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2018.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2019, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2019.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2019.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2019.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2020, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2020.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2020.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2021, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2021.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2021.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2021.dta", replace
use "dag/data/word_data/G0/G0_main_verified_20260910.dta" if source_year==2022, clear
do "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_product_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_org_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2022.do"
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2022.do"
keep source_year source_row export_any_binary rd_activity_flag rd_external_funding_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag innovation_flag export_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag v_innovation_product_flag v_innovation_process_flag v_innovation_marketing_flag v_innovation_org_flag v_innovation_flag v_export_flag vs_export_any_binary vs_rd_activity_flag vs_rd_external_funding_flag vs_innovation_product_flag vs_innovation_process_flag vs_innovation_marketing_flag vs_innovation_org_flag vs_innovation_flag vs_export_flag
save "dag/data/word_data/G0/analysis_tunnel/wave_2022.dta", replace
postclose counts
use `counts', clear
assert observed==verified_only+provisional
export delimited using "dag/reports/word_data/G0/20260910-code-verification/analysis_tunnel_coverage.csv", replace
use "dag/data/word_data/G0/analysis_tunnel/wave_2010.dta", clear
append using "dag/data/word_data/G0/analysis_tunnel/wave_2011.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2012.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2013.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2014.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2015.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2017.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2018.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2019.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2020.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2021.dta"
append using "dag/data/word_data/G0/analysis_tunnel/wave_2022.dta"
isid source_year source_row
assert _N==1200
tempfile tunnel
save `tunnel'
use "dag/data/word_data/G0/G0_main_verified_20260910.dta", clear
capture drop export_any_binary
capture drop vs_export_any_binary
capture drop rd_activity_flag
capture drop vs_rd_activity_flag
capture drop rd_external_funding_flag
capture drop vs_rd_external_funding_flag
capture drop innovation_product_flag
capture drop vs_innovation_product_flag
capture drop innovation_process_flag
capture drop vs_innovation_process_flag
capture drop innovation_marketing_flag
capture drop vs_innovation_marketing_flag
capture drop innovation_org_flag
capture drop vs_innovation_org_flag
capture drop innovation_flag
capture drop vs_innovation_flag
capture drop export_flag
capture drop vs_export_flag
merge 1:1 source_year source_row using `tunnel', assert(match) nogen
replace export_observed=!missing(export_flag)
generate byte export_assumption_conflict=export_share_valid & !missing(export_any_binary) & (export_share_pct>0)!=export_any_binary
replace export_definition_status="working_binary_1yes_2no; annual_code_evidence_pending" if vs_export_flag==10
replace g0_schema_version="20260910_analysis_tunnel_v3"
generate str80 analysis_contract="stable field names; working values + v_ verified-only + vs_=10 provisional"
label define G0_tunnel_state 0 "observed/verified" 1 "observed zero" 2 "negative" 3 "missing" 4 "source absent" 5 "parse failure" 6 "invalid code" 7 "code evidence missing" 8 "outside universe" 9 "retired incompatible alias" 10 "PROVISIONAL observed; assumption documented", replace
label values vs_export_any_binary G0_tunnel_state
label variable export_any_binary "Working standardized 0/1; inspect vs_export_any_binary (10=provisional)"
label variable v_export_any_binary "Verified-only companion to export_any_binary"
label values vs_rd_activity_flag G0_tunnel_state
label variable rd_activity_flag "Working standardized 0/1; inspect vs_rd_activity_flag (10=provisional)"
label variable v_rd_activity_flag "Verified-only companion to rd_activity_flag"
label values vs_rd_external_funding_flag G0_tunnel_state
label variable rd_external_funding_flag "Working standardized 0/1; inspect vs_rd_external_funding_flag (10=provisional)"
label variable v_rd_external_funding_flag "Verified-only companion to rd_external_funding_flag"
label values vs_innovation_product_flag G0_tunnel_state
label variable innovation_product_flag "Working standardized 0/1; inspect vs_innovation_product_flag (10=provisional)"
label variable v_innovation_product_flag "Verified-only companion to innovation_product_flag"
label values vs_innovation_process_flag G0_tunnel_state
label variable innovation_process_flag "Working standardized 0/1; inspect vs_innovation_process_flag (10=provisional)"
label variable v_innovation_process_flag "Verified-only companion to innovation_process_flag"
label values vs_innovation_marketing_flag G0_tunnel_state
label variable innovation_marketing_flag "Working standardized 0/1; inspect vs_innovation_marketing_flag (10=provisional)"
label variable v_innovation_marketing_flag "Verified-only companion to innovation_marketing_flag"
label values vs_innovation_org_flag G0_tunnel_state
label variable innovation_org_flag "Working standardized 0/1; inspect vs_innovation_org_flag (10=provisional)"
label variable v_innovation_org_flag "Verified-only companion to innovation_org_flag"
label values vs_innovation_flag G0_tunnel_state
label variable innovation_flag "Working standardized 0/1; inspect vs_innovation_flag (10=provisional)"
label variable v_innovation_flag "Verified-only companion to innovation_flag"
label values vs_export_flag G0_tunnel_state
label variable export_flag "Working standardized 0/1; inspect vs_export_flag (10=provisional)"
label variable v_export_flag "Verified-only companion to export_flag"
isid source_year source_row
assert _N==1200
sort source_year source_row
cf source_year source_row raw_* using "dag/data/word_data/G0/G0_main_verified_20260910.dta", all
assert missing(export_flag) if source_year==2022 & export_direct_flag==0 & !export_share_valid
save "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta", replace
copy "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta" "dag/data/word_data/G0/G0_main_candidate.dta", replace
display "G0_ANALYSIS_TUNNEL_SUCCESS"
log close tunnel
