* Tujuan: Jumlahkan komponen biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; simpan banyak komponen yang tersedia dan apakah lengkap. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C061.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:step-version" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:step-version" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L2:step-do" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L2:step-do" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L3:step-g0c_begin" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
g0c_begin "C061_energy_cost_subtotal"
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L3:step-g0c_begin" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L4:step-use" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
* Jumlahkan hanya biaya bahan bakar dan listrik yang status sumbernya 0/1 serta nilainya tidak negatif; hitung berapa dari tiga komponen yang tersedia. // WFDOC-INJECTED
use source_year source_row fuel_total_reported_rp000 st_fuel_total_reported_rp000 elec_pln_rp000 st_elec_pln_rp000 elec_nonpln_rp000 st_elec_nonpln_rp000 using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L4:step-use" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:step-foreach" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "loop" 5 16 `=_rc' "in" `"fuel_total_reported_rp000 elec_pln_rp000 elec_nonpln_rp000"' // WFLOG-INJECTED
* Ulangi blok untuk v: fuel_total_reported_rp000, elec_pln_rp000, elec_nonpln_rp000. // WFDOC-INJECTED
foreach v in fuel_total_reported_rp000 elec_pln_rp000 elec_nonpln_rp000 {
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:iteration-body" "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L6:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
* Salin komponen biaya hanya bila nilai tidak negatif, terisi, dan status sumbernya 0/1. // WFDOC-INJECTED
    generate double __`v'=`v' if `v'>=0 & !missing(`v') & inlist(st_`v',0,1)
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L6:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:iteration-body" "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L5:step-foreach" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "loop" 5 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L8:step-egen" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
* Hitung berapa dari tiga komponen yang memenuhi syarat; angka ini membedakan subtotal parsial dari lengkap. // WFDOC-INJECTED
egen byte energy_cost_reported_n=rownonmiss(__fuel_total_reported_rp000 __elec_pln_rp000 __elec_nonpln_rp000)
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L8:step-egen" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L9:step-egen" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
* Jumlahkan komponen yang lolos; opsi missing mencegah semua-komponen-kosong berubah menjadi nol. // WFDOC-INJECTED
egen double energy_exp_observed_repaired=rowtotal(__fuel_total_reported_rp000 __elec_pln_rp000 __elec_nonpln_rp000), missing
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L9:step-egen" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L10:step-replace" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
* Pastikan subtotal tetap missing jika tidak ada satu pun komponen yang teramati. // WFDOC-INJECTED
replace energy_exp_observed_repaired=. if energy_cost_reported_n==0
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L10:step-replace" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L11:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
generate byte energy_cost_reported_partial=inrange(energy_cost_reported_n,1,2)
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L11:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L12:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
generate byte energy_cost_reported_complete=energy_cost_reported_n==3
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L12:step-generate" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L13:step-assert" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
assert missing(energy_exp_observed_repaired) if energy_cost_reported_n==0
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L13:step-assert" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L14:step-keep" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
keep source_year source_row energy_cost_reported_n energy_cost_reported_partial energy_cost_reported_complete energy_exp_observed_repaired
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L14:step-keep" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L15:step-order" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L15:step-order" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L16:step-isid" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L16:step-isid" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L17:step-assert" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L17:step-assert" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C061_energy_cost_subtotal.do:L18:step-g0c_finish" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C061_energy_cost_subtotal" "C061"
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L18:step-g0c_finish" "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C061_energy_cost_subtotal.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
