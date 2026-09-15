* Tujuan: Hitung log natural nilai tambah hanya saat nilainya positif; nol, negatif, dan missing tetap tanpa hasil log. // WFDOC-INJECTED
* Input: corrections/data/C030.dta // WFDOC-INJECTED
* Output: corrections/data/C041.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L1:step-version" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L1:step-version" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 1 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L2:step-do" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L2:step-do" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 2 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L3:step-g0c_begin" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
g0c_begin "C041_va_log"
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L3:step-g0c_begin" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 3 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L4:step-use" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
* Log natural hanya dihitung untuk nilai tambah positif; nol, negatif, dan missing tidak menghasilkan log. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L4:step-use" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 4 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L5:step-g0c_log" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 5 10 `=_rc' // WFLOG-INJECTED
* Helper menghitung ln(nilai tambah) hanya bila nilai tambah>0 dan terisi; hasil lain tetap missing. // WFDOC-INJECTED
g0c_log va_signed_nominal, generate(va_log_positive)
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L5:step-g0c_log" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 5 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L6:step-keep" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
keep source_year source_row va_log_positive
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L6:step-keep" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 6 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L7:step-order" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L7:step-order" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 7 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L8:step-isid" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 8 10 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L8:step-isid" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 8 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L9:step-assert" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L9:step-assert" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 9 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C041_va_log.do:L10:step-g0c_finish" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C041_va_log" "C041"
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L10:step-g0c_finish" "rows/G0/corrections/C041_va_log.do:L1:file" "statement" 10 10 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C041_va_log.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
