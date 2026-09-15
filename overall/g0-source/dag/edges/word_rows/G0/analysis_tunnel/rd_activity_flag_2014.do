* Tujuan: Untuk 2014, lengkapi rd_activity_flag dari rd_indicator_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_rd_activity_flag menyimpan salinan nilai awal; vs_rd_activity_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/rd_activity_flag_2014.do dari data/intermediate/verified_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field rd_activity_flag, year 2014. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2014.log", text replace name(tcell)
* Mulai rd_activity_flag sebagai nilai kosong; vs_rd_activity_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2014. // WFDOC-INJECTED
clonevar v_rd_activity_flag=rd_activity_flag
* Lengkapi rd_activity_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_rd_activity_flag menandai isian baru. // WFDOC-INJECTED
replace rd_activity_flag=(rd_indicator_raw==1) if missing(rd_activity_flag) & inlist(rd_indicator_raw,1,2)
replace vs_rd_activity_flag=10 if !missing(rd_activity_flag) & missing(v_rd_activity_flag)
assert inlist(rd_activity_flag,0,1) if !missing(rd_activity_flag)
assert rd_activity_flag==v_rd_activity_flag if !missing(v_rd_activity_flag)
* Hitung berapa baris rd_activity_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_activity_flag)
local n=r(N)
quietly count if !missing(v_rd_activity_flag)
local v=r(N)
quietly count if vs_rd_activity_flag==10 & !missing(rd_activity_flag)
post counts (2014) ("rd_activity_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, rd_activity_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_activity_flag v_rd_activity_flag vs_rd_activity_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_rd_activity_flag_2014.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_rd_activity_flag_2014"
log close tcell
