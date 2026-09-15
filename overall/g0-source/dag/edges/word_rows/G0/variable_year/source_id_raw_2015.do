* Tujuan: Untuk 2015, ubah raw_kip menjadi source_id_raw; vs_source_id_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/source_id_raw_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_source_id_raw_2015: annual staged raw state -> source_id_raw at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 5; kip15 | no kip 4 digit
log using "$VYL/N_G0_source_id_raw_2015.log", text replace name(vycell)
generate str64 source_id_raw=""
generate byte vs_source_id_raw=3
* Bentuk source_id_raw dari kolom sumber pada baris ini; aturan vs_source_id_raw di bawah mempertahankan perbedaan status. // WFDOC-INJECTED
replace source_id_raw=strtrim(raw_kip)
replace source_id_raw="" if inlist(upper(source_id_raw),"***",".","NA","N/A","NULL","-")
replace vs_source_id_raw=0 if source_id_raw!=""
* Hitung berapa baris source_id_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(source_id_raw)
local obs=r(N)
quietly count if 0
local zeros=r(N)
quietly count if inlist(vs_source_id_raw,5,6,8)
local bad=r(N)
quietly count if vs_source_id_raw==4
local absent=r(N)
post cell (2015) ("source_id_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, source_id_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row source_id_raw vs_source_id_raw raw_kip
isid source_year source_row
save "$VYD/N_G0_source_id_raw_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_source_id_raw_2015"
log close vycell
