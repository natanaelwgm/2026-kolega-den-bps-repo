* Tujuan: Untuk 2010, ubah raw_shjvcu10 menjadi val_shjvcu; vs_val_shjvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_shjvcu_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_shjvcu_2010: annual staged raw state -> val_shjvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 96; shjvcu10 | stock semi finish prod bgn of yr,000 rp
log using "$VYL/N_G0_val_shjvcu_2010.log", text replace name(vycell)
* Mulai val_shjvcu sebagai nilai kosong; vs_val_shjvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_shjvcu=.
generate byte vs_val_shjvcu=3
* Baca raw_shjvcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_shjvcu. // WFDOC-INJECTED
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu10),",","",.))*1
replace vs_val_shjvcu=5 if missing(real(subinstr(strtrim(raw_shjvcu10),",","",.))) & !inlist(upper(strtrim(raw_shjvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_shjvcu=cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0)) if !missing(val_shjvcu)
* Hitung berapa baris val_shjvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_shjvcu)
local obs=r(N)
quietly count if val_shjvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_shjvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_shjvcu==4
local absent=r(N)
post cell (2010) ("val_shjvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_shjvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_shjvcu vs_val_shjvcu raw_shjvcu10
isid source_year source_row
save "$VYD/N_G0_val_shjvcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_shjvcu_2010"
log close vycell
