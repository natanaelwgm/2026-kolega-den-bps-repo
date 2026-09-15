* Tujuan: Baca daftar syarat wajib penyelesaian dan ubah kolom keputusan menjadi angka sebelum menghasilkan status gerbang. // WFDOC-INJECTED
* Input: corrections/metadata/completion_gate.csv // WFDOC-INJECTED
* Output: corrections/reports/completion_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L1:step-version" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L1:step-version" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L2:step-do" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L2:step-do" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X24"
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L3:step-g0c_begin" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L4:step-import" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/completion_gate.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L4:step-import" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L5:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
rename mandatory __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L5:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L6:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
generate double mandatory=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L6:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L7:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
assert !missing(mandatory) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L7:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L8:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L8:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L9:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
rename G0_complete __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L9:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L10:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
generate double G0_complete=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L10:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L11:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
assert !missing(G0_complete) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L11:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L12:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L12:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L13:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
rename exact_request_line __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L13:step-rename" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L14:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
generate double exact_request_line=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L14:step-generate" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L15:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
assert !missing(exact_request_line) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L15:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L16:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L16:step-drop" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L17:step-isid" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
isid requirement_id
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L17:step-isid" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L18:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
assert _N==29
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L18:step-assert" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L19:step-save" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
save "corrections/reports/completion_gate.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L19:step-save" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L20:step-display" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X24"
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L20:step-display" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X24_completion_gate.do:L21:step-log" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L21:step-log" "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X24_completion_gate.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
