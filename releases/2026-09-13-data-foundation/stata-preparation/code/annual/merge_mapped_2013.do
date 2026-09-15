* Tujuan: Gabungkan hasil pemetaan kolom tahun 2013 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2013.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2013.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L1:step-do" "code/annual/merge_mapped_2013.do:L1:file" "statement" 1 748 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L1:step-do" "code/annual/merge_mapped_2013.do:L1:file" "statement" 1 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L2:step-do" "code/annual/merge_mapped_2013.do:L1:file" "statement" 2 748 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L2:step-do" "code/annual/merge_mapped_2013.do:L1:file" "statement" 2 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L3:step-use" "code/annual/merge_mapped_2013.do:L1:file" "statement" 3 748 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2013.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L3:step-use" "code/annual/merge_mapped_2013.do:L1:file" "statement" 3 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L4:step-assert" "code/annual/merge_mapped_2013.do:L1:file" "statement" 4 748 `=_rc' // WFLOG-INJECTED
assert source_year==2013
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L4:step-assert" "code/annual/merge_mapped_2013.do:L1:file" "statement" 4 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L5:step-isid" "code/annual/merge_mapped_2013.do:L1:file" "statement" 5 748 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L5:step-isid" "code/annual/merge_mapped_2013.do:L1:file" "statement" 5 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 6 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2013.dta") fields("amdal_raw vs_amdal_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 6 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 7 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2013.dta") fields("b3wste_raw vs_b3wste_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 7 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L8:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 8 748 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L8:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 8 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L9:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 9 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L9:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 9 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L10:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 10 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L10:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 10 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L11:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 11 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L11:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 11 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 12 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2013.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 12 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L13:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 13 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L13:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 13 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L14:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 14 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L14:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 14 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L15:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 15 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L15:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 15 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L16:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 16 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L16:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 16 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 17 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2013.dta") fields("capital_nominal vs_capital_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 17 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L18:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 18 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L18:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 18 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L19:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 19 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L19:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 19 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L20:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 20 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L20:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 20 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L21:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 21 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L21:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 21 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 22 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2013.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 22 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L23:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 23 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L23:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 23 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L24:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 24 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L24:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 24 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L25:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 25 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L25:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 25 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L26:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 26 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L26:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 26 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 27 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2013.dta") fields("export_binary_raw vs_export_binary_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 27 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L28:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 28 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L28:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 28 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L29:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 29 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L29:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 29 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L30:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 30 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L30:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 30 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L31:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 31 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L31:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 31 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 32 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2013.dta") fields("export_share_pct vs_export_share_pct") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 32 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L33:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 33 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L33:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 33 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L34:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 34 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L34:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 34 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L35:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 35 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L35:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 35 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L36:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 36 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L36:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 36 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 37 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2013.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 37 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L38:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 38 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L38:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 38 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L39:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 39 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L39:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 39 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L40:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 40 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L40:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 40 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L41:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 41 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L41:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 41 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 42 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2013.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 42 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L43:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 43 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L43:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 43 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L44:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 44 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L44:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 44 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L45:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 45 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L45:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 45 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L46:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 46 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L46:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 46 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 47 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2013.dta") fields("import_value_nominal vs_import_value_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 47 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 48 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2013.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 48 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 49 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2013.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 49 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 50 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2013.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 50 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 51 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2013.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 51 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 52 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2013.dta") fields("innovation_raw vs_innovation_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 52 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 53 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2013.dta") fields("inspli_raw vs_inspli_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 53 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L54:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 54 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L54:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 54 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L55:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 55 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L55:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 55 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L56:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 56 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L56:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 56 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L57:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 57 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L57:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 57 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 58 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2013.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 58 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 59 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2013.dta") fields("liwste_raw vs_liwste_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 59 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 60 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2013.dta") fields("pplihi_raw vs_pplihi_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 60 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L61:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 61 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L61:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 61 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L62:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 62 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L62:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 62 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L63:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 63 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L63:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 63 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L64:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 64 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L64:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 64 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 65 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2013.dta") fields("production_workers vs_production_workers") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 65 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 66 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2013.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 66 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 67 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2013.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 67 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 68 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2013.dta") fields("rd_workers vs_rd_workers") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 68 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 69 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2013.dta") fields("sowste_raw vs_sowste_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 69 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 70 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2013.dta") fields("spplhi_raw vs_spplhi_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 70 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L71:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 71 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L71:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 71 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L72:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 72 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L72:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 72 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L73:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 73 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L73:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 73 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L74:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 74 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L74:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 74 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 75 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2013.dta") fields("val_cbdacu vs_val_cbdacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 75 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 76 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2013.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 76 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L77:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 77 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L77:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 77 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L78:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 78 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L78:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 78 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L79:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 79 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L79:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 79 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L80:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 80 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L80:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 80 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 81 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2013.dta") fields("val_cbsacu vs_val_cbsacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 81 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L82:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 82 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L82:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 82 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L83:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 83 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L83:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 83 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L84:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 84 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L84:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 84 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L85:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 85 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L85:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 85 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 86 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2013.dta") fields("val_cbttcu vs_val_cbttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 86 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L87:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 87 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L87:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 87 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L88:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 88 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cldacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L88:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 88 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L89:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 89 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L89:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 89 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L90:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 90 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L90:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 90 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 91 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2013.dta") fields("val_cldacu vs_val_cldacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 91 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 92 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2013.dta") fields("val_clfpcu vs_val_clfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 92 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L93:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 93 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L93:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 93 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L94:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 94 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L94:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 94 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L95:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 95 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L95:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 95 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L96:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 96 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L96:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 96 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 97 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2013.dta") fields("val_clsacu vs_val_clsacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 97 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L98:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 98 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L98:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 98 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L99:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 99 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L99:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 99 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L100:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 100 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L100:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 100 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L101:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 101 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L101:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 101 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 102 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2013.dta") fields("val_clttcu vs_val_clttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 102 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L103:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 103 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L103:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 103 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L104:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 104 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L104:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 104 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L105:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 105 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L105:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 105 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L106:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 106 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L106:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 106 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 107 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2013.dta") fields("val_cmdacu vs_val_cmdacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 107 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 108 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2013.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 108 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L109:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 109 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L109:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 109 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L110:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 110 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L110:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 110 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L111:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 111 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L111:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 111 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L112:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 112 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L112:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 112 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 113 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2013.dta") fields("val_cmsacu vs_val_cmsacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 113 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L114:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 114 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L114:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 114 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L115:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 115 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L115:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 115 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L116:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 116 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L116:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 116 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L117:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 117 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L117:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 117 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 118 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2013.dta") fields("val_cmttcu vs_val_cmttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 118 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L119:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 119 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L119:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 119 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L120:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 120 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L120:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 120 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L121:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 121 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L121:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 121 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L122:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 122 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L122:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 122 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 123 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2013.dta") fields("val_codacu vs_val_codacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 123 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 124 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2013.dta") fields("val_cofpcu vs_val_cofpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 124 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L125:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 125 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L125:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 125 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L126:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 126 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L126:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 126 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L127:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 127 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L127:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 127 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L128:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 128 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L128:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 128 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 129 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2013.dta") fields("val_cosacu vs_val_cosacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 129 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 130 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2013.dta") fields("val_costrd vs_val_costrd") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 130 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L131:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 131 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L131:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 131 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L132:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 132 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L132:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 132 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L133:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 133 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L133:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 133 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L134:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 134 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L134:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 134 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 135 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2013.dta") fields("val_cottcu vs_val_cottcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 135 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 136 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2013.dta") fields("val_csdacu vs_val_csdacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 136 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 137 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2013.dta") fields("val_csfpcu vs_val_csfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 137 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 138 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2013.dta") fields("val_cssacu vs_val_cssacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 138 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 139 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2013.dta") fields("val_csttcu vs_val_csttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 139 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L140:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 140 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L140:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 140 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L141:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 141 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L141:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 141 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L142:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 142 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L142:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 142 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L143:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 143 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L143:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 143 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 144 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2013.dta") fields("val_ctdacu vs_val_ctdacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 144 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 145 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2013.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 145 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L146:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 146 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L146:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 146 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L147:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 147 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L147:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 147 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L148:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 148 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L148:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 148 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L149:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 149 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L149:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 149 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 150 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2013.dta") fields("val_ctsacu vs_val_ctsacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 150 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 151 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2013.dta") fields("val_cttcu vs_val_cttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 151 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L152:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 152 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L152:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 152 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L153:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 153 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L153:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 153 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L154:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 154 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L154:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 154 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L155:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 155 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L155:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 155 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 156 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2013.dta") fields("val_ctttcu vs_val_ctttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 156 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L157:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 157 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L157:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 157 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L158:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 158 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L158:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 158 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L159:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 159 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L159:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 159 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L160:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 160 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L160:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 160 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 161 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2013.dta") fields("val_cvdacu vs_val_cvdacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 161 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 162 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2013.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 162 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L163:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 163 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L163:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 163 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L164:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 164 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L164:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 164 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L165:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 165 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L165:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 165 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L166:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 166 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L166:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 166 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 167 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2013.dta") fields("val_cvsacu vs_val_cvsacu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 167 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L168:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 168 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L168:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 168 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L169:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 169 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L169:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 169 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L170:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 170 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L170:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 170 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L171:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 171 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L171:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 171 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 172 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2013.dta") fields("val_cvttcu vs_val_cvttcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 172 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 173 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2013.dta") fields("val_devvcu vs_val_devvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 173 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 174 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2013.dta") fields("val_ecavce vs_val_ecavce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 174 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 175 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2013.dta") fields("val_ecavcu vs_val_ecavcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 175 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L176:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 176 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L176:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 176 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L177:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 177 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L177:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 177 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L178:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 178 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L178:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 178 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L179:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 179 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L179:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 179 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 180 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2013.dta") fields("val_ecbvce vs_val_ecbvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 180 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L181:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 181 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L181:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 181 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L182:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 182 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L182:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 182 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L183:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 183 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L183:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 183 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L184:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 184 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L184:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 184 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 185 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2013.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 185 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 186 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2013.dta") fields("val_eckvce vs_val_eckvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 186 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 187 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2013.dta") fields("val_eckvcu vs_val_eckvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 187 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L188:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 188 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L188:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 188 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L189:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 189 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L189:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 189 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L190:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 190 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L190:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 190 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L191:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 191 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L191:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 191 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 192 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2013.dta") fields("val_eclvce vs_val_eclvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 192 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L193:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 193 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L193:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 193 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L194:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 194 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L194:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 194 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L195:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 195 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L195:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 195 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L196:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 196 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L196:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 196 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 197 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2013.dta") fields("val_eclvcu vs_val_eclvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 197 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 198 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2013.dta") fields("val_edivce vs_val_edivce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 198 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 199 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2013.dta") fields("val_edivcu vs_val_edivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 199 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L200:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 200 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2013.dta") fields("val_efovce vs_val_efovce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L200:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 200 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 201 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2013.dta") fields("val_efovcu vs_val_efovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 201 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L202:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 202 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L202:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 202 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L203:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 203 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L203:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 203 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L204:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 204 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L204:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 204 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L205:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 205 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L205:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 205 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L206:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 206 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2013.dta") fields("val_efuvce vs_val_efuvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L206:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 206 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L207:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 207 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L207:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 207 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L208:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 208 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L208:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 208 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L209:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 209 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L209:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 209 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L210:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 210 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L210:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 210 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 211 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2013.dta") fields("val_efuvcu vs_val_efuvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 211 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L212:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 212 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L212:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 212 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L213:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 213 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L213:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 213 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L214:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 214 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L214:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 214 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L215:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 215 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L215:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 215 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 216 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2013.dta") fields("val_egavce vs_val_egavce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 216 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L217:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 217 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L217:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 217 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L218:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 218 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L218:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 218 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L219:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 219 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L219:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 219 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L220:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 220 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L220:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 220 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 221 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2013.dta") fields("val_egavcu vs_val_egavcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 221 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L222:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 222 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L222:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 222 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L223:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 223 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L223:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 223 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L224:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 224 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L224:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 224 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L225:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 225 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L225:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 225 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 226 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2013.dta") fields("val_egovce vs_val_egovce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 226 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L227:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 227 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L227:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 227 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L228:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 228 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L228:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 228 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L229:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 229 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L229:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 229 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L230:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 230 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L230:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 230 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 231 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2013.dta") fields("val_egovcu vs_val_egovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 231 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L232:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 232 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L232:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 232 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L233:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 233 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L233:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 233 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L234:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 234 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L234:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 234 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L235:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 235 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L235:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 235 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 236 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2013.dta") fields("val_elpvce vs_val_elpvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 236 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L237:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 237 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L237:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 237 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L238:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 238 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L238:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 238 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L239:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 239 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L239:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 239 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L240:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 240 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L240:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 240 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 241 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2013.dta") fields("val_elpvcu vs_val_elpvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 241 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L242:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 242 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L242:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 242 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L243:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 243 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L243:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 243 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L244:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 244 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L244:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 244 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L245:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 245 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L245:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 245 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 246 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2013.dta") fields("val_eluvce vs_val_eluvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 246 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L247:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 247 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L247:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 247 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L248:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 248 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L248:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 248 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L249:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 249 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L249:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 249 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L250:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 250 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L250:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 250 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L251:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 251 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2013.dta") fields("val_eluvcu vs_val_eluvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L251:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 251 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L252:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 252 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L252:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 252 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L253:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 253 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L253:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 253 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L254:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 254 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L254:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 254 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L255:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 255 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L255:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 255 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L256:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 256 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2013.dta") fields("val_encvce vs_val_encvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L256:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 256 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L257:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 257 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L257:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 257 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L258:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 258 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L258:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 258 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L259:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 259 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L259:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 259 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L260:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 260 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L260:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 260 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L261:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 261 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2013.dta") fields("val_encvcu vs_val_encvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L261:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 261 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 262 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2013.dta") fields("val_engvce vs_val_engvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 262 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 263 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2013.dta") fields("val_engvcu vs_val_engvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 263 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L264:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 264 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L264:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 264 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L265:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 265 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L265:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 265 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L266:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 266 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L266:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 266 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L267:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 267 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L267:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 267 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 268 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2013.dta") fields("val_enpvcu vs_val_enpvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 268 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L269:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 269 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L269:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 269 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L270:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 270 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L270:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 270 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L271:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 271 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L271:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 271 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L272:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 272 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L272:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 272 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 273 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2013.dta") fields("val_eoivce vs_val_eoivce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 273 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L274:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 274 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L274:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 274 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L275:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 275 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L275:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 275 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L276:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 276 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L276:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 276 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L277:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 277 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L277:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 277 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 278 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2013.dta") fields("val_eoivcu vs_val_eoivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 278 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L279:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 279 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L279:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 279 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L280:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 280 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L280:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 280 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L281:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 281 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L281:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 281 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L282:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 282 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L282:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 282 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 283 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2013.dta") fields("val_epevce vs_val_epevce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 283 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L284:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 284 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L284:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 284 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L285:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 285 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L285:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 285 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L286:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 286 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L286:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 286 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L287:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 287 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L287:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 287 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L288:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 288 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2013.dta") fields("val_epevcu vs_val_epevcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L288:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 288 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L289:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 289 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L289:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 289 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L290:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 290 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L290:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 290 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L291:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 291 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L291:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 291 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L292:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 292 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L292:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 292 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 293 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2013.dta") fields("val_eplvcu vs_val_eplvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 293 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 294 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2013.dta") fields("val_esdvce vs_val_esdvce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 294 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 295 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2013.dta") fields("val_esdvcu vs_val_esdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 295 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L296:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 296 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L296:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 296 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L297:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 297 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L297:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 297 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L298:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 298 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L298:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 298 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L299:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 299 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L299:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 299 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 300 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2013.dta") fields("val_esovce vs_val_esovce") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 300 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L301:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 301 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L301:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 301 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L302:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 302 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L302:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 302 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L303:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 303 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L303:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 303 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L304:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 304 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L304:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 304 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 305 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2013.dta") fields("val_esovcu vs_val_esovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 305 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L306:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 306 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L306:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 306 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L307:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 307 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L307:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 307 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L308:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 308 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L308:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 308 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L309:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 309 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L309:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 309 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 310 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2013.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 310 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L311:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 311 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L311:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 311 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L312:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 312 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L312:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 312 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L313:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 313 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L313:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 313 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L314:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 314 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L314:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 314 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 315 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2013.dta") fields("val_icovcu vs_val_icovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 315 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 316 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2013.dta") fields("val_idevcu vs_val_idevcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 316 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L317:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 317 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L317:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 317 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L318:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 318 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L318:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 318 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L319:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 319 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L319:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 319 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L320:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 320 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L320:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 320 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 321 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2013.dta") fields("val_iinput vs_val_iinput") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 321 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L322:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 322 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L322:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 322 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L323:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 323 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L323:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 323 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L324:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 324 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L324:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 324 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L325:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 325 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L325:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 325 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 326 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2013.dta") fields("val_iinvcu vs_val_iinvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 326 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 327 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2013.dta") fields("val_iisfov vs_val_iisfov") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 327 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L328:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 328 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2013.dta") fields("val_iislov vs_val_iislov") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L328:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 328 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L329:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 329 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L329:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 329 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L330:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 330 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L330:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 330 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L331:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 331 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L331:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 331 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L332:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 332 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L332:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 332 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 333 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2013.dta") fields("val_iisvcu vs_val_iisvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 333 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 334 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2013.dta") fields("val_ikivcu vs_val_ikivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 334 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 335 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2013.dta") fields("val_iklvcu vs_val_iklvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 335 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 336 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2013.dta") fields("val_ikovcu vs_val_ikovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 336 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L337:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 337 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L337:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 337 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L338:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 338 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L338:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 338 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L339:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 339 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L339:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 339 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L340:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 340 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L340:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 340 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 341 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2013.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 341 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L342:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 342 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2013.dta") fields("val_insvcu vs_val_insvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L342:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 342 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 343 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2013.dta") fields("val_intvcu vs_val_intvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 343 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L344:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 344 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L344:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 344 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L345:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 345 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L345:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 345 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L346:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 346 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L346:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 346 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L347:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 347 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L347:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 347 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 348 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2013.dta") fields("val_iotvcu vs_val_iotvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 348 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 349 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2013.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 349 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 350 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2013.dta") fields("val_iprvcu vs_val_iprvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 350 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 351 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2013.dta") fields("val_irdvcu vs_val_irdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 351 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 352 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2013.dta") fields("val_irevcu vs_val_irevcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 352 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L353:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 353 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L353:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 353 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L354:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 354 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L354:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 354 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L355:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 355 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L355:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 355 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L356:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 356 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L356:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 356 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L357:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 357 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2013.dta") fields("val_irrvcu vs_val_irrvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L357:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 357 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L358:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 358 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L358:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 358 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L359:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 359 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L359:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 359 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L360:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 360 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L360:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 360 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L361:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 361 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L361:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 361 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L362:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 362 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2013.dta") fields("val_itxvcu vs_val_itxvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L362:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 362 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 363 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2013.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 363 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 364 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2013.dta") fields("val_nopvcu vs_val_nopvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 364 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 365 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2013.dta") fields("val_othvcu vs_val_othvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 365 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L366:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 366 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L366:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 366 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L367:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 367 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L367:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 367 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L368:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 368 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L368:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 368 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L369:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 369 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L369:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 369 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 370 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2013.dta") fields("val_output vs_val_output") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 370 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L371:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 371 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L371:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 371 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L372:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 372 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L372:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 372 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L373:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 373 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L373:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 373 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L374:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 374 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L374:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 374 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L375:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 375 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2013.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L375:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 375 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 376 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2013.dta") fields("val_renvcu vs_val_renvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 376 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L377:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 377 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L377:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 377 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L378:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 378 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L378:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 378 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L379:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 379 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L379:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 379 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L380:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 380 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L380:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 380 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 381 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2013.dta") fields("val_rimvcu vs_val_rimvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 381 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L382:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 382 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L382:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 382 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L383:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 383 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L383:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 383 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L384:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 384 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L384:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 384 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L385:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 385 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L385:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 385 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 386 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2013.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 386 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 387 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2013.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 387 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 388 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2013.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 388 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L389:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 389 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L389:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 389 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L390:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 390 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L390:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 390 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L391:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 391 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L391:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 391 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L392:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 392 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L392:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 392 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 393 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2013.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 393 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 394 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2013.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 394 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L395:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 395 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L395:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 395 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L396:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 396 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L396:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 396 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L397:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 397 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L397:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 397 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L398:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 398 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L398:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 398 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 399 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2013.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 399 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 400 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2013.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 400 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L401:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 401 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L401:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 401 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L402:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 402 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L402:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 402 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L403:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 403 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L403:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 403 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L404:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 404 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L404:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 404 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 405 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2013.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 405 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 406 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2013.dta") fields("val_sfovcu vs_val_sfovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 406 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 407 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2013.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 407 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 408 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2013.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 408 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 409 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2013.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 409 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L410:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 410 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L410:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 410 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L411:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 411 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L411:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 411 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L412:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 412 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L412:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 412 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L413:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 413 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L413:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 413 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 414 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2013.dta") fields("val_shdvcu vs_val_shdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 414 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L415:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 415 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L415:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 415 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L416:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 416 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L416:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 416 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L417:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 417 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L417:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 417 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L418:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 418 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L418:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 418 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 419 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2013.dta") fields("val_shfvcu vs_val_shfvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 419 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L420:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 420 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L420:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 420 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L421:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 421 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L421:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 421 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L422:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 422 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L422:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 422 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L423:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 423 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L423:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 423 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 424 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2013.dta") fields("val_shjvcu vs_val_shjvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 424 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L425:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 425 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L425:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 425 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L426:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 426 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L426:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 426 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L427:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 427 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L427:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 427 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L428:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 428 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L428:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 428 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 429 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2013.dta") fields("val_srdvcu vs_val_srdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 429 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L430:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 430 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L430:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 430 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L431:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 431 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L431:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 431 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L432:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 432 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L432:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 432 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L433:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 433 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L433:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 433 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 434 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2013.dta") fields("val_srjvcu vs_val_srjvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 434 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L435:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 435 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L435:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 435 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L436:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 436 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L436:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 436 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L437:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 437 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L437:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 437 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L438:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 438 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L438:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 438 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 439 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2013.dta") fields("val_srmvcu vs_val_srmvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 439 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L440:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 440 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L440:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 440 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L441:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 441 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L441:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 441 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L442:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 442 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L442:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 442 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L443:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 443 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L443:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 443 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 444 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2013.dta") fields("val_stdvcu vs_val_stdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 444 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L445:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 445 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L445:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 445 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L446:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 446 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L446:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 446 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L447:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 447 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L447:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 447 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L448:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 448 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L448:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 448 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 449 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2013.dta") fields("val_stjvcu vs_val_stjvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 449 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L450:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 450 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L450:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 450 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L451:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 451 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L451:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 451 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L452:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 452 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L452:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 452 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L453:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 453 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L453:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 453 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 454 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2013.dta") fields("val_stlvcu vs_val_stlvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 454 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L455:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 455 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L455:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 455 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L456:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 456 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L456:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 456 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L457:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 457 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L457:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 457 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L458:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 458 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L458:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 458 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 459 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2013.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 459 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L460:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 460 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L460:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 460 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L461:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 461 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L461:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 461 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L462:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 462 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L462:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 462 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L463:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 463 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L463:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 463 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 464 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2013.dta") fields("val_yelvcu vs_val_yelvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 464 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L465:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 465 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L465:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 465 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L466:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 466 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L466:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 466 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L467:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 467 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L467:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 467 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L468:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 468 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L468:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 468 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 469 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2013.dta") fields("val_yisvcu vs_val_yisvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 469 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 470 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2013.dta") fields("val_yisvdo vs_val_yisvdo") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 470 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 471 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2013.dta") fields("val_yisvfo vs_val_yisvfo") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 471 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L472:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 472 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2013.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L472:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 472 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 473 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2013.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 473 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 474 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2013.dta") fields("val_ykivcu vs_val_ykivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 474 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L475:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 475 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L475:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 475 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L476:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 476 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L476:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 476 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L477:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 477 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L477:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 477 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L478:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 478 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L478:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 478 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 479 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2013.dta") fields("val_yprvcu vs_val_yprvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 479 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L480:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 480 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L480:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 480 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L481:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 481 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L481:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 481 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L482:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 482 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L482:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 482 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L483:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 483 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L483:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 483 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 484 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2013.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 484 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L485:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 485 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2013.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L485:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 485 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L486:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 486 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2013.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L486:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 486 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 487 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2013.dta") fields("val_ytovcu vs_val_ytovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 487 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L488:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 488 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L488:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 488 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L489:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 489 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L489:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 489 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L490:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 490 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L490:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 490 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L491:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 491 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L491:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 491 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 492 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2013.dta") fields("val_znavcu vs_val_znavcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 492 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L493:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 493 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L493:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 493 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L494:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 494 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L494:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 494 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L495:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 495 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L495:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 495 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L496:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 496 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L496:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 496 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 497 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2013.dta") fields("val_zndvcu vs_val_zndvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 497 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 498 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2013.dta") fields("val_znevcu vs_val_znevcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 498 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 499 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2013.dta") fields("val_znhvcu vs_val_znhvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 499 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L500:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 500 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L500:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 500 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L501:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 501 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L501:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 501 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L502:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 502 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L502:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 502 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L503:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 503 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L503:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 503 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 504 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2013.dta") fields("val_znivcu vs_val_znivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 504 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L505:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 505 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L505:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 505 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L506:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 506 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L506:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 506 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L507:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 507 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L507:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 507 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L508:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 508 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L508:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 508 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 509 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2013.dta") fields("val_znovcu vs_val_znovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 509 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L510:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 510 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L510:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 510 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L511:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 511 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L511:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 511 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L512:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 512 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L512:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 512 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L513:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 513 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L513:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 513 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 514 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2013.dta") fields("val_znpvcu vs_val_znpvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 514 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 515 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2013.dta") fields("val_znrvcu vs_val_znrvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 515 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L516:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 516 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L516:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 516 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L517:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 517 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L517:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 517 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L518:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 518 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L518:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 518 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L519:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 519 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L519:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 519 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L520:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 520 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2013.dta") fields("val_znsvcu vs_val_znsvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L520:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 520 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L521:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 521 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2013.dta") fields("val_zntvcu vs_val_zntvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L521:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 521 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L522:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 522 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L522:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 522 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L523:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 523 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L523:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 523 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L524:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 524 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L524:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 524 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L525:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 525 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L525:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 525 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L526:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 526 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2013.dta") fields("val_zpavcu vs_val_zpavcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L526:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 526 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L527:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 527 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L527:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 527 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L528:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 528 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L528:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 528 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L529:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 529 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L529:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 529 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L530:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 530 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L530:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 530 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L531:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 531 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2013.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L531:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 531 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 532 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2013.dta") fields("val_zpevcu vs_val_zpevcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 532 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 533 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2013.dta") fields("val_zphvcu vs_val_zphvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 533 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L534:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 534 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L534:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 534 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L535:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 535 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L535:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 535 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L536:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 536 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L536:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 536 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L537:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 537 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L537:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 537 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 538 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2013.dta") fields("val_zpivcu vs_val_zpivcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 538 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L539:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 539 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L539:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 539 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L540:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 540 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L540:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 540 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L541:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 541 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L541:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 541 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L542:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 542 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L542:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 542 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L543:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 543 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2013.dta") fields("val_zpovcu vs_val_zpovcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L543:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 543 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L544:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 544 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L544:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 544 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L545:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 545 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L545:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 545 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L546:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 546 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L546:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 546 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L547:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 547 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L547:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 547 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 548 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2013.dta") fields("val_zppvcu vs_val_zppvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L548:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 548 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 549 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2013.dta") fields("val_zprvcu vs_val_zprvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 549 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L550:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 550 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L550:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 550 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L551:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 551 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L551:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 551 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L552:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 552 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L552:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 552 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L553:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 553 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L553:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 553 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 554 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2013.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 554 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 555 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2013.dta") fields("val_zptvcu vs_val_zptvcu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L555:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 555 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L556:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 556 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L556:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 556 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L557:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 557 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L557:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 557 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L558:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 558 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L558:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 558 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L559:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 559 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L559:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 559 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 560 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2013.dta") fields("value_added_nominal vs_value_added_nominal") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L560:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 560 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L561:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 561 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L561:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 561 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L562:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 562 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L562:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 562 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L563:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 563 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L563:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 563 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L564:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 564 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L564:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 564 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 565 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2013.dta") fields("workers vs_workers") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L565:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 565 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L566:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 566 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L566:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 566 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L567:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 567 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L567:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 567 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L568:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 568 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L568:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 568 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L569:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 569 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L569:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 569 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L570:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 570 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2013.dta") fields("source_id_raw vs_source_id_raw") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L570:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 570 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L571:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 571 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L571:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 571 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L572:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 572 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup13___3
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L572:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 572 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L573:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 573 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L573:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 573 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L574:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 574 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L574:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 574 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L575:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 575 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2013.dta") fields("district_code vs_district_code") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L575:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 575 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L576:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 576 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L576:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 576 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L577:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 577 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic513
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L577:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 577 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L578:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 578 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L578:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 578 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L579:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 579 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L579:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 579 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L580:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 580 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2013.dta") fields("industry_code vs_industry_code") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L580:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 580 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L581:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 581 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L581:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 581 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L582:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 582 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi13___2
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L582:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 582 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L583:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 583 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L583:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 583 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L584:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 584 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L584:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 584 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 585 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2013.dta") fields("province_code vs_province_code") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L585:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 585 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L586:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 586 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L586:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 586 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L587:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 587 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L587:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 587 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L588:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 588 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L588:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 588 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L589:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 589 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L589:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 589 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 590 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2013.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L590:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 590 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L591:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 591 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L591:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 591 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L592:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 592 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L592:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 592 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L593:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 593 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L593:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 593 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L594:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 594 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L594:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 594 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 595 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2013.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 595 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L596:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 596 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L596:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 596 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L597:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 597 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L597:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 597 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L598:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 598 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L598:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 598 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L599:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 599 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L599:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 599 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 600 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2013.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 600 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L601:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 601 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L601:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 601 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L602:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 602 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L602:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 602 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L603:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 603 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L603:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 603 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L604:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 604 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L604:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 604 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L605:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 605 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2013.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L605:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 605 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L606:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 606 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L606:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 606 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L607:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 607 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L607:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 607 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L608:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 608 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L608:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 608 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L609:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 609 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L609:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 609 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 610 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2013.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 610 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L611:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 611 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2013.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L611:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 611 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L612:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 612 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2013.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L612:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 612 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 613 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2013.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 613 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 614 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2013.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 614 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L615:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 615 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L615:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 615 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L616:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 616 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L616:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 616 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L617:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 617 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L617:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 617 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L618:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 618 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L618:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 618 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 619 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2013.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 619 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L620:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 620 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L620:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 620 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L621:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 621 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L621:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 621 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L622:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 622 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L622:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 622 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L623:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 623 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L623:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 623 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 624 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2013.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 624 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L625:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 625 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L625:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 625 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L626:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 626 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L626:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 626 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L627:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 627 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L627:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 627 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L628:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 628 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L628:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 628 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 629 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2013.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 629 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L630:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 630 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L630:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 630 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L631:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 631 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L631:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 631 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L632:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 632 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L632:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 632 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L633:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 633 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L633:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 633 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 634 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2013.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 634 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L635:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 635 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L635:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 635 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L636:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 636 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L636:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 636 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L637:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 637 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L637:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 637 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L638:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 638 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L638:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 638 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L639:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 639 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2013.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L639:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 639 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L640:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 640 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L640:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 640 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L641:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 641 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L641:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 641 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L642:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 642 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L642:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 642 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L643:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 643 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L643:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 643 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 644 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2013.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 644 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L645:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 645 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2013.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L645:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 645 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 646 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2013.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 646 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L647:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 647 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L647:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 647 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L648:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 648 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L648:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 648 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L649:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 649 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L649:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 649 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L650:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 650 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L650:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 650 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 651 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2013.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 651 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L652:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 652 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L652:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 652 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L653:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 653 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L653:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 653 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L654:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 654 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L654:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 654 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L655:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 655 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L655:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 655 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 656 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2013.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L656:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 656 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L657:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 657 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2013.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L657:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 657 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 658 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2013.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 658 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 659 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2013.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 659 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 660 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2013.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 660 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 661 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2013.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 661 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 662 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2013.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 662 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L663:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 663 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L663:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 663 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L664:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 664 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoiliu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L664:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 664 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L665:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 665 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L665:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 665 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L666:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 666 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L666:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 666 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 667 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2013.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 667 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L668:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 668 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L668:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 668 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L669:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 669 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L669:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 669 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L670:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 670 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L670:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 670 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L671:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 671 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L671:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 671 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L672:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 672 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2013.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L672:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 672 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L673:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 673 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L673:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 673 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L674:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 674 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L674:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 674 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L675:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 675 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L675:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 675 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L676:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 676 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L676:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 676 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 677 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2013.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 677 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L678:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 678 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L678:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 678 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L679:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 679 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L679:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 679 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L680:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 680 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L680:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 680 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L681:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 681 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L681:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 681 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 682 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2013.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 682 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L683:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 683 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L683:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 683 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L684:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 684 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L684:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 684 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L685:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 685 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L685:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 685 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L686:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 686 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L686:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 686 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 687 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2013.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 687 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L688:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 688 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L688:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 688 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L689:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 689 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L689:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 689 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L690:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 690 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L690:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 690 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L691:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 691 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L691:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 691 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 692 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2013.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 692 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L693:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 693 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2013.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L693:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 693 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L694:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 694 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2013.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L694:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 694 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L695:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 695 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L695:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 695 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L696:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 696 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L696:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 696 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L697:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 697 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L697:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 697 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L698:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 698 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L698:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 698 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L699:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 699 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2013.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L699:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 699 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L700:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 700 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L700:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 700 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L701:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 701 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egom3u13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L701:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 701 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L702:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 702 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L702:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 702 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L703:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 703 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L703:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 703 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L704:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 704 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2013.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L704:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 704 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L705:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 705 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L705:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 705 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L706:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 706 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L706:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 706 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L707:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 707 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L707:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 707 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L708:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 708 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L708:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 708 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L709:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 709 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2013.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L709:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 709 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L710:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 710 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L710:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 710 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L711:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 711 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L711:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 711 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L712:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 712 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L712:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 712 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L713:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 713 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L713:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 713 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 714 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2013.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 714 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L715:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 715 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L715:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 715 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L716:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 716 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L716:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 716 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L717:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 717 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L717:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 717 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L718:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 718 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L718:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 718 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 719 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2013.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 719 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L720:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 720 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L720:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 720 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L721:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 721 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L721:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 721 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L722:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 722 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L722:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 722 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L723:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 723 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L723:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 723 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L724:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 724 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2013.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L724:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 724 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L725:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 725 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L725:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 725 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L726:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 726 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L726:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 726 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L727:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 727 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L727:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 727 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L728:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 728 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L728:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 728 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L729:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 729 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2013.dta") fields("export_any_binary vs_export_any_binary") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L729:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 729 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L730:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 730 748 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L730:step-preserve" "code/annual/merge_mapped_2013.do:L1:file" "statement" 730 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L731:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 731 748 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor13
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L731:step-keep" "code/annual/merge_mapped_2013.do:L1:file" "statement" 731 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L732:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 732 748 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2013.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L732:step-cf" "code/annual/merge_mapped_2013.do:L1:file" "statement" 732 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L733:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 733 748 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L733:step-restore" "code/annual/merge_mapped_2013.do:L1:file" "statement" 733 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 734 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2013.dta") fields("export_direct_flag vs_export_direct_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 734 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 735 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2013.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 735 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L736:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 736 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2013.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L736:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 736 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 737 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2013.dta") fields("innovation_flag vs_innovation_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 737 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 738 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2013.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 738 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 739 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2013.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 739 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 740 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2013.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 740 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L741:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 741 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2013.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L741:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 741 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 742 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2013.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 742 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 743 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2013.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 743 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 744 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2013.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 744 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 745 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2013.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 745 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 746 748 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2013.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2013)
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2013.do:L1:file" "statement" 746 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L747:step-isid" "code/annual/merge_mapped_2013.do:L1:file" "statement" 747 748 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L747:step-isid" "code/annual/merge_mapped_2013.do:L1:file" "statement" 747 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2013.do:L748:step-save" "code/annual/merge_mapped_2013.do:L1:file" "statement" 748 748 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2013.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L748:step-save" "code/annual/merge_mapped_2013.do:L1:file" "statement" 748 748 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
