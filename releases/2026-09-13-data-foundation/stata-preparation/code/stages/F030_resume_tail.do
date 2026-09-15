capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Tujuan: Lengkapi lima variabel terakhir dan gabungan tahun 2022 dari proses yang terhenti.
* Input: Dua belas sumber tahunan; hasil sebelumnya wajib cocok dengan hash pada kontrak resume.
* Output: Sisa berkas variabel dan mapped_wave_2022.dta; seluruh hasil akan dibandingkan pada V060/V070.
* Gagal: Hentikan proses dan simpan kode error asli; jangan mengulang atau menerima hasil diam-diam.
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L5:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
* Siapkan lingkungan Stata yang sama dengan tahap wave lainnya. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L5:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L6:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
* Lanjutkan variabel waste solid 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_solid_flag_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L6:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L7:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
* Lanjutkan variabel waste liquid 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_liquid_flag_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L7:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L8:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
* Lanjutkan variabel waste hazardous 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_hazardous_flag_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L8:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L9:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
* Lanjutkan konversi bahan bakar gas alam ke MMBtu untuk 2022. // WFDOC-INJECTED
do "code/leaves/mapped/fuel_natgas_mmbtu_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L9:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L10:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
* Lanjutkan variabel kuantitas biomassa 2022. // WFDOC-INJECTED
do "code/leaves/mapped/fuel_biomass_kg_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L10:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L11:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
* Gabungkan seluruh hasil mapped 2022 menjadi wave tahunan setelah lima leaf tersisa selesai. // WFDOC-INJECTED
do "code/annual/merge_mapped_2022.do"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L11:step-do" "code/stages/F030_resume_tail.do:L1:file" "statement" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/stages/F030_resume_tail.do:L12:step-display" "code/stages/F030_resume_tail.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
* Tampilkan penanda selesai yang dipakai runner untuk mengenali akhir tail. // WFDOC-INJECTED
display "WF_F030_TAIL_COMPLETION_PASS"
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L12:step-display" "code/stages/F030_resume_tail.do:L1:file" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/stages/F030_resume_tail.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
