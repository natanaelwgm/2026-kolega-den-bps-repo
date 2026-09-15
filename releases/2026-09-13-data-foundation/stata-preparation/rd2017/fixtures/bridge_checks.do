* Tujuan: Jalankan pemeriksaan pembanding yang tertulis di file ini; kegagalan syarat menghentikan validasi. // WFDOC-INJECTED
* Input: fixtures/guard_results.dta // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L1:step-version" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 1 51 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L1:step-version" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 1 51 `=_rc' // WFLOG-INJECTED
* Constructed literals only, including the exact shared25 table and wider tokens.
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L3:step-foreach" "rd2017/fixtures/bridge_checks.do:L1:file" "loop" 2 51 `=_rc' "in" `"truth25-literal-inputs literal-parser-fixtures"' // WFLOG-INJECTED
* Ulangi blok untuk name: truth25-literal-inputs, literal-parser-fixtures. // WFDOC-INJECTED
foreach name in truth25-literal-inputs literal-parser-fixtures {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "rd2017/fixtures/bridge_checks.do:L3:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L4:step-local" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 1 17 `=_rc' // WFLOG-INJECTED
 local spec=cond("`name'"=="truth25-literal-inputs","truth25_literal_inputs","literal_parser_inputs")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L4:step-local" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L5:step-rd17_import" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 2 17 `=_rc' // WFLOG-INJECTED
 rd17_import, file("inputs/`name'.csv") spec("`spec'")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L5:step-rd17_import" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L6:step-wave_rd17_literal_class" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 3 17 `=_rc' // WFLOG-INJECTED
 wave_rd17_literal_class raw_rnd17, generate(rd17_own_token_class) present(parent_present)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L6:step-wave_rd17_literal_class" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L7:step-wave_rd17_literal_class" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 4 17 `=_rc' // WFLOG-INJECTED
 wave_rd17_literal_class raw_costrd17, generate(rd17_external_token_class) present(child_present)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L7:step-wave_rd17_literal_class" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L8:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 5 17 `=_rc' // WFLOG-INJECTED
 assert rd17_own_token_class==expected_parent_class
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L8:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L9:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 6 17 `=_rc' // WFLOG-INJECTED
 assert rd17_external_token_class==expected_child_class
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L9:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L10:step-generate" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 7 17 `=_rc' // WFLOG-INJECTED
 generate int source_year=2017
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L10:step-generate" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L11:step-generate" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 8 17 `=_rc' // WFLOG-INJECTED
 generate int source_row=_n
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L11:step-generate" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L12:step-foreach" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "loop" 9 17 `=_rc' "in" `"own external"' // WFLOG-INJECTED
* Ulangi blok untuk side: own, external. // WFDOC-INJECTED
 foreach side in own external {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "rd2017/fixtures/bridge_checks.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L13:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
  local raw=cond("`side'"=="own","raw_rnd17","raw_costrd17")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L13:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L14:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
  local value=cond("`side'"=="own","rd_indicator_raw","val_costrd")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L14:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L15:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
  local state=cond("`side'"=="own","vs_rd_indicator_raw","vs_val_costrd")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L15:step-local" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L16:step-generate" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
  generate double `value'=real(subinstr(strtrim(`raw'),",","",.))
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L16:step-generate" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L17:step-generate" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
  generate byte `state'=3
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L17:step-generate" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L18:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
  replace `state'=5 if missing(`value') & !inlist(upper(strtrim(`raw')),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L18:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L19:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
  replace `state'=cond(`value'<0,2,cond(`value'==0,1,0)) if !missing(`value')
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L19:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L20:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
  replace `value'=. if rd17_`side'_token_class=="absent"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L20:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L21:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
  replace `state'=4 if rd17_`side'_token_class=="absent"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L21:step-replace" "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L12:iteration-body" "rd2017/fixtures/bridge_checks.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L12:step-foreach" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "loop" 9 17 `=_rc' // WFLOG-INJECTED
 * Existing literal L14 has TAB: Unicode blank, canonical ASCII parser failure.
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L24:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 10 17 `=_rc' // WFLOG-INJECTED
 assert missing(val_costrd) & vs_val_costrd==5 & rd17_external_token_class=="blank" if fixture_id=="L14"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L24:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 10 17 `=_rc' // WFLOG-INJECTED
 * L07 is wider than the admitted actual str1 columns. The literal parser
 * accepts its wrapped digits, but the unchanged canonical mapper does not.
 * Keep the canonical guard strict and require that constructed case to reject.
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L28:step-if" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 11 17 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`name'" sama dengan "literal-parser-fixtures". // WFDOC-INJECTED
 if "`name'"=="literal-parser-fixtures" {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L28:block-body" "rd2017/fixtures/bridge_checks.do:L28:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L29:step-preserve" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 1 12 `=_rc' // WFLOG-INJECTED
  preserve
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L29:step-preserve" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L30:step-keep" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 2 12 `=_rc' // WFLOG-INJECTED
  keep if fixture_id=="L07"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L30:step-keep" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L31:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 3 12 `=_rc' // WFLOG-INJECTED
  assert _N==1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L31:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L32:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 4 12 `=_rc' // WFLOG-INJECTED
  assert rd17_own_token_class=="2" & rd17_external_token_class=="1"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L32:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L33:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 5 12 `=_rc' // WFLOG-INJECTED
  assert missing(rd_indicator_raw) & vs_rd_indicator_raw==5
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L33:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L34:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 6 12 `=_rc' // WFLOG-INJECTED
  capture noisily rd17_wave_guard
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L34:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L35:step-local" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 7 12 `=_rc' // WFLOG-INJECTED
  local l07_rc=_rc
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L35:step-local" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L36:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 8 12 `=_rc' // WFLOG-INJECTED
  assert `l07_rc'==9
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L36:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L37:step-restore" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 9 12 `=_rc' // WFLOG-INJECTED
  restore
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L37:step-restore" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L38:step-drop" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 10 12 `=_rc' // WFLOG-INJECTED
  drop if fixture_id=="L07"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L38:step-drop" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L39:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 11 12 `=_rc' // WFLOG-INJECTED
  assert _N==23
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L39:step-assert" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L40:step-display" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 12 12 `=_rc' // WFLOG-INJECTED
  display "RD17_L07_EXPECTED_CANONICAL_REJECTION_PASS"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L40:step-display" "rd2017/fixtures/bridge_checks.do:L28:block-body" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L28:block-body" "rd2017/fixtures/bridge_checks.do:L28:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L28:step-if" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L42:step-foreach" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "loop" 12 17 `=_rc' "in" `"classes universe answer audit"' // WFLOG-INJECTED
* Ulangi blok untuk stage: classes, universe, answer, audit. // WFDOC-INJECTED
 foreach stage in classes universe answer audit {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L42:iteration-body" "rd2017/fixtures/bridge_checks.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L43:step-rd17_from_wave" "rd2017/fixtures/bridge_checks.do:L42:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
  rd17_from_wave, stage("`stage'")
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L43:step-rd17_from_wave" "rd2017/fixtures/bridge_checks.do:L42:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L42:iteration-body" "rd2017/fixtures/bridge_checks.do:L42:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L42:step-foreach" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "loop" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L45:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 13 17 `=_rc' // WFLOG-INJECTED
 assert parent_token_class==expected_parent_class & child_token_class==expected_child_class
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L45:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L46:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 14 17 `=_rc' // WFLOG-INJECTED
 assert rd_universe_candidate==expected_universe & rd_answer_state_candidate==expected_answer_state
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L46:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L47:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 15 17 `=_rc' // WFLOG-INJECTED
 assert rd_external_candidate==expected_external & outside_answer_candidate==expected_outside
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L47:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L48:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 16 17 `=_rc' // WFLOG-INJECTED
 assert measurement_admitted==expected_admission & primary_release==0
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L48:step-assert" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L49:step-display" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 17 17 `=_rc' // WFLOG-INJECTED
 display "RD17_CANONICAL_BRIDGE_PASS `name'"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L49:step-display" "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L3:iteration-body" "rd2017/fixtures/bridge_checks.do:L3:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L3:step-foreach" "rd2017/fixtures/bridge_checks.do:L1:file" "loop" 2 51 `=_rc' // WFLOG-INJECTED
* One passing typed baseline, then one-property rejected variants.
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L52:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 3 51 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L52:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 3 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L53:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 4 51 `=_rc' // WFLOG-INJECTED
set obs 3
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L53:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 4 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L54:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 5 51 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L54:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 5 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L55:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 6 51 `=_rc' // WFLOG-INJECTED
generate int source_row=_n
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L55:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 6 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L56:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 7 51 `=_rc' // WFLOG-INJECTED
generate double rd_indicator_raw=1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L56:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 7 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L57:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 8 51 `=_rc' // WFLOG-INJECTED
generate double val_costrd=2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L57:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 8 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L58:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 9 51 `=_rc' // WFLOG-INJECTED
generate byte vs_rd_indicator_raw=0
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L58:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 9 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L59:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 10 51 `=_rc' // WFLOG-INJECTED
generate byte vs_val_costrd=0
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L59:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 10 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L60:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 11 51 `=_rc' // WFLOG-INJECTED
generate str6 rd17_own_token_class="1"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L60:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 11 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L61:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 12 51 `=_rc' // WFLOG-INJECTED
generate str6 rd17_external_token_class="2"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L61:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 12 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L62:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 13 51 `=_rc' // WFLOG-INJECTED
rd17_wave_guard, expected(3)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L62:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 13 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L63:step-tempfile" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 14 51 `=_rc' // WFLOG-INJECTED
tempfile baseline
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L63:step-tempfile" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 14 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L64:step-save" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 15 51 `=_rc' // WFLOG-INJECTED
save `baseline'
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L64:step-save" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 15 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L65:step-tempname" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 16 51 `=_rc' // WFLOG-INJECTED
tempname POST
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L65:step-tempname" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 16 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L66:step-postfile" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 17 51 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `POST' str32 fixture_id int expected_rc int actual_rc byte passed using "fixtures/guard_results.dta", replace
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L66:step-postfile" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 17 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L67:step-post" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 18 51 `=_rc' // WFLOG-INJECTED
post `POST' ("typed_baseline") (0) (0) (1)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L67:step-post" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 18 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L68:step-foreach" "rd2017/fixtures/bridge_checks.do:L1:file" "loop" 19 51 `=_rc' "in" `"own_value own_state external_value external_state blank_value bad_class bad_width bad_year duplicate_key missing_column bad_numeric_type absent_mismatch"' // WFLOG-INJECTED
* Ulangi blok untuk setiap id yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach id in own_value own_state external_value external_state blank_value bad_class bad_width bad_year duplicate_key missing_column bad_numeric_type absent_mismatch {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "rd2017/fixtures/bridge_checks.do:L68:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L69:step-use" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
 use `baseline', clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L69:step-use" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L70:step-local" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
 local expected=9
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L70:step-local" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L71:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="own_value" replace rd_indicator_raw=2 in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L71:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L72:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="own_state" replace vs_rd_indicator_raw=3 in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L72:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L73:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="external_value" replace val_costrd=1 in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L73:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L74:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="external_state" replace vs_val_costrd=3 in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L74:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L75:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="blank_value" replace rd17_own_token_class="blank" in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L75:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L76:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 8 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="bad_class" replace rd17_own_token_class="oops" in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L76:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 8 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L77:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 9 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="bad_width" recast str8 rd17_own_token_class
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L77:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 9 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L78:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="bad_year" replace source_year=2018 in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L78:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L79:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`id'" sama dengan "duplicate_key". // WFDOC-INJECTED
 if "`id'"=="duplicate_key" {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L79:block-body" "rd2017/fixtures/bridge_checks.do:L79:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L80:step-replace" "rd2017/fixtures/bridge_checks.do:L79:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  replace source_row=1 in 2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L80:step-replace" "rd2017/fixtures/bridge_checks.do:L79:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L81:step-local" "rd2017/fixtures/bridge_checks.do:L79:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  local expected=459
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L81:step-local" "rd2017/fixtures/bridge_checks.do:L79:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L79:block-body" "rd2017/fixtures/bridge_checks.do:L79:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L79:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L83:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 12 18 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`id'" sama dengan "missing_column". // WFDOC-INJECTED
 if "`id'"=="missing_column" {
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L83:block-body" "rd2017/fixtures/bridge_checks.do:L83:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L84:step-drop" "rd2017/fixtures/bridge_checks.do:L83:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  drop val_costrd
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L84:step-drop" "rd2017/fixtures/bridge_checks.do:L83:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L85:step-local" "rd2017/fixtures/bridge_checks.do:L83:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  local expected=111
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L85:step-local" "rd2017/fixtures/bridge_checks.do:L83:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L83:block-body" "rd2017/fixtures/bridge_checks.do:L83:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L83:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 12 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L87:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="bad_numeric_type" recast float val_costrd
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L87:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L88:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
 if "`id'"=="absent_mismatch" replace rd17_own_token_class="absent" in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L88:step-if" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L89:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
 capture noisily rd17_wave_guard, expected(3)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L89:step-rd17_wave_guard" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L90:step-local" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
 local rc=_rc
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L90:step-local" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L91:step-assert" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
 assert `rc'==`expected'
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L91:step-assert" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L92:step-post" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
 post `POST' ("`id'") (`expected') (`rc') (1)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L92:step-post" "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L68:iteration-body" "rd2017/fixtures/bridge_checks.do:L68:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L68:step-foreach" "rd2017/fixtures/bridge_checks.do:L1:file" "loop" 19 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L94:step-postclose" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 20 51 `=_rc' // WFLOG-INJECTED
postclose `POST'
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L94:step-postclose" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 20 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L95:step-use" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 21 51 `=_rc' // WFLOG-INJECTED
use "fixtures/guard_results.dta", clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L95:step-use" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 21 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L96:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 22 51 `=_rc' // WFLOG-INJECTED
assert _N==13 & passed==1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L96:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 22 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L97:step-export" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 23 51 `=_rc' // WFLOG-INJECTED
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
export delimited using "fixtures/guard_results.csv", quote replace
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L97:step-export" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 23 51 `=_rc' // WFLOG-INJECTED
* Wrapper accepts only native-width source strings; class values other years are empty.
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L99:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 24 51 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L99:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 24 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L100:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 25 51 `=_rc' // WFLOG-INJECTED
set obs 3
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L100:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 25 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L101:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 26 51 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L101:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 26 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L102:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 27 51 `=_rc' // WFLOG-INJECTED
replace source_year=2018 in 3
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L102:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 27 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L103:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 28 51 `=_rc' // WFLOG-INJECTED
generate str1 raw_rnd17="1"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L103:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 28 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L104:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 29 51 `=_rc' // WFLOG-INJECTED
replace raw_rnd17="." in 2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L104:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 29 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L105:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 30 51 `=_rc' // WFLOG-INJECTED
generate str1 raw_costrd17="2"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L105:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 30 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L106:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 31 51 `=_rc' // WFLOG-INJECTED
replace raw_costrd17="-" in 2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L106:step-replace" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 31 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L107:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 32 51 `=_rc' // WFLOG-INJECTED
generate double rd_indicator_raw=1 if _n!=2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L107:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 32 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L108:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 33 51 `=_rc' // WFLOG-INJECTED
generate double val_costrd=2 if _n!=2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L108:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 33 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L109:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 34 51 `=_rc' // WFLOG-INJECTED
generate byte vs_rd_indicator_raw=cond(_n==2,3,0)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L109:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 34 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L110:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 35 51 `=_rc' // WFLOG-INJECTED
generate byte vs_val_costrd=cond(_n==2,3,0)
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L110:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 35 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L111:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 36 51 `=_rc' // WFLOG-INJECTED
wave_rd17_classes
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L111:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 36 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L112:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 37 51 `=_rc' // WFLOG-INJECTED
assert rd17_own_token_class=="1" & rd17_external_token_class=="2" in 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L112:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 37 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L113:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 38 51 `=_rc' // WFLOG-INJECTED
assert rd17_own_token_class=="other" & rd17_external_token_class=="other" in 2
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L113:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 38 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L114:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 39 51 `=_rc' // WFLOG-INJECTED
assert rd17_own_token_class=="" & rd17_external_token_class=="" in 3
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L114:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 39 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L115:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 40 51 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L115:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 40 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L116:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 41 51 `=_rc' // WFLOG-INJECTED
set obs 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L116:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 41 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L117:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 42 51 `=_rc' // WFLOG-INJECTED
generate int source_year=2018
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L117:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 42 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L118:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 43 51 `=_rc' // WFLOG-INJECTED
wave_rd17_classes
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L118:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 43 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L119:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 44 51 `=_rc' // WFLOG-INJECTED
assert rd17_own_token_class=="" & rd17_external_token_class==""
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L119:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 44 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L120:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 45 51 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L120:step-clear" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 45 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L121:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 46 51 `=_rc' // WFLOG-INJECTED
set obs 1
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L121:step-set" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 46 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L122:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 47 51 `=_rc' // WFLOG-INJECTED
generate int source_year=2017
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L122:step-generate" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 47 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L123:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 48 51 `=_rc' // WFLOG-INJECTED
capture noisily wave_rd17_classes
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L123:step-wave_rd17_classes" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 48 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L124:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 49 51 `=_rc' // WFLOG-INJECTED
assert _rc==111
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L124:step-assert" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 49 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L125:step-display" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 50 51 `=_rc' // WFLOG-INJECTED
display "RD17_UPSTREAM_WRAPPER_PASS"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L125:step-display" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 50 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/fixtures/bridge_checks.do:L126:step-display" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 51 51 `=_rc' // WFLOG-INJECTED
display "RD17_BRIDGE_AND_GUARD_FIXTURES_PASS"
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L126:step-display" "rd2017/fixtures/bridge_checks.do:L1:file" "statement" 51 51 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/fixtures/bridge_checks.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
