* Tujuan: Gabungkan hasil pemetaan kolom tahun 2011 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2011.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2011.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L1:step-do" "code/annual/merge_mapped_2011.do:L1:file" "statement" 1 724 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L1:step-do" "code/annual/merge_mapped_2011.do:L1:file" "statement" 1 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L2:step-do" "code/annual/merge_mapped_2011.do:L1:file" "statement" 2 724 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L2:step-do" "code/annual/merge_mapped_2011.do:L1:file" "statement" 2 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L3:step-use" "code/annual/merge_mapped_2011.do:L1:file" "statement" 3 724 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2011.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L3:step-use" "code/annual/merge_mapped_2011.do:L1:file" "statement" 3 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L4:step-assert" "code/annual/merge_mapped_2011.do:L1:file" "statement" 4 724 `=_rc' // WFLOG-INJECTED
assert source_year==2011
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L4:step-assert" "code/annual/merge_mapped_2011.do:L1:file" "statement" 4 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L5:step-isid" "code/annual/merge_mapped_2011.do:L1:file" "statement" 5 724 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L5:step-isid" "code/annual/merge_mapped_2011.do:L1:file" "statement" 5 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 6 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2011.dta") fields("amdal_raw vs_amdal_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 6 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 7 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2011.dta") fields("b3wste_raw vs_b3wste_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 7 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L8:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 8 724 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L8:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 8 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L9:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 9 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L9:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 9 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L10:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 10 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L10:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 10 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L11:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 11 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L11:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 11 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 12 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2011.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 12 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L13:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 13 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L13:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 13 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L14:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 14 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L14:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 14 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L15:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 15 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L15:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 15 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L16:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 16 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L16:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 16 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 17 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2011.dta") fields("capital_nominal vs_capital_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 17 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L18:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 18 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L18:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 18 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L19:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 19 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L19:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 19 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L20:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 20 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L20:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 20 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L21:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 21 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L21:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 21 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 22 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2011.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 22 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L23:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 23 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L23:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 23 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L24:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 24 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L24:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 24 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L25:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 25 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L25:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 25 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L26:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 26 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L26:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 26 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 27 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2011.dta") fields("export_binary_raw vs_export_binary_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 27 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L28:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 28 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L28:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 28 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L29:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 29 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L29:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 29 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L30:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 30 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L30:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 30 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L31:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 31 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L31:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 31 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 32 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2011.dta") fields("export_share_pct vs_export_share_pct") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 32 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L33:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 33 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L33:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 33 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L34:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 34 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L34:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 34 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L35:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 35 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L35:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 35 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L36:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 36 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L36:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 36 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 37 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2011.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 37 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L38:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 38 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L38:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 38 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L39:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 39 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L39:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 39 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L40:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 40 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L40:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 40 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L41:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 41 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L41:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 41 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 42 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2011.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 42 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L43:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 43 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L43:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 43 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L44:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 44 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L44:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 44 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L45:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 45 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L45:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 45 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L46:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 46 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L46:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 46 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 47 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2011.dta") fields("import_value_nominal vs_import_value_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 47 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 48 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2011.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 48 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 49 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2011.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 49 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 50 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2011.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 50 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 51 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2011.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 51 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 52 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2011.dta") fields("innovation_raw vs_innovation_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 52 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 53 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2011.dta") fields("inspli_raw vs_inspli_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 53 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L54:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 54 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L54:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 54 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L55:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 55 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L55:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 55 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L56:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 56 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L56:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 56 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L57:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 57 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L57:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 57 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 58 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2011.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 58 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 59 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2011.dta") fields("liwste_raw vs_liwste_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 59 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 60 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2011.dta") fields("pplihi_raw vs_pplihi_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 60 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L61:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 61 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L61:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 61 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L62:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 62 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L62:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 62 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L63:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 63 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L63:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 63 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L64:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 64 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L64:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 64 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 65 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2011.dta") fields("production_workers vs_production_workers") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 65 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 66 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2011.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 66 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 67 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2011.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 67 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 68 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2011.dta") fields("rd_workers vs_rd_workers") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 68 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 69 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2011.dta") fields("sowste_raw vs_sowste_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 69 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 70 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2011.dta") fields("spplhi_raw vs_spplhi_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 70 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L71:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 71 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L71:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 71 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L72:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 72 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L72:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 72 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L73:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 73 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L73:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 73 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L74:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 74 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L74:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 74 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 75 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2011.dta") fields("val_cbdacu vs_val_cbdacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 75 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 76 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2011.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 76 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L77:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 77 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L77:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 77 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L78:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 78 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L78:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 78 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L79:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 79 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L79:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 79 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L80:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 80 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L80:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 80 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 81 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2011.dta") fields("val_cbsacu vs_val_cbsacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 81 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L82:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 82 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L82:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 82 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L83:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 83 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L83:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 83 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L84:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 84 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L84:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 84 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L85:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 85 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L85:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 85 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 86 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2011.dta") fields("val_cbttcu vs_val_cbttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 86 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L87:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 87 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L87:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 87 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L88:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 88 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cldacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L88:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 88 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L89:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 89 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L89:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 89 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L90:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 90 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L90:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 90 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 91 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2011.dta") fields("val_cldacu vs_val_cldacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 91 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 92 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2011.dta") fields("val_clfpcu vs_val_clfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 92 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L93:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 93 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L93:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 93 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L94:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 94 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L94:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 94 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L95:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 95 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L95:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 95 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L96:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 96 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L96:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 96 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 97 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2011.dta") fields("val_clsacu vs_val_clsacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 97 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L98:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 98 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L98:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 98 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L99:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 99 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L99:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 99 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L100:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 100 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L100:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 100 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L101:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 101 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L101:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 101 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 102 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2011.dta") fields("val_clttcu vs_val_clttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 102 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L103:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 103 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L103:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 103 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L104:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 104 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L104:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 104 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L105:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 105 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L105:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 105 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L106:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 106 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L106:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 106 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 107 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2011.dta") fields("val_cmdacu vs_val_cmdacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 107 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 108 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2011.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 108 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L109:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 109 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L109:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 109 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L110:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 110 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L110:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 110 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L111:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 111 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L111:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 111 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L112:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 112 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L112:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 112 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 113 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2011.dta") fields("val_cmsacu vs_val_cmsacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 113 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L114:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 114 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L114:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 114 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L115:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 115 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L115:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 115 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L116:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 116 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L116:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 116 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L117:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 117 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L117:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 117 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 118 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2011.dta") fields("val_cmttcu vs_val_cmttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 118 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L119:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 119 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L119:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 119 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L120:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 120 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L120:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 120 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L121:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 121 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L121:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 121 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L122:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 122 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L122:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 122 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 123 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2011.dta") fields("val_codacu vs_val_codacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 123 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 124 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2011.dta") fields("val_cofpcu vs_val_cofpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 124 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L125:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 125 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L125:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 125 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L126:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 126 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L126:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 126 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L127:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 127 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L127:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 127 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L128:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 128 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L128:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 128 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 129 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2011.dta") fields("val_cosacu vs_val_cosacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 129 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 130 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2011.dta") fields("val_costrd vs_val_costrd") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 130 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L131:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 131 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L131:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 131 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L132:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 132 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L132:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 132 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L133:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 133 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L133:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 133 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L134:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 134 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L134:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 134 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 135 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2011.dta") fields("val_cottcu vs_val_cottcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 135 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 136 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2011.dta") fields("val_csdacu vs_val_csdacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 136 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 137 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2011.dta") fields("val_csfpcu vs_val_csfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 137 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 138 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2011.dta") fields("val_cssacu vs_val_cssacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 138 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 139 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2011.dta") fields("val_csttcu vs_val_csttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 139 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L140:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 140 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L140:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 140 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L141:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 141 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L141:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 141 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L142:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 142 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L142:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 142 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L143:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 143 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L143:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 143 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 144 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2011.dta") fields("val_ctdacu vs_val_ctdacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 144 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 145 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2011.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 145 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L146:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 146 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L146:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 146 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L147:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 147 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L147:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 147 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L148:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 148 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L148:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 148 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L149:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 149 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L149:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 149 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 150 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2011.dta") fields("val_ctsacu vs_val_ctsacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 150 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 151 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2011.dta") fields("val_cttcu vs_val_cttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 151 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L152:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 152 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L152:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 152 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L153:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 153 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L153:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 153 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L154:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 154 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L154:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 154 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L155:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 155 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L155:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 155 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 156 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2011.dta") fields("val_ctttcu vs_val_ctttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 156 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L157:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 157 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L157:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 157 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L158:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 158 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L158:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 158 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L159:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 159 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L159:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 159 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L160:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 160 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L160:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 160 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 161 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2011.dta") fields("val_cvdacu vs_val_cvdacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 161 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 162 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2011.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 162 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L163:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 163 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L163:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 163 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L164:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 164 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L164:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 164 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L165:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 165 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L165:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 165 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L166:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 166 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L166:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 166 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 167 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2011.dta") fields("val_cvsacu vs_val_cvsacu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 167 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L168:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 168 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L168:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 168 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L169:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 169 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L169:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 169 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L170:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 170 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L170:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 170 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L171:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 171 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L171:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 171 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 172 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2011.dta") fields("val_cvttcu vs_val_cvttcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 172 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 173 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2011.dta") fields("val_devvcu vs_val_devvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 173 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 174 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2011.dta") fields("val_ecavce vs_val_ecavce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 174 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 175 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2011.dta") fields("val_ecavcu vs_val_ecavcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 175 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 176 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2011.dta") fields("val_ecbvce vs_val_ecbvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L176:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 176 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 177 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2011.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L177:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 177 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L178:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 178 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2011.dta") fields("val_eckvce vs_val_eckvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L178:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 178 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 179 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2011.dta") fields("val_eckvcu vs_val_eckvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L179:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 179 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L180:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 180 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L180:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 180 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L181:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 181 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L181:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 181 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L182:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 182 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L182:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 182 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L183:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 183 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L183:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 183 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 184 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2011.dta") fields("val_eclvce vs_val_eclvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L184:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 184 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L185:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 185 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L185:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 185 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L186:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 186 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L186:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 186 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L187:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 187 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L187:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 187 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L188:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 188 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L188:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 188 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L189:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 189 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2011.dta") fields("val_eclvcu vs_val_eclvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L189:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 189 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 190 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2011.dta") fields("val_edivce vs_val_edivce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L190:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 190 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 191 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2011.dta") fields("val_edivcu vs_val_edivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L191:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 191 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 192 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2011.dta") fields("val_efovce vs_val_efovce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 192 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 193 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2011.dta") fields("val_efovcu vs_val_efovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L193:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 193 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L194:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 194 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L194:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 194 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L195:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 195 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L195:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 195 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L196:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 196 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L196:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 196 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L197:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 197 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L197:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 197 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 198 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2011.dta") fields("val_efuvce vs_val_efuvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 198 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L199:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 199 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L199:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 199 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L200:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 200 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L200:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 200 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L201:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 201 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L201:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 201 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L202:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 202 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L202:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 202 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 203 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2011.dta") fields("val_efuvcu vs_val_efuvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L203:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 203 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L204:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 204 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L204:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 204 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L205:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 205 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L205:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 205 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L206:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 206 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L206:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 206 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L207:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 207 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L207:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 207 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 208 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2011.dta") fields("val_egavce vs_val_egavce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L208:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 208 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L209:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 209 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L209:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 209 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L210:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 210 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L210:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 210 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L211:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 211 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L211:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 211 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L212:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 212 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L212:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 212 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 213 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2011.dta") fields("val_egavcu vs_val_egavcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L213:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 213 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 214 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2011.dta") fields("val_egovce vs_val_egovce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L214:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 214 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 215 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2011.dta") fields("val_egovcu vs_val_egovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L215:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 215 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L216:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 216 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L216:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 216 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L217:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 217 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L217:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 217 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L218:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 218 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L218:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 218 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L219:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 219 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L219:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 219 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 220 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2011.dta") fields("val_elpvce vs_val_elpvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L220:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 220 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L221:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 221 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L221:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 221 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L222:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 222 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L222:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 222 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L223:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 223 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L223:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 223 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L224:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 224 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L224:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 224 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 225 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2011.dta") fields("val_elpvcu vs_val_elpvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L225:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 225 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L226:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 226 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L226:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 226 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L227:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 227 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L227:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 227 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L228:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 228 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L228:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 228 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L229:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 229 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L229:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 229 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 230 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2011.dta") fields("val_eluvce vs_val_eluvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L230:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 230 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L231:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 231 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L231:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 231 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L232:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 232 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L232:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 232 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L233:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 233 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L233:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 233 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L234:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 234 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L234:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 234 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 235 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2011.dta") fields("val_eluvcu vs_val_eluvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L235:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 235 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L236:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 236 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L236:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 236 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L237:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 237 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L237:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 237 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L238:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 238 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L238:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 238 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L239:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 239 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L239:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 239 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 240 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2011.dta") fields("val_encvce vs_val_encvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L240:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 240 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L241:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 241 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L241:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 241 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L242:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 242 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L242:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 242 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L243:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 243 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L243:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 243 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L244:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 244 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L244:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 244 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 245 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2011.dta") fields("val_encvcu vs_val_encvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L245:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 245 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 246 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2011.dta") fields("val_engvce vs_val_engvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 246 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 247 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2011.dta") fields("val_engvcu vs_val_engvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L247:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 247 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L248:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 248 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L248:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 248 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L249:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 249 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L249:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 249 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L250:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 250 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L250:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 250 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L251:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 251 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L251:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 251 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 252 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2011.dta") fields("val_enpvcu vs_val_enpvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L252:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 252 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L253:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 253 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L253:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 253 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L254:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 254 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L254:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 254 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L255:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 255 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L255:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 255 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L256:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 256 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L256:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 256 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 257 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2011.dta") fields("val_eoivce vs_val_eoivce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L257:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 257 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L258:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 258 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L258:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 258 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L259:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 259 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L259:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 259 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L260:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 260 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L260:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 260 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L261:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 261 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L261:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 261 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 262 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2011.dta") fields("val_eoivcu vs_val_eoivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 262 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L263:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 263 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L263:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 263 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L264:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 264 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L264:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 264 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L265:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 265 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L265:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 265 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L266:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 266 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L266:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 266 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 267 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2011.dta") fields("val_epevce vs_val_epevce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L267:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 267 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L268:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 268 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L268:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 268 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L269:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 269 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L269:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 269 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L270:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 270 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L270:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 270 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L271:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 271 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L271:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 271 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L272:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 272 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2011.dta") fields("val_epevcu vs_val_epevcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L272:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 272 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L273:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 273 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L273:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 273 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L274:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 274 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L274:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 274 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L275:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 275 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L275:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 275 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L276:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 276 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L276:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 276 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L277:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 277 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2011.dta") fields("val_eplvcu vs_val_eplvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L277:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 277 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 278 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2011.dta") fields("val_esdvce vs_val_esdvce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 278 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L279:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 279 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2011.dta") fields("val_esdvcu vs_val_esdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L279:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 279 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L280:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 280 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L280:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 280 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L281:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 281 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L281:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 281 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L282:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 282 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L282:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 282 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L283:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 283 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L283:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 283 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 284 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2011.dta") fields("val_esovce vs_val_esovce") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L284:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 284 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L285:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 285 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L285:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 285 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L286:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 286 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L286:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 286 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L287:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 287 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L287:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 287 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L288:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 288 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L288:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 288 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 289 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2011.dta") fields("val_esovcu vs_val_esovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L289:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 289 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L290:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 290 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L290:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 290 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L291:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 291 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L291:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 291 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L292:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 292 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L292:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 292 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L293:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 293 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L293:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 293 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 294 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2011.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 294 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L295:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 295 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L295:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 295 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L296:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 296 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L296:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 296 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L297:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 297 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L297:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 297 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L298:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 298 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L298:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 298 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 299 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2011.dta") fields("val_icovcu vs_val_icovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L299:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 299 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 300 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2011.dta") fields("val_idevcu vs_val_idevcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 300 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L301:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 301 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L301:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 301 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L302:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 302 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L302:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 302 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L303:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 303 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L303:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 303 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L304:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 304 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L304:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 304 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 305 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2011.dta") fields("val_iinput vs_val_iinput") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 305 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L306:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 306 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L306:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 306 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L307:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 307 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L307:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 307 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L308:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 308 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L308:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 308 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L309:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 309 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L309:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 309 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 310 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2011.dta") fields("val_iinvcu vs_val_iinvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 310 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 311 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2011.dta") fields("val_iisfov vs_val_iisfov") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L311:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 311 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 312 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2011.dta") fields("val_iislov vs_val_iislov") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L312:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 312 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L313:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 313 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L313:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 313 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L314:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 314 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L314:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 314 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L315:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 315 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L315:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 315 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L316:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 316 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L316:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 316 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 317 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2011.dta") fields("val_iisvcu vs_val_iisvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L317:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 317 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L318:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 318 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2011.dta") fields("val_ikivcu vs_val_ikivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L318:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 318 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 319 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2011.dta") fields("val_iklvcu vs_val_iklvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L319:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 319 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 320 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2011.dta") fields("val_ikovcu vs_val_ikovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L320:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 320 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L321:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 321 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L321:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 321 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L322:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 322 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L322:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 322 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L323:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 323 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L323:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 323 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L324:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 324 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L324:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 324 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 325 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2011.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L325:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 325 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 326 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2011.dta") fields("val_insvcu vs_val_insvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 326 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 327 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2011.dta") fields("val_intvcu vs_val_intvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 327 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L328:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 328 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L328:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 328 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L329:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 329 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L329:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 329 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L330:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 330 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L330:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 330 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L331:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 331 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L331:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 331 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 332 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2011.dta") fields("val_iotvcu vs_val_iotvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L332:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 332 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 333 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2011.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 333 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 334 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2011.dta") fields("val_iprvcu vs_val_iprvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 334 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 335 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2011.dta") fields("val_irdvcu vs_val_irdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 335 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 336 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2011.dta") fields("val_irevcu vs_val_irevcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 336 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L337:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 337 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L337:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 337 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L338:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 338 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L338:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 338 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L339:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 339 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L339:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 339 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L340:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 340 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L340:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 340 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 341 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2011.dta") fields("val_irrvcu vs_val_irrvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 341 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L342:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 342 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L342:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 342 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L343:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 343 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L343:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 343 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L344:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 344 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L344:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 344 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L345:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 345 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L345:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 345 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 346 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2011.dta") fields("val_itxvcu vs_val_itxvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L346:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 346 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L347:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 347 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2011.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L347:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 347 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 348 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2011.dta") fields("val_nopvcu vs_val_nopvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 348 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 349 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2011.dta") fields("val_othvcu vs_val_othvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 349 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L350:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 350 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L350:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 350 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L351:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 351 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L351:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 351 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L352:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 352 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L352:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 352 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L353:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 353 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L353:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 353 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 354 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2011.dta") fields("val_output vs_val_output") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L354:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 354 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L355:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 355 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L355:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 355 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L356:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 356 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L356:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 356 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L357:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 357 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L357:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 357 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L358:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 358 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L358:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 358 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 359 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2011.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L359:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 359 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 360 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2011.dta") fields("val_renvcu vs_val_renvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L360:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 360 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L361:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 361 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L361:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 361 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L362:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 362 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L362:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 362 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L363:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 363 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L363:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 363 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L364:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 364 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L364:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 364 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 365 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2011.dta") fields("val_rimvcu vs_val_rimvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 365 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L366:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 366 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L366:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 366 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L367:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 367 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L367:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 367 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L368:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 368 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L368:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 368 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L369:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 369 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L369:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 369 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 370 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2011.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 370 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 371 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2011.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L371:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 371 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 372 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2011.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L372:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 372 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L373:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 373 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L373:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 373 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L374:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 374 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L374:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 374 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L375:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 375 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L375:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 375 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L376:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 376 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L376:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 376 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 377 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2011.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L377:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 377 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 378 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2011.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L378:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 378 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L379:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 379 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L379:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 379 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L380:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 380 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L380:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 380 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L381:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 381 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L381:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 381 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L382:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 382 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L382:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 382 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 383 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2011.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L383:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 383 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 384 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2011.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L384:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 384 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L385:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 385 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L385:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 385 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L386:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 386 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L386:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 386 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L387:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 387 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L387:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 387 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L388:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 388 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L388:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 388 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 389 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2011.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L389:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 389 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 390 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2011.dta") fields("val_sfovcu vs_val_sfovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L390:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 390 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 391 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2011.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L391:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 391 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 392 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2011.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L392:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 392 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 393 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2011.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 393 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L394:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 394 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L394:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 394 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L395:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 395 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L395:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 395 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L396:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 396 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L396:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 396 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L397:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 397 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L397:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 397 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 398 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2011.dta") fields("val_shdvcu vs_val_shdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L398:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 398 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L399:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 399 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L399:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 399 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L400:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 400 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L400:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 400 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L401:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 401 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L401:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 401 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L402:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 402 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L402:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 402 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 403 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2011.dta") fields("val_shfvcu vs_val_shfvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L403:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 403 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L404:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 404 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L404:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 404 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L405:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 405 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L405:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 405 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L406:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 406 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L406:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 406 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L407:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 407 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L407:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 407 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 408 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2011.dta") fields("val_shjvcu vs_val_shjvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 408 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L409:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 409 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L409:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 409 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L410:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 410 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L410:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 410 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L411:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 411 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L411:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 411 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L412:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 412 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L412:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 412 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 413 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2011.dta") fields("val_srdvcu vs_val_srdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L413:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 413 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L414:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 414 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L414:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 414 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L415:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 415 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L415:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 415 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L416:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 416 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L416:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 416 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L417:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 417 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L417:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 417 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 418 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2011.dta") fields("val_srjvcu vs_val_srjvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L418:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 418 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L419:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 419 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L419:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 419 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L420:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 420 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L420:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 420 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L421:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 421 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L421:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 421 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L422:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 422 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L422:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 422 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 423 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2011.dta") fields("val_srmvcu vs_val_srmvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L423:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 423 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L424:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 424 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L424:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 424 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L425:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 425 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L425:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 425 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L426:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 426 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L426:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 426 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L427:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 427 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L427:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 427 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 428 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2011.dta") fields("val_stdvcu vs_val_stdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L428:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 428 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L429:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 429 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L429:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 429 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L430:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 430 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L430:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 430 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L431:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 431 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L431:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 431 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L432:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 432 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L432:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 432 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 433 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2011.dta") fields("val_stjvcu vs_val_stjvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L433:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 433 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L434:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 434 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L434:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 434 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L435:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 435 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L435:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 435 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L436:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 436 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L436:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 436 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L437:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 437 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L437:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 437 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 438 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2011.dta") fields("val_stlvcu vs_val_stlvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L438:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 438 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L439:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 439 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L439:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 439 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L440:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 440 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L440:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 440 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L441:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 441 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L441:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 441 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L442:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 442 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L442:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 442 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 443 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2011.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L443:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 443 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L444:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 444 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L444:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 444 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L445:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 445 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L445:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 445 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L446:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 446 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L446:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 446 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L447:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 447 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L447:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 447 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 448 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2011.dta") fields("val_yelvcu vs_val_yelvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L448:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 448 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L449:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 449 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L449:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 449 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L450:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 450 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L450:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 450 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L451:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 451 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L451:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 451 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L452:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 452 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L452:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 452 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 453 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2011.dta") fields("val_yisvcu vs_val_yisvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L453:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 453 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 454 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2011.dta") fields("val_yisvdo vs_val_yisvdo") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 454 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 455 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2011.dta") fields("val_yisvfo vs_val_yisvfo") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L455:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 455 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 456 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2011.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L456:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 456 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 457 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2011.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L457:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 457 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 458 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2011.dta") fields("val_ykivcu vs_val_ykivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L458:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 458 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L459:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 459 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L459:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 459 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L460:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 460 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L460:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 460 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L461:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 461 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L461:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 461 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L462:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 462 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L462:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 462 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 463 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2011.dta") fields("val_yprvcu vs_val_yprvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L463:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 463 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L464:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 464 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L464:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 464 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L465:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 465 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L465:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 465 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L466:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 466 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L466:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 466 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L467:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 467 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L467:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 467 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 468 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2011.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L468:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 468 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 469 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2011.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 469 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 470 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2011.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L470:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 470 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 471 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2011.dta") fields("val_ytovcu vs_val_ytovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L471:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 471 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L472:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 472 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L472:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 472 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L473:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 473 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L473:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 473 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L474:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 474 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L474:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 474 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L475:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 475 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L475:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 475 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 476 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2011.dta") fields("val_znavcu vs_val_znavcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L476:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 476 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L477:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 477 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L477:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 477 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L478:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 478 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L478:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 478 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L479:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 479 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L479:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 479 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L480:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 480 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L480:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 480 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 481 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2011.dta") fields("val_zndvcu vs_val_zndvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 481 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 482 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2011.dta") fields("val_znevcu vs_val_znevcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 482 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L483:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 483 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2011.dta") fields("val_znhvcu vs_val_znhvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L483:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 483 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L484:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 484 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L484:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 484 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L485:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 485 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L485:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 485 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L486:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 486 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L486:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 486 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L487:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 487 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L487:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 487 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L488:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 488 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2011.dta") fields("val_znivcu vs_val_znivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L488:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 488 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L489:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 489 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L489:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 489 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L490:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 490 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L490:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 490 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L491:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 491 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L491:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 491 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L492:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 492 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L492:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 492 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 493 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2011.dta") fields("val_znovcu vs_val_znovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 493 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L494:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 494 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L494:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 494 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L495:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 495 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L495:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 495 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L496:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 496 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L496:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 496 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L497:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 497 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L497:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 497 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 498 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2011.dta") fields("val_znpvcu vs_val_znpvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L498:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 498 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 499 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2011.dta") fields("val_znrvcu vs_val_znrvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L499:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 499 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L500:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 500 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L500:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 500 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L501:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 501 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L501:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 501 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L502:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 502 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L502:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 502 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L503:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 503 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L503:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 503 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 504 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2011.dta") fields("val_znsvcu vs_val_znsvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L504:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 504 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 505 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2011.dta") fields("val_zntvcu vs_val_zntvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 505 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L506:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 506 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L506:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 506 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L507:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 507 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L507:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 507 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L508:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 508 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L508:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 508 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L509:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 509 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L509:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 509 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L510:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 510 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2011.dta") fields("val_zpavcu vs_val_zpavcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L510:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 510 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L511:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 511 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L511:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 511 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L512:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 512 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L512:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 512 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L513:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 513 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L513:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 513 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L514:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 514 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L514:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 514 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 515 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2011.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L515:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 515 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 516 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2011.dta") fields("val_zpevcu vs_val_zpevcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L516:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 516 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 517 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2011.dta") fields("val_zphvcu vs_val_zphvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 517 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L518:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 518 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L518:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 518 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L519:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 519 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L519:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 519 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L520:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 520 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L520:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 520 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L521:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 521 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L521:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 521 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 522 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2011.dta") fields("val_zpivcu vs_val_zpivcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 522 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L523:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 523 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L523:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 523 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L524:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 524 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L524:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 524 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L525:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 525 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L525:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 525 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L526:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 526 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L526:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 526 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 527 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2011.dta") fields("val_zpovcu vs_val_zpovcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L527:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 527 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L528:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 528 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L528:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 528 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L529:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 529 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L529:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 529 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L530:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 530 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L530:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 530 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L531:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 531 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L531:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 531 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 532 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2011.dta") fields("val_zppvcu vs_val_zppvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L532:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 532 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 533 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2011.dta") fields("val_zprvcu vs_val_zprvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L533:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 533 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L534:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 534 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L534:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 534 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L535:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 535 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L535:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 535 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L536:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 536 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L536:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 536 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L537:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 537 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L537:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 537 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 538 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2011.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L538:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 538 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 539 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2011.dta") fields("val_zptvcu vs_val_zptvcu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 539 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L540:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 540 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L540:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 540 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L541:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 541 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L541:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 541 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L542:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 542 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L542:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 542 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L543:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 543 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L543:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 543 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 544 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2011.dta") fields("value_added_nominal vs_value_added_nominal") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L544:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 544 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L545:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 545 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L545:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 545 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L546:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 546 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L546:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 546 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L547:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 547 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L547:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 547 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L548:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 548 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L548:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 548 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 549 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2011.dta") fields("workers vs_workers") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L549:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 549 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L550:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 550 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L550:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 550 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L551:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 551 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L551:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 551 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L552:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 552 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L552:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 552 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L553:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 553 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L553:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 553 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 554 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2011.dta") fields("source_id_raw vs_source_id_raw") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L554:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 554 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L555:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 555 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L555:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 555 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L556:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 556 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L556:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 556 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L557:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 557 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L557:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 557 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L558:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 558 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L558:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 558 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 559 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2011.dta") fields("district_code vs_district_code") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L559:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 559 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L560:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 560 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L560:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 560 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L561:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 561 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic511
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L561:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 561 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L562:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 562 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L562:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 562 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L563:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 563 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L563:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 563 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 564 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2011.dta") fields("industry_code vs_industry_code") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L564:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 564 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L565:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 565 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L565:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 565 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L566:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 566 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L566:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 566 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L567:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 567 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L567:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 567 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L568:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 568 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L568:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 568 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 569 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2011.dta") fields("province_code vs_province_code") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L569:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 569 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L570:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 570 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L570:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 570 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L571:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 571 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L571:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 571 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L572:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 572 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L572:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 572 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L573:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 573 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L573:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 573 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 574 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2011.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L574:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 574 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L575:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 575 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L575:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 575 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L576:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 576 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L576:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 576 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L577:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 577 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L577:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 577 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L578:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 578 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L578:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 578 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 579 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2011.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L579:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 579 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L580:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 580 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L580:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 580 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L581:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 581 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L581:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 581 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L582:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 582 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L582:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 582 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L583:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 583 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L583:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 583 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 584 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2011.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L584:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 584 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L585:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 585 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L585:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 585 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L586:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 586 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L586:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 586 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L587:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 587 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L587:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 587 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L588:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 588 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L588:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 588 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 589 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2011.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L589:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 589 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L590:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 590 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L590:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 590 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L591:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 591 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L591:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 591 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L592:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 592 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L592:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 592 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L593:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 593 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L593:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 593 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 594 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2011.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L594:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 594 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 595 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2011.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L595:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 595 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 596 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2011.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L596:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 596 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 597 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2011.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L597:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 597 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 598 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2011.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 598 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L599:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 599 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L599:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 599 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L600:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 600 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L600:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 600 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L601:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 601 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L601:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 601 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L602:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 602 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L602:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 602 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 603 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2011.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 603 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L604:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 604 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L604:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 604 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L605:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 605 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L605:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 605 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L606:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 606 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L606:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 606 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L607:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 607 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L607:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 607 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 608 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2011.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 608 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L609:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 609 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L609:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 609 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L610:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 610 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L610:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 610 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L611:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 611 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L611:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 611 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L612:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 612 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L612:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 612 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 613 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2011.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 613 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L614:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 614 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L614:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 614 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L615:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 615 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L615:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 615 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L616:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 616 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L616:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 616 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L617:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 617 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L617:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 617 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 618 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2011.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 618 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 619 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2011.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 619 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 620 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2011.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 620 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 621 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2011.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 621 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 622 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2011.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 622 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L623:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 623 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L623:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 623 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L624:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 624 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L624:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 624 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L625:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 625 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L625:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 625 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L626:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 626 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L626:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 626 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 627 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2011.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 627 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L628:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 628 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L628:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 628 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L629:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 629 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L629:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 629 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L630:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 630 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L630:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 630 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L631:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 631 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L631:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 631 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 632 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2011.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 632 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 633 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2011.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L633:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 633 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 634 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2011.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L634:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 634 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 635 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2011.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L635:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 635 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 636 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2011.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L636:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 636 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 637 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2011.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 637 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 638 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2011.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L638:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 638 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L639:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 639 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L639:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 639 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L640:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 640 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoiliu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L640:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 640 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L641:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 641 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L641:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 641 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L642:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 642 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L642:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 642 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 643 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2011.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L643:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 643 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L644:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 644 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L644:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 644 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L645:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 645 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L645:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 645 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L646:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 646 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L646:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 646 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L647:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 647 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L647:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 647 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 648 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2011.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L648:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 648 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L649:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 649 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L649:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 649 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L650:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 650 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L650:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 650 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L651:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 651 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L651:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 651 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L652:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 652 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L652:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 652 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 653 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2011.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 653 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L654:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 654 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L654:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 654 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L655:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 655 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L655:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 655 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L656:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 656 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L656:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 656 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L657:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 657 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L657:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 657 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 658 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2011.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L658:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 658 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L659:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 659 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L659:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 659 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L660:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 660 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L660:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 660 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L661:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 661 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L661:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 661 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L662:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 662 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L662:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 662 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 663 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2011.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L663:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 663 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L664:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 664 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L664:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 664 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L665:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 665 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L665:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 665 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L666:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 666 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L666:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 666 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L667:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 667 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L667:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 667 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 668 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2011.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 668 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 669 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2011.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 669 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 670 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2011.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 670 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L671:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 671 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L671:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 671 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L672:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 672 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L672:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 672 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L673:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 673 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L673:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 673 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L674:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 674 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L674:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 674 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 675 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2011.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 675 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 676 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2011.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L676:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 676 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 677 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2011.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L677:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 677 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L678:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 678 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L678:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 678 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L679:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 679 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L679:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 679 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L680:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 680 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L680:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 680 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L681:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 681 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L681:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 681 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 682 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2011.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L682:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 682 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L683:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 683 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L683:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 683 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L684:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 684 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L684:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 684 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L685:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 685 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L685:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 685 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L686:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 686 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L686:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 686 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 687 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2011.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L687:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 687 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L688:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 688 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L688:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 688 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L689:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 689 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L689:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 689 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L690:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 690 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L690:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 690 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L691:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 691 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L691:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 691 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 692 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2011.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L692:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 692 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L693:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 693 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L693:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 693 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L694:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 694 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L694:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 694 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L695:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 695 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L695:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 695 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L696:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 696 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L696:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 696 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 697 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2011.dta") fields("export_any_binary vs_export_any_binary") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L697:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 697 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L698:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 698 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L698:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 698 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L699:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 699 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L699:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 699 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L700:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 700 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L700:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 700 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L701:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 701 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L701:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 701 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 702 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2011.dta") fields("export_direct_flag vs_export_direct_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 702 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L703:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 703 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L703:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 703 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L704:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 704 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_resech11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L704:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 704 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L705:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 705 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L705:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 705 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L706:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 706 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L706:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 706 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 707 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2011.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 707 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 708 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2011.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L708:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 708 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L709:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 709 724 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L709:step-preserve" "code/annual/merge_mapped_2011.do:L1:file" "statement" 709 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L710:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 710 724 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_innova11
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L710:step-keep" "code/annual/merge_mapped_2011.do:L1:file" "statement" 710 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L711:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 711 724 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2011.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L711:step-cf" "code/annual/merge_mapped_2011.do:L1:file" "statement" 711 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L712:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 712 724 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L712:step-restore" "code/annual/merge_mapped_2011.do:L1:file" "statement" 712 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 713 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2011.dta") fields("innovation_flag vs_innovation_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L713:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 713 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 714 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2011.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L714:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 714 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 715 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2011.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L715:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 715 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L716:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 716 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2011.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L716:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 716 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 717 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2011.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 717 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L718:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 718 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2011.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L718:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 718 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 719 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2011.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L719:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 719 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 720 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2011.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L720:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 720 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L721:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 721 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2011.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L721:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 721 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 722 724 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2011.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2011)
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2011.do:L1:file" "statement" 722 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L723:step-isid" "code/annual/merge_mapped_2011.do:L1:file" "statement" 723 724 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L723:step-isid" "code/annual/merge_mapped_2011.do:L1:file" "statement" 723 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2011.do:L724:step-save" "code/annual/merge_mapped_2011.do:L1:file" "statement" 724 724 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2011.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L724:step-save" "code/annual/merge_mapped_2011.do:L1:file" "statement" 724 724 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
