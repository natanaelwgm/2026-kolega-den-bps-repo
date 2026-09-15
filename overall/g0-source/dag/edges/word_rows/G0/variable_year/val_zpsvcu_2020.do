* Tujuan: Untuk 2020, kolom sumber val_zpsvcu tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zpsvcu_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zpsvcu_2020: annual staged raw state -> val_zpsvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpsvcu_2020.log", text replace name(vycell)
* Mulai val_zpsvcu sebagai nilai kosong; vs_val_zpsvcu mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double val_zpsvcu=.
generate byte vs_val_zpsvcu=4
* Hitung berapa baris val_zpsvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zpsvcu)
local obs=r(N)
quietly count if val_zpsvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpsvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpsvcu==4
local absent=r(N)
post cell (2020) ("val_zpsvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zpsvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zpsvcu vs_val_zpsvcu
isid source_year source_row
save "$VYD/N_G0_val_zpsvcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpsvcu_2020"
log close vycell
