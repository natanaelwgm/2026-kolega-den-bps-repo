* Tujuan: Untuk 2011, ubah raw_dasing11 menjadi foreign_ownership_pct; vs_foreign_ownership_pct mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/foreign_ownership_pct_2011.do dari data/intermediate/raw_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_foreign_ownership_pct_2011: annual staged raw state -> foreign_ownership_pct at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 9; dasing11 | pct of capital owned by foreign
log using "$VYL/N_G0_foreign_ownership_pct_2011.log", text replace name(vycell)
* Mulai foreign_ownership_pct sebagai nilai kosong; vs_foreign_ownership_pct mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
generate double foreign_ownership_pct=.
generate byte vs_foreign_ownership_pct=3
* Baca raw_dasing11 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk foreign_ownership_pct. // WFDOC-INJECTED
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing11),",","",.))*1
replace vs_foreign_ownership_pct=5 if missing(real(subinstr(strtrim(raw_dasing11),",","",.))) & !inlist(upper(strtrim(raw_dasing11)),"","***",".","NA","N/A","NULL","-")
replace vs_foreign_ownership_pct=cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0)) if !missing(foreign_ownership_pct)
* Hitung berapa baris foreign_ownership_pct yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(foreign_ownership_pct)
local obs=r(N)
quietly count if foreign_ownership_pct==0
local zeros=r(N)
quietly count if inlist(vs_foreign_ownership_pct,5,6,8)
local bad=r(N)
quietly count if vs_foreign_ownership_pct==4
local absent=r(N)
post cell (2011) ("foreign_ownership_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, foreign_ownership_pct, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row foreign_ownership_pct vs_foreign_ownership_pct raw_dasing11
isid source_year source_row
save "$VYD/N_G0_foreign_ownership_pct_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_foreign_ownership_pct_2011"
log close vycell
