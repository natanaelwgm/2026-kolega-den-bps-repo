* Tujuan: Untuk 2019, ubah raw_prprex19 menjadi export_share_pct; vs_export_share_pct mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/export_share_pct_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_export_share_pct_2019: annual staged raw state -> export_share_pct at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_export_share_pct_2019.log", text replace name(vycell)
* Mulai export_share_pct sebagai nilai kosong; vs_export_share_pct mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double export_share_pct=.
generate byte vs_export_share_pct=3
* Baca raw_prprex19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk export_share_pct. // WFDOC-INJECTED
replace export_share_pct=real(subinstr(strtrim(raw_prprex19),",","",.))*1
replace vs_export_share_pct=5 if missing(real(subinstr(strtrim(raw_prprex19),",","",.))) & !inlist(upper(strtrim(raw_prprex19)),"","***",".","NA","N/A","NULL","-")
replace vs_export_share_pct=cond(export_share_pct<0,2,cond(export_share_pct==0,1,0)) if !missing(export_share_pct)
* Hitung berapa baris export_share_pct yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_share_pct)
local obs=r(N)
quietly count if export_share_pct==0
local zeros=r(N)
quietly count if inlist(vs_export_share_pct,5,6,8)
local bad=r(N)
quietly count if vs_export_share_pct==4
local absent=r(N)
post cell (2019) ("export_share_pct") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, export_share_pct, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_share_pct vs_export_share_pct raw_prprex19
isid source_year source_row
save "$VYD/N_G0_export_share_pct_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_export_share_pct_2019"
log close vycell
