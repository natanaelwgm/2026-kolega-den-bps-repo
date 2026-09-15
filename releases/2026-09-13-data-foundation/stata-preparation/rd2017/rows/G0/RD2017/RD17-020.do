* Tujuan: Ambil baris 2017 untuk proyeksi R&D: rd_indicator_raw menyimpan kode jawaban pertanyaan (1/2), bukan uang; val_costrd adalah kolom biaya yang terpisah. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: rd2017/states/wave_2017_projection.dta; rd2017/states/wave_2017_projection.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L1:step-version" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
log using "runtime/RD17-020.log", name(RD17CHILD) text replace
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L2:step-log" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L3:step-use" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
* Muat jawaban pertanyaan R&D dan nilai biaya sebagai kolom terpisah; rd_indicator_raw berisi kode jawaban, bukan uang. // WFDOC-INJECTED
use source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class using "$RD17_MASTER", clear
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L3:step-use" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L4:step-keep" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
* Batasi proyeksi ini pada baris tahun 2017. // WFDOC-INJECTED
keep if source_year==2017
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L4:step-keep" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L5:step-order" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L5:step-order" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L6:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
* Ekspor tabel R&D dengan nama dasar dan spesifikasi yang tertulis di opsi perintah ini. // WFDOC-INJECTED
rd17_export, stem("states/wave_2017_projection") spec("wave_2017_projection")
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L6:step-rd17_export" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L7:step-display" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
display "PASS CHILD RD17-020"
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L7:step-display" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/rows/G0/RD2017/RD17-020.do:L8:step-log" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
log close RD17CHILD
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L8:step-log" "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/rows/G0/RD2017/RD17-020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
