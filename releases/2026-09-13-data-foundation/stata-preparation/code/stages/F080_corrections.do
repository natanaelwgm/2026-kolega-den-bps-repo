* Tujuan: Jalankan urutan koreksi, domain, dan ringkasan yang tercantum untuk membentuk pendamping analisis. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; rows/G0/corrections/_utils.do; dan 371 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L1:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 1 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L1:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 1 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L2:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 2 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/_utils.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L2:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 2 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L3:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 3 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/G0_known_answer_fixtures.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/G0_known_answer_fixtures.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L3:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 3 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L4:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 4 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C010_bind_baseline.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C010_bind_baseline.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L4:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 4 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L5:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 5 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C020_va_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C020_va_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L5:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 5 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L6:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 6 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C071_ratio_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C071_ratio_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L6:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 6 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L7:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 7 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C090_own_generation_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C090_own_generation_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L7:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 7 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L8:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 8 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C130_price_flag_scope.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C130_price_flag_scope.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L8:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 8 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L9:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 9 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C061_energy_cost_subtotal.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C061_energy_cost_subtotal.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L9:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 9 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L10:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 10 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT001_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT001_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L10:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 10 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L11:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 11 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT002_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT002_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L11:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 11 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L12:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 12 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT004_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT004_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L12:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 12 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L13:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 13 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR002_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR002_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L13:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 13 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L14:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 14 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR003_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR003_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L14:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 14 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L15:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 15 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR004_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR004_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L15:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 15 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L16:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 16 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR005_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR005_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L16:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 16 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L17:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 17 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR009_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR009_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L17:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 17 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L18:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 18 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR010_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR010_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L18:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 18 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L19:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 19 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR011_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR011_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L19:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 19 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L20:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 20 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR012_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR012_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L20:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 20 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L21:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 21 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR013_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR013_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L21:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 21 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L22:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 22 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR014_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR014_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L22:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 22 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L23:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 23 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR015_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR015_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L23:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 23 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L24:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 24 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR016_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR016_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L24:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 24 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L25:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 25 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR017_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR017_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L25:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 25 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L26:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 26 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR018_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR018_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L26:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 26 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L27:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 27 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR019_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR019_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L27:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 27 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L28:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 28 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR020_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR020_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L28:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 28 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L29:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 29 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR021_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR021_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L29:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 29 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L30:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 30 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR022_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR022_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L30:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 30 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L31:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 31 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR023_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR023_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L31:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 31 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L32:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 32 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR024_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR024_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L32:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 32 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L33:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 33 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR025_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR025_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L33:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 33 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L34:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 34 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR026_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR026_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L34:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 34 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L35:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 35 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR027_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR027_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L35:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 35 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L36:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 36 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR028_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR028_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L36:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 36 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L37:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 37 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR029_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR029_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L37:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 37 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L38:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 38 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR030_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR030_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L38:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 38 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L39:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 39 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR031_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR031_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L39:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 39 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L40:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 40 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR032_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR032_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L40:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 40 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L41:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 41 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR033_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR033_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L41:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 41 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L42:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 42 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR034_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR034_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L42:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 42 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L43:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 43 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR035_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR035_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L43:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 43 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L44:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 44 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR036_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR036_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L44:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 44 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L45:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 45 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR037_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR037_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L45:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 45 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L46:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 46 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR038_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR038_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L46:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 46 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L47:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 47 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR039_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR039_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L47:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 47 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L48:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 48 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR040_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR040_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L48:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 48 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L49:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 49 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR041_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR041_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L49:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 49 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L50:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 50 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR042_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR042_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L50:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 50 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L51:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 51 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR043_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR043_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L51:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 51 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L52:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 52 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR044_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR044_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L52:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 52 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L53:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 53 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR045_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR045_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L53:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 53 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L54:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 54 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR046_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR046_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L54:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 54 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L55:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 55 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR047_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR047_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L55:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 55 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L56:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 56 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR048_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR048_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L56:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 56 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L57:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 57 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR049_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR049_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L57:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 57 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L58:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 58 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR050_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR050_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L58:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 58 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L59:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 59 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR051_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR051_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L59:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 59 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L60:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 60 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR052_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR052_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L60:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 60 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L61:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 61 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR053_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR053_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L61:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 61 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L62:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 62 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR054_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR054_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L62:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 62 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L63:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 63 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR055_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR055_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L63:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 63 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L64:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 64 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR056_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR056_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L64:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 64 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L65:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 65 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR057_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR057_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L65:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 65 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L66:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 66 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR058_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR058_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L66:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 66 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L67:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 67 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR059_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR059_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L67:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 67 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L68:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 68 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR060_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR060_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L68:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 68 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L69:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 69 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR061_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR061_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L69:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 69 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L70:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 70 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR062_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR062_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L70:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 70 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L71:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 71 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR063_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR063_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L71:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 71 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L72:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 72 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR064_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR064_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L72:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 72 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L73:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 73 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR065_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR065_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L73:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 73 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L74:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 74 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR066_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR066_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L74:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 74 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L75:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 75 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR067_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR067_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L75:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 75 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L76:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 76 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR068_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR068_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L76:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 76 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L77:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 77 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR069_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR069_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L77:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 77 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L78:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 78 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR070_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR070_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L78:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 78 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L79:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 79 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR071_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR071_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L79:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 79 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L80:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 80 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR072_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR072_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L80:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 80 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L81:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 81 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR073_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR073_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L81:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 81 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L82:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 82 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR074_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR074_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L82:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 82 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L83:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 83 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR075_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR075_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L83:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 83 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L84:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 84 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR076_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR076_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L84:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 84 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L85:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 85 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR077_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR077_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L85:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 85 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L86:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 86 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR078_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR078_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L86:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 86 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L87:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 87 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR079_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR079_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L87:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 87 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L88:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 88 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR080_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR080_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L88:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 88 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L89:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 89 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR081_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR081_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L89:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 89 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L90:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 90 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR082_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR082_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L90:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 90 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L91:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 91 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR083_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR083_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L91:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 91 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L92:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 92 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR084_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR084_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L92:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 92 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L93:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 93 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR085_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR085_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L93:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 93 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L94:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 94 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR086_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR086_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L94:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 94 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L95:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 95 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR087_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR087_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L95:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 95 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L96:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 96 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR088_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR088_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L96:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 96 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L97:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 97 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR089_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR089_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L97:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 97 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L98:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 98 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR090_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR090_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L98:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 98 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L99:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 99 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR091_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR091_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L99:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 99 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L100:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 100 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR092_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR092_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L100:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 100 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L101:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 101 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR093_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR093_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L101:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 101 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L102:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 102 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR094_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR094_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L102:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 102 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L103:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 103 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR095_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR095_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L103:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 103 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L104:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 104 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR096_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR096_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L104:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 104 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L105:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 105 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR097_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR097_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L105:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 105 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L106:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 106 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR098_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR098_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L106:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 106 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L107:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 107 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR099_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR099_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L107:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 107 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L108:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 108 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR100_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR100_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L108:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 108 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L109:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 109 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR101_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR101_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L109:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 109 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L110:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 110 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR102_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR102_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L110:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 110 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L111:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 111 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR103_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR103_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L111:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 111 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L112:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 112 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR104_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR104_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L112:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 112 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L113:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 113 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR105_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR105_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L113:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 113 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L114:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 114 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR106_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR106_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L114:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 114 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L115:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 115 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR107_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR107_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L115:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 115 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L116:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 116 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR108_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR108_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L116:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 116 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L117:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 117 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR109_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR109_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L117:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 117 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L118:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 118 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR110_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR110_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L118:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 118 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L119:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 119 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR111_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR111_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L119:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 119 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L120:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 120 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR112_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR112_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L120:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 120 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L121:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 121 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR113_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR113_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L121:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 121 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L122:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 122 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR114_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR114_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L122:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 122 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L123:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 123 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR115_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR115_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L123:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 123 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L124:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 124 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR116_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR116_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L124:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 124 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L125:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 125 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR117_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR117_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L125:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 125 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L126:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 126 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR118_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR118_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L126:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 126 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L127:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 127 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR119_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR119_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L127:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 127 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L128:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 128 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR120_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR120_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L128:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 128 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L129:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 129 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR121_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR121_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L129:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 129 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L130:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 130 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR122_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR122_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L130:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 130 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L131:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 131 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR123_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR123_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L131:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 131 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L132:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 132 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR124_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR124_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L132:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 132 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L133:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 133 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR125_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR125_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L133:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 133 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L134:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 134 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR126_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR126_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L134:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 134 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L135:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 135 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR127_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR127_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L135:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 135 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L136:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 136 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR128_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR128_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L136:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 136 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L137:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 137 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR129_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR129_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L137:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 137 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L138:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 138 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR130_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR130_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L138:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 138 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L139:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 139 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR131_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR131_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L139:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 139 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L140:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 140 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR132_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR132_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L140:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 140 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L141:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 141 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR133_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR133_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L141:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 141 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L142:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 142 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR134_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR134_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L142:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 142 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L143:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 143 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR135_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR135_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L143:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 143 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L144:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 144 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR136_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR136_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L144:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 144 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L145:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 145 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR137_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR137_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L145:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 145 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L146:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 146 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR138_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR138_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L146:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 146 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L147:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 147 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR139_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR139_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L147:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 147 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L148:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 148 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR140_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR140_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L148:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 148 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L149:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 149 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR141_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR141_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L149:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 149 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L150:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 150 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR142_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR142_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L150:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 150 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L151:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 151 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR143_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR143_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L151:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 151 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L152:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 152 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR144_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR144_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L152:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 152 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L153:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 153 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR145_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR145_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L153:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 153 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L154:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 154 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR146_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR146_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L154:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 154 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L155:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 155 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR147_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR147_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L155:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 155 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L156:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 156 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR148_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR148_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L156:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 156 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L157:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 157 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR149_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR149_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L157:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 157 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L158:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 158 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR150_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR150_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L158:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 158 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L159:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 159 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR151_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR151_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L159:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 159 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L160:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 160 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR152_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR152_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L160:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 160 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L161:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 161 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR153_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR153_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L161:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 161 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L162:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 162 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR154_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR154_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L162:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 162 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L163:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 163 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR155_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR155_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L163:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 163 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L164:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 164 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR156_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR156_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L164:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 164 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L165:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 165 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR157_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR157_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L165:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 165 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L166:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 166 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR158_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR158_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L166:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 166 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L167:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 167 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR159_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR159_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L167:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 167 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L168:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 168 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR160_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR160_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L168:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 168 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L169:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 169 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR162_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR162_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L169:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 169 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L170:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 170 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR163_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR163_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L170:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 170 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L171:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 171 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR164_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR164_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L171:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 171 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L172:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 172 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR168_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR168_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L172:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 172 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L173:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 173 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR169_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR169_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L173:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 173 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L174:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 174 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR170_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR170_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L174:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 174 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L175:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 175 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR171_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR171_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L175:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 175 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L176:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 176 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR172_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR172_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L176:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 176 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L177:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 177 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR173_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR173_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L177:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 177 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L178:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 178 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR174_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR174_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L178:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 178 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L179:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 179 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR175_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR175_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L179:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 179 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L180:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 180 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR176_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR176_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L180:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 180 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L181:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 181 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR177_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR177_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L181:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 181 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L182:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 182 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR178_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR178_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L182:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 182 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L183:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 183 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR179_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR179_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L183:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 183 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L184:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 184 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR180_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR180_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L184:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 184 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L185:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 185 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR181_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR181_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L185:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 185 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L186:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 186 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR182_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR182_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L186:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 186 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L187:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 187 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR183_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR183_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L187:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 187 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L188:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 188 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR184_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR184_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L188:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 188 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L189:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 189 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR185_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR185_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L189:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 189 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L190:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 190 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR186_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR186_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L190:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 190 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L191:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 191 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR187_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR187_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L191:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 191 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L192:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 192 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR188_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR188_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L192:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 192 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L193:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 193 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR189_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR189_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L193:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 193 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L194:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 194 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR190_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR190_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L194:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 194 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L195:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 195 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR191_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR191_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L195:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 195 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L196:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 196 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR192_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR192_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L196:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 196 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L197:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 197 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR193_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR193_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L197:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 197 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L198:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 198 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR194_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR194_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L198:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 198 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L199:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 199 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR195_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR195_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L199:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 199 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L200:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 200 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR196_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR196_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L200:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 200 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L201:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 201 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR197_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR197_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L201:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 201 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L202:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 202 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR198_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR198_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L202:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 202 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L203:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 203 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR199_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR199_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L203:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 203 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L204:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 204 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR200_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR200_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L204:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 204 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L205:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 205 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR201_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR201_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L205:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 205 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L206:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 206 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR202_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR202_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L206:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 206 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L207:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 207 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR203_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR203_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L207:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 207 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L208:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 208 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR204_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR204_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L208:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 208 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L209:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 209 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR205_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR205_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L209:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 209 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L210:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 210 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR206_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR206_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L210:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 210 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L211:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 211 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR207_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR207_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L211:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 211 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L212:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 212 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR208_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR208_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L212:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 212 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L213:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 213 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR209_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR209_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L213:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 213 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L214:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 214 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR210_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR210_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L214:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 214 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L215:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 215 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR211_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR211_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L215:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 215 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L216:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 216 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR212_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR212_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L216:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 216 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L217:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 217 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR213_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR213_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L217:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 217 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L218:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 218 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR214_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR214_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L218:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 218 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L219:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 219 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR215_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR215_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L219:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 219 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L220:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 220 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR216_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR216_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L220:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 220 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L221:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 221 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR217_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR217_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L221:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 221 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L222:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 222 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR218_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR218_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L222:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 222 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L223:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 223 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR219_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR219_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L223:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 223 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L224:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 224 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR220_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR220_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L224:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 224 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L225:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 225 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR221_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR221_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L225:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 225 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L226:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 226 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR222_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR222_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L226:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 226 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L227:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 227 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR223_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR223_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L227:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 227 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L228:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 228 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR224_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR224_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L228:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 228 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L229:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 229 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR225_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR225_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L229:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 229 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L230:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 230 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR226_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR226_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L230:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 230 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L231:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 231 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR227_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR227_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L231:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 231 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L232:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 232 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR228_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR228_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L232:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 232 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L233:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 233 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR229_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR229_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L233:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 233 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L234:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 234 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR230_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR230_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L234:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 234 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L235:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 235 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR231_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR231_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L235:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 235 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L236:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 236 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR232_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR232_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L236:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 236 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L237:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 237 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR233_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR233_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L237:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 237 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L238:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 238 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR234_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR234_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L238:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 238 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L239:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 239 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR235_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR235_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L239:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 239 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L240:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 240 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR236_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR236_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L240:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 240 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L241:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 241 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR237_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR237_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L241:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 241 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L242:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 242 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR238_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR238_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L242:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 242 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L243:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 243 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR239_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR239_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L243:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 243 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L244:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 244 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR240_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR240_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L244:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 244 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L245:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 245 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR241_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR241_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L245:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 245 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L246:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 246 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR242_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR242_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L246:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 246 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L247:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 247 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR243_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR243_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L247:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 247 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L248:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 248 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR244_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR244_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L248:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 248 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L249:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 249 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR245_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR245_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L249:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 249 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L250:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 250 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR246_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR246_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L250:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 250 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L251:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 251 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR247_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR247_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L251:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 251 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L252:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 252 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR248_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR248_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L252:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 252 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L253:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 253 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR249_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR249_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L253:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 253 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L254:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 254 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR250_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR250_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L254:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 254 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L255:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 255 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR251_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR251_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L255:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 255 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L256:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 256 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR252_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR252_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L256:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 256 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L257:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 257 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR253_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR253_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L257:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 257 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L258:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 258 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR254_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR254_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L258:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 258 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L259:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 259 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR255_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR255_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L259:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 259 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L260:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 260 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR256_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR256_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L260:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 260 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L261:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 261 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR257_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR257_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L261:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 261 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L262:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 262 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR258_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR258_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L262:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 262 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L263:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 263 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR259_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR259_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L263:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 263 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L264:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 264 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR260_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR260_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L264:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 264 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L265:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 265 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR261_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR261_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L265:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 265 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L266:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 266 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR262_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR262_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L266:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 266 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L267:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 267 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR263_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR263_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L267:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 267 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L268:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 268 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR264_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR264_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L268:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 268 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L269:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 269 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR265_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR265_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L269:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 269 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L270:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 270 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR266_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR266_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L270:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 270 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L271:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 271 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR267_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR267_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L271:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 271 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L272:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 272 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR268_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR268_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L272:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 272 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L273:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 273 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR269_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR269_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L273:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 273 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L274:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 274 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR270_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR270_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L274:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 274 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L275:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 275 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR271_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR271_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L275:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 275 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L276:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 276 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR272_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR272_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L276:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 276 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L277:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 277 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR273_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR273_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L277:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 277 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L278:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 278 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR274_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR274_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L278:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 278 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L279:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 279 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR275_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR275_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L279:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 279 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L280:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 280 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR276_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR276_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L280:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 280 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L281:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 281 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR277_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR277_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L281:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 281 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L282:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 282 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR278_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR278_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L282:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 282 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L283:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 283 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR279_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR279_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L283:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 283 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L284:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 284 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR280_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR280_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L284:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 284 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L285:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 285 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR281_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR281_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L285:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 285 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L286:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 286 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR282_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR282_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L286:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 286 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L287:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 287 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR283_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR283_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L287:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 287 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L288:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 288 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR284_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR284_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L288:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 288 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L289:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 289 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR285_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR285_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L289:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 289 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L290:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 290 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR286_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR286_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L290:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 290 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L291:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 291 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR287_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR287_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L291:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 291 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L292:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 292 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR288_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR288_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L292:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 292 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L293:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 293 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR289_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR289_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L293:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 293 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L294:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 294 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR290_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR290_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L294:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 294 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L295:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 295 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR291_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR291_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L295:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 295 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L296:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 296 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR292_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR292_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L296:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 296 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L297:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 297 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR293_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR293_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L297:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 297 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L298:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 298 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR294_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR294_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L298:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 298 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L299:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 299 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR295_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR295_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L299:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 299 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L300:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 300 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR296_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR296_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L300:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 300 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L301:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 301 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR297_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR297_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L301:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 301 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L302:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 302 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR298_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR298_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L302:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 302 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L303:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 303 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR299_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR299_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L303:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 303 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L304:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 304 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR300_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR300_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L304:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 304 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L305:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 305 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR301_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR301_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L305:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 305 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L306:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 306 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR302_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR302_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L306:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 306 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L307:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 307 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR303_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR303_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L307:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 307 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L308:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 308 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR304_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR304_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L308:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 308 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L309:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 309 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR305_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR305_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L309:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 309 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L310:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 310 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR306_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR306_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L310:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 310 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L311:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 311 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR307_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR307_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L311:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 311 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L312:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 312 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR308_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR308_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L312:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 312 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L313:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 313 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR309_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR309_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L313:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 313 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L314:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 314 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR310_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR310_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L314:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 314 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L315:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 315 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR311_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR311_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L315:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 315 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L316:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 316 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR312_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR312_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L316:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 316 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L317:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 317 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR313_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR313_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L317:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 317 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L318:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 318 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR314_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR314_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L318:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 318 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L319:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 319 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR315_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR315_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L319:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 319 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L320:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 320 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR316_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR316_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L320:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 320 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L321:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 321 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR317_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR317_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L321:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 321 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L322:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 322 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR318_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR318_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L322:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 322 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L323:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 323 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR319_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR319_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L323:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 323 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L324:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 324 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR320_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR320_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L324:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 324 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L325:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 325 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ001_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ001_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L325:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 325 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L326:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 326 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ002_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ002_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L326:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 326 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L327:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 327 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ003_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ003_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L327:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 327 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L328:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 328 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ004_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ004_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L328:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 328 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L329:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 329 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ005_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ005_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L329:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 329 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L330:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 330 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ006_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ006_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L330:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 330 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L331:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 331 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ007_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ007_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L331:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 331 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L332:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 332 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ008_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ008_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L332:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 332 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L333:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 333 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ009_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ009_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L333:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 333 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L334:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 334 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ010_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ010_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L334:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 334 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L335:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 335 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ011_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ011_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L335:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 335 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L336:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 336 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ012_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ012_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L336:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 336 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L337:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 337 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ013_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ013_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L337:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 337 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L338:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 338 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ014_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ014_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L338:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 338 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L339:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 339 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ015_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ015_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L339:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 339 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L340:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 340 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ016_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ016_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L340:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 340 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L341:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 341 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ017_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ017_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L341:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 341 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L342:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 342 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ018_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ018_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L342:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 342 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L343:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 343 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ019_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ019_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L343:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 343 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L344:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 344 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ020_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ020_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L344:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 344 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L345:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 345 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CQ021_quantity_sign.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CQ021_quantity_sign.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L345:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 345 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L346:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 346 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C030_keep_signed_va.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C030_keep_signed_va.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L346:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 346 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L347:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 347 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C081_recompute_ratio.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C081_recompute_ratio.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L347:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 347 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L348:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 348 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C072_ratio_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C072_ratio_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L348:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 348 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L349:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 349 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C100_own_generation_delta.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C100_own_generation_delta.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L349:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 349 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L350:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 350 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C110_quantity_flag_states.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C110_quantity_flag_states.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L350:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 350 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L351:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 351 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT003_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT003_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L351:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 351 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L352:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 352 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT005_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT005_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L352:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 352 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L353:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 353 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR006_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR006_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L353:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 353 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L354:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 354 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR167_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR167_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L354:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 354 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L355:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 355 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C040_va_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C040_va_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L355:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 355 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L356:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 356 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C041_va_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C041_va_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L356:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 356 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L357:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 357 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C050_signed_tail_threshold.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C050_signed_tail_threshold.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L357:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 357 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L358:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 358 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C082_recompute_ratio.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C082_recompute_ratio.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L358:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 358 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L359:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 359 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C120_flag_logic.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C120_flag_logic.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L359:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 359 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L360:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 360 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT006_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT006_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L360:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 360 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L361:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 361 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CT007_recompute_total.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CT007_recompute_total.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L361:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 361 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L362:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 362 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR001_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR001_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L362:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 362 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L363:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 363 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR161_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR161_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L363:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 363 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L364:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 364 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C060_signed_tail_companion.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C060_signed_tail_companion.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L364:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 364 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L365:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 365 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C073_ratio_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C073_ratio_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L365:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 365 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L366:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 366 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C074_ratio_domain.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C074_ratio_domain.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L366:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 366 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L367:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 367 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR007_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR007_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L367:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 367 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L368:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 368 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR008_per_worker.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR008_per_worker.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L368:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 368 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L369:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 369 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR165_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR165_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L369:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 369 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L370:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 370 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/CR166_log.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/CR166_log.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L370:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 370 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L371:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 371 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C083_recompute_ratio.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C083_recompute_ratio.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L371:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 371 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L372:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 372 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C084_recompute_ratio.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C084_recompute_ratio.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L372:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 372 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L373:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 373 374 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak rows/G0/corrections/C140_assemble_companions.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "rows/G0/corrections/C140_assemble_companions.do"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L373:step-do" "code/stages/F080_corrections.do:L1:file" "statement" 373 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F080_corrections.do:L374:step-display" "code/stages/F080_corrections.do:L1:file" "statement" 374 374 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F080_PASS"
capture noisily __wf_progress end "code/stages/F080_corrections.do:L374:step-display" "code/stages/F080_corrections.do:L1:file" "statement" 374 374 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F080_corrections.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
