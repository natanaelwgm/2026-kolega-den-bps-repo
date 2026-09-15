* Tujuan: Untuk 2022, ubah raw_efovce22 menjadi val_efovce; vs_val_efovce mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_efovce_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_efovce_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_efovce_2022: annual staged raw state -> val_efovce at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_efovce_2022.log", text replace name(vycell)
* Mulai val_efovce sebagai nilai kosong; vs_val_efovce mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double val_efovce=.
generate byte vs_val_efovce=3
* Baca raw_efovce22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_efovce. // WFDOC-INJECTED
replace val_efovce=real(subinstr(strtrim(raw_efovce22),",","",.))*1
replace vs_val_efovce=5 if missing(real(subinstr(strtrim(raw_efovce22),",","",.))) & !inlist(upper(strtrim(raw_efovce22)),"","***",".","NA","N/A","NULL","-")
replace vs_val_efovce=cond(val_efovce<0,2,cond(val_efovce==0,1,0)) if !missing(val_efovce)
* Hitung berapa baris val_efovce yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_efovce)
local obs=r(N)
quietly count if val_efovce==0
local zeros=r(N)
quietly count if inlist(vs_val_efovce,5,6,8)
local bad=r(N)
quietly count if vs_val_efovce==4
local absent=r(N)
post cell (2022) ("val_efovce") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_efovce, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_efovce vs_val_efovce raw_efovce22
isid source_year source_row
save "$VYD/N_G0_val_efovce_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_efovce_2022"
log close vycell
