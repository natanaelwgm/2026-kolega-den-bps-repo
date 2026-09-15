* Tujuan: Tentukan baris yang layak untuk porsi nilai tambah/output: nilai tambah harus ada dan output harus ada serta positif. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C071.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L1:step-version" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L1:step-version" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 1 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L2:step-do" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L2:step-do" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 2 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
g0c_begin "C071_ratio_domain"
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 3 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L4:step-use" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
* Tentukan apakah pembagian nilai tambah dengan output dapat dihitung: pembilang harus ada dan output harus positif serta terisi. // WFDOC-INJECTED
use source_year source_row value_added_nominal gross_output_nominal using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L4:step-use" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 4 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L5:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
generate byte output_share_num_state=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0)))
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L5:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 5 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L6:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
generate byte output_share_den_state=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)))
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L6:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 6 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L7:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
* Tandai hanya baris yang memenuhi batas pembilang/penyebut yang dijelaskan di atas; missing dan penyebut nol tidak lolos. // WFDOC-INJECTED
generate byte output_share_eligible=(!missing(value_added_nominal)) & gross_output_nominal>0 & !missing(gross_output_nominal)
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L7:step-generate" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 7 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L8:step-keep" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
keep source_year source_row output_share_num_state output_share_den_state output_share_eligible
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L8:step-keep" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 8 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L9:step-order" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L9:step-order" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 9 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L10:step-isid" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L10:step-isid" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 10 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L11:step-assert" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L11:step-assert" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 11 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C071_ratio_domain.do:L12:step-g0c_finish" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C071_ratio_domain" "C071"
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L12:step-g0c_finish" "rows/G0/corrections/C071_ratio_domain.do:L1:file" "statement" 12 12 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C071_ratio_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
