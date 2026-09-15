* Tujuan: Untuk 2011, lengkapi rd_activity_flag dari rd_indicator_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_rd_activity_flag menyimpan salinan nilai awal; vs_rd_activity_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/rd_activity_flag_2011.do dari data/intermediate/verified_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Stable tunnel field rd_activity_flag, year 2011. Owner-authorized provisional branch.
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2011.log", text replace name(tcell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
* Mulai rd_activity_flag sebagai nilai kosong; vs_rd_activity_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
clonevar v_rd_activity_flag=rd_activity_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
* Lengkapi rd_activity_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_rd_activity_flag menandai isian baru. // WFDOC-INJECTED
replace rd_activity_flag=(rd_indicator_raw==1) if missing(rd_activity_flag) & inlist(rd_indicator_raw,1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
replace vs_rd_activity_flag=10 if !missing(rd_activity_flag) & missing(v_rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L6:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
assert inlist(rd_activity_flag,0,1) if !missing(rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L6:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
assert rd_activity_flag==v_rd_activity_flag if !missing(v_rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L8:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris rd_activity_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L8:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L9:step-local" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L9:step-local" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
quietly count if !missing(v_rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
local v=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
quietly count if vs_rd_activity_flag==10 & !missing(rd_activity_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L13:step-post" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
post counts (2011) ("rd_activity_flag") (_N) (`n') (`v') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L13:step-post" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L14:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, rd_activity_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L14:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L15:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
keep source_year source_row rd_activity_flag v_rd_activity_flag vs_rd_activity_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L15:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L16:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L16:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L17:step-save" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2011.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L17:step-save" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L18:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L18:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L19:step-display" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
display "TUNNEL_NODE_PASS N_G0_tunnel_rd_activity_flag_2011"
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L19:step-display" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L20:step-log" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
log close tcell
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L20:step-log" "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/rd_activity_flag_2011.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
