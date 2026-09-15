* Tujuan: Untuk 2018, lengkapi rd_external_funding_flag dari legacy_rd_cost_mislabelled hanya saat nilainya kosong dan syarat kode terpenuhi; v_rd_external_funding_flag menyimpan salinan nilai awal; vs_rd_external_funding_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2018.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L1:step-do" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L1:step-do" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L2:step-use" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
* Muat kolom sumber untuk rd_external_funding_flag tahun 2018; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2018.dta", clear
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L2:step-use" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L3:step-assert" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
* Pastikan setiap baris milik tahun 2018; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2018
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L3:step-assert" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L4:step-isid" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L4:step-isid" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L5:step-tempfile" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
tempfile metrics
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L5:step-tempfile" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L6:step-postclose" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture postclose counts
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L6:step-postclose" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L7:step-postfile" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L7:step-postfile" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L8:step-do" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
* Jalankan aturan pembentukan rd_external_funding_flag tahun 2018 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/rd_external_funding_flag_2018.do"
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L8:step-do" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/working/rd_external_funding_flag_2018.do:L9:step-postclose" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
postclose counts
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L9:step-postclose" "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/leaves/working/rd_external_funding_flag_2018.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
