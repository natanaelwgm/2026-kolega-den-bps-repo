* Tujuan: Untuk 2014, ubah raw_lprnou14 menjadi production_workers; vs_production_workers mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/production_workers_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_production_workers_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_production_workers_2014: annual staged raw state -> production_workers at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 37; lprnou14 | total prodoction workers
log using "$VYL/N_G0_production_workers_2014.log", text replace name(vycell)
* Mulai production_workers sebagai nilai kosong; vs_production_workers mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double production_workers=.
generate byte vs_production_workers=3
* Baca raw_lprnou14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk production_workers. // WFDOC-INJECTED
replace production_workers=real(subinstr(strtrim(raw_lprnou14),",","",.))*1
replace vs_production_workers=5 if missing(real(subinstr(strtrim(raw_lprnou14),",","",.))) & !inlist(upper(strtrim(raw_lprnou14)),"","***",".","NA","N/A","NULL","-")
replace vs_production_workers=cond(production_workers<0,2,cond(production_workers==0,1,0)) if !missing(production_workers)
* Hitung berapa baris production_workers yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(production_workers)
local obs=r(N)
quietly count if production_workers==0
local zeros=r(N)
quietly count if inlist(vs_production_workers,5,6,8)
local bad=r(N)
quietly count if vs_production_workers==4
local absent=r(N)
post cell (2014) ("production_workers") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, production_workers, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row production_workers vs_production_workers raw_lprnou14
isid source_year source_row
save "$VYD/N_G0_production_workers_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_production_workers_2014"
log close vycell
