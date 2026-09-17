* Tujuan: Untuk 2022, ubah raw_inspli22 menjadi env_waste_treatment_flag; vs_env_waste_treatment_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/env_waste_treatment_flag_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_env_waste_treatment_flag_2022: annual staged raw state -> env_waste_treatment_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. inspli: 7=present, 8=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
log using "$VYL/N_G0_env_waste_treatment_flag_2022.log", text replace name(vycell)
* Mulai env_waste_treatment_flag sebagai nilai kosong; vs_env_waste_treatment_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double env_waste_treatment_flag=.
generate byte vs_env_waste_treatment_flag=3
* Baca raw_inspli22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk env_waste_treatment_flag. // WFDOC-INJECTED
replace env_waste_treatment_flag=(real(subinstr(strtrim(raw_inspli22),",","",.))==7) if inlist(real(subinstr(strtrim(raw_inspli22),",","",.)),7,8)
replace vs_env_waste_treatment_flag=6 if !missing(real(subinstr(strtrim(raw_inspli22),",","",.))) & !(inlist(real(subinstr(strtrim(raw_inspli22),",","",.)),7,8))
replace vs_env_waste_treatment_flag=cond(env_waste_treatment_flag<0,2,cond(env_waste_treatment_flag==0,1,0)) if !missing(env_waste_treatment_flag)
* Hitung berapa baris env_waste_treatment_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(env_waste_treatment_flag)
local obs=r(N)
quietly count if env_waste_treatment_flag==0
local zeros=r(N)
quietly count if inlist(vs_env_waste_treatment_flag,5,6,8)
local bad=r(N)
quietly count if vs_env_waste_treatment_flag==4
local absent=r(N)
post cell (2022) ("env_waste_treatment_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, env_waste_treatment_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row env_waste_treatment_flag vs_env_waste_treatment_flag raw_inspli22
isid source_year source_row
save "$VYD/N_G0_env_waste_treatment_flag_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_env_waste_treatment_flag_2022"
log close vycell
