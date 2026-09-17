* Tujuan: Untuk 2013, ubah raw_ctdacu13 menjadi val_ctdacu; vs_val_ctdacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_ctdacu_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_ctdacu_2013: annual staged raw state -> val_ctdacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 144; ctdacu13 | depreciation of total fix cap, 000 rp
log using "$VYL/N_G0_val_ctdacu_2013.log", text replace name(vycell)
* Mulai val_ctdacu sebagai nilai kosong; vs_val_ctdacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double val_ctdacu=.
generate byte vs_val_ctdacu=3
* Baca raw_ctdacu13 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_ctdacu. // WFDOC-INJECTED
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu13),",","",.))*1
replace vs_val_ctdacu=5 if missing(real(subinstr(strtrim(raw_ctdacu13),",","",.))) & !inlist(upper(strtrim(raw_ctdacu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ctdacu=cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0)) if !missing(val_ctdacu)
* Hitung berapa baris val_ctdacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_ctdacu)
local obs=r(N)
quietly count if val_ctdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_ctdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_ctdacu==4
local absent=r(N)
post cell (2013) ("val_ctdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_ctdacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_ctdacu vs_val_ctdacu raw_ctdacu13
isid source_year source_row
save "$VYD/N_G0_val_ctdacu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ctdacu_2013"
log close vycell
