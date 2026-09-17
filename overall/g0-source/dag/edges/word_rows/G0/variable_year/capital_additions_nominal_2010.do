* Tujuan: Untuk 2010, ubah raw_ctttcu10 menjadi capital_additions_nominal; vs_capital_additions_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/capital_additions_nominal_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_capital_additions_nominal_2010: annual staged raw state -> capital_additions_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 125; ctttcu10 | total purchases & construct, 000rp
log using "$VYL/N_G0_capital_additions_nominal_2010.log", text replace name(vycell)
* Mulai capital_additions_nominal sebagai nilai kosong; vs_capital_additions_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double capital_additions_nominal=.
generate byte vs_capital_additions_nominal=3
* Baca raw_ctttcu10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk capital_additions_nominal. // WFDOC-INJECTED
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu10),",","",.))*1
replace vs_capital_additions_nominal=5 if missing(real(subinstr(strtrim(raw_ctttcu10),",","",.))) & !inlist(upper(strtrim(raw_ctttcu10)),"","***",".","NA","N/A","NULL","-")
replace vs_capital_additions_nominal=cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0)) if !missing(capital_additions_nominal)
* Hitung berapa baris capital_additions_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(capital_additions_nominal)
local obs=r(N)
quietly count if capital_additions_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_additions_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_additions_nominal==4
local absent=r(N)
post cell (2010) ("capital_additions_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, capital_additions_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row capital_additions_nominal vs_capital_additions_nominal raw_ctttcu10
isid source_year source_row
save "$VYD/N_G0_capital_additions_nominal_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_additions_nominal_2010"
log close vycell
