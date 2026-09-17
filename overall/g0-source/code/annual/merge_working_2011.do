* Tujuan: Tambahkan nilai kerja tahun 2011 ke gelombang terverifikasi memakai source_year dan source_row; guard memastikan pasangan baris cocok sebelum berkas tahunan disimpan. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2011.dta; dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2011.dta; dan 8 masukan lain // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/wave_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
do "code/merge_guard.do"
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use source_year source_row using "data/intermediate/verified_wave_2011.dta", clear
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2011.dta") fields("export_any_binary v_export_any_binary vs_export_any_binary") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2011.dta") fields("rd_activity_flag v_rd_activity_flag vs_rd_activity_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2011.dta") fields("rd_external_funding_flag v_rd_external_funding_flag vs_rd_external_funding_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2011.dta") fields("innovation_product_flag v_innovation_product_flag vs_innovation_product_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2011.dta") fields("innovation_process_flag v_innovation_process_flag vs_innovation_process_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2011.dta") fields("innovation_marketing_flag v_innovation_marketing_flag vs_innovation_marketing_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2011.dta") fields("innovation_org_flag v_innovation_org_flag vs_innovation_org_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2011.dta") fields("innovation_flag v_innovation_flag vs_innovation_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2011.dta") fields("export_flag v_export_flag vs_export_flag") year(2011)
isid source_year source_row
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/wave_2011.dta", replace
