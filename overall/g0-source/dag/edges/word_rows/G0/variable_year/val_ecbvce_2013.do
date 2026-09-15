* Tujuan: Untuk 2013, ubah raw_ecbvce13 menjadi val_ecbvce; vs_val_ecbvce mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_ecbvce_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_ecbvce_2013: annual staged raw state -> val_ecbvce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2013 row 62; ecbvce13 | coal briquettes used for elec gen, 000rp
log using "$VYL/N_G0_val_ecbvce_2013.log", text replace name(vycell)
* Mulai val_ecbvce sebagai nilai kosong; vs_val_ecbvce mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double val_ecbvce=.
generate byte vs_val_ecbvce=3
* Baca raw_ecbvce13 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_ecbvce. // WFDOC-INJECTED
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce13),",","",.))*1
replace vs_val_ecbvce=5 if missing(real(subinstr(strtrim(raw_ecbvce13),",","",.))) & !inlist(upper(strtrim(raw_ecbvce13)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ecbvce=cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0)) if !missing(val_ecbvce)
* Hitung berapa baris val_ecbvce yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_ecbvce)
local obs=r(N)
quietly count if val_ecbvce==0
local zeros=r(N)
quietly count if inlist(vs_val_ecbvce,5,6,8)
local bad=r(N)
quietly count if vs_val_ecbvce==4
local absent=r(N)
post cell (2013) ("val_ecbvce") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_ecbvce, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_ecbvce vs_val_ecbvce raw_ecbvce13
isid source_year source_row
save "$VYD/N_G0_val_ecbvce_2013.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ecbvce_2013"
log close vycell
