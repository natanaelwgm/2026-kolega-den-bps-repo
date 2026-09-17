* Tujuan: Untuk 2022, ubah raw_inspli22 menjadi inspli_raw; vs_inspli_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/inspli_raw_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_inspli_raw_2022: annual staged raw state -> inspli_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_inspli_raw_2022.log", text replace name(vycell)
* Mulai inspli_raw sebagai nilai kosong; vs_inspli_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double inspli_raw=.
generate byte vs_inspli_raw=3
* Baca raw_inspli22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk inspli_raw. // WFDOC-INJECTED
replace inspli_raw=real(subinstr(strtrim(raw_inspli22),",","",.))*1
replace vs_inspli_raw=5 if missing(real(subinstr(strtrim(raw_inspli22),",","",.))) & !inlist(upper(strtrim(raw_inspli22)),"","***",".","NA","N/A","NULL","-")
replace vs_inspli_raw=cond(inspli_raw<0,2,cond(inspli_raw==0,1,0)) if !missing(inspli_raw)
* Hitung berapa baris inspli_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(inspli_raw)
local obs=r(N)
quietly count if inspli_raw==0
local zeros=r(N)
quietly count if inlist(vs_inspli_raw,5,6,8)
local bad=r(N)
quietly count if vs_inspli_raw==4
local absent=r(N)
post cell (2022) ("inspli_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, inspli_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row inspli_raw vs_inspli_raw raw_inspli22
isid source_year source_row
save "$VYD/N_G0_inspli_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_inspli_raw_2022"
log close vycell
