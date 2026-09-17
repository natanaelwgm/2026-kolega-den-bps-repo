* Tujuan: Baca daftar syarat wajib penyelesaian dan ubah kolom keputusan menjadi angka sebelum menghasilkan status gerbang. // WFDOC-INJECTED
* Input: corrections/metadata/completion_gate.csv // WFDOC-INJECTED
* Output: corrections/reports/completion_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X24"
import delimited using "corrections/metadata/completion_gate.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
rename mandatory __raw_numeric
generate double mandatory=real(strtrim(__raw_numeric))
assert !missing(mandatory) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename G0_complete __raw_numeric
generate double G0_complete=real(strtrim(__raw_numeric))
assert !missing(G0_complete) if strtrim(__raw_numeric)!=""
drop __raw_numeric
rename exact_request_line __raw_numeric
generate double exact_request_line=real(strtrim(__raw_numeric))
assert !missing(exact_request_line) if strtrim(__raw_numeric)!=""
drop __raw_numeric
isid requirement_id
assert _N==29
save "corrections/reports/completion_gate.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X24"
capture log close G0CHILD
