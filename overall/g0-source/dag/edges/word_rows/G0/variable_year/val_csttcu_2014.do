* Tujuan: Untuk 2014, kolom sumber val_csttcu tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_csttcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_csttcu_2014: annual staged raw state -> val_csttcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_csttcu_2014.log", text replace name(vycell)
* Mulai val_csttcu sebagai nilai kosong; vs_val_csttcu mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_csttcu=.
generate byte vs_val_csttcu=4
* Hitung berapa baris val_csttcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_csttcu)
local obs=r(N)
quietly count if val_csttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_csttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_csttcu==4
local absent=r(N)
post cell (2014) ("val_csttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_csttcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_csttcu vs_val_csttcu
isid source_year source_row
save "$VYD/N_G0_val_csttcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_csttcu_2014"
log close vycell
