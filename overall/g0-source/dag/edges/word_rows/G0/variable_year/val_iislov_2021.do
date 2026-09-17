* Tujuan: Untuk 2021, ubah raw_iislov21 menjadi val_iislov; vs_val_iislov mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_iislov_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_iislov_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_iislov_2021: annual staged raw state -> val_iislov at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_iislov_2021.log", text replace name(vycell)
* Mulai val_iislov sebagai nilai kosong; vs_val_iislov mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double val_iislov=.
generate byte vs_val_iislov=3
* Baca raw_iislov21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_iislov. // WFDOC-INJECTED
replace val_iislov=real(subinstr(strtrim(raw_iislov21),",","",.))*1
replace vs_val_iislov=5 if missing(real(subinstr(strtrim(raw_iislov21),",","",.))) & !inlist(upper(strtrim(raw_iislov21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_iislov=cond(val_iislov<0,2,cond(val_iislov==0,1,0)) if !missing(val_iislov)
* Hitung berapa baris val_iislov yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_iislov)
local obs=r(N)
quietly count if val_iislov==0
local zeros=r(N)
quietly count if inlist(vs_val_iislov,5,6,8)
local bad=r(N)
quietly count if vs_val_iislov==4
local absent=r(N)
post cell (2021) ("val_iislov") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_iislov, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_iislov vs_val_iislov raw_iislov21
isid source_year source_row
save "$VYD/N_G0_val_iislov_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_iislov_2021"
log close vycell
