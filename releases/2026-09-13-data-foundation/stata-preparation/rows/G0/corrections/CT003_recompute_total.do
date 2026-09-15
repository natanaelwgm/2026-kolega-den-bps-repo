* Tujuan: Ubah total pembelian listrik kWh menjadi GJ dengan faktor 0,0036; hasil hanya dibuat bila komponen listrik tersedia. // WFDOC-INJECTED
* Input: corrections/data/CT002.dta // WFDOC-INJECTED
* Output: corrections/data/CT003.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L1:step-version" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L1:step-version" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L2:step-do" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L2:step-do" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
g0c_begin "CT003_recompute_total"
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L4:step-use" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
use  using "corrections/data/CT002.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L4:step-use" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=r_elec_purchased_kwh if r_elec_purchased_kwh>=0 & !missing(r_elec_purchased_kwh)
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L5:step-generate" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L6:step-egen" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
egen byte r_gj_electricity_n=rownonmiss(__component0)
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L6:step-egen" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
generate double r_gj_electricity=.
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L8:step-replace" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
replace r_gj_electricity=__component0*.0036 if r_gj_electricity_n==1
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L8:step-replace" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L9:step-assert" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
assert missing(r_gj_electricity) if r_gj_electricity_n==0
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L9:step-assert" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L10:step-keep" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
keep source_year source_row r_gj_electricity r_gj_electricity_n
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L10:step-keep" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L11:step-order" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L11:step-order" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L12:step-isid" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L12:step-isid" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L13:step-assert" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L13:step-assert" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT003_recompute_total.do:L14:step-g0c_finish" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT003_recompute_total" "CT003"
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L14:step-g0c_finish" "rows/G0/corrections/CT003_recompute_total.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CT003_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
