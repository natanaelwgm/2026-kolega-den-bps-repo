* Tujuan: Sebelum merge, periksa tahun yang diharapkan, keunikan kunci source_year/source_row, kolom tujuan, dan jumlah pasangan baris; kegagalan membuat merge berhenti. // WFDOC-INJECTED
* Input: `using' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture program drop wf_merge_guard
* Definisikan pemeriksa sebelum merge: memastikan tahun sesuai, kunci tahun/baris unik, tidak ada kolom tujuan lama, dan semua baris punya pasangan. // WFDOC-INJECTED
* Definisikan perintah bantu wf_merge_guard; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wf_merge_guard
 syntax, USING(string) FIELDS(string) YEAR(integer)
 assert source_year==`year'
 isid source_year source_row
 local oldn=_N
* Ulangi blok untuk tiap v dalam daftar local fields. // WFDOC-INJECTED
 foreach v of local fields {
  capture confirm variable `v'
  assert _rc==111
 }
 preserve
 use "`using'", clear
 assert source_year==`year'
 isid source_year source_row
* Ulangi blok untuk tiap v dalam daftar local fields. // WFDOC-INJECTED
 foreach v of local fields {
  confirm variable `v'
 }
 restore
 merge 1:1 source_year source_row using "`using'", assert(match) nogen keepusing(`fields')
 assert _N==`oldn'
 isid source_year source_row
end
