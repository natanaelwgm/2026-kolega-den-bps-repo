* Tujuan: Jalankan laporan publikasi dari master analisis setelah file wave siap. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; code/reports/rebuild_legacy_coverage.do; dan 32 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Jalankan tahap/berkas anak code/reports/rebuild_legacy_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_legacy_coverage.do"
* Jalankan tahap/berkas anak code/reports/rebuild_source_counts.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_source_counts.do"
* Jalankan tahap/berkas anak code/reports/rebuild_signed_thresholds.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_signed_thresholds.do"
* Jalankan tahap/berkas anak rows/G0/corrections/C150_change_audit.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C150_change_audit.do"
* Jalankan tahap/berkas anak rows/G0/corrections/C160_publication_summaries.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C160_publication_summaries.do"
* Jalankan tahap/berkas anak rows/G0/corrections/C170_flag_rates.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C170_flag_rates.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X01_source_lineage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X01_source_lineage.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X02_annual_sample.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X02_annual_sample.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X03_source_inventory.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X03_source_inventory.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X04_variable_year_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X04_variable_year_acceptance.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X05_annual_schema_mapping.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X05_annual_schema_mapping.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X06_source_state_counts.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X06_source_state_counts.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X07_reported_accounting_diagnostics.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X08_worker_denominator_domains.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X08_worker_denominator_domains.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X09_capital_definition_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X09_capital_definition_coverage.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X10_log_domain_losses.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X10_log_domain_losses.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X11_outlier_sensitivity.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X11_outlier_sensitivity.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X12_export_definition_states.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X12_export_definition_states.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X13_rd_definition_states.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X13_rd_definition_states.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X14_identity_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X14_identity_acceptance.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X15_classification_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X15_classification_acceptance.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X16_wpi_reference.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X16_wpi_reference.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X17_company_price_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X17_company_price_gate.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X18_nominal_real_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X18_nominal_real_gate.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X19_fuel_unit_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X19_fuel_unit_acceptance.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X20_energy_component_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X20_energy_component_coverage.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X21_electricity_and_own_generation.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X21_electricity_and_own_generation.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X22_grid_assumption_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X22_grid_assumption_coverage.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X23_energy_cost_reconciliation.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X23_energy_cost_reconciliation.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_X24_completion_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X24_completion_gate.do"
* Jalankan tahap/berkas anak rows/G0/publication/G0_support_dictionary.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_support_dictionary.do"
* Jalankan tahap/berkas anak rows/G0/corrections/C180_export_roundtrip.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C180_export_roundtrip.do"
* Jalankan tahap/berkas anak code/reports/new_token_field_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/new_token_field_coverage.do"
display "WF_STAGE_F090_REPORTS_PASS"
