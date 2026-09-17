* Tujuan: Untuk 2017, ubah raw_egovcu17 menjadi val_egovcu; vs_val_egovcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_egovcu_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_egovcu_2017: annual staged raw state -> val_egovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_egovcu_2017.log", text replace name(vycell)
* Mulai val_egovcu sebagai nilai kosong; vs_val_egovcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double val_egovcu=.
generate byte vs_val_egovcu=3
* Baca raw_egovcu17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_egovcu. // WFDOC-INJECTED
replace val_egovcu=real(subinstr(strtrim(raw_egovcu17),",","",.))*1
replace vs_val_egovcu=5 if missing(real(subinstr(strtrim(raw_egovcu17),",","",.))) & !inlist(upper(strtrim(raw_egovcu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_egovcu=cond(val_egovcu<0,2,cond(val_egovcu==0,1,0)) if !missing(val_egovcu)
* Hitung berapa baris val_egovcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_egovcu)
local obs=r(N)
quietly count if val_egovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_egovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_egovcu==4
local absent=r(N)
post cell (2017) ("val_egovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_egovcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_egovcu vs_val_egovcu raw_egovcu17
isid source_year source_row
save "$VYD/N_G0_val_egovcu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_egovcu_2017"
log close vycell
