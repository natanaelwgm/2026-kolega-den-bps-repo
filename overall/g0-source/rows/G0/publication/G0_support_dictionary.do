* Tujuan: Buat kamus keluaran dari master dan registri rilis; kolom token pertanyaan R&D dikeluarkan dari kamus publik. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; correction-planning/registries/publication_variable_year_release.csv // WFDOC-INJECTED
* Output: corrections/reports/variable_year_release_status.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
use "data/analysis/G0_analysis_ready.dta", clear
drop rd17_own_token_class rd17_external_token_class
do "rows/G0/edges/G0_raw_schema.do" "corrections/reports/dictionary_all_columns.dta"
import delimited using "correction-planning/registries/publication_variable_year_release.csv", varnames(1) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
save "corrections/reports/variable_year_release_status.dta", replace
