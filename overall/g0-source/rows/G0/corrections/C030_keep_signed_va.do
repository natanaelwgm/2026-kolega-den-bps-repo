* Tujuan: Teruskan nilai tambah asli hanya untuk baris yang lolos status C020; pemeriksaan memastikan angka terpilih sama dengan sumber. // WFDOC-INJECTED
* Input: corrections/data/C010.dta; corrections/data/C020.dta // WFDOC-INJECTED
* Output: corrections/data/C030.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C030_keep_signed_va"
* Salin nilai tambah apa adanya hanya untuk baris yang dinyatakan eligible; pemeriksaan sesudahnya memastikan salinan sama dengan sumber. // WFDOC-INJECTED
use source_year source_row value_added_nominal using "corrections/data/C010.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C020.dta", assert(match) nogen keepusing(va_signed_eligible)
generate double va_signed_nominal=.
replace va_signed_nominal=value_added_nominal if va_signed_eligible
assert va_signed_nominal==value_added_nominal if va_signed_eligible
keep source_year source_row va_signed_nominal
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C030_keep_signed_va" "C030"
