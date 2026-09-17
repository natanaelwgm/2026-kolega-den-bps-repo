* Tujuan: Untuk 2014, ubah raw_disic514 menjadi industry_code; vs_industry_code mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong. // WFDOC-INJECTED
* Input: data/intermediate/raw_wave_2014.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_industry_code_2014.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat kolom sumber untuk industry_code tahun 2014; baris tetap memakai source_year dan source_row. // WFDOC-INJECTED
use source_year source_row raw_disic514 using "data/intermediate/raw_wave_2014.dta", clear
* Pastikan setiap baris milik tahun 2014; pemeriksaan isid berikutnya menolak kunci source_year/source_row yang berulang. // WFDOC-INJECTED
assert source_year==2014
isid source_year source_row
tempfile metrics
capture postclose cell
* Buka tabel hitungan diagnostik; isinya mencatat banyak baris dan status, bukan mengubah nilai sumber. // WFDOC-INJECTED
postfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics', replace
* Jalankan aturan pembentukan industry_code tahun 2014 yang ada di do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/variable_year/industry_code_2014.do"
postclose cell
