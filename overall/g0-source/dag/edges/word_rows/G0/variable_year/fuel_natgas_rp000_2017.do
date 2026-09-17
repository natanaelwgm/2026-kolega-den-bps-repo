* Tujuan: Untuk 2017, kolom sumber fuel_natgas_rp000 tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/fuel_natgas_rp000_2017.do dari data/intermediate/raw_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_fuel_natgas_rp000_2017: annual staged raw state -> fuel_natgas_rp000 at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_fuel_natgas_rp000_2017.log", text replace name(vycell)
* Mulai fuel_natgas_rp000 sebagai nilai kosong; vs_fuel_natgas_rp000 mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
generate double fuel_natgas_rp000=.
generate byte vs_fuel_natgas_rp000=4
* Hitung berapa baris fuel_natgas_rp000 yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(fuel_natgas_rp000)
local obs=r(N)
quietly count if fuel_natgas_rp000==0
local zeros=r(N)
quietly count if inlist(vs_fuel_natgas_rp000,5,6,8)
local bad=r(N)
quietly count if vs_fuel_natgas_rp000==4
local absent=r(N)
post cell (2017) ("fuel_natgas_rp000") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, fuel_natgas_rp000, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row fuel_natgas_rp000 vs_fuel_natgas_rp000
isid source_year source_row
save "$VYD/N_G0_fuel_natgas_rp000_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_fuel_natgas_rp000_2017"
log close vycell
