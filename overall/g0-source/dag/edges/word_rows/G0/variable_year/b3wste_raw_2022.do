* Tujuan: Untuk 2022, ubah raw_b3wste22 menjadi b3wste_raw; vs_b3wste_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/b3wste_raw_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_b3wste_raw_2022: annual staged raw state -> b3wste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_b3wste_raw_2022.log", text replace name(vycell)
* Mulai b3wste_raw sebagai nilai kosong; vs_b3wste_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double b3wste_raw=.
generate byte vs_b3wste_raw=3
* Baca raw_b3wste22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk b3wste_raw. // WFDOC-INJECTED
replace b3wste_raw=real(subinstr(strtrim(raw_b3wste22),",","",.))*1
replace vs_b3wste_raw=5 if missing(real(subinstr(strtrim(raw_b3wste22),",","",.))) & !inlist(upper(strtrim(raw_b3wste22)),"","***",".","NA","N/A","NULL","-")
replace vs_b3wste_raw=cond(b3wste_raw<0,2,cond(b3wste_raw==0,1,0)) if !missing(b3wste_raw)
* Hitung berapa baris b3wste_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(b3wste_raw)
local obs=r(N)
quietly count if b3wste_raw==0
local zeros=r(N)
quietly count if inlist(vs_b3wste_raw,5,6,8)
local bad=r(N)
quietly count if vs_b3wste_raw==4
local absent=r(N)
post cell (2022) ("b3wste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, b3wste_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row b3wste_raw vs_b3wste_raw raw_b3wste22
isid source_year source_row
save "$VYD/N_G0_b3wste_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_b3wste_raw_2022"
log close vycell
