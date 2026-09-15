* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/edges/word_rows/G0/G0_select_identity_mode.do; dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
set maxvar 10000
* Load the full frozen G0 dataset with explicitly selected identity sidecar.
* Changes memory only. Never save over G0_main_candidate.dta.
args dag_root identity_mode real_crosswalk dummy_district_count
if `"`dag_root'"'=="" local dag_root "."
if `"`identity_mode'"'=="" local identity_mode "off"
cd "`dag_root'"
do "dag/edges/word_rows/G0/G0_select_identity_mode.do" "." "`identity_mode'" "`real_crosswalk'" "`dummy_district_count'"
use "dag/data/word_data/G0/G0_main_candidate.dta", clear
isid source_year source_row
merge 1:1 source_year source_row using "dag/data/word_data/G0/identity-options/G0_identity_spine_`identity_mode'.dta", assert(match) nogen
* Isi blok hanya dijalankan bila "`identity_mode'" sama dengan "off". // WFDOC-INJECTED
if "`identity_mode'"=="off" {
    assert identity_is_dummy==0 & missing(selected_firm_id)
    xtset, clear
}
else {
    isid selected_firm_id source_year
    xtset selected_firm_id source_year
}
* Isi blok hanya dijalankan bila "`identity_mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`identity_mode'"=="dummy" {
    assert identity_is_dummy==1 & identity_real_link_verified==0
    display as error "SIMULATION ONLY: synthetic panel and districts; no real firm/spatial inference."
}
display as result "G0_IDENTITY_VIEW_LOADED mode=`identity_mode' rows=" _N
