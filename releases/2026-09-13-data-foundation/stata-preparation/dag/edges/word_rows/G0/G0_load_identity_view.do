* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/edges/word_rows/G0/G0_select_identity_mode.do; dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:step-version" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:step-version" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L2:step-clear" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L2:step-clear" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L3:step-set" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L3:step-set" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L4:step-set" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
set maxvar 10000
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L4:step-set" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
* Load the full frozen G0 dataset with explicitly selected identity sidecar.
* Changes memory only. Never save over G0_main_candidate.dta.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L7:step-args" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
args dag_root identity_mode real_crosswalk dummy_district_count
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L7:step-args" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L8:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
if `"`dag_root'"'=="" local dag_root "."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L8:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L9:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
if `"`identity_mode'"'=="" local identity_mode "off"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L9:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L10:step-cd" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
cd "`dag_root'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L10:step-cd" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L11:step-do" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
do "dag/edges/word_rows/G0/G0_select_identity_mode.do" "." "`identity_mode'" "`real_crosswalk'" "`dummy_district_count'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L11:step-do" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L12:step-use" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_main_candidate.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L12:step-use" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L13:step-isid" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L13:step-isid" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L14:step-merge" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
merge 1:1 source_year source_row using "dag/data/word_data/G0/identity-options/G0_identity_spine_`identity_mode'.dta", assert(match) nogen
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L14:step-merge" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`identity_mode'" sama dengan "off". // WFDOC-INJECTED
if "`identity_mode'"=="off" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L16:step-assert" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    assert identity_is_dummy==0 & missing(selected_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L16:step-assert" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L17:step-xtset" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    xtset, clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L17:step-xtset" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:block-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
else {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "block" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L20:step-isid" "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    isid selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L20:step-isid" "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L21:step-xtset" "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    xtset selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L21:step-xtset" "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L19:branch-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "block" 2 2 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L15:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`identity_mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`identity_mode'"=="dummy" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L24:step-assert" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    assert identity_is_dummy==1 & identity_real_link_verified==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L24:step-assert" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L25:step-display" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    display as error "SIMULATION ONLY: synthetic panel and districts; no real firm/spatial inference."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L25:step-display" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:block-body" "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L23:step-if" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_load_identity_view.do:L27:step-display" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
display as result "G0_IDENTITY_VIEW_LOADED mode=`identity_mode' rows=" _N
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L27:step-display" "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_load_identity_view.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
