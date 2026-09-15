* Tujuan: Untuk 2019, ubah raw_vtlvcu19 menjadi val_vtlvcu; vs_val_vtlvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_vtlvcu_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_vtlvcu_2019: annual staged raw state -> val_vtlvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_vtlvcu_2019.log", text replace name(vycell)
* Mulai val_vtlvcu sebagai nilai kosong; vs_val_vtlvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double val_vtlvcu=.
generate byte vs_val_vtlvcu=3
* Baca raw_vtlvcu19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_vtlvcu. // WFDOC-INJECTED
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu19),",","",.))*1
replace vs_val_vtlvcu=5 if missing(real(subinstr(strtrim(raw_vtlvcu19),",","",.))) & !inlist(upper(strtrim(raw_vtlvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_vtlvcu=cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0)) if !missing(val_vtlvcu)
* Hitung berapa baris val_vtlvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_vtlvcu)
local obs=r(N)
quietly count if val_vtlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_vtlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_vtlvcu==4
local absent=r(N)
post cell (2019) ("val_vtlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_vtlvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_vtlvcu vs_val_vtlvcu raw_vtlvcu19
isid source_year source_row
save "$VYD/N_G0_val_vtlvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_vtlvcu_2019"
log close vycell
