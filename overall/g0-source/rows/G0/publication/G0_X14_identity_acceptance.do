* Tujuan: Pastikan mode identitas perusahaan tetap off, tautan ID nyata tidak diverifikasi, dan ID dummy/terpilih tetap kosong. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/identity_acceptance.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X14"
use source_year source_row identity_mode identity_is_dummy identity_real_link_verified selected_firm_id dummy_firm_id using "data/analysis/G0_analysis_ready.dta", clear
* Hentikan proses bila mode identitas berubah dari off atau jika ID nyata/dummy muncul. // WFDOC-INJECTED
assert identity_mode=="off" & identity_is_dummy==0 & identity_real_link_verified==0
assert missing(selected_firm_id) & missing(dummy_firm_id)
generate long rows=1
generate long verified_link_n=0
generate long dummy_n=0
generate long duplicate_source_key_n=0
isid source_year source_row
collapse (sum) rows verified_link_n dummy_n duplicate_source_key_n, by(source_year)
generate str12 identity_mode="off"
generate str90 panel_gate="Unavailable real crosswalk; source-year/source-row identifies observations, not panel firms"
save "corrections/reports/identity_acceptance.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X14"
capture log close G0CHILD
