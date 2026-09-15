* Tujuan: Untuk 2012, ubah raw_ekspor12 menjadi export_any_binary; vs_export_any_binary mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_any_binary_2012.do dari data/intermediate/raw_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_export_any_binary_2012: annual staged raw state -> export_any_binary at source_year/source_row.
* Evidence: 2010–15 legacy layout EKSPOR 1 yes 2 no; 2020 BPS questionnaire reproduction Q402a; 2021 Lampung PDF p92 Q402a. Own or third-party export. 2022 direct-export question belongs to separate field.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_export_any_binary_2012.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Mulai export_any_binary sebagai nilai kosong; vs_export_any_binary mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double export_any_binary=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
generate byte vs_export_any_binary=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Baca raw_ekspor12 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk export_any_binary. // WFDOC-INJECTED
replace export_any_binary=(real(subinstr(strtrim(raw_ekspor12),",","",.))==1) if inlist(real(subinstr(strtrim(raw_ekspor12),",","",.)),1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace vs_export_any_binary=6 if !missing(real(subinstr(strtrim(raw_ekspor12),",","",.))) & !(inlist(real(subinstr(strtrim(raw_ekspor12),",","",.)),1,2))
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace vs_export_any_binary=cond(export_any_binary<0,2,cond(export_any_binary==0,1,0)) if !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris export_any_binary yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
quietly count if export_any_binary==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_export_any_binary,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_export_any_binary==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post cell (2012) ("export_any_binary") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, export_any_binary, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row export_any_binary vs_export_any_binary raw_ekspor12
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_export_any_binary_2012.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_export_any_binary_2012"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/export_any_binary_2012.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
