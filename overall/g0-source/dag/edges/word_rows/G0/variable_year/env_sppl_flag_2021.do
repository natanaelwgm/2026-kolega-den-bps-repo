* Tujuan: Untuk 2021, ubah raw_spplhi21 menjadi env_sppl_flag; vs_env_sppl_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/env_sppl_flag_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_env_sppl_flag_2021: annual staged raw state -> env_sppl_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. spplhi: 5=present, 6=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
log using "$VYL/N_G0_env_sppl_flag_2021.log", text replace name(vycell)
* Mulai env_sppl_flag sebagai nilai kosong; vs_env_sppl_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double env_sppl_flag=.
generate byte vs_env_sppl_flag=3
* Baca raw_spplhi21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk env_sppl_flag. // WFDOC-INJECTED
replace env_sppl_flag=(real(subinstr(strtrim(raw_spplhi21),",","",.))==5) if inlist(real(subinstr(strtrim(raw_spplhi21),",","",.)),5,6)
replace vs_env_sppl_flag=6 if !missing(real(subinstr(strtrim(raw_spplhi21),",","",.))) & !(inlist(real(subinstr(strtrim(raw_spplhi21),",","",.)),5,6))
replace vs_env_sppl_flag=cond(env_sppl_flag<0,2,cond(env_sppl_flag==0,1,0)) if !missing(env_sppl_flag)
* Hitung berapa baris env_sppl_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(env_sppl_flag)
local obs=r(N)
quietly count if env_sppl_flag==0
local zeros=r(N)
quietly count if inlist(vs_env_sppl_flag,5,6,8)
local bad=r(N)
quietly count if vs_env_sppl_flag==4
local absent=r(N)
post cell (2021) ("env_sppl_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, env_sppl_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row env_sppl_flag vs_env_sppl_flag raw_spplhi21
isid source_year source_row
save "$VYD/N_G0_env_sppl_flag_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_env_sppl_flag_2021"
log close vycell
