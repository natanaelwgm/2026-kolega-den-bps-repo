* Tujuan: Impor tabel keputusan klasifikasi per tahun dan pastikan kolom numerik/unknown dapat dibaca sebelum diringkas. // WFDOC-INJECTED
* Input: corrections/metadata/classification_acceptance.csv // WFDOC-INJECTED
* Output: corrections/reports/classification_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L1:step-version" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 1 25 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L1:step-version" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 1 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L2:step-do" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 2 25 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L2:step-do" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 2 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 3 25 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X15"
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 3 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L4:step-import" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 4 25 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/classification_acceptance.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L4:step-import" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 4 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L5:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 5 25 `=_rc' // WFLOG-INJECTED
rename source_year __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L5:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 5 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L6:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 6 25 `=_rc' // WFLOG-INJECTED
generate double source_year=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L6:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 6 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L7:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 7 25 `=_rc' // WFLOG-INJECTED
assert !missing(source_year) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L7:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 7 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L8:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 8 25 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L8:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 8 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L9:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 9 25 `=_rc' // WFLOG-INJECTED
rename unknown_n __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L9:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 9 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 10 25 `=_rc' // WFLOG-INJECTED
generate double unknown_n=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 10 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L11:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 11 25 `=_rc' // WFLOG-INJECTED
assert !missing(unknown_n) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L11:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 11 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L12:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 12 25 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L12:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 12 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L13:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 13 25 `=_rc' // WFLOG-INJECTED
rename native_field_present __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L13:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 13 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 14 25 `=_rc' // WFLOG-INJECTED
generate double native_field_present=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 14 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L15:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 15 25 `=_rc' // WFLOG-INJECTED
assert !missing(native_field_present) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L15:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 15 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L16:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 16 25 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L16:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 16 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L17:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 17 25 `=_rc' // WFLOG-INJECTED
rename measurement_admitted __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L17:step-rename" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 17 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L18:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 18 25 `=_rc' // WFLOG-INJECTED
generate double measurement_admitted=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L18:step-generate" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 18 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L19:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 19 25 `=_rc' // WFLOG-INJECTED
assert !missing(measurement_admitted) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L19:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 19 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L20:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 20 25 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L20:step-drop" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 20 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L21:step-isid" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 21 25 `=_rc' // WFLOG-INJECTED
isid source_year domain
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L21:step-isid" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 21 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L22:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 22 25 `=_rc' // WFLOG-INJECTED
assert _N==39
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L22:step-assert" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 22 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L23:step-save" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 23 25 `=_rc' // WFLOG-INJECTED
save "corrections/reports/classification_acceptance.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L23:step-save" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 23 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L24:step-display" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 24 25 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X15"
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L24:step-display" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 24 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X15_classification_acceptance.do:L25:step-log" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 25 25 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L25:step-log" "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "statement" 25 25 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X15_classification_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
