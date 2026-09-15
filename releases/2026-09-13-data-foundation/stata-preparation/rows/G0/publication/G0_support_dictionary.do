* Tujuan: Buat kamus keluaran dari master dan registri rilis; kolom token pertanyaan R&D dikeluarkan dari kamus publik. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; correction-planning/registries/publication_variable_year_release.csv // WFDOC-INJECTED
* Output: corrections/reports/variable_year_release_status.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L1:step-version" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L1:step-version" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L2:step-do" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L2:step-do" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L3:step-use" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L3:step-use" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L4:step-drop" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
drop rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L4:step-drop" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L5:step-do" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
do "rows/G0/edges/G0_raw_schema.do" "corrections/reports/dictionary_all_columns.dta"
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L5:step-do" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L6:step-import" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 6 7 `=_rc' // WFLOG-INJECTED
import delimited using "correction-planning/registries/publication_variable_year_release.csv", varnames(1) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L6:step-import" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_support_dictionary.do:L7:step-save" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
save "corrections/reports/variable_year_release_status.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L7:step-save" "rows/G0/publication/G0_support_dictionary.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_support_dictionary.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
