* Tujuan: Untuk 2018, ubah raw_renvcu18 menjadi val_renvcu; vs_val_renvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_renvcu_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_renvcu_2018: annual staged raw state -> val_renvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_renvcu_2018.log", text replace name(vycell)
* Mulai val_renvcu sebagai nilai kosong; vs_val_renvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double val_renvcu=.
generate byte vs_val_renvcu=3
* Baca raw_renvcu18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_renvcu. // WFDOC-INJECTED
replace val_renvcu=real(subinstr(strtrim(raw_renvcu18),",","",.))*1
replace vs_val_renvcu=5 if missing(real(subinstr(strtrim(raw_renvcu18),",","",.))) & !inlist(upper(strtrim(raw_renvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_renvcu=cond(val_renvcu<0,2,cond(val_renvcu==0,1,0)) if !missing(val_renvcu)
* Hitung berapa baris val_renvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_renvcu)
local obs=r(N)
quietly count if val_renvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_renvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_renvcu==4
local absent=r(N)
post cell (2018) ("val_renvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_renvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_renvcu vs_val_renvcu raw_renvcu18
isid source_year source_row
save "$VYD/N_G0_val_renvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_renvcu_2018"
log close vycell
