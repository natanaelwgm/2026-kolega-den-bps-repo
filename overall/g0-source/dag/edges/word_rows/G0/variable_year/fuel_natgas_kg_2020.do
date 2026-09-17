* Tujuan: Untuk 2020, ubah raw_engkgu20 menjadi fuel_natgas_kg; vs_fuel_natgas_kg mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_natgas_kg_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_natgas_kg_2020: annual staged raw state -> fuel_natgas_kg at source_year/source_row.
* Evidence: 2020–22 annual Q302: natural gas MMBTU and biomass tonnes. Use fuel_natgas_mmbtu or fuel_biomass_kg, respectively; source original remains unchanged.
log using "$VYL/N_G0_fuel_natgas_kg_2020.log", text replace name(vycell)
* Mulai fuel_natgas_kg sebagai nilai kosong; vs_fuel_natgas_kg mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double fuel_natgas_kg=.
generate byte vs_fuel_natgas_kg=3
replace vs_fuel_natgas_kg=9
replace vs_fuel_natgas_kg=cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0)) if !missing(fuel_natgas_kg)
* Hitung berapa baris fuel_natgas_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_natgas_kg)
local obs=r(N)
quietly count if fuel_natgas_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_natgas_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_natgas_kg==4
local absent=r(N)
post cell (2020) ("fuel_natgas_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_natgas_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_natgas_kg vs_fuel_natgas_kg raw_engkgu20
isid source_year source_row
save "$VYD/N_G0_fuel_natgas_kg_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_natgas_kg_2020"
log close vycell
