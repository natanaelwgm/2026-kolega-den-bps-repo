* Tujuan: Untuk 2017, ubah raw_intvcu17 menjadi val_intvcu; vs_val_intvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_intvcu_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_intvcu_2017: annual staged raw state -> val_intvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_intvcu_2017.log", text replace name(vycell)
* Mulai val_intvcu sebagai nilai kosong; vs_val_intvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double val_intvcu=.
generate byte vs_val_intvcu=3
* Baca raw_intvcu17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_intvcu. // WFDOC-INJECTED
replace val_intvcu=real(subinstr(strtrim(raw_intvcu17),",","",.))*1
replace vs_val_intvcu=5 if missing(real(subinstr(strtrim(raw_intvcu17),",","",.))) & !inlist(upper(strtrim(raw_intvcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_intvcu=cond(val_intvcu<0,2,cond(val_intvcu==0,1,0)) if !missing(val_intvcu)
* Hitung berapa baris val_intvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_intvcu)
local obs=r(N)
quietly count if val_intvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_intvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_intvcu==4
local absent=r(N)
post cell (2017) ("val_intvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_intvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_intvcu vs_val_intvcu raw_intvcu17
isid source_year source_row
save "$VYD/N_G0_val_intvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_intvcu_2017"
log close vycell
