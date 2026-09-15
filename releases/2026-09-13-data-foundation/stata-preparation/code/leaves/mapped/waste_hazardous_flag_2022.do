* Tujuan: Jalankan pemetaan waste_hazardous_flag untuk wave 2022 dari kolom sumber raw_b3wste22 dan raw_inspli22; aturan pemetaan berada di do-file anak. // WFDOC-INJECTED
* Input: raw_wave_2022.dta, termasuk source_year/source_row dan dua kolom raw yang disebut di atas. // WFDOC-INJECTED
* Output: kolom waste_hazardous_flag tahun 2022 dan ringkasan hitungan observed/zeros/invalid/source_absent. // WFDOC-INJECTED
* Jika tahun, kunci baris, atau do-file anak gagal, wave ini belum selesai. // WFDOC-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:step-do" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:step-do" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L2:step-use" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
* Muat hanya kunci baris dan kolom raw raw_b3wste22/raw_inspli22 yang dipakai untuk pemetaan 2022. // WFDOC-INJECTED
use source_year source_row raw_b3wste22 raw_inspli22 using "data/intermediate/raw_wave_2022.dta", clear
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L2:step-use" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L3:step-assert" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
* Pastikan semua baris pada berkas ini milik tahun 2022. // WFDOC-INJECTED
assert source_year==2022
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L3:step-assert" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L4:step-isid" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
* Pastikan pasangan source_year/source_row tidak berulang; pasangan ini mengenali baris, bukan firmID. // WFDOC-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L4:step-isid" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L5:step-tempfile" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
tempfile metrics
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L5:step-tempfile" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L6:step-postclose" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture postclose cell
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L6:step-postclose" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L7:step-postfile" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
* Siapkan ringkasan diagnostics untuk jumlah baris, nilai teramati, nol, tidak valid, dan sumber yang tidak tersedia. // WFDOC-INJECTED
postfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics', replace
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L7:step-postfile" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L8:step-do" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
* Jalankan aturan pemetaan waste_hazardous_flag khusus tahun 2022 pada do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/variable_year/waste_hazardous_flag_2022.do"
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L8:step-do" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/waste_hazardous_flag_2022.do:L9:step-postclose" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
* Tutup tabel hitungan setelah pemetaan selesai agar metrik dapat dibaca sebagai satu hasil. // WFDOC-INJECTED
postclose cell
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L9:step-postclose" "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/leaves/mapped/waste_hazardous_flag_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
