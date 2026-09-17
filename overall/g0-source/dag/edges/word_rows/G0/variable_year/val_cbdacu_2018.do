* Tujuan: Untuk 2018, ubah raw_cbdacu18 menjadi val_cbdacu; vs_val_cbdacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cbdacu_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cbdacu_2018: annual staged raw state -> val_cbdacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cbdacu_2018.log", text replace name(vycell)
* Mulai val_cbdacu sebagai nilai kosong; vs_val_cbdacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double val_cbdacu=.
generate byte vs_val_cbdacu=3
* Baca raw_cbdacu18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cbdacu. // WFDOC-INJECTED
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu18),",","",.))*1
replace vs_val_cbdacu=5 if missing(real(subinstr(strtrim(raw_cbdacu18),",","",.))) & !inlist(upper(strtrim(raw_cbdacu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cbdacu=cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0)) if !missing(val_cbdacu)
* Hitung berapa baris val_cbdacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cbdacu)
local obs=r(N)
quietly count if val_cbdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cbdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cbdacu==4
local absent=r(N)
post cell (2018) ("val_cbdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cbdacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cbdacu vs_val_cbdacu raw_cbdacu18
isid source_year source_row
save "$VYD/N_G0_val_cbdacu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cbdacu_2018"
log close vycell
