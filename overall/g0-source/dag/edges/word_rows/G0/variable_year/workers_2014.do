* Tujuan: Untuk 2014, ubah raw_ltlnou14 menjadi workers; vs_workers mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/workers_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_workers_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_workers_2014: annual staged raw state -> workers at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 40; ltlnou14 | total workers
log using "$VYL/N_G0_workers_2014.log", text replace name(vycell)
* Mulai workers sebagai nilai kosong; vs_workers mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double workers=.
generate byte vs_workers=3
* Baca raw_ltlnou14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk workers. // WFDOC-INJECTED
replace workers=real(subinstr(strtrim(raw_ltlnou14),",","",.))*1
replace vs_workers=5 if missing(real(subinstr(strtrim(raw_ltlnou14),",","",.))) & !inlist(upper(strtrim(raw_ltlnou14)),"","***",".","NA","N/A","NULL","-")
replace vs_workers=cond(workers<0,2,cond(workers==0,1,0)) if !missing(workers)
* Hitung berapa baris workers yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(workers)
local obs=r(N)
quietly count if workers==0
local zeros=r(N)
quietly count if inlist(vs_workers,5,6,8)
local bad=r(N)
quietly count if vs_workers==4
local absent=r(N)
post cell (2014) ("workers") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, workers, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row workers vs_workers raw_ltlnou14
isid source_year source_row
save "$VYD/N_G0_workers_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_workers_2014"
log close vycell
