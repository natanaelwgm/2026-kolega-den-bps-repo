* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/runtime/preflight.json; rd2017/runtime/preflight_pass.do // WFDOC-INJECTED
* Output: rd2017/runtime/RD17-000.log // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-000.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L4:step-confirm" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
confirm file "runtime/preflight.json"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L4:step-confirm" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L5:step-confirm" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
confirm file "runtime/preflight_pass.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L5:step-confirm" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L6:step-do" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
do "runtime/preflight_pass.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L6:step-do" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
assert `"`c(tmpdir)'"'=="$RD17_SCRATCH/"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L7:step-assert" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L9:step-display" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-000"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L9:step-display" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-000.do:L10:step-log" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L10:step-log" "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-000.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
