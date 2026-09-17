* Tujuan: Untuk 2021, ubah raw_ecakgu21 menjadi fuel_biomass_kg; vs_fuel_biomass_kg mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_biomass_kg_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_biomass_kg_2021: annual staged raw state -> fuel_biomass_kg at source_year/source_row.
* Evidence: 2020 questionnaire Q302f/i; 2021 Lampung PDF p90 Q302g/j; 2022 Sumbar PDF p69 Q302h/k. Gas MMBTU; mixed biomass tonnes ×1000. Not pure charcoal.
log using "$VYL/N_G0_fuel_biomass_kg_2021.log", text replace name(vycell)
* Mulai fuel_biomass_kg sebagai nilai kosong; vs_fuel_biomass_kg mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double fuel_biomass_kg=.
generate byte vs_fuel_biomass_kg=3
* Baca raw_ecakgu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_biomass_kg. // WFDOC-INJECTED
replace fuel_biomass_kg=real(subinstr(strtrim(raw_ecakgu21),",","",.))*1000
replace vs_fuel_biomass_kg=5 if missing(real(subinstr(strtrim(raw_ecakgu21),",","",.))) & !inlist(upper(strtrim(raw_ecakgu21)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_biomass_kg=cond(fuel_biomass_kg<0,2,cond(fuel_biomass_kg==0,1,0)) if !missing(fuel_biomass_kg)
* Hitung berapa baris fuel_biomass_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_biomass_kg)
local obs=r(N)
quietly count if fuel_biomass_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_biomass_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_biomass_kg==4
local absent=r(N)
post cell (2021) ("fuel_biomass_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_biomass_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_biomass_kg vs_fuel_biomass_kg raw_ecakgu21
isid source_year source_row
save "$VYD/N_G0_fuel_biomass_kg_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_biomass_kg_2021"
log close vycell
