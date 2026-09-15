* Tujuan: Untuk 2018, ubah raw_dasing18 menjadi foreign_ownership_pct; vs_foreign_ownership_pct mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/foreign_ownership_pct_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_foreign_ownership_pct_2018: annual staged raw state -> foreign_ownership_pct at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_foreign_ownership_pct_2018.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Mulai foreign_ownership_pct sebagai nilai kosong; vs_foreign_ownership_pct mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double foreign_ownership_pct=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
generate byte vs_foreign_ownership_pct=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Baca raw_dasing18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk foreign_ownership_pct. // WFDOC-INJECTED
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing18),",","",.))*1
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace vs_foreign_ownership_pct=5 if missing(real(subinstr(strtrim(raw_dasing18),",","",.))) & !inlist(upper(strtrim(raw_dasing18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace vs_foreign_ownership_pct=cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0)) if !missing(foreign_ownership_pct)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris foreign_ownership_pct yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(foreign_ownership_pct)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
quietly count if foreign_ownership_pct==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_foreign_ownership_pct,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_foreign_ownership_pct==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post cell (2018) ("foreign_ownership_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, foreign_ownership_pct, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row foreign_ownership_pct vs_foreign_ownership_pct raw_dasing18
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_foreign_ownership_pct_2018.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_foreign_ownership_pct_2018"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/foreign_ownership_pct_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
