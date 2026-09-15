* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: rd2017/inputs/truth25-literal-inputs.csv; rd2017/inputs/literal-parser-fixtures.csv; dan 1 masukan lain // WFDOC-INJECTED
* Output: rd2017/fixtures/truth25_results.dta; rd2017/fixtures/truth25_results.csv; dan 8 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 1 91 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 1 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 2 91 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-010.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 2 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L3:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 3 91 `=_rc' // WFLOG-INJECTED
rd17_import, file("inputs/truth25-literal-inputs.csv") spec("truth25_literal_inputs")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L3:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 3 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L4:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 4 91 `=_rc' // WFLOG-INJECTED
tempfile original
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L4:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 4 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L5:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 5 91 `=_rc' // WFLOG-INJECTED
save `original'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L5:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 5 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L6:step-foreach" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "loop" 6 91 `=_rc' "in" `"tokens universe answer audit"' // WFLOG-INJECTED
* Ulangi blok untuk stage: tokens, universe, answer, audit. // WFDOC-INJECTED
foreach stage in tokens universe answer audit {
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L6:iteration-body" "rd2017/rows/G0/RD2017/RD17-010.do:L6:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L7:step-rd17_candidate" "rd2017/rows/G0/RD2017/RD17-010.do:L6:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 rd17_candidate, stage("`stage'")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L7:step-rd17_candidate" "rd2017/rows/G0/RD2017/RD17-010.do:L6:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L6:iteration-body" "rd2017/rows/G0/RD2017/RD17-010.do:L6:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L6:step-foreach" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "loop" 6 91 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L10:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 7 91 `=_rc' // WFLOG-INJECTED
assert parent_token_class==expected_parent_class & child_token_class==expected_child_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L10:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 7 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L11:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 8 91 `=_rc' // WFLOG-INJECTED
assert rd_universe_candidate==expected_universe & rd_answer_state_candidate==expected_answer_state
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L11:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 8 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L12:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 9 91 `=_rc' // WFLOG-INJECTED
assert rd_external_candidate==expected_external & outside_answer_candidate==expected_outside
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L12:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 9 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L13:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 10 91 `=_rc' // WFLOG-INJECTED
assert measurement_admitted==expected_admission & primary_release==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L13:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 10 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L14:step-cf" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 11 91 `=_rc' // WFLOG-INJECTED
cf raw_rnd17 raw_costrd17 parent_present child_present using `original'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L14:step-cf" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 11 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L15:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 12 91 `=_rc' // WFLOG-INJECTED
local a : type parent_token
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L15:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 12 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L16:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 13 91 `=_rc' // WFLOG-INJECTED
local b : type child_token
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L16:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 13 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L17:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 14 91 `=_rc' // WFLOG-INJECTED
assert "`a'"=="str40" & "`b'"=="str40"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L17:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 14 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L18:step-preserve" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 15 91 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L18:step-preserve" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 15 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L19:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 16 91 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L19:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 16 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L20:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 17 91 `=_rc' // WFLOG-INJECTED
tempfile fc
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L20:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 17 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L21:step-rd17_counts" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 18 91 `=_rc' // WFLOG-INJECTED
rd17_counts, saving("`fc'") expected(25)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L21:step-rd17_counts" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 18 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L22:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 19 91 `=_rc' // WFLOG-INJECTED
use `fc', clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L22:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 19 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L23:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 20 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==25 if group_id=="all_rows"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L23:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 20 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L24:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 21 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==5 if group_id=="eligible"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L24:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 21 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L25:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 22 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==5 if group_id=="structural_skip"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L25:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 22 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L26:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 23 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==5 if group_id=="parent_blank"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L26:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 23 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L27:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 24 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==5 if group_id=="parent_invalid"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L27:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 24 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L28:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 25 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==5 if group_id=="parent_absent"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L28:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 25 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L29:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 26 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==15 if group_id=="unknown_parent"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L29:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 26 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L30:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 27 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==9 if group_id=="unknown_parent_child_nonblank"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L30:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 27 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L31:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 28 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==1 if group_id=="eligible_yes"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L31:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 28 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L32:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 29 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==1 if group_id=="eligible_no"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L32:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 29 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L33:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 30 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==2 if group_id=="eligible_known"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L33:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 30 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L34:step-restore" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 31 91 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L34:step-restore" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 31 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L35:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 32 91 `=_rc' // WFLOG-INJECTED
generate byte passed=1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L35:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 32 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L36:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 33 91 `=_rc' // WFLOG-INJECTED
order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L36:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 33 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L37:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 34 91 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("fixtures/truth25_results") spec("fixture_truth25_results")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L37:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 34 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L38:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 35 91 `=_rc' // WFLOG-INJECTED
rd17_import, file("inputs/literal-parser-fixtures.csv") spec("literal_parser_inputs")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L38:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 35 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L39:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 36 91 `=_rc' // WFLOG-INJECTED
tempfile original
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L39:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 36 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L40:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 37 91 `=_rc' // WFLOG-INJECTED
save `original'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L40:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 37 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L41:step-foreach" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "loop" 38 91 `=_rc' "in" `"tokens universe answer audit"' // WFLOG-INJECTED
* Ulangi blok untuk stage: tokens, universe, answer, audit. // WFDOC-INJECTED
foreach stage in tokens universe answer audit {
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L41:iteration-body" "rd2017/rows/G0/RD2017/RD17-010.do:L41:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L42:step-rd17_candidate" "rd2017/rows/G0/RD2017/RD17-010.do:L41:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
 rd17_candidate, stage("`stage'")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L42:step-rd17_candidate" "rd2017/rows/G0/RD2017/RD17-010.do:L41:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L41:iteration-body" "rd2017/rows/G0/RD2017/RD17-010.do:L41:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L41:step-foreach" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "loop" 38 91 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L45:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 39 91 `=_rc' // WFLOG-INJECTED
assert parent_token_class==expected_parent_class & child_token_class==expected_child_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L45:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 39 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L46:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 40 91 `=_rc' // WFLOG-INJECTED
assert rd_universe_candidate==expected_universe & rd_answer_state_candidate==expected_answer_state
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L46:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 40 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L47:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 41 91 `=_rc' // WFLOG-INJECTED
assert rd_external_candidate==expected_external & outside_answer_candidate==expected_outside
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L47:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 41 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L48:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 42 91 `=_rc' // WFLOG-INJECTED
assert measurement_admitted==expected_admission & primary_release==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L48:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 42 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L49:step-cf" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 43 91 `=_rc' // WFLOG-INJECTED
cf raw_rnd17 raw_costrd17 parent_present child_present using `original'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L49:step-cf" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 43 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L50:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 44 91 `=_rc' // WFLOG-INJECTED
local a : type parent_token
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L50:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 44 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L51:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 45 91 `=_rc' // WFLOG-INJECTED
local b : type child_token
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L51:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 45 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L52:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 46 91 `=_rc' // WFLOG-INJECTED
assert "`a'"=="str40" & "`b'"=="str40"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L52:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 46 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L53:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 47 91 `=_rc' // WFLOG-INJECTED
generate byte passed=1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L53:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 47 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L54:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 48 91 `=_rc' // WFLOG-INJECTED
order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L54:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 48 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L55:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 49 91 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("fixtures/literal_results") spec("fixture_literal_results")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L55:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 49 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L56:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 50 91 `=_rc' // WFLOG-INJECTED
rd17_import, file("inputs/ratio-fixtures.csv") spec("ratio_fixture_inputs")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L56:step-rd17_import" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 50 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L57:step-rd17_ratio" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 51 91 `=_rc' // WFLOG-INJECTED
rd17_ratio
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L57:step-rd17_ratio" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 51 91 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L59:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 52 91 `=_rc' // WFLOG-INJECTED
assert numerator_n==expected_numerator_n & denominator_n==expected_denominator_n
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L59:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 52 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L60:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 53 91 `=_rc' // WFLOG-INJECTED
assert missing(ratio)==expected_missing & missing(percent)==expected_missing
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L60:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 53 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L61:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 54 91 `=_rc' // WFLOG-INJECTED
assert abs(ratio-expected_ratio)<=2*epsdouble()*max(1,abs(expected_ratio)) if expected_missing==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L61:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 54 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L62:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 55 91 `=_rc' // WFLOG-INJECTED
assert abs(percent-expected_percent)<=2*epsdouble()*max(1,abs(expected_percent)) if expected_missing==0
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L62:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 55 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L63:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 56 91 `=_rc' // WFLOG-INJECTED
assert ratio==expected_ratio if inlist(expected_ratio,0,1)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L63:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 56 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L64:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 57 91 `=_rc' // WFLOG-INJECTED
assert percent==expected_percent if inlist(expected_percent,0,100)
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L64:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 57 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L65:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 58 91 `=_rc' // WFLOG-INJECTED
assert ratio!=float(ratio) & percent!=float(percent) if precision_probe==1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L65:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 58 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L66:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 59 91 `=_rc' // WFLOG-INJECTED
local a : type ratio
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L66:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 59 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L67:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 60 91 `=_rc' // WFLOG-INJECTED
local b : type percent
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L67:step-local" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 60 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L68:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 61 91 `=_rc' // WFLOG-INJECTED
assert "`a'"=="double" & "`b'"=="double"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L68:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 61 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L69:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 62 91 `=_rc' // WFLOG-INJECTED
generate byte passed=1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L69:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 62 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L70:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 63 91 `=_rc' // WFLOG-INJECTED
order fixture_id estimate_id eligible_yes_n eligible_no_n eligible_n expected_numerator_n expected_denominator_n expected_ratio expected_percent expected_missing precision_probe numerator_n denominator_n ratio percent passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L70:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 63 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L71:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 64 91 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("fixtures/ratio_results") spec("fixture_ratio_results")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L71:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 64 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L72:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 65 91 `=_rc' // WFLOG-INJECTED
use "fixtures/truth25_results.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L72:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 65 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L73:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 66 91 `=_rc' // WFLOG-INJECTED
keep fixture_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L73:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 66 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L74:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 67 91 `=_rc' // WFLOG-INJECTED
generate str12 fixture_family="truth25"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L74:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 67 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L75:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 68 91 `=_rc' // WFLOG-INJECTED
generate str40 estimate_id=""
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L75:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 68 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L76:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 69 91 `=_rc' // WFLOG-INJECTED
order fixture_family fixture_id estimate_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L76:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 69 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L77:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 70 91 `=_rc' // WFLOG-INJECTED
tempfile f_truth25
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L77:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 70 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L78:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 71 91 `=_rc' // WFLOG-INJECTED
save `f_truth25'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L78:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 71 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L79:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 72 91 `=_rc' // WFLOG-INJECTED
use "fixtures/literal_results.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L79:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 72 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L80:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 73 91 `=_rc' // WFLOG-INJECTED
keep fixture_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L80:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 73 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L81:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 74 91 `=_rc' // WFLOG-INJECTED
generate str12 fixture_family="literal"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L81:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 74 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L82:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 75 91 `=_rc' // WFLOG-INJECTED
generate str40 estimate_id=""
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L82:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 75 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L83:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 76 91 `=_rc' // WFLOG-INJECTED
order fixture_family fixture_id estimate_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L83:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 76 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L84:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 77 91 `=_rc' // WFLOG-INJECTED
tempfile f_literal
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L84:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 77 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L85:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 78 91 `=_rc' // WFLOG-INJECTED
save `f_literal'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L85:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 78 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L86:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 79 91 `=_rc' // WFLOG-INJECTED
use "fixtures/ratio_results.dta", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L86:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 79 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L87:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 80 91 `=_rc' // WFLOG-INJECTED
keep fixture_id estimate_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L87:step-keep" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 80 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L88:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 81 91 `=_rc' // WFLOG-INJECTED
generate str12 fixture_family="ratio"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L88:step-generate" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 81 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L89:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 82 91 `=_rc' // WFLOG-INJECTED
order fixture_family fixture_id estimate_id passed
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L89:step-order" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 82 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L90:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 83 91 `=_rc' // WFLOG-INJECTED
tempfile f_ratio
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L90:step-tempfile" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 83 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L91:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 84 91 `=_rc' // WFLOG-INJECTED
save `f_ratio'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L91:step-save" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 84 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L92:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 85 91 `=_rc' // WFLOG-INJECTED
use `f_truth25', clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L92:step-use" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 85 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L93:step-append" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 86 91 `=_rc' // WFLOG-INJECTED
append using `f_literal' `f_ratio'
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L93:step-append" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 86 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L94:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 87 91 `=_rc' // WFLOG-INJECTED
assert passed==1
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L94:step-assert" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 87 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L95:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 88 91 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("fixtures/results") spec("fixture_results")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L95:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 88 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L96:step-do" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 89 91 `=_rc' // WFLOG-INJECTED
do "fixtures/bridge_checks.do"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L96:step-do" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 89 91 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L98:step-display" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 90 91 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-010"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L98:step-display" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 90 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-010.do:L99:step-log" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 91 91 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L99:step-log" "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "statement" 91 91 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-010.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
