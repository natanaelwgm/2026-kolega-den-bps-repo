* Tujuan: Untuk 2018, ubah raw_costrd18 menjadi rd_external_funding_flag; vs_rd_external_funding_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/rd_external_funding_flag_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_rd_external_funding_flag_2018: annual staged raw state -> rd_external_funding_flag at source_year/source_row.
* Evidence: 2019 BPS Modul IBS pp47,67; 2020 Q217; 2021 Lampung PDF p88 Q217; 2022 Sumbar PDF p68 Q207. Funding R&D carried out by another party, 1 yes 2 no.
log using "$VYL/N_G0_rd_external_funding_flag_2018.log", text replace name(vycell)
* Mulai rd_external_funding_flag sebagai nilai kosong; vs_rd_external_funding_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double rd_external_funding_flag=.
generate byte vs_rd_external_funding_flag=3
replace vs_rd_external_funding_flag=7
replace vs_rd_external_funding_flag=cond(rd_external_funding_flag<0,2,cond(rd_external_funding_flag==0,1,0)) if !missing(rd_external_funding_flag)
* Hitung berapa baris rd_external_funding_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_external_funding_flag)
local obs=r(N)
quietly count if rd_external_funding_flag==0
local zeros=r(N)
quietly count if inlist(vs_rd_external_funding_flag,5,6,8)
local bad=r(N)
quietly count if vs_rd_external_funding_flag==4
local absent=r(N)
post cell (2018) ("rd_external_funding_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, rd_external_funding_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_external_funding_flag vs_rd_external_funding_flag raw_costrd18
isid source_year source_row
save "$VYD/N_G0_rd_external_funding_flag_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_external_funding_flag_2018"
log close vycell
