* Tujuan: Untuk 2017, ubah raw_ekspor17 menjadi export_direct_flag; vs_export_direct_flag mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_direct_flag_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_export_direct_flag_2017: annual staged raw state -> export_direct_flag at source_year/source_row.
* Evidence: 2022 Sumbar PDF p72 Q402a: direct export, 1 yes 2 no. Direct no does not imply no indirect exports.
log using "$VYL/N_G0_export_direct_flag_2017.log", text replace name(vycell)
* Mulai export_direct_flag sebagai nilai kosong; vs_export_direct_flag mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double export_direct_flag=.
generate byte vs_export_direct_flag=3
replace vs_export_direct_flag=7
replace vs_export_direct_flag=cond(export_direct_flag<0,2,cond(export_direct_flag==0,1,0)) if !missing(export_direct_flag)
* Hitung berapa baris export_direct_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_direct_flag)
local obs=r(N)
quietly count if export_direct_flag==0
local zeros=r(N)
quietly count if inlist(vs_export_direct_flag,5,6,8)
local bad=r(N)
quietly count if vs_export_direct_flag==4
local absent=r(N)
post cell (2017) ("export_direct_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, export_direct_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_direct_flag vs_export_direct_flag raw_ekspor17
isid source_year source_row
save "$VYD/N_G0_export_direct_flag_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_direct_flag_2017"
log close vycell
