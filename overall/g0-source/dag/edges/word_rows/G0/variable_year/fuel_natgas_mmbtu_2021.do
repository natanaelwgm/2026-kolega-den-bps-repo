* Tujuan: Untuk 2021, ubah raw_engkgu21 menjadi fuel_natgas_mmbtu; vs_fuel_natgas_mmbtu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_natgas_mmbtu_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_natgas_mmbtu_2021: annual staged raw state -> fuel_natgas_mmbtu at source_year/source_row.
* Evidence: 2020 questionnaire Q302f/i; 2021 Lampung PDF p90 Q302g/j; 2022 Sumbar PDF p69 Q302h/k. Gas MMBTU; mixed biomass tonnes ×1000. Not pure charcoal.
log using "$VYL/N_G0_fuel_natgas_mmbtu_2021.log", text replace name(vycell)
* Mulai fuel_natgas_mmbtu sebagai nilai kosong; vs_fuel_natgas_mmbtu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double fuel_natgas_mmbtu=.
generate byte vs_fuel_natgas_mmbtu=3
* Baca raw_engkgu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk fuel_natgas_mmbtu. // WFDOC-INJECTED
replace fuel_natgas_mmbtu=real(subinstr(strtrim(raw_engkgu21),",","",.))*1
replace vs_fuel_natgas_mmbtu=5 if missing(real(subinstr(strtrim(raw_engkgu21),",","",.))) & !inlist(upper(strtrim(raw_engkgu21)),"","***",".","NA","N/A","NULL","-")
replace vs_fuel_natgas_mmbtu=cond(fuel_natgas_mmbtu<0,2,cond(fuel_natgas_mmbtu==0,1,0)) if !missing(fuel_natgas_mmbtu)
* Hitung berapa baris fuel_natgas_mmbtu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_natgas_mmbtu)
local obs=r(N)
quietly count if fuel_natgas_mmbtu==0
local zeros=r(N)
quietly count if inlist(vs_fuel_natgas_mmbtu,5,6,8)
local bad=r(N)
quietly count if vs_fuel_natgas_mmbtu==4
local absent=r(N)
post cell (2021) ("fuel_natgas_mmbtu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_natgas_mmbtu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_natgas_mmbtu vs_fuel_natgas_mmbtu raw_engkgu21
isid source_year source_row
save "$VYD/N_G0_fuel_natgas_mmbtu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_natgas_mmbtu_2021"
log close vycell
