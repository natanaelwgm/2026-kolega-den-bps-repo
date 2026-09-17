* Tujuan: Untuk 2021, ubah raw_enpvcu21 menjadi elec_nonpln_rp000; vs_elec_nonpln_rp000 mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/elec_nonpln_rp000_2021.do dari data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_elec_nonpln_rp000_2021: annual staged raw state -> elec_nonpln_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_elec_nonpln_rp000_2021.log", text replace name(vycell)
* Mulai elec_nonpln_rp000 sebagai nilai kosong; vs_elec_nonpln_rp000 mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
generate double elec_nonpln_rp000=.
generate byte vs_elec_nonpln_rp000=3
* Baca raw_enpvcu21 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk elec_nonpln_rp000. // WFDOC-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu21),",","",.))*1
replace vs_elec_nonpln_rp000=5 if missing(real(subinstr(strtrim(raw_enpvcu21),",","",.))) & !inlist(upper(strtrim(raw_enpvcu21)),"","***",".","NA","N/A","NULL","-")
replace vs_elec_nonpln_rp000=cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0)) if !missing(elec_nonpln_rp000)
* Hitung berapa baris elec_nonpln_rp000 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(elec_nonpln_rp000)
local obs=r(N)
quietly count if elec_nonpln_rp000==0
local zeros=r(N)
quietly count if inlist(vs_elec_nonpln_rp000,5,6,8)
local bad=r(N)
quietly count if vs_elec_nonpln_rp000==4
local absent=r(N)
post cell (2021) ("elec_nonpln_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, elec_nonpln_rp000, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row elec_nonpln_rp000 vs_elec_nonpln_rp000 raw_enpvcu21
isid source_year source_row
save "$VYD/N_G0_elec_nonpln_rp000_2021.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_elec_nonpln_rp000_2021"
log close vycell
