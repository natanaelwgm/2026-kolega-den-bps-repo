* Tujuan: Jalankan laporan publikasi dari master analisis setelah file wave siap. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; code/reports/rebuild_legacy_coverage.do; dan 32 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L1:step-do" "code/stages/F090_reports.do:L1:file" "statement" 1 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L1:step-do" "code/stages/F090_reports.do:L1:file" "statement" 1 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L2:step-do" "code/stages/F090_reports.do:L1:file" "statement" 2 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/reports/rebuild_legacy_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_legacy_coverage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L2:step-do" "code/stages/F090_reports.do:L1:file" "statement" 2 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L3:step-do" "code/stages/F090_reports.do:L1:file" "statement" 3 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/reports/rebuild_source_counts.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_source_counts.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L3:step-do" "code/stages/F090_reports.do:L1:file" "statement" 3 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L4:step-do" "code/stages/F090_reports.do:L1:file" "statement" 4 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/reports/rebuild_signed_thresholds.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/rebuild_signed_thresholds.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L4:step-do" "code/stages/F090_reports.do:L1:file" "statement" 4 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L5:step-do" "code/stages/F090_reports.do:L1:file" "statement" 5 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C150_change_audit.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C150_change_audit.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L5:step-do" "code/stages/F090_reports.do:L1:file" "statement" 5 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L6:step-do" "code/stages/F090_reports.do:L1:file" "statement" 6 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C160_publication_summaries.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C160_publication_summaries.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L6:step-do" "code/stages/F090_reports.do:L1:file" "statement" 6 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L7:step-do" "code/stages/F090_reports.do:L1:file" "statement" 7 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C170_flag_rates.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C170_flag_rates.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L7:step-do" "code/stages/F090_reports.do:L1:file" "statement" 7 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L8:step-do" "code/stages/F090_reports.do:L1:file" "statement" 8 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X01_source_lineage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X01_source_lineage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L8:step-do" "code/stages/F090_reports.do:L1:file" "statement" 8 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L9:step-do" "code/stages/F090_reports.do:L1:file" "statement" 9 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X02_annual_sample.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X02_annual_sample.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L9:step-do" "code/stages/F090_reports.do:L1:file" "statement" 9 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L10:step-do" "code/stages/F090_reports.do:L1:file" "statement" 10 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X03_source_inventory.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X03_source_inventory.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L10:step-do" "code/stages/F090_reports.do:L1:file" "statement" 10 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L11:step-do" "code/stages/F090_reports.do:L1:file" "statement" 11 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X04_variable_year_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X04_variable_year_acceptance.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L11:step-do" "code/stages/F090_reports.do:L1:file" "statement" 11 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L12:step-do" "code/stages/F090_reports.do:L1:file" "statement" 12 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X05_annual_schema_mapping.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X05_annual_schema_mapping.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L12:step-do" "code/stages/F090_reports.do:L1:file" "statement" 12 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L13:step-do" "code/stages/F090_reports.do:L1:file" "statement" 13 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X06_source_state_counts.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X06_source_state_counts.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L13:step-do" "code/stages/F090_reports.do:L1:file" "statement" 13 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L14:step-do" "code/stages/F090_reports.do:L1:file" "statement" 14 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X07_reported_accounting_diagnostics.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X07_reported_accounting_diagnostics.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L14:step-do" "code/stages/F090_reports.do:L1:file" "statement" 14 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L15:step-do" "code/stages/F090_reports.do:L1:file" "statement" 15 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X08_worker_denominator_domains.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X08_worker_denominator_domains.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L15:step-do" "code/stages/F090_reports.do:L1:file" "statement" 15 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L16:step-do" "code/stages/F090_reports.do:L1:file" "statement" 16 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X09_capital_definition_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X09_capital_definition_coverage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L16:step-do" "code/stages/F090_reports.do:L1:file" "statement" 16 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L17:step-do" "code/stages/F090_reports.do:L1:file" "statement" 17 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X10_log_domain_losses.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X10_log_domain_losses.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L17:step-do" "code/stages/F090_reports.do:L1:file" "statement" 17 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L18:step-do" "code/stages/F090_reports.do:L1:file" "statement" 18 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X11_outlier_sensitivity.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X11_outlier_sensitivity.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L18:step-do" "code/stages/F090_reports.do:L1:file" "statement" 18 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L19:step-do" "code/stages/F090_reports.do:L1:file" "statement" 19 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X12_export_definition_states.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X12_export_definition_states.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L19:step-do" "code/stages/F090_reports.do:L1:file" "statement" 19 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L20:step-do" "code/stages/F090_reports.do:L1:file" "statement" 20 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X13_rd_definition_states.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X13_rd_definition_states.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L20:step-do" "code/stages/F090_reports.do:L1:file" "statement" 20 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L21:step-do" "code/stages/F090_reports.do:L1:file" "statement" 21 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X14_identity_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X14_identity_acceptance.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L21:step-do" "code/stages/F090_reports.do:L1:file" "statement" 21 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L22:step-do" "code/stages/F090_reports.do:L1:file" "statement" 22 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X15_classification_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X15_classification_acceptance.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L22:step-do" "code/stages/F090_reports.do:L1:file" "statement" 22 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L23:step-do" "code/stages/F090_reports.do:L1:file" "statement" 23 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X16_wpi_reference.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X16_wpi_reference.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L23:step-do" "code/stages/F090_reports.do:L1:file" "statement" 23 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L24:step-do" "code/stages/F090_reports.do:L1:file" "statement" 24 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X17_company_price_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X17_company_price_gate.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L24:step-do" "code/stages/F090_reports.do:L1:file" "statement" 24 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L25:step-do" "code/stages/F090_reports.do:L1:file" "statement" 25 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X18_nominal_real_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X18_nominal_real_gate.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L25:step-do" "code/stages/F090_reports.do:L1:file" "statement" 25 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L26:step-do" "code/stages/F090_reports.do:L1:file" "statement" 26 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X19_fuel_unit_acceptance.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X19_fuel_unit_acceptance.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L26:step-do" "code/stages/F090_reports.do:L1:file" "statement" 26 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L27:step-do" "code/stages/F090_reports.do:L1:file" "statement" 27 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X20_energy_component_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X20_energy_component_coverage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L27:step-do" "code/stages/F090_reports.do:L1:file" "statement" 27 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L28:step-do" "code/stages/F090_reports.do:L1:file" "statement" 28 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X21_electricity_and_own_generation.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X21_electricity_and_own_generation.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L28:step-do" "code/stages/F090_reports.do:L1:file" "statement" 28 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L29:step-do" "code/stages/F090_reports.do:L1:file" "statement" 29 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X22_grid_assumption_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X22_grid_assumption_coverage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L29:step-do" "code/stages/F090_reports.do:L1:file" "statement" 29 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L30:step-do" "code/stages/F090_reports.do:L1:file" "statement" 30 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X23_energy_cost_reconciliation.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X23_energy_cost_reconciliation.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L30:step-do" "code/stages/F090_reports.do:L1:file" "statement" 30 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L31:step-do" "code/stages/F090_reports.do:L1:file" "statement" 31 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_X24_completion_gate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_X24_completion_gate.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L31:step-do" "code/stages/F090_reports.do:L1:file" "statement" 31 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L32:step-do" "code/stages/F090_reports.do:L1:file" "statement" 32 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/publication/G0_support_dictionary.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/publication/G0_support_dictionary.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L32:step-do" "code/stages/F090_reports.do:L1:file" "statement" 32 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L33:step-do" "code/stages/F090_reports.do:L1:file" "statement" 33 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C180_export_roundtrip.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C180_export_roundtrip.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L33:step-do" "code/stages/F090_reports.do:L1:file" "statement" 33 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L34:step-do" "code/stages/F090_reports.do:L1:file" "statement" 34 35 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/reports/new_token_field_coverage.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/reports/new_token_field_coverage.do"
capture noisily __wf_progress end "code/stages/F090_reports.do:L34:step-do" "code/stages/F090_reports.do:L1:file" "statement" 34 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F090_reports.do:L35:step-display" "code/stages/F090_reports.do:L1:file" "statement" 35 35 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F090_REPORTS_PASS"
capture noisily __wf_progress end "code/stages/F090_reports.do:L35:step-display" "code/stages/F090_reports.do:L1:file" "statement" 35 35 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F090_reports.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
