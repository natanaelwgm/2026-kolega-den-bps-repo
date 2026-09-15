* Tujuan: Untuk 2021, ubah raw_ekspor21 menjadi export_binary_raw; vs_export_binary_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_binary_raw_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_export_binary_raw_2021: annual staged raw state -> export_binary_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_export_binary_raw_2021.log", text replace name(vycell)
* Mulai export_binary_raw sebagai nilai kosong; vs_export_binary_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double export_binary_raw=.
generate byte vs_export_binary_raw=3
* Baca raw_ekspor21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk export_binary_raw. // WFDOC-INJECTED
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor21),",","",.))*1
replace vs_export_binary_raw=5 if missing(real(subinstr(strtrim(raw_ekspor21),",","",.))) & !inlist(upper(strtrim(raw_ekspor21)),"","***",".","NA","N/A","NULL","-")
replace vs_export_binary_raw=cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0)) if !missing(export_binary_raw)
* Hitung berapa baris export_binary_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_binary_raw)
local obs=r(N)
quietly count if export_binary_raw==0
local zeros=r(N)
quietly count if inlist(vs_export_binary_raw,5,6,8)
local bad=r(N)
quietly count if vs_export_binary_raw==4
local absent=r(N)
post cell (2021) ("export_binary_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, export_binary_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_binary_raw vs_export_binary_raw raw_ekspor21
isid source_year source_row
save "$VYD/N_G0_export_binary_raw_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_binary_raw_2021"
log close vycell
