* Tujuan: Tandai laporan own-generation yang dapat dinilai hanya jika status sumbernya 0/1 dan kWh ada serta tidak negatif; flag positif hanya berlaku untuk nilai di atas nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C090.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L1:step-version" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L1:step-version" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L2:step-do" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L2:step-do" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
g0c_begin "C090_own_generation_domain"
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L3:step-g0c_begin" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L4:step-use" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
* Anggap laporan own-generation layak dinilai hanya bila status sumbernya 0/1 dan nilai kWh terisi serta tidak negatif. // WFDOC-INJECTED
use source_year source_row elec_owngen_kwh st_elec_owngen_kwh using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L4:step-use" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L5:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
generate byte own_gen_source_state=st_elec_owngen_kwh
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L5:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L6:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
* Luluskan nilai hanya jika status sumber 0/1, kWh tidak kosong, dan nilainya tidak negatif. // WFDOC-INJECTED
generate byte own_gen_observed_valid=inlist(own_gen_source_state,0,1) & elec_owngen_kwh>=0 & !missing(elec_owngen_kwh)
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L6:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L7:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
generate byte own_gen_positive_reported=elec_owngen_kwh>0 if own_gen_observed_valid
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L7:step-generate" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L8:step-assert" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
assert missing(own_gen_positive_reported) if !own_gen_observed_valid
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L8:step-assert" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L9:step-keep" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
keep source_year source_row own_gen_source_state own_gen_observed_valid own_gen_positive_reported
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L9:step-keep" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L10:step-order" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L10:step-order" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L11:step-isid" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L11:step-isid" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L12:step-assert" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L12:step-assert" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C090_own_generation_domain.do:L13:step-g0c_finish" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C090_own_generation_domain" "C090"
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L13:step-g0c_finish" "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C090_own_generation_domain.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
