* Tujuan: Untuk 2021, ubah raw_inov21 menjadi innovation_flag; vs_innovation_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_flag_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_innovation_flag_2021: annual staged raw state -> innovation_flag at source_year/source_row.
* Evidence: 2011 INNOVA layout; 2020 Q218; 2021 Lampung PDF p88 Q218; 2022 Sumbar PDF p68 Q208. Broad innovation indicator; question wording differs from 2011.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_innovation_flag_2021.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Mulai innovation_flag sebagai nilai kosong; vs_innovation_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double innovation_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
generate byte vs_innovation_flag=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Baca raw_inov21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk innovation_flag. // WFDOC-INJECTED
replace innovation_flag=(real(subinstr(strtrim(raw_inov21),",","",.))==1) if inlist(real(subinstr(strtrim(raw_inov21),",","",.)),1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace vs_innovation_flag=6 if !missing(real(subinstr(strtrim(raw_inov21),",","",.))) & !(inlist(real(subinstr(strtrim(raw_inov21),",","",.)),1,2))
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace vs_innovation_flag=cond(innovation_flag<0,2,cond(innovation_flag==0,1,0)) if !missing(innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris innovation_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
quietly count if innovation_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_innovation_flag,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_innovation_flag==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post cell (2021) ("innovation_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, innovation_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row innovation_flag vs_innovation_flag raw_inov21
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_innovation_flag_2021.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_innovation_flag_2021"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/innovation_flag_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
