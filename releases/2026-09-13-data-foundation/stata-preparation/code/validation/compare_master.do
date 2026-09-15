* Tujuan: Bandingkan master gabungan dengan snapshot pembanding untuk memastikan baris dan kolom sama. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta // WFDOC-INJECTED
* Output: validation/V085.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L1:step-do" "code/validation/compare_master.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/validation/compare_master.do:L1:step-do" "code/validation/compare_master.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L2:step-use" "code/validation/compare_master.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "code/validation/compare_master.do:L2:step-use" "code/validation/compare_master.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L3:step-assert" "code/validation/compare_master.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _N==33049 & c(k)==4593
capture noisily __wf_progress end "code/validation/compare_master.do:L3:step-assert" "code/validation/compare_master.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L4:step-isid" "code/validation/compare_master.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
* Pastikan satu pasangan tahun/nomor baris hanya muncul sekali; pasangan ini mengenali baris, bukan firmID. // WFDOC-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/validation/compare_master.do:L4:step-isid" "code/validation/compare_master.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L5:step-assert" "code/validation/compare_master.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert rd17_own_token_class=="" & rd17_external_token_class=="" if source_year!=2017
capture noisily __wf_progress end "code/validation/compare_master.do:L5:step-assert" "code/validation/compare_master.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L6:step-drop" "code/validation/compare_master.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
drop rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress end "code/validation/compare_master.do:L6:step-drop" "code/validation/compare_master.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L7:step-cf" "code/validation/compare_master.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta", all
capture noisily __wf_progress end "code/validation/compare_master.do:L7:step-cf" "code/validation/compare_master.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_master.do:L8:step-display" "code/validation/compare_master.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
display "WF_MASTER_ORIGINAL_4591_VALUES_EXACT"
capture noisily __wf_progress end "code/validation/compare_master.do:L8:step-display" "code/validation/compare_master.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/validation/compare_master.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
