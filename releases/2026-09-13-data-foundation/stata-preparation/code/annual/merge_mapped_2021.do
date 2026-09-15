* Tujuan: Gabungkan hasil pemetaan kolom tahun 2021 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2021.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2021.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L1:step-do" "code/annual/merge_mapped_2021.do:L1:file" "statement" 1 948 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L1:step-do" "code/annual/merge_mapped_2021.do:L1:file" "statement" 1 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L2:step-do" "code/annual/merge_mapped_2021.do:L1:file" "statement" 2 948 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L2:step-do" "code/annual/merge_mapped_2021.do:L1:file" "statement" 2 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L3:step-use" "code/annual/merge_mapped_2021.do:L1:file" "statement" 3 948 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2021.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L3:step-use" "code/annual/merge_mapped_2021.do:L1:file" "statement" 3 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L4:step-assert" "code/annual/merge_mapped_2021.do:L1:file" "statement" 4 948 `=_rc' // WFLOG-INJECTED
assert source_year==2021
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L4:step-assert" "code/annual/merge_mapped_2021.do:L1:file" "statement" 4 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L5:step-isid" "code/annual/merge_mapped_2021.do:L1:file" "statement" 5 948 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L5:step-isid" "code/annual/merge_mapped_2021.do:L1:file" "statement" 5 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L6:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 6 948 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L6:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 6 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L7:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 7 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_amdal21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L7:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 7 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L8:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 8 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L8:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 8 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L9:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 9 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L9:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 9 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L10:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 10 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2021.dta") fields("amdal_raw vs_amdal_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L10:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 10 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L11:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 11 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2021.dta") fields("b3wste_raw vs_b3wste_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L11:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 11 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L12:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 12 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L12:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 12 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L13:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 13 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L13:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 13 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L14:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 14 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L14:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 14 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L15:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 15 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L15:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 15 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L16:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 16 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2021.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L16:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 16 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L17:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 17 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L17:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 17 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L18:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 18 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L18:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 18 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L19:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 19 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L19:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 19 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L20:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 20 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L20:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 20 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L21:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 21 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2021.dta") fields("capital_nominal vs_capital_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L21:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 21 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L22:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 22 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L22:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 22 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L23:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 23 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L23:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 23 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L24:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 24 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L24:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 24 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L25:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 25 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L25:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 25 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L26:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 26 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2021.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L26:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 26 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L27:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 27 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L27:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 27 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L28:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 28 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L28:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 28 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L29:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 29 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L29:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 29 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L30:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 30 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L30:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 30 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L31:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 31 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2021.dta") fields("export_binary_raw vs_export_binary_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L31:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 31 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L32:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 32 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L32:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 32 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L33:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 33 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L33:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 33 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L34:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 34 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L34:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 34 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L35:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 35 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L35:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 35 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L36:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 36 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2021.dta") fields("export_share_pct vs_export_share_pct") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L36:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 36 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L37:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 37 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L37:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 37 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L38:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 38 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L38:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 38 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L39:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 39 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L39:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 39 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L40:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 40 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L40:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 40 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 41 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2021.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 41 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L42:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 42 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L42:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 42 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L43:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 43 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L43:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 43 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L44:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 44 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L44:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 44 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L45:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 45 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L45:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 45 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L46:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 46 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2021.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L46:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 46 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L47:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 47 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L47:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 47 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L48:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 48 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L48:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 48 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L49:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 49 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L49:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 49 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L50:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 50 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L50:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 50 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 51 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2021.dta") fields("import_value_nominal vs_import_value_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 51 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 52 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2021.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 52 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 53 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2021.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 53 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L54:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 54 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2021.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L54:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 54 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L55:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 55 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2021.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L55:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 55 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L56:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 56 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L56:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 56 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L57:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 57 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inov21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L57:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 57 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L58:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 58 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L58:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 58 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L59:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 59 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L59:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 59 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 60 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2021.dta") fields("innovation_raw vs_innovation_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 60 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L61:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 61 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L61:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 61 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L62:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 62 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inspli21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L62:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 62 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L63:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 63 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L63:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 63 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L64:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 64 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L64:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 64 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 65 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2021.dta") fields("inspli_raw vs_inspli_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 65 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L66:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 66 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L66:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 66 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L67:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 67 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L67:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 67 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L68:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 68 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L68:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 68 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L69:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 69 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L69:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 69 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 70 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2021.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 70 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 71 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2021.dta") fields("liwste_raw vs_liwste_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 71 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L72:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 72 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L72:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 72 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L73:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 73 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_pplihi21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L73:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 73 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L74:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 74 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L74:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 74 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L75:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 75 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L75:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 75 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 76 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2021.dta") fields("pplihi_raw vs_pplihi_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 76 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L77:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 77 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L77:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 77 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L78:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 78 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L78:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 78 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L79:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 79 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L79:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 79 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L80:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 80 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L80:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 80 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 81 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2021.dta") fields("production_workers vs_production_workers") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 81 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L82:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 82 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L82:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 82 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L83:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 83 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L83:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 83 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L84:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 84 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L84:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 84 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L85:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 85 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L85:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 85 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 86 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2021.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 86 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L87:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 87 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L87:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 87 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L88:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 88 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L88:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 88 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L89:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 89 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L89:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 89 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L90:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 90 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L90:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 90 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 91 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2021.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 91 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L92:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 92 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L92:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 92 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L93:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 93 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlrnd21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L93:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 93 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L94:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 94 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_workers_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L94:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 94 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L95:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 95 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L95:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 95 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 96 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2021.dta") fields("rd_workers vs_rd_workers") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 96 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 97 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2021.dta") fields("sowste_raw vs_sowste_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 97 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L98:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 98 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L98:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 98 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L99:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 99 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_spplhi21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L99:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 99 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L100:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 100 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L100:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 100 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L101:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 101 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L101:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 101 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 102 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2021.dta") fields("spplhi_raw vs_spplhi_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 102 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 103 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2021.dta") fields("val_cbdacu vs_val_cbdacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 103 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L104:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 104 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L104:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 104 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L105:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 105 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L105:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 105 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L106:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 106 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L106:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 106 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L107:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 107 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L107:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 107 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 108 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2021.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 108 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L109:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 109 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L109:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 109 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L110:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 110 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L110:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 110 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L111:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 111 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L111:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 111 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L112:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 112 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L112:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 112 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 113 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2021.dta") fields("val_cbsacu vs_val_cbsacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 113 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L114:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 114 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L114:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 114 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L115:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 115 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L115:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 115 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L116:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 116 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L116:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 116 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L117:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 117 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L117:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 117 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 118 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2021.dta") fields("val_cbttcu vs_val_cbttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 118 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L119:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 119 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2021.dta") fields("val_cldacu vs_val_cldacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L119:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 119 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L120:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 120 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L120:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 120 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L121:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 121 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L121:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 121 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L122:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 122 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L122:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 122 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L123:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 123 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L123:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 123 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 124 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2021.dta") fields("val_clfpcu vs_val_clfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 124 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L125:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 125 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L125:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 125 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L126:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 126 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L126:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 126 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L127:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 127 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L127:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 127 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L128:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 128 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L128:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 128 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 129 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2021.dta") fields("val_clsacu vs_val_clsacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 129 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L130:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 130 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L130:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 130 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L131:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 131 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L131:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 131 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L132:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 132 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L132:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 132 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L133:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 133 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L133:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 133 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L134:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 134 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2021.dta") fields("val_clttcu vs_val_clttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L134:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 134 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 135 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2021.dta") fields("val_cmdacu vs_val_cmdacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 135 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L136:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 136 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L136:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 136 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L137:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 137 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L137:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 137 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L138:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 138 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L138:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 138 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L139:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 139 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L139:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 139 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 140 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2021.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 140 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L141:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 141 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L141:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 141 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L142:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 142 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L142:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 142 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L143:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 143 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L143:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 143 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L144:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 144 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L144:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 144 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 145 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2021.dta") fields("val_cmsacu vs_val_cmsacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 145 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L146:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 146 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L146:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 146 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L147:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 147 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L147:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 147 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L148:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 148 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L148:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 148 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L149:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 149 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L149:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 149 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 150 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2021.dta") fields("val_cmttcu vs_val_cmttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 150 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 151 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2021.dta") fields("val_codacu vs_val_codacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 151 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L152:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 152 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L152:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 152 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L153:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 153 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cofpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L153:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 153 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L154:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 154 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L154:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 154 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L155:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 155 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L155:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 155 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 156 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2021.dta") fields("val_cofpcu vs_val_cofpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 156 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L157:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 157 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L157:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 157 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L158:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 158 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L158:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 158 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L159:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 159 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L159:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 159 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L160:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 160 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L160:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 160 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 161 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2021.dta") fields("val_cosacu vs_val_cosacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 161 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L162:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 162 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L162:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 162 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L163:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 163 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L163:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 163 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L164:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 164 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_costrd_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L164:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 164 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L165:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 165 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L165:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 165 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 166 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2021.dta") fields("val_costrd vs_val_costrd") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 166 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L167:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 167 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L167:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 167 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L168:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 168 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L168:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 168 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L169:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 169 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L169:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 169 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L170:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 170 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L170:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 170 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 171 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2021.dta") fields("val_cottcu vs_val_cottcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 171 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 172 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2021.dta") fields("val_csdacu vs_val_csdacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 172 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L173:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 173 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L173:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 173 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L174:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 174 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L174:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 174 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L175:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 175 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L175:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 175 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L176:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 176 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L176:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 176 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 177 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2021.dta") fields("val_csfpcu vs_val_csfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 177 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L178:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 178 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L178:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 178 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L179:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 179 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cssacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L179:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 179 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L180:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 180 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L180:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 180 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L181:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 181 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L181:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 181 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 182 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2021.dta") fields("val_cssacu vs_val_cssacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 182 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L183:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 183 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L183:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 183 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L184:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 184 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L184:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 184 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L185:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 185 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L185:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 185 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L186:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 186 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L186:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 186 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 187 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2021.dta") fields("val_csttcu vs_val_csttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 187 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 188 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2021.dta") fields("val_ctdacu vs_val_ctdacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 188 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L189:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 189 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L189:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 189 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L190:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 190 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L190:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 190 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L191:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 191 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L191:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 191 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L192:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 192 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L192:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 192 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 193 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2021.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 193 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L194:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 194 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L194:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 194 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L195:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 195 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L195:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 195 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L196:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 196 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L196:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 196 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L197:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 197 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L197:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 197 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 198 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2021.dta") fields("val_ctsacu vs_val_ctsacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 198 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 199 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2021.dta") fields("val_cttcu vs_val_cttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 199 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L200:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 200 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L200:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 200 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L201:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 201 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L201:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 201 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L202:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 202 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L202:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 202 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L203:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 203 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L203:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 203 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 204 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2021.dta") fields("val_ctttcu vs_val_ctttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 204 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L205:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 205 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2021.dta") fields("val_cvdacu vs_val_cvdacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L205:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 205 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L206:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 206 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L206:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 206 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L207:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 207 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvfpcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L207:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 207 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L208:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 208 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L208:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 208 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L209:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 209 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L209:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 209 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 210 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2021.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 210 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L211:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 211 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L211:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 211 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L212:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 212 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L212:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 212 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L213:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 213 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L213:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 213 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L214:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 214 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L214:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 214 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 215 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2021.dta") fields("val_cvsacu vs_val_cvsacu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 215 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L216:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 216 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L216:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 216 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L217:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 217 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L217:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 217 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L218:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 218 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L218:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 218 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L219:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 219 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L219:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 219 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 220 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2021.dta") fields("val_cvttcu vs_val_cvttcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 220 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 221 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2021.dta") fields("val_devvcu vs_val_devvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 221 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L222:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 222 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L222:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 222 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L223:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 223 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L223:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 223 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L224:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 224 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L224:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 224 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L225:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 225 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L225:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 225 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 226 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2021.dta") fields("val_ecavce vs_val_ecavce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 226 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L227:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 227 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L227:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 227 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L228:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 228 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L228:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 228 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L229:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 229 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L229:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 229 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L230:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 230 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L230:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 230 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 231 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2021.dta") fields("val_ecavcu vs_val_ecavcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 231 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L232:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 232 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L232:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 232 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L233:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 233 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L233:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 233 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L234:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 234 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L234:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 234 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L235:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 235 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L235:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 235 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 236 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2021.dta") fields("val_ecbvce vs_val_ecbvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 236 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L237:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 237 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L237:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 237 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L238:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 238 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L238:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 238 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L239:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 239 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L239:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 239 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L240:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 240 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L240:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 240 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 241 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2021.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 241 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 242 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2021.dta") fields("val_eckvce vs_val_eckvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 242 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 243 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2021.dta") fields("val_eckvcu vs_val_eckvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 243 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L244:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 244 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L244:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 244 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L245:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 245 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L245:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 245 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L246:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 246 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L246:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 246 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L247:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 247 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L247:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 247 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L248:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 248 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2021.dta") fields("val_eclvce vs_val_eclvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L248:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 248 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L249:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 249 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L249:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 249 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L250:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 250 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L250:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 250 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L251:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 251 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L251:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 251 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L252:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 252 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L252:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 252 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L253:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 253 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2021.dta") fields("val_eclvcu vs_val_eclvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L253:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 253 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L254:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 254 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L254:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 254 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L255:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 255 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L255:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 255 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L256:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 256 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_edivce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L256:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 256 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L257:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 257 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L257:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 257 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L258:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 258 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2021.dta") fields("val_edivce vs_val_edivce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L258:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 258 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L259:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 259 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L259:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 259 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L260:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 260 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L260:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 260 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L261:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 261 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L261:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 261 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L262:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 262 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L262:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 262 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 263 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2021.dta") fields("val_edivcu vs_val_edivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 263 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L264:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 264 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L264:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 264 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L265:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 265 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L265:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 265 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L266:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 266 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efovce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L266:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 266 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L267:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 267 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L267:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 267 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 268 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2021.dta") fields("val_efovce vs_val_efovce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 268 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L269:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 269 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L269:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 269 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L270:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 270 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L270:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 270 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L271:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 271 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L271:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 271 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L272:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 272 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L272:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 272 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 273 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2021.dta") fields("val_efovcu vs_val_efovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 273 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L274:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 274 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L274:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 274 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L275:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 275 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L275:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 275 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L276:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 276 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L276:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 276 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L277:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 277 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L277:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 277 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 278 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2021.dta") fields("val_efuvce vs_val_efuvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 278 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L279:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 279 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L279:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 279 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L280:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 280 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L280:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 280 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L281:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 281 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L281:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 281 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L282:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 282 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L282:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 282 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 283 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2021.dta") fields("val_efuvcu vs_val_efuvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 283 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 284 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2021.dta") fields("val_egavce vs_val_egavce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 284 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 285 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2021.dta") fields("val_egavcu vs_val_egavcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 285 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 286 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2021.dta") fields("val_egovce vs_val_egovce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 286 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 287 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2021.dta") fields("val_egovcu vs_val_egovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 287 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L288:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 288 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L288:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 288 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L289:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 289 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L289:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 289 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L290:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 290 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L290:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 290 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L291:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 291 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L291:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 291 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 292 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2021.dta") fields("val_elpvce vs_val_elpvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 292 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L293:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 293 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L293:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 293 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L294:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 294 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L294:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 294 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L295:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 295 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L295:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 295 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L296:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 296 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L296:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 296 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 297 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2021.dta") fields("val_elpvcu vs_val_elpvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 297 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L298:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 298 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L298:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 298 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L299:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 299 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L299:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 299 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L300:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 300 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L300:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 300 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L301:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 301 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L301:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 301 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L302:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 302 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2021.dta") fields("val_eluvce vs_val_eluvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L302:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 302 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L303:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 303 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L303:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 303 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L304:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 304 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L304:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 304 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L305:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 305 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L305:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 305 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L306:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 306 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L306:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 306 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 307 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2021.dta") fields("val_eluvcu vs_val_eluvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 307 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L308:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 308 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L308:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 308 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L309:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 309 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L309:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 309 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L310:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 310 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L310:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 310 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L311:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 311 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L311:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 311 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 312 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2021.dta") fields("val_encvce vs_val_encvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 312 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L313:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 313 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L313:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 313 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L314:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 314 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L314:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 314 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L315:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 315 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L315:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 315 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L316:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 316 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L316:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 316 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 317 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2021.dta") fields("val_encvcu vs_val_encvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 317 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L318:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 318 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L318:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 318 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L319:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 319 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L319:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 319 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L320:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 320 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_engvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L320:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 320 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L321:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 321 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L321:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 321 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L322:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 322 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2021.dta") fields("val_engvce vs_val_engvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L322:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 322 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L323:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 323 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L323:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 323 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L324:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 324 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L324:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 324 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L325:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 325 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L325:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 325 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L326:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 326 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L326:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 326 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 327 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2021.dta") fields("val_engvcu vs_val_engvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 327 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L328:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 328 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L328:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 328 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L329:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 329 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L329:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 329 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L330:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 330 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L330:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 330 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L331:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 331 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L331:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 331 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 332 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2021.dta") fields("val_enpvcu vs_val_enpvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 332 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 333 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2021.dta") fields("val_eoivce vs_val_eoivce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 333 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 334 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2021.dta") fields("val_eoivcu vs_val_eoivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 334 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L335:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 335 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L335:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 335 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L336:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 336 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L336:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 336 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L337:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 337 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L337:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 337 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L338:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 338 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L338:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 338 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L339:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 339 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2021.dta") fields("val_epevce vs_val_epevce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L339:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 339 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L340:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 340 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L340:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 340 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L341:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 341 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L341:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 341 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L342:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 342 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L342:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 342 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L343:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 343 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L343:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 343 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 344 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2021.dta") fields("val_epevcu vs_val_epevcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 344 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L345:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 345 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L345:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 345 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L346:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 346 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L346:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 346 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L347:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 347 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L347:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 347 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L348:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 348 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L348:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 348 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 349 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2021.dta") fields("val_eplvcu vs_val_eplvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 349 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L350:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 350 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L350:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 350 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L351:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 351 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esdvce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L351:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 351 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L352:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 352 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L352:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 352 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L353:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 353 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L353:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 353 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 354 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2021.dta") fields("val_esdvce vs_val_esdvce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 354 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L355:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 355 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L355:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 355 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L356:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 356 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L356:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 356 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L357:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 357 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L357:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 357 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L358:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 358 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L358:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 358 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 359 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2021.dta") fields("val_esdvcu vs_val_esdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 359 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L360:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 360 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L360:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 360 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L361:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 361 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L361:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 361 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L362:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 362 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L362:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 362 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L363:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 363 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L363:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 363 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 364 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2021.dta") fields("val_esovce vs_val_esovce") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 364 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L365:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 365 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L365:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 365 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L366:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 366 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L366:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 366 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L367:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 367 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L367:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 367 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L368:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 368 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L368:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 368 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L369:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 369 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2021.dta") fields("val_esovcu vs_val_esovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L369:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 369 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L370:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 370 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L370:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 370 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L371:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 371 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L371:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 371 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L372:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 372 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L372:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 372 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L373:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 373 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L373:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 373 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L374:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 374 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2021.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L374:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 374 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L375:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 375 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L375:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 375 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L376:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 376 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L376:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 376 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L377:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 377 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L377:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 377 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L378:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 378 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L378:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 378 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L379:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 379 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2021.dta") fields("val_icovcu vs_val_icovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L379:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 379 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L380:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 380 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L380:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 380 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L381:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 381 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_idevcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L381:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 381 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L382:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 382 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L382:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 382 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L383:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 383 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L383:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 383 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 384 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2021.dta") fields("val_idevcu vs_val_idevcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 384 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L385:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 385 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L385:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 385 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L386:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 386 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L386:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 386 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L387:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 387 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L387:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 387 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L388:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 388 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L388:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 388 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 389 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2021.dta") fields("val_iinput vs_val_iinput") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 389 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L390:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 390 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L390:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 390 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L391:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 391 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L391:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 391 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L392:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 392 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L392:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 392 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L393:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 393 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L393:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 393 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 394 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2021.dta") fields("val_iinvcu vs_val_iinvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 394 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L395:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 395 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L395:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 395 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L396:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 396 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisfov21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L396:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 396 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L397:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 397 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L397:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 397 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L398:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 398 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L398:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 398 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 399 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2021.dta") fields("val_iisfov vs_val_iisfov") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 399 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L400:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 400 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L400:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 400 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L401:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 401 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iislov21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L401:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 401 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L402:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 402 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iislov_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L402:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 402 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L403:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 403 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L403:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 403 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 404 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2021.dta") fields("val_iislov vs_val_iislov") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L404:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 404 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 405 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2021.dta") fields("val_iisvcu vs_val_iisvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 405 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 406 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2021.dta") fields("val_ikivcu vs_val_ikivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 406 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L407:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 407 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L407:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 407 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L408:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 408 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iklvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L408:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 408 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L409:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 409 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L409:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 409 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L410:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 410 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L410:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 410 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 411 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2021.dta") fields("val_iklvcu vs_val_iklvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L411:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 411 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L412:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 412 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L412:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 412 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L413:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 413 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L413:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 413 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L414:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 414 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L414:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 414 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L415:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 415 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L415:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 415 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L416:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 416 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2021.dta") fields("val_ikovcu vs_val_ikovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L416:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 416 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L417:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 417 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L417:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 417 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L418:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 418 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L418:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 418 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L419:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 419 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L419:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 419 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L420:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 420 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L420:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 420 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L421:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 421 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2021.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L421:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 421 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L422:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 422 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2021.dta") fields("val_insvcu vs_val_insvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L422:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 422 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 423 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2021.dta") fields("val_intvcu vs_val_intvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 423 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L424:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 424 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L424:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 424 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L425:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 425 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L425:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 425 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L426:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 426 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L426:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 426 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L427:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 427 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L427:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 427 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 428 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2021.dta") fields("val_iotvcu vs_val_iotvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 428 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L429:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 429 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L429:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 429 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L430:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 430 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ipkvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L430:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 430 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L431:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 431 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L431:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 431 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L432:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 432 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L432:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 432 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 433 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2021.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 433 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L434:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 434 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L434:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 434 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L435:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 435 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iprvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L435:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 435 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L436:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 436 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L436:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 436 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L437:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 437 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L437:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 437 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 438 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2021.dta") fields("val_iprvcu vs_val_iprvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 438 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L439:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 439 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L439:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 439 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L440:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 440 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L440:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 440 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L441:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 441 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L441:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 441 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L442:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 442 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L442:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 442 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 443 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2021.dta") fields("val_irdvcu vs_val_irdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 443 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 444 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2021.dta") fields("val_irevcu vs_val_irevcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 444 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L445:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 445 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2021.dta") fields("val_irrvcu vs_val_irrvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L445:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 445 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L446:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 446 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L446:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 446 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L447:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 447 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L447:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 447 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L448:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 448 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L448:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 448 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L449:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 449 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L449:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 449 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L450:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 450 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2021.dta") fields("val_itxvcu vs_val_itxvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L450:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 450 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L451:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 451 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L451:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 451 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L452:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 452 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iuwvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L452:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 452 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L453:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 453 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L453:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 453 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L454:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 454 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L454:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 454 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 455 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2021.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 455 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L456:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 456 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L456:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 456 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L457:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 457 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_nopvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L457:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 457 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L458:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 458 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L458:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 458 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L459:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 459 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L459:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 459 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L460:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 460 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2021.dta") fields("val_nopvcu vs_val_nopvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L460:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 460 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 461 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2021.dta") fields("val_othvcu vs_val_othvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 461 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L462:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 462 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L462:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 462 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L463:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 463 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L463:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 463 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L464:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 464 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L464:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 464 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L465:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 465 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L465:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 465 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L466:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 466 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2021.dta") fields("val_output vs_val_output") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L466:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 466 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L467:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 467 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L467:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 467 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L468:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 468 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L468:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 468 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L469:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 469 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L469:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 469 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L470:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 470 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L470:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 470 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 471 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2021.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 471 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L472:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 472 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2021.dta") fields("val_renvcu vs_val_renvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L472:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 472 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L473:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 473 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L473:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 473 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L474:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 474 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L474:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 474 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L475:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 475 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L475:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 475 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L476:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 476 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L476:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 476 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 477 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2021.dta") fields("val_rimvcu vs_val_rimvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 477 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L478:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 478 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L478:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 478 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L479:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 479 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L479:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 479 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L480:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 480 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L480:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 480 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L481:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 481 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L481:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 481 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 482 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2021.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 482 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L483:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 483 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L483:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 483 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L484:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 484 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfbvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L484:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 484 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L485:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 485 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L485:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 485 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L486:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 486 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L486:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 486 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 487 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2021.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 487 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L488:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 488 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L488:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 488 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L489:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 489 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfcvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L489:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 489 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L490:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 490 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L490:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 490 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L491:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 491 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L491:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 491 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 492 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2021.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 492 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L493:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 493 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L493:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 493 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L494:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 494 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L494:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 494 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L495:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 495 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L495:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 495 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L496:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 496 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L496:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 496 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 497 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2021.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 497 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L498:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 498 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L498:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 498 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L499:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 499 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfgvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L499:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 499 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L500:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 500 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L500:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 500 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L501:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 501 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L501:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 501 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 502 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2021.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 502 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L503:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 503 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L503:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 503 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L504:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 504 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L504:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 504 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L505:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 505 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L505:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 505 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L506:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 506 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L506:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 506 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 507 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2021.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 507 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L508:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 508 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L508:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 508 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L509:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 509 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfkvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L509:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 509 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L510:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 510 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L510:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 510 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L511:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 511 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L511:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 511 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 512 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2021.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 512 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L513:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 513 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L513:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 513 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L514:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 514 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L514:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 514 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L515:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 515 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L515:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 515 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L516:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 516 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L516:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 516 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 517 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2021.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 517 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L518:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 518 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L518:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 518 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L519:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 519 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L519:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 519 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L520:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 520 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L520:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 520 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L521:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 521 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L521:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 521 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 522 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2021.dta") fields("val_sfovcu vs_val_sfovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 522 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L523:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 523 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L523:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 523 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L524:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 524 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfrvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L524:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 524 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L525:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 525 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L525:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 525 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L526:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 526 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L526:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 526 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 527 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2021.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 527 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L528:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 528 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L528:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 528 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L529:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 529 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfsvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L529:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 529 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L530:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 530 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L530:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 530 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L531:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 531 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L531:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 531 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 532 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2021.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 532 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L533:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 533 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L533:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 533 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L534:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 534 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfuvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L534:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 534 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L535:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 535 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L535:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 535 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L536:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 536 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L536:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 536 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 537 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2021.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 537 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L538:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 538 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L538:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 538 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L539:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 539 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L539:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 539 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L540:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 540 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L540:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 540 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L541:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 541 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L541:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 541 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 542 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2021.dta") fields("val_shdvcu vs_val_shdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 542 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L543:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 543 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L543:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 543 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L544:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 544 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L544:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 544 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L545:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 545 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L545:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 545 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L546:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 546 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L546:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 546 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 547 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2021.dta") fields("val_shfvcu vs_val_shfvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 547 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L548:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 548 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L548:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 548 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L549:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 549 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L549:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 549 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L550:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 550 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L550:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 550 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L551:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 551 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L551:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 551 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 552 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2021.dta") fields("val_shjvcu vs_val_shjvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 552 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L553:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 553 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L553:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 553 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L554:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 554 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L554:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 554 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L555:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 555 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L555:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 555 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L556:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 556 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L556:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 556 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 557 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2021.dta") fields("val_srdvcu vs_val_srdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 557 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L558:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 558 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L558:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 558 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L559:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 559 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L559:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 559 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L560:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 560 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L560:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 560 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L561:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 561 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L561:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 561 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 562 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2021.dta") fields("val_srjvcu vs_val_srjvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 562 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L563:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 563 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L563:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 563 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L564:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 564 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L564:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 564 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L565:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 565 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L565:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 565 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L566:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 566 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L566:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 566 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 567 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2021.dta") fields("val_srmvcu vs_val_srmvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 567 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L568:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 568 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L568:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 568 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L569:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 569 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L569:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 569 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L570:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 570 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L570:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 570 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L571:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 571 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L571:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 571 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 572 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2021.dta") fields("val_stdvcu vs_val_stdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 572 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L573:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 573 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L573:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 573 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L574:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 574 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L574:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 574 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L575:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 575 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L575:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 575 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L576:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 576 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L576:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 576 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 577 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2021.dta") fields("val_stjvcu vs_val_stjvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 577 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L578:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 578 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L578:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 578 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L579:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 579 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L579:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 579 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L580:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 580 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L580:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 580 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L581:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 581 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L581:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 581 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 582 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2021.dta") fields("val_stlvcu vs_val_stlvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 582 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L583:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 583 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L583:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 583 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L584:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 584 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L584:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 584 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L585:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 585 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L585:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 585 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L586:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 586 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L586:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 586 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L587:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 587 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2021.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L587:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 587 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L588:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 588 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L588:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 588 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L589:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 589 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L589:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 589 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L590:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 590 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L590:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 590 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L591:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 591 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L591:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 591 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L592:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 592 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2021.dta") fields("val_yelvcu vs_val_yelvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L592:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 592 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L593:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 593 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L593:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 593 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L594:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 594 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L594:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 594 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L595:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 595 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L595:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 595 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L596:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 596 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L596:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 596 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 597 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2021.dta") fields("val_yisvcu vs_val_yisvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 597 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L598:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 598 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L598:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 598 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L599:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 599 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L599:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 599 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L600:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 600 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L600:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 600 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L601:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 601 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L601:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 601 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 602 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2021.dta") fields("val_yisvdo vs_val_yisvdo") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 602 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L603:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 603 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L603:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 603 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L604:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 604 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L604:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 604 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L605:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 605 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L605:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 605 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L606:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 606 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L606:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 606 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 607 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2021.dta") fields("val_yisvfo vs_val_yisvfo") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 607 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L608:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 608 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L608:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 608 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L609:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 609 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L609:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 609 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L610:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 610 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L610:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 610 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L611:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 611 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L611:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 611 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L612:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 612 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2021.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L612:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 612 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L613:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 613 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L613:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 613 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L614:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 614 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykfvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L614:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 614 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L615:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 615 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L615:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 615 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L616:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 616 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L616:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 616 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L617:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 617 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2021.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L617:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 617 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 618 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2021.dta") fields("val_ykivcu vs_val_ykivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 618 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L619:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 619 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L619:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 619 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L620:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 620 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L620:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 620 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L621:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 621 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L621:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 621 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L622:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 622 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L622:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 622 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L623:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 623 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2021.dta") fields("val_yprvcu vs_val_yprvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L623:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 623 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L624:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 624 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L624:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 624 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L625:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 625 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L625:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 625 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L626:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 626 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L626:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 626 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L627:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 627 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L627:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 627 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 628 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2021.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L628:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 628 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L629:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 629 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L629:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 629 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L630:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 630 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrsvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L630:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 630 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L631:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 631 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L631:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 631 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L632:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 632 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L632:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 632 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 633 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2021.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 633 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L634:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 634 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L634:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 634 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L635:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 635 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ysnvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L635:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 635 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L636:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 636 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L636:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 636 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L637:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 637 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L637:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 637 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 638 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2021.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 638 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L639:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 639 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L639:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 639 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L640:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 640 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ytovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L640:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 640 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L641:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 641 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L641:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 641 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L642:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 642 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L642:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 642 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 643 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2021.dta") fields("val_ytovcu vs_val_ytovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 643 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 644 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2021.dta") fields("val_znavcu vs_val_znavcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L644:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 644 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L645:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 645 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L645:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 645 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L646:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 646 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L646:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 646 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L647:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 647 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L647:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 647 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L648:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 648 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L648:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 648 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L649:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 649 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2021.dta") fields("val_zndvcu vs_val_zndvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L649:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 649 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L650:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 650 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L650:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 650 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L651:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 651 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znevcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L651:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 651 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L652:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 652 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L652:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 652 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L653:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 653 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L653:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 653 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 654 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2021.dta") fields("val_znevcu vs_val_znevcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 654 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L655:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 655 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L655:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 655 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L656:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 656 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znhvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L656:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 656 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L657:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 657 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L657:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 657 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L658:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 658 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L658:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 658 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 659 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2021.dta") fields("val_znhvcu vs_val_znhvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 659 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 660 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2021.dta") fields("val_znivcu vs_val_znivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 660 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 661 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2021.dta") fields("val_znovcu vs_val_znovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L661:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 661 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 662 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2021.dta") fields("val_znpvcu vs_val_znpvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L662:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 662 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L663:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 663 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L663:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 663 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L664:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 664 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znrvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L664:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 664 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L665:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 665 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L665:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 665 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L666:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 666 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L666:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 666 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 667 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2021.dta") fields("val_znrvcu vs_val_znrvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 667 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 668 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2021.dta") fields("val_znsvcu vs_val_znsvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 668 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L669:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 669 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L669:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 669 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L670:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 670 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zntvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L670:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 670 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L671:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 671 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L671:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 671 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L672:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 672 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L672:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 672 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 673 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2021.dta") fields("val_zntvcu vs_val_zntvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 673 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L674:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 674 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2021.dta") fields("val_zpavcu vs_val_zpavcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L674:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 674 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L675:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 675 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L675:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 675 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L676:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 676 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L676:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 676 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L677:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 677 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L677:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 677 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L678:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 678 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L678:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 678 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L679:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 679 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2021.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L679:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 679 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L680:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 680 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L680:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 680 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L681:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 681 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpevcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L681:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 681 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L682:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 682 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L682:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 682 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L683:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 683 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L683:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 683 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L684:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 684 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2021.dta") fields("val_zpevcu vs_val_zpevcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L684:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 684 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L685:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 685 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L685:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 685 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L686:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 686 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zphvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L686:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 686 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L687:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 687 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L687:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 687 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L688:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 688 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L688:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 688 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 689 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2021.dta") fields("val_zphvcu vs_val_zphvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 689 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 690 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2021.dta") fields("val_zpivcu vs_val_zpivcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 690 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L691:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 691 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2021.dta") fields("val_zpovcu vs_val_zpovcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L691:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 691 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 692 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2021.dta") fields("val_zppvcu vs_val_zppvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 692 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L693:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 693 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L693:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 693 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L694:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 694 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zprvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L694:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 694 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L695:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 695 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L695:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 695 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L696:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 696 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L696:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 696 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 697 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2021.dta") fields("val_zprvcu vs_val_zprvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 697 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L698:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 698 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2021.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L698:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 698 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L699:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 699 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L699:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 699 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L700:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 700 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zptvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L700:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 700 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L701:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 701 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L701:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 701 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L702:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 702 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L702:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 702 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L703:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 703 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2021.dta") fields("val_zptvcu vs_val_zptvcu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L703:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 703 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L704:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 704 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L704:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 704 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L705:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 705 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L705:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 705 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L706:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 706 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L706:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 706 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L707:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 707 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L707:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 707 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 708 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2021.dta") fields("value_added_nominal vs_value_added_nominal") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 708 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L709:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 709 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L709:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 709 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L710:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 710 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L710:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 710 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L711:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 711 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L711:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 711 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L712:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 712 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L712:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 712 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 713 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2021.dta") fields("workers vs_workers") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 713 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L714:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 714 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L714:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 714 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L715:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 715 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L715:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 715 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L716:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 716 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L716:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 716 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L717:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 717 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L717:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 717 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L718:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 718 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2021.dta") fields("source_id_raw vs_source_id_raw") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L718:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 718 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L719:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 719 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L719:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 719 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L720:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 720 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L720:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 720 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L721:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 721 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L721:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 721 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L722:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 722 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L722:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 722 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L723:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 723 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2021.dta") fields("district_code vs_district_code") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L723:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 723 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L724:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 724 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L724:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 724 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L725:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 725 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic521
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L725:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 725 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L726:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 726 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L726:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 726 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L727:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 727 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L727:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 727 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L728:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 728 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2021.dta") fields("industry_code vs_industry_code") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L728:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 728 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L729:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 729 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L729:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 729 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L730:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 730 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L730:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 730 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L731:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 731 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L731:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 731 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L732:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 732 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L732:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 732 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 733 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2021.dta") fields("province_code vs_province_code") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 733 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L734:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 734 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L734:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 734 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L735:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 735 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L735:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 735 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L736:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 736 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L736:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 736 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L737:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 737 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L737:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 737 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 738 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2021.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L738:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 738 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L739:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 739 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L739:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 739 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L740:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 740 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L740:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 740 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L741:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 741 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L741:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 741 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L742:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 742 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L742:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 742 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 743 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2021.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 743 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L744:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 744 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L744:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 744 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L745:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 745 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L745:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 745 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L746:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 746 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L746:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 746 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L747:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 747 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L747:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 747 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 748 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2021.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 748 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L749:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 749 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L749:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 749 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L750:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 750 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L750:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 750 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L751:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 751 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L751:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 751 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L752:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 752 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L752:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 752 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 753 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2021.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 753 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L754:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 754 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L754:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 754 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L755:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 755 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L755:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 755 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L756:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 756 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L756:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 756 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L757:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 757 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L757:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 757 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L758:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 758 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2021.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L758:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 758 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L759:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 759 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L759:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 759 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L760:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 760 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esdliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L760:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 760 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L761:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 761 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L761:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 761 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L762:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 762 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L762:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 762 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L763:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 763 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2021.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L763:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 763 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L764:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 764 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L764:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 764 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L765:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 765 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esdvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L765:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 765 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L766:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 766 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L766:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 766 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L767:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 767 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L767:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 767 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L768:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 768 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2021.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L768:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 768 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L769:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 769 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L769:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 769 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L770:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 770 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecakgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L770:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 770 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L771:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 771 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L771:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 771 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L772:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 772 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L772:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 772 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L773:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 773 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2021.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L773:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 773 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L774:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 774 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L774:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 774 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L775:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 775 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L775:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 775 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L776:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 776 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L776:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 776 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L777:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 777 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L777:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 777 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L778:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 778 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2021.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L778:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 778 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 779 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2021.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 779 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L780:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 780 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2021.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L780:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 780 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L781:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 781 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L781:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 781 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L782:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 782 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L782:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 782 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L783:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 783 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L783:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 783 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L784:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 784 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L784:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 784 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L785:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 785 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2021.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L785:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 785 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L786:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 786 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L786:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 786 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L787:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 787 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L787:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 787 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L788:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 788 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L788:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 788 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L789:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 789 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L789:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 789 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L790:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 790 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2021.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L790:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 790 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L791:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 791 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L791:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 791 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L792:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 792 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L792:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 792 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L793:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 793 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L793:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 793 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L794:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 794 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L794:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 794 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L795:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 795 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2021.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L795:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 795 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L796:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 796 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L796:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 796 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L797:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 797 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L797:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 797 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L798:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 798 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L798:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 798 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L799:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 799 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L799:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 799 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L800:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 800 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2021.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L800:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 800 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L801:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 801 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2021.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L801:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 801 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L802:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 802 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2021.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L802:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 802 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L803:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 803 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L803:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 803 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L804:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 804 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L804:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 804 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L805:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 805 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L805:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 805 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L806:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 806 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L806:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 806 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 807 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2021.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 807 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L808:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 808 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L808:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 808 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L809:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 809 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L809:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 809 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L810:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 810 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L810:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 810 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L811:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 811 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L811:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 811 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 812 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2021.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L812:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 812 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L813:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 813 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L813:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 813 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L814:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 814 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ediliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L814:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 814 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L815:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 815 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L815:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 815 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L816:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 816 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L816:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 816 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L817:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 817 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2021.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L817:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 817 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L818:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 818 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L818:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 818 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L819:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 819 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L819:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 819 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L820:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 820 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L820:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 820 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L821:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 821 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L821:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 821 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L822:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 822 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2021.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L822:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 822 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L823:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 823 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2021.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L823:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 823 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L824:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 824 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2021.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L824:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 824 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L825:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 825 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L825:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 825 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L826:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 826 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efoliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L826:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 826 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L827:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 827 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L827:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 827 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L828:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 828 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L828:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 828 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L829:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 829 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2021.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L829:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 829 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L830:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 830 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L830:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 830 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L831:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 831 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L831:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 831 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L832:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 832 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L832:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 832 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L833:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 833 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L833:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 833 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L834:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 834 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2021.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L834:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 834 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L835:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 835 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2021.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L835:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 835 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L836:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 836 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2021.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L836:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 836 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L837:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 837 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L837:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 837 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L838:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 838 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L838:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 838 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L839:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 839 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L839:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 839 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L840:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 840 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L840:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 840 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L841:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 841 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2021.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L841:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 841 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L842:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 842 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L842:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 842 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L843:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 843 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L843:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 843 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L844:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 844 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L844:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 844 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L845:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 845 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L845:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 845 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L846:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 846 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2021.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L846:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 846 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L847:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 847 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L847:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 847 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L848:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 848 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L848:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 848 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L849:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 849 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L849:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 849 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L850:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 850 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L850:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 850 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L851:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 851 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2021.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L851:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 851 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L852:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 852 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L852:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 852 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L853:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 853 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L853:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 853 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L854:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 854 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L854:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 854 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L855:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 855 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L855:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 855 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L856:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 856 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2021.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L856:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 856 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L857:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 857 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L857:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 857 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L858:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 858 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engkgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L858:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 858 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L859:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 859 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L859:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 859 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L860:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 860 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L860:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 860 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L861:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 861 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2021.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L861:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 861 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L862:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 862 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L862:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 862 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L863:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 863 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L863:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 863 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L864:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 864 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L864:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 864 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L865:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 865 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L865:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 865 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L866:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 866 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2021.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L866:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 866 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L867:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 867 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L867:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 867 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L868:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 868 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L868:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 868 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L869:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 869 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L869:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 869 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L870:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 870 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L870:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 870 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L871:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 871 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2021.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L871:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 871 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L872:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 872 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2021.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L872:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 872 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L873:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 873 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2021.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L873:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 873 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L874:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 874 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L874:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 874 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L875:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 875 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L875:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 875 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L876:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 876 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L876:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 876 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L877:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 877 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L877:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 877 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L878:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 878 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2021.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L878:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 878 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L879:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 879 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L879:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 879 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L880:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 880 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L880:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 880 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L881:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 881 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L881:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 881 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L882:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 882 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L882:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 882 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L883:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 883 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2021.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L883:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 883 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L884:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 884 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L884:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 884 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L885:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 885 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L885:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 885 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L886:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 886 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L886:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 886 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L887:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 887 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L887:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 887 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L888:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 888 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2021.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L888:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 888 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L889:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 889 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L889:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 889 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L890:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 890 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L890:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 890 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L891:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 891 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L891:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 891 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L892:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 892 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L892:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 892 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L893:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 893 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2021.dta") fields("export_any_binary vs_export_any_binary") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L893:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 893 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L894:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 894 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L894:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 894 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L895:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 895 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L895:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 895 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L896:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 896 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L896:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 896 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L897:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 897 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L897:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 897 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L898:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 898 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2021.dta") fields("export_direct_flag vs_export_direct_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L898:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 898 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L899:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 899 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L899:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 899 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L900:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 900 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L900:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 900 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L901:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 901 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L901:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 901 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L902:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 902 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L902:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 902 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L903:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 903 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2021.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L903:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 903 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L904:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 904 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L904:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 904 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L905:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 905 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L905:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 905 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L906:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 906 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L906:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 906 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L907:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 907 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L907:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 907 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L908:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 908 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2021.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L908:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 908 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L909:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 909 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L909:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 909 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L910:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 910 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inov21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L910:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 910 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L911:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 911 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L911:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 911 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L912:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 912 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L912:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 912 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L913:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 913 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2021.dta") fields("innovation_flag vs_innovation_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L913:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 913 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L914:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 914 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L914:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 914 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L915:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 915 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_amdal21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L915:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 915 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L916:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 916 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L916:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 916 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L917:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 917 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L917:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 917 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L918:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 918 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2021.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L918:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 918 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L919:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 919 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L919:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 919 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L920:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 920 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_pplihi21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L920:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 920 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L921:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 921 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L921:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 921 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L922:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 922 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L922:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 922 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L923:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 923 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2021.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L923:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 923 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L924:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 924 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L924:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 924 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L925:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 925 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_spplhi21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L925:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 925 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L926:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 926 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L926:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 926 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L927:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 927 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L927:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 927 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L928:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 928 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2021.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L928:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 928 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L929:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 929 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L929:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 929 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L930:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 930 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inspli21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L930:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 930 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L931:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 931 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L931:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 931 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L932:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 932 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L932:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 932 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L933:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 933 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2021.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L933:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 933 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L934:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 934 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2021.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L934:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 934 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L935:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 935 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2021.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L935:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 935 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L936:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 936 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2021.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L936:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 936 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L937:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 937 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L937:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 937 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L938:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 938 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engkgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L938:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 938 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L939:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 939 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L939:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 939 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L940:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 940 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L940:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 940 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L941:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 941 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2021.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L941:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 941 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L942:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 942 948 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L942:step-preserve" "code/annual/merge_mapped_2021.do:L1:file" "statement" 942 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L943:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 943 948 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecakgu21
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L943:step-keep" "code/annual/merge_mapped_2021.do:L1:file" "statement" 943 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L944:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 944 948 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2021.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L944:step-cf" "code/annual/merge_mapped_2021.do:L1:file" "statement" 944 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L945:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 945 948 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L945:step-restore" "code/annual/merge_mapped_2021.do:L1:file" "statement" 945 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L946:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 946 948 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2021.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2021)
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L946:step-wf_merge_guard" "code/annual/merge_mapped_2021.do:L1:file" "statement" 946 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L947:step-isid" "code/annual/merge_mapped_2021.do:L1:file" "statement" 947 948 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L947:step-isid" "code/annual/merge_mapped_2021.do:L1:file" "statement" 947 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2021.do:L948:step-save" "code/annual/merge_mapped_2021.do:L1:file" "statement" 948 948 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2021.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L948:step-save" "code/annual/merge_mapped_2021.do:L1:file" "statement" 948 948 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
