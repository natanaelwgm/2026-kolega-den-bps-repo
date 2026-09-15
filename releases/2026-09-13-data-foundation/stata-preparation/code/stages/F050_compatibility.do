* Tujuan: Siapkan berkas kompatibilitas yang diperlukan oleh langkah kerja berikut dari data intermediate. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; dag/edges/word_rows/G0/G0_03_map_economic_fields.do; dan 8 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L1:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 1 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L1:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L2:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 2 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_03_map_economic_fields.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_03_map_economic_fields.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L2:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L3:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 3 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L3:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L4:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 4 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_05_map_geography_industry.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_05_map_geography_industry.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L4:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L5:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 5 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L5:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L6:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 6 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L6:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L7:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 7 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L7:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L8:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 8 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L8:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L9:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 9 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L9:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L10:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_integrate_verified_candidate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do" "$WFROOT" "dag/data/word_data/G0/G0_main_candidate.dta"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L10:step-do" "code/stages/F050_compatibility.do:L1:file" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F050_compatibility.do:L11:step-display" "code/stages/F050_compatibility.do:L1:file" "statement" 11 11 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F050_PASS"
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L11:step-display" "code/stages/F050_compatibility.do:L1:file" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F050_compatibility.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
