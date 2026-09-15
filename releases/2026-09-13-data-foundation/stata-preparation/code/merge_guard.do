* Tujuan: Sebelum merge, periksa tahun yang diharapkan, keunikan kunci source_year/source_row, kolom tujuan, dan jumlah pasangan baris; kegagalan membuat merge berhenti. // WFDOC-INJECTED
* Input: `using' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L1:step-program" "code/merge_guard.do:L1:file" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture program drop wf_merge_guard
capture noisily __wf_progress end "code/merge_guard.do:L1:step-program" "code/merge_guard.do:L1:file" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L2:step-program" "code/merge_guard.do:L1:file" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Definisikan pemeriksa sebelum merge: memastikan tahun sesuai, kunci tahun/baris unik, tidak ada kolom tujuan lama, dan semua baris punya pasangan. // WFDOC-INJECTED
* Definisikan perintah bantu wf_merge_guard; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wf_merge_guard
capture noisily __wf_progress start "code/merge_guard.do:L2:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L3:step-syntax" "code/merge_guard.do:L2:program-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
 syntax, USING(string) FIELDS(string) YEAR(integer)
capture noisily __wf_progress end "code/merge_guard.do:L3:step-syntax" "code/merge_guard.do:L2:program-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L4:step-assert" "code/merge_guard.do:L2:program-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
 assert source_year==`year'
capture noisily __wf_progress end "code/merge_guard.do:L4:step-assert" "code/merge_guard.do:L2:program-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L5:step-isid" "code/merge_guard.do:L2:program-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
 isid source_year source_row
capture noisily __wf_progress end "code/merge_guard.do:L5:step-isid" "code/merge_guard.do:L2:program-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L6:step-local" "code/merge_guard.do:L2:program-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
 local oldn=_N
capture noisily __wf_progress end "code/merge_guard.do:L6:step-local" "code/merge_guard.do:L2:program-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L7:step-foreach" "code/merge_guard.do:L2:program-body" "loop" 5 14 `=_rc' "local-expanded" `"`fields'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local fields. // WFDOC-INJECTED
 foreach v of local fields {
capture noisily __wf_progress start "code/merge_guard.do:L7:iteration-body" "code/merge_guard.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L8:step-confirm" "code/merge_guard.do:L7:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
  capture confirm variable `v'
capture noisily __wf_progress end "code/merge_guard.do:L8:step-confirm" "code/merge_guard.do:L7:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L9:step-assert" "code/merge_guard.do:L7:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
  assert _rc==111
capture noisily __wf_progress end "code/merge_guard.do:L9:step-assert" "code/merge_guard.do:L7:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/merge_guard.do:L7:iteration-body" "code/merge_guard.do:L7:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "code/merge_guard.do:L7:step-foreach" "code/merge_guard.do:L2:program-body" "loop" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L11:step-preserve" "code/merge_guard.do:L2:program-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
 preserve
capture noisily __wf_progress end "code/merge_guard.do:L11:step-preserve" "code/merge_guard.do:L2:program-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L12:step-use" "code/merge_guard.do:L2:program-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
 use "`using'", clear
capture noisily __wf_progress end "code/merge_guard.do:L12:step-use" "code/merge_guard.do:L2:program-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L13:step-assert" "code/merge_guard.do:L2:program-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
 assert source_year==`year'
capture noisily __wf_progress end "code/merge_guard.do:L13:step-assert" "code/merge_guard.do:L2:program-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L14:step-isid" "code/merge_guard.do:L2:program-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
 isid source_year source_row
capture noisily __wf_progress end "code/merge_guard.do:L14:step-isid" "code/merge_guard.do:L2:program-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L15:step-foreach" "code/merge_guard.do:L2:program-body" "loop" 10 14 `=_rc' "local-expanded" `"`fields'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local fields. // WFDOC-INJECTED
 foreach v of local fields {
capture noisily __wf_progress start "code/merge_guard.do:L15:iteration-body" "code/merge_guard.do:L15:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L16:step-confirm" "code/merge_guard.do:L15:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
  confirm variable `v'
capture noisily __wf_progress end "code/merge_guard.do:L16:step-confirm" "code/merge_guard.do:L15:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/merge_guard.do:L15:iteration-body" "code/merge_guard.do:L15:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "code/merge_guard.do:L15:step-foreach" "code/merge_guard.do:L2:program-body" "loop" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L18:step-restore" "code/merge_guard.do:L2:program-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
 restore
capture noisily __wf_progress end "code/merge_guard.do:L18:step-restore" "code/merge_guard.do:L2:program-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L19:step-merge" "code/merge_guard.do:L2:program-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
 merge 1:1 source_year source_row using "`using'", assert(match) nogen keepusing(`fields')
capture noisily __wf_progress end "code/merge_guard.do:L19:step-merge" "code/merge_guard.do:L2:program-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L20:step-assert" "code/merge_guard.do:L2:program-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
 assert _N==`oldn'
capture noisily __wf_progress end "code/merge_guard.do:L20:step-assert" "code/merge_guard.do:L2:program-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/merge_guard.do:L21:step-isid" "code/merge_guard.do:L2:program-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
 isid source_year source_row
capture noisily __wf_progress end "code/merge_guard.do:L21:step-isid" "code/merge_guard.do:L2:program-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/merge_guard.do:L2:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "code/merge_guard.do:L2:step-program" "code/merge_guard.do:L1:file" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/merge_guard.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
