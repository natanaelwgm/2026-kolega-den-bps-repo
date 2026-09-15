* Tujuan: Untuk tiap tahun, hitung persentil ke-99 dari nilai absolut nilai tambah sebagai ambang uji sensitivitas. // WFDOC-INJECTED
* Input: corrections/data/C030.dta // WFDOC-INJECTED
* Output: corrections/data/C050.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L1:step-version" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L1:step-version" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L2:step-do" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L2:step-do" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L3:step-g0c_begin" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
g0c_begin "C050_signed_tail_threshold"
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L3:step-g0c_begin" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L4:step-use" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
* Hitung persentil ke-99 dari nilai absolut nilai tambah per tahun; ambang dipakai untuk uji sensitivitas, bukan untuk mengubah nilai tambah. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L4:step-use" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L5:step-generate" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
* Ubah tanda hanya untuk membuat besar absolut; nilai tambah asli tidak diubah. // WFDOC-INJECTED
generate double __absolute=abs(va_signed_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L5:step-generate" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L6:step-bysort" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
* Hitung ambang p99 secara terpisah dalam tiap tahun dari besar absolut nilai tambah. // WFDOC-INJECTED
bysort source_year: egen double p99_abs_va=pctile(__absolute), p(99)
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L6:step-bysort" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L7:step-generate" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
generate long __nonzero=va_signed_nominal!=0 & !missing(va_signed_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L7:step-generate" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L8:step-collapse" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
* Ringkas menjadi satu baris per tahun: jumlah nilai tambah teramati, banyak yang tidak nol, dan ambang p99. // WFDOC-INJECTED
collapse (count) n_signed_va=va_signed_nominal (sum) n_nonzero=__nonzero (first) p99_abs_va, by(source_year)
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L8:step-collapse" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L9:step-recast" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
recast long n_signed_va n_nonzero
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L9:step-recast" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L10:step-replace" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
replace p99_abs_va=. if n_signed_va==0
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L10:step-replace" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L11:step-isid" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
isid source_year
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L11:step-isid" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L12:step-keep" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
keep source_year n_signed_va n_nonzero p99_abs_va
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L12:step-keep" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L13:step-order" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
order source_year
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L13:step-order" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C050_signed_tail_threshold.do:L14:step-g0c_finish" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C050_signed_tail_threshold" "C050"
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L14:step-g0c_finish" "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C050_signed_tail_threshold.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
