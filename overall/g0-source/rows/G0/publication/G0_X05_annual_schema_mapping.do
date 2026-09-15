* Tujuan: Impor peta nama sumber-ke-kanonik per tahun dan pastikan satu nama kanonik hanya muncul sekali per wave. // WFDOC-INJECTED
* Input: corrections/metadata/annual_schema_mapping.csv // WFDOC-INJECTED
* Output: corrections/reports/annual_schema_mapping.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X05"
import delimited using "corrections/metadata/annual_schema_mapping.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
rename source_year __raw_numeric
generate double source_year=real(strtrim(__raw_numeric))
assert !missing(source_year) if strtrim(__raw_numeric)!=""
drop __raw_numeric
isid source_year canonical_name
generate strL evidence_ref=child_path
save "corrections/reports/annual_schema_mapping.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X05"
capture log close G0CHILD
