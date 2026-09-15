* Tujuan: Gabungkan hasil pemetaan kolom tahun 2014 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2014.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2014.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L1:step-do" "code/annual/merge_mapped_2014.do:L1:file" "statement" 1 756 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L1:step-do" "code/annual/merge_mapped_2014.do:L1:file" "statement" 1 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L2:step-do" "code/annual/merge_mapped_2014.do:L1:file" "statement" 2 756 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L2:step-do" "code/annual/merge_mapped_2014.do:L1:file" "statement" 2 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L3:step-use" "code/annual/merge_mapped_2014.do:L1:file" "statement" 3 756 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2014.dta", clear
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L3:step-use" "code/annual/merge_mapped_2014.do:L1:file" "statement" 3 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L4:step-assert" "code/annual/merge_mapped_2014.do:L1:file" "statement" 4 756 `=_rc' // WFLOG-INJECTED
assert source_year==2014
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L4:step-assert" "code/annual/merge_mapped_2014.do:L1:file" "statement" 4 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L5:step-isid" "code/annual/merge_mapped_2014.do:L1:file" "statement" 5 756 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L5:step-isid" "code/annual/merge_mapped_2014.do:L1:file" "statement" 5 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 6 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2014.dta") fields("amdal_raw vs_amdal_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L6:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 6 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 7 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2014.dta") fields("b3wste_raw vs_b3wste_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L7:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 7 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L8:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 8 756 `=_rc' // WFLOG-INJECTED
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L8:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 8 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L9:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 9 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L9:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 9 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L10:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 10 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L10:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 10 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L11:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 11 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L11:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 11 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 12 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2014.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L12:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 12 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L13:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 13 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L13:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 13 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L14:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 14 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L14:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 14 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L15:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 15 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L15:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 15 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L16:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 16 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L16:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 16 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 17 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2014.dta") fields("capital_nominal vs_capital_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L17:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 17 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L18:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 18 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L18:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 18 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L19:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 19 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_v1115
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L19:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 19 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L20:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 20 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L20:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 20 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L21:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 21 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L21:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 21 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 22 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2014.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L22:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 22 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L23:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 23 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L23:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 23 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L24:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 24 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L24:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 24 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L25:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 25 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L25:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 25 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L26:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 26 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L26:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 26 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 27 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2014.dta") fields("export_binary_raw vs_export_binary_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L27:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 27 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L28:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 28 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L28:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 28 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L29:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 29 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_prprex14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L29:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 29 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L30:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 30 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L30:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 30 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L31:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 31 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L31:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 31 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 32 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2014.dta") fields("export_share_pct vs_export_share_pct") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L32:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 32 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L33:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 33 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L33:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 33 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L34:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 34 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dasing14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L34:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 34 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L35:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 35 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L35:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 35 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L36:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 36 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L36:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 36 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 37 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2014.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L37:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 37 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L38:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 38 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L38:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 38 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L39:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 39 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L39:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 39 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L40:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 40 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L40:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 40 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L41:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 41 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L41:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 41 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 42 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2014.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L42:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 42 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L43:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 43 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L43:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 43 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L44:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 44 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L44:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 44 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L45:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 45 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L45:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 45 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L46:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 46 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L46:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 46 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 47 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2014.dta") fields("import_value_nominal vs_import_value_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L47:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 47 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 48 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2014.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L48:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 48 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 49 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2014.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L49:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 49 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 50 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2014.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L50:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 50 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 51 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2014.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L51:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 51 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 52 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2014.dta") fields("innovation_raw vs_innovation_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L52:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 52 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 53 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2014.dta") fields("inspli_raw vs_inspli_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L53:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 53 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L54:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 54 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L54:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 54 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L55:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 55 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L55:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 55 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L56:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 56 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L56:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 56 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L57:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 57 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L57:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 57 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 58 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2014.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L58:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 58 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 59 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2014.dta") fields("liwste_raw vs_liwste_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L59:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 59 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 60 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2014.dta") fields("pplihi_raw vs_pplihi_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L60:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 60 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L61:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 61 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L61:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 61 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L62:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 62 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_lprnou14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L62:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 62 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L63:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 63 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L63:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 63 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L64:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 64 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L64:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 64 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 65 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2014.dta") fields("production_workers vs_production_workers") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L65:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 65 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 66 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2014.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L66:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 66 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 67 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2014.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L67:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 67 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 68 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2014.dta") fields("rd_workers vs_rd_workers") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L68:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 68 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 69 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2014.dta") fields("sowste_raw vs_sowste_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L69:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 69 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 70 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2014.dta") fields("spplhi_raw vs_spplhi_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L70:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 70 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L71:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 71 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L71:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 71 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L72:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 72 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbdacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L72:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 72 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L73:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 73 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L73:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 73 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L74:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 74 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L74:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 74 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 75 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2014.dta") fields("val_cbdacu vs_val_cbdacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L75:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 75 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 76 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2014.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L76:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 76 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L77:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 77 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L77:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 77 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L78:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 78 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbsacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L78:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 78 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L79:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 79 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L79:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 79 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L80:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 80 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L80:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 80 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 81 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2014.dta") fields("val_cbsacu vs_val_cbsacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L81:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 81 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L82:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 82 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L82:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 82 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L83:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 83 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cbttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L83:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 83 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L84:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 84 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L84:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 84 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L85:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 85 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L85:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 85 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 86 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2014.dta") fields("val_cbttcu vs_val_cbttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L86:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 86 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L87:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 87 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L87:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 87 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L88:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 88 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cldacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L88:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 88 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L89:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 89 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L89:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 89 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L90:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 90 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L90:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 90 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 91 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2014.dta") fields("val_cldacu vs_val_cldacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L91:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 91 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 92 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2014.dta") fields("val_clfpcu vs_val_clfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L92:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 92 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L93:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 93 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L93:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 93 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L94:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 94 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clsacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L94:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 94 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L95:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 95 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L95:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 95 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L96:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 96 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L96:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 96 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 97 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2014.dta") fields("val_clsacu vs_val_clsacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L97:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 97 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L98:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 98 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L98:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 98 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L99:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 99 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_clttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L99:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 99 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L100:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 100 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L100:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 100 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L101:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 101 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L101:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 101 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 102 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2014.dta") fields("val_clttcu vs_val_clttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L102:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 102 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L103:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 103 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L103:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 103 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L104:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 104 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmdacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L104:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 104 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L105:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 105 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L105:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 105 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L106:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 106 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L106:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 106 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 107 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2014.dta") fields("val_cmdacu vs_val_cmdacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L107:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 107 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 108 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2014.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L108:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 108 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L109:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 109 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L109:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 109 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L110:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 110 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmsacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L110:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 110 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L111:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 111 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L111:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 111 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L112:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 112 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L112:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 112 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 113 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2014.dta") fields("val_cmsacu vs_val_cmsacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L113:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 113 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L114:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 114 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L114:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 114 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L115:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 115 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cmttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L115:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 115 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L116:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 116 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L116:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 116 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L117:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 117 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L117:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 117 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 118 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2014.dta") fields("val_cmttcu vs_val_cmttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L118:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 118 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L119:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 119 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L119:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 119 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L120:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 120 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_codacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L120:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 120 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L121:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 121 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L121:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 121 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L122:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 122 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L122:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 122 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 123 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2014.dta") fields("val_codacu vs_val_codacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L123:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 123 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 124 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2014.dta") fields("val_cofpcu vs_val_cofpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L124:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 124 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L125:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 125 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L125:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 125 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L126:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 126 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cosacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L126:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 126 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L127:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 127 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L127:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 127 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L128:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 128 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L128:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 128 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 129 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2014.dta") fields("val_cosacu vs_val_cosacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L129:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 129 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 130 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2014.dta") fields("val_costrd vs_val_costrd") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L130:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 130 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L131:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 131 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L131:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 131 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L132:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 132 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cottcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L132:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 132 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L133:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 133 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L133:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 133 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L134:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 134 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L134:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 134 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 135 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2014.dta") fields("val_cottcu vs_val_cottcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L135:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 135 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 136 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2014.dta") fields("val_csdacu vs_val_csdacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L136:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 136 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 137 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2014.dta") fields("val_csfpcu vs_val_csfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L137:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 137 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 138 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2014.dta") fields("val_cssacu vs_val_cssacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L138:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 138 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 139 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2014.dta") fields("val_csttcu vs_val_csttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L139:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 139 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L140:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 140 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L140:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 140 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L141:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 141 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctdacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L141:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 141 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L142:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 142 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L142:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 142 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L143:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 143 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L143:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 143 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 144 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2014.dta") fields("val_ctdacu vs_val_ctdacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L144:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 144 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 145 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2014.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L145:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 145 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L146:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 146 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L146:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 146 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L147:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 147 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctsacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L147:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 147 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L148:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 148 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L148:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 148 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L149:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 149 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L149:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 149 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 150 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2014.dta") fields("val_ctsacu vs_val_ctsacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L150:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 150 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 151 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2014.dta") fields("val_cttcu vs_val_cttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L151:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 151 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L152:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 152 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L152:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 152 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L153:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 153 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ctttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L153:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 153 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L154:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 154 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L154:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 154 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L155:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 155 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L155:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 155 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 156 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2014.dta") fields("val_ctttcu vs_val_ctttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L156:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 156 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L157:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 157 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L157:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 157 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L158:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 158 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvdacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L158:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 158 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L159:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 159 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L159:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 159 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L160:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 160 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L160:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 160 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 161 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2014.dta") fields("val_cvdacu vs_val_cvdacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L161:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 161 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 162 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2014.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L162:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 162 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L163:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 163 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L163:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 163 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L164:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 164 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvsacu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L164:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 164 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L165:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 165 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L165:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 165 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L166:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 166 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L166:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 166 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 167 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2014.dta") fields("val_cvsacu vs_val_cvsacu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L167:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 167 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L168:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 168 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L168:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 168 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L169:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 169 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_cvttcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L169:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 169 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L170:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 170 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L170:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 170 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L171:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 171 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L171:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 171 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 172 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2014.dta") fields("val_cvttcu vs_val_cvttcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L172:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 172 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 173 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2014.dta") fields("val_devvcu vs_val_devvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L173:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 173 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 174 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2014.dta") fields("val_ecavce vs_val_ecavce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L174:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 174 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 175 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2014.dta") fields("val_ecavcu vs_val_ecavcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L175:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 175 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L176:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 176 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L176:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 176 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L177:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 177 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L177:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 177 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L178:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 178 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L178:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 178 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L179:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 179 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L179:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 179 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 180 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2014.dta") fields("val_ecbvce vs_val_ecbvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L180:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 180 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L181:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 181 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L181:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 181 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L182:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 182 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L182:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 182 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L183:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 183 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L183:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 183 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L184:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 184 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L184:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 184 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 185 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2014.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L185:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 185 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 186 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2014.dta") fields("val_eckvce vs_val_eckvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L186:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 186 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 187 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2014.dta") fields("val_eckvcu vs_val_eckvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L187:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 187 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L188:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 188 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L188:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 188 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L189:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 189 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L189:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 189 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L190:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 190 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L190:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 190 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L191:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 191 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L191:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 191 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 192 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2014.dta") fields("val_eclvce vs_val_eclvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L192:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 192 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L193:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 193 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L193:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 193 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L194:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 194 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L194:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 194 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L195:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 195 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L195:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 195 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L196:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 196 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L196:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 196 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 197 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2014.dta") fields("val_eclvcu vs_val_eclvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L197:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 197 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 198 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2014.dta") fields("val_edivce vs_val_edivce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L198:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 198 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 199 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2014.dta") fields("val_edivcu vs_val_edivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L199:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 199 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L200:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 200 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2014.dta") fields("val_efovce vs_val_efovce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L200:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 200 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 201 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2014.dta") fields("val_efovcu vs_val_efovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L201:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 201 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L202:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 202 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L202:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 202 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L203:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 203 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L203:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 203 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L204:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 204 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L204:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 204 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L205:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 205 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L205:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 205 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L206:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 206 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2014.dta") fields("val_efuvce vs_val_efuvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L206:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 206 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L207:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 207 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L207:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 207 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L208:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 208 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L208:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 208 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L209:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 209 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L209:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 209 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L210:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 210 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L210:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 210 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 211 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2014.dta") fields("val_efuvcu vs_val_efuvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L211:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 211 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L212:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 212 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L212:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 212 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L213:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 213 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L213:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 213 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L214:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 214 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L214:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 214 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L215:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 215 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L215:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 215 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 216 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2014.dta") fields("val_egavce vs_val_egavce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L216:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 216 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L217:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 217 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L217:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 217 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L218:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 218 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L218:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 218 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L219:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 219 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L219:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 219 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L220:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 220 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L220:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 220 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 221 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2014.dta") fields("val_egavcu vs_val_egavcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L221:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 221 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L222:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 222 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L222:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 222 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L223:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 223 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L223:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 223 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L224:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 224 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L224:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 224 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L225:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 225 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L225:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 225 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 226 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2014.dta") fields("val_egovce vs_val_egovce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L226:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 226 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L227:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 227 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L227:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 227 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L228:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 228 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L228:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 228 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L229:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 229 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L229:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 229 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L230:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 230 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L230:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 230 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 231 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2014.dta") fields("val_egovcu vs_val_egovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L231:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 231 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L232:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 232 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L232:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 232 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L233:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 233 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L233:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 233 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L234:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 234 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L234:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 234 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L235:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 235 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L235:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 235 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 236 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2014.dta") fields("val_elpvce vs_val_elpvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L236:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 236 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L237:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 237 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L237:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 237 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L238:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 238 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L238:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 238 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L239:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 239 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L239:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 239 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L240:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 240 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L240:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 240 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 241 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2014.dta") fields("val_elpvcu vs_val_elpvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L241:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 241 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L242:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 242 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L242:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 242 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L243:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 243 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L243:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 243 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L244:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 244 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L244:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 244 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L245:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 245 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L245:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 245 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 246 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2014.dta") fields("val_eluvce vs_val_eluvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L246:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 246 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L247:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 247 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L247:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 247 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L248:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 248 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L248:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 248 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L249:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 249 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L249:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 249 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L250:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 250 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L250:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 250 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L251:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 251 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2014.dta") fields("val_eluvcu vs_val_eluvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L251:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 251 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L252:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 252 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L252:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 252 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L253:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 253 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L253:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 253 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L254:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 254 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L254:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 254 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L255:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 255 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L255:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 255 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L256:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 256 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2014.dta") fields("val_encvce vs_val_encvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L256:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 256 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L257:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 257 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L257:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 257 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L258:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 258 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L258:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 258 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L259:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 259 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L259:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 259 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L260:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 260 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L260:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 260 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L261:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 261 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2014.dta") fields("val_encvcu vs_val_encvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L261:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 261 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 262 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2014.dta") fields("val_engvce vs_val_engvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L262:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 262 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 263 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2014.dta") fields("val_engvcu vs_val_engvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L263:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 263 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L264:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 264 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L264:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 264 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L265:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 265 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L265:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 265 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L266:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 266 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L266:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 266 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L267:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 267 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L267:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 267 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 268 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2014.dta") fields("val_enpvcu vs_val_enpvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L268:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 268 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L269:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 269 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L269:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 269 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L270:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 270 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L270:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 270 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L271:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 271 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L271:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 271 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L272:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 272 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L272:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 272 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 273 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2014.dta") fields("val_eoivce vs_val_eoivce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L273:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 273 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L274:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 274 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L274:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 274 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L275:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 275 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L275:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 275 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L276:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 276 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L276:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 276 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L277:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 277 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L277:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 277 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 278 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2014.dta") fields("val_eoivcu vs_val_eoivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L278:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 278 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L279:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 279 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L279:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 279 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L280:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 280 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L280:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 280 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L281:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 281 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L281:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 281 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L282:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 282 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L282:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 282 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 283 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2014.dta") fields("val_epevce vs_val_epevce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L283:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 283 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L284:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 284 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L284:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 284 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L285:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 285 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L285:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 285 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L286:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 286 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L286:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 286 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L287:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 287 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L287:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 287 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L288:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 288 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2014.dta") fields("val_epevcu vs_val_epevcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L288:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 288 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L289:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 289 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L289:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 289 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L290:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 290 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L290:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 290 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L291:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 291 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L291:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 291 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L292:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 292 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L292:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 292 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 293 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2014.dta") fields("val_eplvcu vs_val_eplvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L293:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 293 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 294 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2014.dta") fields("val_esdvce vs_val_esdvce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L294:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 294 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 295 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2014.dta") fields("val_esdvcu vs_val_esdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L295:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 295 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L296:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 296 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L296:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 296 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L297:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 297 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovce14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L297:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 297 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L298:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 298 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L298:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 298 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L299:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 299 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L299:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 299 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 300 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2014.dta") fields("val_esovce vs_val_esovce") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L300:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 300 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L301:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 301 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L301:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 301 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L302:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 302 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L302:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 302 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L303:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 303 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L303:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 303 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L304:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 304 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L304:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 304 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 305 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2014.dta") fields("val_esovcu vs_val_esovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L305:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 305 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L306:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 306 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L306:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 306 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L307:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 307 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ibrvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L307:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 307 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L308:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 308 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L308:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 308 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L309:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 309 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L309:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 309 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 310 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2014.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L310:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 310 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L311:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 311 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L311:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 311 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L312:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 312 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_icovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L312:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 312 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L313:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 313 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L313:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 313 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L314:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 314 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L314:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 314 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 315 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2014.dta") fields("val_icovcu vs_val_icovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L315:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 315 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 316 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2014.dta") fields("val_idevcu vs_val_idevcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L316:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 316 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L317:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 317 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L317:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 317 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L318:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 318 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinput14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L318:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 318 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L319:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 319 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L319:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 319 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L320:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 320 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L320:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 320 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 321 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2014.dta") fields("val_iinput vs_val_iinput") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L321:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 321 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L322:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 322 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L322:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 322 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L323:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 323 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iinvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L323:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 323 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L324:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 324 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L324:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 324 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L325:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 325 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L325:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 325 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 326 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2014.dta") fields("val_iinvcu vs_val_iinvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L326:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 326 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 327 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2014.dta") fields("val_iisfov vs_val_iisfov") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L327:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 327 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L328:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 328 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2014.dta") fields("val_iislov vs_val_iislov") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L328:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 328 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L329:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 329 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L329:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 329 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L330:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 330 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iisvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L330:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 330 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L331:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 331 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L331:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 331 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L332:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 332 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L332:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 332 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 333 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2014.dta") fields("val_iisvcu vs_val_iisvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L333:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 333 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 334 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2014.dta") fields("val_ikivcu vs_val_ikivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L334:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 334 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 335 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2014.dta") fields("val_iklvcu vs_val_iklvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L335:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 335 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 336 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2014.dta") fields("val_ikovcu vs_val_ikovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L336:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 336 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L337:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 337 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L337:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 337 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L338:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 338 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ilrvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L338:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 338 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L339:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 339 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L339:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 339 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L340:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 340 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L340:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 340 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 341 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2014.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L341:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 341 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L342:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 342 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2014.dta") fields("val_insvcu vs_val_insvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L342:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 342 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 343 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2014.dta") fields("val_intvcu vs_val_intvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L343:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 343 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L344:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 344 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L344:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 344 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L345:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 345 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_iotvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L345:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 345 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L346:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 346 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L346:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 346 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L347:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 347 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L347:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 347 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 348 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2014.dta") fields("val_iotvcu vs_val_iotvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L348:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 348 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 349 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2014.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L349:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 349 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 350 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2014.dta") fields("val_iprvcu vs_val_iprvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L350:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 350 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 351 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2014.dta") fields("val_irdvcu vs_val_irdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L351:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 351 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 352 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2014.dta") fields("val_irevcu vs_val_irevcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L352:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 352 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L353:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 353 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L353:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 353 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L354:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 354 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_irrvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L354:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 354 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L355:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 355 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L355:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 355 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L356:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 356 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L356:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 356 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L357:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 357 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2014.dta") fields("val_irrvcu vs_val_irrvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L357:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 357 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L358:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 358 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L358:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 358 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L359:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 359 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_itxvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L359:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 359 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L360:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 360 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L360:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 360 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L361:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 361 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L361:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 361 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L362:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 362 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2014.dta") fields("val_itxvcu vs_val_itxvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L362:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 362 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 363 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2014.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L363:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 363 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 364 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2014.dta") fields("val_nopvcu vs_val_nopvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L364:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 364 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 365 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2014.dta") fields("val_othvcu vs_val_othvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L365:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 365 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L366:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 366 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L366:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 366 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L367:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 367 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_output14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L367:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 367 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L368:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 368 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L368:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 368 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L369:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 369 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L369:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 369 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 370 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2014.dta") fields("val_output vs_val_output") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L370:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 370 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L371:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 371 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L371:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 371 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L372:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 372 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rdnvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L372:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 372 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L373:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 373 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L373:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 373 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L374:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 374 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L374:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 374 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L375:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 375 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2014.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L375:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 375 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 376 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2014.dta") fields("val_renvcu vs_val_renvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L376:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 376 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L377:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 377 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L377:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 377 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L378:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 378 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rimvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L378:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 378 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L379:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 379 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L379:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 379 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L380:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 380 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L380:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 380 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 381 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2014.dta") fields("val_rimvcu vs_val_rimvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L381:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 381 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L382:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 382 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L382:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 382 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L383:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 383 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_rtlvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L383:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 383 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L384:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 384 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L384:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 384 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L385:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 385 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L385:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 385 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 386 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2014.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L386:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 386 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 387 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2014.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L387:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 387 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 388 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2014.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L388:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 388 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L389:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 389 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L389:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 389 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L390:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 390 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfdvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L390:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 390 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L391:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 391 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L391:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 391 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L392:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 392 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L392:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 392 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 393 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2014.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L393:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 393 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 394 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2014.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L394:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 394 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L395:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 395 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L395:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 395 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L396:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 396 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfjvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L396:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 396 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L397:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 397 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L397:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 397 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L398:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 398 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L398:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 398 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 399 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2014.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L399:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 399 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 400 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2014.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L400:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 400 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L401:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 401 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L401:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 401 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L402:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 402 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_sfnvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L402:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 402 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L403:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 403 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L403:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 403 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L404:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 404 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L404:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 404 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 405 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2014.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L405:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 405 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 406 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2014.dta") fields("val_sfovcu vs_val_sfovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L406:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 406 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 407 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2014.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L407:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 407 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 408 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2014.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L408:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 408 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 409 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2014.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L409:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 409 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L410:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 410 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L410:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 410 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L411:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 411 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shdvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L411:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 411 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L412:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 412 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L412:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 412 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L413:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 413 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L413:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 413 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 414 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2014.dta") fields("val_shdvcu vs_val_shdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L414:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 414 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L415:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 415 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L415:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 415 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L416:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 416 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shfvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L416:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 416 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L417:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 417 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L417:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 417 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L418:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 418 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L418:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 418 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 419 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2014.dta") fields("val_shfvcu vs_val_shfvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L419:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 419 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L420:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 420 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L420:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 420 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L421:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 421 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_shjvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L421:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 421 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L422:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 422 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L422:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 422 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L423:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 423 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L423:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 423 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 424 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2014.dta") fields("val_shjvcu vs_val_shjvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L424:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 424 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L425:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 425 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L425:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 425 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L426:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 426 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srdvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L426:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 426 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L427:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 427 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L427:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 427 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L428:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 428 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L428:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 428 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 429 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2014.dta") fields("val_srdvcu vs_val_srdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L429:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 429 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L430:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 430 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L430:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 430 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L431:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 431 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srjvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L431:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 431 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L432:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 432 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L432:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 432 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L433:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 433 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L433:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 433 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 434 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2014.dta") fields("val_srjvcu vs_val_srjvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L434:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 434 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L435:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 435 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L435:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 435 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L436:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 436 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_srmvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L436:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 436 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L437:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 437 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L437:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 437 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L438:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 438 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L438:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 438 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 439 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2014.dta") fields("val_srmvcu vs_val_srmvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L439:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 439 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L440:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 440 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L440:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 440 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L441:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 441 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stdvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L441:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 441 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L442:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 442 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L442:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 442 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L443:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 443 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L443:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 443 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 444 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2014.dta") fields("val_stdvcu vs_val_stdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L444:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 444 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L445:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 445 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L445:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 445 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L446:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 446 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stjvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L446:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 446 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L447:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 447 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L447:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 447 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L448:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 448 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L448:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 448 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 449 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2014.dta") fields("val_stjvcu vs_val_stjvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L449:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 449 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L450:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 450 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L450:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 450 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L451:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 451 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_stlvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L451:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 451 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L452:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 452 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L452:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 452 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L453:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 453 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L453:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 453 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 454 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2014.dta") fields("val_stlvcu vs_val_stlvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L454:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 454 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L455:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 455 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L455:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 455 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L456:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 456 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L456:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 456 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L457:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 457 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L457:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 457 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L458:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 458 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L458:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 458 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 459 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2014.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L459:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 459 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L460:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 460 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L460:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 460 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L461:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 461 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yelvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L461:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 461 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L462:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 462 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L462:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 462 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L463:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 463 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L463:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 463 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 464 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2014.dta") fields("val_yelvcu vs_val_yelvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L464:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 464 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L465:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 465 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L465:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 465 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L466:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 466 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L466:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 466 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L467:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 467 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L467:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 467 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L468:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 468 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L468:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 468 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 469 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2014.dta") fields("val_yisvcu vs_val_yisvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L469:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 469 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L470:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 470 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L470:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 470 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L471:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 471 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvdo14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L471:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 471 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L472:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 472 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L472:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 472 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L473:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 473 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L473:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 473 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 474 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2014.dta") fields("val_yisvdo vs_val_yisvdo") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L474:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 474 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L475:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 475 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L475:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 475 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L476:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 476 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yisvfo14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L476:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 476 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L477:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 477 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L477:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 477 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L478:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 478 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L478:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 478 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 479 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2014.dta") fields("val_yisvfo vs_val_yisvfo") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L479:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 479 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L480:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 480 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2014.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L480:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 480 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 481 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2014.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L481:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 481 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 482 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2014.dta") fields("val_ykivcu vs_val_ykivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L482:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 482 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L483:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 483 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L483:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 483 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L484:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 484 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yprvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L484:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 484 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L485:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 485 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L485:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 485 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L486:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 486 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L486:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 486 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 487 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2014.dta") fields("val_yprvcu vs_val_yprvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L487:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 487 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L488:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 488 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L488:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 488 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L489:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 489 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_yrnvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L489:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 489 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L490:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 490 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L490:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 490 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L491:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 491 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L491:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 491 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 492 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2014.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L492:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 492 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 493 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2014.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L493:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 493 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 494 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2014.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L494:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 494 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L495:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 495 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2014.dta") fields("val_ytovcu vs_val_ytovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L495:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 495 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L496:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 496 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L496:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 496 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L497:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 497 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znavcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L497:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 497 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L498:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 498 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L498:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 498 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L499:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 499 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L499:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 499 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L500:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 500 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2014.dta") fields("val_znavcu vs_val_znavcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L500:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 500 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L501:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 501 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L501:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 501 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L502:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 502 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zndvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L502:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 502 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L503:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 503 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L503:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 503 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L504:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 504 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L504:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 504 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 505 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2014.dta") fields("val_zndvcu vs_val_zndvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L505:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 505 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L506:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 506 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2014.dta") fields("val_znevcu vs_val_znevcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L506:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 506 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 507 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2014.dta") fields("val_znhvcu vs_val_znhvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L507:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 507 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L508:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 508 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L508:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 508 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L509:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 509 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znivcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L509:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 509 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L510:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 510 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L510:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 510 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L511:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 511 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L511:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 511 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 512 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2014.dta") fields("val_znivcu vs_val_znivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L512:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 512 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L513:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 513 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L513:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 513 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L514:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 514 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L514:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 514 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L515:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 515 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L515:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 515 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L516:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 516 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L516:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 516 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 517 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2014.dta") fields("val_znovcu vs_val_znovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L517:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 517 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L518:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 518 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L518:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 518 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L519:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 519 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znpvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L519:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 519 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L520:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 520 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L520:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 520 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L521:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 521 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L521:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 521 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 522 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2014.dta") fields("val_znpvcu vs_val_znpvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L522:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 522 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L523:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 523 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2014.dta") fields("val_znrvcu vs_val_znrvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L523:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 523 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L524:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 524 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L524:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 524 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L525:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 525 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_znsvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L525:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 525 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L526:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 526 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L526:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 526 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L527:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 527 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L527:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 527 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L528:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 528 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2014.dta") fields("val_znsvcu vs_val_znsvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L528:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 528 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 529 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2014.dta") fields("val_zntvcu vs_val_zntvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L529:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 529 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L530:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 530 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L530:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 530 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L531:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 531 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpavcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L531:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 531 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L532:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 532 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L532:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 532 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L533:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 533 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L533:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 533 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 534 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2014.dta") fields("val_zpavcu vs_val_zpavcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L534:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 534 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L535:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 535 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L535:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 535 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L536:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 536 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpdvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L536:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 536 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L537:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 537 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L537:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 537 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L538:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 538 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L538:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 538 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 539 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2014.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L539:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 539 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L540:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 540 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2014.dta") fields("val_zpevcu vs_val_zpevcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L540:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 540 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 541 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2014.dta") fields("val_zphvcu vs_val_zphvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L541:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 541 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L542:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 542 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L542:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 542 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L543:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 543 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpivcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L543:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 543 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L544:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 544 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L544:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 544 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L545:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 545 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L545:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 545 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L546:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 546 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2014.dta") fields("val_zpivcu vs_val_zpivcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L546:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 546 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L547:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 547 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L547:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 547 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L548:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 548 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L548:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 548 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L549:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 549 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L549:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 549 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L550:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 550 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L550:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 550 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L551:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 551 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2014.dta") fields("val_zpovcu vs_val_zpovcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L551:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 551 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L552:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 552 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L552:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 552 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L553:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 553 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zppvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L553:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 553 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L554:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 554 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L554:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 554 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L555:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 555 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L555:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 555 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L556:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 556 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2014.dta") fields("val_zppvcu vs_val_zppvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L556:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 556 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 557 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2014.dta") fields("val_zprvcu vs_val_zprvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L557:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 557 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L558:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 558 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L558:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 558 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L559:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 559 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_zpsvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L559:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 559 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L560:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 560 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L560:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 560 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L561:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 561 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L561:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 561 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 562 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2014.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L562:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 562 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L563:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 563 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2014.dta") fields("val_zptvcu vs_val_zptvcu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L563:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 563 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L564:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 564 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L564:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 564 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L565:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 565 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_vtlvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L565:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 565 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L566:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 566 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L566:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 566 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L567:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 567 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L567:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 567 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L568:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 568 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2014.dta") fields("value_added_nominal vs_value_added_nominal") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L568:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 568 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L569:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 569 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L569:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 569 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L570:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 570 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ltlnou14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L570:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 570 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L571:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 571 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L571:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 571 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L572:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 572 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L572:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 572 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 573 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2014.dta") fields("workers vs_workers") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L573:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 573 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L574:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 574 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L574:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 574 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L575:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 575 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_kipb
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L575:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 575 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L576:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 576 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L576:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 576 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L577:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 577 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L577:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 577 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L578:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 578 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2014.dta") fields("source_id_raw vs_source_id_raw") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L578:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 578 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L579:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 579 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L579:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 579 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L580:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 580 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dkabup14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L580:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 580 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L581:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 581 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L581:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 581 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L582:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 582 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L582:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 582 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 583 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2014.dta") fields("district_code vs_district_code") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L583:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 583 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L584:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 584 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L584:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 584 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L585:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 585 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_disic514
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L585:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 585 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L586:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 586 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L586:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 586 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L587:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 587 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L587:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 587 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 588 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2014.dta") fields("industry_code vs_industry_code") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L588:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 588 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L589:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 589 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L589:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 589 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L590:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 590 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_dprovi14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L590:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 590 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L591:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 591 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L591:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 591 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L592:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 592 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L592:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 592 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L593:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 593 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2014.dta") fields("province_code vs_province_code") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L593:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 593 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L594:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 594 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L594:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 594 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L595:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 595 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpkhu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L595:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 595 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L596:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 596 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L596:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 596 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L597:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 597 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L597:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 597 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 598 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2014.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L598:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 598 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L599:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 599 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L599:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 599 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L600:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 600 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_enpvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L600:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 600 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L601:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 601 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L601:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 601 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L602:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 602 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L602:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 602 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 603 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2014.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L603:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 603 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L604:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 604 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L604:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 604 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L605:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 605 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esgkhu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L605:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 605 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L606:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 606 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L606:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 606 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L607:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 607 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L607:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 607 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 608 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2014.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L608:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 608 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L609:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 609 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L609:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 609 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L610:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 610 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplkhu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L610:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 610 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L611:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 611 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L611:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 611 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L612:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 612 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L612:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 612 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 613 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2014.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L613:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 613 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L614:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 614 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L614:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 614 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L615:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 615 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eplvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L615:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 615 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L616:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 616 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L616:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 616 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L617:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 617 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L617:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 617 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 618 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2014.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L618:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 618 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 619 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2014.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L619:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 619 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 620 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2014.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L620:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 620 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 621 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2014.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L621:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 621 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 622 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2014.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L622:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 622 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L623:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 623 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L623:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 623 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L624:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 624 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egam3u14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L624:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 624 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L625:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 625 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L625:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 625 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L626:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 626 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L626:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 626 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 627 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2014.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L627:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 627 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L628:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 628 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L628:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 628 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L629:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 629 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egavcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L629:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 629 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L630:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 630 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L630:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 630 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L631:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 631 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L631:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 631 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 632 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2014.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L632:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 632 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L633:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 633 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L633:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 633 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L634:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 634 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclkgu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L634:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 634 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L635:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 635 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L635:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 635 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L636:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 636 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L636:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 636 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 637 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2014.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L637:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 637 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L638:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 638 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L638:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 638 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L639:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 639 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eclvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L639:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 639 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L640:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 640 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L640:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 640 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L641:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 641 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L641:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 641 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L642:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 642 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2014.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L642:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 642 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L643:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 643 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L643:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 643 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L644:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 644 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbkgu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L644:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 644 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L645:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 645 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L645:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 645 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L646:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 646 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L646:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 646 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L647:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 647 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2014.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L647:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 647 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L648:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 648 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L648:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 648 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L649:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 649 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ecbvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L649:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 649 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L650:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 650 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L650:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 650 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L651:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 651 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L651:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 651 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L652:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 652 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2014.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L652:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 652 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 653 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2014.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L653:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 653 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 654 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2014.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L654:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 654 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L655:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 655 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L655:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 655 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L656:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 656 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esoliu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L656:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 656 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L657:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 657 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L657:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 657 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L658:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 658 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L658:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 658 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 659 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2014.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L659:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 659 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L660:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 660 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L660:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 660 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L661:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 661 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_esovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L661:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 661 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L662:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 662 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L662:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 662 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L663:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 663 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L663:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 663 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L664:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 664 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2014.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L664:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 664 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 665 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2014.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L665:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 665 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 666 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2014.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L666:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 666 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 667 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2014.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L667:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 667 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 668 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2014.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L668:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 668 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 669 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2014.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L669:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 669 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 670 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2014.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L670:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 670 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L671:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 671 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L671:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 671 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L672:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 672 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoiliu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L672:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 672 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L673:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 673 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L673:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 673 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L674:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 674 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L674:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 674 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 675 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2014.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L675:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 675 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L676:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 676 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L676:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 676 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L677:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 677 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eoivcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L677:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 677 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L678:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 678 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L678:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 678 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L679:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 679 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L679:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 679 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L680:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 680 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2014.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L680:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 680 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L681:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 681 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L681:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 681 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L682:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 682 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpkgu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L682:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 682 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L683:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 683 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L683:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 683 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L684:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 684 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L684:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 684 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L685:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 685 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2014.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L685:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 685 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L686:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 686 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L686:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 686 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L687:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 687 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_elpvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L687:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 687 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L688:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 688 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L688:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 688 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L689:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 689 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L689:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 689 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 690 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2014.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L690:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 690 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L691:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 691 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L691:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 691 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L692:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 692 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluliu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L692:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 692 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L693:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 693 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L693:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 693 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L694:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 694 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L694:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 694 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 695 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2014.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L695:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 695 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L696:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 696 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L696:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 696 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L697:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 697 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_eluvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L697:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 697 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L698:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 698 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L698:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 698 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L699:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 699 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L699:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 699 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 700 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2014.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L700:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 700 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L701:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 701 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2014.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L701:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 701 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 702 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2014.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L702:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 702 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L703:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 703 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L703:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 703 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L704:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 704 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_encvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L704:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 704 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L705:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 705 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L705:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 705 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L706:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 706 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L706:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 706 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 707 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2014.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L707:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 707 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L708:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 708 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L708:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 708 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L709:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 709 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egom3u14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L709:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 709 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L710:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 710 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L710:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 710 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L711:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 711 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L711:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 711 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 712 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2014.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L712:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 712 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L713:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 713 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L713:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 713 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L714:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 714 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_egovcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L714:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 714 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L715:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 715 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L715:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 715 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L716:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 716 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L716:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 716 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 717 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2014.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L717:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 717 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L718:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 718 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L718:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 718 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L719:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 719 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epeliu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L719:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 719 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L720:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 720 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L720:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 720 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L721:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 721 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L721:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 721 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 722 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2014.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L722:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 722 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L723:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 723 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L723:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 723 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L724:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 724 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_epevcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L724:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 724 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L725:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 725 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L725:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 725 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L726:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 726 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L726:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 726 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 727 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2014.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L727:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 727 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L728:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 728 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L728:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 728 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L729:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 729 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_efuvcu14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L729:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 729 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L730:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 730 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L730:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 730 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L731:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 731 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L731:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 731 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 732 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2014.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L732:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 732 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L733:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 733 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L733:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 733 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L734:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 734 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L734:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 734 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L735:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 735 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L735:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 735 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L736:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 736 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L736:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 736 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 737 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2014.dta") fields("export_any_binary vs_export_any_binary") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L737:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 737 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L738:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 738 756 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L738:step-preserve" "code/annual/merge_mapped_2014.do:L1:file" "statement" 738 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L739:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 739 756 `=_rc' // WFLOG-INJECTED
keep source_year source_row raw_ekspor14
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L739:step-keep" "code/annual/merge_mapped_2014.do:L1:file" "statement" 739 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L740:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 740 756 `=_rc' // WFLOG-INJECTED
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2014.dta", all
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L740:step-cf" "code/annual/merge_mapped_2014.do:L1:file" "statement" 740 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L741:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 741 756 `=_rc' // WFLOG-INJECTED
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L741:step-restore" "code/annual/merge_mapped_2014.do:L1:file" "statement" 741 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 742 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2014.dta") fields("export_direct_flag vs_export_direct_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L742:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 742 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 743 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2014.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L743:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 743 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 744 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2014.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L744:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 744 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 745 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2014.dta") fields("innovation_flag vs_innovation_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L745:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 745 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 746 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2014.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L746:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 746 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 747 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2014.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L747:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 747 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 748 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2014.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L748:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 748 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L749:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 749 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2014.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L749:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 749 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 750 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2014.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L750:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 750 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 751 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2014.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L751:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 751 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 752 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2014.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L752:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 752 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 753 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2014.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L753:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 753 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L754:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 754 756 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2014.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2014)
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L754:step-wf_merge_guard" "code/annual/merge_mapped_2014.do:L1:file" "statement" 754 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L755:step-isid" "code/annual/merge_mapped_2014.do:L1:file" "statement" 755 756 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L755:step-isid" "code/annual/merge_mapped_2014.do:L1:file" "statement" 755 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_mapped_2014.do:L756:step-save" "code/annual/merge_mapped_2014.do:L1:file" "statement" 756 756 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2014.dta", replace
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L756:step-save" "code/annual/merge_mapped_2014.do:L1:file" "statement" 756 756 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_mapped_2014.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
