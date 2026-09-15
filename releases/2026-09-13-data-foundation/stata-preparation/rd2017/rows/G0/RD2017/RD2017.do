* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: lib/shared.do; lib/wave_rd17_classes.do; dan 12 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L1:step-version" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 1 28 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L1:step-version" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 1 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L2:step-clear" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 2 28 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L2:step-clear" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 2 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L3:step-set" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 3 28 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L3:step-set" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 3 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L4:step-set" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 4 28 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L4:step-set" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 4 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L5:step-args" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 5 28 `=_rc' // WFLOG-INJECTED
args foundation_root
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L5:step-args" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 5 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L6:step-assert" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 6 28 `=_rc' // WFLOG-INJECTED
assert `"`foundation_root'"'!=""
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L6:step-assert" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 6 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L7:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 7 28 `=_rc' // WFLOG-INJECTED
global RD17_FOUNDATION `"`foundation_root'"'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L7:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 7 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L8:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 8 28 `=_rc' // WFLOG-INJECTED
global RD17_ROOT "$RD17_FOUNDATION/rd2017"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L8:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 8 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L9:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 9 28 `=_rc' // WFLOG-INJECTED
global RD17_MASTER "$RD17_FOUNDATION/data/analysis/G0_analysis_ready.dta"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L9:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 9 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L10:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 10 28 `=_rc' // WFLOG-INJECTED
global RD17_SCRATCH "$RD17_ROOT/scratch"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L10:step-global" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 10 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L11:step-cd" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 11 28 `=_rc' // WFLOG-INJECTED
cd "$RD17_ROOT"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L11:step-cd" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 11 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L12:step-log" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 12 28 `=_rc' // WFLOG-INJECTED
log using "runtime/run.log", name(RD17RUN) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L12:step-log" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 12 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L13:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 13 28 `=_rc' // WFLOG-INJECTED
do "lib/shared.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L13:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 13 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L14:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 14 28 `=_rc' // WFLOG-INJECTED
do "lib/wave_rd17_classes.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L14:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 14 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L15:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 15 28 `=_rc' // WFLOG-INJECTED
do "lib/from_wave.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L15:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 15 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L16:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 16 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-000.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L16:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 16 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L17:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 17 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-010.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L17:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 17 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L18:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 18 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-020.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L18:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 18 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L19:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 19 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-030.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L19:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 19 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L20:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 20 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-040.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L20:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 20 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L21:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 21 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-050.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L21:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 21 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L22:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 22 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-060.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L22:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 22 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L23:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 23 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-070.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L23:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 23 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L24:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 24 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-080.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L24:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 24 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L25:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 25 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-090.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L25:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 25 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L26:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 26 28 `=_rc' // WFLOG-INJECTED
do "rows/G0/RD2017/RD17-100.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L26:step-do" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 26 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L27:step-display" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 27 28 `=_rc' // WFLOG-INJECTED
display "G0_RD2017_MASTER_ONLY_SUCCESS_CANDIDATE_ONLY"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L27:step-display" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 27 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD2017.do:L28:step-log" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 28 28 `=_rc' // WFLOG-INJECTED
log close RD17RUN
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L28:step-log" "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "statement" 28 28 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
