* Tujuan: Untuk 2019, ubah raw_v1115 menjadi capital_stock_nominal; vs_capital_stock_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/capital_stock_nominal_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_capital_stock_nominal_2019: annual staged raw state -> capital_stock_nominal at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_capital_stock_nominal_2019.log", text replace name(vycell)
* Mulai capital_stock_nominal sebagai nilai kosong; vs_capital_stock_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double capital_stock_nominal=.
generate byte vs_capital_stock_nominal=3
* Baca raw_v1115 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk capital_stock_nominal. // WFDOC-INJECTED
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.))*1
replace vs_capital_stock_nominal=5 if missing(real(subinstr(strtrim(raw_v1115),",","",.))) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace vs_capital_stock_nominal=cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0)) if !missing(capital_stock_nominal)
* Hitung berapa baris capital_stock_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(capital_stock_nominal)
local obs=r(N)
quietly count if capital_stock_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_stock_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_stock_nominal==4
local absent=r(N)
post cell (2019) ("capital_stock_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, capital_stock_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row capital_stock_nominal vs_capital_stock_nominal raw_v1115
isid source_year source_row
save "$VYD/N_G0_capital_stock_nominal_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_stock_nominal_2019"
log close vycell
