* Tujuan: Untuk 2019, lengkapi export_flag dari export_any_binary hanya saat nilainya kosong dan syarat kode terpenuhi; v_export_flag menyimpan salinan nilai awal; vs_export_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/export_flag_2019.do dari data/intermediate/verified_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field export_flag, year 2019. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2019.log", text replace name(tcell)
* Mulai export_flag sebagai nilai kosong; vs_export_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
clonevar v_export_flag=export_flag
generate byte vs_export_flag=cond(missing(v_export_flag),3,0)
* Lengkapi export_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_export_flag menandai isian baru. // WFDOC-INJECTED
replace export_flag=export_any_binary if missing(export_flag) & !missing(export_any_binary) & export_verified_conflict==0
replace vs_export_flag=10 if !missing(export_flag) & missing(v_export_flag)
assert inlist(export_flag,0,1) if !missing(export_flag)
assert export_flag==v_export_flag if !missing(v_export_flag)
* Hitung berapa baris export_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_flag)
local n=r(N)
quietly count if !missing(v_export_flag)
local v=r(N)
quietly count if vs_export_flag==10 & !missing(export_flag)
post counts (2019) ("export_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, export_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_flag v_export_flag vs_export_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2019.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_export_flag_2019"
log close tcell
