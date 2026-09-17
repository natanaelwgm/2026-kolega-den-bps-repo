* Tujuan: Untuk 2020, ubah raw_spplhi20 menjadi spplhi_raw; vs_spplhi_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/spplhi_raw_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_spplhi_raw_2020: annual staged raw state -> spplhi_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_spplhi_raw_2020.log", text replace name(vycell)
* Mulai spplhi_raw sebagai nilai kosong; vs_spplhi_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double spplhi_raw=.
generate byte vs_spplhi_raw=3
* Baca raw_spplhi20 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk spplhi_raw. // WFDOC-INJECTED
replace spplhi_raw=real(subinstr(strtrim(raw_spplhi20),",","",.))*1
replace vs_spplhi_raw=5 if missing(real(subinstr(strtrim(raw_spplhi20),",","",.))) & !inlist(upper(strtrim(raw_spplhi20)),"","***",".","NA","N/A","NULL","-")
replace vs_spplhi_raw=cond(spplhi_raw<0,2,cond(spplhi_raw==0,1,0)) if !missing(spplhi_raw)
* Hitung berapa baris spplhi_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(spplhi_raw)
local obs=r(N)
quietly count if spplhi_raw==0
local zeros=r(N)
quietly count if inlist(vs_spplhi_raw,5,6,8)
local bad=r(N)
quietly count if vs_spplhi_raw==4
local absent=r(N)
post cell (2020) ("spplhi_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, spplhi_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row spplhi_raw vs_spplhi_raw raw_spplhi20
isid source_year source_row
save "$VYD/N_G0_spplhi_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_spplhi_raw_2020"
log close vycell
