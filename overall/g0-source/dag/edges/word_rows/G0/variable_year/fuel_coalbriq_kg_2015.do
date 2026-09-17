* Tujuan: Untuk 2015, kolom sumber fuel_coalbriq_kg tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_coalbriq_kg_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_coalbriq_kg_2015: annual staged raw state -> fuel_coalbriq_kg at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 57; ecbkgu15 | total coal briq used for elec gen, kg
log using "$VYL/N_G0_fuel_coalbriq_kg_2015.log", text replace name(vycell)
* Mulai fuel_coalbriq_kg sebagai nilai kosong; vs_fuel_coalbriq_kg mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double fuel_coalbriq_kg=.
generate byte vs_fuel_coalbriq_kg=4
* Hitung berapa baris fuel_coalbriq_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_coalbriq_kg)
local obs=r(N)
quietly count if fuel_coalbriq_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coalbriq_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coalbriq_kg==4
local absent=r(N)
post cell (2015) ("fuel_coalbriq_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_coalbriq_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_coalbriq_kg vs_fuel_coalbriq_kg
isid source_year source_row
save "$VYD/N_G0_fuel_coalbriq_kg_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coalbriq_kg_2015"
log close vycell
