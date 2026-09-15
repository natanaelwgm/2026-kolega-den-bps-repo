* Tujuan: Untuk 2012, lengkapi innovation_process_flag dari innovation_process_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_process_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_process_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_process_flag_2012.do dari data/intermediate/verified_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Stable tunnel field innovation_process_flag, year 2012. Owner-authorized provisional branch.
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2012.log", text replace name(tcell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 1 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L3:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
* Mulai innovation_process_flag sebagai nilai kosong; vs_innovation_process_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double innovation_process_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L3:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 2 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L4:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
generate double v_innovation_process_flag=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L4:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 3 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L5:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
generate byte vs_innovation_process_flag=cond(missing(innovation_process_raw),4,7)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L5:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 4 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
* Lengkapi innovation_process_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_process_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_process_flag=(innovation_process_raw==3) if missing(innovation_process_flag) & inlist(innovation_process_raw,3,4)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 5 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L7:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
replace vs_innovation_process_flag=10 if !missing(innovation_process_flag) & missing(v_innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L7:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 6 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L8:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
assert inlist(innovation_process_flag,0,1) if !missing(innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L8:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 7 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L9:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
assert innovation_process_flag==v_innovation_process_flag if !missing(v_innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L9:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 8 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris innovation_process_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 9 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 10 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
quietly count if !missing(v_innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 11 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L13:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
local v=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L13:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 12 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L14:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
quietly count if vs_innovation_process_flag==10 & !missing(innovation_process_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L14:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 13 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L15:step-post" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
post counts (2012) ("innovation_process_flag") (_N) (`n') (`v') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L15:step-post" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 14 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L16:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, innovation_process_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L16:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 15 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L17:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
keep source_year source_row innovation_process_flag v_innovation_process_flag vs_innovation_process_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L17:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 16 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L18:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L18:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 17 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L19:step-save" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2012.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L19:step-save" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 18 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L20:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L20:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 19 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L21:step-display" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_process_flag_2012"
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L21:step-display" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 20 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L22:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
log close tcell
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L22:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "statement" 21 21 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_process_flag_2012.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
