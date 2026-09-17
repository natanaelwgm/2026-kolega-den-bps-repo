* Tujuan: Untuk 2017, ubah raw_zpavcu17 menjadi val_zpavcu; vs_val_zpavcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zpavcu_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zpavcu_2017: annual staged raw state -> val_zpavcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zpavcu_2017.log", text replace name(vycell)
* Mulai val_zpavcu sebagai nilai kosong; vs_val_zpavcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double val_zpavcu=.
generate byte vs_val_zpavcu=3
* Baca raw_zpavcu17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_zpavcu. // WFDOC-INJECTED
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu17),",","",.))*1
replace vs_val_zpavcu=5 if missing(real(subinstr(strtrim(raw_zpavcu17),",","",.))) & !inlist(upper(strtrim(raw_zpavcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zpavcu=cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0)) if !missing(val_zpavcu)
* Hitung berapa baris val_zpavcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zpavcu)
local obs=r(N)
quietly count if val_zpavcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zpavcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zpavcu==4
local absent=r(N)
post cell (2017) ("val_zpavcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zpavcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zpavcu vs_val_zpavcu raw_zpavcu17
isid source_year source_row
save "$VYD/N_G0_val_zpavcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zpavcu_2017"
log close vycell
