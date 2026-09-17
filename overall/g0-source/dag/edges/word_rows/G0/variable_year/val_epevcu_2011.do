* Tujuan: Untuk 2011, ubah raw_epevcu11 menjadi val_epevcu; vs_val_epevcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_epevcu_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_epevcu_2011: annual staged raw state -> val_epevcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 35; epevcu11 | total premium/gasoline used, 000rp
log using "$VYL/N_G0_val_epevcu_2011.log", text replace name(vycell)
* Mulai val_epevcu sebagai nilai kosong; vs_val_epevcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double val_epevcu=.
generate byte vs_val_epevcu=3
* Baca raw_epevcu11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_epevcu. // WFDOC-INJECTED
replace val_epevcu=real(subinstr(strtrim(raw_epevcu11),",","",.))*1
replace vs_val_epevcu=5 if missing(real(subinstr(strtrim(raw_epevcu11),",","",.))) & !inlist(upper(strtrim(raw_epevcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_val_epevcu=cond(val_epevcu<0,2,cond(val_epevcu==0,1,0)) if !missing(val_epevcu)
* Hitung berapa baris val_epevcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_epevcu)
local obs=r(N)
quietly count if val_epevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_epevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_epevcu==4
local absent=r(N)
post cell (2011) ("val_epevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_epevcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_epevcu vs_val_epevcu raw_epevcu11
isid source_year source_row
save "$VYD/N_G0_val_epevcu_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_epevcu_2011"
log close vycell
