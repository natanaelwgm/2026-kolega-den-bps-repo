* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/outputs/candidate_2017.dta; rd2017/inputs/truth25-literal-inputs.csv // WFDOC-INJECTED
* Output: rd2017/outputs/joint_counts.dta; rd2017/outputs/joint_counts.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 1 27 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 1 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 2 27 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-070.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 2 27 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 3 27 `=_rc' // WFLOG-INJECTED
use "outputs/candidate_2017.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L4:step-use" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 3 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L5:step-local" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 4 27 `=_rc' // WFLOG-INJECTED
local N=_N
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L5:step-local" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 4 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L6:step-contract" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 5 27 `=_rc' // WFLOG-INJECTED
contract source_year parent_token_class child_token_class, freq(n) nomiss
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L6:step-contract" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 5 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L7:step-recast" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 6 27 `=_rc' // WFLOG-INJECTED
recast long n
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L7:step-recast" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 6 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L8:step-tempfile" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 7 27 `=_rc' // WFLOG-INJECTED
tempfile observed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L8:step-tempfile" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 7 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L9:step-save" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 8 27 `=_rc' // WFLOG-INJECTED
save `observed'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L9:step-save" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 8 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L10:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 9 27 `=_rc' // WFLOG-INJECTED
rd17_import, file("inputs/truth25-literal-inputs.csv") spec("truth25_literal_inputs")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L10:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 9 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L11:step-keep" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 10 27 `=_rc' // WFLOG-INJECTED
keep expected_parent_class expected_child_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L11:step-keep" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 10 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L12:step-rename" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 11 27 `=_rc' // WFLOG-INJECTED
rename expected_parent_class parent_token_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L12:step-rename" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 11 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L13:step-rename" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 12 27 `=_rc' // WFLOG-INJECTED
rename expected_child_class child_token_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L13:step-rename" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 12 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L14:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 13 27 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L14:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 13 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L15:step-merge" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 14 27 `=_rc' // WFLOG-INJECTED
merge 1:1 source_year parent_token_class child_token_class using `observed'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L15:step-merge" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 14 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L16:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 15 27 `=_rc' // WFLOG-INJECTED
assert inlist(_merge,1,3)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L16:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 15 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L17:step-replace" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 16 27 `=_rc' // WFLOG-INJECTED
replace n=0 if _merge==1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L17:step-replace" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 16 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L18:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 17 27 `=_rc' // WFLOG-INJECTED
assert n>=0 & !missing(n)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L18:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 17 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L19:step-drop" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 18 27 `=_rc' // WFLOG-INJECTED
drop _merge
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L19:step-drop" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 18 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L20:step-recast" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 19 27 `=_rc' // WFLOG-INJECTED
recast long n
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L20:step-recast" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 19 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L21:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 20 27 `=_rc' // WFLOG-INJECTED
generate long all_rows=`N'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L21:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 20 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L22:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 21 27 `=_rc' // WFLOG-INJECTED
generate byte measurement_admitted=0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L22:step-generate" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 21 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L23:step-summarize" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 22 27 `=_rc' // WFLOG-INJECTED
quietly summarize n, meanonly
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L23:step-summarize" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 22 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L24:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 23 27 `=_rc' // WFLOG-INJECTED
assert r(sum)==3357 & `N'==3357
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L24:step-assert" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 23 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L25:step-order" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 24 27 `=_rc' // WFLOG-INJECTED
order source_year parent_token_class child_token_class n all_rows measurement_admitted
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L25:step-order" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 24 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L26:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 25 27 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("outputs/joint_counts") spec("joint_counts")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L26:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 25 27 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L28:step-display" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 26 27 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-070"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L28:step-display" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 26 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-070.do:L29:step-log" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 27 27 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L29:step-log" "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "statement" 27 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-070.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
