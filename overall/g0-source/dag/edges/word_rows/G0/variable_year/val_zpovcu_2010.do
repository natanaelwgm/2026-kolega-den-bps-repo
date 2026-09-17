* Tujuan: Untuk 2010, ubah raw_zpovcu10 menjadi val_zpovcu; vs_val_zpovcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zpovcu_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zpovcu_2010: annual staged raw state -> val_zpovcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 23; zpovcu10 | overtime prod workers, 000rp
log using "$VYL/N_G0_val_zpovcu_2010.log", text replace name(vycell)
* Mulai val_zpovcu sebagai nilai kosong; vs_val_zpovcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_zpovcu=.
generate byte vs_val_zpovcu=3
* Baca raw_zpovcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_zpovcu. // WFDOC-INJECTED
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu10),",","",.))*1
replace vs_val_zpovcu=5 if missing(real(subinstr(strtrim(raw_zpovcu10),",","",.))) & !inlist(upper(strtrim(raw_zpovcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpovcu=cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0)) if !missing(val_zpovcu)
* Hitung berapa baris val_zpovcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zpovcu)
local obs=r(N)
quietly count if val_zpovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpovcu==4
local absent=r(N)
post cell (2010) ("val_zpovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zpovcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zpovcu vs_val_zpovcu raw_zpovcu10
isid source_year source_row
save "$VYD/N_G0_val_zpovcu_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpovcu_2010"
log close vycell
