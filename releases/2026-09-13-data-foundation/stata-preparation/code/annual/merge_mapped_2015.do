* Tujuan: Gabungkan hasil pemetaan kolom tahun 2015 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2015.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2015.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L1:step-do" "code/annual/merge_mapped_2015.do:L1:file" "statement" 1 668 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L1:step-do" "code/annual/merge_mapped_2015.do:L1:file" "statement" 1 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L2:step-do" "code/annual/merge_mapped_2015.do:L1:file" "statement" 2 668 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L2:step-do" "code/annual/merge_mapped_2015.do:L1:file" "statement" 2 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L3:step-use" "code/annual/merge_mapped_2015.do:L1:file" "statement" 3 668 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2015.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L3:step-use" "code/annual/merge_mapped_2015.do:L1:file" "statement" 3 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L4:step-assert" "code/annual/merge_mapped_2015.do:L1:file" "statement" 4 668 `=_rc' // WFLOG-INJECTED
assert source_year==2015
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L4:step-assert" "code/annual/merge_mapped_2015.do:L1:file" "statement" 4 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L5:step-isid" "code/annual/merge_mapped_2015.do:L1:file" "statement" 5 668 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L5:step-isid" "code/annual/merge_mapped_2015.do:L1:file" "statement" 5 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 6 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2015.dta") fields("amdal_raw vs_amdal_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 6 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 7 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2015.dta") fields("b3wste_raw vs_b3wste_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 7 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L8:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 8 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2015.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L8:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 8 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L9:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 9 668 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L9:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 9 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L10:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 10 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L10:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 10 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L11:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 11 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L11:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 11 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L12:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 12 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L12:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 12 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L13:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 13 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2015.dta") fields("capital_nominal vs_capital_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L13:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 13 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L14:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 14 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L14:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 14 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L15:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 15 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L15:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 15 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L16:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 16 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L16:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 16 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L17:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 17 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L17:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 17 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L18:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 18 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2015.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L18:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 18 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L19:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 19 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L19:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 19 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L20:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 20 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L20:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 20 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L21:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 21 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L21:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 21 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L22:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 22 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L22:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 22 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L23:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 23 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2015.dta") fields("export_binary_raw vs_export_binary_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L23:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 23 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L24:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 24 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2015.dta") fields("export_share_pct vs_export_share_pct") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L24:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 24 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L25:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 25 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L25:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 25 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L26:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 26 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L26:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 26 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L27:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 27 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L27:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 27 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L28:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 28 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L28:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 28 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L29:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 29 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2015.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L29:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 29 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L30:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 30 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L30:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 30 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L31:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 31 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output15
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L31:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 31 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L32:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 32 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L32:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 32 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L33:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 33 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L33:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 33 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L34:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 34 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2015.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L34:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 34 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L35:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 35 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L35:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 35 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L36:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 36 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L36:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 36 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L37:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 37 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L37:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 37 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L38:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 38 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L38:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 38 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L39:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 39 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2015.dta") fields("import_value_nominal vs_import_value_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L39:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 39 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L40:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 40 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2015.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L40:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 40 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 41 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2015.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 41 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 42 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2015.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 42 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L43:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 43 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2015.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L43:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 43 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L44:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 44 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2015.dta") fields("innovation_raw vs_innovation_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L44:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 44 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L45:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 45 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2015.dta") fields("inspli_raw vs_inspli_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L45:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 45 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L46:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 46 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L46:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 46 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L47:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 47 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput15
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L47:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 47 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L48:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 48 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L48:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 48 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L49:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 49 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L49:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 49 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 50 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2015.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 50 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 51 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2015.dta") fields("liwste_raw vs_liwste_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 51 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 52 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2015.dta") fields("pplihi_raw vs_pplihi_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 52 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L53:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 53 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L53:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 53 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L54:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 54 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L54:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 54 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L55:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 55 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L55:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 55 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L56:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 56 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L56:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 56 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L57:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 57 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2015.dta") fields("production_workers vs_production_workers") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L57:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 57 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 58 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2015.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 58 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 59 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2015.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 59 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 60 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2015.dta") fields("rd_workers vs_rd_workers") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 60 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L61:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 61 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2015.dta") fields("sowste_raw vs_sowste_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L61:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 61 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L62:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 62 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2015.dta") fields("spplhi_raw vs_spplhi_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L62:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 62 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L63:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 63 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2015.dta") fields("val_cbdacu vs_val_cbdacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L63:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 63 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L64:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 64 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2015.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L64:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 64 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L65:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 65 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L65:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 65 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L66:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 66 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L66:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 66 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L67:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 67 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L67:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 67 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L68:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 68 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L68:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 68 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 69 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2015.dta") fields("val_cbsacu vs_val_cbsacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 69 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L70:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 70 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L70:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 70 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L71:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 71 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L71:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 71 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L72:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 72 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L72:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 72 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L73:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 73 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L73:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 73 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L74:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 74 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2015.dta") fields("val_cbttcu vs_val_cbttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L74:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 74 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 75 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2015.dta") fields("val_cldacu vs_val_cldacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 75 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 76 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2015.dta") fields("val_clfpcu vs_val_clfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 76 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L77:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 77 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L77:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 77 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L78:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 78 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L78:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 78 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L79:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 79 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L79:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 79 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L80:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 80 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L80:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 80 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 81 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2015.dta") fields("val_clsacu vs_val_clsacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 81 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L82:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 82 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L82:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 82 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L83:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 83 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L83:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 83 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L84:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 84 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L84:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 84 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L85:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 85 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L85:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 85 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 86 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2015.dta") fields("val_clttcu vs_val_clttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 86 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 87 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2015.dta") fields("val_cmdacu vs_val_cmdacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 87 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L88:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 88 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2015.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L88:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 88 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L89:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 89 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L89:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 89 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L90:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 90 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L90:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 90 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L91:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 91 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L91:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 91 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L92:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 92 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L92:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 92 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 93 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2015.dta") fields("val_cmsacu vs_val_cmsacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 93 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L94:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 94 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L94:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 94 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L95:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 95 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L95:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 95 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L96:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 96 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L96:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 96 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L97:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 97 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L97:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 97 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 98 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2015.dta") fields("val_cmttcu vs_val_cmttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 98 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 99 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2015.dta") fields("val_codacu vs_val_codacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 99 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 100 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2015.dta") fields("val_cofpcu vs_val_cofpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 100 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L101:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 101 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L101:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 101 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L102:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 102 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L102:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 102 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L103:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 103 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L103:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 103 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L104:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 104 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L104:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 104 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 105 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2015.dta") fields("val_cosacu vs_val_cosacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 105 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L106:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 106 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2015.dta") fields("val_costrd vs_val_costrd") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L106:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 106 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L107:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 107 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L107:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 107 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L108:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 108 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L108:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 108 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L109:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 109 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L109:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 109 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L110:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 110 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L110:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 110 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L111:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 111 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2015.dta") fields("val_cottcu vs_val_cottcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L111:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 111 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L112:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 112 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2015.dta") fields("val_csdacu vs_val_csdacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L112:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 112 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 113 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2015.dta") fields("val_csfpcu vs_val_csfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 113 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L114:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 114 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2015.dta") fields("val_cssacu vs_val_cssacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L114:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 114 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 115 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2015.dta") fields("val_csttcu vs_val_csttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 115 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 116 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2015.dta") fields("val_ctdacu vs_val_ctdacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 116 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L117:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 117 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2015.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L117:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 117 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L118:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 118 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L118:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 118 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L119:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 119 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L119:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 119 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L120:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 120 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L120:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 120 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L121:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 121 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L121:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 121 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L122:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 122 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2015.dta") fields("val_ctsacu vs_val_ctsacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L122:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 122 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L123:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 123 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L123:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 123 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L124:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 124 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cttcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L124:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 124 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L125:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 125 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L125:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 125 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L126:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 126 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L126:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 126 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L127:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 127 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2015.dta") fields("val_cttcu vs_val_cttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L127:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 127 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L128:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 128 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2015.dta") fields("val_ctttcu vs_val_ctttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L128:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 128 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 129 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2015.dta") fields("val_cvdacu vs_val_cvdacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 129 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 130 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2015.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 130 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L131:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 131 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L131:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 131 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L132:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 132 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L132:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 132 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L133:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 133 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L133:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 133 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L134:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 134 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L134:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 134 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 135 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2015.dta") fields("val_cvsacu vs_val_cvsacu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 135 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L136:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 136 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L136:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 136 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L137:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 137 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L137:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 137 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L138:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 138 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L138:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 138 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L139:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 139 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L139:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 139 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 140 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2015.dta") fields("val_cvttcu vs_val_cvttcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 140 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L141:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 141 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2015.dta") fields("val_devvcu vs_val_devvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L141:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 141 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 142 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2015.dta") fields("val_ecavce vs_val_ecavce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 142 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L143:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 143 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2015.dta") fields("val_ecavcu vs_val_ecavcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L143:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 143 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 144 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2015.dta") fields("val_ecbvce vs_val_ecbvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 144 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 145 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2015.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 145 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L146:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 146 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2015.dta") fields("val_eckvce vs_val_eckvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L146:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 146 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 147 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2015.dta") fields("val_eckvcu vs_val_eckvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 147 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L148:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 148 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L148:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 148 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L149:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 149 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L149:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 149 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L150:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 150 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L150:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 150 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L151:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 151 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L151:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 151 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L152:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 152 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2015.dta") fields("val_eclvce vs_val_eclvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L152:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 152 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L153:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 153 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L153:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 153 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L154:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 154 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L154:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 154 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L155:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 155 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L155:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 155 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L156:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 156 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L156:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 156 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L157:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 157 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2015.dta") fields("val_eclvcu vs_val_eclvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L157:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 157 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 158 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2015.dta") fields("val_edivce vs_val_edivce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 158 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L159:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 159 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2015.dta") fields("val_edivcu vs_val_edivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L159:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 159 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L160:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 160 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2015.dta") fields("val_efovce vs_val_efovce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L160:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 160 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 161 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2015.dta") fields("val_efovcu vs_val_efovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 161 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L162:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 162 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L162:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 162 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L163:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 163 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L163:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 163 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L164:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 164 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L164:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 164 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L165:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 165 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L165:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 165 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 166 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2015.dta") fields("val_efuvce vs_val_efuvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 166 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L167:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 167 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L167:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 167 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L168:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 168 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L168:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 168 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L169:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 169 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L169:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 169 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L170:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 170 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L170:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 170 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 171 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2015.dta") fields("val_efuvcu vs_val_efuvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 171 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L172:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 172 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L172:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 172 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L173:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 173 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L173:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 173 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L174:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 174 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L174:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 174 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L175:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 175 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L175:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 175 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 176 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2015.dta") fields("val_egavce vs_val_egavce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 176 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L177:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 177 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L177:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 177 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L178:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 178 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L178:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 178 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L179:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 179 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L179:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 179 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L180:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 180 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L180:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 180 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 181 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2015.dta") fields("val_egavcu vs_val_egavcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 181 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 182 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2015.dta") fields("val_egovce vs_val_egovce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 182 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L183:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 183 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2015.dta") fields("val_egovcu vs_val_egovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L183:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 183 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L184:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 184 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L184:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 184 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L185:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 185 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L185:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 185 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L186:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 186 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L186:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 186 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L187:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 187 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L187:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 187 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 188 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2015.dta") fields("val_elpvce vs_val_elpvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 188 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L189:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 189 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L189:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 189 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L190:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 190 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L190:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 190 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L191:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 191 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L191:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 191 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L192:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 192 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L192:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 192 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 193 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2015.dta") fields("val_elpvcu vs_val_elpvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 193 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L194:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 194 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L194:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 194 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L195:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 195 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L195:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 195 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L196:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 196 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L196:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 196 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L197:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 197 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L197:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 197 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 198 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2015.dta") fields("val_eluvce vs_val_eluvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 198 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L199:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 199 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L199:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 199 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L200:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 200 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L200:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 200 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L201:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 201 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L201:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 201 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L202:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 202 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L202:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 202 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 203 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2015.dta") fields("val_eluvcu vs_val_eluvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 203 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L204:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 204 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L204:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 204 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L205:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 205 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L205:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 205 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L206:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 206 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L206:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 206 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L207:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 207 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L207:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 207 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 208 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2015.dta") fields("val_encvce vs_val_encvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 208 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L209:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 209 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L209:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 209 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L210:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 210 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L210:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 210 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L211:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 211 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L211:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 211 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L212:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 212 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L212:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 212 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 213 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2015.dta") fields("val_encvcu vs_val_encvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 213 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 214 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2015.dta") fields("val_engvce vs_val_engvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 214 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 215 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2015.dta") fields("val_engvcu vs_val_engvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 215 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L216:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 216 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L216:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 216 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L217:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 217 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L217:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 217 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L218:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 218 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L218:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 218 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L219:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 219 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L219:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 219 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 220 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2015.dta") fields("val_enpvcu vs_val_enpvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 220 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L221:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 221 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L221:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 221 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L222:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 222 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L222:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 222 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L223:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 223 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L223:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 223 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L224:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 224 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L224:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 224 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 225 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2015.dta") fields("val_eoivce vs_val_eoivce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 225 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L226:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 226 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L226:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 226 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L227:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 227 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L227:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 227 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L228:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 228 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L228:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 228 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L229:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 229 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L229:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 229 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 230 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2015.dta") fields("val_eoivcu vs_val_eoivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 230 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L231:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 231 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L231:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 231 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L232:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 232 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L232:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 232 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L233:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 233 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L233:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 233 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L234:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 234 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L234:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 234 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 235 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2015.dta") fields("val_epevce vs_val_epevce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 235 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L236:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 236 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L236:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 236 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L237:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 237 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L237:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 237 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L238:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 238 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L238:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 238 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L239:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 239 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L239:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 239 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 240 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2015.dta") fields("val_epevcu vs_val_epevcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 240 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L241:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 241 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L241:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 241 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L242:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 242 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L242:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 242 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L243:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 243 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L243:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 243 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L244:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 244 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L244:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 244 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 245 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2015.dta") fields("val_eplvcu vs_val_eplvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 245 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 246 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2015.dta") fields("val_esdvce vs_val_esdvce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 246 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 247 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2015.dta") fields("val_esdvcu vs_val_esdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 247 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L248:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 248 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L248:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 248 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L249:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 249 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L249:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 249 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L250:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 250 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L250:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 250 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L251:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 251 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L251:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 251 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 252 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2015.dta") fields("val_esovce vs_val_esovce") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 252 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L253:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 253 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L253:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 253 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L254:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 254 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L254:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 254 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L255:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 255 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L255:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 255 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L256:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 256 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L256:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 256 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 257 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2015.dta") fields("val_esovcu vs_val_esovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 257 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L258:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 258 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L258:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 258 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L259:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 259 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L259:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 259 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L260:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 260 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L260:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 260 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L261:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 261 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L261:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 261 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 262 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2015.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 262 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L263:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 263 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L263:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 263 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L264:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 264 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L264:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 264 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L265:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 265 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L265:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 265 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L266:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 266 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L266:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 266 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 267 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2015.dta") fields("val_icovcu vs_val_icovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 267 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 268 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2015.dta") fields("val_idevcu vs_val_idevcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 268 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L269:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 269 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2015.dta") fields("val_iinput vs_val_iinput") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L269:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 269 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L270:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 270 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L270:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 270 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L271:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 271 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L271:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 271 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L272:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 272 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L272:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 272 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L273:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 273 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L273:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 273 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L274:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 274 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2015.dta") fields("val_iinvcu vs_val_iinvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L274:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 274 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 275 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2015.dta") fields("val_iisfov vs_val_iisfov") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 275 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L276:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 276 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2015.dta") fields("val_iislov vs_val_iislov") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L276:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 276 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L277:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 277 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L277:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 277 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L278:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 278 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L278:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 278 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L279:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 279 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L279:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 279 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L280:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 280 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L280:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 280 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L281:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 281 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2015.dta") fields("val_iisvcu vs_val_iisvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L281:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 281 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L282:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 282 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2015.dta") fields("val_ikivcu vs_val_ikivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L282:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 282 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 283 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2015.dta") fields("val_iklvcu vs_val_iklvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 283 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 284 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2015.dta") fields("val_ikovcu vs_val_ikovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 284 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L285:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 285 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L285:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 285 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L286:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 286 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L286:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 286 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L287:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 287 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L287:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 287 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L288:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 288 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L288:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 288 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 289 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2015.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 289 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 290 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2015.dta") fields("val_insvcu vs_val_insvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 290 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L291:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 291 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2015.dta") fields("val_intvcu vs_val_intvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L291:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 291 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L292:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 292 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L292:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 292 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L293:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 293 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L293:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 293 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L294:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 294 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L294:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 294 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L295:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 295 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L295:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 295 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L296:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 296 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2015.dta") fields("val_iotvcu vs_val_iotvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L296:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 296 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 297 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2015.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 297 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L298:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 298 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2015.dta") fields("val_iprvcu vs_val_iprvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L298:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 298 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 299 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2015.dta") fields("val_irdvcu vs_val_irdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 299 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L300:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 300 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L300:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 300 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L301:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 301 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irevcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L301:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 301 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L302:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 302 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L302:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 302 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L303:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 303 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L303:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 303 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L304:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 304 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2015.dta") fields("val_irevcu vs_val_irevcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L304:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 304 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 305 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2015.dta") fields("val_irrvcu vs_val_irrvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 305 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L306:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 306 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L306:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 306 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L307:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 307 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L307:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 307 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L308:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 308 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L308:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 308 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L309:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 309 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L309:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 309 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 310 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2015.dta") fields("val_itxvcu vs_val_itxvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 310 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 311 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2015.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 311 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 312 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2015.dta") fields("val_nopvcu vs_val_nopvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 312 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 313 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2015.dta") fields("val_othvcu vs_val_othvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 313 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 314 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2015.dta") fields("val_output vs_val_output") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 314 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L315:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 315 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L315:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 315 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L316:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 316 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L316:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 316 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L317:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 317 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L317:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 317 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L318:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 318 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L318:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 318 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 319 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2015.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 319 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 320 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2015.dta") fields("val_renvcu vs_val_renvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 320 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L321:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 321 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L321:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 321 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L322:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 322 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L322:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 322 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L323:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 323 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L323:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 323 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L324:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 324 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L324:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 324 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 325 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2015.dta") fields("val_rimvcu vs_val_rimvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 325 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L326:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 326 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L326:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 326 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L327:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 327 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L327:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 327 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L328:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 328 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L328:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 328 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L329:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 329 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L329:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 329 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 330 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2015.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 330 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 331 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2015.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 331 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 332 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2015.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 332 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L333:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 333 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L333:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 333 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L334:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 334 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L334:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 334 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L335:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 335 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L335:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 335 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L336:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 336 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L336:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 336 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L337:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 337 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2015.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L337:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 337 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L338:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 338 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2015.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L338:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 338 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L339:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 339 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L339:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 339 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L340:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 340 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L340:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 340 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L341:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 341 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L341:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 341 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L342:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 342 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L342:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 342 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 343 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2015.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 343 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 344 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2015.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 344 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L345:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 345 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L345:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 345 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L346:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 346 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L346:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 346 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L347:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 347 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L347:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 347 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L348:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 348 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L348:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 348 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 349 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2015.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 349 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 350 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2015.dta") fields("val_sfovcu vs_val_sfovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 350 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 351 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2015.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 351 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 352 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2015.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 352 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L353:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 353 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2015.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L353:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 353 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L354:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 354 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L354:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 354 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L355:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 355 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L355:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 355 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L356:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 356 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L356:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 356 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L357:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 357 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L357:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 357 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L358:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 358 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2015.dta") fields("val_shdvcu vs_val_shdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L358:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 358 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L359:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 359 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L359:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 359 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L360:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 360 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L360:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 360 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L361:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 361 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L361:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 361 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L362:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 362 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L362:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 362 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 363 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2015.dta") fields("val_shfvcu vs_val_shfvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 363 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L364:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 364 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L364:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 364 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L365:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 365 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L365:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 365 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L366:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 366 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L366:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 366 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L367:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 367 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L367:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 367 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L368:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 368 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2015.dta") fields("val_shjvcu vs_val_shjvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L368:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 368 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L369:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 369 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L369:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 369 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L370:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 370 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L370:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 370 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L371:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 371 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L371:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 371 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L372:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 372 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L372:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 372 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L373:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 373 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2015.dta") fields("val_srdvcu vs_val_srdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L373:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 373 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L374:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 374 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L374:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 374 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L375:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 375 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L375:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 375 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L376:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 376 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L376:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 376 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L377:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 377 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L377:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 377 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 378 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2015.dta") fields("val_srjvcu vs_val_srjvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 378 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L379:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 379 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L379:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 379 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L380:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 380 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L380:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 380 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L381:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 381 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L381:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 381 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L382:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 382 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L382:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 382 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 383 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2015.dta") fields("val_srmvcu vs_val_srmvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 383 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L384:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 384 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L384:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 384 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L385:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 385 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L385:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 385 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L386:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 386 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L386:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 386 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L387:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 387 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L387:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 387 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 388 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2015.dta") fields("val_stdvcu vs_val_stdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 388 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L389:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 389 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L389:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 389 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L390:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 390 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L390:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 390 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L391:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 391 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L391:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 391 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L392:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 392 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L392:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 392 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 393 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2015.dta") fields("val_stjvcu vs_val_stjvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 393 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L394:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 394 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L394:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 394 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L395:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 395 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L395:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 395 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L396:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 396 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L396:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 396 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L397:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 397 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L397:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 397 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 398 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2015.dta") fields("val_stlvcu vs_val_stlvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 398 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 399 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2015.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 399 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L400:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 400 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L400:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 400 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L401:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 401 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L401:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 401 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L402:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 402 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L402:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 402 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L403:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 403 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L403:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 403 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 404 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2015.dta") fields("val_yelvcu vs_val_yelvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 404 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L405:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 405 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L405:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 405 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L406:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 406 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L406:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 406 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L407:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 407 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L407:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 407 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L408:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 408 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L408:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 408 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 409 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2015.dta") fields("val_yisvcu vs_val_yisvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 409 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L410:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 410 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2015.dta") fields("val_yisvdo vs_val_yisvdo") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L410:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 410 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 411 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2015.dta") fields("val_yisvfo vs_val_yisvfo") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 411 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L412:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 412 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2015.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L412:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 412 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 413 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2015.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 413 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 414 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2015.dta") fields("val_ykivcu vs_val_ykivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 414 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L415:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 415 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L415:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 415 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L416:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 416 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L416:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 416 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L417:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 417 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L417:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 417 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L418:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 418 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L418:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 418 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 419 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2015.dta") fields("val_yprvcu vs_val_yprvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 419 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L420:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 420 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L420:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 420 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L421:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 421 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L421:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 421 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L422:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 422 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L422:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 422 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L423:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 423 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L423:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 423 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 424 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2015.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 424 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L425:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 425 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2015.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L425:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 425 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L426:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 426 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2015.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L426:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 426 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L427:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 427 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2015.dta") fields("val_ytovcu vs_val_ytovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L427:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 427 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L428:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 428 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L428:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 428 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L429:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 429 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L429:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 429 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L430:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 430 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L430:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 430 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L431:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 431 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L431:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 431 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L432:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 432 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2015.dta") fields("val_znavcu vs_val_znavcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L432:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 432 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L433:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 433 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L433:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 433 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L434:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 434 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L434:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 434 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L435:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 435 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L435:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 435 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L436:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 436 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L436:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 436 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L437:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 437 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2015.dta") fields("val_zndvcu vs_val_zndvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L437:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 437 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 438 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2015.dta") fields("val_znevcu vs_val_znevcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 438 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 439 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2015.dta") fields("val_znhvcu vs_val_znhvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 439 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L440:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 440 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2015.dta") fields("val_znivcu vs_val_znivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L440:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 440 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L441:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 441 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L441:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 441 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L442:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 442 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L442:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 442 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L443:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 443 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L443:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 443 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L444:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 444 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L444:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 444 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L445:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 445 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2015.dta") fields("val_znovcu vs_val_znovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L445:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 445 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L446:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 446 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L446:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 446 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L447:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 447 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L447:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 447 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L448:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 448 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L448:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 448 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L449:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 449 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L449:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 449 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L450:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 450 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2015.dta") fields("val_znpvcu vs_val_znpvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L450:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 450 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L451:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 451 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2015.dta") fields("val_znrvcu vs_val_znrvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L451:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 451 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L452:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 452 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L452:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 452 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L453:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 453 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L453:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 453 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L454:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 454 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L454:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 454 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L455:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 455 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L455:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 455 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 456 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2015.dta") fields("val_znsvcu vs_val_znsvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 456 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 457 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2015.dta") fields("val_zntvcu vs_val_zntvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 457 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L458:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 458 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L458:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 458 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L459:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 459 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L459:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 459 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L460:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 460 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L460:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 460 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L461:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 461 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L461:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 461 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 462 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2015.dta") fields("val_zpavcu vs_val_zpavcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 462 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L463:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 463 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L463:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 463 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L464:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 464 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L464:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 464 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L465:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 465 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L465:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 465 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L466:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 466 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L466:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 466 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 467 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2015.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 467 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 468 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2015.dta") fields("val_zpevcu vs_val_zpevcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 468 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 469 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2015.dta") fields("val_zphvcu vs_val_zphvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 469 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L470:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 470 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L470:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 470 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L471:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 471 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L471:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 471 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L472:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 472 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L472:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 472 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L473:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 473 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L473:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 473 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 474 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2015.dta") fields("val_zpivcu vs_val_zpivcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 474 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L475:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 475 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L475:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 475 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L476:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 476 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L476:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 476 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L477:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 477 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L477:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 477 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L478:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 478 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L478:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 478 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 479 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2015.dta") fields("val_zpovcu vs_val_zpovcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 479 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L480:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 480 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L480:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 480 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L481:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 481 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L481:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 481 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L482:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 482 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L482:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 482 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L483:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 483 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L483:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 483 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 484 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2015.dta") fields("val_zppvcu vs_val_zppvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 484 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L485:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 485 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2015.dta") fields("val_zprvcu vs_val_zprvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L485:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 485 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L486:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 486 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L486:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 486 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L487:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 487 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L487:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 487 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L488:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 488 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L488:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 488 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L489:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 489 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L489:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 489 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L490:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 490 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2015.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L490:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 490 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L491:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 491 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2015.dta") fields("val_zptvcu vs_val_zptvcu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L491:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 491 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L492:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 492 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L492:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 492 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L493:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 493 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu15
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L493:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 493 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L494:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 494 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L494:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 494 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L495:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 495 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L495:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 495 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L496:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 496 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2015.dta") fields("value_added_nominal vs_value_added_nominal") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L496:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 496 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L497:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 497 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L497:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 497 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L498:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 498 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L498:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 498 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L499:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 499 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L499:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 499 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L500:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 500 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L500:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 500 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L501:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 501 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2015.dta") fields("workers vs_workers") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L501:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 501 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L502:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 502 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L502:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 502 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L503:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 503 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kip
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L503:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 503 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L504:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 504 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L504:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 504 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L505:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 505 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L505:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 505 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L506:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 506 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2015.dta") fields("source_id_raw vs_source_id_raw") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L506:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 506 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L507:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 507 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L507:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 507 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L508:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 508 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kodekab
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L508:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 508 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L509:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 509 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L509:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 509 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L510:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 510 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L510:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 510 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L511:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 511 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2015.dta") fields("district_code vs_district_code") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L511:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 511 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L512:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 512 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L512:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 512 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L513:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 513 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic5
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L513:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 513 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L514:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 514 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L514:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 514 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L515:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 515 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L515:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 515 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 516 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2015.dta") fields("industry_code vs_industry_code") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 516 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L517:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 517 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L517:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 517 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L518:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 518 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L518:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 518 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L519:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 519 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L519:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 519 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L520:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 520 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L520:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 520 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L521:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 521 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2015.dta") fields("province_code vs_province_code") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L521:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 521 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L522:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 522 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L522:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 522 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L523:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 523 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L523:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 523 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L524:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 524 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L524:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 524 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L525:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 525 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L525:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 525 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L526:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 526 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2015.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L526:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 526 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L527:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 527 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L527:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 527 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L528:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 528 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L528:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 528 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L529:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 529 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L529:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 529 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L530:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 530 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L530:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 530 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L531:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 531 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2015.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L531:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 531 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L532:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 532 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L532:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 532 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L533:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 533 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L533:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 533 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L534:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 534 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L534:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 534 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L535:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 535 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L535:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 535 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L536:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 536 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2015.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L536:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 536 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L537:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 537 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L537:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 537 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L538:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 538 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L538:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 538 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L539:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 539 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L539:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 539 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L540:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 540 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L540:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 540 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 541 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2015.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 541 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L542:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 542 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L542:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 542 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L543:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 543 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L543:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 543 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L544:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 544 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L544:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 544 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L545:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 545 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L545:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 545 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L546:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 546 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2015.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L546:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 546 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 547 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2015.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 547 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 548 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2015.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 548 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 549 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2015.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 549 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L550:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 550 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2015.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L550:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 550 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L551:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 551 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L551:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 551 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L552:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 552 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L552:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 552 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L553:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 553 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L553:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 553 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L554:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 554 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L554:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 554 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 555 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2015.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 555 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L556:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 556 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L556:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 556 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L557:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 557 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L557:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 557 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L558:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 558 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L558:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 558 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L559:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 559 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L559:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 559 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 560 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2015.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 560 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L561:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 561 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L561:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 561 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L562:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 562 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L562:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 562 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L563:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 563 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L563:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 563 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L564:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 564 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L564:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 564 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 565 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2015.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 565 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L566:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 566 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L566:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 566 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L567:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 567 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L567:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 567 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L568:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 568 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L568:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 568 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L569:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 569 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L569:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 569 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L570:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 570 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2015.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L570:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 570 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L571:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 571 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2015.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L571:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 571 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 572 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2015.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 572 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 573 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2015.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 573 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 574 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2015.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 574 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L575:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 575 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L575:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 575 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L576:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 576 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L576:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 576 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L577:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 577 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L577:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 577 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L578:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 578 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L578:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 578 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 579 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2015.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 579 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L580:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 580 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L580:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 580 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L581:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 581 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L581:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 581 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L582:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 582 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L582:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 582 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L583:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 583 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L583:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 583 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 584 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2015.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 584 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 585 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2015.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 585 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L586:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 586 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2015.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L586:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 586 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L587:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 587 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2015.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L587:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 587 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 588 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2015.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 588 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 589 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2015.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 589 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 590 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2015.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 590 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L591:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 591 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L591:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 591 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L592:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 592 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoiliu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L592:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 592 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L593:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 593 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L593:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 593 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L594:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 594 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L594:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 594 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 595 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2015.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 595 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L596:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 596 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L596:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 596 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L597:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 597 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L597:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 597 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L598:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 598 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L598:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 598 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L599:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 599 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L599:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 599 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 600 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2015.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 600 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L601:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 601 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L601:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 601 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L602:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 602 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L602:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 602 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L603:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 603 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L603:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 603 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L604:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 604 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L604:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 604 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L605:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 605 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2015.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L605:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 605 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L606:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 606 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L606:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 606 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L607:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 607 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L607:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 607 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L608:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 608 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L608:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 608 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L609:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 609 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L609:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 609 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 610 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2015.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 610 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L611:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 611 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L611:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 611 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L612:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 612 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L612:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 612 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L613:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 613 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L613:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 613 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L614:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 614 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L614:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 614 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L615:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 615 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2015.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L615:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 615 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L616:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 616 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L616:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 616 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L617:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 617 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L617:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 617 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L618:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 618 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L618:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 618 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L619:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 619 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L619:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 619 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 620 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2015.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 620 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 621 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2015.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 621 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 622 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2015.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 622 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L623:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 623 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L623:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 623 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L624:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 624 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L624:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 624 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L625:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 625 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L625:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 625 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L626:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 626 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L626:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 626 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 627 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2015.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 627 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 628 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2015.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 628 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 629 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2015.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 629 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L630:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 630 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L630:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 630 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L631:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 631 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L631:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 631 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L632:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 632 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L632:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 632 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L633:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 633 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L633:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 633 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 634 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2015.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 634 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L635:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 635 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L635:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 635 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L636:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 636 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L636:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 636 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L637:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 637 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L637:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 637 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L638:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 638 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L638:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 638 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L639:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 639 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2015.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L639:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 639 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L640:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 640 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L640:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 640 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L641:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 641 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L641:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 641 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L642:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 642 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L642:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 642 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L643:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 643 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L643:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 643 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 644 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2015.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 644 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L645:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 645 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L645:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 645 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L646:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 646 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L646:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 646 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L647:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 647 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L647:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 647 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L648:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 648 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L648:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 648 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L649:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 649 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2015.dta") fields("export_any_binary vs_export_any_binary") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L649:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 649 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L650:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 650 668 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L650:step-preserve" "code/annual/merge_mapped_2015.do:L1:file" "statement" 650 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L651:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 651 668 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L651:step-keep" "code/annual/merge_mapped_2015.do:L1:file" "statement" 651 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L652:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 652 668 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2015.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L652:step-cf" "code/annual/merge_mapped_2015.do:L1:file" "statement" 652 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L653:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 653 668 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L653:step-restore" "code/annual/merge_mapped_2015.do:L1:file" "statement" 653 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 654 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2015.dta") fields("export_direct_flag vs_export_direct_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 654 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L655:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 655 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2015.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L655:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 655 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 656 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2015.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 656 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L657:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 657 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2015.dta") fields("innovation_flag vs_innovation_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L657:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 657 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 658 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2015.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 658 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 659 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2015.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 659 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 660 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2015.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 660 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 661 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2015.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 661 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 662 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2015.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 662 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 663 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2015.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 663 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L664:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 664 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2015.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L664:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 664 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 665 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2015.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 665 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 666 668 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2015.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2015)
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2015.do:L1:file" "statement" 666 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L667:step-isid" "code/annual/merge_mapped_2015.do:L1:file" "statement" 667 668 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L667:step-isid" "code/annual/merge_mapped_2015.do:L1:file" "statement" 667 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2015.do:L668:step-save" "code/annual/merge_mapped_2015.do:L1:file" "statement" 668 668 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2015.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L668:step-save" "code/annual/merge_mapped_2015.do:L1:file" "statement" 668 668 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2015.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
