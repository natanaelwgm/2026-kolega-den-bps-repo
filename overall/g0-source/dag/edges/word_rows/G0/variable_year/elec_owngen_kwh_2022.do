* Tujuan: Untuk 2022, ubah raw_esgkhu22 menjadi elec_owngen_kwh; vs_elec_owngen_kwh mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/elec_owngen_kwh_2022.do dari data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_elec_owngen_kwh_2022: annual staged raw state -> elec_owngen_kwh at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_owngen_kwh_2022.log", text replace name(vycell)
* Mulai elec_owngen_kwh sebagai nilai kosong; vs_elec_owngen_kwh mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double elec_owngen_kwh=.
generate byte vs_elec_owngen_kwh=3
* Baca raw_esgkhu22 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk elec_owngen_kwh. // WFDOC-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu22),",","",.))*1
replace vs_elec_owngen_kwh=5 if missing(real(subinstr(strtrim(raw_esgkhu22),",","",.))) & !inlist(upper(strtrim(raw_esgkhu22)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_owngen_kwh=cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0)) if !missing(elec_owngen_kwh)
* Hitung berapa baris elec_owngen_kwh yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(elec_owngen_kwh)
local obs=r(N)
quietly count if elec_owngen_kwh==0
local zeros=r(N)
quietly count if inlist(vs_elec_owngen_kwh,5,6,8)
local bad=r(N)
quietly count if vs_elec_owngen_kwh==4
local absent=r(N)
post cell (2022) ("elec_owngen_kwh") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, elec_owngen_kwh, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row elec_owngen_kwh vs_elec_owngen_kwh raw_esgkhu22
isid source_year source_row
save "$VYD/N_G0_elec_owngen_kwh_2022.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_owngen_kwh_2022"
log close vycell
