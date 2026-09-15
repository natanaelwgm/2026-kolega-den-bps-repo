* Tujuan: Bagi data koreksi C140 menjadi 12 file tahunan; tiap file hanya berisi satu source_year, memeriksa source_year/source_row, lalu disimpan. // WFDOC-INJECTED
* Input: corrections/data/C140.dta // WFDOC-INJECTED
* Output: data/waves/wave_2010.dta; data/waves/wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L1:step-do" "code/stages/F085_publish_waves.do:L1:file" "statement" 1 80 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L1:step-do" "code/stages/F085_publish_waves.do:L1:file" "statement" 1 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L2:step-use" "code/stages/F085_publish_waves.do:L1:file" "statement" 2 80 `=_rc' // WFLOG-INJECTED
use "corrections/data/C140.dta", clear
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L2:step-use" "code/stages/F085_publish_waves.do:L1:file" "statement" 2 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L3:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 3 80 `=_rc' // WFLOG-INJECTED
assert c(k)==4591
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L3:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 3 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L4:step-do" "code/stages/F085_publish_waves.do:L1:file" "statement" 4 80 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rd2017/lib/wave_rd17_classes.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rd2017/lib/wave_rd17_classes.do"
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L4:step-do" "code/stages/F085_publish_waves.do:L1:file" "statement" 4 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L5:step-wave_rd17_classes" "code/stages/F085_publish_waves.do:L1:file" "statement" 5 80 `=_rc' // WFLOG-INJECTED
wave_rd17_classes
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L5:step-wave_rd17_classes" "code/stages/F085_publish_waves.do:L1:file" "statement" 5 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L6:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 6 80 `=_rc' // WFLOG-INJECTED
assert c(k)==4593
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L6:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 6 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L7:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 7 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L7:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 7 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L8:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 8 80 `=_rc' // WFLOG-INJECTED
* Untuk tiap tahun, pilih baris tahun itu saja, cek source_year/source_row, simpan wave, lalu restore sebelum tahun berikutnya. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L8:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 8 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L9:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 9 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2010
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L9:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 9 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L10:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 10 80 `=_rc' // WFLOG-INJECTED
assert source_year==2010
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L10:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 10 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L11:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 11 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L11:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 11 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L12:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 12 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2010.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L12:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 12 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L13:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 13 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L13:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 13 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L14:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 14 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L14:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 14 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L15:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 15 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2011
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L15:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 15 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L16:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 16 80 `=_rc' // WFLOG-INJECTED
assert source_year==2011
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L16:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 16 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L17:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 17 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L17:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 17 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L18:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 18 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2011.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L18:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 18 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L19:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 19 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L19:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 19 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L20:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 20 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L20:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 20 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L21:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 21 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2012
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L21:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 21 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L22:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 22 80 `=_rc' // WFLOG-INJECTED
assert source_year==2012
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L22:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 22 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L23:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 23 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L23:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 23 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L24:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 24 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2012.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L24:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 24 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L25:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 25 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L25:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 25 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L26:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 26 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L26:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 26 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L27:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 27 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2013
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L27:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 27 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L28:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 28 80 `=_rc' // WFLOG-INJECTED
assert source_year==2013
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L28:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 28 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L29:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 29 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L29:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 29 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L30:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 30 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2013.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L30:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 30 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L31:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 31 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L31:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 31 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L32:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 32 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L32:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 32 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L33:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 33 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2014
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L33:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 33 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L34:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 34 80 `=_rc' // WFLOG-INJECTED
assert source_year==2014
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L34:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 34 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L35:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 35 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L35:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 35 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L36:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 36 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2014.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L36:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 36 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L37:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 37 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L37:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 37 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L38:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 38 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L38:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 38 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L39:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 39 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2015
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L39:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 39 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L40:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 40 80 `=_rc' // WFLOG-INJECTED
assert source_year==2015
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L40:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 40 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L41:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 41 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L41:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 41 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L42:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 42 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2015.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L42:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 42 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L43:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 43 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L43:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 43 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L44:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 44 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L44:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 44 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L45:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 45 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2017
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L45:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 45 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L46:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 46 80 `=_rc' // WFLOG-INJECTED
assert source_year==2017
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L46:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 46 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L47:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 47 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L47:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 47 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L48:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 48 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2017.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L48:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 48 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L49:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 49 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L49:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 49 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L50:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 50 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L50:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 50 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L51:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 51 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2018
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L51:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 51 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L52:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 52 80 `=_rc' // WFLOG-INJECTED
assert source_year==2018
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L52:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 52 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L53:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 53 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L53:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 53 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L54:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 54 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2018.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L54:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 54 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L55:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 55 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L55:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 55 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L56:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 56 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L56:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 56 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L57:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 57 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2019
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L57:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 57 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L58:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 58 80 `=_rc' // WFLOG-INJECTED
assert source_year==2019
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L58:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 58 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L59:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 59 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L59:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 59 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L60:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 60 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2019.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L60:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 60 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L61:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 61 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L61:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 61 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L62:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 62 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L62:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 62 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L63:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 63 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2020
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L63:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 63 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L64:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 64 80 `=_rc' // WFLOG-INJECTED
assert source_year==2020
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L64:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 64 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L65:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 65 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L65:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 65 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L66:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 66 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2020.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L66:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 66 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L67:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 67 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L67:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 67 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L68:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 68 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L68:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 68 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L69:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 69 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2021
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L69:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 69 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L70:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 70 80 `=_rc' // WFLOG-INJECTED
assert source_year==2021
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L70:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 70 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L71:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 71 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L71:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 71 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L72:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 72 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2021.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L72:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 72 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L73:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 73 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L73:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 73 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L74:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 74 80 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L74:step-preserve" "code/stages/F085_publish_waves.do:L1:file" "statement" 74 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L75:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 75 80 `=_rc' // WFLOG-INJECTED
keep if source_year==2022
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L75:step-keep" "code/stages/F085_publish_waves.do:L1:file" "statement" 75 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L76:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 76 80 `=_rc' // WFLOG-INJECTED
assert source_year==2022
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L76:step-assert" "code/stages/F085_publish_waves.do:L1:file" "statement" 76 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L77:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 77 80 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L77:step-isid" "code/stages/F085_publish_waves.do:L1:file" "statement" 77 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L78:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 78 80 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/waves/wave_2022.dta", replace
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L78:step-save" "code/stages/F085_publish_waves.do:L1:file" "statement" 78 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L79:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 79 80 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L79:step-restore" "code/stages/F085_publish_waves.do:L1:file" "statement" 79 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F085_publish_waves.do:L80:step-display" "code/stages/F085_publish_waves.do:L1:file" "statement" 80 80 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F085_PASS"
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L80:step-display" "code/stages/F085_publish_waves.do:L1:file" "statement" 80 80 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F085_publish_waves.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
