* Tujuan: Gabungkan hasil pemetaan kolom tahun 2019 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2019.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2019.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L1:step-do" "code/annual/merge_mapped_2019.do:L1:file" "statement" 1 836 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L1:step-do" "code/annual/merge_mapped_2019.do:L1:file" "statement" 1 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L2:step-do" "code/annual/merge_mapped_2019.do:L1:file" "statement" 2 836 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L2:step-do" "code/annual/merge_mapped_2019.do:L1:file" "statement" 2 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L3:step-use" "code/annual/merge_mapped_2019.do:L1:file" "statement" 3 836 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2019.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L3:step-use" "code/annual/merge_mapped_2019.do:L1:file" "statement" 3 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L4:step-assert" "code/annual/merge_mapped_2019.do:L1:file" "statement" 4 836 `=_rc' // WFLOG-INJECTED
assert source_year==2019
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L4:step-assert" "code/annual/merge_mapped_2019.do:L1:file" "statement" 4 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L5:step-isid" "code/annual/merge_mapped_2019.do:L1:file" "statement" 5 836 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L5:step-isid" "code/annual/merge_mapped_2019.do:L1:file" "statement" 5 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 6 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2019.dta") fields("amdal_raw vs_amdal_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 6 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 7 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2019.dta") fields("b3wste_raw vs_b3wste_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 7 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L8:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 8 836 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L8:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 8 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L9:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 9 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L9:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 9 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L10:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 10 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L10:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 10 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L11:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 11 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L11:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 11 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 12 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2019.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 12 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L13:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 13 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L13:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 13 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L14:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 14 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L14:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 14 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L15:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 15 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L15:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 15 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L16:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 16 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L16:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 16 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 17 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2019.dta") fields("capital_nominal vs_capital_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 17 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L18:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 18 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L18:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 18 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L19:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 19 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L19:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 19 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L20:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 20 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L20:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 20 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L21:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 21 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L21:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 21 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 22 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2019.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 22 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L23:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 23 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L23:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 23 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L24:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 24 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L24:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 24 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L25:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 25 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L25:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 25 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L26:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 26 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L26:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 26 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 27 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2019.dta") fields("export_binary_raw vs_export_binary_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 27 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L28:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 28 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L28:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 28 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L29:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 29 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L29:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 29 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L30:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 30 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L30:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 30 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L31:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 31 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L31:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 31 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 32 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2019.dta") fields("export_share_pct vs_export_share_pct") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 32 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L33:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 33 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L33:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 33 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L34:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 34 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L34:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 34 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L35:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 35 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L35:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 35 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L36:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 36 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L36:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 36 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 37 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2019.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 37 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L38:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 38 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L38:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 38 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L39:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 39 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L39:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 39 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L40:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 40 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L40:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 40 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L41:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 41 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L41:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 41 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 42 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2019.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 42 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L43:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 43 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L43:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 43 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L44:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 44 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L44:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 44 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L45:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 45 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L45:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 45 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L46:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 46 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L46:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 46 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 47 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2019.dta") fields("import_value_nominal vs_import_value_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 47 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 48 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2019.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 48 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 49 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2019.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 49 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 50 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2019.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 50 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 51 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2019.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 51 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 52 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2019.dta") fields("innovation_raw vs_innovation_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 52 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 53 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2019.dta") fields("inspli_raw vs_inspli_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 53 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L54:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 54 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L54:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 54 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L55:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 55 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L55:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 55 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L56:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 56 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L56:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 56 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L57:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 57 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L57:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 57 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 58 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2019.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 58 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 59 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2019.dta") fields("liwste_raw vs_liwste_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 59 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 60 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2019.dta") fields("pplihi_raw vs_pplihi_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 60 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L61:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 61 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L61:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 61 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L62:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 62 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L62:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 62 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L63:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 63 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L63:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 63 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L64:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 64 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L64:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 64 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 65 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2019.dta") fields("production_workers vs_production_workers") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 65 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L66:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 66 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L66:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 66 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L67:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 67 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L67:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 67 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L68:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 68 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L68:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 68 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L69:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 69 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L69:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 69 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 70 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2019.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 70 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L71:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 71 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L71:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 71 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L72:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 72 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L72:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 72 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L73:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 73 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L73:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 73 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L74:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 74 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L74:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 74 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 75 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2019.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 75 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L76:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 76 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L76:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 76 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L77:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 77 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlrnd19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L77:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 77 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L78:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 78 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_workers_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L78:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 78 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L79:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 79 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L79:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 79 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L80:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 80 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2019.dta") fields("rd_workers vs_rd_workers") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L80:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 80 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 81 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2019.dta") fields("sowste_raw vs_sowste_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 81 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L82:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 82 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2019.dta") fields("spplhi_raw vs_spplhi_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L82:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 82 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L83:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 83 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L83:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 83 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L84:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 84 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L84:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 84 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L85:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 85 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L85:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 85 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L86:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 86 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L86:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 86 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 87 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2019.dta") fields("val_cbdacu vs_val_cbdacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L87:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 87 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L88:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 88 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2019.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L88:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 88 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L89:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 89 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L89:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 89 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L90:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 90 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L90:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 90 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L91:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 91 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L91:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 91 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L92:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 92 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L92:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 92 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 93 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2019.dta") fields("val_cbsacu vs_val_cbsacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L93:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 93 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L94:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 94 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L94:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 94 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L95:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 95 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L95:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 95 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L96:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 96 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L96:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 96 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L97:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 97 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L97:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 97 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 98 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2019.dta") fields("val_cbttcu vs_val_cbttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L98:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 98 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 99 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2019.dta") fields("val_cldacu vs_val_cldacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L99:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 99 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 100 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2019.dta") fields("val_clfpcu vs_val_clfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L100:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 100 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L101:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 101 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L101:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 101 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L102:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 102 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L102:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 102 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L103:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 103 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L103:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 103 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L104:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 104 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L104:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 104 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 105 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2019.dta") fields("val_clsacu vs_val_clsacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L105:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 105 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L106:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 106 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L106:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 106 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L107:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 107 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L107:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 107 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L108:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 108 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L108:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 108 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L109:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 109 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L109:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 109 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L110:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 110 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2019.dta") fields("val_clttcu vs_val_clttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L110:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 110 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L111:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 111 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L111:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 111 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L112:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 112 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L112:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 112 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L113:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 113 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L113:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 113 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L114:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 114 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L114:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 114 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 115 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2019.dta") fields("val_cmdacu vs_val_cmdacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L115:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 115 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 116 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2019.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L116:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 116 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L117:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 117 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L117:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 117 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L118:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 118 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L118:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 118 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L119:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 119 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L119:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 119 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L120:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 120 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L120:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 120 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 121 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2019.dta") fields("val_cmsacu vs_val_cmsacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L121:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 121 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L122:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 122 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L122:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 122 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L123:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 123 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L123:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 123 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L124:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 124 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L124:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 124 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L125:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 125 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L125:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 125 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 126 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2019.dta") fields("val_cmttcu vs_val_cmttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L126:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 126 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L127:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 127 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L127:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 127 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L128:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 128 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L128:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 128 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L129:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 129 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L129:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 129 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L130:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 130 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L130:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 130 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 131 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2019.dta") fields("val_codacu vs_val_codacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L131:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 131 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 132 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2019.dta") fields("val_cofpcu vs_val_cofpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L132:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 132 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L133:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 133 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L133:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 133 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L134:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 134 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L134:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 134 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L135:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 135 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L135:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 135 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L136:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 136 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L136:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 136 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 137 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2019.dta") fields("val_cosacu vs_val_cosacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 137 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L138:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 138 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L138:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 138 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L139:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 139 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L139:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 139 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L140:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 140 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_costrd_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L140:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 140 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L141:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 141 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L141:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 141 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 142 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2019.dta") fields("val_costrd vs_val_costrd") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L142:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 142 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L143:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 143 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L143:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 143 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L144:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 144 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L144:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 144 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L145:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 145 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L145:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 145 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L146:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 146 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L146:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 146 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 147 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2019.dta") fields("val_cottcu vs_val_cottcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L147:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 147 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 148 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2019.dta") fields("val_csdacu vs_val_csdacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L148:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 148 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L149:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 149 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2019.dta") fields("val_csfpcu vs_val_csfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L149:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 149 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L150:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 150 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L150:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 150 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L151:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 151 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cssacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L151:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 151 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L152:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 152 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L152:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 152 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L153:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 153 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L153:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 153 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L154:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 154 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2019.dta") fields("val_cssacu vs_val_cssacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L154:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 154 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L155:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 155 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L155:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 155 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L156:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 156 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_csttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L156:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 156 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L157:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 157 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L157:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 157 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L158:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 158 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L158:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 158 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L159:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 159 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2019.dta") fields("val_csttcu vs_val_csttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L159:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 159 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L160:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 160 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L160:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 160 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L161:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 161 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L161:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 161 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L162:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 162 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L162:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 162 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L163:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 163 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L163:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 163 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L164:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 164 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2019.dta") fields("val_ctdacu vs_val_ctdacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L164:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 164 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L165:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 165 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2019.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L165:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 165 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L166:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 166 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L166:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 166 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L167:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 167 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L167:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 167 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L168:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 168 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L168:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 168 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L169:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 169 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L169:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 169 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L170:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 170 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2019.dta") fields("val_ctsacu vs_val_ctsacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L170:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 170 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 171 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2019.dta") fields("val_cttcu vs_val_cttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L171:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 171 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L172:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 172 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L172:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 172 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L173:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 173 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L173:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 173 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L174:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 174 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L174:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 174 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L175:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 175 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L175:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 175 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 176 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2019.dta") fields("val_ctttcu vs_val_ctttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 176 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L177:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 177 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L177:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 177 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L178:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 178 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L178:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 178 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L179:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 179 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L179:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 179 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L180:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 180 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L180:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 180 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 181 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2019.dta") fields("val_cvdacu vs_val_cvdacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L181:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 181 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 182 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2019.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L182:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 182 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L183:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 183 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L183:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 183 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L184:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 184 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L184:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 184 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L185:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 185 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L185:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 185 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L186:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 186 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L186:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 186 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 187 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2019.dta") fields("val_cvsacu vs_val_cvsacu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 187 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L188:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 188 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L188:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 188 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L189:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 189 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L189:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 189 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L190:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 190 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L190:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 190 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L191:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 191 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L191:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 191 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 192 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2019.dta") fields("val_cvttcu vs_val_cvttcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 192 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L193:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 193 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L193:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 193 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L194:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 194 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_devvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L194:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 194 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L195:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 195 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L195:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 195 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L196:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 196 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L196:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 196 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 197 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2019.dta") fields("val_devvcu vs_val_devvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 197 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 198 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2019.dta") fields("val_ecavce vs_val_ecavce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 198 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 199 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2019.dta") fields("val_ecavcu vs_val_ecavcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 199 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L200:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 200 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L200:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 200 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L201:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 201 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L201:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 201 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L202:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 202 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L202:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 202 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L203:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 203 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L203:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 203 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 204 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2019.dta") fields("val_ecbvce vs_val_ecbvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L204:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 204 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L205:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 205 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L205:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 205 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L206:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 206 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L206:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 206 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L207:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 207 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L207:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 207 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L208:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 208 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L208:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 208 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L209:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 209 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2019.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L209:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 209 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 210 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2019.dta") fields("val_eckvce vs_val_eckvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L210:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 210 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 211 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2019.dta") fields("val_eckvcu vs_val_eckvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 211 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L212:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 212 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L212:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 212 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L213:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 213 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L213:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 213 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L214:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 214 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L214:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 214 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L215:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 215 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L215:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 215 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 216 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2019.dta") fields("val_eclvce vs_val_eclvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 216 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L217:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 217 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L217:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 217 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L218:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 218 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L218:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 218 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L219:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 219 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L219:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 219 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L220:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 220 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L220:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 220 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 221 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2019.dta") fields("val_eclvcu vs_val_eclvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 221 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L222:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 222 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2019.dta") fields("val_edivce vs_val_edivce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L222:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 222 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L223:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 223 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2019.dta") fields("val_edivcu vs_val_edivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L223:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 223 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L224:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 224 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2019.dta") fields("val_efovce vs_val_efovce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L224:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 224 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 225 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2019.dta") fields("val_efovcu vs_val_efovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 225 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L226:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 226 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L226:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 226 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L227:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 227 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L227:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 227 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L228:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 228 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L228:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 228 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L229:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 229 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L229:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 229 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 230 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2019.dta") fields("val_efuvce vs_val_efuvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 230 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L231:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 231 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L231:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 231 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L232:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 232 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L232:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 232 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L233:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 233 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L233:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 233 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L234:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 234 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L234:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 234 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 235 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2019.dta") fields("val_efuvcu vs_val_efuvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 235 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L236:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 236 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L236:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 236 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L237:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 237 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L237:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 237 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L238:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 238 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L238:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 238 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L239:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 239 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L239:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 239 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 240 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2019.dta") fields("val_egavce vs_val_egavce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 240 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L241:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 241 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L241:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 241 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L242:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 242 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L242:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 242 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L243:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 243 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L243:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 243 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L244:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 244 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L244:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 244 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 245 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2019.dta") fields("val_egavcu vs_val_egavcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 245 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L246:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 246 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L246:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 246 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L247:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 247 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L247:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 247 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L248:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 248 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L248:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 248 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L249:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 249 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L249:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 249 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L250:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 250 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2019.dta") fields("val_egovce vs_val_egovce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L250:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 250 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L251:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 251 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L251:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 251 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L252:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 252 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L252:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 252 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L253:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 253 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L253:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 253 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L254:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 254 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L254:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 254 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L255:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 255 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2019.dta") fields("val_egovcu vs_val_egovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L255:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 255 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L256:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 256 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L256:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 256 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L257:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 257 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L257:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 257 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L258:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 258 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L258:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 258 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L259:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 259 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L259:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 259 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L260:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 260 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2019.dta") fields("val_elpvce vs_val_elpvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L260:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 260 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L261:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 261 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L261:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 261 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L262:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 262 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L262:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 262 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L263:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 263 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L263:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 263 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L264:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 264 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L264:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 264 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L265:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 265 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2019.dta") fields("val_elpvcu vs_val_elpvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L265:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 265 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L266:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 266 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L266:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 266 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L267:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 267 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L267:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 267 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L268:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 268 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L268:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 268 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L269:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 269 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L269:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 269 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L270:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 270 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2019.dta") fields("val_eluvce vs_val_eluvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L270:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 270 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L271:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 271 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L271:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 271 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L272:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 272 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L272:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 272 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L273:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 273 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L273:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 273 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L274:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 274 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L274:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 274 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 275 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2019.dta") fields("val_eluvcu vs_val_eluvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L275:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 275 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L276:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 276 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L276:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 276 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L277:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 277 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L277:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 277 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L278:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 278 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L278:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 278 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L279:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 279 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L279:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 279 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L280:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 280 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2019.dta") fields("val_encvce vs_val_encvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L280:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 280 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L281:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 281 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L281:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 281 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L282:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 282 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L282:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 282 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L283:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 283 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L283:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 283 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L284:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 284 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L284:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 284 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 285 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2019.dta") fields("val_encvcu vs_val_encvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L285:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 285 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 286 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2019.dta") fields("val_engvce vs_val_engvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L286:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 286 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 287 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2019.dta") fields("val_engvcu vs_val_engvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L287:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 287 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L288:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 288 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L288:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 288 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L289:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 289 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L289:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 289 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L290:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 290 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L290:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 290 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L291:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 291 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L291:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 291 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 292 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2019.dta") fields("val_enpvcu vs_val_enpvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L292:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 292 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 293 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2019.dta") fields("val_eoivce vs_val_eoivce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 293 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 294 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2019.dta") fields("val_eoivcu vs_val_eoivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 294 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L295:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 295 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L295:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 295 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L296:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 296 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L296:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 296 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L297:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 297 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L297:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 297 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L298:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 298 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L298:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 298 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 299 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2019.dta") fields("val_epevce vs_val_epevce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 299 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L300:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 300 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L300:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 300 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L301:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 301 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L301:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 301 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L302:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 302 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L302:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 302 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L303:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 303 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L303:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 303 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L304:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 304 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2019.dta") fields("val_epevcu vs_val_epevcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L304:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 304 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L305:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 305 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L305:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 305 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L306:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 306 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L306:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 306 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L307:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 307 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L307:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 307 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L308:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 308 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L308:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 308 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L309:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 309 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2019.dta") fields("val_eplvcu vs_val_eplvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L309:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 309 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 310 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2019.dta") fields("val_esdvce vs_val_esdvce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 310 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 311 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2019.dta") fields("val_esdvcu vs_val_esdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 311 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L312:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 312 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L312:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 312 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L313:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 313 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L313:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 313 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L314:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 314 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L314:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 314 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L315:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 315 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L315:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 315 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 316 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2019.dta") fields("val_esovce vs_val_esovce") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 316 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L317:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 317 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L317:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 317 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L318:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 318 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L318:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 318 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L319:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 319 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L319:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 319 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L320:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 320 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L320:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 320 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 321 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2019.dta") fields("val_esovcu vs_val_esovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 321 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L322:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 322 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L322:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 322 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L323:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 323 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L323:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 323 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L324:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 324 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L324:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 324 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L325:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 325 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L325:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 325 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 326 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2019.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 326 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L327:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 327 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L327:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 327 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L328:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 328 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L328:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 328 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L329:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 329 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L329:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 329 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L330:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 330 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L330:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 330 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 331 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2019.dta") fields("val_icovcu vs_val_icovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L331:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 331 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L332:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 332 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L332:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 332 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L333:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 333 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_idevcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L333:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 333 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L334:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 334 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L334:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 334 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L335:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 335 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L335:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 335 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 336 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2019.dta") fields("val_idevcu vs_val_idevcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 336 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L337:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 337 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L337:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 337 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L338:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 338 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L338:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 338 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L339:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 339 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L339:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 339 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L340:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 340 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L340:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 340 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 341 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2019.dta") fields("val_iinput vs_val_iinput") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 341 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L342:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 342 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L342:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 342 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L343:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 343 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L343:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 343 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L344:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 344 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L344:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 344 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L345:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 345 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L345:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 345 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 346 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2019.dta") fields("val_iinvcu vs_val_iinvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 346 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L347:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 347 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L347:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 347 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L348:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 348 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisfov19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L348:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 348 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L349:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 349 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L349:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 349 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L350:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 350 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L350:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 350 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 351 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2019.dta") fields("val_iisfov vs_val_iisfov") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 351 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L352:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 352 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L352:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 352 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L353:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 353 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iislov19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L353:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 353 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L354:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 354 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iislov_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L354:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 354 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L355:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 355 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L355:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 355 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 356 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2019.dta") fields("val_iislov vs_val_iislov") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L356:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 356 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L357:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 357 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L357:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 357 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L358:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 358 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L358:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 358 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L359:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 359 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L359:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 359 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L360:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 360 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L360:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 360 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 361 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2019.dta") fields("val_iisvcu vs_val_iisvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L361:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 361 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L362:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 362 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L362:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 362 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L363:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 363 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikivcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L363:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 363 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L364:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 364 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L364:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 364 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L365:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 365 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L365:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 365 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 366 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2019.dta") fields("val_ikivcu vs_val_ikivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L366:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 366 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L367:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 367 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L367:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 367 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L368:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 368 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iklvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L368:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 368 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L369:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 369 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L369:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 369 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L370:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 370 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L370:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 370 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 371 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2019.dta") fields("val_iklvcu vs_val_iklvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 371 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L372:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 372 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L372:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 372 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L373:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 373 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ikovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L373:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 373 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L374:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 374 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L374:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 374 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L375:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 375 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L375:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 375 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 376 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2019.dta") fields("val_ikovcu vs_val_ikovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 376 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L377:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 377 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L377:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 377 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L378:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 378 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L378:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 378 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L379:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 379 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L379:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 379 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L380:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 380 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L380:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 380 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 381 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2019.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 381 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L382:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 382 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L382:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 382 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L383:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 383 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_insvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L383:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 383 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L384:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 384 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L384:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 384 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L385:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 385 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L385:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 385 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 386 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2019.dta") fields("val_insvcu vs_val_insvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 386 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L387:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 387 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L387:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 387 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L388:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 388 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_intvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L388:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 388 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L389:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 389 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L389:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 389 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L390:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 390 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L390:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 390 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 391 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2019.dta") fields("val_intvcu vs_val_intvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 391 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L392:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 392 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L392:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 392 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L393:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 393 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L393:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 393 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L394:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 394 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L394:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 394 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L395:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 395 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L395:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 395 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L396:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 396 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2019.dta") fields("val_iotvcu vs_val_iotvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L396:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 396 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L397:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 397 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2019.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L397:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 397 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L398:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 398 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L398:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 398 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L399:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 399 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iprvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L399:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 399 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L400:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 400 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L400:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 400 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L401:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 401 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L401:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 401 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L402:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 402 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2019.dta") fields("val_iprvcu vs_val_iprvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L402:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 402 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L403:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 403 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L403:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 403 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L404:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 404 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L404:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 404 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L405:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 405 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L405:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 405 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L406:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 406 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L406:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 406 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 407 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2019.dta") fields("val_irdvcu vs_val_irdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 407 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 408 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2019.dta") fields("val_irevcu vs_val_irevcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 408 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L409:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 409 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L409:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 409 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L410:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 410 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L410:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 410 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L411:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 411 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L411:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 411 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L412:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 412 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L412:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 412 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 413 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2019.dta") fields("val_irrvcu vs_val_irrvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 413 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L414:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 414 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L414:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 414 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L415:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 415 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L415:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 415 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L416:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 416 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L416:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 416 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L417:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 417 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L417:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 417 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 418 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2019.dta") fields("val_itxvcu vs_val_itxvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 418 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 419 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2019.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 419 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L420:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 420 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L420:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 420 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L421:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 421 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_nopvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L421:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 421 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L422:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 422 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L422:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 422 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L423:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 423 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L423:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 423 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 424 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2019.dta") fields("val_nopvcu vs_val_nopvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 424 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L425:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 425 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L425:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 425 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L426:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 426 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_othvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L426:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 426 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L427:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 427 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L427:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 427 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L428:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 428 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L428:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 428 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 429 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2019.dta") fields("val_othvcu vs_val_othvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 429 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L430:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 430 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L430:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 430 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L431:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 431 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L431:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 431 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L432:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 432 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L432:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 432 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L433:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 433 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L433:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 433 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 434 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2019.dta") fields("val_output vs_val_output") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 434 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L435:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 435 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L435:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 435 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L436:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 436 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L436:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 436 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L437:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 437 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L437:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 437 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L438:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 438 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L438:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 438 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 439 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2019.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 439 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L440:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 440 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L440:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 440 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L441:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 441 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_renvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L441:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 441 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L442:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 442 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L442:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 442 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L443:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 443 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L443:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 443 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 444 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2019.dta") fields("val_renvcu vs_val_renvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 444 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L445:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 445 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L445:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 445 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L446:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 446 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L446:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 446 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L447:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 447 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L447:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 447 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L448:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 448 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L448:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 448 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 449 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2019.dta") fields("val_rimvcu vs_val_rimvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 449 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L450:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 450 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L450:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 450 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L451:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 451 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L451:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 451 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L452:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 452 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L452:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 452 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L453:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 453 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L453:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 453 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 454 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2019.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 454 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 455 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2019.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 455 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 456 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2019.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 456 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L457:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 457 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L457:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 457 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L458:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 458 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L458:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 458 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L459:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 459 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L459:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 459 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L460:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 460 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L460:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 460 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 461 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2019.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L461:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 461 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 462 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2019.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L462:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 462 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L463:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 463 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L463:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 463 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L464:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 464 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L464:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 464 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L465:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 465 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L465:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 465 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L466:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 466 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L466:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 466 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 467 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2019.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L467:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 467 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 468 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2019.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 468 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L469:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 469 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L469:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 469 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L470:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 470 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L470:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 470 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L471:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 471 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L471:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 471 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L472:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 472 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L472:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 472 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 473 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2019.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L473:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 473 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 474 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2019.dta") fields("val_sfovcu vs_val_sfovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 474 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L475:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 475 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2019.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L475:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 475 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 476 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2019.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 476 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 477 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2019.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L477:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 477 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L478:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 478 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L478:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 478 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L479:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 479 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L479:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 479 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L480:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 480 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L480:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 480 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L481:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 481 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L481:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 481 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 482 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2019.dta") fields("val_shdvcu vs_val_shdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 482 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L483:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 483 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L483:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 483 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L484:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 484 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L484:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 484 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L485:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 485 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L485:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 485 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L486:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 486 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L486:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 486 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 487 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2019.dta") fields("val_shfvcu vs_val_shfvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 487 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L488:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 488 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L488:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 488 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L489:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 489 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L489:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 489 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L490:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 490 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L490:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 490 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L491:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 491 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L491:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 491 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 492 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2019.dta") fields("val_shjvcu vs_val_shjvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 492 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L493:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 493 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L493:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 493 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L494:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 494 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L494:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 494 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L495:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 495 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L495:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 495 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L496:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 496 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L496:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 496 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 497 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2019.dta") fields("val_srdvcu vs_val_srdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L497:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 497 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L498:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 498 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L498:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 498 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L499:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 499 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L499:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 499 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L500:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 500 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L500:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 500 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L501:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 501 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L501:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 501 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 502 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2019.dta") fields("val_srjvcu vs_val_srjvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L502:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 502 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L503:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 503 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L503:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 503 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L504:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 504 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L504:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 504 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L505:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 505 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L505:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 505 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L506:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 506 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L506:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 506 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 507 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2019.dta") fields("val_srmvcu vs_val_srmvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 507 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L508:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 508 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L508:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 508 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L509:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 509 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L509:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 509 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L510:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 510 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L510:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 510 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L511:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 511 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L511:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 511 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 512 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2019.dta") fields("val_stdvcu vs_val_stdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 512 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L513:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 513 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L513:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 513 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L514:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 514 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L514:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 514 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L515:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 515 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L515:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 515 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L516:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 516 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L516:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 516 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 517 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2019.dta") fields("val_stjvcu vs_val_stjvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 517 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L518:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 518 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L518:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 518 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L519:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 519 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L519:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 519 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L520:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 520 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L520:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 520 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L521:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 521 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L521:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 521 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 522 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2019.dta") fields("val_stlvcu vs_val_stlvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 522 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L523:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 523 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L523:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 523 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L524:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 524 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L524:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 524 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L525:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 525 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L525:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 525 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L526:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 526 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L526:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 526 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 527 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2019.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 527 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L528:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 528 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L528:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 528 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L529:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 529 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L529:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 529 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L530:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 530 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L530:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 530 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L531:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 531 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L531:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 531 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 532 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2019.dta") fields("val_yelvcu vs_val_yelvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 532 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L533:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 533 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L533:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 533 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L534:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 534 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L534:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 534 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L535:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 535 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L535:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 535 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L536:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 536 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L536:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 536 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 537 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2019.dta") fields("val_yisvcu vs_val_yisvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L537:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 537 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L538:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 538 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L538:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 538 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L539:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 539 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L539:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 539 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L540:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 540 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L540:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 540 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L541:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 541 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L541:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 541 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 542 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2019.dta") fields("val_yisvdo vs_val_yisvdo") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L542:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 542 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L543:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 543 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L543:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 543 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L544:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 544 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L544:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 544 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L545:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 545 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L545:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 545 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L546:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 546 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L546:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 546 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 547 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2019.dta") fields("val_yisvfo vs_val_yisvfo") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L547:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 547 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L548:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 548 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L548:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 548 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L549:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 549 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L549:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 549 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L550:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 550 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L550:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 550 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L551:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 551 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L551:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 551 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 552 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2019.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L552:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 552 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L553:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 553 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L553:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 553 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L554:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 554 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykfvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L554:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 554 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L555:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 555 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L555:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 555 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L556:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 556 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L556:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 556 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 557 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2019.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 557 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L558:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 558 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L558:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 558 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L559:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 559 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ykivcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L559:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 559 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L560:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 560 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L560:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 560 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L561:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 561 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L561:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 561 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 562 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2019.dta") fields("val_ykivcu vs_val_ykivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 562 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L563:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 563 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L563:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 563 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L564:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 564 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L564:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 564 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L565:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 565 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L565:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 565 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L566:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 566 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L566:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 566 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 567 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2019.dta") fields("val_yprvcu vs_val_yprvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L567:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 567 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L568:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 568 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L568:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 568 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L569:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 569 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L569:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 569 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L570:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 570 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L570:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 570 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L571:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 571 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L571:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 571 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 572 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2019.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L572:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 572 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L573:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 573 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L573:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 573 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L574:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 574 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrsvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L574:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 574 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L575:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 575 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L575:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 575 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L576:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 576 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L576:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 576 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 577 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2019.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L577:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 577 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L578:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 578 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L578:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 578 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L579:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 579 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ysnvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L579:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 579 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L580:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 580 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L580:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 580 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L581:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 581 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L581:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 581 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 582 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2019.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L582:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 582 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 583 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2019.dta") fields("val_ytovcu vs_val_ytovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 583 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 584 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2019.dta") fields("val_znavcu vs_val_znavcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 584 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L585:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 585 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L585:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 585 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L586:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 586 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L586:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 586 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L587:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 587 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L587:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 587 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L588:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 588 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L588:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 588 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 589 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2019.dta") fields("val_zndvcu vs_val_zndvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 589 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L590:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 590 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L590:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 590 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L591:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 591 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znevcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L591:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 591 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L592:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 592 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L592:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 592 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L593:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 593 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L593:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 593 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 594 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2019.dta") fields("val_znevcu vs_val_znevcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 594 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L595:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 595 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L595:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 595 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L596:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 596 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znhvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L596:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 596 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L597:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 597 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L597:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 597 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L598:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 598 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L598:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 598 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 599 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2019.dta") fields("val_znhvcu vs_val_znhvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L599:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 599 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 600 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2019.dta") fields("val_znivcu vs_val_znivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L600:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 600 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L601:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 601 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2019.dta") fields("val_znovcu vs_val_znovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L601:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 601 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 602 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2019.dta") fields("val_znpvcu vs_val_znpvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L602:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 602 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L603:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 603 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L603:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 603 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L604:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 604 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znrvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L604:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 604 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L605:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 605 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L605:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 605 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L606:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 606 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L606:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 606 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 607 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2019.dta") fields("val_znrvcu vs_val_znrvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L607:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 607 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 608 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2019.dta") fields("val_znsvcu vs_val_znsvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 608 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L609:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 609 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L609:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 609 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L610:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 610 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zntvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L610:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 610 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L611:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 611 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L611:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 611 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L612:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 612 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L612:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 612 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 613 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2019.dta") fields("val_zntvcu vs_val_zntvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 613 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 614 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2019.dta") fields("val_zpavcu vs_val_zpavcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L614:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 614 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L615:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 615 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L615:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 615 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L616:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 616 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L616:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 616 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L617:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 617 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L617:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 617 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L618:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 618 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L618:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 618 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 619 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2019.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 619 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L620:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 620 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L620:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 620 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L621:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 621 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpevcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L621:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 621 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L622:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 622 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L622:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 622 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L623:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 623 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L623:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 623 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 624 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2019.dta") fields("val_zpevcu vs_val_zpevcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L624:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 624 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L625:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 625 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L625:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 625 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L626:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 626 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zphvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L626:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 626 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L627:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 627 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L627:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 627 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L628:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 628 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L628:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 628 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 629 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2019.dta") fields("val_zphvcu vs_val_zphvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L629:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 629 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 630 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2019.dta") fields("val_zpivcu vs_val_zpivcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L630:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 630 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L631:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 631 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2019.dta") fields("val_zpovcu vs_val_zpovcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L631:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 631 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 632 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2019.dta") fields("val_zppvcu vs_val_zppvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 632 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L633:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 633 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L633:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 633 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L634:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 634 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zprvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L634:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 634 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L635:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 635 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L635:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 635 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L636:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 636 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L636:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 636 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 637 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2019.dta") fields("val_zprvcu vs_val_zprvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 637 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 638 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2019.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 638 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L639:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 639 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L639:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 639 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L640:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 640 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zptvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L640:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 640 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L641:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 641 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L641:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 641 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L642:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 642 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L642:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 642 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 643 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2019.dta") fields("val_zptvcu vs_val_zptvcu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 643 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L644:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 644 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L644:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 644 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L645:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 645 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L645:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 645 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L646:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 646 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L646:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 646 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L647:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 647 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L647:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 647 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 648 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2019.dta") fields("value_added_nominal vs_value_added_nominal") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 648 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L649:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 649 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L649:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 649 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L650:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 650 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L650:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 650 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L651:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 651 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L651:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 651 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L652:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 652 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L652:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 652 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 653 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2019.dta") fields("workers vs_workers") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 653 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L654:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 654 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L654:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 654 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L655:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 655 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L655:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 655 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L656:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 656 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L656:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 656 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L657:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 657 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L657:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 657 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 658 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2019.dta") fields("source_id_raw vs_source_id_raw") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 658 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L659:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 659 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L659:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 659 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L660:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 660 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L660:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 660 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L661:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 661 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L661:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 661 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L662:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 662 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L662:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 662 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 663 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2019.dta") fields("district_code vs_district_code") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 663 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L664:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 664 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L664:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 664 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L665:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 665 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic519
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L665:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 665 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L666:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 666 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L666:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 666 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L667:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 667 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L667:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 667 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 668 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2019.dta") fields("industry_code vs_industry_code") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 668 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L669:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 669 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L669:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 669 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L670:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 670 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L670:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 670 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L671:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 671 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L671:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 671 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L672:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 672 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L672:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 672 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 673 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2019.dta") fields("province_code vs_province_code") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L673:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 673 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L674:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 674 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L674:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 674 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L675:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 675 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L675:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 675 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L676:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 676 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L676:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 676 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L677:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 677 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L677:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 677 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L678:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 678 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2019.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L678:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 678 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L679:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 679 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L679:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 679 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L680:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 680 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L680:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 680 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L681:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 681 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L681:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 681 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L682:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 682 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L682:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 682 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L683:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 683 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2019.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L683:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 683 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L684:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 684 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L684:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 684 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L685:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 685 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L685:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 685 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L686:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 686 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L686:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 686 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L687:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 687 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L687:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 687 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L688:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 688 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2019.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L688:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 688 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L689:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 689 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L689:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 689 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L690:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 690 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L690:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 690 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L691:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 691 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L691:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 691 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L692:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 692 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L692:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 692 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L693:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 693 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2019.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L693:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 693 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L694:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 694 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L694:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 694 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L695:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 695 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L695:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 695 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L696:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 696 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L696:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 696 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L697:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 697 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L697:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 697 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L698:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 698 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2019.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L698:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 698 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L699:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 699 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2019.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L699:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 699 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 700 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2019.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 700 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L701:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 701 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2019.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L701:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 701 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 702 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2019.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 702 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L703:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 703 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L703:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 703 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L704:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 704 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L704:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 704 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L705:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 705 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L705:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 705 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L706:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 706 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L706:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 706 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 707 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2019.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 707 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L708:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 708 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L708:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 708 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L709:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 709 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L709:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 709 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L710:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 710 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L710:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 710 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L711:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 711 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L711:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 711 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 712 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2019.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 712 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L713:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 713 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L713:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 713 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L714:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 714 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L714:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 714 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L715:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 715 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L715:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 715 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L716:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 716 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L716:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 716 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 717 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2019.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 717 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L718:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 718 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L718:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 718 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L719:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 719 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L719:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 719 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L720:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 720 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L720:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 720 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L721:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 721 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L721:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 721 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 722 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2019.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 722 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L723:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 723 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L723:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 723 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L724:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 724 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L724:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 724 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L725:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 725 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L725:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 725 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L726:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 726 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L726:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 726 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 727 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2019.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 727 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L728:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 728 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L728:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 728 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L729:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 729 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L729:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 729 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L730:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 730 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L730:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 730 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L731:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 731 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L731:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 731 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 732 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2019.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 732 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 733 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2019.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L733:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 733 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 734 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2019.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L734:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 734 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L735:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 735 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L735:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 735 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L736:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 736 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L736:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 736 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L737:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 737 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L737:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 737 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L738:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 738 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L738:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 738 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 739 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2019.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L739:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 739 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L740:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 740 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L740:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 740 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L741:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 741 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L741:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 741 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L742:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 742 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L742:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 742 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L743:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 743 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L743:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 743 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 744 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2019.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 744 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 745 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2019.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 745 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 746 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2019.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 746 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 747 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2019.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 747 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 748 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2019.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 748 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L749:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 749 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2019.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L749:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 749 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 750 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2019.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 750 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 751 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2019.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 751 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 752 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2019.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 752 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L753:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 753 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L753:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 753 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L754:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 754 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L754:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 754 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L755:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 755 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L755:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 755 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L756:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 756 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L756:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 756 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L757:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 757 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2019.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L757:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 757 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L758:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 758 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L758:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 758 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L759:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 759 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L759:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 759 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L760:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 760 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L760:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 760 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L761:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 761 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L761:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 761 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 762 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2019.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L762:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 762 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L763:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 763 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L763:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 763 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L764:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 764 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L764:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 764 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L765:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 765 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L765:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 765 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L766:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 766 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L766:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 766 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L767:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 767 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2019.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L767:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 767 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L768:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 768 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L768:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 768 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L769:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 769 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L769:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 769 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L770:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 770 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L770:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 770 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L771:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 771 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L771:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 771 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L772:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 772 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2019.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L772:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 772 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L773:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 773 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2019.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L773:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 773 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 774 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2019.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L774:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 774 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L775:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 775 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L775:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 775 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L776:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 776 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L776:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 776 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L777:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 777 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L777:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 777 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L778:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 778 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L778:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 778 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 779 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2019.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L779:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 779 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L780:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 780 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L780:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 780 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L781:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 781 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egom3u19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L781:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 781 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L782:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 782 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L782:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 782 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L783:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 783 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L783:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 783 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 784 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2019.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L784:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 784 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L785:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 785 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L785:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 785 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L786:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 786 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L786:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 786 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L787:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 787 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L787:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 787 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L788:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 788 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L788:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 788 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L789:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 789 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2019.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L789:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 789 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L790:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 790 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L790:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 790 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L791:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 791 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L791:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 791 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L792:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 792 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L792:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 792 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L793:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 793 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L793:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 793 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L794:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 794 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2019.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L794:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 794 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L795:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 795 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L795:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 795 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L796:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 796 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L796:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 796 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L797:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 797 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L797:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 797 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L798:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 798 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L798:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 798 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L799:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 799 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2019.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L799:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 799 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L800:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 800 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L800:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 800 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L801:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 801 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L801:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 801 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L802:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 802 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L802:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 802 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L803:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 803 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L803:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 803 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L804:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 804 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2019.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L804:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 804 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L805:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 805 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L805:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 805 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L806:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 806 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L806:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 806 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L807:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 807 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L807:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 807 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L808:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 808 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L808:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 808 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L809:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 809 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2019.dta") fields("export_any_binary vs_export_any_binary") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L809:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 809 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L810:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 810 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L810:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 810 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L811:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 811 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L811:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 811 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L812:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 812 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L812:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 812 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L813:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 813 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L813:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 813 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 814 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2019.dta") fields("export_direct_flag vs_export_direct_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L814:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 814 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L815:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 815 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L815:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 815 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L816:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 816 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rnd19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L816:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 816 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L817:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 817 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L817:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 817 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L818:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 818 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L818:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 818 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 819 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2019.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L819:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 819 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L820:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 820 836 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L820:step-preserve" "code/annual/merge_mapped_2019.do:L1:file" "statement" 820 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L821:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 821 836 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_costrd19
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L821:step-keep" "code/annual/merge_mapped_2019.do:L1:file" "statement" 821 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L822:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 822 836 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2019.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L822:step-cf" "code/annual/merge_mapped_2019.do:L1:file" "statement" 822 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L823:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 823 836 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L823:step-restore" "code/annual/merge_mapped_2019.do:L1:file" "statement" 823 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L824:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 824 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2019.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L824:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 824 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L825:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 825 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2019.dta") fields("innovation_flag vs_innovation_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L825:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 825 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L826:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 826 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2019.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L826:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 826 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L827:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 827 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2019.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L827:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 827 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L828:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 828 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2019.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L828:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 828 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L829:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 829 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2019.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L829:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 829 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L830:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 830 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2019.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L830:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 830 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L831:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 831 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2019.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L831:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 831 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L832:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 832 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2019.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L832:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 832 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L833:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 833 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2019.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L833:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 833 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L834:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 834 836 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2019.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2019)
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L834:step-wf_merge_guard" "code/annual/merge_mapped_2019.do:L1:file" "statement" 834 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L835:step-isid" "code/annual/merge_mapped_2019.do:L1:file" "statement" 835 836 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L835:step-isid" "code/annual/merge_mapped_2019.do:L1:file" "statement" 835 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2019.do:L836:step-save" "code/annual/merge_mapped_2019.do:L1:file" "statement" 836 836 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2019.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L836:step-save" "code/annual/merge_mapped_2019.do:L1:file" "statement" 836 836 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2019.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
