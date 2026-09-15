* Tujuan: Siapkan berkas kompatibilitas yang diperlukan oleh langkah kerja berikut dari data intermediate. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; dag/edges/word_rows/G0/G0_03_map_economic_fields.do; dan 8 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_03_map_economic_fields.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_03_map_economic_fields.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_04_validate_real_identifiers.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_05_map_geography_industry.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_05_map_geography_industry.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_08_construct_energy_emissions.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_09_construct_ratios_logs.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_10_assemble_main_dataset.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_integrate_verified_candidate.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do" "$WFROOT" "dag/data/word_data/G0/G0_main_candidate.dta"
display "WF_STAGE_F050_PASS"
