* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/states/universe_2017.dta // WFDOC-INJECTED
* Output: rd2017/states/answer_2017.dta; rd2017/states/answer_2017.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-050.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L3:step-use" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
use "states/universe_2017.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L3:step-use" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L4:step-rd17_from_wave" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
rd17_from_wave, stage("answer")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L4:step-rd17_from_wave" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L5:step-order" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L5:step-order" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L6:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("states/answer_2017") spec("answer_2017")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L6:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L7:step-display" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-050"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L7:step-display" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-050.do:L8:step-log" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L8:step-log" "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-050.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
