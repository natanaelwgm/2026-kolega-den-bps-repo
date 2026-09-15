* Tujuan: Gabungkan hasil pemetaan kolom tahun 2020 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2020.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2020.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L1:step-do" "code/annual/merge_mapped_2020.do:L1:file" "statement" 1 932 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L1:step-do" "code/annual/merge_mapped_2020.do:L1:file" "statement" 1 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L2:step-do" "code/annual/merge_mapped_2020.do:L1:file" "statement" 2 932 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L2:step-do" "code/annual/merge_mapped_2020.do:L1:file" "statement" 2 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L3:step-use" "code/annual/merge_mapped_2020.do:L1:file" "statement" 3 932 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2020.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L3:step-use" "code/annual/merge_mapped_2020.do:L1:file" "statement" 3 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L4:step-assert" "code/annual/merge_mapped_2020.do:L1:file" "statement" 4 932 `=_rc' // WFLOG-INJECTED
assert source_year==2020
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L4:step-assert" "code/annual/merge_mapped_2020.do:L1:file" "statement" 4 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L5:step-isid" "code/annual/merge_mapped_2020.do:L1:file" "statement" 5 932 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L5:step-isid" "code/annual/merge_mapped_2020.do:L1:file" "statement" 5 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L6:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 6 932 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L6:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 6 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L7:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 7 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_amdal20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L7:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 7 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L8:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 8 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L8:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 8 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L9:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 9 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L9:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 9 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L10:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 10 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2020.dta") fields("amdal_raw vs_amdal_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L10:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 10 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L11:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 11 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2020.dta") fields("b3wste_raw vs_b3wste_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L11:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 11 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L12:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 12 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L12:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 12 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L13:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 13 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L13:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 13 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L14:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 14 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L14:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 14 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L15:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 15 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L15:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 15 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L16:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 16 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2020.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L16:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 16 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L17:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 17 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L17:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 17 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L18:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 18 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L18:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 18 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L19:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 19 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L19:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 19 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L20:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 20 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L20:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 20 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L21:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 21 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2020.dta") fields("capital_nominal vs_capital_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L21:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 21 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L22:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 22 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L22:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 22 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L23:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 23 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L23:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 23 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L24:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 24 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L24:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 24 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L25:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 25 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L25:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 25 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L26:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 26 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2020.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L26:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 26 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L27:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 27 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L27:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 27 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L28:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 28 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L28:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 28 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L29:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 29 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L29:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 29 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L30:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 30 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L30:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 30 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L31:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 31 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2020.dta") fields("export_binary_raw vs_export_binary_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L31:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 31 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L32:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 32 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L32:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 32 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L33:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 33 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L33:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 33 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L34:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 34 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L34:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 34 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L35:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 35 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L35:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 35 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L36:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 36 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2020.dta") fields("export_share_pct vs_export_share_pct") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L36:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 36 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L37:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 37 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L37:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 37 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L38:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 38 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L38:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 38 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L39:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 39 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L39:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 39 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L40:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 40 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L40:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 40 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 41 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2020.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L41:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 41 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L42:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 42 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L42:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 42 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L43:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 43 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L43:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 43 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L44:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 44 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L44:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 44 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L45:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 45 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L45:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 45 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L46:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 46 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2020.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L46:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 46 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L47:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 47 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L47:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 47 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L48:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 48 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L48:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 48 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L49:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 49 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L49:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 49 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L50:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 50 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L50:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 50 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 51 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2020.dta") fields("import_value_nominal vs_import_value_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 51 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 52 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2020.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 52 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 53 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2020.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 53 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L54:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 54 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2020.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L54:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 54 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L55:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 55 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2020.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L55:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 55 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L56:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 56 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L56:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 56 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L57:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 57 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inov20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L57:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 57 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L58:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 58 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L58:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 58 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L59:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 59 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L59:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 59 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 60 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2020.dta") fields("innovation_raw vs_innovation_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 60 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L61:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 61 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L61:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 61 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L62:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 62 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inspli20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L62:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 62 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L63:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 63 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L63:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 63 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L64:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 64 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L64:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 64 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 65 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2020.dta") fields("inspli_raw vs_inspli_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 65 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L66:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 66 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L66:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 66 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L67:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 67 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L67:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 67 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L68:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 68 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L68:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 68 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L69:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 69 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L69:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 69 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 70 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2020.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 70 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 71 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2020.dta") fields("liwste_raw vs_liwste_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L71:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 71 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L72:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 72 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L72:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 72 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L73:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 73 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_pplihi20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L73:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 73 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L74:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 74 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L74:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 74 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L75:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 75 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L75:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 75 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 76 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2020.dta") fields("pplihi_raw vs_pplihi_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 76 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L77:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 77 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L77:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 77 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L78:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 78 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L78:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 78 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L79:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 79 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L79:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 79 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L80:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 80 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L80:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 80 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 81 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2020.dta") fields("production_workers vs_production_workers") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 81 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L82:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 82 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L82:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 82 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L83:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 83 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L83:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 83 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L84:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 84 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L84:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 84 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L85:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 85 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L85:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 85 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 86 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2020.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 86 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L87:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 87 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L87:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 87 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L88:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 88 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L88:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 88 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L89:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 89 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L89:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 89 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L90:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 90 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L90:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 90 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 91 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2020.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 91 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L92:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 92 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L92:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 92 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L93:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 93 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlrnd20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L93:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 93 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L94:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 94 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_workers_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L94:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 94 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L95:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 95 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L95:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 95 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 96 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2020.dta") fields("rd_workers vs_rd_workers") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L96:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 96 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 97 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2020.dta") fields("sowste_raw vs_sowste_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 97 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L98:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 98 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L98:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 98 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L99:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 99 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_spplhi20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L99:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 99 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L100:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 100 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L100:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 100 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L101:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 101 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L101:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 101 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 102 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2020.dta") fields("spplhi_raw vs_spplhi_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 102 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 103 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2020.dta") fields("val_cbdacu vs_val_cbdacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L103:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 103 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L104:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 104 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L104:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 104 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L105:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 105 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L105:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 105 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L106:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 106 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L106:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 106 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L107:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 107 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L107:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 107 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 108 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2020.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 108 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L109:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 109 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L109:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 109 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L110:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 110 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L110:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 110 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L111:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 111 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L111:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 111 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L112:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 112 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L112:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 112 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 113 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2020.dta") fields("val_cbsacu vs_val_cbsacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 113 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L114:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 114 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L114:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 114 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L115:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 115 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L115:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 115 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L116:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 116 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L116:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 116 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L117:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 117 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L117:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 117 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 118 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2020.dta") fields("val_cbttcu vs_val_cbttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 118 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L119:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 119 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2020.dta") fields("val_cldacu vs_val_cldacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L119:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 119 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L120:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 120 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L120:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 120 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L121:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 121 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L121:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 121 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L122:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 122 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L122:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 122 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L123:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 123 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L123:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 123 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 124 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2020.dta") fields("val_clfpcu vs_val_clfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 124 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L125:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 125 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L125:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 125 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L126:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 126 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L126:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 126 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L127:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 127 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L127:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 127 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L128:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 128 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L128:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 128 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 129 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2020.dta") fields("val_clsacu vs_val_clsacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 129 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L130:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 130 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L130:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 130 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L131:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 131 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L131:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 131 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L132:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 132 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L132:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 132 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L133:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 133 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L133:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 133 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L134:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 134 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2020.dta") fields("val_clttcu vs_val_clttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L134:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 134 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 135 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2020.dta") fields("val_cmdacu vs_val_cmdacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 135 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L136:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 136 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L136:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 136 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L137:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 137 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L137:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 137 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L138:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 138 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L138:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 138 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L139:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 139 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L139:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 139 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 140 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2020.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L140:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 140 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L141:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 141 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L141:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 141 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L142:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 142 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L142:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 142 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L143:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 143 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L143:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 143 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L144:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 144 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L144:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 144 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 145 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2020.dta") fields("val_cmsacu vs_val_cmsacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 145 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L146:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 146 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L146:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 146 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L147:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 147 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L147:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 147 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L148:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 148 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L148:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 148 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L149:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 149 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L149:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 149 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 150 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2020.dta") fields("val_cmttcu vs_val_cmttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 150 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 151 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2020.dta") fields("val_codacu vs_val_codacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 151 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L152:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 152 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L152:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 152 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L153:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 153 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cofpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L153:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 153 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L154:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 154 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L154:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 154 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L155:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 155 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L155:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 155 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 156 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2020.dta") fields("val_cofpcu vs_val_cofpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 156 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L157:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 157 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L157:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 157 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L158:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 158 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L158:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 158 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L159:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 159 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L159:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 159 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L160:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 160 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L160:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 160 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 161 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2020.dta") fields("val_cosacu vs_val_cosacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 161 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L162:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 162 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L162:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 162 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L163:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 163 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L163:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 163 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L164:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 164 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_costrd_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L164:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 164 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L165:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 165 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L165:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 165 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 166 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2020.dta") fields("val_costrd vs_val_costrd") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L166:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 166 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L167:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 167 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L167:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 167 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L168:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 168 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L168:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 168 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L169:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 169 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L169:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 169 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L170:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 170 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L170:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 170 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 171 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2020.dta") fields("val_cottcu vs_val_cottcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 171 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 172 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2020.dta") fields("val_csdacu vs_val_csdacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 172 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L173:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 173 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L173:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 173 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L174:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 174 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L174:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 174 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L175:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 175 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L175:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 175 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L176:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 176 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L176:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 176 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 177 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2020.dta") fields("val_csfpcu vs_val_csfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 177 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L178:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 178 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L178:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 178 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L179:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 179 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cssacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L179:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 179 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L180:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 180 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L180:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 180 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L181:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 181 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L181:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 181 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 182 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2020.dta") fields("val_cssacu vs_val_cssacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 182 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L183:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 183 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L183:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 183 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L184:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 184 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L184:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 184 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L185:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 185 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L185:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 185 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L186:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 186 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L186:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 186 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 187 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2020.dta") fields("val_csttcu vs_val_csttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 187 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 188 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2020.dta") fields("val_ctdacu vs_val_ctdacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L188:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 188 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L189:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 189 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L189:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 189 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L190:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 190 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L190:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 190 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L191:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 191 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L191:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 191 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L192:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 192 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L192:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 192 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 193 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2020.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 193 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L194:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 194 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L194:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 194 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L195:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 195 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L195:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 195 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L196:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 196 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L196:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 196 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L197:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 197 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L197:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 197 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 198 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2020.dta") fields("val_ctsacu vs_val_ctsacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 198 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 199 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2020.dta") fields("val_cttcu vs_val_cttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 199 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L200:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 200 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L200:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 200 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L201:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 201 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L201:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 201 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L202:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 202 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L202:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 202 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L203:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 203 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L203:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 203 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 204 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2020.dta") fields("val_ctttcu vs_val_ctttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 204 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L205:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 205 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2020.dta") fields("val_cvdacu vs_val_cvdacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L205:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 205 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L206:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 206 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L206:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 206 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L207:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 207 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvfpcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L207:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 207 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L208:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 208 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L208:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 208 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L209:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 209 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L209:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 209 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 210 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2020.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 210 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L211:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 211 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L211:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 211 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L212:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 212 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L212:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 212 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L213:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 213 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L213:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 213 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L214:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 214 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L214:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 214 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 215 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2020.dta") fields("val_cvsacu vs_val_cvsacu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 215 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L216:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 216 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L216:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 216 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L217:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 217 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L217:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 217 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L218:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 218 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L218:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 218 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L219:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 219 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L219:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 219 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 220 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2020.dta") fields("val_cvttcu vs_val_cvttcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 220 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 221 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2020.dta") fields("val_devvcu vs_val_devvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 221 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L222:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 222 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L222:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 222 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L223:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 223 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L223:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 223 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L224:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 224 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L224:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 224 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L225:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 225 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L225:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 225 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 226 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2020.dta") fields("val_ecavce vs_val_ecavce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 226 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L227:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 227 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L227:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 227 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L228:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 228 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L228:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 228 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L229:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 229 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L229:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 229 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L230:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 230 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L230:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 230 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 231 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2020.dta") fields("val_ecavcu vs_val_ecavcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 231 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L232:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 232 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L232:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 232 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L233:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 233 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L233:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 233 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L234:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 234 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L234:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 234 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L235:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 235 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L235:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 235 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 236 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2020.dta") fields("val_ecbvce vs_val_ecbvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 236 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L237:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 237 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L237:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 237 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L238:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 238 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L238:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 238 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L239:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 239 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L239:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 239 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L240:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 240 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L240:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 240 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 241 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2020.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 241 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 242 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2020.dta") fields("val_eckvce vs_val_eckvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L242:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 242 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 243 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2020.dta") fields("val_eckvcu vs_val_eckvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L243:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 243 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L244:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 244 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L244:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 244 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L245:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 245 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L245:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 245 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L246:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 246 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L246:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 246 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L247:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 247 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L247:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 247 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L248:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 248 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2020.dta") fields("val_eclvce vs_val_eclvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L248:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 248 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L249:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 249 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L249:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 249 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L250:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 250 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L250:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 250 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L251:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 251 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L251:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 251 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L252:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 252 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L252:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 252 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L253:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 253 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2020.dta") fields("val_eclvcu vs_val_eclvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L253:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 253 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L254:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 254 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L254:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 254 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L255:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 255 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L255:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 255 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L256:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 256 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_edivce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L256:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 256 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L257:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 257 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L257:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 257 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L258:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 258 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2020.dta") fields("val_edivce vs_val_edivce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L258:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 258 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L259:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 259 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L259:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 259 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L260:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 260 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L260:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 260 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L261:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 261 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L261:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 261 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L262:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 262 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L262:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 262 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 263 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2020.dta") fields("val_edivcu vs_val_edivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 263 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L264:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 264 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L264:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 264 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L265:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 265 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L265:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 265 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L266:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 266 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efovce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L266:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 266 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L267:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 267 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L267:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 267 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 268 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2020.dta") fields("val_efovce vs_val_efovce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 268 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L269:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 269 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L269:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 269 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L270:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 270 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L270:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 270 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L271:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 271 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L271:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 271 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L272:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 272 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L272:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 272 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 273 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2020.dta") fields("val_efovcu vs_val_efovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 273 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L274:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 274 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L274:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 274 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L275:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 275 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L275:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 275 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L276:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 276 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L276:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 276 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L277:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 277 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L277:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 277 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 278 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2020.dta") fields("val_efuvce vs_val_efuvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 278 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L279:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 279 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L279:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 279 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L280:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 280 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L280:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 280 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L281:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 281 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L281:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 281 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L282:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 282 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L282:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 282 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 283 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2020.dta") fields("val_efuvcu vs_val_efuvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 283 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 284 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2020.dta") fields("val_egavce vs_val_egavce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 284 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 285 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2020.dta") fields("val_egavcu vs_val_egavcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 285 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 286 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2020.dta") fields("val_egovce vs_val_egovce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 286 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 287 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2020.dta") fields("val_egovcu vs_val_egovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 287 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L288:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 288 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L288:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 288 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L289:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 289 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L289:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 289 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L290:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 290 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L290:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 290 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L291:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 291 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L291:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 291 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 292 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2020.dta") fields("val_elpvce vs_val_elpvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 292 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L293:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 293 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L293:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 293 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L294:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 294 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L294:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 294 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L295:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 295 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L295:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 295 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L296:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 296 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L296:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 296 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 297 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2020.dta") fields("val_elpvcu vs_val_elpvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L297:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 297 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L298:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 298 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L298:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 298 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L299:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 299 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L299:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 299 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L300:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 300 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L300:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 300 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L301:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 301 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L301:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 301 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L302:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 302 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2020.dta") fields("val_eluvce vs_val_eluvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L302:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 302 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L303:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 303 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L303:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 303 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L304:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 304 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L304:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 304 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L305:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 305 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L305:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 305 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L306:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 306 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L306:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 306 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 307 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2020.dta") fields("val_eluvcu vs_val_eluvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L307:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 307 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L308:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 308 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L308:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 308 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L309:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 309 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L309:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 309 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L310:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 310 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L310:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 310 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L311:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 311 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L311:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 311 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 312 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2020.dta") fields("val_encvce vs_val_encvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 312 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L313:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 313 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L313:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 313 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L314:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 314 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L314:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 314 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L315:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 315 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L315:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 315 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L316:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 316 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L316:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 316 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 317 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2020.dta") fields("val_encvcu vs_val_encvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 317 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L318:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 318 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L318:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 318 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L319:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 319 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L319:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 319 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L320:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 320 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_engvce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L320:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 320 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L321:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 321 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L321:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 321 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L322:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 322 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2020.dta") fields("val_engvce vs_val_engvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L322:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 322 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L323:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 323 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L323:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 323 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L324:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 324 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L324:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 324 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L325:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 325 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L325:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 325 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L326:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 326 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L326:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 326 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 327 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2020.dta") fields("val_engvcu vs_val_engvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 327 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L328:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 328 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L328:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 328 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L329:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 329 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L329:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 329 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L330:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 330 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L330:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 330 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L331:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 331 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L331:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 331 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 332 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2020.dta") fields("val_enpvcu vs_val_enpvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 332 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 333 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2020.dta") fields("val_eoivce vs_val_eoivce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 333 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 334 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2020.dta") fields("val_eoivcu vs_val_eoivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 334 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L335:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 335 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L335:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 335 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L336:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 336 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L336:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 336 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L337:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 337 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L337:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 337 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L338:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 338 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L338:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 338 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L339:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 339 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2020.dta") fields("val_epevce vs_val_epevce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L339:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 339 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L340:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 340 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L340:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 340 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L341:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 341 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L341:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 341 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L342:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 342 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L342:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 342 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L343:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 343 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L343:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 343 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 344 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2020.dta") fields("val_epevcu vs_val_epevcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L344:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 344 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L345:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 345 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L345:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 345 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L346:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 346 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L346:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 346 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L347:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 347 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L347:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 347 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L348:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 348 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L348:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 348 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 349 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2020.dta") fields("val_eplvcu vs_val_eplvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 349 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 350 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2020.dta") fields("val_esdvce vs_val_esdvce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 350 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 351 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2020.dta") fields("val_esdvcu vs_val_esdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 351 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L352:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 352 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L352:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 352 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L353:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 353 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L353:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 353 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L354:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 354 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L354:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 354 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L355:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 355 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L355:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 355 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 356 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2020.dta") fields("val_esovce vs_val_esovce") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 356 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L357:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 357 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L357:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 357 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L358:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 358 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L358:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 358 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L359:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 359 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L359:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 359 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L360:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 360 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L360:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 360 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 361 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2020.dta") fields("val_esovcu vs_val_esovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 361 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L362:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 362 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L362:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 362 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L363:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 363 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L363:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 363 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L364:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 364 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L364:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 364 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L365:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 365 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L365:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 365 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 366 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2020.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 366 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L367:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 367 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L367:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 367 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L368:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 368 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L368:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 368 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L369:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 369 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L369:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 369 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L370:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 370 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L370:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 370 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 371 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2020.dta") fields("val_icovcu vs_val_icovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 371 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L372:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 372 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L372:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 372 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L373:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 373 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_idevcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L373:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 373 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L374:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 374 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L374:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 374 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L375:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 375 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L375:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 375 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 376 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2020.dta") fields("val_idevcu vs_val_idevcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 376 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L377:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 377 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L377:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 377 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L378:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 378 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L378:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 378 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L379:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 379 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L379:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 379 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L380:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 380 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L380:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 380 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 381 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2020.dta") fields("val_iinput vs_val_iinput") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 381 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L382:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 382 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L382:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 382 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L383:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 383 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L383:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 383 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L384:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 384 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L384:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 384 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L385:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 385 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L385:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 385 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 386 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2020.dta") fields("val_iinvcu vs_val_iinvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 386 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L387:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 387 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L387:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 387 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L388:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 388 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisfov20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L388:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 388 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L389:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 389 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L389:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 389 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L390:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 390 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L390:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 390 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 391 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2020.dta") fields("val_iisfov vs_val_iisfov") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 391 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L392:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 392 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L392:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 392 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L393:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 393 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iislov20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L393:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 393 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L394:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 394 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iislov_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L394:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 394 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L395:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 395 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L395:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 395 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L396:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 396 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2020.dta") fields("val_iislov vs_val_iislov") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L396:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 396 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L397:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 397 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2020.dta") fields("val_iisvcu vs_val_iisvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L397:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 397 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 398 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2020.dta") fields("val_ikivcu vs_val_ikivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 398 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L399:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 399 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L399:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 399 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L400:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 400 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iklvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L400:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 400 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L401:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 401 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L401:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 401 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L402:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 402 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L402:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 402 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 403 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2020.dta") fields("val_iklvcu vs_val_iklvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 403 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L404:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 404 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L404:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 404 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L405:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 405 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L405:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 405 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L406:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 406 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L406:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 406 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L407:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 407 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L407:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 407 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 408 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2020.dta") fields("val_ikovcu vs_val_ikovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 408 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L409:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 409 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L409:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 409 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L410:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 410 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L410:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 410 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L411:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 411 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L411:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 411 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L412:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 412 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L412:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 412 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 413 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2020.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 413 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 414 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2020.dta") fields("val_insvcu vs_val_insvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 414 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L415:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 415 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2020.dta") fields("val_intvcu vs_val_intvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L415:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 415 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L416:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 416 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L416:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 416 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L417:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 417 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L417:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 417 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L418:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 418 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L418:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 418 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L419:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 419 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L419:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 419 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L420:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 420 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2020.dta") fields("val_iotvcu vs_val_iotvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L420:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 420 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L421:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 421 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L421:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 421 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L422:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 422 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ipkvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L422:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 422 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L423:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 423 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L423:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 423 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L424:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 424 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L424:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 424 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L425:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 425 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2020.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L425:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 425 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L426:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 426 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L426:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 426 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L427:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 427 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iprvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L427:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 427 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L428:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 428 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L428:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 428 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L429:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 429 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L429:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 429 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L430:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 430 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2020.dta") fields("val_iprvcu vs_val_iprvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L430:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 430 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L431:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 431 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L431:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 431 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L432:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 432 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L432:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 432 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L433:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 433 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L433:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 433 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L434:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 434 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L434:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 434 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L435:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 435 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2020.dta") fields("val_irdvcu vs_val_irdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L435:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 435 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L436:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 436 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2020.dta") fields("val_irevcu vs_val_irevcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L436:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 436 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L437:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 437 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2020.dta") fields("val_irrvcu vs_val_irrvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L437:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 437 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L438:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 438 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L438:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 438 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L439:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 439 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L439:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 439 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L440:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 440 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L440:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 440 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L441:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 441 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L441:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 441 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L442:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 442 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2020.dta") fields("val_itxvcu vs_val_itxvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L442:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 442 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L443:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 443 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L443:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 443 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L444:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 444 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iuwvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L444:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 444 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L445:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 445 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L445:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 445 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L446:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 446 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L446:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 446 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L447:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 447 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2020.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L447:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 447 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L448:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 448 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L448:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 448 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L449:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 449 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_nopvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L449:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 449 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L450:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 450 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L450:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 450 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L451:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 451 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L451:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 451 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L452:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 452 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2020.dta") fields("val_nopvcu vs_val_nopvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L452:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 452 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 453 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2020.dta") fields("val_othvcu vs_val_othvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 453 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L454:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 454 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L454:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 454 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L455:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 455 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L455:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 455 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L456:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 456 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L456:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 456 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L457:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 457 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L457:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 457 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 458 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2020.dta") fields("val_output vs_val_output") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 458 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L459:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 459 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L459:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 459 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L460:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 460 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L460:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 460 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L461:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 461 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L461:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 461 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L462:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 462 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L462:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 462 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 463 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2020.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 463 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 464 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2020.dta") fields("val_renvcu vs_val_renvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 464 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L465:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 465 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L465:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 465 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L466:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 466 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L466:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 466 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L467:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 467 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L467:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 467 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L468:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 468 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L468:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 468 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 469 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2020.dta") fields("val_rimvcu vs_val_rimvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 469 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L470:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 470 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L470:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 470 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L471:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 471 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L471:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 471 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L472:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 472 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L472:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 472 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L473:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 473 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L473:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 473 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 474 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2020.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 474 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L475:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 475 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L475:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 475 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L476:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 476 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfbvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L476:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 476 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L477:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 477 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L477:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 477 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L478:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 478 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L478:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 478 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 479 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2020.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 479 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L480:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 480 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L480:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 480 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L481:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 481 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfcvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L481:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 481 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L482:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 482 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L482:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 482 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L483:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 483 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L483:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 483 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 484 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2020.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L484:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 484 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L485:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 485 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L485:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 485 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L486:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 486 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L486:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 486 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L487:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 487 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L487:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 487 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L488:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 488 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L488:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 488 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L489:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 489 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2020.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L489:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 489 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L490:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 490 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L490:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 490 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L491:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 491 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfgvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L491:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 491 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L492:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 492 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L492:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 492 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L493:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 493 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L493:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 493 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 494 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2020.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 494 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L495:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 495 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L495:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 495 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L496:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 496 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L496:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 496 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L497:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 497 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L497:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 497 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L498:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 498 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L498:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 498 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 499 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2020.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 499 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L500:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 500 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L500:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 500 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L501:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 501 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfkvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L501:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 501 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L502:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 502 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L502:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 502 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L503:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 503 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L503:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 503 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 504 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2020.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 504 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L505:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 505 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L505:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 505 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L506:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 506 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L506:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 506 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L507:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 507 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L507:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 507 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L508:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 508 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L508:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 508 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 509 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2020.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L509:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 509 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L510:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 510 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L510:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 510 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L511:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 511 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L511:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 511 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L512:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 512 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L512:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 512 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L513:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 513 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L513:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 513 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 514 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2020.dta") fields("val_sfovcu vs_val_sfovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L514:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 514 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L515:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 515 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L515:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 515 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L516:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 516 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfrvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L516:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 516 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L517:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 517 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L517:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 517 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L518:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 518 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L518:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 518 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L519:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 519 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2020.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L519:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 519 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L520:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 520 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L520:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 520 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L521:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 521 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfsvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L521:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 521 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L522:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 522 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L522:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 522 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L523:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 523 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L523:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 523 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L524:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 524 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2020.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L524:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 524 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L525:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 525 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L525:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 525 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L526:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 526 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfuvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L526:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 526 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L527:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 527 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L527:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 527 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L528:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 528 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L528:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 528 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 529 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2020.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 529 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L530:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 530 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L530:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 530 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L531:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 531 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L531:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 531 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L532:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 532 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L532:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 532 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L533:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 533 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L533:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 533 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 534 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2020.dta") fields("val_shdvcu vs_val_shdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 534 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L535:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 535 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L535:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 535 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L536:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 536 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L536:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 536 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L537:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 537 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L537:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 537 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L538:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 538 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L538:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 538 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 539 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2020.dta") fields("val_shfvcu vs_val_shfvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 539 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L540:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 540 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L540:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 540 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L541:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 541 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L541:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 541 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L542:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 542 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L542:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 542 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L543:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 543 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L543:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 543 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 544 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2020.dta") fields("val_shjvcu vs_val_shjvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 544 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L545:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 545 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L545:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 545 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L546:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 546 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L546:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 546 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L547:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 547 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L547:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 547 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L548:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 548 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L548:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 548 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 549 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2020.dta") fields("val_srdvcu vs_val_srdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 549 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L550:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 550 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L550:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 550 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L551:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 551 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L551:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 551 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L552:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 552 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L552:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 552 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L553:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 553 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L553:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 553 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 554 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2020.dta") fields("val_srjvcu vs_val_srjvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 554 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L555:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 555 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L555:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 555 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L556:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 556 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L556:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 556 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L557:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 557 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L557:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 557 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L558:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 558 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L558:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 558 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 559 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2020.dta") fields("val_srmvcu vs_val_srmvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 559 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L560:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 560 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L560:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 560 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L561:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 561 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L561:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 561 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L562:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 562 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L562:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 562 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L563:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 563 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L563:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 563 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 564 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2020.dta") fields("val_stdvcu vs_val_stdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 564 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L565:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 565 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L565:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 565 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L566:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 566 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L566:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 566 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L567:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 567 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L567:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 567 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L568:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 568 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L568:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 568 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 569 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2020.dta") fields("val_stjvcu vs_val_stjvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 569 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L570:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 570 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L570:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 570 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L571:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 571 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L571:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 571 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L572:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 572 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L572:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 572 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L573:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 573 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L573:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 573 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 574 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2020.dta") fields("val_stlvcu vs_val_stlvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 574 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L575:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 575 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L575:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 575 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L576:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 576 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L576:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 576 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L577:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 577 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L577:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 577 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L578:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 578 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L578:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 578 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 579 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2020.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 579 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L580:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 580 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L580:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 580 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L581:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 581 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L581:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 581 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L582:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 582 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L582:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 582 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L583:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 583 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L583:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 583 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 584 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2020.dta") fields("val_yelvcu vs_val_yelvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 584 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L585:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 585 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L585:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 585 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L586:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 586 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L586:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 586 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L587:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 587 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L587:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 587 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L588:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 588 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L588:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 588 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 589 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2020.dta") fields("val_yisvcu vs_val_yisvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 589 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L590:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 590 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L590:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 590 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L591:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 591 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L591:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 591 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L592:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 592 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L592:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 592 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L593:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 593 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L593:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 593 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 594 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2020.dta") fields("val_yisvdo vs_val_yisvdo") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 594 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L595:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 595 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L595:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 595 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L596:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 596 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L596:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 596 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L597:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 597 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L597:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 597 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L598:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 598 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L598:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 598 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 599 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2020.dta") fields("val_yisvfo vs_val_yisvfo") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 599 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L600:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 600 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L600:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 600 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L601:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 601 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L601:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 601 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L602:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 602 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L602:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 602 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L603:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 603 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L603:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 603 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L604:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 604 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2020.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L604:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 604 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L605:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 605 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L605:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 605 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L606:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 606 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykfvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L606:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 606 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L607:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 607 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L607:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 607 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L608:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 608 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L608:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 608 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L609:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 609 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2020.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L609:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 609 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 610 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2020.dta") fields("val_ykivcu vs_val_ykivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L610:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 610 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L611:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 611 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L611:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 611 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L612:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 612 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L612:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 612 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L613:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 613 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L613:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 613 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L614:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 614 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L614:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 614 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L615:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 615 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2020.dta") fields("val_yprvcu vs_val_yprvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L615:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 615 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L616:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 616 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L616:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 616 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L617:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 617 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L617:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 617 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L618:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 618 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L618:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 618 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L619:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 619 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L619:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 619 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 620 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2020.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 620 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L621:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 621 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L621:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 621 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L622:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 622 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrsvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L622:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 622 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L623:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 623 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L623:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 623 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L624:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 624 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L624:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 624 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L625:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 625 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2020.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L625:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 625 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L626:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 626 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L626:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 626 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L627:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 627 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ysnvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L627:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 627 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L628:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 628 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L628:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 628 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L629:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 629 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L629:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 629 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 630 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2020.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 630 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L631:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 631 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L631:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 631 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L632:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 632 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ytovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L632:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 632 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L633:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 633 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L633:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 633 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L634:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 634 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L634:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 634 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 635 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2020.dta") fields("val_ytovcu vs_val_ytovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 635 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 636 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2020.dta") fields("val_znavcu vs_val_znavcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 636 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L637:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 637 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L637:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 637 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L638:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 638 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L638:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 638 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L639:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 639 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L639:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 639 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L640:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 640 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L640:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 640 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L641:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 641 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2020.dta") fields("val_zndvcu vs_val_zndvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L641:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 641 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L642:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 642 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L642:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 642 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L643:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 643 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znevcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L643:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 643 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L644:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 644 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L644:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 644 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L645:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 645 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L645:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 645 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 646 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2020.dta") fields("val_znevcu vs_val_znevcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L646:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 646 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L647:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 647 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L647:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 647 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L648:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 648 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znhvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L648:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 648 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L649:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 649 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L649:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 649 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L650:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 650 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L650:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 650 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 651 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2020.dta") fields("val_znhvcu vs_val_znhvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L651:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 651 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L652:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 652 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2020.dta") fields("val_znivcu vs_val_znivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L652:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 652 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 653 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2020.dta") fields("val_znovcu vs_val_znovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 653 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 654 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2020.dta") fields("val_znpvcu vs_val_znpvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 654 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L655:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 655 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L655:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 655 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L656:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 656 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znrvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L656:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 656 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L657:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 657 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L657:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 657 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L658:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 658 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L658:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 658 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 659 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2020.dta") fields("val_znrvcu vs_val_znrvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 659 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 660 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2020.dta") fields("val_znsvcu vs_val_znsvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L660:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 660 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L661:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 661 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L661:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 661 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L662:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 662 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zntvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L662:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 662 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L663:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 663 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L663:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 663 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L664:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 664 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L664:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 664 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 665 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2020.dta") fields("val_zntvcu vs_val_zntvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 665 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 666 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2020.dta") fields("val_zpavcu vs_val_zpavcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 666 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L667:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 667 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L667:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 667 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L668:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 668 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L668:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 668 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L669:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 669 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L669:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 669 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L670:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 670 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L670:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 670 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L671:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 671 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2020.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L671:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 671 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L672:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 672 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L672:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 672 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L673:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 673 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpevcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L673:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 673 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L674:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 674 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L674:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 674 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L675:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 675 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L675:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 675 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 676 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2020.dta") fields("val_zpevcu vs_val_zpevcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 676 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L677:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 677 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L677:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 677 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L678:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 678 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zphvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L678:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 678 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L679:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 679 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L679:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 679 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L680:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 680 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L680:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 680 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 681 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2020.dta") fields("val_zphvcu vs_val_zphvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L681:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 681 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 682 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2020.dta") fields("val_zpivcu vs_val_zpivcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 682 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L683:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 683 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2020.dta") fields("val_zpovcu vs_val_zpovcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L683:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 683 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L684:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 684 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2020.dta") fields("val_zppvcu vs_val_zppvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L684:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 684 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L685:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 685 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L685:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 685 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L686:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 686 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zprvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L686:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 686 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L687:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 687 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L687:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 687 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L688:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 688 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L688:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 688 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 689 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2020.dta") fields("val_zprvcu vs_val_zprvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L689:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 689 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 690 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2020.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 690 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L691:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 691 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L691:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 691 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L692:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 692 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zptvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L692:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 692 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L693:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 693 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L693:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 693 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L694:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 694 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L694:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 694 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 695 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2020.dta") fields("val_zptvcu vs_val_zptvcu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 695 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L696:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 696 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L696:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 696 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L697:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 697 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L697:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 697 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L698:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 698 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L698:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 698 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L699:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 699 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L699:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 699 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 700 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2020.dta") fields("value_added_nominal vs_value_added_nominal") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 700 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L701:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 701 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L701:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 701 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L702:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 702 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L702:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 702 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L703:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 703 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L703:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 703 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L704:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 704 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L704:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 704 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 705 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2020.dta") fields("workers vs_workers") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L705:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 705 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L706:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 706 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L706:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 706 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L707:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 707 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L707:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 707 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L708:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 708 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L708:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 708 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L709:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 709 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L709:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 709 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 710 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2020.dta") fields("source_id_raw vs_source_id_raw") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L710:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 710 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L711:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 711 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L711:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 711 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L712:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 712 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L712:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 712 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L713:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 713 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L713:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 713 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L714:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 714 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L714:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 714 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 715 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2020.dta") fields("district_code vs_district_code") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 715 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L716:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 716 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L716:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 716 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L717:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 717 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic520
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L717:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 717 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L718:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 718 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L718:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 718 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L719:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 719 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L719:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 719 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 720 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2020.dta") fields("industry_code vs_industry_code") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 720 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L721:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 721 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L721:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 721 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L722:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 722 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L722:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 722 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L723:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 723 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L723:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 723 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L724:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 724 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L724:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 724 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L725:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 725 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2020.dta") fields("province_code vs_province_code") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L725:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 725 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L726:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 726 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L726:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 726 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L727:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 727 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L727:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 727 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L728:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 728 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L728:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 728 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L729:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 729 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L729:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 729 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L730:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 730 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2020.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L730:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 730 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L731:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 731 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L731:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 731 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L732:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 732 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L732:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 732 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L733:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 733 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L733:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 733 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L734:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 734 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L734:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 734 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 735 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2020.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L735:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 735 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L736:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 736 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L736:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 736 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L737:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 737 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L737:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 737 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L738:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 738 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L738:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 738 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L739:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 739 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L739:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 739 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 740 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2020.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L740:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 740 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L741:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 741 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L741:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 741 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L742:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 742 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L742:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 742 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L743:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 743 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L743:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 743 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L744:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 744 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L744:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 744 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 745 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2020.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 745 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L746:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 746 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L746:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 746 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L747:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 747 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L747:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 747 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L748:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 748 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L748:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 748 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L749:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 749 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L749:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 749 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 750 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2020.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 750 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 751 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2020.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 751 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 752 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2020.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 752 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L753:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 753 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L753:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 753 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L754:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 754 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecakgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L754:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 754 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L755:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 755 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L755:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 755 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L756:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 756 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L756:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 756 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L757:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 757 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2020.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L757:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 757 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L758:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 758 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L758:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 758 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L759:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 759 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecavcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L759:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 759 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L760:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 760 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L760:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 760 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L761:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 761 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L761:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 761 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 762 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2020.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 762 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L763:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 763 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2020.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L763:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 763 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L764:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 764 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2020.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L764:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 764 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L765:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 765 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L765:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 765 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L766:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 766 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L766:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 766 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L767:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 767 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L767:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 767 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L768:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 768 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L768:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 768 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L769:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 769 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2020.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L769:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 769 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L770:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 770 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L770:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 770 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L771:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 771 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L771:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 771 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L772:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 772 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L772:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 772 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L773:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 773 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L773:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 773 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 774 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2020.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 774 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L775:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 775 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L775:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 775 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L776:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 776 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L776:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 776 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L777:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 777 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L777:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 777 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L778:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 778 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L778:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 778 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 779 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2020.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 779 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L780:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 780 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L780:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 780 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L781:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 781 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L781:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 781 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L782:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 782 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L782:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 782 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L783:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 783 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L783:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 783 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 784 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2020.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 784 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L785:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 785 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2020.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L785:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 785 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L786:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 786 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2020.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L786:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 786 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L787:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 787 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L787:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 787 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L788:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 788 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L788:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 788 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L789:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 789 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L789:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 789 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L790:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 790 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L790:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 790 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L791:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 791 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2020.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L791:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 791 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L792:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 792 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L792:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 792 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L793:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 793 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L793:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 793 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L794:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 794 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L794:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 794 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L795:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 795 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L795:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 795 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L796:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 796 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2020.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L796:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 796 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L797:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 797 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L797:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 797 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L798:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 798 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ediliu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L798:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 798 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L799:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 799 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L799:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 799 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L800:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 800 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L800:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 800 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L801:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 801 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2020.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L801:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 801 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L802:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 802 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L802:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 802 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L803:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 803 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_edivcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L803:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 803 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L804:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 804 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L804:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 804 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L805:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 805 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L805:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 805 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L806:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 806 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2020.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L806:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 806 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 807 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2020.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L807:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 807 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L808:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 808 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2020.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L808:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 808 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L809:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 809 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L809:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 809 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L810:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 810 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efoliu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L810:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 810 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L811:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 811 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L811:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 811 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L812:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 812 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L812:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 812 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 813 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2020.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L813:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 813 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L814:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 814 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L814:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 814 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L815:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 815 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efovcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L815:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 815 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L816:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 816 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L816:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 816 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L817:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 817 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L817:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 817 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L818:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 818 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2020.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L818:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 818 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 819 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2020.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 819 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L820:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 820 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2020.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L820:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 820 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L821:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 821 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L821:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 821 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L822:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 822 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L822:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 822 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L823:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 823 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L823:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 823 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L824:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 824 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L824:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 824 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L825:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 825 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2020.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L825:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 825 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L826:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 826 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L826:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 826 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L827:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 827 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L827:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 827 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L828:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 828 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L828:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 828 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L829:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 829 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L829:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 829 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L830:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 830 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2020.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L830:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 830 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L831:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 831 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L831:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 831 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L832:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 832 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L832:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 832 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L833:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 833 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L833:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 833 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L834:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 834 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L834:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 834 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L835:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 835 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2020.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L835:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 835 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L836:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 836 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L836:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 836 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L837:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 837 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L837:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 837 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L838:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 838 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L838:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 838 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L839:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 839 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L839:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 839 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L840:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 840 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2020.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L840:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 840 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L841:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 841 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L841:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 841 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L842:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 842 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engkgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L842:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 842 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L843:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 843 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L843:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 843 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L844:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 844 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L844:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 844 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L845:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 845 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2020.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L845:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 845 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L846:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 846 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L846:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 846 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L847:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 847 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L847:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 847 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L848:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 848 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L848:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 848 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L849:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 849 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L849:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 849 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L850:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 850 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2020.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L850:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 850 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L851:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 851 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L851:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 851 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L852:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 852 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L852:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 852 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L853:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 853 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L853:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 853 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L854:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 854 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L854:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 854 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L855:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 855 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2020.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L855:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 855 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L856:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 856 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2020.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L856:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 856 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L857:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 857 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2020.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L857:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 857 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L858:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 858 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L858:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 858 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L859:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 859 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L859:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 859 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L860:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 860 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L860:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 860 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L861:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 861 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L861:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 861 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L862:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 862 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2020.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L862:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 862 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L863:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 863 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L863:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 863 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L864:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 864 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L864:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 864 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L865:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 865 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L865:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 865 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L866:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 866 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L866:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 866 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L867:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 867 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2020.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L867:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 867 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L868:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 868 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L868:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 868 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L869:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 869 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L869:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 869 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L870:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 870 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L870:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 870 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L871:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 871 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L871:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 871 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L872:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 872 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2020.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L872:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 872 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L873:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 873 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L873:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 873 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L874:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 874 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L874:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 874 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L875:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 875 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L875:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 875 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L876:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 876 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L876:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 876 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L877:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 877 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2020.dta") fields("export_any_binary vs_export_any_binary") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L877:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 877 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L878:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 878 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L878:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 878 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L879:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 879 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L879:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 879 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L880:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 880 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L880:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 880 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L881:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 881 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L881:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 881 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L882:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 882 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2020.dta") fields("export_direct_flag vs_export_direct_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L882:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 882 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L883:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 883 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L883:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 883 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L884:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 884 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L884:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 884 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L885:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 885 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L885:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 885 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L886:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 886 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L886:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 886 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L887:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 887 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2020.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L887:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 887 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L888:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 888 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L888:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 888 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L889:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 889 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L889:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 889 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L890:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 890 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L890:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 890 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L891:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 891 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L891:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 891 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L892:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 892 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2020.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L892:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 892 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L893:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 893 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L893:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 893 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L894:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 894 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inov20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L894:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 894 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L895:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 895 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L895:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 895 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L896:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 896 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L896:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 896 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L897:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 897 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2020.dta") fields("innovation_flag vs_innovation_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L897:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 897 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L898:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 898 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L898:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 898 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L899:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 899 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_amdal20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L899:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 899 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L900:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 900 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L900:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 900 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L901:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 901 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L901:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 901 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L902:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 902 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2020.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L902:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 902 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L903:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 903 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L903:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 903 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L904:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 904 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_pplihi20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L904:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 904 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L905:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 905 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L905:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 905 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L906:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 906 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L906:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 906 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L907:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 907 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2020.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L907:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 907 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L908:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 908 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L908:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 908 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L909:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 909 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_spplhi20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L909:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 909 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L910:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 910 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L910:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 910 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L911:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 911 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L911:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 911 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L912:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 912 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2020.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L912:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 912 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L913:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 913 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L913:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 913 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L914:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 914 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_inspli20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L914:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 914 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L915:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 915 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L915:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 915 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L916:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 916 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L916:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 916 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L917:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 917 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2020.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L917:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 917 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L918:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 918 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2020.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L918:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 918 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L919:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 919 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2020.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L919:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 919 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L920:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 920 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2020.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L920:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 920 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L921:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 921 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L921:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 921 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L922:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 922 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_engkgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L922:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 922 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L923:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 923 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L923:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 923 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L924:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 924 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L924:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 924 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L925:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 925 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2020.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L925:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 925 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L926:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 926 932 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L926:step-preserve" "code/annual/merge_mapped_2020.do:L1:file" "statement" 926 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L927:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 927 932 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecakgu20
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L927:step-keep" "code/annual/merge_mapped_2020.do:L1:file" "statement" 927 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L928:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 928 932 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2020.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L928:step-cf" "code/annual/merge_mapped_2020.do:L1:file" "statement" 928 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L929:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 929 932 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L929:step-restore" "code/annual/merge_mapped_2020.do:L1:file" "statement" 929 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L930:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 930 932 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2020.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2020)
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L930:step-wf_merge_guard" "code/annual/merge_mapped_2020.do:L1:file" "statement" 930 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L931:step-isid" "code/annual/merge_mapped_2020.do:L1:file" "statement" 931 932 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L931:step-isid" "code/annual/merge_mapped_2020.do:L1:file" "statement" 931 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2020.do:L932:step-save" "code/annual/merge_mapped_2020.do:L1:file" "statement" 932 932 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2020.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L932:step-save" "code/annual/merge_mapped_2020.do:L1:file" "statement" 932 932 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
