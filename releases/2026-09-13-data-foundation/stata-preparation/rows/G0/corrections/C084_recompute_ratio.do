* Tujuan: Hitung ulang emisi/output untuk baris yang lolos C074, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/CT007.dta; corrections/data/C010.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C084.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L1:step-version" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L1:step-version" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L2:step-do" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L2:step-do" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L3:step-g0c_begin" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
g0c_begin "C084_recompute_ratio"
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L3:step-g0c_begin" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L4:step-use" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
* Hitung ulang CO2/output hanya saat domain emisi dan output memenuhi C074; simpan nilai lama untuk audit perubahan. // WFDOC-INJECTED
use source_year source_row r_co2_total_s1 using "corrections/data/CT007.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L4:step-use" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L5:step-merge" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 5 16 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal co2_intensity_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L5:step-merge" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 5 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L6:step-merge" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C074.dta", assert(match) nogen keepusing(carbon_eligible)
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L6:step-merge" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L7:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
generate double carbon_legacy_ratio=co2_intensity_nominal
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L7:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L8:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
generate double ci_co2_output_repaired=.
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L8:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L9:step-replace" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
* Hitung ulang ci_co2_output_repaired=r_co2_total_s1/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace ci_co2_output_repaired=r_co2_total_s1/gross_output_nominal if carbon_eligible
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L9:step-replace" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L10:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
generate byte carbon_changed=(ci_co2_output_repaired!=carbon_legacy_ratio)
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L10:step-generate" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L11:step-assert" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
assert missing(ci_co2_output_repaired) if !carbon_eligible
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L11:step-assert" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L12:step-keep" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
keep source_year source_row ci_co2_output_repaired carbon_legacy_ratio carbon_changed
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L12:step-keep" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L13:step-order" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L13:step-order" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L14:step-isid" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L14:step-isid" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L15:step-assert" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L15:step-assert" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C084_recompute_ratio.do:L16:step-g0c_finish" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C084_recompute_ratio" "C084"
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L16:step-g0c_finish" "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C084_recompute_ratio.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
