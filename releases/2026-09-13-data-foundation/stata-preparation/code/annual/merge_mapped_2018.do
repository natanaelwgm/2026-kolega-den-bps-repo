* Tujuan: Gabungkan hasil pemetaan kolom tahun 2018 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2018.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2018.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L1:step-do" "code/annual/merge_mapped_2018.do:L1:file" "statement" 1 816 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L1:step-do" "code/annual/merge_mapped_2018.do:L1:file" "statement" 1 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L2:step-do" "code/annual/merge_mapped_2018.do:L1:file" "statement" 2 816 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L2:step-do" "code/annual/merge_mapped_2018.do:L1:file" "statement" 2 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L3:step-use" "code/annual/merge_mapped_2018.do:L1:file" "statement" 3 816 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2018.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L3:step-use" "code/annual/merge_mapped_2018.do:L1:file" "statement" 3 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L4:step-assert" "code/annual/merge_mapped_2018.do:L1:file" "statement" 4 816 `=_rc' // WFLOG-INJECTED
assert source_year==2018
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L4:step-assert" "code/annual/merge_mapped_2018.do:L1:file" "statement" 4 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L5:step-isid" "code/annual/merge_mapped_2018.do:L1:file" "statement" 5 816 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L5:step-isid" "code/annual/merge_mapped_2018.do:L1:file" "statement" 5 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 6 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2018.dta") fields("amdal_raw vs_amdal_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 6 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 7 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2018.dta") fields("b3wste_raw vs_b3wste_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 7 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L8:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 8 816 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L8:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 8 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L9:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 9 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L9:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 9 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L10:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 10 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L10:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 10 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L11:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 11 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L11:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 11 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 12 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2018.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 12 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L13:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 13 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L13:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 13 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L14:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 14 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L14:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 14 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L15:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 15 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L15:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 15 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L16:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 16 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L16:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 16 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 17 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2018.dta") fields("capital_nominal vs_capital_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 17 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L18:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 18 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L18:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 18 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L19:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 19 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L19:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 19 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L20:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 20 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L20:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 20 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L21:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 21 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L21:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 21 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 22 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2018.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 22 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L23:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 23 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L23:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 23 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L24:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 24 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L24:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 24 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L25:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 25 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L25:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 25 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L26:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 26 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L26:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 26 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 27 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2018.dta") fields("export_binary_raw vs_export_binary_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 27 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L28:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 28 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L28:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 28 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L29:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 29 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L29:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 29 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L30:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 30 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L30:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 30 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L31:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 31 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L31:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 31 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 32 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2018.dta") fields("export_share_pct vs_export_share_pct") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 32 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L33:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 33 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L33:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 33 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L34:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 34 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L34:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 34 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L35:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 35 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L35:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 35 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L36:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 36 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L36:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 36 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 37 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2018.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 37 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L38:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 38 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L38:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 38 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L39:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 39 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L39:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 39 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L40:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 40 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L40:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 40 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L41:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 41 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L41:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 41 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 42 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2018.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 42 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L43:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 43 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L43:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 43 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L44:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 44 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L44:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 44 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L45:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 45 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L45:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 45 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L46:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 46 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L46:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 46 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 47 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2018.dta") fields("import_value_nominal vs_import_value_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 47 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L48:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 48 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L48:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 48 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L49:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 49 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inomkt18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L49:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 49 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L50:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 50 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L50:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 50 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L51:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 51 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L51:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 51 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 52 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2018.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 52 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L53:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 53 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L53:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 53 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L54:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 54 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inoorg18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L54:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 54 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L55:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 55 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L55:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 55 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L56:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 56 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L56:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 56 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L57:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 57 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2018.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L57:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 57 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L58:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 58 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L58:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 58 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L59:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 59 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inopcs18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L59:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 59 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L60:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 60 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L60:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 60 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L61:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 61 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L61:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 61 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L62:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 62 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2018.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L62:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 62 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L63:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 63 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L63:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 63 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L64:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 64 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inoprd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L64:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 64 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L65:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 65 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L65:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 65 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L66:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 66 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L66:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 66 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 67 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2018.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 67 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 68 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2018.dta") fields("innovation_raw vs_innovation_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 68 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 69 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2018.dta") fields("inspli_raw vs_inspli_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 69 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L70:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 70 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L70:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 70 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L71:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 71 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L71:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 71 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L72:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 72 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L72:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 72 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L73:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 73 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L73:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 73 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L74:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 74 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2018.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L74:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 74 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 75 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2018.dta") fields("liwste_raw vs_liwste_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 75 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 76 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2018.dta") fields("pplihi_raw vs_pplihi_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 76 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L77:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 77 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L77:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 77 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L78:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 78 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L78:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 78 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L79:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 79 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L79:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 79 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L80:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 80 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L80:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 80 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 81 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2018.dta") fields("production_workers vs_production_workers") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 81 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L82:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 82 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L82:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 82 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L83:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 83 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L83:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 83 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L84:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 84 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L84:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 84 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L85:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 85 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L85:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 85 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 86 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2018.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 86 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L87:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 87 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L87:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 87 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L88:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 88 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L88:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 88 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L89:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 89 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L89:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 89 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L90:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 90 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L90:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 90 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 91 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2018.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 91 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L92:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 92 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L92:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 92 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L93:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 93 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlrnd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L93:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 93 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L94:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 94 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_workers_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L94:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 94 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L95:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 95 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L95:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 95 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 96 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2018.dta") fields("rd_workers vs_rd_workers") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 96 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 97 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2018.dta") fields("sowste_raw vs_sowste_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 97 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 98 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2018.dta") fields("spplhi_raw vs_spplhi_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 98 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L99:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 99 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L99:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 99 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L100:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 100 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L100:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 100 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L101:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 101 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L101:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 101 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L102:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 102 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L102:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 102 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 103 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2018.dta") fields("val_cbdacu vs_val_cbdacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 103 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L104:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 104 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2018.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L104:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 104 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L105:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 105 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L105:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 105 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L106:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 106 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L106:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 106 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L107:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 107 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L107:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 107 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L108:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 108 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L108:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 108 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L109:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 109 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2018.dta") fields("val_cbsacu vs_val_cbsacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L109:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 109 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L110:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 110 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L110:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 110 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L111:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 111 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L111:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 111 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L112:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 112 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L112:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 112 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L113:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 113 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L113:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 113 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L114:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 114 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2018.dta") fields("val_cbttcu vs_val_cbttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L114:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 114 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 115 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2018.dta") fields("val_cldacu vs_val_cldacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 115 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 116 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2018.dta") fields("val_clfpcu vs_val_clfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 116 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L117:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 117 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L117:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 117 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L118:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 118 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L118:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 118 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L119:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 119 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L119:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 119 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L120:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 120 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L120:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 120 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 121 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2018.dta") fields("val_clsacu vs_val_clsacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 121 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L122:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 122 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L122:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 122 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L123:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 123 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L123:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 123 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L124:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 124 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L124:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 124 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L125:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 125 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L125:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 125 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 126 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2018.dta") fields("val_clttcu vs_val_clttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 126 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L127:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 127 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L127:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 127 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L128:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 128 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L128:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 128 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L129:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 129 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L129:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 129 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L130:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 130 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L130:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 130 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 131 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2018.dta") fields("val_cmdacu vs_val_cmdacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 131 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 132 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2018.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 132 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L133:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 133 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L133:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 133 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L134:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 134 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L134:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 134 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L135:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 135 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L135:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 135 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L136:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 136 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L136:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 136 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 137 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2018.dta") fields("val_cmsacu vs_val_cmsacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 137 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L138:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 138 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L138:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 138 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L139:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 139 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L139:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 139 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L140:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 140 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L140:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 140 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L141:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 141 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L141:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 141 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 142 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2018.dta") fields("val_cmttcu vs_val_cmttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 142 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L143:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 143 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L143:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 143 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L144:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 144 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L144:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 144 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L145:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 145 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L145:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 145 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L146:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 146 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L146:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 146 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 147 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2018.dta") fields("val_codacu vs_val_codacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 147 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 148 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2018.dta") fields("val_cofpcu vs_val_cofpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 148 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L149:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 149 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L149:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 149 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L150:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 150 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L150:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 150 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L151:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 151 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L151:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 151 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L152:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 152 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L152:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 152 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L153:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 153 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2018.dta") fields("val_cosacu vs_val_cosacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L153:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 153 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L154:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 154 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L154:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 154 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L155:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 155 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L155:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 155 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L156:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 156 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_costrd_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L156:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 156 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L157:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 157 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L157:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 157 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 158 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2018.dta") fields("val_costrd vs_val_costrd") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L158:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 158 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L159:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 159 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L159:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 159 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L160:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 160 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L160:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 160 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L161:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 161 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L161:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 161 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L162:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 162 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L162:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 162 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L163:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 163 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2018.dta") fields("val_cottcu vs_val_cottcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L163:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 163 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L164:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 164 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2018.dta") fields("val_csdacu vs_val_csdacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L164:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 164 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L165:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 165 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2018.dta") fields("val_csfpcu vs_val_csfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L165:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 165 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L166:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 166 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L166:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 166 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L167:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 167 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cssacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L167:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 167 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L168:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 168 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L168:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 168 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L169:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 169 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L169:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 169 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L170:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 170 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2018.dta") fields("val_cssacu vs_val_cssacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L170:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 170 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L171:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 171 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L171:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 171 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L172:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 172 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L172:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 172 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L173:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 173 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L173:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 173 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L174:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 174 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L174:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 174 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 175 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2018.dta") fields("val_csttcu vs_val_csttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 175 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L176:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 176 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L176:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 176 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L177:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 177 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L177:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 177 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L178:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 178 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L178:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 178 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L179:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 179 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L179:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 179 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 180 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2018.dta") fields("val_ctdacu vs_val_ctdacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 180 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 181 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2018.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 181 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L182:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 182 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L182:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 182 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L183:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 183 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L183:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 183 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L184:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 184 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L184:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 184 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L185:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 185 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L185:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 185 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 186 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2018.dta") fields("val_ctsacu vs_val_ctsacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 186 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 187 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2018.dta") fields("val_cttcu vs_val_cttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 187 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L188:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 188 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L188:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 188 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L189:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 189 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L189:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 189 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L190:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 190 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L190:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 190 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L191:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 191 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L191:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 191 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 192 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2018.dta") fields("val_ctttcu vs_val_ctttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 192 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L193:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 193 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L193:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 193 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L194:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 194 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L194:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 194 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L195:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 195 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L195:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 195 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L196:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 196 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L196:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 196 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 197 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2018.dta") fields("val_cvdacu vs_val_cvdacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 197 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 198 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2018.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 198 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L199:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 199 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L199:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 199 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L200:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 200 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L200:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 200 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L201:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 201 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L201:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 201 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L202:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 202 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L202:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 202 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 203 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2018.dta") fields("val_cvsacu vs_val_cvsacu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 203 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L204:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 204 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L204:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 204 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L205:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 205 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L205:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 205 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L206:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 206 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L206:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 206 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L207:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 207 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L207:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 207 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 208 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2018.dta") fields("val_cvttcu vs_val_cvttcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 208 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L209:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 209 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L209:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 209 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L210:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 210 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_devvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L210:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 210 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L211:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 211 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L211:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 211 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L212:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 212 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L212:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 212 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 213 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2018.dta") fields("val_devvcu vs_val_devvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 213 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 214 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2018.dta") fields("val_ecavce vs_val_ecavce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 214 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 215 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2018.dta") fields("val_ecavcu vs_val_ecavcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 215 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 216 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2018.dta") fields("val_ecbvce vs_val_ecbvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 216 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L217:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 217 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L217:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 217 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L218:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 218 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L218:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 218 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L219:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 219 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L219:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 219 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L220:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 220 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L220:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 220 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 221 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2018.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 221 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L222:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 222 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2018.dta") fields("val_eckvce vs_val_eckvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L222:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 222 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L223:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 223 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2018.dta") fields("val_eckvcu vs_val_eckvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L223:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 223 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L224:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 224 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L224:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 224 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L225:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 225 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L225:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 225 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L226:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 226 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L226:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 226 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L227:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 227 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L227:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 227 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L228:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 228 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2018.dta") fields("val_eclvce vs_val_eclvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L228:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 228 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L229:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 229 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L229:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 229 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L230:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 230 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L230:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 230 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L231:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 231 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L231:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 231 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L232:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 232 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L232:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 232 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L233:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 233 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2018.dta") fields("val_eclvcu vs_val_eclvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L233:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 233 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L234:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 234 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2018.dta") fields("val_edivce vs_val_edivce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L234:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 234 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 235 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2018.dta") fields("val_edivcu vs_val_edivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 235 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 236 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2018.dta") fields("val_efovce vs_val_efovce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 236 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L237:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 237 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2018.dta") fields("val_efovcu vs_val_efovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L237:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 237 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L238:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 238 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L238:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 238 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L239:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 239 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L239:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 239 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L240:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 240 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L240:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 240 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L241:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 241 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L241:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 241 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 242 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2018.dta") fields("val_efuvce vs_val_efuvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 242 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L243:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 243 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L243:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 243 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L244:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 244 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L244:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 244 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L245:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 245 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L245:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 245 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L246:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 246 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L246:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 246 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 247 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2018.dta") fields("val_efuvcu vs_val_efuvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 247 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L248:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 248 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L248:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 248 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L249:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 249 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L249:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 249 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L250:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 250 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L250:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 250 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L251:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 251 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L251:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 251 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 252 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2018.dta") fields("val_egavce vs_val_egavce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 252 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L253:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 253 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L253:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 253 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L254:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 254 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L254:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 254 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L255:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 255 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L255:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 255 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L256:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 256 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L256:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 256 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 257 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2018.dta") fields("val_egavcu vs_val_egavcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 257 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L258:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 258 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L258:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 258 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L259:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 259 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L259:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 259 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L260:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 260 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L260:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 260 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L261:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 261 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L261:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 261 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 262 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2018.dta") fields("val_egovce vs_val_egovce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 262 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L263:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 263 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L263:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 263 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L264:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 264 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L264:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 264 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L265:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 265 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L265:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 265 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L266:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 266 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L266:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 266 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 267 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2018.dta") fields("val_egovcu vs_val_egovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 267 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 268 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2018.dta") fields("val_elpvce vs_val_elpvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 268 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L269:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 269 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L269:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 269 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L270:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 270 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L270:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 270 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L271:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 271 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L271:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 271 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L272:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 272 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L272:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 272 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 273 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2018.dta") fields("val_elpvcu vs_val_elpvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 273 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L274:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 274 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L274:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 274 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L275:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 275 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L275:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 275 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L276:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 276 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L276:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 276 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L277:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 277 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L277:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 277 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 278 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2018.dta") fields("val_eluvce vs_val_eluvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 278 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L279:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 279 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L279:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 279 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L280:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 280 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L280:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 280 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L281:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 281 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L281:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 281 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L282:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 282 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L282:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 282 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 283 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2018.dta") fields("val_eluvcu vs_val_eluvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 283 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 284 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2018.dta") fields("val_encvce vs_val_encvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 284 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L285:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 285 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L285:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 285 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L286:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 286 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L286:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 286 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L287:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 287 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L287:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 287 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L288:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 288 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L288:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 288 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 289 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2018.dta") fields("val_encvcu vs_val_encvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 289 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 290 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2018.dta") fields("val_engvce vs_val_engvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L290:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 290 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L291:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 291 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2018.dta") fields("val_engvcu vs_val_engvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L291:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 291 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L292:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 292 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L292:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 292 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L293:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 293 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L293:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 293 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L294:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 294 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L294:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 294 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L295:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 295 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L295:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 295 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L296:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 296 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2018.dta") fields("val_enpvcu vs_val_enpvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L296:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 296 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 297 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2018.dta") fields("val_eoivce vs_val_eoivce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 297 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L298:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 298 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2018.dta") fields("val_eoivcu vs_val_eoivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L298:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 298 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L299:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 299 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L299:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 299 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L300:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 300 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L300:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 300 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L301:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 301 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L301:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 301 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L302:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 302 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L302:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 302 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L303:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 303 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2018.dta") fields("val_epevce vs_val_epevce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L303:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 303 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L304:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 304 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L304:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 304 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L305:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 305 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L305:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 305 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L306:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 306 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L306:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 306 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L307:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 307 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L307:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 307 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L308:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 308 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2018.dta") fields("val_epevcu vs_val_epevcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L308:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 308 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L309:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 309 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L309:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 309 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L310:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 310 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L310:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 310 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L311:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 311 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L311:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 311 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L312:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 312 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L312:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 312 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 313 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2018.dta") fields("val_eplvcu vs_val_eplvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L313:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 313 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 314 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2018.dta") fields("val_esdvce vs_val_esdvce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L314:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 314 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 315 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2018.dta") fields("val_esdvcu vs_val_esdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 315 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L316:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 316 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L316:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 316 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L317:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 317 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L317:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 317 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L318:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 318 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L318:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 318 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L319:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 319 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L319:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 319 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 320 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2018.dta") fields("val_esovce vs_val_esovce") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 320 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L321:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 321 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L321:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 321 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L322:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 322 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L322:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 322 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L323:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 323 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L323:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 323 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L324:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 324 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L324:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 324 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 325 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2018.dta") fields("val_esovcu vs_val_esovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 325 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L326:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 326 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L326:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 326 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L327:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 327 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L327:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 327 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L328:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 328 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L328:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 328 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L329:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 329 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L329:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 329 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 330 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2018.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L330:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 330 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L331:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 331 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L331:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 331 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L332:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 332 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L332:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 332 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L333:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 333 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L333:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 333 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L334:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 334 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L334:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 334 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 335 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2018.dta") fields("val_icovcu vs_val_icovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 335 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L336:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 336 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L336:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 336 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L337:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 337 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_idevcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L337:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 337 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L338:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 338 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L338:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 338 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L339:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 339 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L339:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 339 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L340:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 340 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2018.dta") fields("val_idevcu vs_val_idevcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L340:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 340 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L341:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 341 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L341:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 341 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L342:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 342 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L342:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 342 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L343:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 343 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L343:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 343 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L344:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 344 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L344:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 344 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L345:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 345 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2018.dta") fields("val_iinput vs_val_iinput") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L345:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 345 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L346:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 346 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L346:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 346 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L347:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 347 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L347:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 347 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L348:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 348 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L348:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 348 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L349:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 349 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L349:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 349 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 350 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2018.dta") fields("val_iinvcu vs_val_iinvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 350 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L351:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 351 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L351:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 351 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L352:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 352 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisfov18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L352:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 352 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L353:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 353 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L353:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 353 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L354:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 354 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L354:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 354 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L355:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 355 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2018.dta") fields("val_iisfov vs_val_iisfov") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L355:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 355 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L356:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 356 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L356:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 356 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L357:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 357 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iislov18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L357:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 357 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L358:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 358 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iislov_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L358:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 358 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L359:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 359 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L359:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 359 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 360 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2018.dta") fields("val_iislov vs_val_iislov") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 360 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L361:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 361 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L361:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 361 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L362:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 362 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L362:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 362 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L363:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 363 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L363:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 363 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L364:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 364 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L364:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 364 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 365 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2018.dta") fields("val_iisvcu vs_val_iisvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 365 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L366:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 366 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L366:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 366 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L367:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 367 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikivcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L367:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 367 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L368:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 368 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L368:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 368 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L369:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 369 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L369:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 369 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 370 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2018.dta") fields("val_ikivcu vs_val_ikivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 370 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 371 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2018.dta") fields("val_iklvcu vs_val_iklvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 371 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 372 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2018.dta") fields("val_ikovcu vs_val_ikovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 372 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L373:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 373 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L373:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 373 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L374:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 374 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L374:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 374 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L375:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 375 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L375:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 375 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L376:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 376 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L376:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 376 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 377 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2018.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 377 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L378:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 378 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L378:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 378 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L379:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 379 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_insvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L379:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 379 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L380:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 380 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L380:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 380 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L381:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 381 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L381:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 381 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L382:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 382 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2018.dta") fields("val_insvcu vs_val_insvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L382:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 382 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L383:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 383 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L383:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 383 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L384:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 384 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_intvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L384:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 384 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L385:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 385 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L385:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 385 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L386:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 386 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L386:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 386 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 387 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2018.dta") fields("val_intvcu vs_val_intvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 387 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L388:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 388 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L388:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 388 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L389:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 389 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L389:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 389 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L390:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 390 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L390:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 390 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L391:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 391 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L391:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 391 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 392 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2018.dta") fields("val_iotvcu vs_val_iotvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 392 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 393 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2018.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 393 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L394:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 394 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L394:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 394 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L395:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 395 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iprvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L395:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 395 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L396:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 396 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L396:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 396 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L397:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 397 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L397:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 397 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 398 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2018.dta") fields("val_iprvcu vs_val_iprvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 398 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L399:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 399 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L399:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 399 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L400:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 400 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L400:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 400 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L401:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 401 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L401:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 401 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L402:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 402 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L402:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 402 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 403 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2018.dta") fields("val_irdvcu vs_val_irdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 403 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 404 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2018.dta") fields("val_irevcu vs_val_irevcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 404 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L405:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 405 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L405:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 405 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L406:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 406 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L406:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 406 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L407:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 407 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L407:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 407 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L408:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 408 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L408:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 408 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 409 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2018.dta") fields("val_irrvcu vs_val_irrvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 409 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L410:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 410 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L410:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 410 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L411:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 411 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L411:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 411 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L412:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 412 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L412:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 412 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L413:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 413 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L413:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 413 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 414 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2018.dta") fields("val_itxvcu vs_val_itxvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 414 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L415:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 415 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2018.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L415:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 415 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L416:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 416 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L416:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 416 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L417:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 417 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_nopvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L417:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 417 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L418:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 418 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L418:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 418 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L419:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 419 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L419:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 419 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L420:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 420 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2018.dta") fields("val_nopvcu vs_val_nopvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L420:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 420 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L421:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 421 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2018.dta") fields("val_othvcu vs_val_othvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L421:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 421 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L422:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 422 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L422:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 422 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L423:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 423 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L423:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 423 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L424:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 424 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L424:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 424 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L425:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 425 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L425:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 425 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L426:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 426 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2018.dta") fields("val_output vs_val_output") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L426:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 426 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L427:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 427 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L427:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 427 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L428:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 428 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L428:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 428 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L429:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 429 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L429:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 429 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L430:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 430 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L430:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 430 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L431:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 431 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2018.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L431:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 431 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L432:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 432 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L432:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 432 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L433:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 433 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_renvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L433:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 433 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L434:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 434 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L434:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 434 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L435:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 435 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L435:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 435 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L436:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 436 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2018.dta") fields("val_renvcu vs_val_renvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L436:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 436 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L437:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 437 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L437:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 437 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L438:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 438 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L438:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 438 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L439:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 439 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L439:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 439 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L440:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 440 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L440:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 440 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L441:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 441 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2018.dta") fields("val_rimvcu vs_val_rimvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L441:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 441 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L442:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 442 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L442:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 442 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L443:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 443 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L443:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 443 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L444:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 444 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L444:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 444 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L445:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 445 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L445:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 445 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L446:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 446 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2018.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L446:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 446 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L447:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 447 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2018.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L447:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 447 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 448 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2018.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 448 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L449:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 449 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L449:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 449 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L450:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 450 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L450:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 450 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L451:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 451 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L451:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 451 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L452:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 452 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L452:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 452 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 453 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2018.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 453 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 454 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2018.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 454 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L455:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 455 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L455:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 455 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L456:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 456 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L456:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 456 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L457:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 457 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L457:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 457 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L458:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 458 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L458:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 458 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 459 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2018.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 459 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L460:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 460 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2018.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L460:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 460 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L461:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 461 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L461:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 461 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L462:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 462 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L462:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 462 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L463:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 463 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L463:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 463 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L464:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 464 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L464:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 464 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L465:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 465 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2018.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L465:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 465 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L466:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 466 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2018.dta") fields("val_sfovcu vs_val_sfovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L466:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 466 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 467 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2018.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 467 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 468 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2018.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 468 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 469 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2018.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 469 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L470:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 470 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L470:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 470 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L471:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 471 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L471:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 471 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L472:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 472 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L472:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 472 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L473:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 473 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L473:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 473 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 474 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2018.dta") fields("val_shdvcu vs_val_shdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 474 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L475:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 475 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L475:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 475 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L476:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 476 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L476:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 476 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L477:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 477 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L477:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 477 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L478:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 478 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L478:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 478 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 479 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2018.dta") fields("val_shfvcu vs_val_shfvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 479 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L480:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 480 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L480:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 480 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L481:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 481 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L481:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 481 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L482:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 482 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L482:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 482 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L483:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 483 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L483:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 483 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 484 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2018.dta") fields("val_shjvcu vs_val_shjvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 484 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L485:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 485 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L485:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 485 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L486:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 486 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L486:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 486 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L487:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 487 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L487:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 487 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L488:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 488 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L488:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 488 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L489:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 489 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2018.dta") fields("val_srdvcu vs_val_srdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L489:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 489 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L490:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 490 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L490:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 490 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L491:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 491 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L491:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 491 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L492:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 492 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L492:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 492 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L493:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 493 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L493:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 493 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 494 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2018.dta") fields("val_srjvcu vs_val_srjvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 494 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L495:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 495 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L495:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 495 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L496:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 496 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L496:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 496 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L497:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 497 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L497:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 497 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L498:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 498 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L498:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 498 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 499 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2018.dta") fields("val_srmvcu vs_val_srmvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 499 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L500:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 500 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L500:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 500 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L501:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 501 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L501:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 501 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L502:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 502 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L502:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 502 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L503:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 503 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L503:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 503 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 504 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2018.dta") fields("val_stdvcu vs_val_stdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 504 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L505:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 505 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L505:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 505 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L506:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 506 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L506:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 506 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L507:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 507 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L507:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 507 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L508:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 508 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L508:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 508 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 509 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2018.dta") fields("val_stjvcu vs_val_stjvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 509 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L510:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 510 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L510:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 510 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L511:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 511 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L511:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 511 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L512:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 512 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L512:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 512 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L513:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 513 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L513:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 513 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 514 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2018.dta") fields("val_stlvcu vs_val_stlvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 514 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L515:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 515 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L515:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 515 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L516:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 516 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L516:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 516 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L517:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 517 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L517:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 517 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L518:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 518 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L518:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 518 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L519:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 519 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2018.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L519:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 519 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L520:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 520 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L520:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 520 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L521:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 521 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L521:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 521 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L522:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 522 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L522:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 522 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L523:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 523 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L523:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 523 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L524:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 524 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2018.dta") fields("val_yelvcu vs_val_yelvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L524:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 524 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L525:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 525 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L525:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 525 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L526:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 526 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L526:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 526 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L527:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 527 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L527:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 527 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L528:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 528 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L528:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 528 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 529 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2018.dta") fields("val_yisvcu vs_val_yisvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 529 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L530:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 530 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L530:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 530 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L531:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 531 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L531:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 531 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L532:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 532 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L532:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 532 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L533:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 533 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L533:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 533 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 534 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2018.dta") fields("val_yisvdo vs_val_yisvdo") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 534 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L535:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 535 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L535:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 535 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L536:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 536 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L536:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 536 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L537:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 537 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L537:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 537 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L538:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 538 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L538:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 538 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 539 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2018.dta") fields("val_yisvfo vs_val_yisvfo") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 539 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L540:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 540 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2018.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L540:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 540 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 541 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2018.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 541 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 542 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2018.dta") fields("val_ykivcu vs_val_ykivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 542 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L543:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 543 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L543:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 543 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L544:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 544 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L544:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 544 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L545:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 545 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L545:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 545 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L546:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 546 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L546:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 546 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 547 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2018.dta") fields("val_yprvcu vs_val_yprvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 547 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L548:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 548 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L548:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 548 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L549:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 549 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L549:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 549 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L550:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 550 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L550:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 550 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L551:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 551 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L551:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 551 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 552 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2018.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 552 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L553:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 553 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2018.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L553:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 553 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 554 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2018.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 554 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 555 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2018.dta") fields("val_ytovcu vs_val_ytovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 555 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L556:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 556 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L556:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 556 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L557:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 557 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L557:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 557 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L558:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 558 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L558:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 558 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L559:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 559 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L559:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 559 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 560 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2018.dta") fields("val_znavcu vs_val_znavcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 560 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L561:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 561 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L561:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 561 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L562:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 562 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L562:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 562 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L563:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 563 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L563:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 563 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L564:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 564 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L564:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 564 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 565 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2018.dta") fields("val_zndvcu vs_val_zndvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 565 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L566:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 566 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2018.dta") fields("val_znevcu vs_val_znevcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L566:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 566 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 567 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2018.dta") fields("val_znhvcu vs_val_znhvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 567 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L568:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 568 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L568:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 568 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L569:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 569 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L569:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 569 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L570:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 570 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L570:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 570 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L571:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 571 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L571:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 571 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 572 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2018.dta") fields("val_znivcu vs_val_znivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 572 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L573:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 573 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L573:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 573 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L574:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 574 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L574:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 574 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L575:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 575 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L575:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 575 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L576:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 576 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L576:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 576 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 577 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2018.dta") fields("val_znovcu vs_val_znovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 577 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L578:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 578 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L578:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 578 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L579:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 579 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L579:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 579 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L580:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 580 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L580:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 580 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L581:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 581 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L581:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 581 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 582 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2018.dta") fields("val_znpvcu vs_val_znpvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 582 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 583 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2018.dta") fields("val_znrvcu vs_val_znrvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 583 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L584:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 584 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L584:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 584 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L585:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 585 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L585:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 585 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L586:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 586 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L586:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 586 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L587:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 587 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L587:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 587 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 588 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2018.dta") fields("val_znsvcu vs_val_znsvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 588 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 589 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2018.dta") fields("val_zntvcu vs_val_zntvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 589 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L590:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 590 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L590:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 590 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L591:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 591 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L591:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 591 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L592:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 592 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L592:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 592 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L593:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 593 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L593:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 593 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 594 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2018.dta") fields("val_zpavcu vs_val_zpavcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 594 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L595:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 595 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L595:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 595 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L596:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 596 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L596:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 596 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L597:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 597 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L597:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 597 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L598:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 598 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L598:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 598 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 599 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2018.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 599 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 600 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2018.dta") fields("val_zpevcu vs_val_zpevcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 600 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L601:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 601 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2018.dta") fields("val_zphvcu vs_val_zphvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L601:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 601 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L602:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 602 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L602:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 602 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L603:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 603 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L603:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 603 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L604:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 604 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L604:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 604 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L605:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 605 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L605:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 605 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L606:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 606 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2018.dta") fields("val_zpivcu vs_val_zpivcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L606:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 606 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L607:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 607 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L607:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 607 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L608:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 608 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L608:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 608 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L609:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 609 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L609:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 609 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L610:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 610 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L610:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 610 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L611:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 611 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2018.dta") fields("val_zpovcu vs_val_zpovcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L611:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 611 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L612:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 612 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L612:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 612 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L613:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 613 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L613:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 613 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L614:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 614 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L614:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 614 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L615:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 615 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L615:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 615 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L616:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 616 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2018.dta") fields("val_zppvcu vs_val_zppvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L616:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 616 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L617:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 617 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2018.dta") fields("val_zprvcu vs_val_zprvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L617:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 617 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L618:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 618 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L618:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 618 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L619:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 619 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L619:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 619 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L620:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 620 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L620:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 620 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L621:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 621 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L621:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 621 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 622 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2018.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 622 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L623:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 623 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2018.dta") fields("val_zptvcu vs_val_zptvcu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L623:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 623 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L624:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 624 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L624:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 624 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L625:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 625 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L625:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 625 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L626:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 626 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L626:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 626 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L627:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 627 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L627:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 627 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 628 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2018.dta") fields("value_added_nominal vs_value_added_nominal") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 628 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L629:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 629 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L629:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 629 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L630:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 630 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L630:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 630 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L631:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 631 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L631:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 631 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L632:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 632 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L632:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 632 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 633 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2018.dta") fields("workers vs_workers") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 633 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L634:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 634 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L634:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 634 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L635:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 635 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L635:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 635 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L636:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 636 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L636:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 636 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L637:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 637 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L637:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 637 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 638 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2018.dta") fields("source_id_raw vs_source_id_raw") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 638 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L639:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 639 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L639:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 639 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L640:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 640 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L640:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 640 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L641:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 641 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L641:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 641 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L642:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 642 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L642:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 642 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 643 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2018.dta") fields("district_code vs_district_code") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 643 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L644:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 644 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L644:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 644 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L645:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 645 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic518
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L645:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 645 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L646:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 646 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L646:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 646 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L647:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 647 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L647:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 647 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 648 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2018.dta") fields("industry_code vs_industry_code") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 648 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L649:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 649 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L649:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 649 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L650:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 650 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L650:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 650 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L651:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 651 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L651:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 651 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L652:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 652 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L652:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 652 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 653 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2018.dta") fields("province_code vs_province_code") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 653 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L654:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 654 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L654:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 654 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L655:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 655 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L655:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 655 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L656:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 656 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L656:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 656 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L657:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 657 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L657:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 657 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 658 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2018.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 658 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L659:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 659 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L659:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 659 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L660:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 660 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L660:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 660 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L661:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 661 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L661:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 661 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L662:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 662 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L662:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 662 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 663 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2018.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 663 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L664:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 664 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L664:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 664 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L665:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 665 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L665:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 665 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L666:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 666 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L666:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 666 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L667:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 667 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L667:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 667 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 668 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2018.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 668 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L669:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 669 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L669:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 669 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L670:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 670 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L670:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 670 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L671:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 671 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L671:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 671 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L672:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 672 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L672:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 672 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 673 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2018.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 673 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L674:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 674 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L674:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 674 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L675:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 675 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L675:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 675 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L676:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 676 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L676:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 676 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L677:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 677 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L677:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 677 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L678:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 678 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2018.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L678:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 678 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L679:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 679 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2018.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L679:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 679 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L680:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 680 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2018.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L680:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 680 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 681 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2018.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 681 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 682 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2018.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 682 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L683:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 683 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L683:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 683 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L684:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 684 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L684:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 684 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L685:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 685 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L685:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 685 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L686:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 686 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L686:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 686 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 687 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2018.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 687 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L688:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 688 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L688:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 688 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L689:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 689 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L689:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 689 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L690:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 690 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L690:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 690 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L691:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 691 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L691:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 691 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 692 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2018.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 692 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L693:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 693 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L693:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 693 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L694:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 694 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L694:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 694 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L695:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 695 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L695:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 695 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L696:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 696 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L696:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 696 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 697 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2018.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 697 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L698:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 698 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L698:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 698 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L699:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 699 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L699:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 699 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L700:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 700 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L700:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 700 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L701:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 701 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L701:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 701 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 702 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2018.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 702 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L703:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 703 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L703:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 703 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L704:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 704 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L704:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 704 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L705:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 705 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L705:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 705 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L706:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 706 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L706:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 706 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 707 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2018.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 707 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L708:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 708 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L708:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 708 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L709:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 709 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L709:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 709 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L710:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 710 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L710:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 710 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L711:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 711 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L711:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 711 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 712 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2018.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 712 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 713 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2018.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 713 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 714 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2018.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 714 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L715:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 715 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L715:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 715 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L716:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 716 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L716:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 716 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L717:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 717 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L717:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 717 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L718:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 718 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L718:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 718 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 719 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2018.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 719 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L720:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 720 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L720:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 720 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L721:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 721 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L721:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 721 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L722:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 722 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L722:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 722 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L723:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 723 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L723:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 723 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L724:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 724 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2018.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L724:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 724 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L725:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 725 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2018.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L725:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 725 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L726:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 726 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2018.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L726:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 726 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 727 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2018.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 727 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L728:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 728 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2018.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L728:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 728 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L729:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 729 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2018.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L729:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 729 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L730:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 730 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2018.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L730:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 730 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L731:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 731 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2018.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L731:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 731 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 732 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2018.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 732 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L733:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 733 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L733:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 733 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L734:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 734 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L734:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 734 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L735:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 735 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L735:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 735 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L736:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 736 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L736:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 736 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 737 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2018.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 737 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L738:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 738 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L738:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 738 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L739:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 739 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L739:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 739 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L740:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 740 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L740:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 740 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L741:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 741 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L741:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 741 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 742 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2018.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 742 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L743:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 743 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L743:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 743 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L744:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 744 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L744:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 744 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L745:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 745 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L745:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 745 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L746:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 746 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L746:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 746 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 747 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2018.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 747 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L748:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 748 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L748:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 748 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L749:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 749 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L749:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 749 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L750:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 750 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L750:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 750 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L751:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 751 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L751:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 751 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 752 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2018.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 752 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 753 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2018.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 753 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L754:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 754 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2018.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L754:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 754 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L755:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 755 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L755:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 755 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L756:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 756 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L756:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 756 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L757:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 757 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L757:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 757 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L758:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 758 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L758:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 758 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L759:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 759 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2018.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L759:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 759 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L760:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 760 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L760:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 760 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L761:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 761 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egom3u18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L761:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 761 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L762:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 762 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L762:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 762 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L763:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 763 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L763:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 763 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L764:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 764 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2018.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L764:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 764 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L765:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 765 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L765:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 765 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L766:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 766 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L766:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 766 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L767:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 767 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L767:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 767 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L768:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 768 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L768:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 768 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L769:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 769 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2018.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L769:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 769 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L770:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 770 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L770:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 770 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L771:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 771 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L771:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 771 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L772:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 772 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L772:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 772 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L773:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 773 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L773:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 773 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 774 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2018.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 774 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L775:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 775 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L775:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 775 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L776:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 776 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L776:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 776 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L777:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 777 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L777:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 777 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L778:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 778 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L778:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 778 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 779 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2018.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 779 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L780:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 780 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L780:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 780 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L781:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 781 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L781:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 781 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L782:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 782 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L782:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 782 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L783:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 783 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L783:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 783 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 784 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2018.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 784 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L785:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 785 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L785:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 785 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L786:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 786 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L786:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 786 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L787:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 787 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L787:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 787 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L788:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 788 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L788:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 788 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L789:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 789 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2018.dta") fields("export_any_binary vs_export_any_binary") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L789:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 789 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L790:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 790 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L790:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 790 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L791:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 791 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L791:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 791 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L792:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 792 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L792:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 792 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L793:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 793 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L793:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 793 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L794:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 794 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2018.dta") fields("export_direct_flag vs_export_direct_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L794:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 794 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L795:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 795 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L795:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 795 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L796:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 796 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L796:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 796 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L797:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 797 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L797:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 797 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L798:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 798 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L798:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 798 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L799:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 799 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2018.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L799:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 799 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L800:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 800 816 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L800:step-preserve" "code/annual/merge_mapped_2018.do:L1:file" "statement" 800 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L801:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 801 816 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd18
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L801:step-keep" "code/annual/merge_mapped_2018.do:L1:file" "statement" 801 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L802:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 802 816 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2018.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L802:step-cf" "code/annual/merge_mapped_2018.do:L1:file" "statement" 802 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L803:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 803 816 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L803:step-restore" "code/annual/merge_mapped_2018.do:L1:file" "statement" 803 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L804:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 804 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2018.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L804:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 804 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L805:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 805 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2018.dta") fields("innovation_flag vs_innovation_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L805:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 805 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L806:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 806 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2018.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L806:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 806 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 807 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2018.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 807 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L808:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 808 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2018.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L808:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 808 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L809:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 809 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2018.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L809:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 809 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L810:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 810 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2018.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L810:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 810 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L811:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 811 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2018.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L811:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 811 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 812 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2018.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 812 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 813 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2018.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 813 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 814 816 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2018.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2018)
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2018.do:L1:file" "statement" 814 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L815:step-isid" "code/annual/merge_mapped_2018.do:L1:file" "statement" 815 816 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L815:step-isid" "code/annual/merge_mapped_2018.do:L1:file" "statement" 815 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2018.do:L816:step-save" "code/annual/merge_mapped_2018.do:L1:file" "statement" 816 816 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2018.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L816:step-save" "code/annual/merge_mapped_2018.do:L1:file" "statement" 816 816 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
