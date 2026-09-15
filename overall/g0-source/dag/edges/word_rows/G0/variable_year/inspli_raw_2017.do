* Tujuan: Untuk 2017, kolom sumber inspli_raw tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/inspli_raw_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_inspli_raw_2017: annual staged raw state -> inspli_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_inspli_raw_2017.log", text replace name(vycell)
* Mulai inspli_raw sebagai nilai kosong; vs_inspli_raw mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double inspli_raw=.
generate byte vs_inspli_raw=4
* Hitung berapa baris inspli_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(inspli_raw)
local obs=r(N)
quietly count if inspli_raw==0
local zeros=r(N)
quietly count if inlist(vs_inspli_raw,5,6,8)
local bad=r(N)
quietly count if vs_inspli_raw==4
local absent=r(N)
post cell (2017) ("inspli_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, inspli_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row inspli_raw vs_inspli_raw
isid source_year source_row
save "$VYD/N_G0_inspli_raw_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_inspli_raw_2017"
log close vycell
