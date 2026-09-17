* Tujuan: Untuk 2017, ubah raw_eclkgu17 menjadi fuel_coal_kg; vs_fuel_coal_kg mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_coal_kg_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_coal_kg_2017: annual staged raw state -> fuel_coal_kg at source_year/source_row.
* Evidence: 2017 SILASTIK ECLKGU17 explicitly TON; 2021 BPS Lampung appendix PDF p90 Q302e; 2022 BPS Sumbar appendix PDF p69 Q302e. Multiply tonnes by 1000.
log using "$VYL/N_G0_fuel_coal_kg_2017.log", text replace name(vycell)
* Mulai fuel_coal_kg sebagai nilai kosong; vs_fuel_coal_kg mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double fuel_coal_kg=.
generate byte vs_fuel_coal_kg=3
* Baca raw_eclkgu17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_coal_kg. // WFDOC-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu17),",","",.))*1000
replace vs_fuel_coal_kg=5 if missing(real(subinstr(strtrim(raw_eclkgu17),",","",.))) & !inlist(upper(strtrim(raw_eclkgu17)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coal_kg=cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0)) if !missing(fuel_coal_kg)
* Hitung berapa baris fuel_coal_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_coal_kg)
local obs=r(N)
quietly count if fuel_coal_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coal_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coal_kg==4
local absent=r(N)
post cell (2017) ("fuel_coal_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_coal_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_coal_kg vs_fuel_coal_kg raw_eclkgu17
isid source_year source_row
save "$VYD/N_G0_fuel_coal_kg_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coal_kg_2017"
log close vycell
