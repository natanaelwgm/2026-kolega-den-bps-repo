* Tujuan: Susun jumlah observasi menurut tahun, variabel, dan kode status sumber; labelnya menyatakan bahwa masking tidak disimpulkan. // WFDOC-INJECTED
* Input: dag/reports/word_data/G0/source_state_counts.csv // WFDOC-INJECTED
* Output: corrections/reports/source_state_counts.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X06"
import delimited using "dag/reports/word_data/G0/source_state_counts.csv", varnames(1) asdouble clear encoding("UTF-8")
generate str50 state_scope="inherited_numeric_state; masking_not_inferred"
isid source_year variable source_state
rename source_state state
rename observations count
bysort source_year variable: egen long annual_n=total(count)
assert annual_n>0
save "corrections/reports/source_state_counts.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X06"
capture log close G0CHILD
