* Tujuan: Pisahkan nilai tambah yang teramati (positif, nol, atau negatif) dari nilai kosong/status; nilai bertanda tidak otomatis dibuang. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L1:step-version" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L1:step-version" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L2:step-do" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L2:step-do" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
g0c_begin "C020_va_domain"
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L4:step-use" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
* Pisahkan nilai tambah bertanda yang teramati dari nilai kosong/status; nilai negatif dan nol tetap termasuk domain, bukan otomatis dibuang. // WFDOC-INJECTED
use source_year source_row value_added_nominal st_value_added_nominal using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L4:step-use" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L5:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
assert inrange(st_value_added_nominal,0,5)
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L5:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L6:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
assert st_value_added_nominal==0 if value_added_nominal>0 & !missing(value_added_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L6:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L7:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
assert st_value_added_nominal==1 if value_added_nominal==0
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L7:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L8:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
assert st_value_added_nominal==2 if value_added_nominal<0 & !missing(value_added_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L8:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L9:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
assert missing(value_added_nominal) if inlist(st_value_added_nominal,3,4,5)
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L9:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L10:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
generate byte va_source_state=st_value_added_nominal
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L10:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L11:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
generate byte va_signed_eligible=inlist(va_source_state,0,1,2) & !missing(value_added_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L11:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L12:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
generate str24 va_missing_reason="observed_signed"
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L12:step-generate" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L13:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
replace va_missing_reason="observation_missing" if va_source_state==3
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L13:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L14:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
replace va_missing_reason="source_absent" if va_source_state==4
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L14:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L15:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
replace va_missing_reason="parse_failure" if va_source_state==5
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L15:step-replace" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L16:step-keep" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
keep source_year source_row va_source_state va_signed_eligible va_missing_reason
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L16:step-keep" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L17:step-order" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L17:step-order" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L18:step-isid" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L18:step-isid" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L19:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L19:step-assert" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C020_va_domain.do:L20:step-g0c_finish" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C020_va_domain" "C020"
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L20:step-g0c_finish" "rows/G0/corrections/C020_va_domain.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C020_va_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
