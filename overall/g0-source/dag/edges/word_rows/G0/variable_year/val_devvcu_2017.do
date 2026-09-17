* Tujuan: Untuk 2017, ubah raw_devvcu17 menjadi val_devvcu; vs_val_devvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_devvcu_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_devvcu_2017: annual staged raw state -> val_devvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_devvcu_2017.log", text replace name(vycell)
* Mulai val_devvcu sebagai nilai kosong; vs_val_devvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double val_devvcu=.
generate byte vs_val_devvcu=3
* Baca raw_devvcu17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_devvcu. // WFDOC-INJECTED
replace val_devvcu=real(subinstr(strtrim(raw_devvcu17),",","",.))*1
replace vs_val_devvcu=5 if missing(real(subinstr(strtrim(raw_devvcu17),",","",.))) & !inlist(upper(strtrim(raw_devvcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_devvcu=cond(val_devvcu<0,2,cond(val_devvcu==0,1,0)) if !missing(val_devvcu)
* Hitung berapa baris val_devvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_devvcu)
local obs=r(N)
quietly count if val_devvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_devvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_devvcu==4
local absent=r(N)
post cell (2017) ("val_devvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_devvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_devvcu vs_val_devvcu raw_devvcu17
isid source_year source_row
save "$VYD/N_G0_val_devvcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_devvcu_2017"
log close vycell
