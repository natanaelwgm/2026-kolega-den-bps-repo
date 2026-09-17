* Tujuan: Untuk 2013, lengkapi export_any_binary dari export_binary_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_export_any_binary menyimpan salinan nilai awal; vs_export_any_binary menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/export_any_binary_2013.do dari data/intermediate/verified_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field export_any_binary, year 2013. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2013.log", text replace name(tcell)
* Mulai export_any_binary sebagai nilai kosong; vs_export_any_binary dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
clonevar v_export_any_binary=export_any_binary
* Lengkapi export_any_binary hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_export_any_binary menandai isian baru. // WFDOC-INJECTED
replace export_any_binary=(export_binary_raw==1) if missing(export_any_binary) & inlist(export_binary_raw,1,2)
replace vs_export_any_binary=10 if !missing(export_any_binary) & missing(v_export_any_binary)
assert inlist(export_any_binary,0,1) if !missing(export_any_binary)
assert export_any_binary==v_export_any_binary if !missing(v_export_any_binary)
* Hitung berapa baris export_any_binary yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(export_any_binary)
local n=r(N)
quietly count if !missing(v_export_any_binary)
local v=r(N)
quietly count if vs_export_any_binary==10 & !missing(export_any_binary)
post counts (2013) ("export_any_binary") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, export_any_binary, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row export_any_binary v_export_any_binary vs_export_any_binary
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2013.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_export_any_binary_2013"
log close tcell
