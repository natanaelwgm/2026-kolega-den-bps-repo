* Tujuan: Untuk 2010, ubah raw_rimvcu10 menjadi import_value_nominal; vs_import_value_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/import_value_nominal_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_import_value_nominal_2010: annual staged raw state -> import_value_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 85; rimvcu10 | imported raw material used, 000rp
log using "$VYL/N_G0_import_value_nominal_2010.log", text replace name(vycell)
* Mulai import_value_nominal sebagai nilai kosong; vs_import_value_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double import_value_nominal=.
generate byte vs_import_value_nominal=3
* Baca raw_rimvcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk import_value_nominal. // WFDOC-INJECTED
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu10),",","",.))*1
replace vs_import_value_nominal=5 if missing(real(subinstr(strtrim(raw_rimvcu10),",","",.))) & !inlist(upper(strtrim(raw_rimvcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_import_value_nominal=cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0)) if !missing(import_value_nominal)
* Hitung berapa baris import_value_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(import_value_nominal)
local obs=r(N)
quietly count if import_value_nominal==0
local zeros=r(N)
quietly count if inlist(vs_import_value_nominal,5,6,8)
local bad=r(N)
quietly count if vs_import_value_nominal==4
local absent=r(N)
post cell (2010) ("import_value_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, import_value_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row import_value_nominal vs_import_value_nominal raw_rimvcu10
isid source_year source_row
save "$VYD/N_G0_import_value_nominal_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_import_value_nominal_2010"
log close vycell
