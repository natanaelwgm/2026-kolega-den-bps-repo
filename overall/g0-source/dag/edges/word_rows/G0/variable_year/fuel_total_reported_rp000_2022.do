* Tujuan: Untuk 2022, ubah raw_efuvcu22 menjadi fuel_total_reported_rp000; vs_fuel_total_reported_rp000 mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_total_reported_rp000_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_total_reported_rp000_2022: annual staged raw state -> fuel_total_reported_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_total_reported_rp000_2022.log", text replace name(vycell)
* Mulai fuel_total_reported_rp000 sebagai nilai kosong; vs_fuel_total_reported_rp000 mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double fuel_total_reported_rp000=.
generate byte vs_fuel_total_reported_rp000=3
* Baca raw_efuvcu22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_total_reported_rp000. // WFDOC-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu22),",","",.))*1
replace vs_fuel_total_reported_rp000=5 if missing(real(subinstr(strtrim(raw_efuvcu22),",","",.))) & !inlist(upper(strtrim(raw_efuvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_total_reported_rp000=cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0)) if !missing(fuel_total_reported_rp000)
* Hitung berapa baris fuel_total_reported_rp000 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_total_reported_rp000)
local obs=r(N)
quietly count if fuel_total_reported_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_total_reported_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_total_reported_rp000==4
local absent=r(N)
post cell (2022) ("fuel_total_reported_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_total_reported_rp000, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_total_reported_rp000 vs_fuel_total_reported_rp000 raw_efuvcu22
isid source_year source_row
save "$VYD/N_G0_fuel_total_reported_rp000_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_total_reported_rp000_2022"
log close vycell
