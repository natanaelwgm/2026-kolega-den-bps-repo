* Tujuan: Untuk 2018, ubah raw_inoorg18 menjadi innovation_org_raw; vs_innovation_org_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/innovation_org_raw_2018.do dari data/intermediate/raw_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_innovation_org_raw_2018: annual staged raw state -> innovation_org_raw at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_innovation_org_raw_2018.log", text replace name(vycell)
* Mulai innovation_org_raw sebagai nilai kosong; vs_innovation_org_raw mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2018. // WFDOC-INJECTED
generate double innovation_org_raw=.
generate byte vs_innovation_org_raw=3
* Baca raw_inoorg18 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk innovation_org_raw. // WFDOC-INJECTED
replace innovation_org_raw=real(subinstr(strtrim(raw_inoorg18),",","",.))*1
replace vs_innovation_org_raw=5 if missing(real(subinstr(strtrim(raw_inoorg18),",","",.))) & !inlist(upper(strtrim(raw_inoorg18)),"","***",".","NA","N/A","NULL","-")
replace vs_innovation_org_raw=cond(innovation_org_raw<0,2,cond(innovation_org_raw==0,1,0)) if !missing(innovation_org_raw)
* Hitung berapa baris innovation_org_raw yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_org_raw)
local obs=r(N)
quietly count if innovation_org_raw==0
local zeros=r(N)
quietly count if inlist(vs_innovation_org_raw,5,6,8)
local bad=r(N)
quietly count if vs_innovation_org_raw==4
local absent=r(N)
post cell (2018) ("innovation_org_raw") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, innovation_org_raw, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_org_raw vs_innovation_org_raw raw_inoorg18
isid source_year source_row
save "$VYD/N_G0_innovation_org_raw_2018.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_innovation_org_raw_2018"
log close vycell
