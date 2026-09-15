* Tujuan: Gabungkan hasil pemetaan kolom tahun 2017 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2017.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2017.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L1:step-do" "code/annual/merge_mapped_2017.do:L1:file" "statement" 1 824 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L1:step-do" "code/annual/merge_mapped_2017.do:L1:file" "statement" 1 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L2:step-do" "code/annual/merge_mapped_2017.do:L1:file" "statement" 2 824 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L2:step-do" "code/annual/merge_mapped_2017.do:L1:file" "statement" 2 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L3:step-use" "code/annual/merge_mapped_2017.do:L1:file" "statement" 3 824 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2017.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L3:step-use" "code/annual/merge_mapped_2017.do:L1:file" "statement" 3 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L4:step-assert" "code/annual/merge_mapped_2017.do:L1:file" "statement" 4 824 `=_rc' // WFLOG-INJECTED
assert source_year==2017
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L4:step-assert" "code/annual/merge_mapped_2017.do:L1:file" "statement" 4 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L5:step-isid" "code/annual/merge_mapped_2017.do:L1:file" "statement" 5 824 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L5:step-isid" "code/annual/merge_mapped_2017.do:L1:file" "statement" 5 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 6 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2017.dta") fields("amdal_raw vs_amdal_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 6 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 7 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2017.dta") fields("b3wste_raw vs_b3wste_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 7 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L8:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 8 824 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L8:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 8 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L9:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 9 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L9:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 9 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L10:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 10 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L10:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 10 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L11:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 11 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L11:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 11 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 12 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2017.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 12 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L13:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 13 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L13:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 13 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L14:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 14 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L14:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 14 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L15:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 15 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L15:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 15 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L16:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 16 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L16:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 16 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 17 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2017.dta") fields("capital_nominal vs_capital_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 17 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L18:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 18 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L18:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 18 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L19:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 19 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L19:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 19 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L20:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 20 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L20:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 20 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L21:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 21 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L21:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 21 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 22 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2017.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 22 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L23:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 23 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L23:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 23 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L24:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 24 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L24:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 24 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L25:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 25 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L25:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 25 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L26:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 26 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L26:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 26 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 27 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2017.dta") fields("export_binary_raw vs_export_binary_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 27 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L28:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 28 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2017.dta") fields("export_share_pct vs_export_share_pct") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L28:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 28 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L29:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 29 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L29:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 29 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L30:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 30 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L30:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 30 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L31:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 31 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L31:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 31 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L32:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 32 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L32:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 32 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L33:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 33 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2017.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L33:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 33 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L34:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 34 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L34:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 34 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L35:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 35 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L35:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 35 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L36:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 36 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L36:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 36 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L37:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 37 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L37:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 37 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L38:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 38 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2017.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L38:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 38 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L39:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 39 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L39:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 39 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L40:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 40 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L40:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 40 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L41:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 41 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L41:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 41 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L42:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 42 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L42:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 42 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L43:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 43 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2017.dta") fields("import_value_nominal vs_import_value_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L43:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 43 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L44:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 44 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L44:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 44 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L45:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 45 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inomkt17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L45:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 45 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L46:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 46 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L46:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 46 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L47:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 47 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L47:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 47 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 48 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2017.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 48 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L49:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 49 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L49:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 49 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L50:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 50 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inoorg17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L50:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 50 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L51:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 51 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L51:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 51 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L52:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 52 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L52:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 52 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 53 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2017.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 53 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L54:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 54 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L54:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 54 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L55:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 55 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inopcs17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L55:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 55 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L56:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 56 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L56:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 56 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L57:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 57 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L57:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 57 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 58 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2017.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 58 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L59:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 59 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L59:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 59 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L60:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 60 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inoprd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L60:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 60 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L61:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 61 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L61:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 61 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L62:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 62 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L62:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 62 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L63:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 63 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2017.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L63:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 63 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L64:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 64 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2017.dta") fields("innovation_raw vs_innovation_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L64:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 64 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 65 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2017.dta") fields("inspli_raw vs_inspli_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 65 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L66:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 66 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L66:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 66 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L67:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 67 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L67:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 67 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L68:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 68 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L68:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 68 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L69:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 69 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L69:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 69 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 70 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2017.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 70 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 71 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2017.dta") fields("liwste_raw vs_liwste_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 71 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L72:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 72 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2017.dta") fields("pplihi_raw vs_pplihi_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L72:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 72 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L73:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 73 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L73:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 73 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L74:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 74 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L74:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 74 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L75:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 75 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L75:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 75 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L76:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 76 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L76:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 76 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L77:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 77 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2017.dta") fields("production_workers vs_production_workers") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L77:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 77 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L78:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 78 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L78:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 78 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L79:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 79 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L79:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 79 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L80:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 80 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L80:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 80 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L81:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 81 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L81:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 81 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L82:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 82 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2017.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L82:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 82 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L83:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 83 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L83:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 83 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L84:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 84 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L84:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 84 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L85:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 85 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L85:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 85 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L86:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 86 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L86:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 86 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 87 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2017.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 87 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L88:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 88 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L88:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 88 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L89:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 89 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlrnd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L89:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 89 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L90:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 90 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_workers_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L90:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 90 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L91:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 91 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L91:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 91 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 92 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2017.dta") fields("rd_workers vs_rd_workers") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 92 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 93 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2017.dta") fields("sowste_raw vs_sowste_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 93 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L94:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 94 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2017.dta") fields("spplhi_raw vs_spplhi_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L94:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 94 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L95:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 95 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L95:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 95 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L96:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 96 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L96:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 96 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L97:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 97 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L97:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 97 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L98:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 98 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L98:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 98 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 99 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2017.dta") fields("val_cbdacu vs_val_cbdacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 99 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 100 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2017.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 100 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L101:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 101 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L101:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 101 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L102:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 102 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L102:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 102 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L103:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 103 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L103:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 103 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L104:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 104 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L104:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 104 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 105 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2017.dta") fields("val_cbsacu vs_val_cbsacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 105 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L106:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 106 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L106:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 106 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L107:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 107 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L107:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 107 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L108:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 108 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L108:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 108 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L109:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 109 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L109:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 109 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L110:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 110 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2017.dta") fields("val_cbttcu vs_val_cbttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L110:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 110 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L111:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 111 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L111:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 111 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L112:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 112 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cldacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L112:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 112 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L113:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 113 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L113:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 113 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L114:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 114 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L114:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 114 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 115 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2017.dta") fields("val_cldacu vs_val_cldacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 115 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 116 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2017.dta") fields("val_clfpcu vs_val_clfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 116 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L117:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 117 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L117:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 117 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L118:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 118 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L118:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 118 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L119:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 119 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L119:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 119 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L120:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 120 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L120:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 120 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 121 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2017.dta") fields("val_clsacu vs_val_clsacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 121 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L122:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 122 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L122:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 122 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L123:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 123 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L123:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 123 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L124:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 124 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L124:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 124 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L125:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 125 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L125:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 125 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 126 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2017.dta") fields("val_clttcu vs_val_clttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 126 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L127:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 127 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L127:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 127 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L128:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 128 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L128:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 128 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L129:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 129 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L129:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 129 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L130:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 130 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L130:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 130 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 131 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2017.dta") fields("val_cmdacu vs_val_cmdacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 131 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 132 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2017.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 132 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L133:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 133 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L133:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 133 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L134:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 134 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L134:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 134 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L135:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 135 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L135:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 135 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L136:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 136 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L136:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 136 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 137 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2017.dta") fields("val_cmsacu vs_val_cmsacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 137 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L138:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 138 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L138:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 138 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L139:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 139 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L139:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 139 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L140:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 140 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L140:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 140 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L141:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 141 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L141:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 141 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 142 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2017.dta") fields("val_cmttcu vs_val_cmttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 142 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L143:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 143 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L143:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 143 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L144:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 144 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L144:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 144 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L145:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 145 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L145:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 145 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L146:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 146 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L146:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 146 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 147 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2017.dta") fields("val_codacu vs_val_codacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 147 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 148 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2017.dta") fields("val_cofpcu vs_val_cofpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 148 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L149:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 149 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L149:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 149 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L150:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 150 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L150:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 150 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L151:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 151 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L151:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 151 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L152:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 152 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L152:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 152 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L153:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 153 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2017.dta") fields("val_cosacu vs_val_cosacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L153:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 153 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L154:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 154 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L154:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 154 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L155:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 155 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L155:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 155 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L156:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 156 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_costrd_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L156:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 156 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L157:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 157 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L157:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 157 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 158 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2017.dta") fields("val_costrd vs_val_costrd") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 158 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L159:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 159 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L159:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 159 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L160:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 160 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L160:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 160 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L161:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 161 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L161:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 161 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L162:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 162 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L162:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 162 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L163:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 163 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2017.dta") fields("val_cottcu vs_val_cottcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L163:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 163 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L164:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 164 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L164:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 164 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L165:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 165 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csdacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L165:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 165 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L166:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 166 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L166:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 166 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L167:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 167 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L167:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 167 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L168:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 168 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2017.dta") fields("val_csdacu vs_val_csdacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L168:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 168 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L169:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 169 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2017.dta") fields("val_csfpcu vs_val_csfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L169:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 169 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L170:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 170 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L170:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 170 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L171:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 171 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cssacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L171:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 171 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L172:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 172 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L172:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 172 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L173:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 173 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L173:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 173 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 174 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2017.dta") fields("val_cssacu vs_val_cssacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 174 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L175:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 175 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L175:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 175 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L176:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 176 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L176:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 176 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L177:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 177 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L177:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 177 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L178:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 178 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L178:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 178 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 179 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2017.dta") fields("val_csttcu vs_val_csttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 179 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L180:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 180 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L180:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 180 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L181:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 181 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L181:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 181 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L182:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 182 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L182:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 182 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L183:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 183 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L183:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 183 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 184 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2017.dta") fields("val_ctdacu vs_val_ctdacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 184 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 185 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2017.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 185 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L186:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 186 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L186:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 186 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L187:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 187 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L187:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 187 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L188:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 188 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L188:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 188 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L189:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 189 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L189:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 189 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 190 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2017.dta") fields("val_ctsacu vs_val_ctsacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 190 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 191 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2017.dta") fields("val_cttcu vs_val_cttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 191 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L192:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 192 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L192:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 192 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L193:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 193 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L193:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 193 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L194:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 194 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L194:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 194 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L195:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 195 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L195:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 195 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L196:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 196 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2017.dta") fields("val_ctttcu vs_val_ctttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L196:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 196 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L197:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 197 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L197:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 197 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L198:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 198 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L198:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 198 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L199:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 199 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L199:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 199 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L200:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 200 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L200:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 200 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 201 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2017.dta") fields("val_cvdacu vs_val_cvdacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 201 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L202:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 202 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2017.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L202:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 202 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L203:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 203 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L203:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 203 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L204:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 204 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L204:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 204 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L205:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 205 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L205:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 205 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L206:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 206 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L206:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 206 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L207:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 207 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2017.dta") fields("val_cvsacu vs_val_cvsacu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L207:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 207 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L208:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 208 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L208:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 208 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L209:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 209 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L209:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 209 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L210:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 210 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L210:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 210 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L211:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 211 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L211:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 211 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L212:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 212 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2017.dta") fields("val_cvttcu vs_val_cvttcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L212:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 212 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L213:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 213 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L213:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 213 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L214:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 214 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_devvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L214:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 214 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L215:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 215 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L215:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 215 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L216:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 216 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L216:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 216 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L217:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 217 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2017.dta") fields("val_devvcu vs_val_devvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L217:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 217 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L218:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 218 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2017.dta") fields("val_ecavce vs_val_ecavce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L218:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 218 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L219:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 219 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2017.dta") fields("val_ecavcu vs_val_ecavcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L219:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 219 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L220:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 220 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L220:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 220 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L221:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 221 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L221:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 221 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L222:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 222 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L222:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 222 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L223:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 223 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L223:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 223 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L224:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 224 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2017.dta") fields("val_ecbvce vs_val_ecbvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L224:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 224 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L225:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 225 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L225:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 225 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L226:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 226 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L226:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 226 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L227:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 227 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L227:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 227 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L228:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 228 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L228:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 228 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L229:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 229 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2017.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L229:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 229 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 230 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2017.dta") fields("val_eckvce vs_val_eckvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 230 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 231 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2017.dta") fields("val_eckvcu vs_val_eckvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 231 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L232:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 232 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L232:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 232 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L233:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 233 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L233:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 233 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L234:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 234 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L234:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 234 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L235:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 235 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L235:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 235 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 236 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2017.dta") fields("val_eclvce vs_val_eclvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 236 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L237:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 237 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L237:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 237 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L238:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 238 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L238:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 238 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L239:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 239 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L239:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 239 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L240:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 240 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L240:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 240 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 241 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2017.dta") fields("val_eclvcu vs_val_eclvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 241 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 242 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2017.dta") fields("val_edivce vs_val_edivce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 242 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 243 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2017.dta") fields("val_edivcu vs_val_edivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 243 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L244:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 244 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2017.dta") fields("val_efovce vs_val_efovce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L244:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 244 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 245 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2017.dta") fields("val_efovcu vs_val_efovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 245 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L246:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 246 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L246:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 246 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L247:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 247 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L247:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 247 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L248:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 248 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L248:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 248 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L249:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 249 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L249:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 249 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L250:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 250 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2017.dta") fields("val_efuvce vs_val_efuvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L250:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 250 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L251:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 251 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L251:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 251 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L252:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 252 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L252:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 252 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L253:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 253 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L253:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 253 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L254:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 254 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L254:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 254 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L255:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 255 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2017.dta") fields("val_efuvcu vs_val_efuvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L255:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 255 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L256:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 256 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L256:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 256 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L257:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 257 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L257:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 257 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L258:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 258 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L258:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 258 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L259:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 259 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L259:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 259 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L260:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 260 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2017.dta") fields("val_egavce vs_val_egavce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L260:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 260 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L261:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 261 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L261:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 261 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L262:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 262 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L262:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 262 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L263:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 263 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L263:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 263 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L264:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 264 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L264:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 264 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L265:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 265 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2017.dta") fields("val_egavcu vs_val_egavcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L265:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 265 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L266:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 266 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L266:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 266 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L267:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 267 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L267:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 267 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L268:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 268 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L268:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 268 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L269:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 269 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L269:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 269 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L270:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 270 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2017.dta") fields("val_egovce vs_val_egovce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L270:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 270 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L271:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 271 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L271:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 271 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L272:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 272 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L272:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 272 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L273:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 273 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L273:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 273 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L274:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 274 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L274:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 274 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 275 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2017.dta") fields("val_egovcu vs_val_egovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 275 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L276:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 276 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L276:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 276 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L277:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 277 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L277:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 277 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L278:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 278 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L278:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 278 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L279:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 279 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L279:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 279 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L280:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 280 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2017.dta") fields("val_elpvce vs_val_elpvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L280:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 280 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L281:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 281 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L281:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 281 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L282:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 282 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L282:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 282 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L283:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 283 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L283:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 283 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L284:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 284 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L284:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 284 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 285 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2017.dta") fields("val_elpvcu vs_val_elpvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 285 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L286:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 286 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L286:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 286 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L287:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 287 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L287:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 287 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L288:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 288 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L288:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 288 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L289:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 289 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L289:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 289 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 290 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2017.dta") fields("val_eluvce vs_val_eluvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 290 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L291:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 291 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L291:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 291 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L292:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 292 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L292:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 292 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L293:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 293 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L293:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 293 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L294:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 294 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L294:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 294 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 295 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2017.dta") fields("val_eluvcu vs_val_eluvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 295 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L296:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 296 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L296:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 296 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L297:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 297 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L297:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 297 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L298:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 298 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L298:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 298 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L299:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 299 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L299:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 299 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 300 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2017.dta") fields("val_encvce vs_val_encvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 300 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L301:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 301 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L301:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 301 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L302:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 302 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L302:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 302 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L303:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 303 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L303:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 303 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L304:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 304 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L304:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 304 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 305 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2017.dta") fields("val_encvcu vs_val_encvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 305 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L306:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 306 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2017.dta") fields("val_engvce vs_val_engvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L306:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 306 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 307 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2017.dta") fields("val_engvcu vs_val_engvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 307 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L308:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 308 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L308:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 308 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L309:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 309 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L309:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 309 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L310:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 310 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L310:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 310 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L311:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 311 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L311:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 311 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 312 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2017.dta") fields("val_enpvcu vs_val_enpvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 312 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 313 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2017.dta") fields("val_eoivce vs_val_eoivce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 313 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 314 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2017.dta") fields("val_eoivcu vs_val_eoivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 314 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L315:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 315 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L315:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 315 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L316:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 316 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L316:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 316 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L317:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 317 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L317:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 317 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L318:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 318 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L318:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 318 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 319 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2017.dta") fields("val_epevce vs_val_epevce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 319 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L320:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 320 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L320:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 320 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L321:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 321 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L321:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 321 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L322:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 322 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L322:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 322 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L323:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 323 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L323:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 323 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L324:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 324 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2017.dta") fields("val_epevcu vs_val_epevcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L324:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 324 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L325:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 325 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L325:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 325 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L326:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 326 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L326:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 326 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L327:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 327 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L327:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 327 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L328:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 328 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L328:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 328 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L329:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 329 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2017.dta") fields("val_eplvcu vs_val_eplvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L329:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 329 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 330 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2017.dta") fields("val_esdvce vs_val_esdvce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 330 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 331 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2017.dta") fields("val_esdvcu vs_val_esdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 331 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L332:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 332 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L332:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 332 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L333:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 333 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L333:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 333 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L334:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 334 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L334:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 334 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L335:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 335 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L335:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 335 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 336 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2017.dta") fields("val_esovce vs_val_esovce") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 336 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L337:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 337 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L337:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 337 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L338:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 338 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L338:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 338 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L339:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 339 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L339:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 339 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L340:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 340 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L340:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 340 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 341 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2017.dta") fields("val_esovcu vs_val_esovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 341 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L342:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 342 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L342:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 342 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L343:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 343 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L343:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 343 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L344:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 344 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L344:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 344 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L345:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 345 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L345:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 345 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 346 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2017.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 346 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L347:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 347 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L347:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 347 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L348:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 348 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L348:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 348 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L349:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 349 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L349:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 349 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L350:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 350 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L350:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 350 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 351 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2017.dta") fields("val_icovcu vs_val_icovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 351 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L352:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 352 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L352:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 352 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L353:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 353 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_idevcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L353:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 353 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L354:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 354 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L354:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 354 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L355:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 355 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L355:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 355 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 356 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2017.dta") fields("val_idevcu vs_val_idevcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 356 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L357:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 357 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L357:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 357 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L358:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 358 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L358:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 358 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L359:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 359 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L359:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 359 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L360:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 360 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L360:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 360 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 361 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2017.dta") fields("val_iinput vs_val_iinput") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 361 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L362:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 362 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L362:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 362 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L363:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 363 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L363:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 363 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L364:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 364 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L364:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 364 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L365:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 365 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L365:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 365 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 366 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2017.dta") fields("val_iinvcu vs_val_iinvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 366 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L367:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 367 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2017.dta") fields("val_iisfov vs_val_iisfov") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L367:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 367 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L368:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 368 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2017.dta") fields("val_iislov vs_val_iislov") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L368:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 368 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L369:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 369 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L369:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 369 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L370:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 370 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L370:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 370 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L371:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 371 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L371:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 371 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L372:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 372 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L372:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 372 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L373:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 373 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2017.dta") fields("val_iisvcu vs_val_iisvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L373:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 373 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L374:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 374 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L374:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 374 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L375:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 375 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikivcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L375:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 375 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L376:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 376 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L376:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 376 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L377:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 377 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L377:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 377 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 378 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2017.dta") fields("val_ikivcu vs_val_ikivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 378 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L379:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 379 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2017.dta") fields("val_iklvcu vs_val_iklvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L379:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 379 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L380:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 380 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2017.dta") fields("val_ikovcu vs_val_ikovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L380:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 380 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L381:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 381 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L381:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 381 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L382:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 382 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L382:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 382 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L383:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 383 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L383:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 383 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L384:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 384 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L384:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 384 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L385:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 385 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2017.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L385:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 385 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L386:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 386 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L386:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 386 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L387:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 387 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_insvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L387:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 387 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L388:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 388 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L388:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 388 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L389:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 389 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L389:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 389 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 390 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2017.dta") fields("val_insvcu vs_val_insvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 390 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L391:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 391 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L391:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 391 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L392:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 392 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_intvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L392:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 392 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L393:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 393 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L393:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 393 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L394:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 394 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L394:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 394 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L395:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 395 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2017.dta") fields("val_intvcu vs_val_intvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L395:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 395 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L396:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 396 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L396:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 396 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L397:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 397 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L397:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 397 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L398:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 398 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L398:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 398 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L399:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 399 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L399:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 399 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 400 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2017.dta") fields("val_iotvcu vs_val_iotvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 400 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L401:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 401 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2017.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L401:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 401 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L402:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 402 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L402:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 402 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L403:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 403 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iprvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L403:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 403 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L404:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 404 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L404:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 404 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L405:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 405 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L405:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 405 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 406 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2017.dta") fields("val_iprvcu vs_val_iprvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 406 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L407:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 407 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L407:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 407 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L408:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 408 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L408:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 408 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L409:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 409 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L409:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 409 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L410:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 410 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L410:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 410 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 411 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2017.dta") fields("val_irdvcu vs_val_irdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 411 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L412:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 412 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2017.dta") fields("val_irevcu vs_val_irevcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L412:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 412 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L413:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 413 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L413:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 413 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L414:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 414 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L414:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 414 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L415:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 415 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L415:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 415 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L416:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 416 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L416:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 416 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L417:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 417 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2017.dta") fields("val_irrvcu vs_val_irrvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L417:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 417 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L418:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 418 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L418:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 418 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L419:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 419 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L419:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 419 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L420:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 420 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L420:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 420 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L421:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 421 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L421:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 421 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L422:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 422 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2017.dta") fields("val_itxvcu vs_val_itxvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L422:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 422 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 423 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2017.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 423 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L424:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 424 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L424:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 424 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L425:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 425 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_nopvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L425:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 425 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L426:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 426 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L426:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 426 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L427:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 427 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L427:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 427 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 428 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2017.dta") fields("val_nopvcu vs_val_nopvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 428 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 429 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2017.dta") fields("val_othvcu vs_val_othvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 429 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L430:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 430 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L430:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 430 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L431:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 431 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L431:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 431 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L432:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 432 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L432:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 432 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L433:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 433 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L433:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 433 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 434 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2017.dta") fields("val_output vs_val_output") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 434 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L435:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 435 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L435:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 435 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L436:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 436 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L436:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 436 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L437:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 437 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L437:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 437 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L438:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 438 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L438:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 438 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 439 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2017.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 439 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L440:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 440 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L440:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 440 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L441:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 441 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_renvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L441:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 441 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L442:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 442 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L442:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 442 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L443:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 443 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L443:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 443 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 444 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2017.dta") fields("val_renvcu vs_val_renvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 444 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L445:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 445 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L445:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 445 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L446:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 446 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L446:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 446 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L447:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 447 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L447:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 447 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L448:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 448 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L448:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 448 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 449 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2017.dta") fields("val_rimvcu vs_val_rimvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 449 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L450:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 450 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L450:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 450 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L451:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 451 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L451:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 451 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L452:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 452 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L452:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 452 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L453:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 453 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L453:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 453 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 454 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2017.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 454 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 455 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2017.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 455 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 456 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2017.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 456 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L457:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 457 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L457:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 457 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L458:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 458 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L458:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 458 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L459:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 459 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L459:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 459 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L460:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 460 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L460:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 460 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 461 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2017.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 461 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 462 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2017.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 462 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L463:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 463 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L463:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 463 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L464:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 464 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L464:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 464 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L465:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 465 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L465:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 465 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L466:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 466 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L466:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 466 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 467 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2017.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 467 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 468 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2017.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 468 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L469:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 469 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L469:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 469 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L470:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 470 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L470:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 470 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L471:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 471 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L471:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 471 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L472:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 472 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L472:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 472 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 473 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2017.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 473 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 474 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2017.dta") fields("val_sfovcu vs_val_sfovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 474 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L475:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 475 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2017.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L475:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 475 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 476 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2017.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 476 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 477 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2017.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 477 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L478:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 478 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L478:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 478 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L479:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 479 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L479:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 479 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L480:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 480 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L480:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 480 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L481:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 481 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L481:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 481 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 482 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2017.dta") fields("val_shdvcu vs_val_shdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 482 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L483:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 483 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L483:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 483 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L484:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 484 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L484:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 484 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L485:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 485 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L485:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 485 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L486:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 486 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L486:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 486 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 487 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2017.dta") fields("val_shfvcu vs_val_shfvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 487 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L488:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 488 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L488:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 488 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L489:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 489 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L489:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 489 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L490:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 490 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L490:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 490 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L491:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 491 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L491:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 491 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 492 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2017.dta") fields("val_shjvcu vs_val_shjvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 492 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L493:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 493 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L493:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 493 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L494:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 494 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L494:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 494 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L495:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 495 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L495:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 495 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L496:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 496 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L496:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 496 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 497 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2017.dta") fields("val_srdvcu vs_val_srdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 497 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L498:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 498 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L498:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 498 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L499:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 499 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L499:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 499 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L500:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 500 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L500:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 500 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L501:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 501 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L501:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 501 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 502 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2017.dta") fields("val_srjvcu vs_val_srjvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 502 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L503:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 503 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L503:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 503 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L504:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 504 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L504:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 504 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L505:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 505 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L505:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 505 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L506:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 506 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L506:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 506 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 507 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2017.dta") fields("val_srmvcu vs_val_srmvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 507 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L508:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 508 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L508:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 508 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L509:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 509 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L509:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 509 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L510:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 510 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L510:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 510 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L511:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 511 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L511:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 511 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 512 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2017.dta") fields("val_stdvcu vs_val_stdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 512 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L513:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 513 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L513:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 513 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L514:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 514 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L514:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 514 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L515:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 515 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L515:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 515 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L516:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 516 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L516:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 516 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 517 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2017.dta") fields("val_stjvcu vs_val_stjvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 517 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L518:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 518 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L518:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 518 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L519:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 519 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L519:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 519 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L520:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 520 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L520:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 520 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L521:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 521 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L521:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 521 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 522 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2017.dta") fields("val_stlvcu vs_val_stlvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 522 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L523:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 523 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L523:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 523 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L524:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 524 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L524:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 524 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L525:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 525 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L525:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 525 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L526:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 526 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L526:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 526 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 527 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2017.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 527 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L528:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 528 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L528:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 528 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L529:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 529 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L529:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 529 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L530:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 530 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L530:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 530 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L531:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 531 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L531:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 531 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 532 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2017.dta") fields("val_yelvcu vs_val_yelvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 532 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L533:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 533 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L533:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 533 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L534:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 534 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L534:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 534 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L535:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 535 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L535:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 535 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L536:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 536 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L536:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 536 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 537 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2017.dta") fields("val_yisvcu vs_val_yisvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 537 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L538:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 538 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L538:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 538 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L539:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 539 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L539:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 539 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L540:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 540 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L540:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 540 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L541:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 541 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L541:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 541 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 542 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2017.dta") fields("val_yisvdo vs_val_yisvdo") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 542 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L543:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 543 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L543:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 543 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L544:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 544 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L544:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 544 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L545:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 545 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L545:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 545 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L546:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 546 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L546:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 546 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 547 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2017.dta") fields("val_yisvfo vs_val_yisvfo") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 547 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 548 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2017.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 548 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 549 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2017.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 549 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L550:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 550 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2017.dta") fields("val_ykivcu vs_val_ykivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L550:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 550 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L551:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 551 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L551:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 551 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L552:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 552 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L552:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 552 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L553:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 553 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L553:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 553 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L554:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 554 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L554:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 554 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 555 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2017.dta") fields("val_yprvcu vs_val_yprvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 555 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L556:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 556 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L556:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 556 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L557:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 557 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L557:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 557 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L558:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 558 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L558:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 558 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L559:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 559 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L559:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 559 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 560 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2017.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 560 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L561:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 561 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2017.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L561:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 561 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 562 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2017.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 562 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L563:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 563 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2017.dta") fields("val_ytovcu vs_val_ytovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L563:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 563 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L564:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 564 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L564:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 564 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L565:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 565 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L565:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 565 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L566:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 566 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L566:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 566 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L567:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 567 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L567:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 567 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L568:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 568 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2017.dta") fields("val_znavcu vs_val_znavcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L568:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 568 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L569:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 569 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L569:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 569 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L570:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 570 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L570:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 570 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L571:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 571 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L571:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 571 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L572:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 572 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L572:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 572 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 573 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2017.dta") fields("val_zndvcu vs_val_zndvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 573 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 574 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2017.dta") fields("val_znevcu vs_val_znevcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 574 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L575:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 575 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2017.dta") fields("val_znhvcu vs_val_znhvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L575:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 575 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L576:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 576 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L576:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 576 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L577:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 577 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L577:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 577 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L578:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 578 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L578:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 578 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L579:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 579 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L579:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 579 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L580:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 580 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2017.dta") fields("val_znivcu vs_val_znivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L580:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 580 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L581:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 581 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L581:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 581 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L582:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 582 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L582:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 582 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L583:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 583 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L583:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 583 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L584:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 584 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L584:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 584 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 585 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2017.dta") fields("val_znovcu vs_val_znovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 585 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L586:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 586 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L586:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 586 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L587:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 587 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L587:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 587 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L588:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 588 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L588:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 588 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L589:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 589 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L589:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 589 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 590 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2017.dta") fields("val_znpvcu vs_val_znpvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 590 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L591:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 591 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2017.dta") fields("val_znrvcu vs_val_znrvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L591:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 591 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L592:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 592 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L592:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 592 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L593:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 593 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L593:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 593 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L594:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 594 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L594:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 594 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L595:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 595 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L595:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 595 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 596 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2017.dta") fields("val_znsvcu vs_val_znsvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 596 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 597 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2017.dta") fields("val_zntvcu vs_val_zntvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 597 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L598:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 598 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L598:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 598 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L599:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 599 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L599:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 599 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L600:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 600 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L600:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 600 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L601:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 601 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L601:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 601 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 602 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2017.dta") fields("val_zpavcu vs_val_zpavcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 602 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L603:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 603 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L603:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 603 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L604:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 604 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L604:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 604 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L605:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 605 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L605:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 605 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L606:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 606 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L606:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 606 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 607 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2017.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 607 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 608 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2017.dta") fields("val_zpevcu vs_val_zpevcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 608 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L609:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 609 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2017.dta") fields("val_zphvcu vs_val_zphvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L609:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 609 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L610:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 610 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L610:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 610 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L611:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 611 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L611:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 611 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L612:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 612 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L612:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 612 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L613:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 613 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L613:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 613 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 614 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2017.dta") fields("val_zpivcu vs_val_zpivcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 614 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L615:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 615 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L615:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 615 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L616:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 616 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L616:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 616 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L617:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 617 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L617:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 617 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L618:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 618 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L618:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 618 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 619 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2017.dta") fields("val_zpovcu vs_val_zpovcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 619 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L620:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 620 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L620:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 620 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L621:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 621 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L621:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 621 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L622:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 622 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L622:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 622 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L623:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 623 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L623:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 623 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 624 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2017.dta") fields("val_zppvcu vs_val_zppvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 624 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L625:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 625 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2017.dta") fields("val_zprvcu vs_val_zprvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L625:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 625 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L626:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 626 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L626:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 626 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L627:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 627 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L627:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 627 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L628:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 628 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L628:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 628 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L629:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 629 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L629:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 629 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 630 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2017.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 630 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L631:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 631 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2017.dta") fields("val_zptvcu vs_val_zptvcu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L631:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 631 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L632:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 632 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L632:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 632 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L633:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 633 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L633:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 633 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L634:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 634 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L634:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 634 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L635:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 635 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L635:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 635 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 636 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2017.dta") fields("value_added_nominal vs_value_added_nominal") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 636 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L637:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 637 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L637:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 637 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L638:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 638 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L638:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 638 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L639:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 639 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L639:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 639 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L640:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 640 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L640:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 640 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L641:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 641 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2017.dta") fields("workers vs_workers") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L641:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 641 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L642:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 642 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L642:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 642 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L643:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 643 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_psid
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L643:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 643 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L644:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 644 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L644:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 644 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L645:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 645 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L645:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 645 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 646 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2017.dta") fields("source_id_raw vs_source_id_raw") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 646 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L647:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 647 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L647:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 647 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L648:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 648 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L648:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 648 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L649:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 649 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L649:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 649 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L650:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 650 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L650:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 650 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 651 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2017.dta") fields("district_code vs_district_code") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 651 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L652:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 652 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L652:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 652 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L653:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 653 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic517
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L653:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 653 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L654:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 654 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L654:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 654 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L655:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 655 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L655:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 655 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 656 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2017.dta") fields("industry_code vs_industry_code") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 656 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L657:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 657 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L657:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 657 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L658:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 658 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L658:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 658 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L659:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 659 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L659:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 659 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L660:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 660 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L660:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 660 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 661 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2017.dta") fields("province_code vs_province_code") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 661 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L662:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 662 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L662:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 662 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L663:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 663 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L663:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 663 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L664:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 664 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L664:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 664 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L665:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 665 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L665:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 665 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 666 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2017.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 666 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L667:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 667 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L667:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 667 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L668:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 668 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L668:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 668 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L669:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 669 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L669:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 669 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L670:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 670 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L670:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 670 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L671:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 671 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2017.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L671:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 671 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L672:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 672 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L672:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 672 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L673:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 673 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L673:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 673 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L674:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 674 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L674:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 674 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L675:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 675 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L675:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 675 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 676 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2017.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 676 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L677:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 677 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L677:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 677 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L678:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 678 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L678:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 678 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L679:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 679 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L679:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 679 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L680:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 680 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L680:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 680 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 681 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2017.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 681 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L682:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 682 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L682:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 682 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L683:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 683 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L683:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 683 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L684:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 684 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L684:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 684 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L685:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 685 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L685:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 685 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L686:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 686 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2017.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L686:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 686 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 687 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2017.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 687 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L688:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 688 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2017.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L688:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 688 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 689 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2017.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 689 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 690 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2017.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 690 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L691:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 691 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L691:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 691 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L692:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 692 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L692:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 692 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L693:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 693 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L693:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 693 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L694:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 694 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L694:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 694 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 695 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2017.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 695 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L696:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 696 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L696:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 696 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L697:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 697 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L697:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 697 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L698:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 698 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L698:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 698 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L699:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 699 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L699:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 699 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 700 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2017.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 700 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L701:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 701 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L701:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 701 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L702:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 702 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L702:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 702 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L703:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 703 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L703:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 703 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L704:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 704 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L704:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 704 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 705 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2017.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 705 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L706:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 706 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L706:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 706 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L707:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 707 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L707:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 707 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L708:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 708 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L708:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 708 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L709:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 709 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L709:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 709 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 710 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2017.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 710 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L711:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 711 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L711:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 711 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L712:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 712 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L712:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 712 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L713:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 713 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L713:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 713 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L714:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 714 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L714:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 714 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 715 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2017.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 715 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L716:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 716 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L716:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 716 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L717:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 717 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L717:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 717 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L718:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 718 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L718:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 718 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L719:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 719 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L719:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 719 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 720 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2017.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 720 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L721:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 721 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2017.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L721:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 721 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 722 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2017.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 722 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L723:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 723 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L723:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 723 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L724:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 724 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L724:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 724 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L725:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 725 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L725:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 725 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L726:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 726 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L726:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 726 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 727 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2017.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 727 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L728:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 728 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L728:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 728 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L729:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 729 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L729:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 729 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L730:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 730 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L730:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 730 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L731:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 731 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L731:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 731 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 732 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2017.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 732 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 733 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2017.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 733 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 734 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2017.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 734 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 735 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2017.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 735 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L736:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 736 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2017.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L736:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 736 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 737 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2017.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 737 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 738 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2017.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 738 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 739 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2017.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 739 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 740 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2017.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 740 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L741:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 741 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L741:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 741 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L742:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 742 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L742:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 742 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L743:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 743 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L743:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 743 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L744:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 744 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L744:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 744 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 745 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2017.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 745 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L746:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 746 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L746:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 746 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L747:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 747 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L747:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 747 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L748:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 748 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L748:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 748 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L749:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 749 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L749:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 749 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 750 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2017.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 750 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L751:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 751 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L751:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 751 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L752:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 752 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L752:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 752 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L753:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 753 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L753:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 753 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L754:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 754 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L754:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 754 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L755:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 755 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2017.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L755:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 755 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L756:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 756 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L756:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 756 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L757:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 757 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L757:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 757 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L758:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 758 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L758:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 758 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L759:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 759 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L759:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 759 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L760:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 760 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2017.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L760:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 760 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L761:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 761 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2017.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L761:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 761 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 762 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2017.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 762 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L763:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 763 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L763:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 763 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L764:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 764 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L764:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 764 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L765:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 765 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L765:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 765 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L766:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 766 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L766:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 766 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L767:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 767 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2017.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L767:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 767 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L768:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 768 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L768:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 768 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L769:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 769 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egom3u17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L769:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 769 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L770:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 770 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L770:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 770 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L771:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 771 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L771:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 771 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L772:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 772 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2017.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L772:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 772 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L773:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 773 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L773:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 773 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L774:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 774 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L774:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 774 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L775:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 775 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L775:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 775 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L776:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 776 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L776:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 776 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L777:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 777 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2017.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L777:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 777 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L778:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 778 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L778:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 778 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L779:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 779 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L779:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 779 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L780:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 780 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L780:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 780 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L781:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 781 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L781:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 781 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L782:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 782 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2017.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L782:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 782 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L783:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 783 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L783:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 783 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L784:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 784 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L784:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 784 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L785:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 785 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L785:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 785 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L786:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 786 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L786:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 786 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L787:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 787 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2017.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L787:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 787 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L788:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 788 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L788:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 788 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L789:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 789 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L789:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 789 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L790:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 790 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L790:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 790 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L791:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 791 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L791:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 791 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L792:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 792 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2017.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L792:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 792 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L793:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 793 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L793:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 793 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L794:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 794 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L794:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 794 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L795:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 795 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L795:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 795 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L796:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 796 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L796:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 796 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L797:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 797 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2017.dta") fields("export_any_binary vs_export_any_binary") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L797:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 797 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L798:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 798 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L798:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 798 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L799:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 799 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L799:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 799 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L800:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 800 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L800:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 800 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L801:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 801 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L801:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 801 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L802:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 802 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2017.dta") fields("export_direct_flag vs_export_direct_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L802:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 802 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L803:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 803 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L803:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 803 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L804:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 804 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L804:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 804 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L805:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 805 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L805:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 805 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L806:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 806 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L806:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 806 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 807 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2017.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 807 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L808:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 808 824 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L808:step-preserve" "code/annual/merge_mapped_2017.do:L1:file" "statement" 808 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L809:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 809 824 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd17
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L809:step-keep" "code/annual/merge_mapped_2017.do:L1:file" "statement" 809 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L810:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 810 824 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2017.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L810:step-cf" "code/annual/merge_mapped_2017.do:L1:file" "statement" 810 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L811:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 811 824 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L811:step-restore" "code/annual/merge_mapped_2017.do:L1:file" "statement" 811 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 812 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2017.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 812 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 813 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2017.dta") fields("innovation_flag vs_innovation_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 813 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 814 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2017.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 814 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L815:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 815 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2017.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L815:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 815 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L816:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 816 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2017.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L816:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 816 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L817:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 817 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2017.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L817:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 817 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L818:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 818 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2017.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L818:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 818 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 819 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2017.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 819 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L820:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 820 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2017.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L820:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 820 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L821:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 821 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2017.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L821:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 821 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L822:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 822 824 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2017.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2017)
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L822:step-wf_merge_guard" "code/annual/merge_mapped_2017.do:L1:file" "statement" 822 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L823:step-isid" "code/annual/merge_mapped_2017.do:L1:file" "statement" 823 824 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L823:step-isid" "code/annual/merge_mapped_2017.do:L1:file" "statement" 823 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2017.do:L824:step-save" "code/annual/merge_mapped_2017.do:L1:file" "statement" 824 824 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2017.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L824:step-save" "code/annual/merge_mapped_2017.do:L1:file" "statement" 824 824 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
