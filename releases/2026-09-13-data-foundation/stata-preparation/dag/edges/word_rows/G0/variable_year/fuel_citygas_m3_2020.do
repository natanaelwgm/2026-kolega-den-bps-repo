* Tujuan: Untuk 2020, kolom sumber fuel_citygas_m3 tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_citygas_m3_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_fuel_citygas_m3_2020: annual staged raw state -> fuel_citygas_m3 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_fuel_citygas_m3_2020.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
* Mulai fuel_citygas_m3 sebagai nilai kosong; vs_fuel_citygas_m3 mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double fuel_citygas_m3=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
generate byte vs_fuel_citygas_m3=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L6:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris fuel_citygas_m3 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_citygas_m3)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L6:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L7:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L7:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
quietly count if fuel_citygas_m3==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_fuel_citygas_m3,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
quietly count if vs_fuel_citygas_m3==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L14:step-post" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
post cell (2020) ("fuel_citygas_m3") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L14:step-post" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L15:step-preserve" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, fuel_citygas_m3, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L15:step-preserve" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L16:step-keep" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
keep source_year source_row fuel_citygas_m3 vs_fuel_citygas_m3
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L16:step-keep" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L17:step-isid" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L17:step-isid" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L18:step-save" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_fuel_citygas_m3_2020.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L18:step-save" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L19:step-restore" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L19:step-restore" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L20:step-display" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_fuel_citygas_m3_2020"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L20:step-display" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L21:step-log" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L21:step-log" "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/fuel_citygas_m3_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
