* Tujuan: Jumlahkan komponen biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; simpan banyak komponen yang tersedia dan apakah lengkap. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C061.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C061_energy_cost_subtotal"
* Jumlahkan hanya biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; hitung berapa dari tiga komponen yang tersedia. // WFDOC-INJECTED
use source_year source_row fuel_total_reported_rp000 st_fuel_total_reported_rp000 elec_pln_rp000 st_elec_pln_rp000 elec_nonpln_rp000 st_elec_nonpln_rp000 using "corrections/data/C010.dta", clear
* Ulangi blok untuk v: fuel_total_reported_rp000, elec_pln_rp000, elec_nonpln_rp000. // WFDOC-INJECTED
foreach v in fuel_total_reported_rp000 elec_pln_rp000 elec_nonpln_rp000 {
* Salin komponen biaya hanya bila nilai tidak negatif, terisi, dan status sumbernya 0/1. // WFDOC-INJECTED
    generate double __`v'=`v' if `v'>=0 & !missing(`v') & inlist(st_`v',0,1)
}
* Hitung berapa dari tiga komponen yang memenuhi syarat; angka ini membedakan subtotal parsial dari lengkap. // WFDOC-INJECTED
egen byte energy_cost_reported_n=rownonmiss(__fuel_total_reported_rp000 __elec_pln_rp000 __elec_nonpln_rp000)
* Jumlahkan komponen yang lolos; opsi missing mencegah semua-komponen-kosong berubah menjadi nol. // WFDOC-INJECTED
egen double energy_exp_observed_repaired=rowtotal(__fuel_total_reported_rp000 __elec_pln_rp000 __elec_nonpln_rp000), missing
* Pastikan subtotal tetap missing jika tidak ada satu pun komponen yang teramati. // WFDOC-INJECTED
replace energy_exp_observed_repaired=. if energy_cost_reported_n==0
generate byte energy_cost_reported_partial=inrange(energy_cost_reported_n,1,2)
generate byte energy_cost_reported_complete=energy_cost_reported_n==3
assert missing(energy_exp_observed_repaired) if energy_cost_reported_n==0
keep source_year source_row energy_cost_reported_n energy_cost_reported_partial energy_cost_reported_complete energy_exp_observed_repaired
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C061_energy_cost_subtotal" "C061"
