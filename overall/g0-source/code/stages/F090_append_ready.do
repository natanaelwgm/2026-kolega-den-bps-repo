* Tujuan: Satukan 12 file tahunan menjadi data utama G0_analysis_ready; kode memeriksa kunci unik, 33.049 baris, dan 4.593 kolom sebelum menyimpan. // WFDOC-INJECTED
* Input: data/waves/wave_2010.dta; data/waves/wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Output: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Mulai dari wave 2010 lalu append 11 wave lainnya; di akhir, cek kunci unik, jumlah baris/kolom, dan simpan data utama. // WFDOC-INJECTED
use "data/waves/wave_2010.dta", clear
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2011.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2012.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2013.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2014.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2015.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2017.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2018.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2019.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2020.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2021.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2022.dta"
isid source_year source_row
assert _N==33049
assert c(k)==4593
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/analysis/G0_analysis_ready.dta", replace
display "WF_STAGE_F090_APPEND_PASS"
