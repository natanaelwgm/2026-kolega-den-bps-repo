* Tujuan: Untuk 2019, ubah raw_costrd19 menjadi val_costrd; vs_val_costrd mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_costrd_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_costrd_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_costrd_2019: annual staged raw state -> val_costrd at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_costrd_2019.log", text replace name(vycell)
* Mulai val_costrd sebagai nilai kosong; vs_val_costrd mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double val_costrd=.
generate byte vs_val_costrd=3
* Baca raw_costrd19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_costrd. // WFDOC-INJECTED
replace val_costrd=real(subinstr(strtrim(raw_costrd19),",","",.))*1
replace vs_val_costrd=5 if missing(real(subinstr(strtrim(raw_costrd19),",","",.))) & !inlist(upper(strtrim(raw_costrd19)),"","***",".","NA","N/A","NULL","-")
replace vs_val_costrd=cond(val_costrd<0,2,cond(val_costrd==0,1,0)) if !missing(val_costrd)
* Hitung berapa baris val_costrd yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_costrd)
local obs=r(N)
quietly count if val_costrd==0
local zeros=r(N)
quietly count if inlist(vs_val_costrd,5,6,8)
local bad=r(N)
quietly count if vs_val_costrd==4
local absent=r(N)
post cell (2019) ("val_costrd") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_costrd, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_costrd vs_val_costrd raw_costrd19
isid source_year source_row
save "$VYD/N_G0_val_costrd_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_costrd_2019"
log close vycell
