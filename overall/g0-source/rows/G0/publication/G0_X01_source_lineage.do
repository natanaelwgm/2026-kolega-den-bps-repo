* Tujuan: Impor tabel jejak sumber dan salin ID/sha256 untuk keluaran lineage; ini metadata tentang berkas, bukan nilai analisis. // WFDOC-INJECTED
* Input: corrections/metadata/source_lineage.csv // WFDOC-INJECTED
* Output: corrections/reports/source_lineage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X01"
import delimited using "corrections/metadata/source_lineage.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
generate str40 source_id=state_id
generate str64 sha256=source_sha256
save "corrections/reports/source_lineage.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X01"
capture log close G0CHILD
