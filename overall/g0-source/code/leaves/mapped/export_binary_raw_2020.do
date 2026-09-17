* Tujuan: Untuk 2020, ubah raw_ekspor20 menjadi export_binary_raw; vs_export_binary_raw mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_export_binary_raw_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat kolom sumber untuk export_binary_raw tahun 2020; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use source_year source_row raw_ekspor20 using "data/intermediate/raw_wave_2020.dta", clear
* Pastikan setiap baris milik tahun 2020; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2020
isid source_year source_row
tempfile metrics
capture postclose cell
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics', replace
* Jalankan aturan pembentukan export_binary_raw tahun 2020 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/variable_year/export_binary_raw_2020.do"
postclose cell
