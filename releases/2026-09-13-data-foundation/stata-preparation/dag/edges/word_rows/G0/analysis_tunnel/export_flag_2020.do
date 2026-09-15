* Tujuan: Untuk 2020, lengkapi export_flag dari export_any_binary hanya saat nilainya kosong dan syarat kode terpenuhi; v_export_flag menyimpan salinan nilai awal; vs_export_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/export_flag_2020.do dari data/intermediate/verified_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Stable tunnel field export_flag, year 2020. Owner-authorized provisional branch.
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2020.log", text replace name(tcell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 1 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
* Mulai export_flag sebagai nilai kosong; vs_export_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
clonevar v_export_flag=export_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 2 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L4:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
generate byte vs_export_flag=cond(missing(v_export_flag),3,0)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L4:step-generate" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 3 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
* Lengkapi export_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_export_flag menandai isian baru. // WFDOC-INJECTED
replace export_flag=export_any_binary if missing(export_flag) & !missing(export_any_binary) & export_verified_conflict==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 4 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
replace vs_export_flag=10 if !missing(export_flag) & missing(v_export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 5 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
assert inlist(export_flag,0,1) if !missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 6 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L8:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
assert export_flag==v_export_flag if !missing(v_export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L8:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 7 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L9:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris export_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L9:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 8 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L10:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L10:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 9 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L11:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
quietly count if !missing(v_export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L11:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 10 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L12:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
local v=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L12:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 11 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L13:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
quietly count if vs_export_flag==10 & !missing(export_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L13:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 12 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L14:step-post" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
post counts (2020) ("export_flag") (_N) (`n') (`v') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L14:step-post" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 13 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L15:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, export_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L15:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 14 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L16:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
keep source_year source_row export_flag v_export_flag vs_export_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L16:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 15 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L17:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L17:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 16 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L18:step-save" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2020.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L18:step-save" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 17 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L19:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L19:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 18 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L20:step-display" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
display "TUNNEL_NODE_PASS N_G0_tunnel_export_flag_2020"
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L20:step-display" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 19 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L21:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
log close tcell
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L21:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "statement" 20 20 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2020.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
