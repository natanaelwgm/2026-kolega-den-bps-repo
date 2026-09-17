* Tujuan: Untuk 2011, ubah raw_elpkgu11 menjadi fuel_lpg_kg; vs_fuel_lpg_kg mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_lpg_kg_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_lpg_kg_2011: annual staged raw state -> fuel_lpg_kg at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 54; elpkgu11 | total lpg used, kg
log using "$VYL/N_G0_fuel_lpg_kg_2011.log", text replace name(vycell)
* Mulai fuel_lpg_kg sebagai nilai kosong; vs_fuel_lpg_kg mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double fuel_lpg_kg=.
generate byte vs_fuel_lpg_kg=3
* Baca raw_elpkgu11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_lpg_kg. // WFDOC-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu11),",","",.))*1
replace vs_fuel_lpg_kg=5 if missing(real(subinstr(strtrim(raw_elpkgu11),",","",.))) & !inlist(upper(strtrim(raw_elpkgu11)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_lpg_kg=cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0)) if !missing(fuel_lpg_kg)
* Hitung berapa baris fuel_lpg_kg yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_lpg_kg)
local obs=r(N)
quietly count if fuel_lpg_kg==0
local zeros=r(N)
quietly count if inlist(vs_fuel_lpg_kg,5,6,8)
local bad=r(N)
quietly count if vs_fuel_lpg_kg==4
local absent=r(N)
post cell (2011) ("fuel_lpg_kg") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_lpg_kg, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_lpg_kg vs_fuel_lpg_kg raw_elpkgu11
isid source_year source_row
save "$VYD/N_G0_fuel_lpg_kg_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_lpg_kg_2011"
log close vycell
