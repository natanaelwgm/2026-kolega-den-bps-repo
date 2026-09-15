* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/outputs/candidate_2017.dta // WFDOC-INJECTED
* Output: rd2017/outputs/group_counts.dta; rd2017/outputs/group_counts.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-080.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
use "outputs/candidate_2017.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L5:step-rd17_counts" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
rd17_counts, saving("outputs/group_counts.dta") expected(3357)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L5:step-rd17_counts" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L6:step-use" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
use "outputs/group_counts.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L6:step-use" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
assert numerator_n>=0 & denominator_n>=numerator_n
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L8:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("outputs/group_counts") spec("group_counts")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L8:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L10:step-display" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-080"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L10:step-display" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-080.do:L11:step-log" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L11:step-log" "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-080.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
