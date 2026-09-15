* Tujuan: Bandingkan keluaran baseline dengan master yang dipatok; perbedaan nilai atau kunci menghentikan validasi. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Output: validation/V070.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/validation/compare_baseline.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_baseline.do:L1:step-do" "code/validation/compare_baseline.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/validation/compare_baseline.do:L1:step-do" "code/validation/compare_baseline.do:L1:file" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_baseline.do:L2:step-use" "code/validation/compare_baseline.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", clear
capture noisily __wf_progress end "code/validation/compare_baseline.do:L2:step-use" "code/validation/compare_baseline.do:L1:file" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_baseline.do:L3:step-cf" "code/validation/compare_baseline.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", all
capture noisily __wf_progress end "code/validation/compare_baseline.do:L3:step-cf" "code/validation/compare_baseline.do:L1:file" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_baseline.do:L4:step-display" "code/validation/compare_baseline.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
display "WF_BASELINE_VALUES_EXACT"
capture noisily __wf_progress end "code/validation/compare_baseline.do:L4:step-display" "code/validation/compare_baseline.do:L1:file" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/validation/compare_baseline.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
