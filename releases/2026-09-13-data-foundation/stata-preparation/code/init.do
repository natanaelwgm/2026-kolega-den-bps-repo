* Tujuan: Atur lingkungan Stata, lokasi kerja, batas variabel, dan folder sementara yang dipakai oleh semua do-file tahap ini. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/init.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L1:step-version" "code/init.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "code/init.do:L1:step-version" "code/init.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L2:step-set" "code/init.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "code/init.do:L2:step-set" "code/init.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L3:step-set" "code/init.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "code/init.do:L3:step-set" "code/init.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L4:step-if" "code/init.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila c(maxvar) kurang dari 10000. // WFDOC-INJECTED
if c(maxvar)<10000 {
capture noisily __wf_progress start "code/init.do:L4:block-body" "code/init.do:L4:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L5:step-clear" "code/init.do:L4:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
 clear
capture noisily __wf_progress end "code/init.do:L5:step-clear" "code/init.do:L4:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L6:step-set" "code/init.do:L4:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
 set maxvar 10000
capture noisily __wf_progress end "code/init.do:L6:step-set" "code/init.do:L4:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/init.do:L4:block-body" "code/init.do:L4:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "code/init.do:L4:step-if" "code/init.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L8:step-global" "code/init.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
global WFROOT "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
capture noisily __wf_progress end "code/init.do:L8:step-global" "code/init.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L9:step-cd" "code/init.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
cd "$WFROOT"
capture noisily __wf_progress end "code/init.do:L9:step-cd" "code/init.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L10:step-global" "code/init.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
global G0D "dag/data/word_data/G0"
capture noisily __wf_progress end "code/init.do:L10:step-global" "code/init.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L11:step-global" "code/init.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
global G0R "dag/reports/word_data/G0"
capture noisily __wf_progress end "code/init.do:L11:step-global" "code/init.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L12:step-global" "code/init.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
global G0L "dag/logs/word_data/G0"
capture noisily __wf_progress end "code/init.do:L12:step-global" "code/init.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L13:step-global" "code/init.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
global VYD "dag/data/word_data/G0/variable_year"
capture noisily __wf_progress end "code/init.do:L13:step-global" "code/init.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L14:step-global" "code/init.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
global VYL "dag/logs/word_data/G0/variable_year"
capture noisily __wf_progress end "code/init.do:L14:step-global" "code/init.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/init.do:L15:step-global" "code/init.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
global VYR "dag/reports/word_data/G0/20260910-code-verification"
capture noisily __wf_progress end "code/init.do:L15:step-global" "code/init.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/init.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
