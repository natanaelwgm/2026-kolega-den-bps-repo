* Tujuan: Hitung nilai tambah per pekerja; pembilang bertanda boleh negatif, tetapi jumlah pekerja harus positif dan kedua angka harus tersedia. // WFDOC-INJECTED
* Input: corrections/data/C030.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C040.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C040_va_per_worker"
* Hitung nilai tambah per pekerja untuk pembilang bertanda; helper menolak pekerja kosong/tidak positif dan menjaga nilai tambah negatif tetap dapat dihitung. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
* Helper membagi nilai tambah dengan workers hanya bila keduanya terisi dan workers>0; opsi signed mengizinkan pembilang negatif, sedangkan hasil lain tetap missing. // WFDOC-INJECTED
g0c_ratio va_signed_nominal workers, generate(va_signed_per_worker) signed
keep source_year source_row va_signed_per_worker
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C040_va_per_worker" "C040"
