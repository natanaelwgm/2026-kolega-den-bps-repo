* Tujuan: Untuk 2010, kolom sumber innovation_flag tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_flag_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_flag_2010: annual staged raw state -> innovation_flag at source_year/source_row.
* Evidence: 2011 INNOVA layout; 2020 Q218; 2021 Lampung PDF p88 Q218; 2022 Sumbar PDF p68 Q208. Broad innovation indicator; question wording differs from 2011.
log using "$VYL/N_G0_innovation_flag_2010.log", text replace name(vycell)
* Mulai innovation_flag sebagai nilai kosong; vs_innovation_flag mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double innovation_flag=.
generate byte vs_innovation_flag=4
* Hitung berapa baris innovation_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_flag)
local obs=r(N)
quietly count if innovation_flag==0
local zeros=r(N)
quietly count if inlist(vs_innovation_flag,5,6,8)
local bad=r(N)
quietly count if vs_innovation_flag==4
local absent=r(N)
post cell (2010) ("innovation_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_flag vs_innovation_flag
isid source_year source_row
save "$VYD/N_G0_innovation_flag_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_flag_2010"
log close vycell
