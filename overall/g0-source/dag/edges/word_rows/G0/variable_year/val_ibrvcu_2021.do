* Tujuan: Untuk 2021, ubah raw_ibrvcu21 menjadi val_ibrvcu; vs_val_ibrvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_ibrvcu_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_ibrvcu_2021: annual staged raw state -> val_ibrvcu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_ibrvcu_2021.log", text replace name(vycell)
* Mulai val_ibrvcu sebagai nilai kosong; vs_val_ibrvcu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double val_ibrvcu=.
generate byte vs_val_ibrvcu=3
* Baca raw_ibrvcu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_ibrvcu. // WFDOC-INJECTED
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu21),",","",.))*1
replace vs_val_ibrvcu=5 if missing(real(subinstr(strtrim(raw_ibrvcu21),",","",.))) & !inlist(upper(strtrim(raw_ibrvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_val_ibrvcu=cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0)) if !missing(val_ibrvcu)
* Hitung berapa baris val_ibrvcu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_ibrvcu)
local obs=r(N)
quietly count if val_ibrvcu==0
local zeros=r(N)
quietly count if inlist(vs_val_ibrvcu,5,6,8)
local bad=r(N)
quietly count if vs_val_ibrvcu==4
local absent=r(N)
post cell (2021) ("val_ibrvcu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_ibrvcu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_ibrvcu vs_val_ibrvcu raw_ibrvcu21
isid source_year source_row
save "$VYD/N_G0_val_ibrvcu_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_ibrvcu_2021"
log close vycell
