* Tujuan: Bandingkan tabel laporan saat ini dengan hasil G0-rebuild; untuk tabel pekerja, cocokkan baris dengan kunci source_year dan ratio yang unik. // WFDOC-INJECTED
* Input: corrections/reports/*.dta dan tabel pembanding pada work/G0-rebuild/corrections/reports. // WFDOC-INJECTED
* Output: penanda WF_REPORT_VALUES_30_EXACT hanya setelah seluruh tabel lolos perbandingan; nilai laporan tidak dihitung ulang atau disimpan ulang. // WFDOC-INJECTED
* Pada tabel pekerja, sort hanya mengurutkan baris untuk pencocokan; pasangan kunci ganda menghentikan validasi. // WFDOC-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L1:step-do" "code/validation/compare_reports.do:L1:file" "statement" 1 71 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/validation/compare_reports.do:L1:step-do" "code/validation/compare_reports.do:L1:file" "statement" 1 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L2:step-use" "code/validation/compare_reports.do:L1:file" "statement" 2 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/annual_sample.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L2:step-use" "code/validation/compare_reports.do:L1:file" "statement" 2 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L3:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 3 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/annual_sample.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L3:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 3 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L4:step-use" "code/validation/compare_reports.do:L1:file" "statement" 4 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/annual_schema_mapping.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L4:step-use" "code/validation/compare_reports.do:L1:file" "statement" 4 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L5:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 5 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/annual_schema_mapping.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L5:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 5 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L6:step-use" "code/validation/compare_reports.do:L1:file" "statement" 6 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/capital_definition_coverage.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L6:step-use" "code/validation/compare_reports.do:L1:file" "statement" 6 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L7:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 7 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/capital_definition_coverage.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L7:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 7 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L8:step-use" "code/validation/compare_reports.do:L1:file" "statement" 8 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/change_audit.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L8:step-use" "code/validation/compare_reports.do:L1:file" "statement" 8 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L9:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 9 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/change_audit.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L9:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 9 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L10:step-use" "code/validation/compare_reports.do:L1:file" "statement" 10 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/classification_acceptance.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L10:step-use" "code/validation/compare_reports.do:L1:file" "statement" 10 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L11:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 11 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/classification_acceptance.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L11:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 11 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L12:step-use" "code/validation/compare_reports.do:L1:file" "statement" 12 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/company_price_gate.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L12:step-use" "code/validation/compare_reports.do:L1:file" "statement" 12 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L13:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 13 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/company_price_gate.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L13:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 13 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L14:step-use" "code/validation/compare_reports.do:L1:file" "statement" 14 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/completion_gate.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L14:step-use" "code/validation/compare_reports.do:L1:file" "statement" 14 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L15:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 15 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/completion_gate.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L15:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 15 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L16:step-use" "code/validation/compare_reports.do:L1:file" "statement" 16 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/core_descriptive_statistics.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L16:step-use" "code/validation/compare_reports.do:L1:file" "statement" 16 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L17:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 17 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/core_descriptive_statistics.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L17:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 17 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L18:step-use" "code/validation/compare_reports.do:L1:file" "statement" 18 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/dictionary_all_columns.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L18:step-use" "code/validation/compare_reports.do:L1:file" "statement" 18 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L19:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 19 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/dictionary_all_columns.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L19:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 19 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L20:step-use" "code/validation/compare_reports.do:L1:file" "statement" 20 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/electricity_and_own_generation.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L20:step-use" "code/validation/compare_reports.do:L1:file" "statement" 20 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L21:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 21 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/electricity_and_own_generation.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L21:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 21 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L22:step-use" "code/validation/compare_reports.do:L1:file" "statement" 22 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/energy_component_coverage.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L22:step-use" "code/validation/compare_reports.do:L1:file" "statement" 22 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L23:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 23 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/energy_component_coverage.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L23:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 23 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L24:step-use" "code/validation/compare_reports.do:L1:file" "statement" 24 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/energy_cost_reconciliation.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L24:step-use" "code/validation/compare_reports.do:L1:file" "statement" 24 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L25:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 25 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/energy_cost_reconciliation.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L25:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 25 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L26:step-use" "code/validation/compare_reports.do:L1:file" "statement" 26 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/export_definition_states.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L26:step-use" "code/validation/compare_reports.do:L1:file" "statement" 26 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L27:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 27 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/export_definition_states.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L27:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 27 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L28:step-use" "code/validation/compare_reports.do:L1:file" "statement" 28 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/flag_rates.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L28:step-use" "code/validation/compare_reports.do:L1:file" "statement" 28 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L29:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 29 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/flag_rates.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L29:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 29 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L30:step-use" "code/validation/compare_reports.do:L1:file" "statement" 30 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/fuel_unit_acceptance.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L30:step-use" "code/validation/compare_reports.do:L1:file" "statement" 30 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L31:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 31 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/fuel_unit_acceptance.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L31:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 31 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L32:step-use" "code/validation/compare_reports.do:L1:file" "statement" 32 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/grid_assumption_coverage.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L32:step-use" "code/validation/compare_reports.do:L1:file" "statement" 32 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L33:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 33 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/grid_assumption_coverage.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L33:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 33 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L34:step-use" "code/validation/compare_reports.do:L1:file" "statement" 34 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/identity_acceptance.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L34:step-use" "code/validation/compare_reports.do:L1:file" "statement" 34 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L35:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 35 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/identity_acceptance.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L35:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 35 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L36:step-use" "code/validation/compare_reports.do:L1:file" "statement" 36 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/log_domain_losses.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L36:step-use" "code/validation/compare_reports.do:L1:file" "statement" 36 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L37:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 37 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/log_domain_losses.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L37:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 37 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L38:step-use" "code/validation/compare_reports.do:L1:file" "statement" 38 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/nominal_real_gate.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L38:step-use" "code/validation/compare_reports.do:L1:file" "statement" 38 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L39:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 39 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/nominal_real_gate.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L39:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 39 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L40:step-use" "code/validation/compare_reports.do:L1:file" "statement" 40 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/outlier_sensitivity.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L40:step-use" "code/validation/compare_reports.do:L1:file" "statement" 40 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L41:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 41 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/outlier_sensitivity.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L41:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 41 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L42:step-use" "code/validation/compare_reports.do:L1:file" "statement" 42 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/outlier_signed_thresholds.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L42:step-use" "code/validation/compare_reports.do:L1:file" "statement" 42 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L43:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 43 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/outlier_signed_thresholds.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L43:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 43 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L44:step-use" "code/validation/compare_reports.do:L1:file" "statement" 44 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/rd_definition_states.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L44:step-use" "code/validation/compare_reports.do:L1:file" "statement" 44 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L45:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 45 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/rd_definition_states.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L45:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 45 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L46:step-use" "code/validation/compare_reports.do:L1:file" "statement" 46 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/reported_accounting_diagnostics.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L46:step-use" "code/validation/compare_reports.do:L1:file" "statement" 46 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L47:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 47 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/reported_accounting_diagnostics.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L47:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 47 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L48:step-use" "code/validation/compare_reports.do:L1:file" "statement" 48 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/source_inventory.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L48:step-use" "code/validation/compare_reports.do:L1:file" "statement" 48 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L49:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 49 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_inventory.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L49:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 49 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L50:step-use" "code/validation/compare_reports.do:L1:file" "statement" 50 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/source_lineage.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L50:step-use" "code/validation/compare_reports.do:L1:file" "statement" 50 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L51:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 51 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_lineage.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L51:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 51 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L52:step-use" "code/validation/compare_reports.do:L1:file" "statement" 52 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/source_state_counts.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L52:step-use" "code/validation/compare_reports.do:L1:file" "statement" 52 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L53:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 53 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_state_counts.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L53:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 53 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L54:step-use" "code/validation/compare_reports.do:L1:file" "statement" 54 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/variable_year_acceptance.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L54:step-use" "code/validation/compare_reports.do:L1:file" "statement" 54 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L55:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 55 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/variable_year_acceptance.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L55:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 55 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L56:step-use" "code/validation/compare_reports.do:L1:file" "statement" 56 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/variable_year_release_status.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L56:step-use" "code/validation/compare_reports.do:L1:file" "statement" 56 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L57:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 57 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/variable_year_release_status.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L57:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 57 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L58:step-use" "code/validation/compare_reports.do:L1:file" "statement" 58 71 `=_rc' // WFLOG-INJECTED
* Buka tabel worker_denominator_domains saat ini; tabel ini dibandingkan per pasangan tahun dan ratio. // WFDOC-INJECTED
use "corrections/reports/worker_denominator_domains.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L58:step-use" "code/validation/compare_reports.do:L1:file" "statement" 58 71 `=_rc' // WFLOG-INJECTED
* Bandingkan menurut kunci unik tahun dan rasio; urutan ikatan hasil merge bukan bagian dari nilai tabel.
capture noisily __wf_progress start "code/validation/compare_reports.do:L60:step-isid" "code/validation/compare_reports.do:L1:file" "statement" 59 71 `=_rc' // WFLOG-INJECTED
* Pastikan setiap pasangan tahun dan rasio hanya muncul sekali sebelum membandingkan tabel. // WFDOC-INJECTED
* Wajibkan source_year+ratio unik; jika pasangan ini berulang, hentikan validasi karena baris pembanding tidak dapat dipasangkan satu lawan satu. // WFDOC-INJECTED
isid source_year ratio
capture noisily __wf_progress end "code/validation/compare_reports.do:L60:step-isid" "code/validation/compare_reports.do:L1:file" "statement" 59 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L61:step-sort" "code/validation/compare_reports.do:L1:file" "statement" 60 71 `=_rc' // WFLOG-INJECTED
* Urutkan menurut kunci tahun dan rasio yang sama pada kedua tabel; jangan mengubah nilai tabel. // WFDOC-INJECTED
* Urutkan tabel saat ini menurut kunci itu supaya baris yang sama berada pada urutan yang sama; nilai tidak diubah. // WFDOC-INJECTED
sort source_year ratio
capture noisily __wf_progress end "code/validation/compare_reports.do:L61:step-sort" "code/validation/compare_reports.do:L1:file" "statement" 60 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L62:step-tempfile" "code/validation/compare_reports.do:L1:file" "statement" 61 71 `=_rc' // WFLOG-INJECTED
* Sediakan nama berkas sementara untuk pembanding pekerja yang sudah diurutkan. // WFDOC-INJECTED
tempfile sorted_worker_witness
capture noisily __wf_progress end "code/validation/compare_reports.do:L62:step-tempfile" "code/validation/compare_reports.do:L1:file" "statement" 61 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L63:step-preserve" "code/validation/compare_reports.do:L1:file" "statement" 62 71 `=_rc' // WFLOG-INJECTED
* Simpan sementara tabel baru di memori ketika menyiapkan urutan pembanding. // WFDOC-INJECTED
* Simpan salinan sementara tabel saat ini sebelum membuka pembanding. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "code/validation/compare_reports.do:L63:step-preserve" "code/validation/compare_reports.do:L1:file" "statement" 62 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L64:step-use" "code/validation/compare_reports.do:L1:file" "statement" 63 71 `=_rc' // WFLOG-INJECTED
* Buka tabel pekerja dari hasil G0-rebuild sebagai pembanding; nilai tabel ini hanya dibaca. // WFDOC-INJECTED
use "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/worker_denominator_domains.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L64:step-use" "code/validation/compare_reports.do:L1:file" "statement" 63 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L65:step-isid" "code/validation/compare_reports.do:L1:file" "statement" 64 71 `=_rc' // WFLOG-INJECTED
* Pastikan setiap pasangan tahun dan rasio hanya muncul sekali sebelum membandingkan tabel. // WFDOC-INJECTED
* Periksa kunci source_year+ratio pembanding juga unik. // WFDOC-INJECTED
isid source_year ratio
capture noisily __wf_progress end "code/validation/compare_reports.do:L65:step-isid" "code/validation/compare_reports.do:L1:file" "statement" 64 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L66:step-sort" "code/validation/compare_reports.do:L1:file" "statement" 65 71 `=_rc' // WFLOG-INJECTED
* Urutkan menurut kunci tahun dan rasio yang sama pada kedua tabel; jangan mengubah nilai tabel. // WFDOC-INJECTED
* Urutkan pembanding memakai kunci yang sama agar urutan baris sejalan. // WFDOC-INJECTED
sort source_year ratio
capture noisily __wf_progress end "code/validation/compare_reports.do:L66:step-sort" "code/validation/compare_reports.do:L1:file" "statement" 65 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L67:step-save" "code/validation/compare_reports.do:L1:file" "statement" 66 71 `=_rc' // WFLOG-INJECTED
* Simpan pembanding yang sudah diurutkan agar pemeriksaan berikutnya memakai pasangan baris yang tepat. // WFDOC-INJECTED
* Simpan versi terurut pembanding ke tempfile untuk pemeriksaan berikut. // WFDOC-INJECTED
save `sorted_worker_witness'
capture noisily __wf_progress end "code/validation/compare_reports.do:L67:step-save" "code/validation/compare_reports.do:L1:file" "statement" 66 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L68:step-restore" "code/validation/compare_reports.do:L1:file" "statement" 67 71 `=_rc' // WFLOG-INJECTED
* Kembalikan tabel baru ke memori, lalu bandingkan dengan pembanding yang sudah diurutkan. // WFDOC-INJECTED
* Pulihkan tabel saat ini dari preserve; tidak ada angka laporan yang diganti. // WFDOC-INJECTED
restore
capture noisily __wf_progress end "code/validation/compare_reports.do:L68:step-restore" "code/validation/compare_reports.do:L1:file" "statement" 67 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L69:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 68 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
* Bandingkan semua kolom tabel saat ini dengan pembanding terurut; perbedaan nilai atau kolom menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using `sorted_worker_witness', all
capture noisily __wf_progress end "code/validation/compare_reports.do:L69:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 68 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L70:step-use" "code/validation/compare_reports.do:L1:file" "statement" 69 71 `=_rc' // WFLOG-INJECTED
use "corrections/reports/wpi_reference.dta", clear
capture noisily __wf_progress end "code/validation/compare_reports.do:L70:step-use" "code/validation/compare_reports.do:L1:file" "statement" 69 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L71:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 70 71 `=_rc' // WFLOG-INJECTED
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/wpi_reference.dta", all
capture noisily __wf_progress end "code/validation/compare_reports.do:L71:step-cf" "code/validation/compare_reports.do:L1:file" "statement" 70 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/compare_reports.do:L72:step-display" "code/validation/compare_reports.do:L1:file" "statement" 71 71 `=_rc' // WFLOG-INJECTED
* Tampilkan tanda lulus setelah seluruh 30 tabel cocok. // WFDOC-INJECTED
display "WF_REPORT_VALUES_30_EXACT"
capture noisily __wf_progress end "code/validation/compare_reports.do:L72:step-display" "code/validation/compare_reports.do:L1:file" "statement" 71 71 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/validation/compare_reports.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
