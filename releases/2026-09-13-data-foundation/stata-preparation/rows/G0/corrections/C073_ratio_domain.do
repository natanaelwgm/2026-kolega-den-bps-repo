* Tujuan: Tentukan baris yang layak untuk energi/output: energi harus ada dan tidak negatif; output harus ada dan positif. // WFDOC-INJECTED
* Input: corrections/data/CT006.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C073.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L1:step-version" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L1:step-version" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L2:step-do" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L2:step-do" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "C073_ratio_domain"
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L4:step-use" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
* Tentukan apakah energi per output dapat dihitung: energi tidak negatif dan output positif, keduanya terisi. // WFDOC-INJECTED
use source_year source_row r_total_gj_s1 using "corrections/data/CT006.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L4:step-use" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L5:step-merge" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L5:step-merge" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L6:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
generate byte energy_num_state=cond(missing(r_total_gj_s1),3,cond(r_total_gj_s1<0,2,cond(r_total_gj_s1==0,1,0)))
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L6:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L7:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
generate byte energy_den_state=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)))
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L7:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L8:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
* Tandai hanya baris yang memenuhi batas pembilang/penyebut yang dijelaskan di atas; missing dan penyebut nol tidak lolos. // WFDOC-INJECTED
generate byte energy_eligible=(r_total_gj_s1>=0 & !missing(r_total_gj_s1)) & gross_output_nominal>0 & !missing(gross_output_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L8:step-generate" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L9:step-keep" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
keep source_year source_row energy_num_state energy_den_state energy_eligible
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L9:step-keep" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L10:step-order" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L10:step-order" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L11:step-isid" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L11:step-isid" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L12:step-assert" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L12:step-assert" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C073_ratio_domain.do:L13:step-g0c_finish" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C073_ratio_domain" "C073"
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L13:step-g0c_finish" "rows/G0/corrections/C073_ratio_domain.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C073_ratio_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
