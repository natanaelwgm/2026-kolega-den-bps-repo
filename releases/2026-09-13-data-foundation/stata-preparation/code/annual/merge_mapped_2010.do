* Tujuan: Gabungkan hasil pemetaan kolom tahun 2010 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2010.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2010.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L1:step-do" "code/annual/merge_mapped_2010.do:L1:file" "statement" 1 716 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L1:step-do" "code/annual/merge_mapped_2010.do:L1:file" "statement" 1 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L2:step-do" "code/annual/merge_mapped_2010.do:L1:file" "statement" 2 716 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L2:step-do" "code/annual/merge_mapped_2010.do:L1:file" "statement" 2 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L3:step-use" "code/annual/merge_mapped_2010.do:L1:file" "statement" 3 716 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2010.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L3:step-use" "code/annual/merge_mapped_2010.do:L1:file" "statement" 3 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L4:step-assert" "code/annual/merge_mapped_2010.do:L1:file" "statement" 4 716 `=_rc' // WFLOG-INJECTED
assert source_year==2010
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L4:step-assert" "code/annual/merge_mapped_2010.do:L1:file" "statement" 4 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L5:step-isid" "code/annual/merge_mapped_2010.do:L1:file" "statement" 5 716 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L5:step-isid" "code/annual/merge_mapped_2010.do:L1:file" "statement" 5 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 6 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2010.dta") fields("amdal_raw vs_amdal_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 6 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 7 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2010.dta") fields("b3wste_raw vs_b3wste_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 7 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L8:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 8 716 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L8:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 8 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L9:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 9 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L9:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 9 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L10:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 10 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L10:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 10 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L11:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 11 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L11:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 11 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 12 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2010.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 12 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L13:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 13 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L13:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 13 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L14:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 14 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L14:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 14 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L15:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 15 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L15:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 15 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L16:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 16 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L16:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 16 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 17 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2010.dta") fields("capital_nominal vs_capital_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 17 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L18:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 18 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L18:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 18 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L19:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 19 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L19:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 19 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L20:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 20 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L20:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 20 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L21:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 21 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L21:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 21 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 22 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2010.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 22 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L23:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 23 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L23:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 23 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L24:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 24 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L24:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 24 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L25:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 25 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L25:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 25 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L26:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 26 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L26:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 26 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 27 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2010.dta") fields("export_binary_raw vs_export_binary_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 27 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L28:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 28 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L28:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 28 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L29:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 29 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L29:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 29 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L30:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 30 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L30:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 30 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L31:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 31 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L31:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 31 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 32 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2010.dta") fields("export_share_pct vs_export_share_pct") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 32 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L33:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 33 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L33:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 33 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L34:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 34 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L34:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 34 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L35:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 35 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L35:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 35 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L36:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 36 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L36:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 36 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 37 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2010.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 37 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L38:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 38 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L38:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 38 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L39:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 39 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L39:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 39 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L40:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 40 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L40:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 40 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L41:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 41 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L41:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 41 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 42 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2010.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 42 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L43:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 43 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L43:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 43 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L44:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 44 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L44:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 44 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L45:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 45 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L45:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 45 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L46:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 46 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L46:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 46 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 47 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2010.dta") fields("import_value_nominal vs_import_value_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 47 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 48 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2010.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 48 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 49 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2010.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 49 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 50 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2010.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 50 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 51 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2010.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 51 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 52 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2010.dta") fields("innovation_raw vs_innovation_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 52 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 53 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2010.dta") fields("inspli_raw vs_inspli_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 53 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L54:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 54 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L54:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 54 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L55:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 55 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L55:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 55 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L56:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 56 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L56:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 56 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L57:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 57 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L57:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 57 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 58 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2010.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 58 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 59 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2010.dta") fields("liwste_raw vs_liwste_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 59 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 60 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2010.dta") fields("pplihi_raw vs_pplihi_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 60 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L61:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 61 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L61:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 61 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L62:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 62 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L62:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 62 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L63:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 63 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L63:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 63 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L64:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 64 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L64:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 64 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 65 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2010.dta") fields("production_workers vs_production_workers") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 65 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 66 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2010.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 66 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 67 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2010.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 67 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 68 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2010.dta") fields("rd_workers vs_rd_workers") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 68 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 69 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2010.dta") fields("sowste_raw vs_sowste_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 69 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 70 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2010.dta") fields("spplhi_raw vs_spplhi_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 70 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L71:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 71 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L71:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 71 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L72:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 72 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L72:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 72 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L73:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 73 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L73:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 73 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L74:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 74 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L74:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 74 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 75 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2010.dta") fields("val_cbdacu vs_val_cbdacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 75 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 76 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2010.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 76 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L77:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 77 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L77:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 77 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L78:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 78 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L78:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 78 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L79:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 79 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L79:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 79 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L80:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 80 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L80:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 80 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 81 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2010.dta") fields("val_cbsacu vs_val_cbsacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 81 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L82:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 82 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L82:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 82 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L83:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 83 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L83:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 83 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L84:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 84 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L84:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 84 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L85:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 85 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L85:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 85 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 86 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2010.dta") fields("val_cbttcu vs_val_cbttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 86 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L87:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 87 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L87:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 87 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L88:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 88 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cldacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L88:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 88 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L89:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 89 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L89:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 89 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L90:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 90 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L90:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 90 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 91 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2010.dta") fields("val_cldacu vs_val_cldacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 91 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 92 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2010.dta") fields("val_clfpcu vs_val_clfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 92 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L93:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 93 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L93:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 93 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L94:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 94 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L94:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 94 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L95:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 95 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L95:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 95 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L96:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 96 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L96:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 96 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 97 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2010.dta") fields("val_clsacu vs_val_clsacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 97 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L98:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 98 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L98:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 98 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L99:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 99 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L99:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 99 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L100:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 100 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L100:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 100 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L101:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 101 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L101:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 101 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 102 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2010.dta") fields("val_clttcu vs_val_clttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 102 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L103:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 103 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L103:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 103 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L104:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 104 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L104:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 104 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L105:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 105 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L105:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 105 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L106:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 106 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L106:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 106 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 107 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2010.dta") fields("val_cmdacu vs_val_cmdacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 107 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 108 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2010.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 108 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L109:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 109 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L109:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 109 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L110:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 110 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L110:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 110 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L111:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 111 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L111:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 111 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L112:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 112 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L112:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 112 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 113 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2010.dta") fields("val_cmsacu vs_val_cmsacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 113 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L114:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 114 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L114:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 114 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L115:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 115 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L115:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 115 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L116:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 116 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L116:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 116 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L117:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 117 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L117:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 117 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 118 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2010.dta") fields("val_cmttcu vs_val_cmttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 118 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L119:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 119 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L119:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 119 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L120:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 120 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L120:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 120 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L121:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 121 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L121:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 121 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L122:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 122 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L122:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 122 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 123 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2010.dta") fields("val_codacu vs_val_codacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 123 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 124 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2010.dta") fields("val_cofpcu vs_val_cofpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 124 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L125:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 125 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L125:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 125 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L126:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 126 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L126:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 126 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L127:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 127 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L127:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 127 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L128:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 128 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L128:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 128 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 129 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2010.dta") fields("val_cosacu vs_val_cosacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 129 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 130 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2010.dta") fields("val_costrd vs_val_costrd") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 130 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L131:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 131 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L131:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 131 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L132:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 132 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L132:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 132 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L133:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 133 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L133:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 133 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L134:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 134 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L134:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 134 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 135 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2010.dta") fields("val_cottcu vs_val_cottcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 135 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 136 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2010.dta") fields("val_csdacu vs_val_csdacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 136 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 137 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2010.dta") fields("val_csfpcu vs_val_csfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 137 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 138 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2010.dta") fields("val_cssacu vs_val_cssacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 138 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 139 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2010.dta") fields("val_csttcu vs_val_csttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 139 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L140:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 140 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L140:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 140 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L141:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 141 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L141:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 141 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L142:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 142 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L142:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 142 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L143:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 143 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L143:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 143 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 144 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2010.dta") fields("val_ctdacu vs_val_ctdacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 144 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 145 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2010.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 145 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L146:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 146 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L146:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 146 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L147:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 147 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L147:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 147 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L148:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 148 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L148:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 148 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L149:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 149 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L149:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 149 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 150 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2010.dta") fields("val_ctsacu vs_val_ctsacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 150 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 151 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2010.dta") fields("val_cttcu vs_val_cttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 151 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L152:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 152 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L152:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 152 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L153:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 153 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L153:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 153 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L154:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 154 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L154:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 154 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L155:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 155 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L155:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 155 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 156 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2010.dta") fields("val_ctttcu vs_val_ctttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 156 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L157:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 157 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L157:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 157 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L158:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 158 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L158:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 158 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L159:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 159 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L159:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 159 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L160:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 160 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L160:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 160 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 161 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2010.dta") fields("val_cvdacu vs_val_cvdacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 161 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 162 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2010.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 162 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L163:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 163 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L163:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 163 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L164:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 164 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L164:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 164 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L165:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 165 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L165:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 165 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L166:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 166 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L166:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 166 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 167 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2010.dta") fields("val_cvsacu vs_val_cvsacu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 167 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L168:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 168 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L168:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 168 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L169:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 169 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L169:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 169 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L170:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 170 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L170:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 170 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L171:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 171 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L171:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 171 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 172 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2010.dta") fields("val_cvttcu vs_val_cvttcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 172 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 173 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2010.dta") fields("val_devvcu vs_val_devvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 173 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 174 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2010.dta") fields("val_ecavce vs_val_ecavce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 174 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 175 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2010.dta") fields("val_ecavcu vs_val_ecavcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 175 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 176 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2010.dta") fields("val_ecbvce vs_val_ecbvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 176 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 177 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2010.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 177 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L178:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 178 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2010.dta") fields("val_eckvce vs_val_eckvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L178:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 178 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 179 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2010.dta") fields("val_eckvcu vs_val_eckvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 179 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L180:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 180 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L180:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 180 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L181:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 181 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L181:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 181 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L182:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 182 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L182:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 182 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L183:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 183 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L183:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 183 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 184 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2010.dta") fields("val_eclvce vs_val_eclvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 184 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L185:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 185 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L185:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 185 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L186:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 186 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L186:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 186 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L187:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 187 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L187:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 187 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L188:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 188 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L188:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 188 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L189:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 189 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2010.dta") fields("val_eclvcu vs_val_eclvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L189:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 189 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 190 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2010.dta") fields("val_edivce vs_val_edivce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 190 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 191 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2010.dta") fields("val_edivcu vs_val_edivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 191 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 192 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2010.dta") fields("val_efovce vs_val_efovce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 192 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 193 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2010.dta") fields("val_efovcu vs_val_efovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 193 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L194:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 194 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L194:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 194 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L195:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 195 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L195:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 195 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L196:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 196 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L196:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 196 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L197:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 197 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L197:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 197 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 198 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2010.dta") fields("val_efuvce vs_val_efuvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 198 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L199:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 199 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L199:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 199 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L200:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 200 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L200:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 200 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L201:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 201 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L201:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 201 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L202:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 202 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L202:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 202 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 203 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2010.dta") fields("val_efuvcu vs_val_efuvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 203 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L204:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 204 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L204:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 204 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L205:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 205 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L205:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 205 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L206:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 206 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L206:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 206 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L207:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 207 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L207:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 207 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 208 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2010.dta") fields("val_egavce vs_val_egavce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 208 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L209:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 209 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L209:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 209 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L210:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 210 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L210:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 210 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L211:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 211 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L211:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 211 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L212:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 212 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L212:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 212 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 213 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2010.dta") fields("val_egavcu vs_val_egavcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 213 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 214 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2010.dta") fields("val_egovce vs_val_egovce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 214 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 215 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2010.dta") fields("val_egovcu vs_val_egovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 215 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L216:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 216 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L216:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 216 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L217:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 217 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L217:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 217 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L218:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 218 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L218:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 218 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L219:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 219 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L219:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 219 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 220 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2010.dta") fields("val_elpvce vs_val_elpvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 220 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L221:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 221 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L221:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 221 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L222:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 222 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L222:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 222 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L223:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 223 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L223:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 223 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L224:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 224 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L224:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 224 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 225 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2010.dta") fields("val_elpvcu vs_val_elpvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 225 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L226:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 226 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L226:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 226 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L227:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 227 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L227:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 227 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L228:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 228 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L228:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 228 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L229:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 229 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L229:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 229 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 230 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2010.dta") fields("val_eluvce vs_val_eluvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 230 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L231:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 231 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L231:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 231 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L232:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 232 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L232:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 232 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L233:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 233 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L233:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 233 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L234:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 234 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L234:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 234 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 235 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2010.dta") fields("val_eluvcu vs_val_eluvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 235 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L236:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 236 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L236:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 236 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L237:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 237 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L237:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 237 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L238:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 238 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L238:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 238 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L239:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 239 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L239:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 239 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 240 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2010.dta") fields("val_encvce vs_val_encvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 240 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L241:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 241 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L241:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 241 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L242:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 242 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L242:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 242 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L243:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 243 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L243:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 243 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L244:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 244 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L244:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 244 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 245 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2010.dta") fields("val_encvcu vs_val_encvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 245 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 246 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2010.dta") fields("val_engvce vs_val_engvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 246 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 247 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2010.dta") fields("val_engvcu vs_val_engvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 247 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L248:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 248 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L248:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 248 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L249:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 249 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L249:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 249 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L250:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 250 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L250:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 250 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L251:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 251 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L251:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 251 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 252 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2010.dta") fields("val_enpvcu vs_val_enpvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 252 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L253:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 253 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L253:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 253 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L254:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 254 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L254:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 254 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L255:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 255 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L255:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 255 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L256:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 256 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L256:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 256 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 257 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2010.dta") fields("val_eoivce vs_val_eoivce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 257 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L258:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 258 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L258:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 258 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L259:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 259 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L259:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 259 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L260:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 260 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L260:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 260 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L261:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 261 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L261:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 261 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 262 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2010.dta") fields("val_eoivcu vs_val_eoivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 262 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L263:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 263 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L263:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 263 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L264:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 264 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L264:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 264 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L265:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 265 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L265:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 265 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L266:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 266 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L266:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 266 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 267 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2010.dta") fields("val_epevce vs_val_epevce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 267 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L268:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 268 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L268:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 268 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L269:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 269 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L269:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 269 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L270:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 270 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L270:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 270 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L271:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 271 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L271:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 271 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L272:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 272 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2010.dta") fields("val_epevcu vs_val_epevcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L272:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 272 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L273:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 273 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L273:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 273 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L274:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 274 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L274:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 274 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L275:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 275 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L275:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 275 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L276:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 276 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L276:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 276 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L277:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 277 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2010.dta") fields("val_eplvcu vs_val_eplvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L277:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 277 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 278 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2010.dta") fields("val_esdvce vs_val_esdvce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 278 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L279:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 279 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2010.dta") fields("val_esdvcu vs_val_esdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L279:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 279 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L280:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 280 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L280:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 280 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L281:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 281 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L281:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 281 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L282:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 282 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L282:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 282 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L283:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 283 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L283:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 283 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 284 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2010.dta") fields("val_esovce vs_val_esovce") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 284 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L285:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 285 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L285:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 285 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L286:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 286 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L286:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 286 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L287:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 287 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L287:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 287 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L288:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 288 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L288:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 288 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 289 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2010.dta") fields("val_esovcu vs_val_esovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 289 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L290:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 290 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L290:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 290 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L291:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 291 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L291:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 291 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L292:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 292 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L292:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 292 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L293:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 293 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L293:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 293 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 294 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2010.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 294 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L295:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 295 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L295:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 295 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L296:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 296 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L296:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 296 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L297:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 297 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L297:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 297 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L298:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 298 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L298:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 298 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 299 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2010.dta") fields("val_icovcu vs_val_icovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 299 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 300 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2010.dta") fields("val_idevcu vs_val_idevcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 300 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L301:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 301 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L301:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 301 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L302:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 302 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L302:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 302 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L303:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 303 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L303:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 303 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L304:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 304 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L304:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 304 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 305 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2010.dta") fields("val_iinput vs_val_iinput") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 305 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L306:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 306 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L306:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 306 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L307:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 307 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L307:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 307 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L308:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 308 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L308:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 308 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L309:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 309 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L309:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 309 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 310 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2010.dta") fields("val_iinvcu vs_val_iinvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 310 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 311 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2010.dta") fields("val_iisfov vs_val_iisfov") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 311 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 312 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2010.dta") fields("val_iislov vs_val_iislov") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 312 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L313:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 313 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L313:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 313 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L314:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 314 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L314:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 314 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L315:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 315 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L315:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 315 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L316:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 316 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L316:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 316 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 317 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2010.dta") fields("val_iisvcu vs_val_iisvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 317 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L318:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 318 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2010.dta") fields("val_ikivcu vs_val_ikivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L318:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 318 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 319 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2010.dta") fields("val_iklvcu vs_val_iklvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 319 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 320 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2010.dta") fields("val_ikovcu vs_val_ikovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 320 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L321:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 321 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L321:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 321 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L322:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 322 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L322:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 322 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L323:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 323 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L323:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 323 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L324:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 324 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L324:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 324 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 325 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2010.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 325 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 326 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2010.dta") fields("val_insvcu vs_val_insvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 326 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 327 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2010.dta") fields("val_intvcu vs_val_intvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 327 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L328:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 328 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L328:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 328 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L329:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 329 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L329:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 329 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L330:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 330 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L330:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 330 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L331:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 331 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L331:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 331 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 332 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2010.dta") fields("val_iotvcu vs_val_iotvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 332 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 333 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2010.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 333 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 334 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2010.dta") fields("val_iprvcu vs_val_iprvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 334 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 335 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2010.dta") fields("val_irdvcu vs_val_irdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 335 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 336 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2010.dta") fields("val_irevcu vs_val_irevcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 336 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L337:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 337 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L337:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 337 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L338:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 338 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L338:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 338 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L339:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 339 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L339:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 339 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L340:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 340 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L340:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 340 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 341 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2010.dta") fields("val_irrvcu vs_val_irrvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 341 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L342:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 342 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L342:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 342 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L343:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 343 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L343:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 343 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L344:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 344 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L344:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 344 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L345:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 345 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L345:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 345 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 346 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2010.dta") fields("val_itxvcu vs_val_itxvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 346 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L347:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 347 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2010.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L347:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 347 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 348 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2010.dta") fields("val_nopvcu vs_val_nopvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 348 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 349 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2010.dta") fields("val_othvcu vs_val_othvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 349 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L350:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 350 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L350:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 350 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L351:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 351 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L351:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 351 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L352:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 352 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L352:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 352 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L353:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 353 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L353:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 353 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 354 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2010.dta") fields("val_output vs_val_output") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 354 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L355:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 355 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L355:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 355 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L356:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 356 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L356:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 356 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L357:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 357 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L357:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 357 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L358:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 358 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L358:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 358 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 359 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2010.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 359 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 360 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2010.dta") fields("val_renvcu vs_val_renvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 360 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L361:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 361 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L361:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 361 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L362:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 362 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L362:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 362 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L363:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 363 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L363:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 363 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L364:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 364 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L364:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 364 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 365 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2010.dta") fields("val_rimvcu vs_val_rimvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 365 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L366:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 366 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L366:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 366 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L367:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 367 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L367:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 367 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L368:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 368 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L368:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 368 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L369:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 369 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L369:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 369 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 370 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2010.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 370 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 371 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2010.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 371 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 372 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2010.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 372 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L373:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 373 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L373:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 373 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L374:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 374 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L374:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 374 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L375:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 375 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L375:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 375 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L376:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 376 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L376:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 376 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 377 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2010.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 377 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 378 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2010.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 378 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L379:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 379 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L379:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 379 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L380:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 380 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L380:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 380 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L381:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 381 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L381:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 381 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L382:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 382 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L382:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 382 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 383 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2010.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 383 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 384 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2010.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 384 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L385:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 385 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L385:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 385 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L386:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 386 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L386:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 386 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L387:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 387 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L387:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 387 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L388:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 388 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L388:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 388 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 389 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2010.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 389 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 390 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2010.dta") fields("val_sfovcu vs_val_sfovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 390 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 391 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2010.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 391 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 392 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2010.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 392 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 393 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2010.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 393 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L394:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 394 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L394:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 394 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L395:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 395 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L395:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 395 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L396:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 396 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L396:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 396 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L397:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 397 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L397:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 397 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 398 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2010.dta") fields("val_shdvcu vs_val_shdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 398 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L399:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 399 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L399:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 399 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L400:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 400 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L400:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 400 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L401:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 401 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L401:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 401 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L402:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 402 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L402:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 402 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 403 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2010.dta") fields("val_shfvcu vs_val_shfvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 403 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L404:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 404 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L404:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 404 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L405:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 405 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L405:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 405 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L406:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 406 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L406:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 406 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L407:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 407 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L407:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 407 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 408 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2010.dta") fields("val_shjvcu vs_val_shjvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 408 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L409:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 409 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L409:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 409 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L410:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 410 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L410:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 410 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L411:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 411 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L411:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 411 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L412:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 412 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L412:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 412 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 413 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2010.dta") fields("val_srdvcu vs_val_srdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 413 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L414:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 414 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L414:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 414 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L415:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 415 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L415:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 415 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L416:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 416 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L416:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 416 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L417:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 417 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L417:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 417 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 418 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2010.dta") fields("val_srjvcu vs_val_srjvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 418 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L419:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 419 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L419:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 419 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L420:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 420 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L420:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 420 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L421:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 421 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L421:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 421 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L422:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 422 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L422:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 422 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 423 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2010.dta") fields("val_srmvcu vs_val_srmvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 423 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L424:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 424 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L424:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 424 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L425:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 425 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L425:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 425 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L426:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 426 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L426:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 426 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L427:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 427 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L427:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 427 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 428 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2010.dta") fields("val_stdvcu vs_val_stdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 428 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L429:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 429 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L429:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 429 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L430:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 430 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L430:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 430 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L431:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 431 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L431:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 431 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L432:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 432 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L432:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 432 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 433 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2010.dta") fields("val_stjvcu vs_val_stjvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 433 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L434:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 434 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L434:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 434 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L435:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 435 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L435:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 435 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L436:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 436 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L436:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 436 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L437:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 437 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L437:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 437 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 438 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2010.dta") fields("val_stlvcu vs_val_stlvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 438 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L439:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 439 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L439:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 439 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L440:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 440 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L440:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 440 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L441:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 441 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L441:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 441 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L442:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 442 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L442:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 442 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 443 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2010.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 443 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L444:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 444 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L444:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 444 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L445:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 445 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L445:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 445 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L446:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 446 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L446:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 446 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L447:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 447 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L447:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 447 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 448 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2010.dta") fields("val_yelvcu vs_val_yelvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 448 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L449:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 449 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L449:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 449 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L450:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 450 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L450:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 450 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L451:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 451 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L451:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 451 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L452:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 452 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L452:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 452 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 453 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2010.dta") fields("val_yisvcu vs_val_yisvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 453 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 454 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2010.dta") fields("val_yisvdo vs_val_yisvdo") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 454 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 455 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2010.dta") fields("val_yisvfo vs_val_yisvfo") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 455 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 456 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2010.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 456 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 457 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2010.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 457 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 458 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2010.dta") fields("val_ykivcu vs_val_ykivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 458 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L459:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 459 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L459:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 459 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L460:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 460 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L460:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 460 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L461:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 461 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L461:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 461 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L462:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 462 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L462:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 462 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 463 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2010.dta") fields("val_yprvcu vs_val_yprvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 463 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L464:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 464 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L464:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 464 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L465:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 465 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L465:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 465 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L466:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 466 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L466:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 466 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L467:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 467 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L467:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 467 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 468 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2010.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 468 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 469 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2010.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 469 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 470 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2010.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 470 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 471 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2010.dta") fields("val_ytovcu vs_val_ytovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 471 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L472:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 472 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L472:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 472 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L473:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 473 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L473:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 473 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L474:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 474 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L474:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 474 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L475:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 475 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L475:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 475 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 476 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2010.dta") fields("val_znavcu vs_val_znavcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 476 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L477:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 477 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L477:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 477 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L478:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 478 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L478:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 478 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L479:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 479 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L479:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 479 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L480:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 480 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L480:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 480 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 481 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2010.dta") fields("val_zndvcu vs_val_zndvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 481 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 482 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2010.dta") fields("val_znevcu vs_val_znevcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 482 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L483:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 483 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2010.dta") fields("val_znhvcu vs_val_znhvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L483:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 483 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L484:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 484 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L484:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 484 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L485:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 485 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L485:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 485 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L486:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 486 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L486:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 486 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L487:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 487 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L487:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 487 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L488:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 488 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2010.dta") fields("val_znivcu vs_val_znivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L488:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 488 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L489:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 489 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L489:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 489 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L490:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 490 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L490:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 490 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L491:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 491 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L491:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 491 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L492:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 492 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L492:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 492 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 493 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2010.dta") fields("val_znovcu vs_val_znovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 493 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L494:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 494 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L494:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 494 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L495:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 495 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L495:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 495 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L496:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 496 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L496:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 496 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L497:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 497 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L497:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 497 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 498 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2010.dta") fields("val_znpvcu vs_val_znpvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 498 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 499 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2010.dta") fields("val_znrvcu vs_val_znrvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 499 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L500:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 500 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L500:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 500 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L501:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 501 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L501:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 501 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L502:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 502 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L502:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 502 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L503:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 503 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L503:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 503 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 504 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2010.dta") fields("val_znsvcu vs_val_znsvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 504 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 505 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2010.dta") fields("val_zntvcu vs_val_zntvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 505 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L506:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 506 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L506:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 506 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L507:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 507 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L507:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 507 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L508:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 508 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L508:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 508 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L509:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 509 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L509:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 509 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L510:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 510 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2010.dta") fields("val_zpavcu vs_val_zpavcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L510:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 510 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L511:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 511 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L511:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 511 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L512:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 512 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L512:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 512 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L513:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 513 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L513:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 513 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L514:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 514 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L514:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 514 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 515 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2010.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 515 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 516 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2010.dta") fields("val_zpevcu vs_val_zpevcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 516 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 517 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2010.dta") fields("val_zphvcu vs_val_zphvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 517 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L518:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 518 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L518:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 518 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L519:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 519 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L519:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 519 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L520:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 520 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L520:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 520 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L521:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 521 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L521:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 521 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 522 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2010.dta") fields("val_zpivcu vs_val_zpivcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 522 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L523:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 523 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L523:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 523 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L524:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 524 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L524:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 524 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L525:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 525 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L525:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 525 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L526:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 526 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L526:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 526 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 527 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2010.dta") fields("val_zpovcu vs_val_zpovcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 527 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L528:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 528 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L528:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 528 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L529:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 529 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L529:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 529 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L530:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 530 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L530:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 530 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L531:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 531 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L531:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 531 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 532 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2010.dta") fields("val_zppvcu vs_val_zppvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 532 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 533 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2010.dta") fields("val_zprvcu vs_val_zprvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 533 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L534:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 534 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L534:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 534 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L535:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 535 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L535:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 535 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L536:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 536 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L536:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 536 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L537:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 537 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L537:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 537 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 538 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2010.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 538 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 539 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2010.dta") fields("val_zptvcu vs_val_zptvcu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 539 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L540:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 540 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L540:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 540 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L541:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 541 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L541:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 541 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L542:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 542 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L542:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 542 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L543:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 543 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L543:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 543 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 544 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2010.dta") fields("value_added_nominal vs_value_added_nominal") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 544 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L545:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 545 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L545:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 545 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L546:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 546 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L546:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 546 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L547:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 547 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L547:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 547 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L548:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 548 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L548:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 548 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 549 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2010.dta") fields("workers vs_workers") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 549 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L550:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 550 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L550:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 550 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L551:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 551 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L551:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 551 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L552:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 552 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L552:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 552 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L553:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 553 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L553:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 553 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 554 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2010.dta") fields("source_id_raw vs_source_id_raw") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 554 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L555:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 555 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L555:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 555 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L556:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 556 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L556:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 556 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L557:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 557 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L557:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 557 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L558:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 558 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L558:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 558 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 559 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2010.dta") fields("district_code vs_district_code") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 559 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L560:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 560 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L560:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 560 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L561:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 561 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic510
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L561:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 561 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L562:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 562 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L562:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 562 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L563:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 563 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L563:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 563 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 564 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2010.dta") fields("industry_code vs_industry_code") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 564 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L565:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 565 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L565:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 565 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L566:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 566 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L566:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 566 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L567:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 567 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L567:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 567 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L568:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 568 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L568:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 568 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 569 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2010.dta") fields("province_code vs_province_code") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 569 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L570:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 570 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L570:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 570 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L571:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 571 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L571:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 571 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L572:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 572 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L572:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 572 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L573:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 573 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L573:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 573 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 574 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2010.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 574 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L575:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 575 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L575:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 575 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L576:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 576 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L576:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 576 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L577:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 577 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L577:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 577 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L578:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 578 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L578:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 578 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 579 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2010.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 579 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L580:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 580 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L580:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 580 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L581:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 581 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L581:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 581 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L582:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 582 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L582:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 582 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L583:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 583 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L583:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 583 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 584 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2010.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 584 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L585:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 585 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L585:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 585 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L586:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 586 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L586:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 586 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L587:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 587 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L587:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 587 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L588:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 588 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L588:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 588 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 589 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2010.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 589 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L590:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 590 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L590:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 590 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L591:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 591 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L591:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 591 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L592:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 592 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L592:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 592 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L593:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 593 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L593:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 593 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 594 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2010.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 594 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 595 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2010.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 595 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 596 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2010.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 596 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 597 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2010.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 597 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 598 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2010.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 598 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L599:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 599 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L599:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 599 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L600:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 600 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L600:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 600 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L601:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 601 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L601:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 601 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L602:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 602 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L602:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 602 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 603 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2010.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 603 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L604:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 604 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L604:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 604 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L605:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 605 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L605:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 605 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L606:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 606 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L606:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 606 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L607:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 607 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L607:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 607 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 608 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2010.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 608 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L609:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 609 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L609:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 609 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L610:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 610 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L610:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 610 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L611:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 611 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L611:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 611 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L612:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 612 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L612:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 612 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 613 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2010.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 613 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L614:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 614 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L614:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 614 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L615:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 615 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L615:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 615 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L616:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 616 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L616:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 616 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L617:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 617 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L617:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 617 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 618 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2010.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 618 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 619 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2010.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 619 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 620 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2010.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 620 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 621 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2010.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 621 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 622 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2010.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 622 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L623:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 623 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L623:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 623 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L624:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 624 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L624:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 624 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L625:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 625 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L625:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 625 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L626:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 626 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L626:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 626 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 627 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2010.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 627 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L628:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 628 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L628:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 628 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L629:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 629 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L629:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 629 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L630:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 630 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L630:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 630 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L631:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 631 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L631:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 631 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 632 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2010.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 632 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 633 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2010.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 633 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 634 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2010.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 634 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 635 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2010.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 635 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 636 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2010.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 636 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 637 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2010.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 637 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 638 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2010.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 638 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L639:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 639 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L639:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 639 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L640:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 640 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoiliu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L640:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 640 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L641:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 641 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L641:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 641 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L642:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 642 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L642:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 642 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 643 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2010.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 643 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L644:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 644 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L644:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 644 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L645:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 645 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L645:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 645 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L646:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 646 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L646:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 646 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L647:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 647 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L647:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 647 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 648 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2010.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 648 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L649:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 649 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L649:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 649 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L650:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 650 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L650:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 650 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L651:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 651 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L651:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 651 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L652:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 652 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L652:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 652 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 653 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2010.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 653 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L654:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 654 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L654:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 654 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L655:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 655 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L655:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 655 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L656:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 656 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L656:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 656 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L657:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 657 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L657:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 657 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 658 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2010.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 658 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L659:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 659 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L659:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 659 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L660:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 660 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L660:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 660 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L661:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 661 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L661:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 661 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L662:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 662 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L662:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 662 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 663 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2010.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 663 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L664:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 664 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L664:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 664 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L665:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 665 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L665:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 665 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L666:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 666 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L666:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 666 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L667:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 667 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L667:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 667 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 668 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2010.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 668 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 669 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2010.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 669 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 670 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2010.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 670 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L671:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 671 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L671:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 671 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L672:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 672 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L672:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 672 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L673:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 673 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L673:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 673 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L674:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 674 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L674:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 674 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 675 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2010.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 675 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 676 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2010.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 676 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 677 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2010.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 677 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L678:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 678 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L678:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 678 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L679:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 679 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L679:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 679 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L680:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 680 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L680:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 680 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L681:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 681 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L681:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 681 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 682 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2010.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 682 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L683:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 683 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L683:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 683 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L684:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 684 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L684:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 684 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L685:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 685 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L685:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 685 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L686:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 686 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L686:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 686 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 687 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2010.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 687 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L688:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 688 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L688:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 688 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L689:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 689 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L689:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 689 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L690:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 690 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L690:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 690 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L691:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 691 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L691:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 691 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 692 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2010.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 692 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L693:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 693 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L693:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 693 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L694:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 694 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L694:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 694 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L695:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 695 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L695:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 695 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L696:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 696 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L696:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 696 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 697 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2010.dta") fields("export_any_binary vs_export_any_binary") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 697 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L698:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 698 716 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L698:step-preserve" "code/annual/merge_mapped_2010.do:L1:file" "statement" 698 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L699:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 699 716 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor10
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L699:step-keep" "code/annual/merge_mapped_2010.do:L1:file" "statement" 699 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L700:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 700 716 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2010.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L700:step-cf" "code/annual/merge_mapped_2010.do:L1:file" "statement" 700 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L701:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 701 716 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L701:step-restore" "code/annual/merge_mapped_2010.do:L1:file" "statement" 701 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 702 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2010.dta") fields("export_direct_flag vs_export_direct_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 702 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L703:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 703 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2010.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L703:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 703 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L704:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 704 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2010.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L704:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 704 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 705 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2010.dta") fields("innovation_flag vs_innovation_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 705 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L706:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 706 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2010.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L706:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 706 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 707 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2010.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 707 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 708 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2010.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 708 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L709:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 709 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2010.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L709:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 709 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 710 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2010.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 710 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L711:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 711 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2010.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L711:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 711 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 712 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2010.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 712 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 713 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2010.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 713 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 714 716 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2010.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2010)
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2010.do:L1:file" "statement" 714 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L715:step-isid" "code/annual/merge_mapped_2010.do:L1:file" "statement" 715 716 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L715:step-isid" "code/annual/merge_mapped_2010.do:L1:file" "statement" 715 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2010.do:L716:step-save" "code/annual/merge_mapped_2010.do:L1:file" "statement" 716 716 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2010.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L716:step-save" "code/annual/merge_mapped_2010.do:L1:file" "statement" 716 716 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2010.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
