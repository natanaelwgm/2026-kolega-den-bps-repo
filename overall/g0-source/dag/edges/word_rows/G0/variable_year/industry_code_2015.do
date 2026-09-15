* Tujuan: Untuk 2015, ubah raw_disic5 menjadi industry_code; vs_industry_code mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/industry_code_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_industry_code_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_industry_code_2015: annual staged raw state -> industry_code at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 11; disic515 | isic5-klui 2009
log using "$VYL/N_G0_industry_code_2015.log", text replace name(vycell)
generate str64 industry_code=""
generate byte vs_industry_code=3
* Bentuk industry_code dari kolom sumber pada baris ini; aturan vs_industry_code di bawah mempertahankan perbedaan status. // WFDOC-INJECTED
replace industry_code=strtrim(raw_disic5)
replace industry_code="" if inlist(upper(industry_code),"***",".","NA","N/A","NULL","-")
replace vs_industry_code=0 if industry_code!=""
* Hitung berapa baris industry_code yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(industry_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_industry_code,5,6,8)
local bad=r(N)
quietly count if vs_industry_code==4
local absent=r(N)
post cell (2015) ("industry_code") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, industry_code, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row industry_code vs_industry_code raw_disic5
isid source_year source_row
save "$VYD/N_G0_industry_code_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_industry_code_2015"
log close vycell
