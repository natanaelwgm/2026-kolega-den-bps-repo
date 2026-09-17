* Tujuan: Untuk 2020, lengkapi rd_external_funding_flag dari legacy_rd_cost_mislabelled hanya saat nilainya kosong dan syarat kode terpenuhi; v_rd_external_funding_flag menyimpan salinan nilai awal; vs_rd_external_funding_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/rd_external_funding_flag_2020.do dari data/intermediate/verified_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field rd_external_funding_flag, year 2020. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2020.log", text replace name(tcell)
* Mulai rd_external_funding_flag sebagai nilai kosong; vs_rd_external_funding_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2020. // WFDOC-INJECTED
clonevar v_rd_external_funding_flag=rd_external_funding_flag
* Lengkapi rd_external_funding_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_rd_external_funding_flag menandai isian baru. // WFDOC-INJECTED
replace rd_external_funding_flag=(legacy_rd_cost_mislabelled==1) if missing(rd_external_funding_flag) & inlist(legacy_rd_cost_mislabelled,1,2)
replace vs_rd_external_funding_flag=10 if !missing(rd_external_funding_flag) & missing(v_rd_external_funding_flag)
assert inlist(rd_external_funding_flag,0,1) if !missing(rd_external_funding_flag)
assert rd_external_funding_flag==v_rd_external_funding_flag if !missing(v_rd_external_funding_flag)
* Hitung berapa baris rd_external_funding_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_external_funding_flag)
local n=r(N)
quietly count if !missing(v_rd_external_funding_flag)
local v=r(N)
quietly count if vs_rd_external_funding_flag==10 & !missing(rd_external_funding_flag)
post counts (2020) ("rd_external_funding_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, rd_external_funding_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_external_funding_flag v_rd_external_funding_flag vs_rd_external_funding_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_external_funding_flag_2020.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_rd_external_funding_flag_2020"
log close tcell
