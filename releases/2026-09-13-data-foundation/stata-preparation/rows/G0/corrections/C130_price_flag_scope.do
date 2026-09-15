* Tujuan: Pertahankan flag ekor harga lama, tetapi biarkan banyak observasi yang dinilai kosong karena penyebut belum diketahui. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C130.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L1:step-version" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L1:step-version" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L2:step-do" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L2:step-do" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L3:step-g0c_begin" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
g0c_begin "C130_price_flag_scope"
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L3:step-g0c_begin" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L4:step-use" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
* Pertahankan flag ekor harga lama, tetapi jumlah observasi yang dinilai dibiarkan kosong karena denominator belum diketahui. // WFDOC-INJECTED
use source_year source_row any_implausible_price using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L4:step-use" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L5:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
generate byte legacy_price_tail_flag=any_implausible_price
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L5:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L6:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
generate int price_tail_evaluated_n=.
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L6:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L7:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
generate str60 price_tail_source_gate="unknown_denominator; inherited_empirical_tail_only"
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L7:step-generate" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L8:step-keep" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
keep source_year source_row legacy_price_tail_flag price_tail_evaluated_n price_tail_source_gate
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L8:step-keep" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L9:step-order" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L9:step-order" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L10:step-isid" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L10:step-isid" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L11:step-assert" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L11:step-assert" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C130_price_flag_scope.do:L12:step-g0c_finish" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C130_price_flag_scope" "C130"
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L12:step-g0c_finish" "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C130_price_flag_scope.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
