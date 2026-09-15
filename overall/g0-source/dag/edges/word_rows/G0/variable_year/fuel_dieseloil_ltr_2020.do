* Tujuan: Untuk 2020, ubah raw_ediliu20 menjadi fuel_dieseloil_ltr; vs_fuel_dieseloil_ltr mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_dieseloil_ltr_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_dieseloil_ltr_2020: annual staged raw state -> fuel_dieseloil_ltr at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_dieseloil_ltr_2020.log", text replace name(vycell)
* Mulai fuel_dieseloil_ltr sebagai nilai kosong; vs_fuel_dieseloil_ltr mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double fuel_dieseloil_ltr=.
generate byte vs_fuel_dieseloil_ltr=3
* Baca raw_ediliu20 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_dieseloil_ltr. // WFDOC-INJECTED
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu20),",","",.))*1
replace vs_fuel_dieseloil_ltr=5 if missing(real(subinstr(strtrim(raw_ediliu20),",","",.))) & !inlist(upper(strtrim(raw_ediliu20)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_dieseloil_ltr=cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0)) if !missing(fuel_dieseloil_ltr)
* Hitung berapa baris fuel_dieseloil_ltr yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_dieseloil_ltr)
local obs=r(N)
quietly count if fuel_dieseloil_ltr==0
local zeros=r(N)
quietly count if inlist(vs_fuel_dieseloil_ltr,5,6,8)
local bad=r(N)
quietly count if vs_fuel_dieseloil_ltr==4
local absent=r(N)
post cell (2020) ("fuel_dieseloil_ltr") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_dieseloil_ltr, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_dieseloil_ltr vs_fuel_dieseloil_ltr raw_ediliu20
isid source_year source_row
save "$VYD/N_G0_fuel_dieseloil_ltr_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_dieseloil_ltr_2020"
log close vycell
