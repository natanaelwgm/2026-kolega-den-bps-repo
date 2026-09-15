* Tujuan: Untuk 2020, ubah raw_ytovcu20 menjadi val_ytovcu; vs_val_ytovcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_ytovcu_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_ytovcu_2020: annual staged raw state -> val_ytovcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ytovcu_2020.log", text replace name(vycell)
* Mulai val_ytovcu sebagai nilai kosong; vs_val_ytovcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double val_ytovcu=.
generate byte vs_val_ytovcu=3
* Baca raw_ytovcu20 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_ytovcu. // WFDOC-INJECTED
replace val_ytovcu=real(subinstr(strtrim(raw_ytovcu20),",","",.))*1
replace vs_val_ytovcu=5 if missing(real(subinstr(strtrim(raw_ytovcu20),",","",.))) & !inlist(upper(strtrim(raw_ytovcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ytovcu=cond(val_ytovcu<0,2,cond(val_ytovcu==0,1,0)) if !missing(val_ytovcu)
* Hitung berapa baris val_ytovcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_ytovcu)
local obs=r(N)
quietly count if val_ytovcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ytovcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ytovcu==4
local absent=r(N)
post cell (2020) ("val_ytovcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_ytovcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_ytovcu vs_val_ytovcu raw_ytovcu20
isid source_year source_row
save "$VYD/N_G0_val_ytovcu_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ytovcu_2020"
log close vycell
