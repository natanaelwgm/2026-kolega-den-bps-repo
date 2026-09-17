* Tujuan: Untuk 2015, ubah raw_eoivce menjadi val_eoivce; vs_val_eoivce mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_eoivce_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_eoivce_2015: annual staged raw state -> val_eoivce at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 52; eoivce15 | kerosene used for elec gen, 000 rp
log using "$VYL/N_G0_val_eoivce_2015.log", text replace name(vycell)
* Mulai val_eoivce sebagai nilai kosong; vs_val_eoivce mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double val_eoivce=.
generate byte vs_val_eoivce=3
* Baca raw_eoivce setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_eoivce. // WFDOC-INJECTED
replace val_eoivce=real(subinstr(strtrim(raw_eoivce),",","",.))*1
replace vs_val_eoivce=5 if missing(real(subinstr(strtrim(raw_eoivce),",","",.))) & !inlist(upper(strtrim(raw_eoivce)),"","***",".","NA","N/A","NULL","-")
replace vs_val_eoivce=cond(val_eoivce<0,2,cond(val_eoivce==0,1,0)) if !missing(val_eoivce)
* Hitung berapa baris val_eoivce yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_eoivce)
local obs=r(N)
quietly count if val_eoivce==0
local zeros=r(N)
quietly count if inlist(vs_val_eoivce,5,6,8)
local bad=r(N)
quietly count if vs_val_eoivce==4
local absent=r(N)
post cell (2015) ("val_eoivce") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_eoivce, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_eoivce vs_val_eoivce raw_eoivce
isid source_year source_row
save "$VYD/N_G0_val_eoivce_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_eoivce_2015"
log close vycell
