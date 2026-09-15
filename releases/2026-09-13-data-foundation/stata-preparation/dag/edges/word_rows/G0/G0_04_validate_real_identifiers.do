* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_identifier_fields.dta; dag/reports/word_data/G0/panel_id_gate.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:step-use" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 1 30 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:step-use" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 1 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L2:step-label" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 2 30 `=_rc' // WFLOG-INJECTED
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L2:step-label" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 2 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L3:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 3 30 `=_rc' // WFLOG-INJECTED
generate str64 source_id_raw=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L3:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 3 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L4:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 4 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L4:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 4 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L5:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 5 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L5:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 5 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L6:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 6 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L6:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 6 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L7:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 7 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L7:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 7 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L8:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 8 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L8:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 8 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L9:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 9 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kip) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L9:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 9 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L10:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 10 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_psid) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L10:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 10 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L11:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 11 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L11:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 11 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L12:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 12 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L12:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 12 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L13:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 13 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L13:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 13 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L14:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 14 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L14:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 14 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L15:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 15 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw=strtrim(raw_kipb) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L15:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 15 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L16:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 16 30 `=_rc' // WFLOG-INJECTED
replace source_id_raw="" if inlist(upper(source_id_raw),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L16:step-replace" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 16 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L17:step-keep" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 17 30 `=_rc' // WFLOG-INJECTED
keep source_year source_row source_id_raw
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L17:step-keep" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 17 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L18:step-isid" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 18 30 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L18:step-isid" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 18 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L19:step-save" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 19 30 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_identifier_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L19:step-save" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 19 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L20:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 20 30 `=_rc' // WFLOG-INJECTED
generate byte source_id_observed=source_id_raw!=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L20:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 20 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L21:step-bysort" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 21 30 `=_rc' // WFLOG-INJECTED
bysort source_year source_id_raw: generate long source_id_multiplicity=_N if source_id_observed
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L21:step-bysort" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 21 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L22:step-by" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 22 30 `=_rc' // WFLOG-INJECTED
by source_year source_id_raw: generate byte source_id_tag=(_n==1) & source_id_observed
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L22:step-by" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 22 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L23:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 23 30 `=_rc' // WFLOG-INJECTED
generate byte native_id_unique=source_id_multiplicity==1 if source_id_observed
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L23:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 23 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L24:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 24 30 `=_rc' // WFLOG-INJECTED
generate byte real_panel_ready=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L24:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 24 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L25:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 25 30 `=_rc' // WFLOG-INJECTED
generate str64 panel_status="safe_sample_unlinked_crosswalk_pending"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L25:step-generate" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 25 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L26:step-save" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 26 30 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_identifier_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L26:step-save" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 26 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L27:step-preserve" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 27 30 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L27:step-preserve" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 27 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L28:step-collapse" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 28 30 `=_rc' // WFLOG-INJECTED
collapse (count) observations=source_row (sum) id_observed=source_id_observed id_distinct=source_id_tag id_unique_rows=native_id_unique, by(source_year panel_status)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L28:step-collapse" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 28 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L29:step-export" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 29 30 `=_rc' // WFLOG-INJECTED
export delimited using "$G0R/panel_id_gate.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L29:step-export" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 29 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L30:step-restore" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 30 30 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L30:step-restore" "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "statement" 30 30 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
