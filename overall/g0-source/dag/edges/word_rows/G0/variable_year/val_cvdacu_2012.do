* Tujuan: Untuk 2012, ubah raw_cvdacu12 menjadi val_cvdacu; vs_val_cvdacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cvdacu_2012.do dari data/intermediate/raw_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cvdacu_2012: annual staged raw state -> val_cvdacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 114; cvdacu12 | depreciation of vehicles, 000 rp
log using "$VYL/N_G0_val_cvdacu_2012.log", text replace name(vycell)
* Mulai val_cvdacu sebagai nilai kosong; vs_val_cvdacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double val_cvdacu=.
generate byte vs_val_cvdacu=3
* Baca raw_cvdacu12 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cvdacu. // WFDOC-INJECTED
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu12),",","",.))*1
replace vs_val_cvdacu=5 if missing(real(subinstr(strtrim(raw_cvdacu12),",","",.))) & !inlist(upper(strtrim(raw_cvdacu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cvdacu=cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0)) if !missing(val_cvdacu)
* Hitung berapa baris val_cvdacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cvdacu)
local obs=r(N)
quietly count if val_cvdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cvdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cvdacu==4
local absent=r(N)
post cell (2012) ("val_cvdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cvdacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cvdacu vs_val_cvdacu raw_cvdacu12
isid source_year source_row
save "$VYD/N_G0_val_cvdacu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cvdacu_2012"
log close vycell
