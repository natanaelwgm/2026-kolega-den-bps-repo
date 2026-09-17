* Tujuan: Untuk 2021, ubah raw_ctttcu21 menjadi capital_nominal; vs_capital_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/capital_nominal_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_capital_nominal_2021: annual staged raw state -> capital_nominal at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_capital_nominal_2021.log", text replace name(vycell)
* Mulai capital_nominal sebagai nilai kosong; vs_capital_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double capital_nominal=.
generate byte vs_capital_nominal=3
* Baca raw_ctttcu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk capital_nominal. // WFDOC-INJECTED
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu21),",","",.))*1
replace vs_capital_nominal=5 if missing(real(subinstr(strtrim(raw_ctttcu21),",","",.))) & !inlist(upper(strtrim(raw_ctttcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_capital_nominal=cond(capital_nominal<0,2,cond(capital_nominal==0,1,0)) if !missing(capital_nominal)
* Hitung berapa baris capital_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(capital_nominal)
local obs=r(N)
quietly count if capital_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_nominal==4
local absent=r(N)
post cell (2021) ("capital_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, capital_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row capital_nominal vs_capital_nominal raw_ctttcu21
isid source_year source_row
save "$VYD/N_G0_capital_nominal_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_nominal_2021"
log close vycell
