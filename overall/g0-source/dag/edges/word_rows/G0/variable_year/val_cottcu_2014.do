* Tujuan: Untuk 2014, ubah raw_cottcu14 menjadi val_cottcu; vs_val_cottcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cottcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cottcu_2014: annual staged raw state -> val_cottcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 153; cottcu14 | other fixed capital purchase,000rp
log using "$VYL/N_G0_val_cottcu_2014.log", text replace name(vycell)
* Mulai val_cottcu sebagai nilai kosong; vs_val_cottcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_cottcu=.
generate byte vs_val_cottcu=3
* Baca raw_cottcu14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cottcu. // WFDOC-INJECTED
replace val_cottcu=real(subinstr(strtrim(raw_cottcu14),",","",.))*1
replace vs_val_cottcu=5 if missing(real(subinstr(strtrim(raw_cottcu14),",","",.))) & !inlist(upper(strtrim(raw_cottcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cottcu=cond(val_cottcu<0,2,cond(val_cottcu==0,1,0)) if !missing(val_cottcu)
* Hitung berapa baris val_cottcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cottcu)
local obs=r(N)
quietly count if val_cottcu==0
local zeros=r(N)
quietly count if inlist(vs_val_cottcu,5,6,8)
local bad=r(N)
quietly count if vs_val_cottcu==4
local absent=r(N)
post cell (2014) ("val_cottcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cottcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cottcu vs_val_cottcu raw_cottcu14
isid source_year source_row
save "$VYD/N_G0_val_cottcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cottcu_2014"
log close vycell
