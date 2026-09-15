* Tujuan: Untuk 2015, kolom sumber fuel_coke_kg tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_coke_kg_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_coke_kg_2015: annual staged raw state -> fuel_coke_kg at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_coke_kg_2015.log", text replace name(vycell)
* Mulai fuel_coke_kg sebagai nilai kosong; vs_fuel_coke_kg mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double fuel_coke_kg=.
generate byte vs_fuel_coke_kg=4
* Hitung berapa baris fuel_coke_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_coke_kg)
local obs=r(N)
quietly count if fuel_coke_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coke_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coke_kg==4
local absent=r(N)
post cell (2015) ("fuel_coke_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_coke_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_coke_kg vs_fuel_coke_kg
isid source_year source_row
save "$VYD/N_G0_fuel_coke_kg_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coke_kg_2015"
log close vycell
