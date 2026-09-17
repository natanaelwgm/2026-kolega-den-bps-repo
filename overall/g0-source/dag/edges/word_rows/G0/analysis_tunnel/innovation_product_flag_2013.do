* Tujuan: Untuk 2013, lengkapi innovation_product_flag dari innovation_product_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_product_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_product_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_product_flag_2013.do dari data/intermediate/verified_wave_2013.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field innovation_product_flag, year 2013. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2013.log", text replace name(tcell)
* Mulai innovation_product_flag sebagai nilai kosong; vs_innovation_product_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2013. // WFDOC-INJECTED
generate double innovation_product_flag=.
generate double v_innovation_product_flag=.
generate byte vs_innovation_product_flag=cond(missing(innovation_product_raw),4,7)
* Lengkapi innovation_product_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_product_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_product_flag=(innovation_product_raw==1) if missing(innovation_product_flag) & inlist(innovation_product_raw,1,2)
replace vs_innovation_product_flag=10 if !missing(innovation_product_flag) & missing(v_innovation_product_flag)
assert inlist(innovation_product_flag,0,1) if !missing(innovation_product_flag)
assert innovation_product_flag==v_innovation_product_flag if !missing(v_innovation_product_flag)
* Hitung berapa baris innovation_product_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_product_flag)
local n=r(N)
quietly count if !missing(v_innovation_product_flag)
local v=r(N)
quietly count if vs_innovation_product_flag==10 & !missing(innovation_product_flag)
post counts (2013) ("innovation_product_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, innovation_product_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_product_flag v_innovation_product_flag vs_innovation_product_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_product_flag_2013.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_product_flag_2013"
log close tcell
