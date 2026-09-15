* Tujuan: Untuk 2022, ubah raw_b3wste22, raw_inspli22 menjadi waste_hazardous_flag; vs_waste_hazardous_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/waste_hazardous_flag_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_waste_hazardous_flag_2022: annual staged raw state -> waste_hazardous_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 5=yes, 6=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 1 23 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_waste_hazardous_flag_2022.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 1 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 2 23 `=_rc' // WFLOG-INJECTED
* Mulai waste_hazardous_flag sebagai nilai kosong; vs_waste_hazardous_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double waste_hazardous_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 2 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 3 23 `=_rc' // WFLOG-INJECTED
generate byte vs_waste_hazardous_flag=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 3 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 4 23 `=_rc' // WFLOG-INJECTED
* Baca raw_b3wste22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk waste_hazardous_flag. // WFDOC-INJECTED
replace waste_hazardous_flag=(real(subinstr(strtrim(raw_b3wste22),",","",.))==5) if inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6) & real(raw_inspli22)==7
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 4 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 5 23 `=_rc' // WFLOG-INJECTED
replace vs_waste_hazardous_flag=6 if !missing(real(subinstr(strtrim(raw_b3wste22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6))
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 5 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 6 23 `=_rc' // WFLOG-INJECTED
replace vs_waste_hazardous_flag=8 if real(raw_inspli22)!=7
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 6 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L9:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 7 23 `=_rc' // WFLOG-INJECTED
replace vs_waste_hazardous_flag=cond(waste_hazardous_flag<0,2,cond(waste_hazardous_flag==0,1,0)) if !missing(waste_hazardous_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L9:step-replace" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 7 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 8 23 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris waste_hazardous_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(waste_hazardous_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 8 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 9 23 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 9 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 10 23 `=_rc' // WFLOG-INJECTED
quietly count if waste_hazardous_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 10 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 11 23 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 11 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L14:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 12 23 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_waste_hazardous_flag,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L14:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 12 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L15:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 13 23 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L15:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 13 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L16:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 14 23 `=_rc' // WFLOG-INJECTED
quietly count if vs_waste_hazardous_flag==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L16:step-count" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 14 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L17:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 15 23 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L17:step-local" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 15 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L18:step-post" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 16 23 `=_rc' // WFLOG-INJECTED
post cell (2022) ("waste_hazardous_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L18:step-post" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 16 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L19:step-preserve" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 17 23 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, waste_hazardous_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L19:step-preserve" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 17 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L20:step-keep" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 18 23 `=_rc' // WFLOG-INJECTED
keep source_year source_row waste_hazardous_flag vs_waste_hazardous_flag raw_b3wste22
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L20:step-keep" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 18 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L21:step-isid" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 19 23 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L21:step-isid" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 19 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L22:step-save" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 20 23 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_waste_hazardous_flag_2022.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L22:step-save" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 20 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L23:step-restore" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 21 23 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L23:step-restore" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 21 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L24:step-display" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 22 23 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_waste_hazardous_flag_2022"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L24:step-display" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 22 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L25:step-log" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 23 23 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L25:step-log" "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "statement" 23 23 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
