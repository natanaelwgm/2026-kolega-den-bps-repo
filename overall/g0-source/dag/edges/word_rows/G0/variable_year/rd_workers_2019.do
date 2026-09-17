* Tujuan: Untuk 2019, ubah raw_ltlrnd19 menjadi rd_workers; vs_rd_workers mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/rd_workers_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_rd_workers_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_rd_workers_2019: annual staged raw state -> rd_workers at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_rd_workers_2019.log", text replace name(vycell)
* Mulai rd_workers sebagai nilai kosong; vs_rd_workers mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double rd_workers=.
generate byte vs_rd_workers=3
* Baca raw_ltlrnd19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk rd_workers. // WFDOC-INJECTED
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd19),",","",.))*1
replace vs_rd_workers=5 if missing(real(subinstr(strtrim(raw_ltlrnd19),",","",.))) & !inlist(upper(strtrim(raw_ltlrnd19)),"","***",".","NA","N/A","NULL","-")
replace vs_rd_workers=cond(rd_workers<0,2,cond(rd_workers==0,1,0)) if !missing(rd_workers)
* Hitung berapa baris rd_workers yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_workers)
local obs=r(N)
quietly count if rd_workers==0
local zeros=r(N)
quietly count if inlist(vs_rd_workers,5,6,8)
local bad=r(N)
quietly count if vs_rd_workers==4
local absent=r(N)
post cell (2019) ("rd_workers") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, rd_workers, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_workers vs_rd_workers raw_ltlrnd19
isid source_year source_row
save "$VYD/N_G0_rd_workers_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_workers_2019"
log close vycell
