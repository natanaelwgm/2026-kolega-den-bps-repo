* Tujuan: Untuk 2015, kolom sumber capital_additions_nominal tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/capital_additions_nominal_2015.do dari data/intermediate/raw_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_capital_additions_nominal_2015: annual staged raw state -> capital_additions_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 140; ctttcu15 | total purchases & construct, 000rp
log using "$VYL/N_G0_capital_additions_nominal_2015.log", text replace name(vycell)
* Mulai capital_additions_nominal sebagai nilai kosong; vs_capital_additions_nominal mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double capital_additions_nominal=.
generate byte vs_capital_additions_nominal=4
* Hitung berapa baris capital_additions_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(capital_additions_nominal)
local obs=r(N)
quietly count if capital_additions_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_additions_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_additions_nominal==4
local absent=r(N)
post cell (2015) ("capital_additions_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, capital_additions_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row capital_additions_nominal vs_capital_additions_nominal
isid source_year source_row
save "$VYD/N_G0_capital_additions_nominal_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_additions_nominal_2015"
log close vycell
