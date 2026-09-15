* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L1:step-version" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L1:step-version" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
* Upstream only. Exact literal classes from the passed 2017 parser.
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L3:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture program drop wave_rd17_literal_class
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L3:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L4:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu wave_rd17_literal_class; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wave_rd17_literal_class
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L5:step-syntax" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
 syntax varname(string), GENerate(name) PRESENT(varname numeric)
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L5:step-syntax" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L6:step-assert" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
 assert inlist(`present',0,1)
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L6:step-assert" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L7:step-tempvar" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
 tempvar token
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L7:step-tempvar" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L8:step-clonevar" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
 clonevar `token'=`varlist'
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L8:step-clonevar" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L9:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
 replace `token'=ustrtrim(`token')
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L9:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L10:step-generate" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
 generate str6 `generate'="other"
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L10:step-generate" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L11:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
 replace `generate'=`token' if inlist(`token',"1","2")
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L11:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L12:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
 replace `generate'="blank" if `token'==""
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L12:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L13:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
 replace `generate'="absent" if `present'==0
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L13:step-replace" "rd2017/lib/wave_rd17_classes.do:L4:program-body" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L4:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L15:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture program drop wave_rd17_classes
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L15:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L16:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu wave_rd17_classes; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wave_rd17_classes
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L16:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L17:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
 confirm numeric variable source_year
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L17:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L18:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
 confirm new variable rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L18:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L19:step-count" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
 quietly count if source_year==2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L19:step-count" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L20:step-if" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila r(N) sama dengan 0. // WFDOC-INJECTED
 if r(N)==0 {
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L20:block-body" "rd2017/lib/wave_rd17_classes.do:L20:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L21:step-generate" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
  generate str6 rd17_own_token_class=""
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L21:step-generate" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L22:step-generate" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
  generate str6 rd17_external_token_class=""
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L22:step-generate" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L23:step-exit" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L23:step-exit" "rd2017/lib/wave_rd17_classes.do:L20:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L20:block-body" "rd2017/lib/wave_rd17_classes.do:L20:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L20:step-if" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L25:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
 confirm string variable raw_rnd17 raw_costrd17
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L25:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L26:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
 confirm numeric variable rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L26:step-confirm" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L27:step-foreach" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "loop" 7 14 `=_rc' "in" `"raw_rnd17 raw_costrd17"' // WFLOG-INJECTED
* Ulangi blok untuk v: raw_rnd17, raw_costrd17. // WFDOC-INJECTED
 foreach v in raw_rnd17 raw_costrd17 {
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "rd2017/lib/wave_rd17_classes.do:L27:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L28:step-local" "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L28:step-local" "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L29:step-assert" "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  assert "`t'"=="str1"
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L29:step-assert" "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L27:iteration-body" "rd2017/lib/wave_rd17_classes.do:L27:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L27:step-foreach" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "loop" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L31:step-tempvar" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
 tempvar present own external
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L31:step-tempvar" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L32:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
 generate byte `present'=1
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L32:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L33:step-wave_rd17_literal_class" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
 wave_rd17_literal_class raw_rnd17, generate(`own') present(`present')
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L33:step-wave_rd17_literal_class" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L34:step-wave_rd17_literal_class" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
 wave_rd17_literal_class raw_costrd17, generate(`external') present(`present')
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L34:step-wave_rd17_literal_class" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L35:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
 generate str6 rd17_own_token_class=`own' if source_year==2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L35:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L36:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
 generate str6 rd17_external_token_class=`external' if source_year==2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L36:step-generate" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L37:step-foreach" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "loop" 14 14 `=_rc' "in" `"own external"' // WFLOG-INJECTED
* Ulangi blok untuk side: own, external. // WFDOC-INJECTED
 foreach side in own external {
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "rd2017/lib/wave_rd17_classes.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L38:step-local" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
  local value=cond("`side'"=="own","rd_indicator_raw","val_costrd")
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L38:step-local" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L39:step-local" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
  local state=cond("`side'"=="own","vs_rd_indicator_raw","vs_val_costrd")
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L39:step-local" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L40:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
  assert inlist(`state',0,1,2,3,5) if source_year==2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L40:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L41:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
  assert `value'==1 & `state'==0 if source_year==2017 & rd17_`side'_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L41:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L42:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
  assert `value'==2 & `state'==0 if source_year==2017 & rd17_`side'_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L42:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L43:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
  assert missing(`value') & inlist(`state',3,5) if source_year==2017 & rd17_`side'_token_class=="blank"
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L43:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L44:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
  assert inlist(rd17_`side'_token_class,"1","2","blank","other") if source_year==2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L44:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/wave_rd17_classes.do:L45:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
  assert rd17_`side'_token_class=="" if source_year!=2017
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L45:step-assert" "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L37:iteration-body" "rd2017/lib/wave_rd17_classes.do:L37:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L37:step-foreach" "rd2017/lib/wave_rd17_classes.do:L16:program-body" "loop" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L16:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L16:step-program" "rd2017/lib/wave_rd17_classes.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/wave_rd17_classes.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
