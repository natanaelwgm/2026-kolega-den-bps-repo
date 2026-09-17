* Tujuan: Untuk 2014, ubah raw_rimvcu14 menjadi val_rimvcu; vs_val_rimvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_rimvcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_rimvcu_2014: annual staged raw state -> val_rimvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 114; rimvcu14 | imported raw material used, 000rp
log using "$VYL/N_G0_val_rimvcu_2014.log", text replace name(vycell)
* Mulai val_rimvcu sebagai nilai kosong; vs_val_rimvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_rimvcu=.
generate byte vs_val_rimvcu=3
* Baca raw_rimvcu14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_rimvcu. // WFDOC-INJECTED
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu14),",","",.))*1
replace vs_val_rimvcu=5 if missing(real(subinstr(strtrim(raw_rimvcu14),",","",.))) & !inlist(upper(strtrim(raw_rimvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rimvcu=cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0)) if !missing(val_rimvcu)
* Hitung berapa baris val_rimvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_rimvcu)
local obs=r(N)
quietly count if val_rimvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rimvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rimvcu==4
local absent=r(N)
post cell (2014) ("val_rimvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_rimvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_rimvcu vs_val_rimvcu raw_rimvcu14
isid source_year source_row
save "$VYD/N_G0_val_rimvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rimvcu_2014"
log close vycell
