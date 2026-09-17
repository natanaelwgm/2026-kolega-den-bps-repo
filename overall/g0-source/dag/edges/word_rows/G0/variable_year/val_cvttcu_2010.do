* Tujuan: Untuk 2010, ubah raw_cvttcu10 menjadi val_cvttcu; vs_val_cvttcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cvttcu_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cvttcu_2010: annual staged raw state -> val_cvttcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 117; cvttcu10 | vehicles purchases & constr, 000rp
log using "$VYL/N_G0_val_cvttcu_2010.log", text replace name(vycell)
* Mulai val_cvttcu sebagai nilai kosong; vs_val_cvttcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_cvttcu=.
generate byte vs_val_cvttcu=3
* Baca raw_cvttcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cvttcu. // WFDOC-INJECTED
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu10),",","",.))*1
replace vs_val_cvttcu=5 if missing(real(subinstr(strtrim(raw_cvttcu10),",","",.))) & !inlist(upper(strtrim(raw_cvttcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cvttcu=cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0)) if !missing(val_cvttcu)
* Hitung berapa baris val_cvttcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cvttcu)
local obs=r(N)
quietly count if val_cvttcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cvttcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cvttcu==4
local absent=r(N)
post cell (2010) ("val_cvttcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cvttcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cvttcu vs_val_cvttcu raw_cvttcu10
isid source_year source_row
save "$VYD/N_G0_val_cvttcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cvttcu_2010"
log close vycell
