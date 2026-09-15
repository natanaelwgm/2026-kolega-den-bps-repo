* Tujuan: Bandingkan tabel laporan saat ini dengan hasil G0-rebuild; untuk tabel pekerja, cocokkan baris dengan kunci source_year dan ratio yang unik. // WFDOC-INJECTED
* Input: corrections/reports/*.dta dan tabel pembanding pada work/G0-rebuild/corrections/reports. // WFDOC-INJECTED
* Output: penanda WF_REPORT_VALUES_30_EXACT hanya setelah seluruh tabel lolos perbandingan; nilai laporan tidak dihitung ulang atau disimpan ulang. // WFDOC-INJECTED
* Pada tabel pekerja, sort hanya mengurutkan baris untuk pencocokan; pasangan kunci ganda menghentikan validasi. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "corrections/reports/annual_sample.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/annual_sample.dta", all
use "corrections/reports/annual_schema_mapping.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/annual_schema_mapping.dta", all
use "corrections/reports/capital_definition_coverage.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/capital_definition_coverage.dta", all
use "corrections/reports/change_audit.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/change_audit.dta", all
use "corrections/reports/classification_acceptance.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/classification_acceptance.dta", all
use "corrections/reports/company_price_gate.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/company_price_gate.dta", all
use "corrections/reports/completion_gate.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/completion_gate.dta", all
use "corrections/reports/core_descriptive_statistics.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/core_descriptive_statistics.dta", all
use "corrections/reports/dictionary_all_columns.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/dictionary_all_columns.dta", all
use "corrections/reports/electricity_and_own_generation.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/electricity_and_own_generation.dta", all
use "corrections/reports/energy_component_coverage.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/energy_component_coverage.dta", all
use "corrections/reports/energy_cost_reconciliation.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/energy_cost_reconciliation.dta", all
use "corrections/reports/export_definition_states.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/export_definition_states.dta", all
use "corrections/reports/flag_rates.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/flag_rates.dta", all
use "corrections/reports/fuel_unit_acceptance.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/fuel_unit_acceptance.dta", all
use "corrections/reports/grid_assumption_coverage.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/grid_assumption_coverage.dta", all
use "corrections/reports/identity_acceptance.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/identity_acceptance.dta", all
use "corrections/reports/log_domain_losses.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/log_domain_losses.dta", all
use "corrections/reports/nominal_real_gate.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/nominal_real_gate.dta", all
use "corrections/reports/outlier_sensitivity.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/outlier_sensitivity.dta", all
use "corrections/reports/outlier_signed_thresholds.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/outlier_signed_thresholds.dta", all
use "corrections/reports/rd_definition_states.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/rd_definition_states.dta", all
use "corrections/reports/reported_accounting_diagnostics.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/reported_accounting_diagnostics.dta", all
use "corrections/reports/source_inventory.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_inventory.dta", all
use "corrections/reports/source_lineage.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_lineage.dta", all
use "corrections/reports/source_state_counts.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/source_state_counts.dta", all
use "corrections/reports/variable_year_acceptance.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/variable_year_acceptance.dta", all
use "corrections/reports/variable_year_release_status.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/variable_year_release_status.dta", all
* Buka tabel worker_denominator_domains saat ini; tabel ini dibandingkan per pasangan tahun dan ratio. // WFDOC-INJECTED
use "corrections/reports/worker_denominator_domains.dta", clear
* Bandingkan menurut kunci unik tahun dan rasio; urutan ikatan hasil merge bukan bagian dari nilai tabel.
* Pastikan setiap pasangan tahun dan rasio hanya muncul sekali sebelum membandingkan tabel. // WFDOC-INJECTED
* Wajibkan source_year+ratio unik; jika pasangan ini berulang, hentikan validasi karena baris pembanding tidak dapat dipasangkan satu lawan satu. // WFDOC-INJECTED
isid source_year ratio
* Urutkan menurut kunci tahun dan rasio yang sama pada kedua tabel; jangan mengubah nilai tabel. // WFDOC-INJECTED
* Urutkan tabel saat ini menurut kunci itu supaya baris yang sama berada pada urutan yang sama; nilai tidak diubah. // WFDOC-INJECTED
sort source_year ratio
* Sediakan nama berkas sementara untuk pembanding pekerja yang sudah diurutkan. // WFDOC-INJECTED
tempfile sorted_worker_witness
* Simpan sementara tabel baru di memori ketika menyiapkan urutan pembanding. // WFDOC-INJECTED
* Simpan salinan sementara tabel saat ini sebelum membuka pembanding. // WFDOC-INJECTED
preserve
* Buka tabel pekerja dari hasil G0-rebuild sebagai pembanding; nilai tabel ini hanya dibaca. // WFDOC-INJECTED
use "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/worker_denominator_domains.dta", clear
* Pastikan setiap pasangan tahun dan rasio hanya muncul sekali sebelum membandingkan tabel. // WFDOC-INJECTED
* Periksa kunci source_year+ratio pembanding juga unik. // WFDOC-INJECTED
isid source_year ratio
* Urutkan menurut kunci tahun dan rasio yang sama pada kedua tabel; jangan mengubah nilai tabel. // WFDOC-INJECTED
* Urutkan pembanding memakai kunci yang sama agar urutan baris sejalan. // WFDOC-INJECTED
sort source_year ratio
* Simpan pembanding yang sudah diurutkan agar pemeriksaan berikutnya memakai pasangan baris yang tepat. // WFDOC-INJECTED
* Simpan versi terurut pembanding ke tempfile untuk pemeriksaan berikut. // WFDOC-INJECTED
save `sorted_worker_witness'
* Kembalikan tabel baru ke memori, lalu bandingkan dengan pembanding yang sudah diurutkan. // WFDOC-INJECTED
* Pulihkan tabel saat ini dari preserve; tidak ada angka laporan yang diganti. // WFDOC-INJECTED
restore
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
* Bandingkan semua kolom tabel saat ini dengan pembanding terurut; perbedaan nilai atau kolom menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using `sorted_worker_witness', all
use "corrections/reports/wpi_reference.dta", clear
* Bandingkan semua kolom dengan pembanding; satu nilai berbeda sudah cukup untuk menggagalkan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/reports/wpi_reference.dta", all
* Tampilkan tanda lulus setelah seluruh 30 tabel cocok. // WFDOC-INJECTED
display "WF_REPORT_VALUES_30_EXACT"
