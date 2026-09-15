* Tujuan: Untuk 2014, ubah raw_znpvcu14 menjadi val_znpvcu; vs_val_znpvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_znpvcu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_znpvcu_2014: annual staged raw state -> val_znpvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 49; znpvcu14 | pensi-soc allw-ins non prod wrkrs, 000rp
log using "$VYL/N_G0_val_znpvcu_2014.log", text replace name(vycell)
* Mulai val_znpvcu sebagai nilai kosong; vs_val_znpvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_znpvcu=.
generate byte vs_val_znpvcu=3
* Baca raw_znpvcu14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_znpvcu. // WFDOC-INJECTED
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu14),",","",.))*1
replace vs_val_znpvcu=5 if missing(real(subinstr(strtrim(raw_znpvcu14),",","",.))) & !inlist(upper(strtrim(raw_znpvcu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_znpvcu=cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0)) if !missing(val_znpvcu)
* Hitung berapa baris val_znpvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_znpvcu)
local obs=r(N)
quietly count if val_znpvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_znpvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_znpvcu==4
local absent=r(N)
post cell (2014) ("val_znpvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_znpvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_znpvcu vs_val_znpvcu raw_znpvcu14
isid source_year source_row
save "$VYD/N_G0_val_znpvcu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_znpvcu_2014"
log close vycell
