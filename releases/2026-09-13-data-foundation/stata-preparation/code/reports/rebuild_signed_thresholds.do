* Tujuan: Bentuk tabel atau laporan dari kolom dan kondisi yang tercantum langsung di file ini. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: data/analysis/signed_thresholds.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L1:step-version" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L1:step-version" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L2:step-do" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
do "rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L2:step-do" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L3:step-g0c_begin" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
g0c_begin "C050_signed_tail_threshold"
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L3:step-g0c_begin" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L4:step-use" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
use source_year source_row va_signed_nominal using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L4:step-use" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L5:step-generate" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
generate double __absolute=abs(va_signed_nominal)
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L5:step-generate" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L6:step-bysort" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
bysort source_year: egen double p99_abs_va=pctile(__absolute), p(99)
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L6:step-bysort" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L7:step-generate" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
generate long __nonzero=va_signed_nominal!=0 & !missing(va_signed_nominal)
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L7:step-generate" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L8:step-collapse" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
collapse (count) n_signed_va=va_signed_nominal (sum) n_nonzero=__nonzero (first) p99_abs_va, by(source_year)
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L8:step-collapse" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L9:step-recast" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
recast long n_signed_va n_nonzero
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L9:step-recast" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L10:step-replace" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
replace p99_abs_va=. if n_signed_va==0
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L10:step-replace" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L11:step-isid" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
isid source_year
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L11:step-isid" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L12:step-keep" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
keep source_year n_signed_va n_nonzero p99_abs_va
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L12:step-keep" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L13:step-order" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
order source_year
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L13:step-order" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L14:step-save" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
save "data/analysis/signed_thresholds.dta", replace
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L14:step-save" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/reports/rebuild_signed_thresholds.do:L15:step-log" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L15:step-log" "code/reports/rebuild_signed_thresholds.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/reports/rebuild_signed_thresholds.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
