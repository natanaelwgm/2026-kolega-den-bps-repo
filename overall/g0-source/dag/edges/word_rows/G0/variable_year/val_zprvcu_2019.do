* Tujuan: Untuk 2019, ubah raw_zprvcu19 menjadi val_zprvcu; vs_val_zprvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_zprvcu_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_zprvcu_2019: annual staged raw state -> val_zprvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_zprvcu_2019.log", text replace name(vycell)
* Mulai val_zprvcu sebagai nilai kosong; vs_val_zprvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double val_zprvcu=.
generate byte vs_val_zprvcu=3
* Baca raw_zprvcu19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_zprvcu. // WFDOC-INJECTED
replace val_zprvcu=real(subinstr(strtrim(raw_zprvcu19),",","",.))*1
replace vs_val_zprvcu=5 if missing(real(subinstr(strtrim(raw_zprvcu19),",","",.))) & !inlist(upper(strtrim(raw_zprvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_zprvcu=cond(val_zprvcu<0,2,cond(val_zprvcu==0,1,0)) if !missing(val_zprvcu)
* Hitung berapa baris val_zprvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_zprvcu)
local obs=r(N)
quietly count if val_zprvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_zprvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_zprvcu==4
local absent=r(N)
post cell (2019) ("val_zprvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_zprvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_zprvcu vs_val_zprvcu raw_zprvcu19
isid source_year source_row
save "$VYD/N_G0_val_zprvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_zprvcu_2019"
log close vycell
