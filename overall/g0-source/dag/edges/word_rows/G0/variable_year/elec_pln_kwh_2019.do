* Tujuan: Untuk 2019, ubah raw_eplkhu19 menjadi elec_pln_kwh; vs_elec_pln_kwh mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/elec_pln_kwh_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_elec_pln_kwh_2019: annual staged raw state -> elec_pln_kwh at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_pln_kwh_2019.log", text replace name(vycell)
* Mulai elec_pln_kwh sebagai nilai kosong; vs_elec_pln_kwh mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double elec_pln_kwh=.
generate byte vs_elec_pln_kwh=3
* Baca raw_eplkhu19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk elec_pln_kwh. // WFDOC-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu19),",","",.))*1
replace vs_elec_pln_kwh=5 if missing(real(subinstr(strtrim(raw_eplkhu19),",","",.))) & !inlist(upper(strtrim(raw_eplkhu19)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_pln_kwh=cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0)) if !missing(elec_pln_kwh)
* Hitung berapa baris elec_pln_kwh yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(elec_pln_kwh)
local obs=r(N)
quietly count if elec_pln_kwh==0
local zeros=r(N)
quietly count if inlist(vs_elec_pln_kwh,5,6,8)
local bad=r(N)
quietly count if vs_elec_pln_kwh==4
local absent=r(N)
post cell (2019) ("elec_pln_kwh") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, elec_pln_kwh, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row elec_pln_kwh vs_elec_pln_kwh raw_eplkhu19
isid source_year source_row
save "$VYD/N_G0_elec_pln_kwh_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_pln_kwh_2019"
log close vycell
