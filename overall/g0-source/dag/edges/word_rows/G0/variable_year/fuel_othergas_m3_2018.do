* Tujuan: Untuk 2018, ubah raw_egom3u18 menjadi fuel_othergas_m3; vs_fuel_othergas_m3 mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_othergas_m3_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_othergas_m3_2018: annual staged raw state -> fuel_othergas_m3 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_othergas_m3_2018.log", text replace name(vycell)
* Mulai fuel_othergas_m3 sebagai nilai kosong; vs_fuel_othergas_m3 mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double fuel_othergas_m3=.
generate byte vs_fuel_othergas_m3=3
* Baca raw_egom3u18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_othergas_m3. // WFDOC-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u18),",","",.))*1
replace vs_fuel_othergas_m3=5 if missing(real(subinstr(strtrim(raw_egom3u18),",","",.))) & !inlist(upper(strtrim(raw_egom3u18)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_othergas_m3=cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0)) if !missing(fuel_othergas_m3)
* Hitung berapa baris fuel_othergas_m3 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_othergas_m3)
local obs=r(N)
quietly count if fuel_othergas_m3==0
local zeros=r(N)
quietly count if inlist(vs_fuel_othergas_m3,5,6,8)
local bad=r(N)
quietly count if vs_fuel_othergas_m3==4
local absent=r(N)
post cell (2018) ("fuel_othergas_m3") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_othergas_m3, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_othergas_m3 vs_fuel_othergas_m3 raw_egom3u18
isid source_year source_row
save "$VYD/N_G0_fuel_othergas_m3_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_othergas_m3_2018"
log close vycell
