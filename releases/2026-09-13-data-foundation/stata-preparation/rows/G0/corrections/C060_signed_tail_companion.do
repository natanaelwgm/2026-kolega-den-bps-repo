* Tujuan: Tandai nilai tambah yang absolutnya lebih dari 10 kali ambang tahun tersebut; salinan sensitivitas hanya menyimpan nilai yang tidak masuk ekor itu. // WFDOC-INJECTED
* Input: corrections/data/C030.dta; corrections/data/C050.dta // WFDOC-INJECTED
* Output: corrections/data/C060.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L1:step-version" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L1:step-version" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L2:step-do" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L2:step-do" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L3:step-g0c_begin" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
g0c_begin "C060_signed_tail_companion"
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L3:step-g0c_begin" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L4:step-use" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
* Tandai nilai yang absolutnya lebih dari 10 kali ambang persentil ke-99 tahun itu; nilai bertanda asli hanya diteruskan jika bukan ekor tersebut. // WFDOC-INJECTED
use source_year source_row va_signed_nominal using "corrections/data/C030.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L4:step-use" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L5:step-merge" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
* Pasangkan satu ambang p99 per tahun ke tiap baris tahun yang sama. // WFDOC-INJECTED
merge m:1 source_year using "corrections/data/C050.dta", assert(match) nogen keepusing(p99_abs_va)
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L5:step-merge" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L6:step-generate" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
* Tandai jika nilai absolut lebih dari 10 kali p99 tahun itu; missing input/ambang tidak diberi flag. // WFDOC-INJECTED
generate byte va_abs_tail_flag=abs(va_signed_nominal)>10*p99_abs_va if !missing(va_signed_nominal,p99_abs_va) & p99_abs_va>=0
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L6:step-generate" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L7:step-generate" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
* Pertahankan angka bertanda hanya untuk baris di luar flag ekor; ini kolom sensitivitas, bukan pengganti nilai utama. // WFDOC-INJECTED
generate double va_signed_tail_sensitivity=va_signed_nominal if va_abs_tail_flag==0
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L7:step-generate" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L8:step-keep" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
keep source_year source_row va_abs_tail_flag va_signed_tail_sensitivity
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L8:step-keep" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L9:step-order" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L9:step-order" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L10:step-isid" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L10:step-isid" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L11:step-assert" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L11:step-assert" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C060_signed_tail_companion.do:L12:step-g0c_finish" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C060_signed_tail_companion" "C060"
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L12:step-g0c_finish" "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C060_signed_tail_companion.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
