* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/identity-options/G0_identity_spine_off.dta; dag/data/word_data/G0/G0_analysis_ready.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
set maxvar 10000
args dag_root identity_mode real_crosswalk
if `"`dag_root'"'=="" local dag_root "."
if `"`identity_mode'"'=="" local identity_mode "off"
cd "`dag_root'"
capture log close
log using "dag/logs/word_data/G0/identity-options/G0_publish_complete_identity_dataset.log", text replace
* One complete downstream file; existing owner-authorized synthetic identity method.
use "dag/data/word_data/G0/G0_main_candidate.dta", clear
quietly ds
local canonical_fields `r(varlist)'
do "dag/edges/word_rows/G0/G0_load_identity_view.do" "." "`identity_mode'" "`real_crosswalk'"
* Keep identity schema stable when dummy is switched off or replaced by real IDs.
* Ulangi blok untuk var: demo_province, demo_industry2. // WFDOC-INJECTED
foreach var in demo_province demo_industry2 {
    capture confirm variable `var'
    if _rc generate str2 `var'=""
}
capture confirm variable demo_slot
if _rc generate long demo_slot=.
capture confirm variable demo_district_slot
if _rc generate byte demo_district_slot=.
assert _N==33049
isid source_year source_row
if "`identity_mode'"!="off" isid selected_firm_id source_year
if "`identity_mode'"=="dummy" assert !missing(selected_firm_id) & !missing(dummy_firm_id)
if "`identity_mode'"=="dummy" assert selected_district_code!="" & dummy_district_code!=""
if "`identity_mode'"=="dummy" assert identity_is_dummy==1 & identity_real_link_verified==0
sort source_year source_row
cf `canonical_fields' using "dag/data/word_data/G0/G0_main_candidate.dta", all
save "dag/data/word_data/G0/G0_analysis_ready.dta", replace
use "dag/data/word_data/G0/G0_analysis_ready.dta", clear
isid source_year source_row
if "`identity_mode'"!="off" isid selected_firm_id source_year
assert _N==33049
if "`identity_mode'"=="dummy" assert identity_is_dummy==1 & identity_real_link_verified==0
if "`identity_mode'"=="dummy" assert !missing(selected_firm_id) & selected_district_code!=""
quietly describe
local fields=r(k)
preserve
    bysort selected_firm_id: keep if _n==1
    count if !missing(selected_firm_id)
    local ids=r(N)
restore
display "G0_COMPLETE_IDENTITY_DATASET_SUCCESS rows=" _N " fields=`fields' selected_ids=`ids' mode=`identity_mode'"
log close
