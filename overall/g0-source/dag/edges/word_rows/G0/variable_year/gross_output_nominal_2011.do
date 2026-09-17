* Tujuan: Untuk 2011, ubah raw_output11 menjadi gross_output_nominal; vs_gross_output_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/gross_output_nominal_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_gross_output_nominal_2011: annual staged raw state -> gross_output_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 133; output11 | total output, 000 rp
log using "$VYL/N_G0_gross_output_nominal_2011.log", text replace name(vycell)
* Mulai gross_output_nominal sebagai nilai kosong; vs_gross_output_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double gross_output_nominal=.
generate byte vs_gross_output_nominal=3
* Baca raw_output11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk gross_output_nominal. // WFDOC-INJECTED
replace gross_output_nominal=real(subinstr(strtrim(raw_output11),",","",.))*1
replace vs_gross_output_nominal=5 if missing(real(subinstr(strtrim(raw_output11),",","",.))) & !inlist(upper(strtrim(raw_output11)),"","***",".","NA","N/A","NULL","-")
replace vs_gross_output_nominal=cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)) if !missing(gross_output_nominal)
* Hitung berapa baris gross_output_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(gross_output_nominal)
local obs=r(N)
quietly count if gross_output_nominal==0
local zeros=r(N)
quietly count if inlist(vs_gross_output_nominal,5,6,8)
local bad=r(N)
quietly count if vs_gross_output_nominal==4
local absent=r(N)
post cell (2011) ("gross_output_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, gross_output_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row gross_output_nominal vs_gross_output_nominal raw_output11
isid source_year source_row
save "$VYD/N_G0_gross_output_nominal_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_gross_output_nominal_2011"
log close vycell
