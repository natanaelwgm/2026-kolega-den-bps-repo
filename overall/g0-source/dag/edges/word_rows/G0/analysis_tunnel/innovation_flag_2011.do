* Tujuan: Untuk 2011, lengkapi innovation_flag dari innovation_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_flag menyimpan salinan nilai awal; vs_innovation_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_flag_2011.do dari data/intermediate/verified_wave_2011.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2011.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field innovation_flag, year 2011. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2011.log", text replace name(tcell)
* Mulai innovation_flag sebagai nilai kosong; vs_innovation_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2011. // WFDOC-INJECTED
clonevar v_innovation_flag=innovation_flag
* Lengkapi innovation_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_flag=(innovation_raw==1) if missing(innovation_flag) & inlist(innovation_raw,1,2)
replace vs_innovation_flag=10 if !missing(innovation_flag) & missing(v_innovation_flag)
assert inlist(innovation_flag,0,1) if !missing(innovation_flag)
assert innovation_flag==v_innovation_flag if !missing(v_innovation_flag)
* Hitung berapa baris innovation_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_flag)
local n=r(N)
quietly count if !missing(v_innovation_flag)
local v=r(N)
quietly count if vs_innovation_flag==10 & !missing(innovation_flag)
post counts (2011) ("innovation_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, innovation_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_flag v_innovation_flag vs_innovation_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2011.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_flag_2011"
log close tcell
