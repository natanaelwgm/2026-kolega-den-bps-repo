* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L1:step-version" "rd2017/lib/from_wave.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L1:step-version" "rd2017/lib/from_wave.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
* Numerical decisions consume canonical values/statuses/classes, never raw text.
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L3:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture program drop rd17_wave_guard
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L3:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L4:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_wave_guard; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define rd17_wave_guard
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L5:step-syntax" "rd2017/lib/from_wave.do:L4:program-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
 syntax, [EXPECTED(integer 0)]
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L5:step-syntax" "rd2017/lib/from_wave.do:L4:program-body" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L6:step-confirm" "rd2017/lib/from_wave.do:L4:program-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
 confirm numeric variable source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L6:step-confirm" "rd2017/lib/from_wave.do:L4:program-body" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L7:step-confirm" "rd2017/lib/from_wave.do:L4:program-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
 confirm string variable rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L7:step-confirm" "rd2017/lib/from_wave.do:L4:program-body" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L8:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 4 11 `=_rc' "in" `"source_year source_row"' // WFLOG-INJECTED
* Ulangi blok untuk v: source_year, source_row. // WFDOC-INJECTED
 foreach v in source_year source_row {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L8:iteration-body" "rd2017/lib/from_wave.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L9:step-local" "rd2017/lib/from_wave.do:L8:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L9:step-local" "rd2017/lib/from_wave.do:L8:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L10:step-assert" "rd2017/lib/from_wave.do:L8:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  assert "`t'"=="int"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L10:step-assert" "rd2017/lib/from_wave.do:L8:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L8:iteration-body" "rd2017/lib/from_wave.do:L8:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L8:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L12:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 5 11 `=_rc' "in" `"rd_indicator_raw val_costrd"' // WFLOG-INJECTED
* Ulangi blok untuk v: rd_indicator_raw, val_costrd. // WFDOC-INJECTED
 foreach v in rd_indicator_raw val_costrd {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L12:iteration-body" "rd2017/lib/from_wave.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L13:step-local" "rd2017/lib/from_wave.do:L12:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L13:step-local" "rd2017/lib/from_wave.do:L12:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L14:step-assert" "rd2017/lib/from_wave.do:L12:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  assert "`t'"=="double"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L14:step-assert" "rd2017/lib/from_wave.do:L12:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L12:iteration-body" "rd2017/lib/from_wave.do:L12:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L12:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L16:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 6 11 `=_rc' "in" `"vs_rd_indicator_raw vs_val_costrd"' // WFLOG-INJECTED
* Ulangi blok untuk v: vs_rd_indicator_raw, vs_val_costrd. // WFDOC-INJECTED
 foreach v in vs_rd_indicator_raw vs_val_costrd {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L16:iteration-body" "rd2017/lib/from_wave.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L17:step-local" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L17:step-local" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L18:step-assert" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
  assert "`t'"=="byte"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L18:step-assert" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L19:step-assert" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
  assert inlist(`v',0,1,2,3,4,5)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L19:step-assert" "rd2017/lib/from_wave.do:L16:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L16:iteration-body" "rd2017/lib/from_wave.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L16:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L21:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 7 11 `=_rc' "in" `"rd17_own_token_class rd17_external_token_class"' // WFLOG-INJECTED
* Ulangi blok untuk v: rd17_own_token_class, rd17_external_token_class. // WFDOC-INJECTED
 foreach v in rd17_own_token_class rd17_external_token_class {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L21:iteration-body" "rd2017/lib/from_wave.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L22:step-local" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L22:step-local" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L23:step-assert" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
  assert "`t'"=="str6"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L23:step-assert" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L24:step-assert" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
  assert inlist(`v',"1","2","blank","other","absent")
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L24:step-assert" "rd2017/lib/from_wave.do:L21:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L21:iteration-body" "rd2017/lib/from_wave.do:L21:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L21:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L26:step-assert" "rd2017/lib/from_wave.do:L4:program-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
 assert source_year==2017 & !missing(source_row)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L26:step-assert" "rd2017/lib/from_wave.do:L4:program-body" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L27:step-isid" "rd2017/lib/from_wave.do:L4:program-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
 isid source_year source_row
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L27:step-isid" "rd2017/lib/from_wave.do:L4:program-body" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L28:step-if" "rd2017/lib/from_wave.do:L4:program-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
 if `expected'>0 assert _N==`expected'
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L28:step-if" "rd2017/lib/from_wave.do:L4:program-body" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L29:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 11 11 `=_rc' "in" `"own external"' // WFLOG-INJECTED
* Ulangi blok untuk side: own, external. // WFDOC-INJECTED
 foreach side in own external {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L29:iteration-body" "rd2017/lib/from_wave.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L30:step-local" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
  local value=cond("`side'"=="own","rd_indicator_raw","val_costrd")
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L30:step-local" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L31:step-local" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
  local state=cond("`side'"=="own","vs_rd_indicator_raw","vs_val_costrd")
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L31:step-local" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L32:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
  assert `value'==1 & `state'==0 if rd17_`side'_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L32:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L33:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
  assert `value'==2 & `state'==0 if rd17_`side'_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L33:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L34:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
  assert missing(`value') & inlist(`state',3,5) if rd17_`side'_token_class=="blank"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L34:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L35:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
  assert missing(`value') & `state'==4 if rd17_`side'_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L35:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L36:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
  assert `state'!=4 if rd17_`side'_token_class!="absent"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L36:step-assert" "rd2017/lib/from_wave.do:L29:iteration-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L29:iteration-body" "rd2017/lib/from_wave.do:L29:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L29:step-foreach" "rd2017/lib/from_wave.do:L4:program-body" "loop" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L4:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L39:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture program drop rd17_from_wave
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L39:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L40:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_from_wave; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define rd17_from_wave
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L40:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L41:step-syntax" "rd2017/lib/from_wave.do:L40:program-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
 syntax, STAGE(string)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L41:step-syntax" "rd2017/lib/from_wave.do:L40:program-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L42:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "classes". // WFDOC-INJECTED
 if "`stage'"=="classes" {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L42:block-body" "rd2017/lib/from_wave.do:L42:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L43:step-rd17_wave_guard" "rd2017/lib/from_wave.do:L42:block-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
  rd17_wave_guard
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L43:step-rd17_wave_guard" "rd2017/lib/from_wave.do:L42:block-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L44:step-clonevar" "rd2017/lib/from_wave.do:L42:block-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
  clonevar parent_token_class=rd17_own_token_class
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L44:step-clonevar" "rd2017/lib/from_wave.do:L42:block-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L45:step-clonevar" "rd2017/lib/from_wave.do:L42:block-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
  clonevar child_token_class=rd17_external_token_class
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L45:step-clonevar" "rd2017/lib/from_wave.do:L42:block-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L46:step-exit" "rd2017/lib/from_wave.do:L42:block-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L46:step-exit" "rd2017/lib/from_wave.do:L42:block-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L42:block-body" "rd2017/lib/from_wave.do:L42:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L42:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L48:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "universe". // WFDOC-INJECTED
 if "`stage'"=="universe" {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L48:block-body" "rd2017/lib/from_wave.do:L48:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L49:step-generate" "rd2017/lib/from_wave.do:L48:block-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=.
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L49:step-generate" "rd2017/lib/from_wave.do:L48:block-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L50:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=0 if rd_indicator_raw==2 & vs_rd_indicator_raw==0 & parent_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L50:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L51:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=1 if rd_indicator_raw==1 & vs_rd_indicator_raw==0 & parent_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L51:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L52:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=2 if inlist(parent_token_class,"blank","other")
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L52:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L53:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=3 if parent_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L53:step-replace" "rd2017/lib/from_wave.do:L48:block-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L54:step-assert" "rd2017/lib/from_wave.do:L48:block-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
  assert inrange(rd_universe_candidate,0,3)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L54:step-assert" "rd2017/lib/from_wave.do:L48:block-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L55:step-exit" "rd2017/lib/from_wave.do:L48:block-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L55:step-exit" "rd2017/lib/from_wave.do:L48:block-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L48:block-body" "rd2017/lib/from_wave.do:L48:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L48:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L57:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "answer". // WFDOC-INJECTED
 if "`stage'"=="answer" {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L57:block-body" "rd2017/lib/from_wave.do:L57:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L58:step-generate" "rd2017/lib/from_wave.do:L57:block-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=.
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L58:step-generate" "rd2017/lib/from_wave.do:L57:block-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L59:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=4 if rd_universe_candidate==1
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L59:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L60:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=5 if inlist(rd_universe_candidate,2,3)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L60:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L61:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=0 if rd_universe_candidate==0 & val_costrd==1 & vs_val_costrd==0 & child_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L61:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L62:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=1 if rd_universe_candidate==0 & val_costrd==2 & vs_val_costrd==0 & child_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L62:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L63:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=2 if rd_universe_candidate==0 & child_token_class=="blank"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L63:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L64:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=3 if rd_universe_candidate==0 & child_token_class=="other"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L64:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L65:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=6 if rd_universe_candidate==0 & child_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L65:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L66:step-assert" "rd2017/lib/from_wave.do:L57:block-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
  assert inrange(rd_answer_state_candidate,0,6)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L66:step-assert" "rd2017/lib/from_wave.do:L57:block-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L67:step-generate" "rd2017/lib/from_wave.do:L57:block-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=.
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L67:step-generate" "rd2017/lib/from_wave.do:L57:block-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L68:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
  replace rd_external_candidate=1 if rd_answer_state_candidate==0
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L68:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L69:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
  replace rd_external_candidate=0 if rd_answer_state_candidate==1
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L69:step-replace" "rd2017/lib/from_wave.do:L57:block-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L70:step-assert" "rd2017/lib/from_wave.do:L57:block-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
  assert missing(rd_external_candidate) if !inlist(rd_answer_state_candidate,0,1)
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L70:step-assert" "rd2017/lib/from_wave.do:L57:block-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L71:step-exit" "rd2017/lib/from_wave.do:L57:block-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L71:step-exit" "rd2017/lib/from_wave.do:L57:block-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L57:block-body" "rd2017/lib/from_wave.do:L57:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L57:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L73:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "audit". // WFDOC-INJECTED
 if "`stage'"=="audit" {
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L73:block-body" "rd2017/lib/from_wave.do:L73:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L74:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
  generate byte outside_answer_candidate=rd_universe_candidate==1 & inlist(child_token_class,"1","2","other")
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L74:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L75:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=0
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L75:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L76:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=0
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L76:step-generate" "rd2017/lib/from_wave.do:L73:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L77:step-assert" "rd2017/lib/from_wave.do:L73:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
  assert missing(rd_external_candidate) if rd_universe_candidate!=0
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L77:step-assert" "rd2017/lib/from_wave.do:L73:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L78:step-assert" "rd2017/lib/from_wave.do:L73:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
  assert outside_answer_candidate==0 if rd_universe_candidate!=1
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L78:step-assert" "rd2017/lib/from_wave.do:L73:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L79:step-exit" "rd2017/lib/from_wave.do:L73:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L79:step-exit" "rd2017/lib/from_wave.do:L73:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L73:block-body" "rd2017/lib/from_wave.do:L73:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L73:step-if" "rd2017/lib/from_wave.do:L40:program-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L81:step-display" "rd2017/lib/from_wave.do:L40:program-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
 display as error "Undeclared canonical classifier stage"
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L81:step-display" "rd2017/lib/from_wave.do:L40:program-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/from_wave.do:L82:step-exit" "rd2017/lib/from_wave.do:L40:program-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
 exit 198
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L82:step-exit" "rd2017/lib/from_wave.do:L40:program-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L40:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L40:step-program" "rd2017/lib/from_wave.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/from_wave.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
