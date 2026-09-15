* Tujuan: Untuk 2021, kolom sumber b3wste_raw tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/b3wste_raw_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_b3wste_raw_2021: annual staged raw state -> b3wste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_b3wste_raw_2021.log", text replace name(vycell)
* Mulai b3wste_raw sebagai nilai kosong; vs_b3wste_raw mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double b3wste_raw=.
generate byte vs_b3wste_raw=4
* Hitung berapa baris b3wste_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(b3wste_raw)
local obs=r(N)
quietly count if b3wste_raw==0
local zeros=r(N)
quietly count if inlist(vs_b3wste_raw,5,6,8)
local bad=r(N)
quietly count if vs_b3wste_raw==4
local absent=r(N)
post cell (2021) ("b3wste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, b3wste_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row b3wste_raw vs_b3wste_raw
isid source_year source_row
save "$VYD/N_G0_b3wste_raw_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_b3wste_raw_2021"
log close vycell
