* Tujuan: Untuk 2022, ubah raw_b3wste22, raw_inspli22 menjadi waste_hazardous_flag; vs_waste_hazardous_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/waste_hazardous_flag_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_waste_hazardous_flag_2022: annual staged raw state -> waste_hazardous_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 5=yes, 6=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
log using "$VYL/N_G0_waste_hazardous_flag_2022.log", text replace name(vycell)
* Mulai waste_hazardous_flag sebagai nilai kosong; vs_waste_hazardous_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double waste_hazardous_flag=.
generate byte vs_waste_hazardous_flag=3
* Baca raw_b3wste22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk waste_hazardous_flag. // WFDOC-INJECTED
replace waste_hazardous_flag=(real(subinstr(strtrim(raw_b3wste22),",","",.))==5) if inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6) & real(raw_inspli22)==7
replace vs_waste_hazardous_flag=6 if !missing(real(subinstr(strtrim(raw_b3wste22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_b3wste22),",","",.)),5,6))
replace vs_waste_hazardous_flag=8 if real(raw_inspli22)!=7
replace vs_waste_hazardous_flag=cond(waste_hazardous_flag<0,2,cond(waste_hazardous_flag==0,1,0)) if !missing(waste_hazardous_flag)
* Hitung berapa baris waste_hazardous_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(waste_hazardous_flag)
local obs=r(N)
quietly count if waste_hazardous_flag==0
local zeros=r(N)
quietly count if inlist(vs_waste_hazardous_flag,5,6,8)
local bad=r(N)
quietly count if vs_waste_hazardous_flag==4
local absent=r(N)
post cell (2022) ("waste_hazardous_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, waste_hazardous_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row waste_hazardous_flag vs_waste_hazardous_flag raw_b3wste22
isid source_year source_row
save "$VYD/N_G0_waste_hazardous_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_waste_hazardous_flag_2022"
log close vycell
