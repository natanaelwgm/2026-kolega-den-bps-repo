* Tujuan: Jalankan pemeriksaan pembanding yang tertulis di file ini; kegagalan syarat menghentikan validasi. // WFDOC-INJECTED
* Input: lib/shared.do; lib/wave_rd17_classes.do; dan 2 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L1:step-version" "rd2017/run_fixtures.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/run_fixtures.do:L1:step-version" "rd2017/run_fixtures.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L2:step-clear" "rd2017/run_fixtures.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "rd2017/run_fixtures.do:L2:step-clear" "rd2017/run_fixtures.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L3:step-set" "rd2017/run_fixtures.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "rd2017/run_fixtures.do:L3:step-set" "rd2017/run_fixtures.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L4:step-set" "rd2017/run_fixtures.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "rd2017/run_fixtures.do:L4:step-set" "rd2017/run_fixtures.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L5:step-args" "rd2017/run_fixtures.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
args foundation_root
capture noisily __wf_progress end "rd2017/run_fixtures.do:L5:step-args" "rd2017/run_fixtures.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L6:step-assert" "rd2017/run_fixtures.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
assert `"`foundation_root'"'!=""
capture noisily __wf_progress end "rd2017/run_fixtures.do:L6:step-assert" "rd2017/run_fixtures.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L7:step-cd" "rd2017/run_fixtures.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
cd `"`foundation_root'/rd2017"'
capture noisily __wf_progress end "rd2017/run_fixtures.do:L7:step-cd" "rd2017/run_fixtures.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L8:step-log" "rd2017/run_fixtures.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
log using "runtime/fixtures-run.log", text replace name(RD17FIX)
capture noisily __wf_progress end "rd2017/run_fixtures.do:L8:step-log" "rd2017/run_fixtures.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L9:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
do "lib/shared.do"
capture noisily __wf_progress end "rd2017/run_fixtures.do:L9:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L10:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
do "lib/wave_rd17_classes.do"
capture noisily __wf_progress end "rd2017/run_fixtures.do:L10:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L11:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
do "lib/from_wave.do"
capture noisily __wf_progress end "rd2017/run_fixtures.do:L11:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L12:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-010.do"
capture noisily __wf_progress end "rd2017/run_fixtures.do:L12:step-do" "rd2017/run_fixtures.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L13:step-display" "rd2017/run_fixtures.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
display "G0_RD17_CANONICAL_FIXTURES_SUCCESS"
capture noisily __wf_progress end "rd2017/run_fixtures.do:L13:step-display" "rd2017/run_fixtures.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run_fixtures.do:L14:step-log" "rd2017/run_fixtures.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
log close RD17FIX
capture noisily __wf_progress end "rd2017/run_fixtures.do:L14:step-log" "rd2017/run_fixtures.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/run_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
