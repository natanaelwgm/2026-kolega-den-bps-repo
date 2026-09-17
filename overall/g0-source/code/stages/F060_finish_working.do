* Tujuan: Lengkapi wave terverifikasi dengan kolom kerja yang disiapkan per variabel/tahun. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_verified_20260910.dta; dag/data/word_data/G0/analysis_tunnel/wave_2010.dta; dan 11 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta; dag/data/word_data/G0/G0_main_candidate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "dag/data/word_data/G0/analysis_tunnel/wave_2010.dta", clear
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2011.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2012.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2013.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2014.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2015.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2017.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2018.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2019.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2020.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2021.dta"
* Tambahkan seluruh baris dari wave berikut ke data yang sedang terbuka; pemeriksaan akhir memastikan gabungan tidak menggandakan kunci. // WFDOC-INJECTED
append using "dag/data/word_data/G0/analysis_tunnel/wave_2022.dta"
tempfile tunnel
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save `tunnel'
use "dag/data/word_data/G0/G0_main_verified_20260910.dta", clear
capture drop export_any_binary
capture drop vs_export_any_binary
capture drop rd_activity_flag
capture drop vs_rd_activity_flag
capture drop rd_external_funding_flag
capture drop vs_rd_external_funding_flag
capture drop innovation_product_flag
capture drop vs_innovation_product_flag
capture drop innovation_process_flag
capture drop vs_innovation_process_flag
capture drop innovation_marketing_flag
capture drop vs_innovation_marketing_flag
capture drop innovation_org_flag
capture drop vs_innovation_org_flag
capture drop innovation_flag
capture drop vs_innovation_flag
capture drop export_flag
capture drop vs_export_flag
merge 1:1 source_year source_row using `tunnel', assert(match) nogen
replace export_observed=!missing(export_flag)
generate byte export_assumption_conflict=export_share_valid & !missing(export_any_binary) & (export_share_pct>0)!=export_any_binary
replace export_definition_status="working_binary_1yes_2no; annual_code_evidence_pending" if vs_export_flag==10
replace g0_schema_version="20260910_analysis_tunnel_v3"
generate str80 analysis_contract="stable field names; working values + v_ verified-only + vs_=10 provisional"
label define G0_tunnel_state 0 "observed/verified" 1 "observed zero" 2 "negative" 3 "missing" 4 "source absent" 5 "parse failure" 6 "invalid code" 7 "code evidence missing" 8 "outside universe" 9 "retired incompatible alias" 10 "PROVISIONAL observed; assumption documented", replace
label values vs_export_any_binary G0_tunnel_state
label variable export_any_binary "Working standardized 0/1; inspect vs_export_any_binary (10=provisional)"
label variable v_export_any_binary "Verified-only companion to export_any_binary"
label values vs_rd_activity_flag G0_tunnel_state
label variable rd_activity_flag "Working standardized 0/1; inspect vs_rd_activity_flag (10=provisional)"
label variable v_rd_activity_flag "Verified-only companion to rd_activity_flag"
label values vs_rd_external_funding_flag G0_tunnel_state
label variable rd_external_funding_flag "Working standardized 0/1; inspect vs_rd_external_funding_flag (10=provisional)"
label variable v_rd_external_funding_flag "Verified-only companion to rd_external_funding_flag"
label values vs_innovation_product_flag G0_tunnel_state
label variable innovation_product_flag "Working standardized 0/1; inspect vs_innovation_product_flag (10=provisional)"
label variable v_innovation_product_flag "Verified-only companion to innovation_product_flag"
label values vs_innovation_process_flag G0_tunnel_state
label variable innovation_process_flag "Working standardized 0/1; inspect vs_innovation_process_flag (10=provisional)"
label variable v_innovation_process_flag "Verified-only companion to innovation_process_flag"
label values vs_innovation_marketing_flag G0_tunnel_state
label variable innovation_marketing_flag "Working standardized 0/1; inspect vs_innovation_marketing_flag (10=provisional)"
label variable v_innovation_marketing_flag "Verified-only companion to innovation_marketing_flag"
label values vs_innovation_org_flag G0_tunnel_state
label variable innovation_org_flag "Working standardized 0/1; inspect vs_innovation_org_flag (10=provisional)"
label variable v_innovation_org_flag "Verified-only companion to innovation_org_flag"
label values vs_innovation_flag G0_tunnel_state
label variable innovation_flag "Working standardized 0/1; inspect vs_innovation_flag (10=provisional)"
label variable v_innovation_flag "Verified-only companion to innovation_flag"
label values vs_export_flag G0_tunnel_state
label variable export_flag "Working standardized 0/1; inspect vs_export_flag (10=provisional)"
label variable v_export_flag "Verified-only companion to export_flag"
isid source_year source_row
assert _N==33049
sort source_year source_row
cf source_year source_row raw_* using "dag/data/word_data/G0/G0_main_verified_20260910.dta", all
assert missing(export_flag) if source_year==2022 & export_direct_flag==0 & !export_share_valid
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta", replace
copy "dag/data/word_data/G0/G0_main_analysis_tunnel_20260910.dta" "dag/data/word_data/G0/G0_main_candidate.dta", replace
display "G0_ANALYSIS_TUNNEL_SUCCESS"
