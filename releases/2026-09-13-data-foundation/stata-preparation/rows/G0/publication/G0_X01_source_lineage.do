* Tujuan: Impor tabel jejak sumber dan salin ID/sha256 untuk keluaran lineage; ini metadata tentang berkas, bukan nilai analisis. // WFDOC-INJECTED
* Input: corrections/metadata/source_lineage.csv // WFDOC-INJECTED
* Output: corrections/reports/source_lineage.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L1:step-version" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L1:step-version" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L2:step-do" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L2:step-do" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X01"
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L3:step-g0c_begin" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L4:step-import" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
import delimited using "corrections/metadata/source_lineage.csv", varnames(1) case(preserve) stringcols(_all) bindquote(strict) clear encoding("UTF-8")
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L4:step-import" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L5:step-generate" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
generate str40 source_id=state_id
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L5:step-generate" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L6:step-generate" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
generate str64 sha256=source_sha256
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L6:step-generate" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L7:step-save" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
save "corrections/reports/source_lineage.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L7:step-save" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L8:step-display" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X01"
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L8:step-display" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X01_source_lineage.do:L9:step-log" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L9:step-log" "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X01_source_lineage.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
