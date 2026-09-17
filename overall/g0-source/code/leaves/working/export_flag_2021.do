* Tujuan: Untuk 2021, lengkapi export_flag dari export_any_binary hanya saat nilainya kosong dan syarat kode terpenuhi; v_export_flag menyimpan salinan nilai awal; vs_export_flag menandai pengisian sesuai aturan yang ada. // WFDOC-INJECTED
* Input: data/intermediate/verified_wave_2021.dta; dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2021.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_flag_2021.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat kolom sumber untuk export_flag tahun 2021; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use "data/intermediate/verified_wave_2021.dta", clear
* Pastikan setiap baris milik tahun 2021; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2021
isid source_year source_row
drop export_any_binary vs_export_any_binary
merge 1:1 source_year source_row using "dag/data/word_data/G0/analysis_tunnel/N_G0_tunnel_export_any_binary_2021.dta", assert(match) nogen keepusing(export_any_binary vs_export_any_binary)
tempfile metrics
capture postclose counts
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics', replace
* Jalankan aturan pembentukan export_flag tahun 2021 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/analysis_tunnel/export_flag_2021.do"
postclose counts
