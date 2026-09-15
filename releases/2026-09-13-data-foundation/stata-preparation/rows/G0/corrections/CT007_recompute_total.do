* Tujuan: Jumlahkan emisi cakupan 1 dan 2 hanya jika kedua subtotal tersedia; bila salah satu belum ada, total gabungan dibuat missing. // WFDOC-INJECTED
* Input: corrections/data/CT004.dta; corrections/data/CT005.dta // WFDOC-INJECTED
* Output: corrections/data/CT007.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L1:step-version" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L1:step-version" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 1 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L2:step-do" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L2:step-do" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 2 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
g0c_begin "CT007_recompute_total"
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L3:step-g0c_begin" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 3 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L4:step-use" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
use  using "corrections/data/CT004.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L4:step-use" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 4 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L5:step-merge" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 5 16 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CT005.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L5:step-merge" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 5 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=r_co2_scope1_s1 if r_co2_scope1_s1>=0 & !missing(r_co2_scope1_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L6:step-generate" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 6 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=r_co2_scope2_s1 if r_co2_scope2_s1>=0 & !missing(r_co2_scope2_s1)
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L7:step-generate" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 7 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L8:step-egen" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
egen byte r_co2_total_s1_n=rownonmiss(__component0 __component1)
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L8:step-egen" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 8 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L9:step-egen" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
egen double r_co2_total_s1=rowtotal(__component0 __component1), missing
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L9:step-egen" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 9 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L10:step-replace" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
replace r_co2_total_s1=. if r_co2_total_s1_n!=2
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L10:step-replace" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 10 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L11:step-assert" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
assert missing(r_co2_total_s1) if r_co2_total_s1_n==0
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L11:step-assert" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 11 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L12:step-keep" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
keep source_year source_row r_co2_total_s1 r_co2_total_s1_n
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L12:step-keep" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 12 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L13:step-order" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L13:step-order" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 13 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L14:step-isid" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L14:step-isid" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 14 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L15:step-assert" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L15:step-assert" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 15 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CT007_recompute_total.do:L16:step-g0c_finish" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT007_recompute_total" "CT007"
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L16:step-g0c_finish" "rows/G0/corrections/CT007_recompute_total.do:L1:file" "statement" 16 16 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CT007_recompute_total.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
