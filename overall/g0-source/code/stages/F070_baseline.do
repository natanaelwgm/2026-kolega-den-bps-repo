* Tujuan: Pilih kolom dasar untuk koreksi dan simpan baseline; pemeriksaan menahan ID perusahaan nyata/dummy. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_publish_complete_identity_dataset.do" "$WFROOT" "off"
* Jalankan tahap/berkas anak dag/edges/word_rows/G0/G0_local_prepare_numeric.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/G0_local_prepare_numeric.do" "$WFROOT"
use "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", clear
* Jalankan tahap/berkas anak code/order_baseline.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/order_baseline.do"
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", replace
display "WF_STAGE_F070_PASS"
