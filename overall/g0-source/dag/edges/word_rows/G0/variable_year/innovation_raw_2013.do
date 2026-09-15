* Tujuan: Untuk 2013, kolom sumber innovation_raw tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_raw_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_raw_2013: annual staged raw state -> innovation_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_raw_2013.log", text replace name(vycell)
* Mulai innovation_raw sebagai nilai kosong; vs_innovation_raw mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double innovation_raw=.
generate byte vs_innovation_raw=4
* Hitung berapa baris innovation_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_raw)
local obs=r(N)
quietly count if innovation_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_raw==4
local absent=r(N)
post cell (2013) ("innovation_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_raw vs_innovation_raw
isid source_year source_row
save "$VYD/N_G0_innovation_raw_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_raw_2013"
log close vycell
