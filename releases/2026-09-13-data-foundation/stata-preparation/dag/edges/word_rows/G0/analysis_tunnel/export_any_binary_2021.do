* Tujuan: Untuk 2021, lengkapi export_any_binary dari export_binary_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_export_any_binary menyimpan salinan nilai awal; vs_export_any_binary menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/export_any_binary_2021.do dari data/intermediate/verified_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Stable tunnel field export_any_binary, year 2021. Owner-authorized provisional branch.
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2021.log", text replace name(tcell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 1 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
* Mulai export_any_binary sebagai nilai kosong; vs_export_any_binary dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2021. // WFDOC-INJECTED
clonevar v_export_any_binary=export_any_binary
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 2 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
* Lengkapi export_any_binary hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_export_any_binary menandai isian baru. // WFDOC-INJECTED
replace export_any_binary=(export_binary_raw==1) if missing(export_any_binary) & inlist(export_binary_raw,1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 3 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
replace vs_export_any_binary=10 if !missing(export_any_binary) & missing(v_export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 4 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L6:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
assert inlist(export_any_binary,0,1) if !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L6:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 5 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
assert export_any_binary==v_export_any_binary if !missing(v_export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L7:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 6 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L8:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris export_any_binary yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L8:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 7 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L9:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L9:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 8 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
quietly count if !missing(v_export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L10:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 9 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
local v=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L11:step-local" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 10 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
quietly count if vs_export_any_binary==10 & !missing(export_any_binary)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L12:step-count" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 11 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L13:step-post" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
post counts (2021) ("export_any_binary") (_N) (`n') (`v') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L13:step-post" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 12 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L14:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, export_any_binary, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L14:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 13 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L15:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
keep source_year source_row export_any_binary v_export_any_binary vs_export_any_binary
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L15:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 14 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L16:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L16:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 15 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L17:step-save" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2021.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L17:step-save" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 16 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L18:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L18:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 17 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L19:step-display" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
display "TUNNEL_NODE_PASS N_G0_tunnel_export_any_binary_2021"
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L19:step-display" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 18 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L20:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
log close tcell
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L20:step-log" "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "statement" 19 19 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/export_any_binary_2021.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
