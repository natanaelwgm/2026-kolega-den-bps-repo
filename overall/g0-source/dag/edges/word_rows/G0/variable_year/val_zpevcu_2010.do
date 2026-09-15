* Tujuan: Untuk 2010, kolom sumber val_zpevcu tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zpevcu_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zpevcu_2010: annual staged raw state -> val_zpevcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpevcu_2010.log", text replace name(vycell)
* Mulai val_zpevcu sebagai nilai kosong; vs_val_zpevcu mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_zpevcu=.
generate byte vs_val_zpevcu=4
* Hitung berapa baris val_zpevcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zpevcu)
local obs=r(N)
quietly count if val_zpevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpevcu==4
local absent=r(N)
post cell (2010) ("val_zpevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zpevcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zpevcu vs_val_zpevcu
isid source_year source_row
save "$VYD/N_G0_val_zpevcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpevcu_2010"
log close vycell
