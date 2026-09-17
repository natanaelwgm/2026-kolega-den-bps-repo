* Tujuan: Untuk 2021, lengkapi innovation_marketing_flag dari innovation_marketing_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_marketing_flag adalah kolom pembanding yang dibuat terpisah; vs_innovation_marketing_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_marketing_flag_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat kolom sumber untuk innovation_marketing_flag tahun 2021; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2021.dta", clear
* Pastikan setiap baris milik tahun 2021; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2021
isid source_year source_row
tempfile metrics
capture postclose counts
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
* Jalankan aturan pembentukan innovation_marketing_flag tahun 2021 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_marketing_flag_2021.do"
postclose counts
