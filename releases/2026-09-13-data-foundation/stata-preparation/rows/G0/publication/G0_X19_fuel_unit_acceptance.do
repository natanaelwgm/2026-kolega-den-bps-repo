* Tujuan: Impor keputusan unit bahan bakar per tahun dan normalisasi kolom angka; nama field/unit saja tidak membuktikan konversi yang diterima. // WFDOC-INJECTED
* Input: corrections/metadata/fuel_unit_acceptance.csv // WFDOC-INJECTED
* Output: corrections/reports/fuel_unit_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:step-version" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 1 41 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:step-version" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 1 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L2:step-do" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 2 41 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L2:step-do" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 2 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 3 41 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X19"
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 3 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L4:step-import" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 4 41 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/fuel_unit_acceptance.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L4:step-import" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 4 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L5:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 5 41 `=_rc' // WFLOG-INJECTED
rename source_year __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L5:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 5 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L6:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 6 41 `=_rc' // WFLOG-INJECTED
generate double source_year=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L6:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 6 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L7:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 7 41 `=_rc' // WFLOG-INJECTED
assert !missing(source_year) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L7:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 7 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L8:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 8 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L8:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 8 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L9:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 9 41 `=_rc' // WFLOG-INJECTED
rename native_field_present __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L9:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 9 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 10 41 `=_rc' // WFLOG-INJECTED
generate double native_field_present=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 10 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L11:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 11 41 `=_rc' // WFLOG-INJECTED
assert !missing(native_field_present) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L11:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 11 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L12:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 12 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L12:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 12 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L13:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 13 41 `=_rc' // WFLOG-INJECTED
rename multiplier __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L13:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 13 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 14 41 `=_rc' // WFLOG-INJECTED
generate double multiplier=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 14 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L15:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 15 41 `=_rc' // WFLOG-INJECTED
assert !missing(multiplier) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L15:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 15 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L16:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 16 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L16:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 16 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L17:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 17 41 `=_rc' // WFLOG-INJECTED
rename factor __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L17:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 17 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L18:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 18 41 `=_rc' // WFLOG-INJECTED
generate double factor=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L18:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 18 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L19:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 19 41 `=_rc' // WFLOG-INJECTED
assert !missing(factor) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L19:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 19 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L20:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 20 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L20:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 20 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L21:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 21 41 `=_rc' // WFLOG-INJECTED
rename inherited_multiplier_candidate __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L21:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 21 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L22:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 22 41 `=_rc' // WFLOG-INJECTED
generate double inherited_multiplier_candidate=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L22:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 22 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L23:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 23 41 `=_rc' // WFLOG-INJECTED
assert !missing(inherited_multiplier_candidate) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L23:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 23 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L24:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 24 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L24:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 24 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L25:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 25 41 `=_rc' // WFLOG-INJECTED
rename measurement_admitted __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L25:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 25 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L26:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 26 41 `=_rc' // WFLOG-INJECTED
generate double measurement_admitted=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L26:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 26 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L27:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 27 41 `=_rc' // WFLOG-INJECTED
assert !missing(measurement_admitted) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L27:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 27 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L28:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 28 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L28:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 28 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L29:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 29 41 `=_rc' // WFLOG-INJECTED
rename source_metadata_only __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L29:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 29 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L30:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 30 41 `=_rc' // WFLOG-INJECTED
generate double source_metadata_only=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L30:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 30 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L31:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 31 41 `=_rc' // WFLOG-INJECTED
assert !missing(source_metadata_only) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L31:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 31 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L32:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 32 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L32:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 32 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L33:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 33 41 `=_rc' // WFLOG-INJECTED
rename test_is_applicable __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L33:step-rename" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 33 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L34:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 34 41 `=_rc' // WFLOG-INJECTED
generate double test_is_applicable=real(strtrim(__raw_numeric))
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L34:step-generate" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 34 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L35:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 35 41 `=_rc' // WFLOG-INJECTED
assert !missing(test_is_applicable) if strtrim(__raw_numeric)!=""
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L35:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 35 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L36:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 36 41 `=_rc' // WFLOG-INJECTED
drop __raw_numeric
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L36:step-drop" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 36 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L37:step-isid" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 37 41 `=_rc' // WFLOG-INJECTED
isid source_year fuel_field
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L37:step-isid" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 37 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L38:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 38 41 `=_rc' // WFLOG-INJECTED
assert _N==273
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L38:step-assert" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 38 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L39:step-save" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 39 41 `=_rc' // WFLOG-INJECTED
save "corrections/reports/fuel_unit_acceptance.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L39:step-save" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 39 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L40:step-display" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 40 41 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X19"
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L40:step-display" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 40 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L41:step-log" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 41 41 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L41:step-log" "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "statement" 41 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X19_fuel_unit_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
