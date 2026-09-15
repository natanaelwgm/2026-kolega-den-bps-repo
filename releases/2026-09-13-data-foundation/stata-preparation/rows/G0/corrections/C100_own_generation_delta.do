* Tujuan: Bandingkan flag own-generation lama dengan indikator nilai kWh positif; simpan apakah indikator tidak diketahui dan apakah hasilnya berbeda. // WFDOC-INJECTED
* Input: corrections/data/C090.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C100.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L1:step-version" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L1:step-version" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L2:step-do" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L2:step-do" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L3:step-g0c_begin" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "C100_own_generation_delta"
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L3:step-g0c_begin" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L4:step-use" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
* Bandingkan flag own-generation lama dengan indikator positif dari angka yang dilaporkan; simpan tanda unknown dan apakah flag berubah. // WFDOC-INJECTED
use source_year source_row own_gen_positive_reported using "corrections/data/C090.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L4:step-use" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L5:step-merge" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(own_generation_reported)
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L5:step-merge" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L6:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
generate byte own_gen_legacy_flag=own_generation_reported
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L6:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L7:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
generate byte own_gen_unknown=missing(own_gen_positive_reported)
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L7:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L8:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
generate byte own_gen_flag_changed=own_gen_positive_reported!=own_gen_legacy_flag
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L8:step-generate" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L9:step-keep" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
keep source_year source_row own_gen_legacy_flag own_gen_unknown own_gen_flag_changed
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L9:step-keep" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L10:step-order" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L10:step-order" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L11:step-isid" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L11:step-isid" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L12:step-assert" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L12:step-assert" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C100_own_generation_delta.do:L13:step-g0c_finish" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C100_own_generation_delta" "C100"
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L13:step-g0c_finish" "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C100_own_generation_delta.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
