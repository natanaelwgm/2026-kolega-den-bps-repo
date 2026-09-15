* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: report/tables/histogram_ln_workers.csv; report/tables/histogram_ln_output_nominal.csv; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:step-version" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:step-version" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L2:step-clear" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L2:step-clear" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L3:step-set" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L3:step-set" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L4:step-args" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
args root
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L4:step-args" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L5:step-cd" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 5 10 `=_rc' // WFLOG-INJECTED
cd "`root'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L5:step-cd" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 5 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L6:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
capture log close _all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L6:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L7:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
log using "report/evidence/G0_histogram_bins.log", text replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L7:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:step-foreach" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "loop" 8 10 `=_rc' "in" `""ln_workers 0.5" "ln_output_nominal 1" "ln_total_gj_s1 1""' // WFLOG-INJECTED
* Ulangi blok untuk setiap pair yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach pair in "ln_workers 0.5" "ln_output_nominal 1" "ln_total_gj_s1 1" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L9:step-gettoken" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 1 17 `=_rc' // WFLOG-INJECTED
 gettoken variable width : pair
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L9:step-gettoken" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L10:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 2 17 `=_rc' // WFLOG-INJECTED
 local width=real(strtrim("`width'"))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L10:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L11:step-use" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 3 17 `=_rc' // WFLOG-INJECTED
 use `variable' using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L11:step-use" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L12:step-keep" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 4 17 `=_rc' // WFLOG-INJECTED
 keep if !missing(`variable')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L12:step-keep" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L13:step-summarize" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 5 17 `=_rc' // WFLOG-INJECTED
 quietly summarize `variable'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L13:step-summarize" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L14:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 6 17 `=_rc' // WFLOG-INJECTED
 local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L14:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L15:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 7 17 `=_rc' // WFLOG-INJECTED
 local start=floor(r(min)/`width')*`width'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L15:step-local" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L16:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 8 17 `=_rc' // WFLOG-INJECTED
 generate long bin=floor((`variable'-`start')/`width')
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L16:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L17:step-contract" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 9 17 `=_rc' // WFLOG-INJECTED
 contract bin, freq(count)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L17:step-contract" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 9 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L18:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 10 17 `=_rc' // WFLOG-INJECTED
 generate double left=`start'+bin*`width'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L18:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 10 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L19:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 11 17 `=_rc' // WFLOG-INJECTED
 generate double width=`width'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L19:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L20:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 12 17 `=_rc' // WFLOG-INJECTED
 generate double proportion=count/`n'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L20:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L21:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 13 17 `=_rc' // WFLOG-INJECTED
 generate long eligible_n=`n'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L21:step-generate" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L22:step-egen" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 14 17 `=_rc' // WFLOG-INJECTED
 egen double check_total=total(proportion)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L22:step-egen" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L23:step-assert" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 15 17 `=_rc' // WFLOG-INJECTED
 assert abs(check_total-1)<1e-10
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L23:step-assert" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L24:step-drop" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 16 17 `=_rc' // WFLOG-INJECTED
 drop check_total
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L24:step-drop" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L25:step-export" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 17 17 `=_rc' // WFLOG-INJECTED
 export delimited using "report/tables/histogram_`variable'.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L25:step-export" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:iteration-body" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L8:step-foreach" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "loop" 8 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L27:step-display" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
display "G0_REPORT_HISTOGRAM_BINS_PASS"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L27:step-display" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L28:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
log close
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L28:step-log" "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_report_histogram_bins.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
