* Tujuan: Untuk 2022, ubah raw_sowste22 menjadi sowste_raw; vs_sowste_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/sowste_raw_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_sowste_raw_2022: annual staged raw state -> sowste_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_sowste_raw_2022.log", text replace name(vycell)
* Mulai sowste_raw sebagai nilai kosong; vs_sowste_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double sowste_raw=.
generate byte vs_sowste_raw=3
* Baca raw_sowste22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk sowste_raw. // WFDOC-INJECTED
replace sowste_raw=real(subinstr(strtrim(raw_sowste22),",","",.))*1
replace vs_sowste_raw=5 if missing(real(subinstr(strtrim(raw_sowste22),",","",.))) & !inlist(upper(strtrim(raw_sowste22)),"","***",".","NA","N/A","NULL","-")
replace vs_sowste_raw=cond(sowste_raw<0,2,cond(sowste_raw==0,1,0)) if !missing(sowste_raw)
* Hitung berapa baris sowste_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(sowste_raw)
local obs=r(N)
quietly count if sowste_raw==0
local zeros=r(N)
quietly count if inlist(vs_sowste_raw,5,6,8)
local bad=r(N)
quietly count if vs_sowste_raw==4
local absent=r(N)
post cell (2022) ("sowste_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, sowste_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row sowste_raw vs_sowste_raw raw_sowste22
isid source_year source_row
save "$VYD/N_G0_sowste_raw_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_sowste_raw_2022"
log close vycell
