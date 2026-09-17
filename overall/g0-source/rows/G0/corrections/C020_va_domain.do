* Tujuan: Pisahkan nilai tambah yang teramati (positif, nol, atau negatif) dari nilai kosong/status; nilai bertanda tidak otomatis dibuang. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C020_va_domain"
* Pisahkan nilai tambah bertanda yang teramati dari nilai kosong/status; nilai negatif dan nol tetap termasuk domain, bukan otomatis dibuang. // WFDOC-INJECTED
use source_year source_row value_added_nominal st_value_added_nominal using "corrections/data/C010.dta", clear
assert inrange(st_value_added_nominal,0,5)
assert st_value_added_nominal==0 if value_added_nominal>0 & !missing(value_added_nominal)
assert st_value_added_nominal==1 if value_added_nominal==0
assert st_value_added_nominal==2 if value_added_nominal<0 & !missing(value_added_nominal)
assert missing(value_added_nominal) if inlist(st_value_added_nominal,3,4,5)
generate byte va_source_state=st_value_added_nominal
generate byte va_signed_eligible=inlist(va_source_state,0,1,2) & !missing(value_added_nominal)
generate str24 va_missing_reason="observed_signed"
replace va_missing_reason="observation_missing" if va_source_state==3
replace va_missing_reason="source_absent" if va_source_state==4
replace va_missing_reason="parse_failure" if va_source_state==5
keep source_year source_row va_source_state va_signed_eligible va_missing_reason
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C020_va_domain" "C020"
