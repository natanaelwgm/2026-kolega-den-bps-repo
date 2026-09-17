* Tujuan: Untuk 2019, ubah raw_rtlvcu19 menjadi val_rtlvcu; vs_val_rtlvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_rtlvcu_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_rtlvcu_2019: annual staged raw state -> val_rtlvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_rtlvcu_2019.log", text replace name(vycell)
* Mulai val_rtlvcu sebagai nilai kosong; vs_val_rtlvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double val_rtlvcu=.
generate byte vs_val_rtlvcu=3
* Baca raw_rtlvcu19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_rtlvcu. // WFDOC-INJECTED
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu19),",","",.))*1
replace vs_val_rtlvcu=5 if missing(real(subinstr(strtrim(raw_rtlvcu19),",","",.))) & !inlist(upper(strtrim(raw_rtlvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_rtlvcu=cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0)) if !missing(val_rtlvcu)
* Hitung berapa baris val_rtlvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_rtlvcu)
local obs=r(N)
quietly count if val_rtlvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_rtlvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_rtlvcu==4
local absent=r(N)
post cell (2019) ("val_rtlvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_rtlvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_rtlvcu vs_val_rtlvcu raw_rtlvcu19
isid source_year source_row
save "$VYD/N_G0_val_rtlvcu_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_rtlvcu_2019"
log close vycell
