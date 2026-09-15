* Tujuan: Untuk 2014, ubah raw_cmsacu14 menjadi val_cmsacu; vs_val_cmsacu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_cmsacu_2014.do dari data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_cmsacu_2014: annual staged raw state -> val_cmsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2014 row 146; cmsacu14 | sale/reduce of mchn & eqp, 000 rp
log using "$VYL/N_G0_val_cmsacu_2014.log", text replace name(vycell)
* Mulai val_cmsacu sebagai nilai kosong; vs_val_cmsacu mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
generate double val_cmsacu=.
generate byte vs_val_cmsacu=3
* Baca raw_cmsacu14 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_cmsacu. // WFDOC-INJECTED
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu14),",","",.))*1
replace vs_val_cmsacu=5 if missing(real(subinstr(strtrim(raw_cmsacu14),",","",.))) & !inlist(upper(strtrim(raw_cmsacu14)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cmsacu=cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0)) if !missing(val_cmsacu)
* Hitung berapa baris val_cmsacu yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_cmsacu)
local obs=r(N)
quietly count if val_cmsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmsacu==4
local absent=r(N)
post cell (2014) ("val_cmsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_cmsacu, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_cmsacu vs_val_cmsacu raw_cmsacu14
isid source_year source_row
save "$VYD/N_G0_val_cmsacu_2014.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmsacu_2014"
log close vycell
