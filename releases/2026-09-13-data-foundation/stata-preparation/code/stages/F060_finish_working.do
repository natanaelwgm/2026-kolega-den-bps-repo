* Tujuan: Lengkapi wave terverifikasi dengan kolom kerja yang disiapkan per variabel/tahun. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_verified_20260910.dta; dag/data/word_data/G0/analysis_tunnel/wave_2010.dta; dan 11 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta; dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L1:step-do" "code/stages/F060_finish_working.do:L1:file" "statement" 1 76 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L1:step-do" "code/stages/F060_finish_working.do:L1:file" "statement" 1 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L2:step-use" "code/stages/F060_finish_working.do:L1:file" "statement" 2 76 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/analysis_tunnel/wave_2010.dta", clear
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L2:step-use" "code/stages/F060_finish_working.do:L1:file" "statement" 2 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L3:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 3 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2011.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L3:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 3 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L4:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 4 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2012.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L4:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 4 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L5:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 5 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2013.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L5:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 5 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L6:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 6 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2014.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L6:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 6 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L7:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 7 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2015.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L7:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 7 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L8:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 8 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2017.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L8:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 8 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L9:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 9 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2018.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L9:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 9 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L10:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 10 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2019.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L10:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 10 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L11:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 11 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2020.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L11:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 11 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L12:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 12 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2021.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L12:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 12 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L13:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 13 76 `=_rc' // WFLOG-INJECTED
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2022.dta"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L13:step-append" "code/stages/F060_finish_working.do:L1:file" "statement" 13 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L14:step-tempfile" "code/stages/F060_finish_working.do:L1:file" "statement" 14 76 `=_rc' // WFLOG-INJECTED
tempfile tunnel
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L14:step-tempfile" "code/stages/F060_finish_working.do:L1:file" "statement" 14 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L15:step-save" "code/stages/F060_finish_working.do:L1:file" "statement" 15 76 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save `tunnel'
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L15:step-save" "code/stages/F060_finish_working.do:L1:file" "statement" 15 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L16:step-use" "code/stages/F060_finish_working.do:L1:file" "statement" 16 76 `=_rc' // WFLOG-INJECTED
use "dag/data/word_data/G0/G0_main_verified_20260910.dta", clear
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L16:step-use" "code/stages/F060_finish_working.do:L1:file" "statement" 16 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L17:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 17 76 `=_rc' // WFLOG-INJECTED
capture drop export_any_binary
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L17:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 17 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L18:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 18 76 `=_rc' // WFLOG-INJECTED
capture drop vs_export_any_binary
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L18:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 18 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L19:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 19 76 `=_rc' // WFLOG-INJECTED
capture drop rd_activity_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L19:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 19 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L20:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 20 76 `=_rc' // WFLOG-INJECTED
capture drop vs_rd_activity_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L20:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 20 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L21:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 21 76 `=_rc' // WFLOG-INJECTED
capture drop rd_external_funding_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L21:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 21 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L22:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 22 76 `=_rc' // WFLOG-INJECTED
capture drop vs_rd_external_funding_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L22:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 22 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L23:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 23 76 `=_rc' // WFLOG-INJECTED
capture drop innovation_product_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L23:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 23 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L24:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 24 76 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_product_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L24:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 24 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L25:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 25 76 `=_rc' // WFLOG-INJECTED
capture drop innovation_process_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L25:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 25 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L26:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 26 76 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_process_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L26:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 26 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L27:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 27 76 `=_rc' // WFLOG-INJECTED
capture drop innovation_marketing_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L27:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 27 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L28:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 28 76 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_marketing_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L28:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 28 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L29:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 29 76 `=_rc' // WFLOG-INJECTED
capture drop innovation_org_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L29:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 29 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L30:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 30 76 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_org_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L30:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 30 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L31:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 31 76 `=_rc' // WFLOG-INJECTED
capture drop innovation_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L31:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 31 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L32:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 32 76 `=_rc' // WFLOG-INJECTED
capture drop vs_innovation_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L32:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 32 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L33:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 33 76 `=_rc' // WFLOG-INJECTED
capture drop export_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L33:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 33 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L34:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 34 76 `=_rc' // WFLOG-INJECTED
capture drop vs_export_flag
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L34:step-drop" "code/stages/F060_finish_working.do:L1:file" "statement" 34 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L35:step-merge" "code/stages/F060_finish_working.do:L1:file" "statement" 35 76 `=_rc' // WFLOG-INJECTED
merge 1:1 source_year source_row using `tunnel', assert(match) nogen
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L35:step-merge" "code/stages/F060_finish_working.do:L1:file" "statement" 35 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L36:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 36 76 `=_rc' // WFLOG-INJECTED
replace export_observed=!missing(export_flag)
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L36:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 36 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L37:step-generate" "code/stages/F060_finish_working.do:L1:file" "statement" 37 76 `=_rc' // WFLOG-INJECTED
generate byte export_assumption_conflict=export_share_valid & !missing(export_any_binary) & (export_share_pct>0)!=export_any_binary
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L37:step-generate" "code/stages/F060_finish_working.do:L1:file" "statement" 37 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L38:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 38 76 `=_rc' // WFLOG-INJECTED
replace export_definition_status="working_binary_1yes_2no; annual_code_evidence_pending" if vs_export_flag==10
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L38:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 38 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L39:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 39 76 `=_rc' // WFLOG-INJECTED
replace g0_schema_version="20260910_analysis_tunnel_v3"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L39:step-replace" "code/stages/F060_finish_working.do:L1:file" "statement" 39 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L40:step-generate" "code/stages/F060_finish_working.do:L1:file" "statement" 40 76 `=_rc' // WFLOG-INJECTED
generate str80 analysis_contract="stable field names; working values + v_ verified-only + vs_=10 provisional"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L40:step-generate" "code/stages/F060_finish_working.do:L1:file" "statement" 40 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L41:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 41 76 `=_rc' // WFLOG-INJECTED
label define G0_tunnel_state 0 "observed/verified" 1 "observed zero" 2 "negative" 3 "missing" 4 "source absent" 5 "parse failure" 6 "invalid code" 7 "code evidence missing" 8 "outside universe" 9 "retired incompatible alias" 10 "PROVISIONAL observed; assumption documented", replace
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L41:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 41 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L42:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 42 76 `=_rc' // WFLOG-INJECTED
label values vs_export_any_binary G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L42:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 42 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L43:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 43 76 `=_rc' // WFLOG-INJECTED
label variable export_any_binary "Working standardized 0/1; inspect vs_export_any_binary (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L43:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 43 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L44:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 44 76 `=_rc' // WFLOG-INJECTED
label variable v_export_any_binary "Verified-only companion to export_any_binary"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L44:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 44 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L45:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 45 76 `=_rc' // WFLOG-INJECTED
label values vs_rd_activity_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L45:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 45 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L46:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 46 76 `=_rc' // WFLOG-INJECTED
label variable rd_activity_flag "Working standardized 0/1; inspect vs_rd_activity_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L46:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 46 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L47:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 47 76 `=_rc' // WFLOG-INJECTED
label variable v_rd_activity_flag "Verified-only companion to rd_activity_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L47:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 47 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L48:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 48 76 `=_rc' // WFLOG-INJECTED
label values vs_rd_external_funding_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L48:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 48 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L49:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 49 76 `=_rc' // WFLOG-INJECTED
label variable rd_external_funding_flag "Working standardized 0/1; inspect vs_rd_external_funding_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L49:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 49 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L50:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 50 76 `=_rc' // WFLOG-INJECTED
label variable v_rd_external_funding_flag "Verified-only companion to rd_external_funding_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L50:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 50 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L51:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 51 76 `=_rc' // WFLOG-INJECTED
label values vs_innovation_product_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L51:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 51 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L52:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 52 76 `=_rc' // WFLOG-INJECTED
label variable innovation_product_flag "Working standardized 0/1; inspect vs_innovation_product_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L52:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 52 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L53:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 53 76 `=_rc' // WFLOG-INJECTED
label variable v_innovation_product_flag "Verified-only companion to innovation_product_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L53:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 53 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L54:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 54 76 `=_rc' // WFLOG-INJECTED
label values vs_innovation_process_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L54:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 54 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L55:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 55 76 `=_rc' // WFLOG-INJECTED
label variable innovation_process_flag "Working standardized 0/1; inspect vs_innovation_process_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L55:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 55 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L56:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 56 76 `=_rc' // WFLOG-INJECTED
label variable v_innovation_process_flag "Verified-only companion to innovation_process_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L56:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 56 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L57:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 57 76 `=_rc' // WFLOG-INJECTED
label values vs_innovation_marketing_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L57:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 57 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L58:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 58 76 `=_rc' // WFLOG-INJECTED
label variable innovation_marketing_flag "Working standardized 0/1; inspect vs_innovation_marketing_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L58:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 58 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L59:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 59 76 `=_rc' // WFLOG-INJECTED
label variable v_innovation_marketing_flag "Verified-only companion to innovation_marketing_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L59:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 59 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L60:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 60 76 `=_rc' // WFLOG-INJECTED
label values vs_innovation_org_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L60:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 60 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L61:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 61 76 `=_rc' // WFLOG-INJECTED
label variable innovation_org_flag "Working standardized 0/1; inspect vs_innovation_org_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L61:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 61 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L62:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 62 76 `=_rc' // WFLOG-INJECTED
label variable v_innovation_org_flag "Verified-only companion to innovation_org_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L62:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 62 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L63:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 63 76 `=_rc' // WFLOG-INJECTED
label values vs_innovation_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L63:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 63 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L64:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 64 76 `=_rc' // WFLOG-INJECTED
label variable innovation_flag "Working standardized 0/1; inspect vs_innovation_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L64:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 64 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L65:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 65 76 `=_rc' // WFLOG-INJECTED
label variable v_innovation_flag "Verified-only companion to innovation_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L65:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 65 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L66:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 66 76 `=_rc' // WFLOG-INJECTED
label values vs_export_flag G0_tunnel_state
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L66:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 66 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L67:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 67 76 `=_rc' // WFLOG-INJECTED
label variable export_flag "Working standardized 0/1; inspect vs_export_flag (10=provisional)"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L67:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 67 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L68:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 68 76 `=_rc' // WFLOG-INJECTED
label variable v_export_flag "Verified-only companion to export_flag"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L68:step-label" "code/stages/F060_finish_working.do:L1:file" "statement" 68 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L69:step-isid" "code/stages/F060_finish_working.do:L1:file" "statement" 69 76 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L69:step-isid" "code/stages/F060_finish_working.do:L1:file" "statement" 69 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L70:step-assert" "code/stages/F060_finish_working.do:L1:file" "statement" 70 76 `=_rc' // WFLOG-INJECTED
assert _N==33049
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L70:step-assert" "code/stages/F060_finish_working.do:L1:file" "statement" 70 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L71:step-sort" "code/stages/F060_finish_working.do:L1:file" "statement" 71 76 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L71:step-sort" "code/stages/F060_finish_working.do:L1:file" "statement" 71 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L72:step-cf" "code/stages/F060_finish_working.do:L1:file" "statement" 72 76 `=_rc' // WFLOG-INJECTED
cf source_year source_row raw_* using "dag/data/word_data/G0/G0_main_verified_20260910.dta", all
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L72:step-cf" "code/stages/F060_finish_working.do:L1:file" "statement" 72 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L73:step-assert" "code/stages/F060_finish_working.do:L1:file" "statement" 73 76 `=_rc' // WFLOG-INJECTED
assert missing(export_flag) if source_year==2022 & export_direct_flag==0 & !export_share_valid
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L73:step-assert" "code/stages/F060_finish_working.do:L1:file" "statement" 73 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L74:step-save" "code/stages/F060_finish_working.do:L1:file" "statement" 74 76 `=_rc' // WFLOG-INJECTED
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta", replace
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L74:step-save" "code/stages/F060_finish_working.do:L1:file" "statement" 74 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L75:step-copy" "code/stages/F060_finish_working.do:L1:file" "statement" 75 76 `=_rc' // WFLOG-INJECTED
copy "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta" "dag/data/word_data/G0/G0_main_candidate.dta", replace
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L75:step-copy" "code/stages/F060_finish_working.do:L1:file" "statement" 75 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F060_finish_working.do:L76:step-display" "code/stages/F060_finish_working.do:L1:file" "statement" 76 76 `=_rc' // WFLOG-INJECTED
display "G0_ANALYSIS_TUNNEL_SUCCESS"
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L76:step-display" "code/stages/F060_finish_working.do:L1:file" "statement" 76 76 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F060_finish_working.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
