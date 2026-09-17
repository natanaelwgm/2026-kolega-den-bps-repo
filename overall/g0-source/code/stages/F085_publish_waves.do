* Tujuan: Bagi data koreksi C140 menjadi 12 file tahunan; tiap file hanya berisi satu source_year, memeriksa source_year/source_row, lalu disimpan. // WFDOC-INJECTED
* Input: corrections/data/C140.dta // WFDOC-INJECTED
* Output: data/waves/wave_2010.dta; data/waves/wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "corrections/data/C140.dta", clear
assert c(k)==4591
* Jalankan tahap/berkas anak rd2017/lib/wave_rd17_classes.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rd2017/lib/wave_rd17_classes.do"
wave_rd17_classes
assert c(k)==4593
isid source_year source_row
* Untuk tiap tahun, pilih baris tahun itu saja, cek source_year/source_row, simpan wave, lalu restore sebelum tahun berikutnya. // WFDOC-INJECTED
preserve
keep if source_year==2010
assert source_year==2010
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2010.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2011
assert source_year==2011
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2011.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2012
assert source_year==2012
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2012.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2013
assert source_year==2013
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2013.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2014
assert source_year==2014
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2014.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2015
assert source_year==2015
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2015.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2017
assert source_year==2017
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2017.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2018
assert source_year==2018
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2018.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2019
assert source_year==2019
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2019.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2020
assert source_year==2020
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2020.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2021
assert source_year==2021
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2021.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2022
assert source_year==2022
isid source_year source_row
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2022.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
display "WF_STAGE_F085_PASS"
