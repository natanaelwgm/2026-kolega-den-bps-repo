* Tujuan: Untuk 2022, ubah raw_liwste22, raw_inspli22 menjadi waste_liquid_flag; vs_waste_liquid_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/waste_liquid_flag_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_waste_liquid_flag_2022: annual staged raw state -> waste_liquid_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p68 Q210: 3=yes, 4=no; asked only when Q209d=7. Out-of-universe observations retained in source text, excluded from harmonized flag.
log using "$VYL/N_G0_waste_liquid_flag_2022.log", text replace name(vycell)
* Mulai waste_liquid_flag sebagai nilai kosong; vs_waste_liquid_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double waste_liquid_flag=.
generate byte vs_waste_liquid_flag=3
* Baca raw_liwste22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk waste_liquid_flag. // WFDOC-INJECTED
replace waste_liquid_flag=(real(subinstr(strtrim(raw_liwste22),",","",.))==3) if inlist(real(subinstr(strtrim(raw_liwste22),",","",.)),3,4) & real(raw_inspli22)==7
replace vs_waste_liquid_flag=6 if !missing(real(subinstr(strtrim(raw_liwste22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_liwste22),",","",.)),3,4))
replace vs_waste_liquid_flag=8 if real(raw_inspli22)!=7
replace vs_waste_liquid_flag=cond(waste_liquid_flag<0,2,cond(waste_liquid_flag==0,1,0)) if !missing(waste_liquid_flag)
* Hitung berapa baris waste_liquid_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(waste_liquid_flag)
local obs=r(N)
quietly count if waste_liquid_flag==0
local zeros=r(N)
quietly count if inlist(vs_waste_liquid_flag,5,6,8)
local bad=r(N)
quietly count if vs_waste_liquid_flag==4
local absent=r(N)
post cell (2022) ("waste_liquid_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, waste_liquid_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row waste_liquid_flag vs_waste_liquid_flag raw_liwste22
isid source_year source_row
save "$VYD/N_G0_waste_liquid_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_waste_liquid_flag_2022"
log close vycell
