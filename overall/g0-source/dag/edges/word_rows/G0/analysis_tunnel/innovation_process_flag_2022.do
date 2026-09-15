* Tujuan: Untuk 2022, lengkapi innovation_process_flag dari innovation_process_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_process_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_process_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_process_flag_2022.do dari data/intermediate/verified_wave_2022.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2022.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field innovation_process_flag, year 2022. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2022.log", text replace name(tcell)
* Mulai innovation_process_flag sebagai nilai kosong; vs_innovation_process_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2022. // WFDOC-INJECTED
generate double innovation_process_flag=.
generate double v_innovation_process_flag=.
generate byte vs_innovation_process_flag=cond(missing(innovation_process_raw),4,7)
* Lengkapi innovation_process_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_process_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_process_flag=(innovation_process_raw==3) if missing(innovation_process_flag) & inlist(innovation_process_raw,3,4)
replace vs_innovation_process_flag=10 if !missing(innovation_process_flag) & missing(v_innovation_process_flag)
assert inlist(innovation_process_flag,0,1) if !missing(innovation_process_flag)
assert innovation_process_flag==v_innovation_process_flag if !missing(v_innovation_process_flag)
* Hitung berapa baris innovation_process_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_process_flag)
local n=r(N)
quietly count if !missing(v_innovation_process_flag)
local v=r(N)
quietly count if vs_innovation_process_flag==10 & !missing(innovation_process_flag)
post counts (2022) ("innovation_process_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, innovation_process_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_process_flag v_innovation_process_flag vs_innovation_process_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_process_flag_2022.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_process_flag_2022"
log close tcell
