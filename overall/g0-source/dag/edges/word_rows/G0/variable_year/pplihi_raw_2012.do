* Tujuan: Untuk 2012, kolom sumber pplihi_raw tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/pplihi_raw_2012.do dari data/intermediate/raw_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_pplihi_raw_2012: annual staged raw state -> pplihi_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_pplihi_raw_2012.log", text replace name(vycell)
* Mulai pplihi_raw sebagai nilai kosong; vs_pplihi_raw mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double pplihi_raw=.
generate byte vs_pplihi_raw=4
* Hitung berapa baris pplihi_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(pplihi_raw)
local obs=r(N)
quietly count if pplihi_raw==0
local zeros=r(N)
quietly count if inlist(vs_pplihi_raw,5,6,8)
local bad=r(N)
quietly count if vs_pplihi_raw==4
local absent=r(N)
post cell (2012) ("pplihi_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, pplihi_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row pplihi_raw vs_pplihi_raw
isid source_year source_row
save "$VYD/N_G0_pplihi_raw_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_pplihi_raw_2012"
log close vycell
