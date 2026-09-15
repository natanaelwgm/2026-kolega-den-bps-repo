* Tujuan: Bentuk satu berkas raw per tahun dari sumber tahunan yang terdaftar, lalu cek kunci tahun/baris. // WFDOC-INJECTED
* Input: code/annual/raw_2010.do; code/annual/raw_2011.do; dan 10 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L1:step-do" "code/stages/F010_raw.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2010.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L1:step-do" "code/stages/F010_raw.do:L1:file" "statement" 1 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L2:step-do" "code/stages/F010_raw.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2011.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L2:step-do" "code/stages/F010_raw.do:L1:file" "statement" 2 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L3:step-do" "code/stages/F010_raw.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2012.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L3:step-do" "code/stages/F010_raw.do:L1:file" "statement" 3 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L4:step-do" "code/stages/F010_raw.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2013.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L4:step-do" "code/stages/F010_raw.do:L1:file" "statement" 4 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L5:step-do" "code/stages/F010_raw.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2014.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L5:step-do" "code/stages/F010_raw.do:L1:file" "statement" 5 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L6:step-do" "code/stages/F010_raw.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2015.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L6:step-do" "code/stages/F010_raw.do:L1:file" "statement" 6 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L7:step-do" "code/stages/F010_raw.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2017.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L7:step-do" "code/stages/F010_raw.do:L1:file" "statement" 7 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L8:step-do" "code/stages/F010_raw.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2018.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L8:step-do" "code/stages/F010_raw.do:L1:file" "statement" 8 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L9:step-do" "code/stages/F010_raw.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2019.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L9:step-do" "code/stages/F010_raw.do:L1:file" "statement" 9 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L10:step-do" "code/stages/F010_raw.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2020.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L10:step-do" "code/stages/F010_raw.do:L1:file" "statement" 10 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L11:step-do" "code/stages/F010_raw.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2021.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L11:step-do" "code/stages/F010_raw.do:L1:file" "statement" 11 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L12:step-do" "code/stages/F010_raw.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2022.do"
capture noisily __wf_progress end "code/stages/F010_raw.do:L12:step-do" "code/stages/F010_raw.do:L1:file" "statement" 12 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F010_raw.do:L13:step-display" "code/stages/F010_raw.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
display "WF_STAGE_F010_PASS"
capture noisily __wf_progress end "code/stages/F010_raw.do:L13:step-display" "code/stages/F010_raw.do:L1:file" "statement" 13 13 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F010_raw.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
