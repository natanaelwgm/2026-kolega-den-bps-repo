* Tujuan: Untuk 2011, ubah raw_cldacu11 menjadi val_cldacu; vs_val_cldacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cldacu_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cldacu_2011: annual staged raw state -> val_cldacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 107; cldacu11 | depreciation of land, 000 rp
log using "$VYL/N_G0_val_cldacu_2011.log", text replace name(vycell)
* Mulai val_cldacu sebagai nilai kosong; vs_val_cldacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double val_cldacu=.
generate byte vs_val_cldacu=3
* Baca raw_cldacu11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cldacu. // WFDOC-INJECTED
replace val_cldacu=real(subinstr(strtrim(raw_cldacu11),",","",.))*1
replace vs_val_cldacu=5 if missing(real(subinstr(strtrim(raw_cldacu11),",","",.))) & !inlist(upper(strtrim(raw_cldacu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cldacu=cond(val_cldacu<0,2,cond(val_cldacu==0,1,0)) if !missing(val_cldacu)
* Hitung berapa baris val_cldacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cldacu)
local obs=r(N)
quietly count if val_cldacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cldacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cldacu==4
local absent=r(N)
post cell (2011) ("val_cldacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cldacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cldacu vs_val_cldacu raw_cldacu11
isid source_year source_row
save "$VYD/N_G0_val_cldacu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cldacu_2011"
log close vycell
