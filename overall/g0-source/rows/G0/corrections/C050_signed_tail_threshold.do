* Tujuan: Untuk tiap tahun, hitung persentil ke-99 dari nilai absolut nilai tambah sebagai ambang uji sensitivitas. // WFDOC-INJECTED
* Input: corrections/data/C030.dta // WFDOC-INJECTED
* Output: corrections/data/C050.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C050_signed_tail_threshold"
* Hitung persentil ke-99 dari nilai absolut nilai tambah per tahun; ambang dipakai untuk uji sensitivitas, bukan untuk mengubah nilai tambah. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
* Ubah tanda hanya untuk membuat besar absolut; nilai tambah asli tidak diubah. // WFDOC-INJECTED
generate double __absolute=abs(va_signed_nominal)
* Hitung ambang p99 secara terpisah dalam tiap tahun dari besar absolut nilai tambah. // WFDOC-INJECTED
bysort source_year: egen double p99_abs_va=pctile(__absolute), p(99)
generate long __nonzero=va_signed_nominal!=0 & !missing(va_signed_nominal)
* Ringkas menjadi satu baris per tahun: jumlah nilai tambah teramati, banyak yang tidak nol, dan ambang p99. // WFDOC-INJECTED
collapse (count) n_signed_va=va_signed_nominal (sum) n_nonzero=__nonzero (first) p99_abs_va, by(source_year)
recast long n_signed_va n_nonzero
replace p99_abs_va=. if n_signed_va==0
isid source_year
keep source_year n_signed_va n_nonzero p99_abs_va
order source_year
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C050_signed_tail_threshold" "C050"
