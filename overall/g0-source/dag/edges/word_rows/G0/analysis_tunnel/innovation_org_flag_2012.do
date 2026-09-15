* Tujuan: Untuk 2012, lengkapi innovation_org_flag dari innovation_org_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_org_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_org_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_org_flag_2012.do dari data/intermediate/verified_wave_2012.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field innovation_org_flag, year 2012. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2012.log", text replace name(tcell)
* Mulai innovation_org_flag sebagai nilai kosong; vs_innovation_org_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2012. // WFDOC-INJECTED
generate double innovation_org_flag=.
generate double v_innovation_org_flag=.
generate byte vs_innovation_org_flag=cond(missing(innovation_org_raw),4,7)
* Lengkapi innovation_org_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_org_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_org_flag=(innovation_org_raw==7) if missing(innovation_org_flag) & inlist(innovation_org_raw,7,8)
replace vs_innovation_org_flag=10 if !missing(innovation_org_flag) & missing(v_innovation_org_flag)
assert inlist(innovation_org_flag,0,1) if !missing(innovation_org_flag)
assert innovation_org_flag==v_innovation_org_flag if !missing(v_innovation_org_flag)
* Hitung berapa baris innovation_org_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_org_flag)
local n=r(N)
quietly count if !missing(v_innovation_org_flag)
local v=r(N)
quietly count if vs_innovation_org_flag==10 & !missing(innovation_org_flag)
post counts (2012) ("innovation_org_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, innovation_org_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_org_flag v_innovation_org_flag vs_innovation_org_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_org_flag_2012.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_org_flag_2012"
log close tcell
