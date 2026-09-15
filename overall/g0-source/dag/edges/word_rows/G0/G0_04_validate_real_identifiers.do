* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_identifier_fields.dta; dag/reports/word_data/G0/panel_id_gate.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
generate str64 source_id_raw=""
replace source_id_raw=strtrim(raw_kipb) if source_year==2010
replace source_id_raw=strtrim(raw_kipb) if source_year==2011
replace source_id_raw=strtrim(raw_kipb) if source_year==2012
replace source_id_raw=strtrim(raw_kipb) if source_year==2013
replace source_id_raw=strtrim(raw_kipb) if source_year==2014
replace source_id_raw=strtrim(raw_kip) if source_year==2015
replace source_id_raw=strtrim(raw_psid) if source_year==2017
replace source_id_raw=strtrim(raw_kipb) if source_year==2018
replace source_id_raw=strtrim(raw_kipb) if source_year==2019
replace source_id_raw=strtrim(raw_kipb) if source_year==2020
replace source_id_raw=strtrim(raw_kipb) if source_year==2021
replace source_id_raw=strtrim(raw_kipb) if source_year==2022
replace source_id_raw="" if inlist(upper(source_id_raw),"***",".","NA","N/A","NULL","-")
keep source_year source_row source_id_raw
isid source_year source_row
save "$G0D/G0_identifier_fields.dta", replace
generate byte source_id_observed=source_id_raw!=""
bysort source_year source_id_raw: generate long source_id_multiplicity=_N if source_id_observed
by source_year source_id_raw: generate byte source_id_tag=(_n==1) & source_id_observed
generate byte native_id_unique=source_id_multiplicity==1 if source_id_observed
generate byte real_panel_ready=0
generate str64 panel_status="safe_sample_unlinked_crosswalk_pending"
save "$G0D/G0_identifier_fields.dta", replace
preserve
collapse (count) observations=source_row (sum) id_observed=source_id_observed id_distinct=source_id_tag id_unique_rows=native_id_unique, by(source_year panel_status)
export delimited using "$G0R/panel_id_gate.csv", replace
restore
