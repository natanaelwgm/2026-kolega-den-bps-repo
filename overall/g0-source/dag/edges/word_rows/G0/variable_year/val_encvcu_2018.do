* Tujuan: Untuk 2018, ubah raw_encvcu18 menjadi val_encvcu; vs_val_encvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_encvcu_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_encvcu_2018: annual staged raw state -> val_encvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_encvcu_2018.log", text replace name(vycell)
* Mulai val_encvcu sebagai nilai kosong; vs_val_encvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double val_encvcu=.
generate byte vs_val_encvcu=3
* Baca raw_encvcu18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_encvcu. // WFDOC-INJECTED
replace val_encvcu=real(subinstr(strtrim(raw_encvcu18),",","",.))*1
replace vs_val_encvcu=5 if missing(real(subinstr(strtrim(raw_encvcu18),",","",.))) & !inlist(upper(strtrim(raw_encvcu18)),"","***",".","NA","N/A","NULL","-")
replace vs_val_encvcu=cond(val_encvcu<0,2,cond(val_encvcu==0,1,0)) if !missing(val_encvcu)
* Hitung berapa baris val_encvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_encvcu)
local obs=r(N)
quietly count if val_encvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_encvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_encvcu==4
local absent=r(N)
post cell (2018) ("val_encvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_encvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_encvcu vs_val_encvcu raw_encvcu18
isid source_year source_row
save "$VYD/N_G0_val_encvcu_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_encvcu_2018"
log close vycell
