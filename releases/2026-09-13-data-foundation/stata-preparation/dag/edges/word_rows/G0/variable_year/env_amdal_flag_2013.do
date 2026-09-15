* Tujuan: Untuk 2013, kolom sumber env_amdal_flag tidak tersedia pada metode tahun ini; nilai dibiarkan kosong dengan status 4. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/env_amdal_flag_2013.do dari data/intermediate/raw_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_env_amdal_flag_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* N_G0_env_amdal_flag_2013: annual staged raw state -> env_amdal_flag at source_year/source_row.
* Evidence: 2020 BPS questionnaire reproduction Q225; 2021 Lampung PDF p88 Q225; 2022 Sumbar PDF p68 Q209. amdal: 1=present, 2=not yet present. 2021 installation versus 2022 treatment wording retained in evidence.
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
log using "$VYL/N_G0_env_amdal_flag_2013.log", text replace name(vycell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L3:step-log" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
* Mulai env_amdal_flag sebagai nilai kosong; vs_env_amdal_flag mulai dari kode 4. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double env_amdal_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L4:step-generate" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
generate byte vs_env_amdal_flag=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L5:step-generate" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L6:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris env_amdal_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(env_amdal_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L6:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L7:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
local obs=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L7:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
quietly count if env_amdal_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L8:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
local zeros=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L9:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
quietly count if inlist(vs_env_amdal_flag,5,6,8)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L10:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
local bad=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L11:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
quietly count if vs_env_amdal_flag==4
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L12:step-count" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
local absent=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L13:step-local" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L14:step-post" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
post cell (2013) ("env_amdal_flag") (_N) (`obs') (`zeros') (`bad') (`absent')
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L14:step-post" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L15:step-preserve" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, env_amdal_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L15:step-preserve" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L16:step-keep" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
keep source_year source_row env_amdal_flag vs_env_amdal_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L16:step-keep" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L17:step-isid" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L17:step-isid" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L18:step-save" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
save "$VYD/N_G0_env_amdal_flag_2013.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L18:step-save" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L19:step-restore" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L19:step-restore" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L20:step-display" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
display "VARIABLE_YEAR_PASS N_G0_env_amdal_flag_2013"
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L20:step-display" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L21:step-log" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
log close vycell
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L21:step-log" "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/variable_year/env_amdal_flag_2013.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
