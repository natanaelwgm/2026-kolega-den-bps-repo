* Tujuan: Untuk 2010, ubah raw_eoivcu10 menjadi fuel_kerosene_rp000; vs_fuel_kerosene_rp000 mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_kerosene_rp000_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_kerosene_rp000_2010: annual staged raw state -> fuel_kerosene_rp000 at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 43; eoivcu10 | total kerosene used, 000 rp
log using "$VYL/N_G0_fuel_kerosene_rp000_2010.log", text replace name(vycell)
* Mulai fuel_kerosene_rp000 sebagai nilai kosong; vs_fuel_kerosene_rp000 mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double fuel_kerosene_rp000=.
generate byte vs_fuel_kerosene_rp000=3
* Baca raw_eoivcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_kerosene_rp000. // WFDOC-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu10),",","",.))*1
replace vs_fuel_kerosene_rp000=5 if missing(real(subinstr(strtrim(raw_eoivcu10),",","",.))) & !inlist(upper(strtrim(raw_eoivcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_kerosene_rp000=cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0)) if !missing(fuel_kerosene_rp000)
* Hitung berapa baris fuel_kerosene_rp000 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_kerosene_rp000)
local obs=r(N)
quietly count if fuel_kerosene_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_kerosene_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_kerosene_rp000==4
local absent=r(N)
post cell (2010) ("fuel_kerosene_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_kerosene_rp000, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_kerosene_rp000 vs_fuel_kerosene_rp000 raw_eoivcu10
isid source_year source_row
save "$VYD/N_G0_fuel_kerosene_rp000_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_kerosene_rp000_2010"
log close vycell
