* Tujuan: Untuk 2017, ubah raw_ekspor17 menjadi export_direct_flag; vs_export_direct_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_direct_flag_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_export_direct_flag_2017: annual staged raw state -> export_direct_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p72 Q402a: direct export, 1 yes 2 no. Direct no does not imply no indirect exports.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_export_direct_flag_2017.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
* Mulai export_direct_flag sebagai nilai kosong; vs_export_direct_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double export_direct_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
generate byte vs_export_direct_flag=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
replace vs_export_direct_flag=7
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
replace vs_export_direct_flag=cond(export_direct_flag<0,2,cond(export_direct_flag==0,1,0)) if !missing(export_direct_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris export_direct_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_direct_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
quietly count if export_direct_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_export_direct_flag,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L14:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
quietly count if vs_export_direct_flag==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L14:step-count" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L15:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L15:step-local" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L16:step-post" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
post cell (2017) ("export_direct_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L16:step-post" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L17:step-preserve" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, export_direct_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L17:step-preserve" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L18:step-keep" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
keep source_year source_row export_direct_flag vs_export_direct_flag raw_ekspor17
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L18:step-keep" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L19:step-isid" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L19:step-isid" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L20:step-save" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_export_direct_flag_2017.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L20:step-save" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L21:step-restore" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L21:step-restore" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L22:step-display" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_export_direct_flag_2017"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L22:step-display" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L23:step-log" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L23:step-log" "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_direct_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
