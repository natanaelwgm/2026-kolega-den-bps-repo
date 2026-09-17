* Tujuan: Untuk 2019, lengkapi innovation_flag dari innovation_raw hanya saat nilainya kosong dan syarat kode terpenuhi; v_innovation_flag menyimpan salinan nilai awal; vs_innovation_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_innovation_flag_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat kolom sumber untuk innovation_flag tahun 2019; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2019.dta", clear
* Pastikan setiap baris milik tahun 2019; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2019
isid source_year source_row
tempfile metrics
capture postclose counts
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
* Jalankan aturan pembentukan innovation_flag tahun 2019 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_2019.do"
postclose counts
