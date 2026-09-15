* Tujuan: Pastikan mode identitas perusahaan tetap off, tautan ID nyata tidak diverifikasi, dan ID dummy/terpilih tetap kosong. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/identity_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L1:step-version" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L1:step-version" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L2:step-do" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L2:step-do" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X14"
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L3:step-g0c_begin" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L4:step-use" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
use source_year source_row identity_mode identity_is_dummy identity_real_link_verified selected_firm_id dummy_firm_id using "data/analysis/G0_analysis_ready.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L4:step-use" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L5:step-assert" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
* Hentikan proses bila mode identitas berubah dari off atau jika ID nyata/dummy muncul. // WFDOC-INJECTED
assert identity_mode=="off" & identity_is_dummy==0 & identity_real_link_verified==0
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L5:step-assert" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L6:step-assert" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
assert missing(selected_firm_id) & missing(dummy_firm_id)
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L6:step-assert" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L7:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
generate long rows=1
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L7:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L8:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
generate long verified_link_n=0
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L8:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L9:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
generate long dummy_n=0
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L9:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
generate long duplicate_source_key_n=0
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L10:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L11:step-isid" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L11:step-isid" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L12:step-collapse" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
collapse (sum) rows verified_link_n dummy_n duplicate_source_key_n, by(source_year)
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L12:step-collapse" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L13:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
generate str12 identity_mode="off"
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L13:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
generate str90 panel_gate="Unavailable real crosswalk; source-year/source-row identifies observations, not panel firms"
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L14:step-generate" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L15:step-save" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
save "corrections/reports/identity_acceptance.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L15:step-save" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L16:step-display" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X14"
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L16:step-display" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X14_identity_acceptance.do:L17:step-log" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L17:step-log" "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X14_identity_acceptance.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
