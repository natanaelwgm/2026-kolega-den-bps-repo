* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: `foundation_root'/rd2017/rows/G0/RD2017/RD2017.do // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/run.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run.do:L1:step-version" "rd2017/run.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/run.do:L1:step-version" "rd2017/run.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run.do:L2:step-args" "rd2017/run.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
args foundation_root
capture noisily __wf_progress end "rd2017/run.do:L2:step-args" "rd2017/run.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run.do:L3:step-assert" "rd2017/run.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
assert `"`foundation_root'"'!=""
capture noisily __wf_progress end "rd2017/run.do:L3:step-assert" "rd2017/run.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/run.do:L4:step-do" "rd2017/run.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
do `"`foundation_root'/rd2017/rows/G0/RD2017/RD2017.do"' `"`foundation_root'"'
capture noisily __wf_progress end "rd2017/run.do:L4:step-do" "rd2017/run.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/run.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
