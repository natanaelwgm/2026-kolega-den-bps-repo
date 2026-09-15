* Tujuan: Hitung nilai tambah per pekerja; pembilang bertanda boleh negatif, tetapi jumlah pekerja harus positif dan kedua angka harus tersedia. // WFDOC-INJECTED
* Input: corrections/data/C030.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C040.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L1:step-version" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 1 11 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L1:step-version" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 1 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L2:step-do" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 2 11 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L2:step-do" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 2 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 3 11 `=_rc' // WFLOG-INJECTED
g0c_begin "C040_va_per_worker"
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L3:step-g0c_begin" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 3 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L4:step-use" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 4 11 `=_rc' // WFLOG-INJECTED
* Hitung nilai tambah per pekerja untuk pembilang bertanda; helper menolak pekerja kosong/tidak positif dan menjaga nilai tambah negatif tetap dapat dihitung. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L4:step-use" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 4 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L5:step-merge" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 5 11 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(workers)
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L5:step-merge" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 5 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L6:step-g0c_ratio" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 6 11 `=_rc' // WFLOG-INJECTED
* Helper membagi nilai tambah dengan workers hanya bila keduanya terisi dan workers>0; opsi signed mengizinkan pembilang negatif, sedangkan hasil lain tetap missing. // WFDOC-INJECTED
g0c_ratio va_signed_nominal workers, generate(va_signed_per_worker) signed
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L6:step-g0c_ratio" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 6 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L7:step-keep" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 7 11 `=_rc' // WFLOG-INJECTED
keep source_year source_row va_signed_per_worker
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L7:step-keep" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 7 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L8:step-order" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 8 11 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L8:step-order" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 8 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L9:step-isid" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 9 11 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L9:step-isid" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 9 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L10:step-assert" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 10 11 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L10:step-assert" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 10 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C040_va_per_worker.do:L11:step-g0c_finish" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 11 11 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C040_va_per_worker" "C040"
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L11:step-g0c_finish" "rows/G0/corrections/C040_va_per_worker.do:L1:file" "statement" 11 11 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C040_va_per_worker.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
