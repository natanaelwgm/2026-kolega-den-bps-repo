* Tujuan: Untuk 2022, ubah raw_ecbkgu22 menjadi fuel_coalbriq_kg; vs_fuel_coalbriq_kg mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_coalbriq_kg_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_coalbriq_kg_2022: annual staged raw state -> fuel_coalbriq_kg at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_coalbriq_kg_2022.log", text replace name(vycell)
* Mulai fuel_coalbriq_kg sebagai nilai kosong; vs_fuel_coalbriq_kg mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double fuel_coalbriq_kg=.
generate byte vs_fuel_coalbriq_kg=3
* Baca raw_ecbkgu22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_coalbriq_kg. // WFDOC-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu22),",","",.))*1
replace vs_fuel_coalbriq_kg=5 if missing(real(subinstr(strtrim(raw_ecbkgu22),",","",.))) & !inlist(upper(strtrim(raw_ecbkgu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_coalbriq_kg=cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0)) if !missing(fuel_coalbriq_kg)
* Hitung berapa baris fuel_coalbriq_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_coalbriq_kg)
local obs=r(N)
quietly count if fuel_coalbriq_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_coalbriq_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_coalbriq_kg==4
local absent=r(N)
post cell (2022) ("fuel_coalbriq_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_coalbriq_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_coalbriq_kg vs_fuel_coalbriq_kg raw_ecbkgu22
isid source_year source_row
save "$VYD/N_G0_fuel_coalbriq_kg_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_coalbriq_kg_2022"
log close vycell
