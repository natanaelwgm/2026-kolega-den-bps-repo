* Tujuan: Untuk 2021, ubah raw_esdvce21 menjadi val_esdvce; vs_val_esdvce mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_esdvce_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_esdvce_2021: annual staged raw state -> val_esdvce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_esdvce_2021.log", text replace name(vycell)
* Mulai val_esdvce sebagai nilai kosong; vs_val_esdvce mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double val_esdvce=.
generate byte vs_val_esdvce=3
* Baca raw_esdvce21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_esdvce. // WFDOC-INJECTED
replace val_esdvce=real(subinstr(strtrim(raw_esdvce21),",","",.))*1
replace vs_val_esdvce=5 if missing(real(subinstr(strtrim(raw_esdvce21),",","",.))) & !inlist(upper(strtrim(raw_esdvce21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_esdvce=cond(val_esdvce<0,2,cond(val_esdvce==0,1,0)) if !missing(val_esdvce)
* Hitung berapa baris val_esdvce yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_esdvce)
local obs=r(N)
quietly count if val_esdvce==0
local zeros=r(N)
quietly count if inlist(vs_val_esdvce,5,6,8)
local bad=r(N)
quietly count if vs_val_esdvce==4
local absent=r(N)
post cell (2021) ("val_esdvce") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_esdvce, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_esdvce vs_val_esdvce raw_esdvce21
isid source_year source_row
save "$VYD/N_G0_val_esdvce_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_esdvce_2021"
log close vycell
