* Tujuan: Untuk 2010, ubah raw_iinput10 menjadi intermediate_inputs_nominal; vs_intermediate_inputs_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/intermediate_inputs_nominal_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_intermediate_inputs_nominal_2010: annual staged raw state -> intermediate_inputs_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 129; iinput10 | total intermediate input, 000 rp
log using "$VYL/N_G0_intermediate_inputs_nominal_2010.log", text replace name(vycell)
* Mulai intermediate_inputs_nominal sebagai nilai kosong; vs_intermediate_inputs_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double intermediate_inputs_nominal=.
generate byte vs_intermediate_inputs_nominal=3
* Baca raw_iinput10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk intermediate_inputs_nominal. // WFDOC-INJECTED
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput10),",","",.))*1
replace vs_intermediate_inputs_nominal=5 if missing(real(subinstr(strtrim(raw_iinput10),",","",.))) & !inlist(upper(strtrim(raw_iinput10)),"","***",".","NA","N/A","NULL","-")
replace vs_intermediate_inputs_nominal=cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0)) if !missing(intermediate_inputs_nominal)
* Hitung berapa baris intermediate_inputs_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(intermediate_inputs_nominal)
local obs=r(N)
quietly count if intermediate_inputs_nominal==0
local zeros=r(N)
quietly count if inlist(vs_intermediate_inputs_nominal,5,6,8)
local bad=r(N)
quietly count if vs_intermediate_inputs_nominal==4
local absent=r(N)
post cell (2010) ("intermediate_inputs_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, intermediate_inputs_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row intermediate_inputs_nominal vs_intermediate_inputs_nominal raw_iinput10
isid source_year source_row
save "$VYD/N_G0_intermediate_inputs_nominal_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_intermediate_inputs_nominal_2010"
log close vycell
