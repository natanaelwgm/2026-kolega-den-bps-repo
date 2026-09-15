* Tujuan: Cocokkan klasifikasi token R&D per baris tahun 2017 dan tiga tabel ringkas dengan keluaran kandidat saat ini serta arsip historis. Laporan hanya membuktikan kesamaan keluaran; measurement_admitted tetap 0. // WFDOC-INJECTED
* Input: $RD17_MASTER: source_year, source_row, raw_rnd17, raw_costrd17, rd17_own_token_class, rd17_external_token_class; outputs/candidate_2017.dta serta arsip $RD17_HISTORY/outputs: candidate_2017, group_counts, joint_counts, candidate_ratios // WFDOC-INJECTED
* Output: validation/equivalence.dta; validation/equivalence.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L1:step-version" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L1:step-version" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
* Explicit validation boundary; historical values never become a numerical parent.
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L3:step-use" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Muat kunci baris, dua kolom mentah, dan dua klasifikasi token yang sudah ada dari master; source_year/source_row menunjuk baris, bukan firmID. // WFDOC-INJECTED
use source_year source_row raw_rnd17 raw_costrd17 rd17_own_token_class rd17_external_token_class using "$RD17_MASTER", clear
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L3:step-use" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L4:step-keep" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
* Sisakan wave 2017 karena pemeriksaan ini khusus untuk tahun itu. // WFDOC-INJECTED
keep if source_year==2017
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L4:step-keep" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L5:step-isid" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
* Pastikan satu pasangan tahun/nomor baris hanya muncul sekali sebelum membuat kandidat pembanding. // WFDOC-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L5:step-isid" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L6:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
* Wajibkan tepat 3.357 baris dan semuanya tahun 2017; jumlah lain menghentikan validasi. // WFDOC-INJECTED
assert _N==3357 & source_year==2017
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L6:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L7:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
generate byte parent_present=1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L7:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L8:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
generate byte child_present=1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L8:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L9:step-foreach" "rd2017/validation/compare_current_wave.do:L1:file" "loop" 8 22 `=_rc' "in" `"tokens universe answer audit"' // WFLOG-INJECTED
* Jalankan empat tahap kandidat yang didefinisikan di shared.do: klasifikasi token, status universe, status jawaban, lalu flag audit; semua tetap kandidat dan measurement_admitted bernilai 0. // WFDOC-INJECTED
foreach stage in tokens universe answer audit {
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L9:iteration-body" "rd2017/validation/compare_current_wave.do:L9:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L10:step-rd17_candidate" "rd2017/validation/compare_current_wave.do:L9:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
* Terapkan tahap yang sedang dipilih oleh loop untuk membentuk kolom kandidat yang dibandingkan di bawah. // WFDOC-INJECTED
 rd17_candidate, stage("`stage'")
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L10:step-rd17_candidate" "rd2017/validation/compare_current_wave.do:L9:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L9:iteration-body" "rd2017/validation/compare_current_wave.do:L9:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L9:step-foreach" "rd2017/validation/compare_current_wave.do:L1:file" "loop" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L12:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
* Pastikan klasifikasi token mentah milik wave sama persis dengan kelas token parent yang dibentuk ulang. // WFDOC-INJECTED
assert rd17_own_token_class==parent_token_class
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L12:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L13:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
* Pastikan klasifikasi token mentah pasangan wave sama persis dengan kelas token child yang dibentuk ulang. // WFDOC-INJECTED
assert rd17_external_token_class==child_token_class
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L13:step-assert" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L14:step-cf" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
* Bandingkan kunci, kelas token, status kandidat, dan flag penerimaan dengan outputs/candidate_2017.dta; satu perbedaan menghentikan validasi. // WFDOC-INJECTED
cf source_year source_row parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release using "outputs/candidate_2017.dta"
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L14:step-cf" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L15:step-cf" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
* Bandingkan kolom mentah dan hasil kandidat dengan candidate_2017.dta historis; ini pemeriksaan kesamaan isi, bukan persetujuan pengukuran. // WFDOC-INJECTED
cf source_year source_row raw_rnd17 raw_costrd17 parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release using "$RD17_HISTORY/outputs/candidate_2017.dta"
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L15:step-cf" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L16:step-foreach" "rd2017/validation/compare_current_wave.do:L1:file" "loop" 13 22 `=_rc' "in" `"group_counts joint_counts candidate_ratios"' // WFLOG-INJECTED
* Ulangi pemeriksaan arsip untuk tiga tabel ringkas: jumlah kelompok, hitungan gabungan, dan rasio kandidat. // WFDOC-INJECTED
foreach table in group_counts joint_counts candidate_ratios {
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L16:iteration-body" "rd2017/validation/compare_current_wave.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L17:step-use" "rd2017/validation/compare_current_wave.do:L16:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
* Buka tabel ringkas saat ini yang namanya sedang dipilih loop. // WFDOC-INJECTED
 use "outputs/`table'.dta", clear
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L17:step-use" "rd2017/validation/compare_current_wave.do:L16:iteration-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L18:step-cf" "rd2017/validation/compare_current_wave.do:L16:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
* Pastikan semua kolom tabel ringkas sama dengan versi historisnya; perbedaan apa pun menghentikan validasi. // WFDOC-INJECTED
 cf _all using "$RD17_HISTORY/outputs/`table'.dta"
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L18:step-cf" "rd2017/validation/compare_current_wave.do:L16:iteration-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L16:iteration-body" "rd2017/validation/compare_current_wave.do:L16:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L16:step-foreach" "rd2017/validation/compare_current_wave.do:L1:file" "loop" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L20:step-clear" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
* Buang tabel kerja yang baru saja dibandingkan sebelum membentuk satu baris laporan hasil validasi. // WFDOC-INJECTED
clear
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L20:step-clear" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L21:step-set" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
* Buat satu baris untuk menyimpan hasil pemeriksaan kesamaan. // WFDOC-INJECTED
set obs 1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L21:step-set" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L22:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Beri tanda 1 karena klasifikasi token wave sudah cocok dengan dua kelas kandidat yang dibentuk ulang. // WFDOC-INJECTED
generate byte literal_wave_classes_exact=1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L22:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L23:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
* Beri tanda 1 setelah 3.357 baris dan kedua pemeriksaan kelas token di atas lolos. // WFDOC-INJECTED
generate byte all_3357_classifications_exact=1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L23:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L24:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
* Beri tanda 1 setelah group_counts, joint_counts, dan candidate_ratios cocok dengan tabel historis. // WFDOC-INJECTED
generate byte three_aggregate_values_exact=1
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L24:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L25:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
* Tetapkan measurement_admitted=0: hasil yang sama dengan arsip tidak berarti pengukuran diterima. // WFDOC-INJECTED
generate byte measurement_admitted=0
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L25:step-generate" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L26:step-save" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
* Simpan satu baris tanda kesetaraan ke berkas DTA validation/equivalence.dta. // WFDOC-INJECTED
save "validation/equivalence.dta", replace
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L26:step-save" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L27:step-export" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
* Ekspor baris hasil yang sama ke CSV agar status validasi mudah dibaca. // WFDOC-INJECTED
export delimited using "validation/equivalence.csv", quote replace
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L27:step-export" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/validation/compare_current_wave.do:L28:step-display" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
* Tampilkan penanda bahwa seluruh perbandingan master dan arsip historis selesai tanpa perbedaan. // WFDOC-INJECTED
display "RD17_MASTER_AND_HISTORICAL_PARITY_PASS"
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L28:step-display" "rd2017/validation/compare_current_wave.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/validation/compare_current_wave.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
