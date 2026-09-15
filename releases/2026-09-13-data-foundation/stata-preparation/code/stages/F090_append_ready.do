* Tujuan: Satukan 12 file tahunan menjadi data utama G0_analysis_ready; kode memeriksa kunci unik, 33.049 baris, dan 4.593 kolom sebelum menyimpan. // WFDOC-INJECTED
* Input: data/waves/wave_2010.dta; data/waves/wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Output: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L1:step-do" "code/stages/F090_append_ready.do:L1:file" "statement" 1 18 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L1:step-do" "code/stages/F090_append_ready.do:L1:file" "statement" 1 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L2:step-use" "code/stages/F090_append_ready.do:L1:file" "statement" 2 18 `=_rc' // WFLOG-INJECTED
* Mulai dari wave 2010 lalu append 11 wave lainnya; di akhir, cek kunci unik, jumlah baris/kolom, dan simpan data utama. // WFDOC-INJECTED
use "data/waves/wave_2010.dta", clear
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L2:step-use" "code/stages/F090_append_ready.do:L1:file" "statement" 2 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L3:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 3 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2011.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L3:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 3 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L4:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 4 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2012.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L4:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 4 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L5:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 5 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2013.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L5:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 5 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L6:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 6 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2014.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L6:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 6 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L7:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 7 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2015.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L7:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 7 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L8:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 8 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2017.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L8:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 8 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L9:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 9 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2018.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L9:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 9 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L10:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 10 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2019.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L10:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 10 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L11:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 11 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2020.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L11:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 11 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L12:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 12 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2021.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L12:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 12 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L13:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 13 18 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "data/waves/wave_2022.dta"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L13:step-append" "code/stages/F090_append_ready.do:L1:file" "statement" 13 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L14:step-isid" "code/stages/F090_append_ready.do:L1:file" "statement" 14 18 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L14:step-isid" "code/stages/F090_append_ready.do:L1:file" "statement" 14 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L15:step-assert" "code/stages/F090_append_ready.do:L1:file" "statement" 15 18 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L15:step-assert" "code/stages/F090_append_ready.do:L1:file" "statement" 15 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L16:step-assert" "code/stages/F090_append_ready.do:L1:file" "statement" 16 18 `=_rc' // WFLOG-INJECTED
assert c(k)==4593
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L16:step-assert" "code/stages/F090_append_ready.do:L1:file" "statement" 16 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L17:step-save" "code/stages/F090_append_ready.do:L1:file" "statement" 17 18 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/analysis/G0_analysis_ready.dta", replace
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L17:step-save" "code/stages/F090_append_ready.do:L1:file" "statement" 17 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_append_ready.do:L18:step-display" "code/stages/F090_append_ready.do:L1:file" "statement" 18 18 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F090_APPEND_PASS"
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L18:step-display" "code/stages/F090_append_ready.do:L1:file" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F090_append_ready.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
