* Tujuan: Untuk 2011, ubah raw_innova11 menjadi innovation_flag; vs_innovation_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_flag_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_flag_2011: annual staged raw state -> innovation_flag at source_year/source_row.
* Evidence: 2011 INNOVA layout; 2020 Q218; 2021 Lampung PDF p88 Q218; 2022 Sumbar PDF p68 Q208. Broad innovation indicator; question wording differs from 2011.
log using "$VYL/N_G0_innovation_flag_2011.log", text replace name(vycell)
* Mulai innovation_flag sebagai nilai kosong; vs_innovation_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double innovation_flag=.
generate byte vs_innovation_flag=3
* Baca raw_innova11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk innovation_flag. // WFDOC-INJECTED
replace innovation_flag=(real(subinstr(strtrim(raw_innova11),",","",.))==1) if inlist(real(subinstr(strtrim(raw_innova11),",","",.)),1,2)
replace vs_innovation_flag=6 if !missing(real(subinstr(strtrim(raw_innova11),",","",.))) & !(inlist(real(subinstr(strtrim(raw_innova11),",","",.)),1,2))
replace vs_innovation_flag=cond(innovation_flag<0,2,cond(innovation_flag==0,1,0)) if !missing(innovation_flag)
* Hitung berapa baris innovation_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_flag)
local obs=r(N)
quietly count if innovation_flag==0
local zeros=r(N)
quietly count if inlist(vs_innovation_flag,5,6,8)
local bad=r(N)
quietly count if vs_innovation_flag==4
local absent=r(N)
post cell (2011) ("innovation_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_flag vs_innovation_flag raw_innova11
isid source_year source_row
save "$VYD/N_G0_innovation_flag_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_flag_2011"
log close vycell
