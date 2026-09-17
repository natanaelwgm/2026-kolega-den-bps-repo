* Tujuan: Untuk 2015, ubah raw_vtlvcu15 menjadi value_added_nominal; vs_value_added_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/value_added_nominal_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_value_added_nominal_2015: annual staged raw state -> value_added_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 146; vtlvcu15 | value added, 000 rp
log using "$VYL/N_G0_value_added_nominal_2015.log", text replace name(vycell)
* Mulai value_added_nominal sebagai nilai kosong; vs_value_added_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double value_added_nominal=.
generate byte vs_value_added_nominal=3
* Baca raw_vtlvcu15 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk value_added_nominal. // WFDOC-INJECTED
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu15),",","",.))*1
replace vs_value_added_nominal=5 if missing(real(subinstr(strtrim(raw_vtlvcu15),",","",.))) & !inlist(upper(strtrim(raw_vtlvcu15)),"","***",".","NA","N/A","NULL","-")
replace vs_value_added_nominal=cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0)) if !missing(value_added_nominal)
* Hitung berapa baris value_added_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(value_added_nominal)
local obs=r(N)
quietly count if value_added_nominal==0
local zeros=r(N)
quietly count if inlist(vs_value_added_nominal,5,6,8)
local bad=r(N)
quietly count if vs_value_added_nominal==4
local absent=r(N)
post cell (2015) ("value_added_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, value_added_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row value_added_nominal vs_value_added_nominal raw_vtlvcu15
isid source_year source_row
save "$VYD/N_G0_value_added_nominal_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_value_added_nominal_2015"
log close vycell
