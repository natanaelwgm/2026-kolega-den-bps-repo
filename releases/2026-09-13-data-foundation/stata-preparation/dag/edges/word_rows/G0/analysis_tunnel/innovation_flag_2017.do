* Tujuan: Untuk 2017, lengkapi innovation_flag dari innovation_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_flag menyimpan salinan nilai awal; vs_innovation_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_flag_2017.do dari data/intermediate/verified_wave_2017.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2017.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
* Stable tunnel field innovation_flag, year 2017. Owner-authorized provisional branch.
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2017.log", text replace name(tcell)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L2:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 1 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
* Mulai innovation_flag sebagai nilai kosong; vs_innovation_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2017. // WFDOC-INJECTED
clonevar v_innovation_flag=innovation_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L3:step-clonevar" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 2 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
* Lengkapi innovation_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_flag=(innovation_raw==1) if missing(innovation_flag) & inlist(innovation_raw,1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L4:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 3 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
replace vs_innovation_flag=10 if !missing(innovation_flag) & missing(v_innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L5:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 4 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
replace innovation_flag=1 if missing(innovation_flag) & (innovation_product_flag==1 | innovation_process_flag==1 | innovation_marketing_flag==1 | innovation_org_flag==1)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L6:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 5 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L7:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
replace innovation_flag=0 if missing(innovation_flag) & innovation_product_flag==0 & innovation_process_flag==0 & innovation_marketing_flag==0 & innovation_org_flag==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L7:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 6 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L8:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
replace vs_innovation_flag=10 if !missing(innovation_flag) & missing(v_innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L8:step-replace" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 7 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L9:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
assert inlist(innovation_flag,0,1) if !missing(innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L9:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 8 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L10:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
assert innovation_flag==v_innovation_flag if !missing(v_innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L10:step-assert" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 9 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L11:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
* Hitung berapa baris innovation_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L11:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 10 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L12:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
local n=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L12:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 11 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L13:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
quietly count if !missing(v_innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L13:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 12 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L14:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
local v=r(N)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L14:step-local" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 13 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L15:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
quietly count if vs_innovation_flag==10 & !missing(innovation_flag)
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L15:step-count" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 14 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L16:step-post" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
post counts (2017) ("innovation_flag") (_N) (`n') (`v') (r(N))
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L16:step-post" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 15 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L17:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
* Simpan hanya source_year/source_row, innovation_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L17:step-preserve" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 16 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L18:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
keep source_year source_row innovation_flag v_innovation_flag vs_innovation_flag
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L18:step-keep" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 17 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L19:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L19:step-isid" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 18 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L20:step-save" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2017.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L20:step-save" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 19 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L21:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L21:step-restore" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 20 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L22:step-display" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_flag_2017"
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L22:step-display" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 21 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L23:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
log close tcell
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L23:step-log" "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "statement" 22 22 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2017.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
