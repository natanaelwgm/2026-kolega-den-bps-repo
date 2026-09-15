* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/outputs/group_counts.dta // WFDOC-INJECTED
* Output: rd2017/outputs/candidate_ratios.dta; rd2017/outputs/candidate_ratios.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-090.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
use "outputs/group_counts.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L5:step-foreach" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "loop" 4 21 `=_rc' "in" `"eligible_yes eligible_no eligible"' // WFLOG-INJECTED
* Ulangi blok untuk g: eligible_yes, eligible_no, eligible. // WFDOC-INJECTED
foreach g in eligible_yes eligible_no eligible {
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "rd2017/rows/G0/RD2017/RD17-090.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L6:step-summarize" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
 quietly summarize numerator_n if group_id=="`g'", meanonly
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L6:step-summarize" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
 assert r(N)==1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L8:step-local" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
 local C_`g'=r(mean)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L8:step-local" "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L5:iteration-body" "rd2017/rows/G0/RD2017/RD17-090.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L5:step-foreach" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "loop" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L10:step-clear" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L10:step-clear" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L11:step-set" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
set obs 2
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L11:step-set" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L12:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L12:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L13:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
generate str40 estimate_id="candidate_yes_among_known_eligible" in 1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L13:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L14:step-replace" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
replace estimate_id="candidate_known_response_coverage" in 2
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L14:step-replace" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L15:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
generate long eligible_yes_n=`C_eligible_yes'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L15:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L16:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
generate long eligible_no_n=`C_eligible_no'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L16:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L17:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
generate long eligible_n=`C_eligible'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L17:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L18:step-rd17_ratio" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
rd17_ratio
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L18:step-rd17_ratio" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L19:step-drop" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
drop eligible_yes_n eligible_no_n eligible_n
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L19:step-drop" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L20:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
generate long accepted_eligible_n=.
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L20:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L21:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
generate double accepted_positive_share=.
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L21:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L22:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
generate byte measurement_admitted=0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L22:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L23:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
generate byte primary_release=0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L23:step-generate" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L24:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("outputs/candidate_ratios") spec("candidate_ratios")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L24:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L26:step-display" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-090"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L26:step-display" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-090.do:L27:step-log" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L27:step-log" "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-090.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
