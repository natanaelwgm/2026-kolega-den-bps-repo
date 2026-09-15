* Tujuan: Ambil data sumber tahun 2021, cek tahun dan keunikan baris, lalu simpan salinan tahunan berkolom raw_*. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/staged/sample_mfg2021_raw.dta // WFDOC-INJECTED
* Output: data/intermediate/raw_wave_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L1:step-do" "code/annual/raw_2021.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/raw_2021.do:L1:step-do" "code/annual/raw_2021.do:L1:file" "statement" 1 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L2:step-use" "code/annual/raw_2021.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
* Muat berkas sumber untuk satu tahun; barisnya lalu diberi kunci tahun dan nomor baris. // WFDOC-INJECTED
use "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/staged/sample_mfg2021_raw.dta", clear
capture noisily __wf_progress end "code/annual/raw_2021.do:L2:step-use" "code/annual/raw_2021.do:L1:file" "statement" 2 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L3:step-assert" "code/annual/raw_2021.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
assert source_year==2021
capture noisily __wf_progress end "code/annual/raw_2021.do:L3:step-assert" "code/annual/raw_2021.do:L1:file" "statement" 3 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L4:step-isid" "code/annual/raw_2021.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/raw_2021.do:L4:step-isid" "code/annual/raw_2021.do:L1:file" "statement" 4 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/raw_2021.do:L5:step-save" "code/annual/raw_2021.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
save "data/intermediate/raw_wave_2021.dta", replace
capture noisily __wf_progress end "code/annual/raw_2021.do:L5:step-save" "code/annual/raw_2021.do:L1:file" "statement" 5 5 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/raw_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
