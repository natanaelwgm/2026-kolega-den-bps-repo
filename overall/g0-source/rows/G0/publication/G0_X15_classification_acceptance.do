* Tujuan: Impor tabel keputusan klasifikasi per tahun dan pastikan kolom numerik/unknown dapat dibaca sebelum diringkas. // WFDOC-INJECTED
* Input: corrections/metadata/classification_acceptance.csv // WFDOC-INJECTED
* Output: corrections/reports/classification_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X15"
import delimited using "corrections/metadata/classification_acceptance.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
rename source_year __raw_numeric
generate double source_year=real(strtrim(__raw_numeric))
assert !missing(source_year) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename unknown_n __raw_numeric
generate double unknown_n=real(strtrim(__raw_numeric))
assert !missing(unknown_n) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename native_field_present __raw_numeric
generate double native_field_present=real(strtrim(__raw_numeric))
assert !missing(native_field_present) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename measurement_admitted __raw_numeric
generate double measurement_admitted=real(strtrim(__raw_numeric))
assert !missing(measurement_admitted) if strtrim(__raw_numeric)!=""
drop __raw_numeric
isid source_year domain
assert _N==39
save "corrections/reports/classification_acceptance.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X15"
capture log close G0CHILD
