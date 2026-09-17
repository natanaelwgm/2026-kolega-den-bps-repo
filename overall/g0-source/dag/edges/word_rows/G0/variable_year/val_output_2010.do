* Tujuan: Untuk 2010, ubah raw_output10 menjadi val_output; vs_val_output mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/val_output_2010.do dari data/intermediate/raw_wave_2010.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_output_2010.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_val_output_2010: annual staged raw state -> val_output at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2010 row 130; output10 | total output, 000 rp
log using "$VYL/N_G0_val_output_2010.log", text replace name(vycell)
* Mulai val_output sebagai nilai kosong; vs_val_output mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2010. // WFDOC-INJECTED
generate double val_output=.
generate byte vs_val_output=3
* Baca raw_output10 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk val_output. // WFDOC-INJECTED
replace val_output=real(subinstr(strtrim(raw_output10),",","",.))*1
replace vs_val_output=5 if missing(real(subinstr(strtrim(raw_output10),",","",.))) & !inlist(upper(strtrim(raw_output10)),"","***",".","NA","N/A","NULL","-")
replace vs_val_output=cond(val_output<0,2,cond(val_output==0,1,0)) if !missing(val_output)
* Hitung berapa baris val_output yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(val_output)
local obs=r(N)
quietly count if val_output==0
local zeros=r(N)
quietly count if inlist(vs_val_output,5,6,8)
local bad=r(N)
quietly count if vs_val_output==4
local absent=r(N)
post cell (2010) ("val_output") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, val_output, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row val_output vs_val_output raw_output10
isid source_year source_row
save "$VYD/N_G0_val_output_2010.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_output_2010"
log close vycell
