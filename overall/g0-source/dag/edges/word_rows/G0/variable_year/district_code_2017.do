* Tujuan: Untuk 2017, ubah raw_dkabup17 menjadi district_code; vs_district_code mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/district_code_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_district_code_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_district_code_2017: annual staged raw state -> district_code at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_district_code_2017.log", text replace name(vycell)
generate str64 district_code=""
generate byte vs_district_code=3
* Bentuk district_code dari kolom sumber pada baris ini; aturan vs_district_code di bawah mempertahankan perbedaan status. // WFDOC-INJECTED
replace district_code=strtrim(raw_dkabup17)
replace district_code="" if inlist(upper(district_code),"***",".","NA","N/A","NULL","-")
replace vs_district_code=0 if district_code!=""
* Hitung berapa baris district_code yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(district_code)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_district_code,5,6,8)
local bad=r(N)
quietly count if vs_district_code==4
local absent=r(N)
post cell (2017) ("district_code") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, district_code, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row district_code vs_district_code raw_dkabup17
isid source_year source_row
save "$VYD/N_G0_district_code_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_district_code_2017"
log close vycell
