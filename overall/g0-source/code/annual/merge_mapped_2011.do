* Tujuan: Gabungkan hasil pemetaan kolom tahun 2011 ke baris data mentah memakai source_year dan source_row; wf_merge_guard memeriksa tahun, kunci unik, dan pasangan baris sebelum merge. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2011.dta; dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2011.dta; dan 232 masukan lain // WFDOC-INJECTED
* Output: data/intermediate/mapped_wave_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
do "code/merge_guard.do"
* Muat wave tahunan utama; source_year dan source_row mengenali satu baris di wave, bukan firmID. // WFDOC-INJECTED
use "data/intermediate/raw_wave_2011.dta", clear
assert source_year==2011
isid source_year source_row
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_amdal_raw_2011.dta") fields("amdal_raw vs_amdal_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_b3wste_raw_2011.dta") fields("b3wste_raw vs_b3wste_raw") year(2011)
* Simpan data lengkap sementara sebelum pemeriksaan per kolom; hasil antara hanya dipakai untuk membandingkan raw dengan variabel, lalu restore memulihkan wave penuh. // WFDOC-INJECTED
preserve
keep source_year source_row raw_ctttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_additions_nominal_2011.dta") fields("capital_additions_nominal vs_capital_additions_nominal") year(2011)
preserve
keep source_year source_row raw_ctttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_nominal_2011.dta") fields("capital_nominal vs_capital_nominal") year(2011)
preserve
keep source_year source_row raw_v1115
cf _all using "dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_capital_stock_nominal_2011.dta") fields("capital_stock_nominal vs_capital_stock_nominal") year(2011)
preserve
keep source_year source_row raw_ekspor11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2011.dta") fields("export_binary_raw vs_export_binary_raw") year(2011)
preserve
keep source_year source_row raw_prprex11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_share_pct_2011.dta") fields("export_share_pct vs_export_share_pct") year(2011)
preserve
keep source_year source_row raw_dasing11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_foreign_ownership_pct_2011.dta") fields("foreign_ownership_pct vs_foreign_ownership_pct") year(2011)
preserve
keep source_year source_row raw_output11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_gross_output_nominal_2011.dta") fields("gross_output_nominal vs_gross_output_nominal") year(2011)
preserve
keep source_year source_row raw_rimvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_import_value_nominal_2011.dta") fields("import_value_nominal vs_import_value_nominal") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_marketing_raw_2011.dta") fields("innovation_marketing_raw vs_innovation_marketing_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_org_raw_2011.dta") fields("innovation_org_raw vs_innovation_org_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_process_raw_2011.dta") fields("innovation_process_raw vs_innovation_process_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_product_raw_2011.dta") fields("innovation_product_raw vs_innovation_product_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_raw_2011.dta") fields("innovation_raw vs_innovation_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_inspli_raw_2011.dta") fields("inspli_raw vs_inspli_raw") year(2011)
preserve
keep source_year source_row raw_iinput11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_intermediate_inputs_nominal_2011.dta") fields("intermediate_inputs_nominal vs_intermediate_inputs_nominal") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_liwste_raw_2011.dta") fields("liwste_raw vs_liwste_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_pplihi_raw_2011.dta") fields("pplihi_raw vs_pplihi_raw") year(2011)
preserve
keep source_year source_row raw_lprnou11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_production_workers_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_production_workers_2011.dta") fields("production_workers vs_production_workers") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2011.dta") fields("rd_cost_nominal vs_rd_cost_nominal") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_indicator_raw_2011.dta") fields("rd_indicator_raw vs_rd_indicator_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_workers_2011.dta") fields("rd_workers vs_rd_workers") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_sowste_raw_2011.dta") fields("sowste_raw vs_sowste_raw") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_spplhi_raw_2011.dta") fields("spplhi_raw vs_spplhi_raw") year(2011)
preserve
keep source_year source_row raw_cbdacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbdacu_2011.dta") fields("val_cbdacu vs_val_cbdacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbfpcu_2011.dta") fields("val_cbfpcu vs_val_cbfpcu") year(2011)
preserve
keep source_year source_row raw_cbsacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbsacu_2011.dta") fields("val_cbsacu vs_val_cbsacu") year(2011)
preserve
keep source_year source_row raw_cbttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cbttcu_2011.dta") fields("val_cbttcu vs_val_cbttcu") year(2011)
preserve
keep source_year source_row raw_cldacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cldacu_2011.dta") fields("val_cldacu vs_val_cldacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clfpcu_2011.dta") fields("val_clfpcu vs_val_clfpcu") year(2011)
preserve
keep source_year source_row raw_clsacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clsacu_2011.dta") fields("val_clsacu vs_val_clsacu") year(2011)
preserve
keep source_year source_row raw_clttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_clttcu_2011.dta") fields("val_clttcu vs_val_clttcu") year(2011)
preserve
keep source_year source_row raw_cmdacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmdacu_2011.dta") fields("val_cmdacu vs_val_cmdacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmfpcu_2011.dta") fields("val_cmfpcu vs_val_cmfpcu") year(2011)
preserve
keep source_year source_row raw_cmsacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmsacu_2011.dta") fields("val_cmsacu vs_val_cmsacu") year(2011)
preserve
keep source_year source_row raw_cmttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cmttcu_2011.dta") fields("val_cmttcu vs_val_cmttcu") year(2011)
preserve
keep source_year source_row raw_codacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_codacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_codacu_2011.dta") fields("val_codacu vs_val_codacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cofpcu_2011.dta") fields("val_cofpcu vs_val_cofpcu") year(2011)
preserve
keep source_year source_row raw_cosacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cosacu_2011.dta") fields("val_cosacu vs_val_cosacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_costrd_2011.dta") fields("val_costrd vs_val_costrd") year(2011)
preserve
keep source_year source_row raw_cottcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cottcu_2011.dta") fields("val_cottcu vs_val_cottcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csdacu_2011.dta") fields("val_csdacu vs_val_csdacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csfpcu_2011.dta") fields("val_csfpcu vs_val_csfpcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cssacu_2011.dta") fields("val_cssacu vs_val_cssacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_csttcu_2011.dta") fields("val_csttcu vs_val_csttcu") year(2011)
preserve
keep source_year source_row raw_ctdacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctdacu_2011.dta") fields("val_ctdacu vs_val_ctdacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctfpcu_2011.dta") fields("val_ctfpcu vs_val_ctfpcu") year(2011)
preserve
keep source_year source_row raw_ctsacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctsacu_2011.dta") fields("val_ctsacu vs_val_ctsacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cttcu_2011.dta") fields("val_cttcu vs_val_cttcu") year(2011)
preserve
keep source_year source_row raw_ctttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ctttcu_2011.dta") fields("val_ctttcu vs_val_ctttcu") year(2011)
preserve
keep source_year source_row raw_cvdacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvdacu_2011.dta") fields("val_cvdacu vs_val_cvdacu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvfpcu_2011.dta") fields("val_cvfpcu vs_val_cvfpcu") year(2011)
preserve
keep source_year source_row raw_cvsacu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvsacu_2011.dta") fields("val_cvsacu vs_val_cvsacu") year(2011)
preserve
keep source_year source_row raw_cvttcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_cvttcu_2011.dta") fields("val_cvttcu vs_val_cvttcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_devvcu_2011.dta") fields("val_devvcu vs_val_devvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavce_2011.dta") fields("val_ecavce vs_val_ecavce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecavcu_2011.dta") fields("val_ecavcu vs_val_ecavcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvce_2011.dta") fields("val_ecbvce vs_val_ecbvce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ecbvcu_2011.dta") fields("val_ecbvcu vs_val_ecbvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvce_2011.dta") fields("val_eckvce vs_val_eckvce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eckvcu_2011.dta") fields("val_eckvcu vs_val_eckvcu") year(2011)
preserve
keep source_year source_row raw_eclvce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvce_2011.dta") fields("val_eclvce vs_val_eclvce") year(2011)
preserve
keep source_year source_row raw_eclvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eclvcu_2011.dta") fields("val_eclvcu vs_val_eclvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivce_2011.dta") fields("val_edivce vs_val_edivce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_edivcu_2011.dta") fields("val_edivcu vs_val_edivcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovce_2011.dta") fields("val_efovce vs_val_efovce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efovcu_2011.dta") fields("val_efovcu vs_val_efovcu") year(2011)
preserve
keep source_year source_row raw_efuvce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvce_2011.dta") fields("val_efuvce vs_val_efuvce") year(2011)
preserve
keep source_year source_row raw_efuvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_efuvcu_2011.dta") fields("val_efuvcu vs_val_efuvcu") year(2011)
preserve
keep source_year source_row raw_egavce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavce_2011.dta") fields("val_egavce vs_val_egavce") year(2011)
preserve
keep source_year source_row raw_egavcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egavcu_2011.dta") fields("val_egavcu vs_val_egavcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovce_2011.dta") fields("val_egovce vs_val_egovce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_egovcu_2011.dta") fields("val_egovcu vs_val_egovcu") year(2011)
preserve
keep source_year source_row raw_elpvce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvce_2011.dta") fields("val_elpvce vs_val_elpvce") year(2011)
preserve
keep source_year source_row raw_elpvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_elpvcu_2011.dta") fields("val_elpvcu vs_val_elpvcu") year(2011)
preserve
keep source_year source_row raw_eluvce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvce_2011.dta") fields("val_eluvce vs_val_eluvce") year(2011)
preserve
keep source_year source_row raw_eluvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eluvcu_2011.dta") fields("val_eluvcu vs_val_eluvcu") year(2011)
preserve
keep source_year source_row raw_encvce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvce_2011.dta") fields("val_encvce vs_val_encvce") year(2011)
preserve
keep source_year source_row raw_encvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_encvcu_2011.dta") fields("val_encvcu vs_val_encvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvce_2011.dta") fields("val_engvce vs_val_engvce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_engvcu_2011.dta") fields("val_engvcu vs_val_engvcu") year(2011)
preserve
keep source_year source_row raw_enpvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_enpvcu_2011.dta") fields("val_enpvcu vs_val_enpvcu") year(2011)
preserve
keep source_year source_row raw_eoivce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivce_2011.dta") fields("val_eoivce vs_val_eoivce") year(2011)
preserve
keep source_year source_row raw_eoivcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eoivcu_2011.dta") fields("val_eoivcu vs_val_eoivcu") year(2011)
preserve
keep source_year source_row raw_epevce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevce_2011.dta") fields("val_epevce vs_val_epevce") year(2011)
preserve
keep source_year source_row raw_epevcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_epevcu_2011.dta") fields("val_epevcu vs_val_epevcu") year(2011)
preserve
keep source_year source_row raw_eplvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_eplvcu_2011.dta") fields("val_eplvcu vs_val_eplvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvce_2011.dta") fields("val_esdvce vs_val_esdvce") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esdvcu_2011.dta") fields("val_esdvcu vs_val_esdvcu") year(2011)
preserve
keep source_year source_row raw_esovce11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovce_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovce_2011.dta") fields("val_esovce vs_val_esovce") year(2011)
preserve
keep source_year source_row raw_esovcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_esovcu_2011.dta") fields("val_esovcu vs_val_esovcu") year(2011)
preserve
keep source_year source_row raw_ibrvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ibrvcu_2011.dta") fields("val_ibrvcu vs_val_ibrvcu") year(2011)
preserve
keep source_year source_row raw_icovcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_icovcu_2011.dta") fields("val_icovcu vs_val_icovcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_idevcu_2011.dta") fields("val_idevcu vs_val_idevcu") year(2011)
preserve
keep source_year source_row raw_iinput11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinput_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinput_2011.dta") fields("val_iinput vs_val_iinput") year(2011)
preserve
keep source_year source_row raw_iinvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iinvcu_2011.dta") fields("val_iinvcu vs_val_iinvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisfov_2011.dta") fields("val_iisfov vs_val_iisfov") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iislov_2011.dta") fields("val_iislov vs_val_iislov") year(2011)
preserve
keep source_year source_row raw_iisvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iisvcu_2011.dta") fields("val_iisvcu vs_val_iisvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikivcu_2011.dta") fields("val_ikivcu vs_val_ikivcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iklvcu_2011.dta") fields("val_iklvcu vs_val_iklvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ikovcu_2011.dta") fields("val_ikovcu vs_val_ikovcu") year(2011)
preserve
keep source_year source_row raw_ilrvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ilrvcu_2011.dta") fields("val_ilrvcu vs_val_ilrvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_insvcu_2011.dta") fields("val_insvcu vs_val_insvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_intvcu_2011.dta") fields("val_intvcu vs_val_intvcu") year(2011)
preserve
keep source_year source_row raw_iotvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iotvcu_2011.dta") fields("val_iotvcu vs_val_iotvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ipkvcu_2011.dta") fields("val_ipkvcu vs_val_ipkvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iprvcu_2011.dta") fields("val_iprvcu vs_val_iprvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irdvcu_2011.dta") fields("val_irdvcu vs_val_irdvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irevcu_2011.dta") fields("val_irevcu vs_val_irevcu") year(2011)
preserve
keep source_year source_row raw_irrvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_irrvcu_2011.dta") fields("val_irrvcu vs_val_irrvcu") year(2011)
preserve
keep source_year source_row raw_itxvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_itxvcu_2011.dta") fields("val_itxvcu vs_val_itxvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_iuwvcu_2011.dta") fields("val_iuwvcu vs_val_iuwvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_nopvcu_2011.dta") fields("val_nopvcu vs_val_nopvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_othvcu_2011.dta") fields("val_othvcu vs_val_othvcu") year(2011)
preserve
keep source_year source_row raw_output11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_output_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_output_2011.dta") fields("val_output vs_val_output") year(2011)
preserve
keep source_year source_row raw_rdnvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rdnvcu_2011.dta") fields("val_rdnvcu vs_val_rdnvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_renvcu_2011.dta") fields("val_renvcu vs_val_renvcu") year(2011)
preserve
keep source_year source_row raw_rimvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rimvcu_2011.dta") fields("val_rimvcu vs_val_rimvcu") year(2011)
preserve
keep source_year source_row raw_rtlvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_rtlvcu_2011.dta") fields("val_rtlvcu vs_val_rtlvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfbvcu_2011.dta") fields("val_sfbvcu vs_val_sfbvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfcvcu_2011.dta") fields("val_sfcvcu vs_val_sfcvcu") year(2011)
preserve
keep source_year source_row raw_sfdvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfdvcu_2011.dta") fields("val_sfdvcu vs_val_sfdvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfgvcu_2011.dta") fields("val_sfgvcu vs_val_sfgvcu") year(2011)
preserve
keep source_year source_row raw_sfjvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfjvcu_2011.dta") fields("val_sfjvcu vs_val_sfjvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfkvcu_2011.dta") fields("val_sfkvcu vs_val_sfkvcu") year(2011)
preserve
keep source_year source_row raw_sfnvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfnvcu_2011.dta") fields("val_sfnvcu vs_val_sfnvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfovcu_2011.dta") fields("val_sfovcu vs_val_sfovcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfrvcu_2011.dta") fields("val_sfrvcu vs_val_sfrvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfsvcu_2011.dta") fields("val_sfsvcu vs_val_sfsvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_sfuvcu_2011.dta") fields("val_sfuvcu vs_val_sfuvcu") year(2011)
preserve
keep source_year source_row raw_shdvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shdvcu_2011.dta") fields("val_shdvcu vs_val_shdvcu") year(2011)
preserve
keep source_year source_row raw_shfvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shfvcu_2011.dta") fields("val_shfvcu vs_val_shfvcu") year(2011)
preserve
keep source_year source_row raw_shjvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_shjvcu_2011.dta") fields("val_shjvcu vs_val_shjvcu") year(2011)
preserve
keep source_year source_row raw_srdvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srdvcu_2011.dta") fields("val_srdvcu vs_val_srdvcu") year(2011)
preserve
keep source_year source_row raw_srjvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srjvcu_2011.dta") fields("val_srjvcu vs_val_srjvcu") year(2011)
preserve
keep source_year source_row raw_srmvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_srmvcu_2011.dta") fields("val_srmvcu vs_val_srmvcu") year(2011)
preserve
keep source_year source_row raw_stdvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stdvcu_2011.dta") fields("val_stdvcu vs_val_stdvcu") year(2011)
preserve
keep source_year source_row raw_stjvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stjvcu_2011.dta") fields("val_stjvcu vs_val_stjvcu") year(2011)
preserve
keep source_year source_row raw_stlvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_stlvcu_2011.dta") fields("val_stlvcu vs_val_stlvcu") year(2011)
preserve
keep source_year source_row raw_vtlvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_vtlvcu_2011.dta") fields("val_vtlvcu vs_val_vtlvcu") year(2011)
preserve
keep source_year source_row raw_yelvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yelvcu_2011.dta") fields("val_yelvcu vs_val_yelvcu") year(2011)
preserve
keep source_year source_row raw_yisvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvcu_2011.dta") fields("val_yisvcu vs_val_yisvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvdo_2011.dta") fields("val_yisvdo vs_val_yisvdo") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yisvfo_2011.dta") fields("val_yisvfo vs_val_yisvfo") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykdvcu_2011.dta") fields("val_ykdvcu vs_val_ykdvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykfvcu_2011.dta") fields("val_ykfvcu vs_val_ykfvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ykivcu_2011.dta") fields("val_ykivcu vs_val_ykivcu") year(2011)
preserve
keep source_year source_row raw_yprvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yprvcu_2011.dta") fields("val_yprvcu vs_val_yprvcu") year(2011)
preserve
keep source_year source_row raw_yrnvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrnvcu_2011.dta") fields("val_yrnvcu vs_val_yrnvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_yrsvcu_2011.dta") fields("val_yrsvcu vs_val_yrsvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2011.dta") fields("val_ysnvcu vs_val_ysnvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_ytovcu_2011.dta") fields("val_ytovcu vs_val_ytovcu") year(2011)
preserve
keep source_year source_row raw_znavcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znavcu_2011.dta") fields("val_znavcu vs_val_znavcu") year(2011)
preserve
keep source_year source_row raw_zndvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zndvcu_2011.dta") fields("val_zndvcu vs_val_zndvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znevcu_2011.dta") fields("val_znevcu vs_val_znevcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znhvcu_2011.dta") fields("val_znhvcu vs_val_znhvcu") year(2011)
preserve
keep source_year source_row raw_znivcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znivcu_2011.dta") fields("val_znivcu vs_val_znivcu") year(2011)
preserve
keep source_year source_row raw_znovcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znovcu_2011.dta") fields("val_znovcu vs_val_znovcu") year(2011)
preserve
keep source_year source_row raw_znpvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znpvcu_2011.dta") fields("val_znpvcu vs_val_znpvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znrvcu_2011.dta") fields("val_znrvcu vs_val_znrvcu") year(2011)
preserve
keep source_year source_row raw_znsvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_znsvcu_2011.dta") fields("val_znsvcu vs_val_znsvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zntvcu_2011.dta") fields("val_zntvcu vs_val_zntvcu") year(2011)
preserve
keep source_year source_row raw_zpavcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpavcu_2011.dta") fields("val_zpavcu vs_val_zpavcu") year(2011)
preserve
keep source_year source_row raw_zpdvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpdvcu_2011.dta") fields("val_zpdvcu vs_val_zpdvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpevcu_2011.dta") fields("val_zpevcu vs_val_zpevcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zphvcu_2011.dta") fields("val_zphvcu vs_val_zphvcu") year(2011)
preserve
keep source_year source_row raw_zpivcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpivcu_2011.dta") fields("val_zpivcu vs_val_zpivcu") year(2011)
preserve
keep source_year source_row raw_zpovcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpovcu_2011.dta") fields("val_zpovcu vs_val_zpovcu") year(2011)
preserve
keep source_year source_row raw_zppvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zppvcu_2011.dta") fields("val_zppvcu vs_val_zppvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zprvcu_2011.dta") fields("val_zprvcu vs_val_zprvcu") year(2011)
preserve
keep source_year source_row raw_zpsvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zpsvcu_2011.dta") fields("val_zpsvcu vs_val_zpsvcu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_val_zptvcu_2011.dta") fields("val_zptvcu vs_val_zptvcu") year(2011)
preserve
keep source_year source_row raw_vtlvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_value_added_nominal_2011.dta") fields("value_added_nominal vs_value_added_nominal") year(2011)
preserve
keep source_year source_row raw_ltlnou11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_workers_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_workers_2011.dta") fields("workers vs_workers") year(2011)
preserve
keep source_year source_row raw_kipb
cf _all using "dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_source_id_raw_2011.dta") fields("source_id_raw vs_source_id_raw") year(2011)
preserve
keep source_year source_row raw_dkabup11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_district_code_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_district_code_2011.dta") fields("district_code vs_district_code") year(2011)
preserve
keep source_year source_row raw_disic511
cf _all using "dag/data/word_data/G0/variable_year/N_G0_industry_code_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_industry_code_2011.dta") fields("industry_code vs_industry_code") year(2011)
preserve
keep source_year source_row raw_dprovi11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_province_code_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_province_code_2011.dta") fields("province_code vs_province_code") year(2011)
preserve
keep source_year source_row raw_enpkhu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_kwh_2011.dta") fields("elec_nonpln_kwh vs_elec_nonpln_kwh") year(2011)
preserve
keep source_year source_row raw_enpvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_nonpln_rp000_2011.dta") fields("elec_nonpln_rp000 vs_elec_nonpln_rp000") year(2011)
preserve
keep source_year source_row raw_esgkhu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_owngen_kwh_2011.dta") fields("elec_owngen_kwh vs_elec_owngen_kwh") year(2011)
preserve
keep source_year source_row raw_eplkhu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_kwh_2011.dta") fields("elec_pln_kwh vs_elec_pln_kwh") year(2011)
preserve
keep source_year source_row raw_eplvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_elec_pln_rp000_2011.dta") fields("elec_pln_rp000 vs_elec_pln_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_ltr_2011.dta") fields("fuel_biodiesel_ltr vs_fuel_biodiesel_ltr") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biodiesel_rp000_2011.dta") fields("fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_kg_2011.dta") fields("fuel_charcoal_kg vs_fuel_charcoal_kg") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_charcoal_rp000_2011.dta") fields("fuel_charcoal_rp000 vs_fuel_charcoal_rp000") year(2011)
preserve
keep source_year source_row raw_egam3u11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_m3_2011.dta") fields("fuel_citygas_m3 vs_fuel_citygas_m3") year(2011)
preserve
keep source_year source_row raw_egavcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_citygas_rp000_2011.dta") fields("fuel_citygas_rp000 vs_fuel_citygas_rp000") year(2011)
preserve
keep source_year source_row raw_eclkgu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_kg_2011.dta") fields("fuel_coal_kg vs_fuel_coal_kg") year(2011)
preserve
keep source_year source_row raw_eclvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coal_rp000_2011.dta") fields("fuel_coal_rp000 vs_fuel_coal_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_kg_2011.dta") fields("fuel_coalbriq_kg vs_fuel_coalbriq_kg") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coalbriq_rp000_2011.dta") fields("fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_kg_2011.dta") fields("fuel_coke_kg vs_fuel_coke_kg") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_coke_rp000_2011.dta") fields("fuel_coke_rp000 vs_fuel_coke_rp000") year(2011)
preserve
keep source_year source_row raw_esoliu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_ltr_2011.dta") fields("fuel_diesel_ltr vs_fuel_diesel_ltr") year(2011)
preserve
keep source_year source_row raw_esovcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_diesel_rp000_2011.dta") fields("fuel_diesel_rp000 vs_fuel_diesel_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_ltr_2011.dta") fields("fuel_dieseloil_ltr vs_fuel_dieseloil_ltr") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_dieseloil_rp000_2011.dta") fields("fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_kg_2011.dta") fields("fuel_firewood_kg vs_fuel_firewood_kg") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_firewood_rp000_2011.dta") fields("fuel_firewood_rp000 vs_fuel_firewood_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_ltr_2011.dta") fields("fuel_fueloil_ltr vs_fuel_fueloil_ltr") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_fueloil_rp000_2011.dta") fields("fuel_fueloil_rp000 vs_fuel_fueloil_rp000") year(2011)
preserve
keep source_year source_row raw_eoiliu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_ltr_2011.dta") fields("fuel_kerosene_ltr vs_fuel_kerosene_ltr") year(2011)
preserve
keep source_year source_row raw_eoivcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_kerosene_rp000_2011.dta") fields("fuel_kerosene_rp000 vs_fuel_kerosene_rp000") year(2011)
preserve
keep source_year source_row raw_elpkgu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_kg_2011.dta") fields("fuel_lpg_kg vs_fuel_lpg_kg") year(2011)
preserve
keep source_year source_row raw_elpvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lpg_rp000_2011.dta") fields("fuel_lpg_rp000 vs_fuel_lpg_rp000") year(2011)
preserve
keep source_year source_row raw_eluliu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_ltr_2011.dta") fields("fuel_lubricant_ltr vs_fuel_lubricant_ltr") year(2011)
preserve
keep source_year source_row raw_eluvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_lubricant_rp000_2011.dta") fields("fuel_lubricant_rp000 vs_fuel_lubricant_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_kg_2011.dta") fields("fuel_natgas_kg vs_fuel_natgas_kg") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_rp000_2011.dta") fields("fuel_natgas_rp000 vs_fuel_natgas_rp000") year(2011)
preserve
keep source_year source_row raw_encvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_other_rp000_2011.dta") fields("fuel_other_rp000 vs_fuel_other_rp000") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_m3_2011.dta") fields("fuel_othergas_m3 vs_fuel_othergas_m3") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_othergas_rp000_2011.dta") fields("fuel_othergas_rp000 vs_fuel_othergas_rp000") year(2011)
preserve
keep source_year source_row raw_epeliu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_ltr_2011.dta") fields("fuel_petrol_ltr vs_fuel_petrol_ltr") year(2011)
preserve
keep source_year source_row raw_epevcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_petrol_rp000_2011.dta") fields("fuel_petrol_rp000 vs_fuel_petrol_rp000") year(2011)
preserve
keep source_year source_row raw_efuvcu11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_total_reported_rp000_2011.dta") fields("fuel_total_reported_rp000 vs_fuel_total_reported_rp000") year(2011)
preserve
keep source_year source_row raw_ekspor11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_any_binary_2011.dta") fields("export_any_binary vs_export_any_binary") year(2011)
preserve
keep source_year source_row raw_ekspor11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_export_direct_flag_2011.dta") fields("export_direct_flag vs_export_direct_flag") year(2011)
preserve
keep source_year source_row raw_resech11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_activity_flag_2011.dta") fields("rd_activity_flag vs_rd_activity_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_rd_external_funding_flag_2011.dta") fields("rd_external_funding_flag vs_rd_external_funding_flag") year(2011)
preserve
keep source_year source_row raw_innova11
cf _all using "dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2011.dta", all
* Kembalikan semua kolom wave setelah pemeriksaan sementara; kolom yang dibandingkan tidak menggantikan data utama. // WFDOC-INJECTED
restore
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_innovation_flag_2011.dta") fields("innovation_flag vs_innovation_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2011.dta") fields("env_amdal_flag vs_env_amdal_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_ukl_upl_flag_2011.dta") fields("env_ukl_upl_flag vs_env_ukl_upl_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_sppl_flag_2011.dta") fields("env_sppl_flag vs_env_sppl_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_env_waste_treatment_flag_2011.dta") fields("env_waste_treatment_flag vs_env_waste_treatment_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_solid_flag_2011.dta") fields("waste_solid_flag vs_waste_solid_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_liquid_flag_2011.dta") fields("waste_liquid_flag vs_waste_liquid_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_waste_hazardous_flag_2011.dta") fields("waste_hazardous_flag vs_waste_hazardous_flag") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_natgas_mmbtu_2011.dta") fields("fuel_natgas_mmbtu vs_fuel_natgas_mmbtu") year(2011)
* Sebelum merge, periksa bahwa kedua berkas berada pada tahun yang diminta, kunci tahun/baris unik, kolom tujuan belum ada, dan setiap baris punya pasangan. // WFDOC-INJECTED
wf_merge_guard, using("dag/data/word_data/G0/variable_year/N_G0_fuel_biomass_kg_2011.dta") fields("fuel_biomass_kg vs_fuel_biomass_kg") year(2011)
isid source_year source_row
* Simpan wave setelah seluruh pemetaan dan pemeriksaan kunci selesai. // WFDOC-INJECTED
save "data/intermediate/mapped_wave_2011.dta", replace
