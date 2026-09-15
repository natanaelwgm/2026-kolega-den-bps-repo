* Tujuan: Untuk 2010, ubah raw_sfdvcu10 menjadi val_sfdvcu; vs_val_sfdvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_sfdvcu_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_sfdvcu_2010: annual staged raw state -> val_sfdvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 100; sfdvcu10 | stock finish prod end of year,000 rp
log using "$VYL/N_G0_val_sfdvcu_2010.log", text replace name(vycell)
* Mulai val_sfdvcu sebagai nilai kosong; vs_val_sfdvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_sfdvcu=.
generate byte vs_val_sfdvcu=3
* Baca raw_sfdvcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_sfdvcu. // WFDOC-INJECTED
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu10),",","",.))*1
replace vs_val_sfdvcu=5 if missing(real(subinstr(strtrim(raw_sfdvcu10),",","",.))) & !inlist(upper(strtrim(raw_sfdvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_sfdvcu=cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0)) if !missing(val_sfdvcu)
* Hitung berapa baris val_sfdvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_sfdvcu)
local obs=r(N)
quietly count if val_sfdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_sfdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_sfdvcu==4
local absent=r(N)
post cell (2010) ("val_sfdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_sfdvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_sfdvcu vs_val_sfdvcu raw_sfdvcu10
isid source_year source_row
save "$VYD/N_G0_val_sfdvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_sfdvcu_2010"
log close vycell
