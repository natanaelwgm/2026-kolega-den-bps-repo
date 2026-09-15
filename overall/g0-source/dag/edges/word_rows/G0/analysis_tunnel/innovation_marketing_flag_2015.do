* Tujuan: Untuk 2015, lengkapi innovation_marketing_flag dari innovation_marketing_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_marketing_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_marketing_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/working/innovation_marketing_flag_2015.do dari data/intermediate/verified_wave_2015.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2015.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Stable tunnel field innovation_marketing_flag, year 2015. Owner-authorized provisional branch.
log using "dag/logs/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2015.log", text replace name(tcell)
* Mulai innovation_marketing_flag sebagai nilai kosong; vs_innovation_marketing_flag dimulai menurut kode yang tertulis. Baris berikut menerapkan aturan sumber tahun 2015. // WFDOC-INJECTED
generate double innovation_marketing_flag=.
generate double v_innovation_marketing_flag=.
generate byte vs_innovation_marketing_flag=cond(missing(innovation_marketing_raw),4,7)
* Lengkapi innovation_marketing_flag hanya saat nilai utama kosong dan syarat sumber di baris ini terpenuhi; vs_innovation_marketing_flag menandai isian baru. // WFDOC-INJECTED
replace innovation_marketing_flag=(innovation_marketing_raw==5) if missing(innovation_marketing_flag) & inlist(innovation_marketing_raw,5,6)
replace vs_innovation_marketing_flag=10 if !missing(innovation_marketing_flag) & missing(v_innovation_marketing_flag)
assert inlist(innovation_marketing_flag,0,1) if !missing(innovation_marketing_flag)
assert innovation_marketing_flag==v_innovation_marketing_flag if !missing(v_innovation_marketing_flag)
* Hitung berapa baris innovation_marketing_flag yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(innovation_marketing_flag)
local n=r(N)
quietly count if !missing(v_innovation_marketing_flag)
local v=r(N)
quietly count if vs_innovation_marketing_flag==10 & !missing(innovation_marketing_flag)
post counts (2015) ("innovation_marketing_flag") (_N) (`n') (`v') (r(N))
* Simpan hanya source_year/source_row, innovation_marketing_flag, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row innovation_marketing_flag v_innovation_marketing_flag vs_innovation_marketing_flag
isid source_year source_row
save "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2015.dta", replace
restore
display "TUNNEL_NODE_PASS N_G0_tunnel_innovation_marketing_flag_2015"
log close tcell
