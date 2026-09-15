* Tujuan: Untuk 2021, ubah raw_cssacu21 menjadi val_cssacu; vs_val_cssacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cssacu_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cssacu_2021: annual staged raw state -> val_cssacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_cssacu_2021.log", text replace name(vycell)
* Mulai val_cssacu sebagai nilai kosong; vs_val_cssacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double val_cssacu=.
generate byte vs_val_cssacu=3
* Baca raw_cssacu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cssacu. // WFDOC-INJECTED
replace val_cssacu=real(subinstr(strtrim(raw_cssacu21),",","",.))*1
replace vs_val_cssacu=5 if missing(real(subinstr(strtrim(raw_cssacu21),",","",.))) & !inlist(upper(strtrim(raw_cssacu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cssacu=cond(val_cssacu<0,2,cond(val_cssacu==0,1,0)) if !missing(val_cssacu)
* Hitung berapa baris val_cssacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cssacu)
local obs=r(N)
quietly count if val_cssacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cssacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cssacu==4
local absent=r(N)
post cell (2021) ("val_cssacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cssacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cssacu vs_val_cssacu raw_cssacu21
isid source_year source_row
save "$VYD/N_G0_val_cssacu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cssacu_2021"
log close vycell
