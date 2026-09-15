* Tujuan: Baca daftar berkas sumber, ubah ukuran byte menjadi angka, dan catat tahun serta metadata inventaris yang dapat dibaca. // WFDOC-INJECTED
* Input: corrections/metadata/source_inventory.csv // WFDOC-INJECTED
* Output: corrections/reports/source_inventory.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L1:step-version" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 1 31 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L1:step-version" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 1 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L2:step-do" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 2 31 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L2:step-do" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 2 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L3:step-g0c_begin" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 3 31 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X03"
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L3:step-g0c_begin" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 3 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L4:step-import" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 4 31 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/source_inventory.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L4:step-import" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 4 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L5:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 5 31 `=_rc' // WFLOG-INJECTED
rename bytes __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L5:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 5 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L6:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 6 31 `=_rc' // WFLOG-INJECTED
generate double bytes=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L6:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 6 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L7:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 7 31 `=_rc' // WFLOG-INJECTED
assert !missing(bytes) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L7:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 7 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L8:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 8 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L8:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 8 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L9:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 9 31 `=_rc' // WFLOG-INJECTED
rename source_year __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L9:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 9 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L10:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 10 31 `=_rc' // WFLOG-INJECTED
generate double source_year=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L10:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 10 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L11:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 11 31 `=_rc' // WFLOG-INJECTED
assert !missing(source_year) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L11:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 11 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L12:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 12 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L12:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 12 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L13:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 13 31 `=_rc' // WFLOG-INJECTED
rename rows __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L13:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 13 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L14:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 14 31 `=_rc' // WFLOG-INJECTED
generate double rows=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L14:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 14 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L15:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 15 31 `=_rc' // WFLOG-INJECTED
assert !missing(rows) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L15:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 15 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L16:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 16 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L16:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 16 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L17:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 17 31 `=_rc' // WFLOG-INJECTED
rename columns __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L17:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 17 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L18:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 18 31 `=_rc' // WFLOG-INJECTED
generate double columns=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L18:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 18 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L19:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 19 31 `=_rc' // WFLOG-INJECTED
assert !missing(columns) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L19:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 19 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L20:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 20 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L20:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 20 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L21:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 21 31 `=_rc' // WFLOG-INJECTED
rename raw_columns __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L21:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 21 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L22:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 22 31 `=_rc' // WFLOG-INJECTED
generate double raw_columns=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L22:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 22 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L23:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 23 31 `=_rc' // WFLOG-INJECTED
assert !missing(raw_columns) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L23:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 23 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L24:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 24 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L24:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 24 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L25:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 25 31 `=_rc' // WFLOG-INJECTED
rename native_reconciliation_pass __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L25:step-rename" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 25 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L26:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 26 31 `=_rc' // WFLOG-INJECTED
generate double native_reconciliation_pass=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L26:step-generate" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 26 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L27:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 27 31 `=_rc' // WFLOG-INJECTED
assert !missing(native_reconciliation_pass) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L27:step-assert" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 27 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L28:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 28 31 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L28:step-drop" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 28 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L29:step-save" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 29 31 `=_rc' // WFLOG-INJECTED
save "corrections/reports/source_inventory.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L29:step-save" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 29 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L30:step-display" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 30 31 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X03"
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L30:step-display" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 30 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X03_source_inventory.do:L31:step-log" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 31 31 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L31:step-log" "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "statement" 31 31 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X03_source_inventory.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
