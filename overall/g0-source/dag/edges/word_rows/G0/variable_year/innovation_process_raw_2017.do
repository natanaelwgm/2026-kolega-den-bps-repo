* Tujuan: Untuk 2017, ubah raw_inopcs17 menjadi innovation_process_raw; vs_innovation_process_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_process_raw_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_process_raw_2017: annual staged raw state -> innovation_process_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_process_raw_2017.log", text replace name(vycell)
* Mulai innovation_process_raw sebagai nilai kosong; vs_innovation_process_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double innovation_process_raw=.
generate byte vs_innovation_process_raw=3
* Baca raw_inopcs17 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk innovation_process_raw. // WFDOC-INJECTED
replace innovation_process_raw=real(subinstr(strtrim(raw_inopcs17),",","",.))*1
replace vs_innovation_process_raw=5 if missing(real(subinstr(strtrim(raw_inopcs17),",","",.))) & !inlist(upper(strtrim(raw_inopcs17)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_process_raw=cond(innovation_process_raw<0,2,cond(innovation_process_raw==0,1,0)) if !missing(innovation_process_raw)
* Hitung berapa baris innovation_process_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_process_raw)
local obs=r(N)
quietly count if innovation_process_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_process_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_process_raw==4
local absent=r(N)
post cell (2017) ("innovation_process_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_process_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_process_raw vs_innovation_process_raw raw_inopcs17
isid source_year source_row
save "$VYD/N_G0_innovation_process_raw_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_process_raw_2017"
log close vycell
