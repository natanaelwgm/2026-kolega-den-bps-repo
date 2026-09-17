* Tujuan: Untuk 2014, ubah raw_zpdvcu14 menjadi val_zpdvcu; vs_val_zpdvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zpdvcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zpdvcu_2014: annual staged raw state -> val_zpdvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpdvcu_2014.log", text replace name(vycell)
* Mulai val_zpdvcu sebagai nilai kosong; vs_val_zpdvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_zpdvcu=.
generate byte vs_val_zpdvcu=3
* Baca raw_zpdvcu14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_zpdvcu. // WFDOC-INJECTED
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu14),",","",.))*1
replace vs_val_zpdvcu=5 if missing(real(subinstr(strtrim(raw_zpdvcu14),",","",.))) & !inlist(upper(strtrim(raw_zpdvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpdvcu=cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0)) if !missing(val_zpdvcu)
* Hitung berapa baris val_zpdvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zpdvcu)
local obs=r(N)
quietly count if val_zpdvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpdvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpdvcu==4
local absent=r(N)
post cell (2014) ("val_zpdvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zpdvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zpdvcu vs_val_zpdvcu raw_zpdvcu14
isid source_year source_row
save "$VYD/N_G0_val_zpdvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpdvcu_2014"
log close vycell
