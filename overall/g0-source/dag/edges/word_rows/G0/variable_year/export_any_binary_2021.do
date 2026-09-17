* Tujuan: Untuk 2021, ubah raw_ekspor21 menjadi export_any_binary; vs_export_any_binary mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_any_binary_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_export_any_binary_2021: annual staged raw state -> export_any_binary at source_year/source_row.
* Evidence: 2010–15 legacy layout EKSPOR 1 yes 2 no; 2020 BPS questionnaire reproduction Q402a; 2021 Lampung PDF p92 Q402a. Own or third-party export. 2022 direct-export question belongs to separate field.
log using "$VYL/N_G0_export_any_binary_2021.log", text replace name(vycell)
* Mulai export_any_binary sebagai nilai kosong; vs_export_any_binary mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double export_any_binary=.
generate byte vs_export_any_binary=3
* Baca raw_ekspor21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk export_any_binary. // WFDOC-INJECTED
replace export_any_binary=(real(subinstr(strtrim(raw_ekspor21),",","",.))==1) if inlist(real(subinstr(strtrim(raw_ekspor21),",","",.)),1,2)
replace vs_export_any_binary=6 if !missing(real(subinstr(strtrim(raw_ekspor21),",","",.))) & !(inlist(real(subinstr(strtrim(raw_ekspor21),",","",.)),1,2))
replace vs_export_any_binary=cond(export_any_binary<0,2,cond(export_any_binary==0,1,0)) if !missing(export_any_binary)
* Hitung berapa baris export_any_binary yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_any_binary)
local obs=r(N)
quietly count if export_any_binary==0
local zeros=r(N)
quietly count if inlist(vs_export_any_binary,5,6,8)
local bad=r(N)
quietly count if vs_export_any_binary==4
local absent=r(N)
post cell (2021) ("export_any_binary") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, export_any_binary, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_any_binary vs_export_any_binary raw_ekspor21
isid source_year source_row
save "$VYD/N_G0_export_any_binary_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_any_binary_2021"
log close vycell
