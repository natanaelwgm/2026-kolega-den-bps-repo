* Tujuan: Untuk 2018, ubah raw_inomkt18 menjadi innovation_marketing_raw; vs_innovation_marketing_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_marketing_raw_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_marketing_raw_2018: annual staged raw state -> innovation_marketing_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_marketing_raw_2018.log", text replace name(vycell)
* Mulai innovation_marketing_raw sebagai nilai kosong; vs_innovation_marketing_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double innovation_marketing_raw=.
generate byte vs_innovation_marketing_raw=3
* Baca raw_inomkt18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk innovation_marketing_raw. // WFDOC-INJECTED
replace innovation_marketing_raw=real(subinstr(strtrim(raw_inomkt18),",","",.))*1
replace vs_innovation_marketing_raw=5 if missing(real(subinstr(strtrim(raw_inomkt18),",","",.))) & !inlist(upper(strtrim(raw_inomkt18)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_marketing_raw=cond(innovation_marketing_raw<0,2,cond(innovation_marketing_raw==0,1,0)) if !missing(innovation_marketing_raw)
* Hitung berapa baris innovation_marketing_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_marketing_raw)
local obs=r(N)
quietly count if innovation_marketing_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_marketing_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_marketing_raw==4
local absent=r(N)
post cell (2018) ("innovation_marketing_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_marketing_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_marketing_raw vs_innovation_marketing_raw raw_inomkt18
isid source_year source_row
save "$VYD/N_G0_innovation_marketing_raw_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_marketing_raw_2018"
log close vycell
