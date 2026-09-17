* Tujuan: Untuk 2012, ubah raw_cbsacu12 menjadi val_cbsacu; vs_val_cbsacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cbsacu_2012.do dari data/intermediate/raw_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cbsacu_2012: annual staged raw state -> val_cbsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 105; cbsacu12 | sale/reduce of building, 000 rp
log using "$VYL/N_G0_val_cbsacu_2012.log", text replace name(vycell)
* Mulai val_cbsacu sebagai nilai kosong; vs_val_cbsacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double val_cbsacu=.
generate byte vs_val_cbsacu=3
* Baca raw_cbsacu12 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cbsacu. // WFDOC-INJECTED
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu12),",","",.))*1
replace vs_val_cbsacu=5 if missing(real(subinstr(strtrim(raw_cbsacu12),",","",.))) & !inlist(upper(strtrim(raw_cbsacu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbsacu=cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0)) if !missing(val_cbsacu)
* Hitung berapa baris val_cbsacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cbsacu)
local obs=r(N)
quietly count if val_cbsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbsacu==4
local absent=r(N)
post cell (2012) ("val_cbsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cbsacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cbsacu vs_val_cbsacu raw_cbsacu12
isid source_year source_row
save "$VYD/N_G0_val_cbsacu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbsacu_2012"
log close vycell
