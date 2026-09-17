* Tujuan: Untuk 2022, ubah raw_eckvcu22 menjadi val_eckvcu; vs_val_eckvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_eckvcu_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_eckvcu_2022: annual staged raw state -> val_eckvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_eckvcu_2022.log", text replace name(vycell)
* Mulai val_eckvcu sebagai nilai kosong; vs_val_eckvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double val_eckvcu=.
generate byte vs_val_eckvcu=3
* Baca raw_eckvcu22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_eckvcu. // WFDOC-INJECTED
replace val_eckvcu=real(subinstr(strtrim(raw_eckvcu22),",","",.))*1
replace vs_val_eckvcu=5 if missing(real(subinstr(strtrim(raw_eckvcu22),",","",.))) & !inlist(upper(strtrim(raw_eckvcu22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eckvcu=cond(val_eckvcu<0,2,cond(val_eckvcu==0,1,0)) if !missing(val_eckvcu)
* Hitung berapa baris val_eckvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_eckvcu)
local obs=r(N)
quietly count if val_eckvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eckvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eckvcu==4
local absent=r(N)
post cell (2022) ("val_eckvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_eckvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_eckvcu vs_val_eckvcu raw_eckvcu22
isid source_year source_row
save "$VYD/N_G0_val_eckvcu_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eckvcu_2022"
log close vycell
