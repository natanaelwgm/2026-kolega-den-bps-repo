* Tujuan: Tandai nilai tambah yang absolutnya lebih dari 10 kali ambang tahun tersebut; salinan sensitivitas hanya menyimpan nilai yang tidak masuk ekor itu. // WFDOC-INJECTED
* Input: corrections/data/C030.dta; corrections/data/C050.dta // WFDOC-INJECTED
* Output: corrections/data/C060.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C060_signed_tail_companion"
* Tandai nilai yang absolutnya lebih dari 10 kali ambang persentil ke-99 tahun itu; nilai bertanda asli hanya diteruskan jika bukan ekor tersebut. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
* Pasangkan satu ambang p99 per tahun ke tiap baris tahun yang sama. // WFDOC-INJECTED
merge m:1 source_year using "corrections/data/C050.dta", assert(match) nogen keepusing(p99_abs_va)
* Tandai jika nilai absolut lebih dari 10 kali p99 tahun itu; missing input/ambang tidak diberi flag. // WFDOC-INJECTED
generate byte va_abs_tail_flag=abs(va_signed_nominal)>10*p99_abs_va if !missing(va_signed_nominal,p99_abs_va) & p99_abs_va>=0
* Pertahankan angka bertanda hanya untuk baris di luar flag ekor; ini kolom sensitivitas, bukan pengganti nilai utama. // WFDOC-INJECTED
generate double va_signed_tail_sensitivity=va_signed_nominal if va_abs_tail_flag==0
keep source_year source_row va_abs_tail_flag va_signed_tail_sensitivity
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C060_signed_tail_companion" "C060"
