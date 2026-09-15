* Tujuan: Untuk 2022, ubah raw_ysnvcu22 menjadi val_ysnvcu; vs_val_ysnvcu mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_val_ysnvcu_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L1:step-do" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L1:step-do" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 1 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L2:step-use" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
* Muat kolom sumber untuk val_ysnvcu tahun 2022; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use source_year source_row raw_ysnvcu22 using "data/intermediate/raw_wave_2022.dta", clear
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L2:step-use" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 2 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L3:step-assert" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
* Pastikan setiap baris milik tahun 2022; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2022
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L3:step-assert" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 3 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L4:step-isid" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L4:step-isid" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 4 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L5:step-tempfile" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
tempfile metrics
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L5:step-tempfile" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 5 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L6:step-postclose" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture postclose cell
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L6:step-postclose" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 6 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L7:step-postfile" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics', replace
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L7:step-postfile" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 7 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L8:step-do" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
* Jalankan aturan pembentukan val_ysnvcu tahun 2022 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/variable_year/val_ysnvcu_2022.do"
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L8:step-do" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 8 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/leaves/mapped/val_ysnvcu_2022.do:L9:step-postclose" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
postclose cell
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L9:step-postclose" "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "statement" 9 9 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/leaves/mapped/val_ysnvcu_2022.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
