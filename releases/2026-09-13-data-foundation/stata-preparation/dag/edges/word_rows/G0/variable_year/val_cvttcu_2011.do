* Tujuan: Untuk 2011, ubah raw_cvttcu11 menjadi val_cvttcu; vs_val_cvttcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cvttcu_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_val_cvttcu_2011: annual staged raw state -> val_cvttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 117; cvttcu11 | vehicles purchases & constr, 000rp
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_val_cvttcu_2011.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Mulai val_cvttcu sebagai nilai kosong; vs_val_cvttcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double val_cvttcu=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
generate byte vs_val_cvttcu=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Baca raw_cvttcu11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cvttcu. // WFDOC-INJECTED
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu11),",","",.))*1
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace vs_val_cvttcu=5 if missing(real(subinstr(strtrim(raw_cvttcu11),",","",.))) & !inlist(upper(strtrim(raw_cvttcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace vs_val_cvttcu=cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0)) if !missing(val_cvttcu)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris val_cvttcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cvttcu)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
quietly count if val_cvttcu==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_val_cvttcu,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_val_cvttcu==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post cell (2011) ("val_cvttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, val_cvttcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row val_cvttcu vs_val_cvttcu raw_cvttcu11
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_val_cvttcu_2011.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_val_cvttcu_2011"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/val_cvttcu_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
