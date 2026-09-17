* Tujuan: Untuk 2022, kolom sumber val_iisvcu tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_iisvcu_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_iisvcu_2022: annual staged raw state -> val_iisvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_iisvcu_2022.log", text replace name(vycell)
* Mulai val_iisvcu sebagai nilai kosong; vs_val_iisvcu mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double val_iisvcu=.
generate byte vs_val_iisvcu=4
* Hitung berapa baris val_iisvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_iisvcu)
local obs=r(N)
quietly count if val_iisvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_iisvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_iisvcu==4
local absent=r(N)
post cell (2022) ("val_iisvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_iisvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_iisvcu vs_val_iisvcu
isid source_year source_row
save "$VYD/N_G0_val_iisvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iisvcu_2022"
log close vycell
