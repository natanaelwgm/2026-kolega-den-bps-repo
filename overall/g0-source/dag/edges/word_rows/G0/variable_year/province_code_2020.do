* Tujuan: Untuk 2020, ubah raw_dprovi20 menjadi province_code; vs_province_code mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/province_code_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_province_code_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_province_code_2020: annual staged raw state -> province_code at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_province_code_2020.log", text replace name(vycell)
generate str64 province_code=""
generate byte vs_province_code=3
* Bentuk province_code dari kolom sumber pada baris ini; aturan vs_province_code di bawah mempertahankan perbedaan status. // WFDOC-INJECTED
replace province_code=strtrim(raw_dprovi20)
replace province_code="" if inlist(upper(province_code),"***",".","NA","N/A","NULL","-")
replace vs_province_code=0 if province_code!=""
* Hitung berapa baris province_code yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(province_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_province_code,5,6,8)
local bad=r(N)
quietly count if vs_province_code==4
local absent=r(N)
post cell (2020) ("province_code") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, province_code, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row province_code vs_province_code raw_dprovi20
isid source_year source_row
save "$VYD/N_G0_province_code_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_province_code_2020"
log close vycell
