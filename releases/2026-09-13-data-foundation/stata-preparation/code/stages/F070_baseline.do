* Tujuan: Pilih kolom dasar untuk koreksi dan simpan baseline; pemeriksaan menahan ID perusahaan nyata/dummy. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L1:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F070_baseline.do:L1:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L2:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do" "$WFROOT" "off"
capture noisily __wf_progress end "code/stages/F070_baseline.do:L2:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L3:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_local_prepare_numeric.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_local_prepare_numeric.do" "$WFROOT"
capture noisily __wf_progress end "code/stages/F070_baseline.do:L3:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L4:step-use" "code/stages/F070_baseline.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", clear
capture noisily __wf_progress end "code/stages/F070_baseline.do:L4:step-use" "code/stages/F070_baseline.do:L1:file" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L5:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/order_baseline.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/order_baseline.do"
capture noisily __wf_progress end "code/stages/F070_baseline.do:L5:step-do" "code/stages/F070_baseline.do:L1:file" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L6:step-save" "code/stages/F070_baseline.do:L1:file" "statement" 6 7 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", replace
capture noisily __wf_progress end "code/stages/F070_baseline.do:L6:step-save" "code/stages/F070_baseline.do:L1:file" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F070_baseline.do:L7:step-display" "code/stages/F070_baseline.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F070_PASS"
capture noisily __wf_progress end "code/stages/F070_baseline.do:L7:step-display" "code/stages/F070_baseline.do:L1:file" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F070_baseline.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
