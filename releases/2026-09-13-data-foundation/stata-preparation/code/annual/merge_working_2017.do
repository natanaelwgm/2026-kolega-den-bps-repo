* Tujuan: Tambahkan nilai kerja tahun 2017 ke gelombang terverifikasi memakai source_year dan source_row; guard memastikan pasangan baris cocok sebelum berkas tahunan disimpan. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2017.dta; dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2017.dta; dan 8 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/wave_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L1:step-do" "code/annual/merge_working_2017.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L1:step-do" "code/annual/merge_working_2017.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L2:step-do" "code/annual/merge_working_2017.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L2:step-do" "code/annual/merge_working_2017.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L3:step-use" "code/annual/merge_working_2017.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use source_year source_row using "data/intermediate/verified_wave_2017.dta", clear
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L3:step-use" "code/annual/merge_working_2017.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L4:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2017.dta") fields("export_any_binary v_export_any_binary vs_export_any_binary") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L4:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L5:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2017.dta") fields("rd_activity_flag v_rd_activity_flag vs_rd_activity_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L5:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L6:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2017.dta") fields("rd_external_funding_flag v_rd_external_funding_flag vs_rd_external_funding_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L6:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L7:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2017.dta") fields("innovation_product_flag v_innovation_product_flag vs_innovation_product_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L7:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L8:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2017.dta") fields("innovation_process_flag v_innovation_process_flag vs_innovation_process_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L8:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L9:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2017.dta") fields("innovation_marketing_flag v_innovation_marketing_flag vs_innovation_marketing_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L9:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L10:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2017.dta") fields("innovation_org_flag v_innovation_org_flag vs_innovation_org_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L10:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L11:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2017.dta") fields("innovation_flag v_innovation_flag vs_innovation_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L11:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L12:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2017.dta") fields("export_flag v_export_flag vs_export_flag") year(2017)
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L12:step-wf_merge_guard" "code/annual/merge_working_2017.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L13:step-isid" "code/annual/merge_working_2017.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L13:step-isid" "code/annual/merge_working_2017.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/annual/merge_working_2017.do:L14:step-save" "code/annual/merge_working_2017.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/wave_2017.dta", replace
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L14:step-save" "code/annual/merge_working_2017.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/annual/merge_working_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
