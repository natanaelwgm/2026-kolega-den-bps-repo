* Tujuan: Baca daftar berkas sumber, ubah ukuran byte menjadi angka, dan catat tahun serta metadata inventaris yang dapat dibaca. // WFDOC-INJECTED
* Input: corrections/metadata/source_inventory.csv // WFDOC-INJECTED
* Output: corrections/reports/source_inventory.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X03"
import delimited using "corrections/metadata/source_inventory.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
rename bytes __raw_numeric
generate double bytes=real(strtrim(__raw_numeric))
assert !missing(bytes) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename source_year __raw_numeric
generate double source_year=real(strtrim(__raw_numeric))
assert !missing(source_year) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename rows __raw_numeric
generate double rows=real(strtrim(__raw_numeric))
assert !missing(rows) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename columns __raw_numeric
generate double columns=real(strtrim(__raw_numeric))
assert !missing(columns) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename raw_columns __raw_numeric
generate double raw_columns=real(strtrim(__raw_numeric))
assert !missing(raw_columns) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename native_reconciliation_pass __raw_numeric
generate double native_reconciliation_pass=real(strtrim(__raw_numeric))
assert !missing(native_reconciliation_pass) if strtrim(__raw_numeric)!=""
drop __raw_numeric
save "corrections/reports/source_inventory.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X03"
capture log close G0CHILD
