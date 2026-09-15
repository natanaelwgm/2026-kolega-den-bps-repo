* Tujuan: Untuk 2015, ubah raw_epeliu menjadi fuel_petrol_ltr; vs_fuel_petrol_ltr mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_petrol_ltr_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_petrol_ltr_2015: annual staged raw state -> fuel_petrol_ltr at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 41; epeliu15 | total premium/gasoline used, ltr
log using "$VYL/N_G0_fuel_petrol_ltr_2015.log", text replace name(vycell)
* Mulai fuel_petrol_ltr sebagai nilai kosong; vs_fuel_petrol_ltr mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double fuel_petrol_ltr=.
generate byte vs_fuel_petrol_ltr=3
* Baca raw_epeliu setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_petrol_ltr. // WFDOC-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu),",","",.))*1
replace vs_fuel_petrol_ltr=5 if missing(real(subinstr(strtrim(raw_epeliu),",","",.))) & !inlist(upper(strtrim(raw_epeliu)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_petrol_ltr=cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0)) if !missing(fuel_petrol_ltr)
* Hitung berapa baris fuel_petrol_ltr yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_petrol_ltr)
local obs=r(N)
quietly count if fuel_petrol_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_petrol_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_petrol_ltr==4
local absent=r(N)
post cell (2015) ("fuel_petrol_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_petrol_ltr, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_petrol_ltr vs_fuel_petrol_ltr raw_epeliu
isid source_year source_row
save "$VYD/N_G0_fuel_petrol_ltr_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_petrol_ltr_2015"
log close vycell
