* Tujuan: Impor keputusan unit bahan bakar per tahun dan normalisasi kolom angka; nama field/unit saja tidak membuktikan konversi yang diterima. // WFDOC-INJECTED
* Input: corrections/metadata/fuel_unit_acceptance.csv // WFDOC-INJECTED
* Output: corrections/reports/fuel_unit_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X19"
import delimited using "corrections/metadata/fuel_unit_acceptance.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
rename source_year __raw_numeric
generate double source_year=real(strtrim(__raw_numeric))
assert !missing(source_year) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename native_field_present __raw_numeric
generate double native_field_present=real(strtrim(__raw_numeric))
assert !missing(native_field_present) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename multiplier __raw_numeric
generate double multiplier=real(strtrim(__raw_numeric))
assert !missing(multiplier) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename factor __raw_numeric
generate double factor=real(strtrim(__raw_numeric))
assert !missing(factor) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename inherited_multiplier_candidate __raw_numeric
generate double inherited_multiplier_candidate=real(strtrim(__raw_numeric))
assert !missing(inherited_multiplier_candidate) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename measurement_admitted __raw_numeric
generate double measurement_admitted=real(strtrim(__raw_numeric))
assert !missing(measurement_admitted) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename source_metadata_only __raw_numeric
generate double source_metadata_only=real(strtrim(__raw_numeric))
assert !missing(source_metadata_only) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename test_is_applicable __raw_numeric
generate double test_is_applicable=real(strtrim(__raw_numeric))
assert !missing(test_is_applicable) if strtrim(__raw_numeric)!=""
drop __raw_numeric
isid source_year fuel_field
assert _N==273
save "corrections/reports/fuel_unit_acceptance.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X19"
capture log close G0CHILD
