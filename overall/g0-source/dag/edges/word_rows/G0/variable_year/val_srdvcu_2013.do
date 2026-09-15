* Tujuan: Untuk 2013, ubah raw_srdvcu13 menjadi val_srdvcu; vs_val_srdvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_srdvcu_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_srdvcu_2013: annual staged raw state -> val_srdvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 111; srdvcu13 | stock raw matrl,etc end year, 000 rp
log using "$VYL/N_G0_val_srdvcu_2013.log", text replace name(vycell)
* Mulai val_srdvcu sebagai nilai kosong; vs_val_srdvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double val_srdvcu=.
generate byte vs_val_srdvcu=3
* Baca raw_srdvcu13 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_srdvcu. // WFDOC-INJECTED
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu13),",","",.))*1
replace vs_val_srdvcu=5 if missing(real(subinstr(strtrim(raw_srdvcu13),",","",.))) & !inlist(upper(strtrim(raw_srdvcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_srdvcu=cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0)) if !missing(val_srdvcu)
* Hitung berapa baris val_srdvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_srdvcu)
local obs=r(N)
quietly count if val_srdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_srdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_srdvcu==4
local absent=r(N)
post cell (2013) ("val_srdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_srdvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_srdvcu vs_val_srdvcu raw_srdvcu13
isid source_year source_row
save "$VYD/N_G0_val_srdvcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_srdvcu_2013"
log close vycell
