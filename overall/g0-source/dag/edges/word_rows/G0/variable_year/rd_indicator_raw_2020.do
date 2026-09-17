* Tujuan: Untuk 2020, ambil jawaban pertanyaan R&D dari raw_rnd20; ini kolom jawaban, bukan kolom biaya. vs_rd_indicator_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/rd_indicator_raw_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_rd_indicator_raw_2020: annual staged raw state -> rd_indicator_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_rd_indicator_raw_2020.log", text replace name(vycell)
* Mulai rd_indicator_raw sebagai nilai kosong; vs_rd_indicator_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double rd_indicator_raw=.
generate byte vs_rd_indicator_raw=3
* Baca raw_rnd20 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk rd_indicator_raw. // WFDOC-INJECTED
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd20),",","",.))*1
replace vs_rd_indicator_raw=5 if missing(real(subinstr(strtrim(raw_rnd20),",","",.))) & !inlist(upper(strtrim(raw_rnd20)),"","***",".","NA","N/A","NULL","-")
replace vs_rd_indicator_raw=cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0)) if !missing(rd_indicator_raw)
* Hitung berapa baris rd_indicator_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_indicator_raw)
local obs=r(N)
quietly count if rd_indicator_raw==0
local zeros=r(N)
quietly count if inlist(vs_rd_indicator_raw,5,6,8)
local bad=r(N)
quietly count if vs_rd_indicator_raw==4
local absent=r(N)
post cell (2020) ("rd_indicator_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, rd_indicator_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_indicator_raw vs_rd_indicator_raw raw_rnd20
isid source_year source_row
save "$VYD/N_G0_rd_indicator_raw_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_indicator_raw_2020"
log close vycell
