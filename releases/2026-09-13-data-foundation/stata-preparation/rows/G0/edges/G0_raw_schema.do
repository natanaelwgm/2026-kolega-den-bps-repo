* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/dictionary_all_columns.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L1:step-version" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L1:step-version" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
* Schema comparison state: one row per original variable, in original order.
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L3:step-args" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
args output_path
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L3:step-args" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L4:step-tempname" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
tempname schema
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L4:step-tempname" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L5:step-postfile" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
postfile `schema' int position str32 variable_name str12 storage_type str49 display_format str80 variable_label str32 value_label using "`output_path'", replace
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L5:step-postfile" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L6:step-local" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
local j=0
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L6:step-local" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L7:step-foreach" "rows/G0/edges/G0_raw_schema.do:L1:file" "loop" 6 7 `=_rc' "varlist" `"_all"' // WFLOG-INJECTED
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist _all {
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "rows/G0/edges/G0_raw_schema.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L8:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
    local ++j
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L8:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L9:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
    local storage : type `v'
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L9:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L10:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
    local fmt : format `v'
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L10:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L11:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
    local lab : variable label `v'
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L11:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L12:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
    local vl : value label `v'
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L12:step-local" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L13:step-post" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
    post `schema' (`j') ("`v'") ("`storage'") ("`fmt'") (`"`lab'"') ("`vl'")
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L13:step-post" "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L7:iteration-body" "rows/G0/edges/G0_raw_schema.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L7:step-foreach" "rows/G0/edges/G0_raw_schema.do:L1:file" "loop" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/edges/G0_raw_schema.do:L15:step-postclose" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
postclose `schema'
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L15:step-postclose" "rows/G0/edges/G0_raw_schema.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/edges/G0_raw_schema.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
