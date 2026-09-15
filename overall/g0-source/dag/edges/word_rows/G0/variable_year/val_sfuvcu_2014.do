* Tujuan: Untuk 2014, kolom sumber val_sfuvcu tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_sfuvcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_sfuvcu_2014: annual staged raw state -> val_sfuvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_sfuvcu_2014.log", text replace name(vycell)
* Mulai val_sfuvcu sebagai nilai kosong; vs_val_sfuvcu mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_sfuvcu=.
generate byte vs_val_sfuvcu=4
* Hitung berapa baris val_sfuvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_sfuvcu)
local obs=r(N)
quietly count if val_sfuvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfuvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfuvcu==4
local absent=r(N)
post cell (2014) ("val_sfuvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_sfuvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_sfuvcu vs_val_sfuvcu
isid source_year source_row
save "$VYD/N_G0_val_sfuvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfuvcu_2014"
log close vycell
