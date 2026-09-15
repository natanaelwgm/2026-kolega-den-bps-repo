* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; rd2017/outputs/candidate_2017.dta; dan 8 masukan lain // WFDOC-INJECTED
* Output: rd2017/validation/equivalence.dta; rd2017/validation/equivalence.csv; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-100.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
use "outputs/candidate_2017.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L5:step-isid" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L5:step-isid" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L6:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
assert source_year==2017 & _N==3357
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L6:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
assert measurement_admitted==0 & primary_release==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L8:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
assert missing(rd_external_candidate) if rd_universe_candidate!=0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L8:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L9:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
use "outputs/candidate_ratios.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L9:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L10:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
assert missing(accepted_eligible_n) & missing(accepted_positive_share)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L10:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L11:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
assert measurement_admitted==0 & primary_release==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L11:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L12:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
use "fixtures/results.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L12:step-use" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L13:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
assert _N==61 & passed==1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L13:step-assert" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L14:step-do" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
do "validation/compare_current_wave.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L14:step-do" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L16:step-display" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-100"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L16:step-display" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-100.do:L17:step-log" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L17:step-log" "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-100.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
