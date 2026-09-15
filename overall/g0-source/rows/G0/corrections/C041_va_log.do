* Tujuan: Hitung log natural nilai tambah hanya saat nilainya positif; nol, negatif, dan missing tetap tanpa hasil log. // WFDOC-INJECTED
* Input: corrections/data/C030.dta // WFDOC-INJECTED
* Output: corrections/data/C041.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C041_va_log"
* Log natural hanya dihitung untuk nilai tambah positif; nol, negatif, dan missing tidak menghasilkan log. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
* Helper menghitung ln(nilai tambah) hanya bila nilai tambah>0 dan terisi; hasil lain tetap missing. // WFDOC-INJECTED
g0c_log va_signed_nominal, generate(va_log_positive)
keep source_year source_row va_log_positive
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C041_va_log" "C041"
