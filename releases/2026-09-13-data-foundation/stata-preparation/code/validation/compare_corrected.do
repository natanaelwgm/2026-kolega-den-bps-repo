* Tujuan: Bandingkan nilai hasil koreksi dengan berkas keluaran yang diharapkan; pemeriksaan memakai kunci tahun/baris. // WFDOC-INJECTED
* Input: corrections/data/C140.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta // WFDOC-INJECTED
* Output: validation/V080.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/validation/compare_corrected.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_corrected.do:L1:step-do" "code/validation/compare_corrected.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/validation/compare_corrected.do:L1:step-do" "code/validation/compare_corrected.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_corrected.do:L2:step-use" "code/validation/compare_corrected.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
use "corrections/data/C140.dta", clear
capture noisily __wf_progress end "code/validation/compare_corrected.do:L2:step-use" "code/validation/compare_corrected.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_corrected.do:L3:step-cf" "code/validation/compare_corrected.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta", all
capture noisily __wf_progress end "code/validation/compare_corrected.do:L3:step-cf" "code/validation/compare_corrected.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_corrected.do:L4:step-display" "code/validation/compare_corrected.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
display "WF_CORRECTED_VALUES_EXACT"
capture noisily __wf_progress end "code/validation/compare_corrected.do:L4:step-display" "code/validation/compare_corrected.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/validation/compare_corrected.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
