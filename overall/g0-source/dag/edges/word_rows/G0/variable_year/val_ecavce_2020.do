* Tujuan: Untuk 2020, ubah raw_ecavce20 menjadi val_ecavce; vs_val_ecavce mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_ecavce_2020.do dari data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_ecavce_2020: annual staged raw state -> val_ecavce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ecavce_2020.log", text replace name(vycell)
* Mulai val_ecavce sebagai nilai kosong; vs_val_ecavce mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
generate double val_ecavce=.
generate byte vs_val_ecavce=3
* Baca raw_ecavce20 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_ecavce. // WFDOC-INJECTED
replace val_ecavce=real(subinstr(strtrim(raw_ecavce20),",","",.))*1
replace vs_val_ecavce=5 if missing(real(subinstr(strtrim(raw_ecavce20),",","",.))) & !inlist(upper(strtrim(raw_ecavce20)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ecavce=cond(val_ecavce<0,2,cond(val_ecavce==0,1,0)) if !missing(val_ecavce)
* Hitung berapa baris val_ecavce yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_ecavce)
local obs=r(N)
quietly count if val_ecavce==0
local zeros=r(N)
quietly count if inlist(vs_val_ecavce,5,6,8)
local bad=r(N)
quietly count if vs_val_ecavce==4
local absent=r(N)
post cell (2020) ("val_ecavce") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_ecavce, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_ecavce vs_val_ecavce raw_ecavce20
isid source_year source_row
save "$VYD/N_G0_val_ecavce_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ecavce_2020"
log close vycell
