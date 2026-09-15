* Tujuan: Untuk 2020, kolom sumber innovation_process_raw tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_process_raw_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_process_raw_2020: annual staged raw state -> innovation_process_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_process_raw_2020.log", text replace name(vycell)
* Mulai innovation_process_raw sebagai nilai kosong; vs_innovation_process_raw mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double innovation_process_raw=.
generate byte vs_innovation_process_raw=4
* Hitung berapa baris innovation_process_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_process_raw)
local obs=r(N)
quietly count if innovation_process_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_process_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_process_raw==4
local absent=r(N)
post cell (2020) ("innovation_process_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_process_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_process_raw vs_innovation_process_raw
isid source_year source_row
save "$VYD/N_G0_innovation_process_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_process_raw_2020"
log close vycell
