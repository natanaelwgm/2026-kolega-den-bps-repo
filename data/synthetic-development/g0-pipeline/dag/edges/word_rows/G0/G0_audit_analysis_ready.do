* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
version 17
clear all
set more off
set maxvar 10000
log using "dag/logs/word_data/G0/identity-options/G0_audit_analysis_ready.log", text replace
use "dag/data/word_data/G0/G0_analysis_ready.dta", clear
isid source_year source_row
isid selected_firm_id source_year
assert _N==1200
assert identity_is_dummy==1 & identity_real_link_verified==0
assert !missing(selected_firm_id) & selected_district_code!=""
xtset selected_firm_id source_year
preserve
    generate byte __id=!missing(selected_firm_id)
    generate byte __district=selected_district_code!=""
    collapse (count) rows=source_row (sum) id_observed=__id district_observed=__district, by(source_year)
    export delimited using "dag/reports/word_data/G0/identity-options/analysis_ready_coverage.csv", replace
restore
describe, replace clear
export delimited using "dag/reports/word_data/G0/identity-options/analysis_ready_schema.csv", replace
display "G0_ANALYSIS_READY_REOPEN_SUCCESS"
log close
