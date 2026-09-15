* Tujuan: Untuk 2013, ubah raw_kipb menjadi source_id_raw; vs_source_id_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/source_id_raw_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_source_id_raw_2013: annual staged raw state -> source_id_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_source_id_raw_2013.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
generate str64 source_id_raw=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
generate byte vs_source_id_raw=3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Bentuk source_id_raw dari kolom sumber pada baris ini; aturan vs_source_id_raw di bawah mempertahankan perbedaan status. // WFDOC-INJECTED
replace source_id_raw=strtrim(raw_kipb)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L6:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace source_id_raw="" if inlist(upper(source_id_raw),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L7:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace vs_source_id_raw=0 if source_id_raw!=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L8:step-replace" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris source_id_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(source_id_raw)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L9:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L10:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
quietly count if 0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L11:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L12:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_source_id_raw,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L13:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L14:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_source_id_raw==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L15:step-count" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L16:step-local" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post cell (2013) ("source_id_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L17:step-post" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, source_id_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L18:step-preserve" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row source_id_raw vs_source_id_raw raw_kipb
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L19:step-keep" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L20:step-isid" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_source_id_raw_2013.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L21:step-save" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L22:step-restore" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_source_id_raw_2013"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L23:step-display" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L24:step-log" "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/source_id_raw_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
