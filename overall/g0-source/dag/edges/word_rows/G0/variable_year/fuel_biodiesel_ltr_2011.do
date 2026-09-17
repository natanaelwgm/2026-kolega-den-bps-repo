* Tujuan: Untuk 2011, kolom sumber fuel_biodiesel_ltr tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_biodiesel_ltr_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_biodiesel_ltr_2011: annual staged raw state -> fuel_biodiesel_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_biodiesel_ltr_2011.log", text replace name(vycell)
* Mulai fuel_biodiesel_ltr sebagai nilai kosong; vs_fuel_biodiesel_ltr mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double fuel_biodiesel_ltr=.
generate byte vs_fuel_biodiesel_ltr=4
* Hitung berapa baris fuel_biodiesel_ltr yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_biodiesel_ltr)
local obs=r(N)
quietly count if fuel_biodiesel_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biodiesel_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biodiesel_ltr==4
local absent=r(N)
post cell (2011) ("fuel_biodiesel_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_biodiesel_ltr, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_biodiesel_ltr vs_fuel_biodiesel_ltr
isid source_year source_row
save "$VYD/N_G0_fuel_biodiesel_ltr_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biodiesel_ltr_2011"
log close vycell
