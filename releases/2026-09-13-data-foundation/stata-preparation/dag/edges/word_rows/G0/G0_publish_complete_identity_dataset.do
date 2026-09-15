* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/identity-options/G0_identity_spine_off.dta; dag/data/word_data/G0/G0_analysis_ready.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:step-version" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 1 43 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:step-version" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 1 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L2:step-clear" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 2 43 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L2:step-clear" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 2 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L3:step-set" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 3 43 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L3:step-set" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 3 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L4:step-set" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 4 43 `=_rc' // WFLOG-INJECTED
set maxvar 10000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L4:step-set" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 4 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L5:step-args" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 5 43 `=_rc' // WFLOG-INJECTED
args dag_root identity_mode real_crosswalk
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L5:step-args" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 5 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L6:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 6 43 `=_rc' // WFLOG-INJECTED
if `"`dag_root'"'=="" local dag_root "."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L6:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 6 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L7:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 7 43 `=_rc' // WFLOG-INJECTED
if `"`identity_mode'"'=="" local identity_mode "off"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L7:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 7 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L8:step-cd" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 8 43 `=_rc' // WFLOG-INJECTED
cd "`dag_root'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L8:step-cd" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 8 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L9:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 9 43 `=_rc' // WFLOG-INJECTED
capture log close _all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L9:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 9 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L10:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 10 43 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/identity-options/G0_publish_complete_identity_dataset.log", text replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L10:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 10 43 `=_rc' // WFLOG-INJECTED
* One complete downstream file; existing owner-authorized synthetic identity method.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L12:step-use" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 11 43 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_main_candidate.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L12:step-use" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 11 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L13:step-ds" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 12 43 `=_rc' // WFLOG-INJECTED
quietly ds
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L13:step-ds" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 12 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L14:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 13 43 `=_rc' // WFLOG-INJECTED
local canonical_fields `r(varlist)'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L14:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 13 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L15:step-do" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 14 43 `=_rc' // WFLOG-INJECTED
do "dag/edges/word_rows/G0/G0_load_identity_view.do" "." "`identity_mode'" "`real_crosswalk'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L15:step-do" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 14 43 `=_rc' // WFLOG-INJECTED
* Keep identity schema stable when dummy is switched off or replaced by real IDs.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:step-foreach" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "loop" 15 43 `=_rc' "in" `"demo_province demo_industry2"' // WFLOG-INJECTED
* Ulangi blok untuk var: demo_province, demo_industry2. // WFDOC-INJECTED
foreach var in demo_province demo_industry2 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L18:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    capture confirm variable `var'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L18:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L19:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    if _rc generate str2 `var'=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L19:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:iteration-body" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L17:step-foreach" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "loop" 15 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L21:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 16 43 `=_rc' // WFLOG-INJECTED
capture confirm variable demo_slot
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L21:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 16 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L22:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 17 43 `=_rc' // WFLOG-INJECTED
if _rc generate long demo_slot=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L22:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 17 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L23:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 18 43 `=_rc' // WFLOG-INJECTED
capture confirm variable demo_district_slot
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L23:step-confirm" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 18 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L24:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 19 43 `=_rc' // WFLOG-INJECTED
if _rc generate byte demo_district_slot=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L24:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 19 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L25:step-assert" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 20 43 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L25:step-assert" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 20 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L26:step-isid" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 21 43 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L26:step-isid" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 21 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L27:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 22 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"!="off" isid selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L27:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 22 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L28:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 23 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"=="dummy" assert !missing(selected_firm_id) & !missing(dummy_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L28:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 23 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L29:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 24 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"=="dummy" assert selected_district_code!="" & dummy_district_code!=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L29:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 24 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L30:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 25 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"=="dummy" assert identity_is_dummy==1 & identity_real_link_verified==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L30:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 25 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L31:step-sort" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 26 43 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L31:step-sort" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 26 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L32:step-cf" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 27 43 `=_rc' // WFLOG-INJECTED
cf `canonical_fields' using "dag/data/word_data/G0/G0_main_candidate.dta", all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L32:step-cf" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 27 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L33:step-save" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 28 43 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/G0_analysis_ready.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L33:step-save" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 28 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L34:step-use" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 29 43 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L34:step-use" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 29 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L35:step-isid" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 30 43 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L35:step-isid" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 30 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L36:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 31 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"!="off" isid selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L36:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 31 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L37:step-assert" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 32 43 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L37:step-assert" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 32 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L38:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 33 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"=="dummy" assert identity_is_dummy==1 & identity_real_link_verified==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L38:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 33 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L39:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 34 43 `=_rc' // WFLOG-INJECTED
if "`identity_mode'"=="dummy" assert !missing(selected_firm_id) & selected_district_code!=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L39:step-if" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 34 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L40:step-describe" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 35 43 `=_rc' // WFLOG-INJECTED
quietly describe
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L40:step-describe" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 35 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L41:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 36 43 `=_rc' // WFLOG-INJECTED
local fields=r(k)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L41:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 36 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L42:step-preserve" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 37 43 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L42:step-preserve" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 37 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L43:step-bysort" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 38 43 `=_rc' // WFLOG-INJECTED
    bysort selected_firm_id: keep if _n==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L43:step-bysort" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 38 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L44:step-count" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 39 43 `=_rc' // WFLOG-INJECTED
    count if !missing(selected_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L44:step-count" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 39 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L45:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 40 43 `=_rc' // WFLOG-INJECTED
    local ids=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L45:step-local" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 40 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L46:step-restore" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 41 43 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L46:step-restore" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 41 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L47:step-display" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 42 43 `=_rc' // WFLOG-INJECTED
display "G0_COMPLETE_IDENTITY_DATASET_SUCCESS rows=" _N " fields=`fields' selected_ids=`ids' mode=`identity_mode'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L47:step-display" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 42 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L48:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 43 43 `=_rc' // WFLOG-INJECTED
log close
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L48:step-log" "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "statement" 43 43 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
