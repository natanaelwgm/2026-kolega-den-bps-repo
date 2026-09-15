* Tujuan: Hitung ulang nilai tambah/output untuk baris yang lolos C071, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/C010.dta; corrections/data/C071.dta // WFDOC-INJECTED
* Output: corrections/data/C081.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L1:step-version" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L1:step-version" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L2:step-do" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L2:step-do" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 2 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L3:step-g0c_begin" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
g0c_begin "C081_recompute_ratio"
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L3:step-g0c_begin" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L4:step-use" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
* Hitung ulang porsi nilai tambah/output pada baris yang lolos pemeriksaan domain; simpan rasio lama untuk membandingkan perubahan. // WFDOC-INJECTED
use source_year source_row value_added_nominal gross_output_nominal value_added_share_of_output using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L4:step-use" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 4 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L5:step-merge" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C071.dta", assert(match) nogen keepusing(output_share_eligible)
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L5:step-merge" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L6:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
generate double output_share_legacy_ratio=value_added_share_of_output
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L6:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L7:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
generate double va_share_output_repaired=.
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L7:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L8:step-replace" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
* Hitung ulang va_share_output_repaired=value_added_nominal/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace va_share_output_repaired=value_added_nominal/gross_output_nominal if output_share_eligible
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L8:step-replace" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L9:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
generate byte output_share_changed=(va_share_output_repaired!=output_share_legacy_ratio)
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L9:step-generate" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L10:step-assert" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
assert missing(va_share_output_repaired) if !output_share_eligible
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L10:step-assert" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L11:step-keep" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
keep source_year source_row va_share_output_repaired output_share_legacy_ratio output_share_changed
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L11:step-keep" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L12:step-order" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L12:step-order" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L13:step-isid" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L13:step-isid" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 13 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L14:step-assert" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L14:step-assert" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C081_recompute_ratio.do:L15:step-g0c_finish" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C081_recompute_ratio" "C081"
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L15:step-g0c_finish" "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C081_recompute_ratio.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
