* Tujuan: Bentuk kolom kerja tahunan dari sumber yang terverifikasi, sambil mempertahankan nilai awal dan status pengisian. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_verified_20260910.dta // WFDOC-INJECTED
* Output: data/intermediate/verified_wave_2010.dta; data/intermediate/verified_wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L1:step-do" "code/stages/F060_working.do:L1:file" "statement" 1 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L1:step-do" "code/stages/F060_working.do:L1:file" "statement" 1 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L2:step-use" "code/stages/F060_working.do:L1:file" "statement" 2 172 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_main_verified_20260910.dta", clear
capture noisily __wf_progress end "code/stages/F060_working.do:L2:step-use" "code/stages/F060_working.do:L1:file" "statement" 2 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L3:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 3 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L3:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 3 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L4:step-keep" "code/stages/F060_working.do:L1:file" "statement" 4 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2010
capture noisily __wf_progress end "code/stages/F060_working.do:L4:step-keep" "code/stages/F060_working.do:L1:file" "statement" 4 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L5:step-save" "code/stages/F060_working.do:L1:file" "statement" 5 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2010.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L5:step-save" "code/stages/F060_working.do:L1:file" "statement" 5 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L6:step-restore" "code/stages/F060_working.do:L1:file" "statement" 6 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L6:step-restore" "code/stages/F060_working.do:L1:file" "statement" 6 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L7:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 7 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L7:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 7 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L8:step-keep" "code/stages/F060_working.do:L1:file" "statement" 8 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2011
capture noisily __wf_progress end "code/stages/F060_working.do:L8:step-keep" "code/stages/F060_working.do:L1:file" "statement" 8 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L9:step-save" "code/stages/F060_working.do:L1:file" "statement" 9 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2011.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L9:step-save" "code/stages/F060_working.do:L1:file" "statement" 9 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L10:step-restore" "code/stages/F060_working.do:L1:file" "statement" 10 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L10:step-restore" "code/stages/F060_working.do:L1:file" "statement" 10 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L11:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 11 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L11:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 11 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L12:step-keep" "code/stages/F060_working.do:L1:file" "statement" 12 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2012
capture noisily __wf_progress end "code/stages/F060_working.do:L12:step-keep" "code/stages/F060_working.do:L1:file" "statement" 12 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L13:step-save" "code/stages/F060_working.do:L1:file" "statement" 13 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2012.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L13:step-save" "code/stages/F060_working.do:L1:file" "statement" 13 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L14:step-restore" "code/stages/F060_working.do:L1:file" "statement" 14 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L14:step-restore" "code/stages/F060_working.do:L1:file" "statement" 14 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L15:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 15 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L15:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 15 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L16:step-keep" "code/stages/F060_working.do:L1:file" "statement" 16 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2013
capture noisily __wf_progress end "code/stages/F060_working.do:L16:step-keep" "code/stages/F060_working.do:L1:file" "statement" 16 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L17:step-save" "code/stages/F060_working.do:L1:file" "statement" 17 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2013.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L17:step-save" "code/stages/F060_working.do:L1:file" "statement" 17 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L18:step-restore" "code/stages/F060_working.do:L1:file" "statement" 18 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L18:step-restore" "code/stages/F060_working.do:L1:file" "statement" 18 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L19:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 19 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L19:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 19 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L20:step-keep" "code/stages/F060_working.do:L1:file" "statement" 20 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2014
capture noisily __wf_progress end "code/stages/F060_working.do:L20:step-keep" "code/stages/F060_working.do:L1:file" "statement" 20 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L21:step-save" "code/stages/F060_working.do:L1:file" "statement" 21 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2014.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L21:step-save" "code/stages/F060_working.do:L1:file" "statement" 21 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L22:step-restore" "code/stages/F060_working.do:L1:file" "statement" 22 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L22:step-restore" "code/stages/F060_working.do:L1:file" "statement" 22 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L23:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 23 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L23:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 23 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L24:step-keep" "code/stages/F060_working.do:L1:file" "statement" 24 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2015
capture noisily __wf_progress end "code/stages/F060_working.do:L24:step-keep" "code/stages/F060_working.do:L1:file" "statement" 24 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L25:step-save" "code/stages/F060_working.do:L1:file" "statement" 25 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2015.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L25:step-save" "code/stages/F060_working.do:L1:file" "statement" 25 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L26:step-restore" "code/stages/F060_working.do:L1:file" "statement" 26 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L26:step-restore" "code/stages/F060_working.do:L1:file" "statement" 26 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L27:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 27 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L27:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 27 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L28:step-keep" "code/stages/F060_working.do:L1:file" "statement" 28 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2017
capture noisily __wf_progress end "code/stages/F060_working.do:L28:step-keep" "code/stages/F060_working.do:L1:file" "statement" 28 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L29:step-save" "code/stages/F060_working.do:L1:file" "statement" 29 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2017.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L29:step-save" "code/stages/F060_working.do:L1:file" "statement" 29 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L30:step-restore" "code/stages/F060_working.do:L1:file" "statement" 30 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L30:step-restore" "code/stages/F060_working.do:L1:file" "statement" 30 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L31:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 31 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L31:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 31 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L32:step-keep" "code/stages/F060_working.do:L1:file" "statement" 32 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2018
capture noisily __wf_progress end "code/stages/F060_working.do:L32:step-keep" "code/stages/F060_working.do:L1:file" "statement" 32 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L33:step-save" "code/stages/F060_working.do:L1:file" "statement" 33 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2018.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L33:step-save" "code/stages/F060_working.do:L1:file" "statement" 33 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L34:step-restore" "code/stages/F060_working.do:L1:file" "statement" 34 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L34:step-restore" "code/stages/F060_working.do:L1:file" "statement" 34 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L35:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 35 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L35:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 35 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L36:step-keep" "code/stages/F060_working.do:L1:file" "statement" 36 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2019
capture noisily __wf_progress end "code/stages/F060_working.do:L36:step-keep" "code/stages/F060_working.do:L1:file" "statement" 36 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L37:step-save" "code/stages/F060_working.do:L1:file" "statement" 37 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2019.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L37:step-save" "code/stages/F060_working.do:L1:file" "statement" 37 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L38:step-restore" "code/stages/F060_working.do:L1:file" "statement" 38 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L38:step-restore" "code/stages/F060_working.do:L1:file" "statement" 38 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L39:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 39 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L39:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 39 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L40:step-keep" "code/stages/F060_working.do:L1:file" "statement" 40 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2020
capture noisily __wf_progress end "code/stages/F060_working.do:L40:step-keep" "code/stages/F060_working.do:L1:file" "statement" 40 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L41:step-save" "code/stages/F060_working.do:L1:file" "statement" 41 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2020.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L41:step-save" "code/stages/F060_working.do:L1:file" "statement" 41 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L42:step-restore" "code/stages/F060_working.do:L1:file" "statement" 42 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L42:step-restore" "code/stages/F060_working.do:L1:file" "statement" 42 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L43:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 43 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L43:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 43 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L44:step-keep" "code/stages/F060_working.do:L1:file" "statement" 44 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2021
capture noisily __wf_progress end "code/stages/F060_working.do:L44:step-keep" "code/stages/F060_working.do:L1:file" "statement" 44 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L45:step-save" "code/stages/F060_working.do:L1:file" "statement" 45 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2021.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L45:step-save" "code/stages/F060_working.do:L1:file" "statement" 45 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L46:step-restore" "code/stages/F060_working.do:L1:file" "statement" 46 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L46:step-restore" "code/stages/F060_working.do:L1:file" "statement" 46 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L47:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 47 172 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/stages/F060_working.do:L47:step-preserve" "code/stages/F060_working.do:L1:file" "statement" 47 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L48:step-keep" "code/stages/F060_working.do:L1:file" "statement" 48 172 `=_rc' // WFLOG-INJECTED
keep if source_year==2022
capture noisily __wf_progress end "code/stages/F060_working.do:L48:step-keep" "code/stages/F060_working.do:L1:file" "statement" 48 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L49:step-save" "code/stages/F060_working.do:L1:file" "statement" 49 172 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2022.dta", replace
capture noisily __wf_progress end "code/stages/F060_working.do:L49:step-save" "code/stages/F060_working.do:L1:file" "statement" 49 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L50:step-restore" "code/stages/F060_working.do:L1:file" "statement" 50 172 `=_rc' // WFLOG-INJECTED
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/stages/F060_working.do:L50:step-restore" "code/stages/F060_working.do:L1:file" "statement" 50 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L51:step-do" "code/stages/F060_working.do:L1:file" "statement" 51 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L51:step-do" "code/stages/F060_working.do:L1:file" "statement" 51 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L52:step-do" "code/stages/F060_working.do:L1:file" "statement" 52 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L52:step-do" "code/stages/F060_working.do:L1:file" "statement" 52 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L53:step-do" "code/stages/F060_working.do:L1:file" "statement" 53 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L53:step-do" "code/stages/F060_working.do:L1:file" "statement" 53 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L54:step-do" "code/stages/F060_working.do:L1:file" "statement" 54 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L54:step-do" "code/stages/F060_working.do:L1:file" "statement" 54 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L55:step-do" "code/stages/F060_working.do:L1:file" "statement" 55 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L55:step-do" "code/stages/F060_working.do:L1:file" "statement" 55 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L56:step-do" "code/stages/F060_working.do:L1:file" "statement" 56 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L56:step-do" "code/stages/F060_working.do:L1:file" "statement" 56 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L57:step-do" "code/stages/F060_working.do:L1:file" "statement" 57 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L57:step-do" "code/stages/F060_working.do:L1:file" "statement" 57 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L58:step-do" "code/stages/F060_working.do:L1:file" "statement" 58 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L58:step-do" "code/stages/F060_working.do:L1:file" "statement" 58 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L59:step-do" "code/stages/F060_working.do:L1:file" "statement" 59 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L59:step-do" "code/stages/F060_working.do:L1:file" "statement" 59 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L60:step-do" "code/stages/F060_working.do:L1:file" "statement" 60 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L60:step-do" "code/stages/F060_working.do:L1:file" "statement" 60 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L61:step-do" "code/stages/F060_working.do:L1:file" "statement" 61 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L61:step-do" "code/stages/F060_working.do:L1:file" "statement" 61 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L62:step-do" "code/stages/F060_working.do:L1:file" "statement" 62 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L62:step-do" "code/stages/F060_working.do:L1:file" "statement" 62 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L63:step-do" "code/stages/F060_working.do:L1:file" "statement" 63 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L63:step-do" "code/stages/F060_working.do:L1:file" "statement" 63 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L64:step-do" "code/stages/F060_working.do:L1:file" "statement" 64 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L64:step-do" "code/stages/F060_working.do:L1:file" "statement" 64 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L65:step-do" "code/stages/F060_working.do:L1:file" "statement" 65 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L65:step-do" "code/stages/F060_working.do:L1:file" "statement" 65 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L66:step-do" "code/stages/F060_working.do:L1:file" "statement" 66 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L66:step-do" "code/stages/F060_working.do:L1:file" "statement" 66 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L67:step-do" "code/stages/F060_working.do:L1:file" "statement" 67 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L67:step-do" "code/stages/F060_working.do:L1:file" "statement" 67 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L68:step-do" "code/stages/F060_working.do:L1:file" "statement" 68 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L68:step-do" "code/stages/F060_working.do:L1:file" "statement" 68 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L69:step-do" "code/stages/F060_working.do:L1:file" "statement" 69 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L69:step-do" "code/stages/F060_working.do:L1:file" "statement" 69 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L70:step-do" "code/stages/F060_working.do:L1:file" "statement" 70 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L70:step-do" "code/stages/F060_working.do:L1:file" "statement" 70 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L71:step-do" "code/stages/F060_working.do:L1:file" "statement" 71 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L71:step-do" "code/stages/F060_working.do:L1:file" "statement" 71 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L72:step-do" "code/stages/F060_working.do:L1:file" "statement" 72 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L72:step-do" "code/stages/F060_working.do:L1:file" "statement" 72 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L73:step-do" "code/stages/F060_working.do:L1:file" "statement" 73 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L73:step-do" "code/stages/F060_working.do:L1:file" "statement" 73 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L74:step-do" "code/stages/F060_working.do:L1:file" "statement" 74 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L74:step-do" "code/stages/F060_working.do:L1:file" "statement" 74 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L75:step-do" "code/stages/F060_working.do:L1:file" "statement" 75 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L75:step-do" "code/stages/F060_working.do:L1:file" "statement" 75 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L76:step-do" "code/stages/F060_working.do:L1:file" "statement" 76 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L76:step-do" "code/stages/F060_working.do:L1:file" "statement" 76 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L77:step-do" "code/stages/F060_working.do:L1:file" "statement" 77 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L77:step-do" "code/stages/F060_working.do:L1:file" "statement" 77 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L78:step-do" "code/stages/F060_working.do:L1:file" "statement" 78 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L78:step-do" "code/stages/F060_working.do:L1:file" "statement" 78 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L79:step-do" "code/stages/F060_working.do:L1:file" "statement" 79 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L79:step-do" "code/stages/F060_working.do:L1:file" "statement" 79 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L80:step-do" "code/stages/F060_working.do:L1:file" "statement" 80 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L80:step-do" "code/stages/F060_working.do:L1:file" "statement" 80 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L81:step-do" "code/stages/F060_working.do:L1:file" "statement" 81 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L81:step-do" "code/stages/F060_working.do:L1:file" "statement" 81 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L82:step-do" "code/stages/F060_working.do:L1:file" "statement" 82 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L82:step-do" "code/stages/F060_working.do:L1:file" "statement" 82 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L83:step-do" "code/stages/F060_working.do:L1:file" "statement" 83 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L83:step-do" "code/stages/F060_working.do:L1:file" "statement" 83 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L84:step-do" "code/stages/F060_working.do:L1:file" "statement" 84 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L84:step-do" "code/stages/F060_working.do:L1:file" "statement" 84 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L85:step-do" "code/stages/F060_working.do:L1:file" "statement" 85 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L85:step-do" "code/stages/F060_working.do:L1:file" "statement" 85 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L86:step-do" "code/stages/F060_working.do:L1:file" "statement" 86 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L86:step-do" "code/stages/F060_working.do:L1:file" "statement" 86 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L87:step-do" "code/stages/F060_working.do:L1:file" "statement" 87 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L87:step-do" "code/stages/F060_working.do:L1:file" "statement" 87 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L88:step-do" "code/stages/F060_working.do:L1:file" "statement" 88 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L88:step-do" "code/stages/F060_working.do:L1:file" "statement" 88 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L89:step-do" "code/stages/F060_working.do:L1:file" "statement" 89 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L89:step-do" "code/stages/F060_working.do:L1:file" "statement" 89 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L90:step-do" "code/stages/F060_working.do:L1:file" "statement" 90 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L90:step-do" "code/stages/F060_working.do:L1:file" "statement" 90 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L91:step-do" "code/stages/F060_working.do:L1:file" "statement" 91 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L91:step-do" "code/stages/F060_working.do:L1:file" "statement" 91 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L92:step-do" "code/stages/F060_working.do:L1:file" "statement" 92 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L92:step-do" "code/stages/F060_working.do:L1:file" "statement" 92 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L93:step-do" "code/stages/F060_working.do:L1:file" "statement" 93 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L93:step-do" "code/stages/F060_working.do:L1:file" "statement" 93 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L94:step-do" "code/stages/F060_working.do:L1:file" "statement" 94 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L94:step-do" "code/stages/F060_working.do:L1:file" "statement" 94 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L95:step-do" "code/stages/F060_working.do:L1:file" "statement" 95 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L95:step-do" "code/stages/F060_working.do:L1:file" "statement" 95 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L96:step-do" "code/stages/F060_working.do:L1:file" "statement" 96 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L96:step-do" "code/stages/F060_working.do:L1:file" "statement" 96 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L97:step-do" "code/stages/F060_working.do:L1:file" "statement" 97 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L97:step-do" "code/stages/F060_working.do:L1:file" "statement" 97 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L98:step-do" "code/stages/F060_working.do:L1:file" "statement" 98 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L98:step-do" "code/stages/F060_working.do:L1:file" "statement" 98 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L99:step-do" "code/stages/F060_working.do:L1:file" "statement" 99 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L99:step-do" "code/stages/F060_working.do:L1:file" "statement" 99 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L100:step-do" "code/stages/F060_working.do:L1:file" "statement" 100 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L100:step-do" "code/stages/F060_working.do:L1:file" "statement" 100 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L101:step-do" "code/stages/F060_working.do:L1:file" "statement" 101 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L101:step-do" "code/stages/F060_working.do:L1:file" "statement" 101 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L102:step-do" "code/stages/F060_working.do:L1:file" "statement" 102 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L102:step-do" "code/stages/F060_working.do:L1:file" "statement" 102 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L103:step-do" "code/stages/F060_working.do:L1:file" "statement" 103 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L103:step-do" "code/stages/F060_working.do:L1:file" "statement" 103 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L104:step-do" "code/stages/F060_working.do:L1:file" "statement" 104 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L104:step-do" "code/stages/F060_working.do:L1:file" "statement" 104 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L105:step-do" "code/stages/F060_working.do:L1:file" "statement" 105 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L105:step-do" "code/stages/F060_working.do:L1:file" "statement" 105 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L106:step-do" "code/stages/F060_working.do:L1:file" "statement" 106 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L106:step-do" "code/stages/F060_working.do:L1:file" "statement" 106 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L107:step-do" "code/stages/F060_working.do:L1:file" "statement" 107 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L107:step-do" "code/stages/F060_working.do:L1:file" "statement" 107 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L108:step-do" "code/stages/F060_working.do:L1:file" "statement" 108 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L108:step-do" "code/stages/F060_working.do:L1:file" "statement" 108 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L109:step-do" "code/stages/F060_working.do:L1:file" "statement" 109 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L109:step-do" "code/stages/F060_working.do:L1:file" "statement" 109 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L110:step-do" "code/stages/F060_working.do:L1:file" "statement" 110 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L110:step-do" "code/stages/F060_working.do:L1:file" "statement" 110 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L111:step-do" "code/stages/F060_working.do:L1:file" "statement" 111 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L111:step-do" "code/stages/F060_working.do:L1:file" "statement" 111 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L112:step-do" "code/stages/F060_working.do:L1:file" "statement" 112 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L112:step-do" "code/stages/F060_working.do:L1:file" "statement" 112 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L113:step-do" "code/stages/F060_working.do:L1:file" "statement" 113 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L113:step-do" "code/stages/F060_working.do:L1:file" "statement" 113 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L114:step-do" "code/stages/F060_working.do:L1:file" "statement" 114 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L114:step-do" "code/stages/F060_working.do:L1:file" "statement" 114 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L115:step-do" "code/stages/F060_working.do:L1:file" "statement" 115 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L115:step-do" "code/stages/F060_working.do:L1:file" "statement" 115 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L116:step-do" "code/stages/F060_working.do:L1:file" "statement" 116 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L116:step-do" "code/stages/F060_working.do:L1:file" "statement" 116 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L117:step-do" "code/stages/F060_working.do:L1:file" "statement" 117 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L117:step-do" "code/stages/F060_working.do:L1:file" "statement" 117 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L118:step-do" "code/stages/F060_working.do:L1:file" "statement" 118 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L118:step-do" "code/stages/F060_working.do:L1:file" "statement" 118 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L119:step-do" "code/stages/F060_working.do:L1:file" "statement" 119 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L119:step-do" "code/stages/F060_working.do:L1:file" "statement" 119 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L120:step-do" "code/stages/F060_working.do:L1:file" "statement" 120 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L120:step-do" "code/stages/F060_working.do:L1:file" "statement" 120 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L121:step-do" "code/stages/F060_working.do:L1:file" "statement" 121 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L121:step-do" "code/stages/F060_working.do:L1:file" "statement" 121 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L122:step-do" "code/stages/F060_working.do:L1:file" "statement" 122 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L122:step-do" "code/stages/F060_working.do:L1:file" "statement" 122 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L123:step-do" "code/stages/F060_working.do:L1:file" "statement" 123 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L123:step-do" "code/stages/F060_working.do:L1:file" "statement" 123 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L124:step-do" "code/stages/F060_working.do:L1:file" "statement" 124 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L124:step-do" "code/stages/F060_working.do:L1:file" "statement" 124 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L125:step-do" "code/stages/F060_working.do:L1:file" "statement" 125 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L125:step-do" "code/stages/F060_working.do:L1:file" "statement" 125 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L126:step-do" "code/stages/F060_working.do:L1:file" "statement" 126 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L126:step-do" "code/stages/F060_working.do:L1:file" "statement" 126 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L127:step-do" "code/stages/F060_working.do:L1:file" "statement" 127 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L127:step-do" "code/stages/F060_working.do:L1:file" "statement" 127 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L128:step-do" "code/stages/F060_working.do:L1:file" "statement" 128 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L128:step-do" "code/stages/F060_working.do:L1:file" "statement" 128 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L129:step-do" "code/stages/F060_working.do:L1:file" "statement" 129 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L129:step-do" "code/stages/F060_working.do:L1:file" "statement" 129 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L130:step-do" "code/stages/F060_working.do:L1:file" "statement" 130 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L130:step-do" "code/stages/F060_working.do:L1:file" "statement" 130 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L131:step-do" "code/stages/F060_working.do:L1:file" "statement" 131 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L131:step-do" "code/stages/F060_working.do:L1:file" "statement" 131 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L132:step-do" "code/stages/F060_working.do:L1:file" "statement" 132 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L132:step-do" "code/stages/F060_working.do:L1:file" "statement" 132 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L133:step-do" "code/stages/F060_working.do:L1:file" "statement" 133 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L133:step-do" "code/stages/F060_working.do:L1:file" "statement" 133 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L134:step-do" "code/stages/F060_working.do:L1:file" "statement" 134 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L134:step-do" "code/stages/F060_working.do:L1:file" "statement" 134 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L135:step-do" "code/stages/F060_working.do:L1:file" "statement" 135 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L135:step-do" "code/stages/F060_working.do:L1:file" "statement" 135 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L136:step-do" "code/stages/F060_working.do:L1:file" "statement" 136 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L136:step-do" "code/stages/F060_working.do:L1:file" "statement" 136 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L137:step-do" "code/stages/F060_working.do:L1:file" "statement" 137 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L137:step-do" "code/stages/F060_working.do:L1:file" "statement" 137 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L138:step-do" "code/stages/F060_working.do:L1:file" "statement" 138 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L138:step-do" "code/stages/F060_working.do:L1:file" "statement" 138 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L139:step-do" "code/stages/F060_working.do:L1:file" "statement" 139 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L139:step-do" "code/stages/F060_working.do:L1:file" "statement" 139 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L140:step-do" "code/stages/F060_working.do:L1:file" "statement" 140 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L140:step-do" "code/stages/F060_working.do:L1:file" "statement" 140 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L141:step-do" "code/stages/F060_working.do:L1:file" "statement" 141 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L141:step-do" "code/stages/F060_working.do:L1:file" "statement" 141 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L142:step-do" "code/stages/F060_working.do:L1:file" "statement" 142 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L142:step-do" "code/stages/F060_working.do:L1:file" "statement" 142 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L143:step-do" "code/stages/F060_working.do:L1:file" "statement" 143 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L143:step-do" "code/stages/F060_working.do:L1:file" "statement" 143 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L144:step-do" "code/stages/F060_working.do:L1:file" "statement" 144 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L144:step-do" "code/stages/F060_working.do:L1:file" "statement" 144 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L145:step-do" "code/stages/F060_working.do:L1:file" "statement" 145 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L145:step-do" "code/stages/F060_working.do:L1:file" "statement" 145 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L146:step-do" "code/stages/F060_working.do:L1:file" "statement" 146 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L146:step-do" "code/stages/F060_working.do:L1:file" "statement" 146 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L147:step-do" "code/stages/F060_working.do:L1:file" "statement" 147 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L147:step-do" "code/stages/F060_working.do:L1:file" "statement" 147 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L148:step-do" "code/stages/F060_working.do:L1:file" "statement" 148 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L148:step-do" "code/stages/F060_working.do:L1:file" "statement" 148 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L149:step-do" "code/stages/F060_working.do:L1:file" "statement" 149 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L149:step-do" "code/stages/F060_working.do:L1:file" "statement" 149 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L150:step-do" "code/stages/F060_working.do:L1:file" "statement" 150 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L150:step-do" "code/stages/F060_working.do:L1:file" "statement" 150 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L151:step-do" "code/stages/F060_working.do:L1:file" "statement" 151 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L151:step-do" "code/stages/F060_working.do:L1:file" "statement" 151 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L152:step-do" "code/stages/F060_working.do:L1:file" "statement" 152 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L152:step-do" "code/stages/F060_working.do:L1:file" "statement" 152 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L153:step-do" "code/stages/F060_working.do:L1:file" "statement" 153 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L153:step-do" "code/stages/F060_working.do:L1:file" "statement" 153 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L154:step-do" "code/stages/F060_working.do:L1:file" "statement" 154 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L154:step-do" "code/stages/F060_working.do:L1:file" "statement" 154 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L155:step-do" "code/stages/F060_working.do:L1:file" "statement" 155 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L155:step-do" "code/stages/F060_working.do:L1:file" "statement" 155 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L156:step-do" "code/stages/F060_working.do:L1:file" "statement" 156 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L156:step-do" "code/stages/F060_working.do:L1:file" "statement" 156 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L157:step-do" "code/stages/F060_working.do:L1:file" "statement" 157 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L157:step-do" "code/stages/F060_working.do:L1:file" "statement" 157 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L158:step-do" "code/stages/F060_working.do:L1:file" "statement" 158 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L158:step-do" "code/stages/F060_working.do:L1:file" "statement" 158 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L159:step-do" "code/stages/F060_working.do:L1:file" "statement" 159 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2010.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L159:step-do" "code/stages/F060_working.do:L1:file" "statement" 159 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L160:step-do" "code/stages/F060_working.do:L1:file" "statement" 160 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2011.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L160:step-do" "code/stages/F060_working.do:L1:file" "statement" 160 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L161:step-do" "code/stages/F060_working.do:L1:file" "statement" 161 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2012.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L161:step-do" "code/stages/F060_working.do:L1:file" "statement" 161 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L162:step-do" "code/stages/F060_working.do:L1:file" "statement" 162 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2013.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L162:step-do" "code/stages/F060_working.do:L1:file" "statement" 162 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L163:step-do" "code/stages/F060_working.do:L1:file" "statement" 163 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2014.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L163:step-do" "code/stages/F060_working.do:L1:file" "statement" 163 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L164:step-do" "code/stages/F060_working.do:L1:file" "statement" 164 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2015.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L164:step-do" "code/stages/F060_working.do:L1:file" "statement" 164 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L165:step-do" "code/stages/F060_working.do:L1:file" "statement" 165 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2017.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L165:step-do" "code/stages/F060_working.do:L1:file" "statement" 165 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L166:step-do" "code/stages/F060_working.do:L1:file" "statement" 166 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2018.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L166:step-do" "code/stages/F060_working.do:L1:file" "statement" 166 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L167:step-do" "code/stages/F060_working.do:L1:file" "statement" 167 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2019.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L167:step-do" "code/stages/F060_working.do:L1:file" "statement" 167 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L168:step-do" "code/stages/F060_working.do:L1:file" "statement" 168 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2020.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L168:step-do" "code/stages/F060_working.do:L1:file" "statement" 168 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L169:step-do" "code/stages/F060_working.do:L1:file" "statement" 169 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2021.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L169:step-do" "code/stages/F060_working.do:L1:file" "statement" 169 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L170:step-do" "code/stages/F060_working.do:L1:file" "statement" 170 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/merge_working_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2022.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L170:step-do" "code/stages/F060_working.do:L1:file" "statement" 170 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L171:step-do" "code/stages/F060_working.do:L1:file" "statement" 171 172 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/stages/F060_finish_working.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/stages/F060_finish_working.do"
capture noisily __wf_progress end "code/stages/F060_working.do:L171:step-do" "code/stages/F060_working.do:L1:file" "statement" 171 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_working.do:L172:step-display" "code/stages/F060_working.do:L1:file" "statement" 172 172 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F060_PASS"
capture noisily __wf_progress end "code/stages/F060_working.do:L172:step-display" "code/stages/F060_working.do:L1:file" "statement" 172 172 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F060_working.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
