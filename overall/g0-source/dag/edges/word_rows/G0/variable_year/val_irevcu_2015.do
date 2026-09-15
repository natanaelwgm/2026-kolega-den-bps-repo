* Tujuan: Untuk 2015, ubah raw_irevcu menjadi val_irevcu; vs_val_irevcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_irevcu_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_irevcu_2015: annual staged raw state -> val_irevcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 96; irevcu15 | representative+royalty, 000rp
log using "$VYL/N_G0_val_irevcu_2015.log", text replace name(vycell)
* Mulai val_irevcu sebagai nilai kosong; vs_val_irevcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double val_irevcu=.
generate byte vs_val_irevcu=3
* Baca raw_irevcu setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_irevcu. // WFDOC-INJECTED
replace val_irevcu=real(subinstr(strtrim(raw_irevcu),",","",.))*1
replace vs_val_irevcu=5 if missing(real(subinstr(strtrim(raw_irevcu),",","",.))) & !inlist(upper(strtrim(raw_irevcu)),"","***",".","NA","N/A","NULL","-")
replace vs_val_irevcu=cond(val_irevcu<0,2,cond(val_irevcu==0,1,0)) if !missing(val_irevcu)
* Hitung berapa baris val_irevcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_irevcu)
local obs=r(N)
quietly count if val_irevcu==0
local zeros=r(N)
quietly count if inlist(vs_val_irevcu,5,6,8)
local bad=r(N)
quietly count if vs_val_irevcu==4
local absent=r(N)
post cell (2015) ("val_irevcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_irevcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_irevcu vs_val_irevcu raw_irevcu
isid source_year source_row
save "$VYD/N_G0_val_irevcu_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_irevcu_2015"
log close vycell
