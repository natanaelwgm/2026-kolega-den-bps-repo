* Tujuan: Untuk 2013, ubah raw_eplvcu13 menjadi val_eplvcu; vs_val_eplvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_eplvcu_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_eplvcu_2013: annual staged raw state -> val_eplvcu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 86; eplvcu13 | electricity purch from pln, 000rp
log using "$VYL/N_G0_val_eplvcu_2013.log", text replace name(vycell)
* Mulai val_eplvcu sebagai nilai kosong; vs_val_eplvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double val_eplvcu=.
generate byte vs_val_eplvcu=3
* Baca raw_eplvcu13 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_eplvcu. // WFDOC-INJECTED
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu13),",","",.))*1
replace vs_val_eplvcu=5 if missing(real(subinstr(strtrim(raw_eplvcu13),",","",.))) & !inlist(upper(strtrim(raw_eplvcu13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eplvcu=cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0)) if !missing(val_eplvcu)
* Hitung berapa baris val_eplvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_eplvcu)
local obs=r(N)
quietly count if val_eplvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_eplvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_eplvcu==4
local absent=r(N)
post cell (2013) ("val_eplvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_eplvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_eplvcu vs_val_eplvcu raw_eplvcu13
isid source_year source_row
save "$VYD/N_G0_val_eplvcu_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eplvcu_2013"
log close vycell
