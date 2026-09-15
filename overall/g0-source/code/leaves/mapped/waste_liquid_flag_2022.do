* Tujuan: Jalankan pemetaan waste_liquid_flag untuk wave 2022 dari kolom sumber raw_liwste22 dan raw_inspli22; aturan pemetaan berada di do-file anak. // WFDOC-INJECTED
* Input: raw_wave_2022.dta, termasuk source_year/source_row dan dua kolom raw yang disebut di atas. // WFDOC-INJECTED
* Output: kolom waste_liquid_flag tahun 2022 dan ringkasan hitungan observed/zeros/invalid/source_absent. // WFDOC-INJECTED
* Jika tahun, kunci baris, atau do-file anak gagal, wave ini belum selesai. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat hanya kunci baris dan kolom raw raw_liwste22/raw_inspli22 yang dipakai untuk pemetaan 2022. // WFDOC-INJECTED
use source_year source_row raw_liwste22 raw_inspli22 using "data/intermediate/raw_wave_2022.dta", clear
* Pastikan semua baris pada berkas ini milik tahun 2022. // WFDOC-INJECTED
assert source_year==2022
* Pastikan pasangan source_year/source_row tidak berulang; pasangan ini mengenali baris, bukan firmID. // WFDOC-INJECTED
isid source_year source_row
tempfile metrics
capture postclose cell
* Siapkan ringkasan diagnostics untuk jumlah baris, nilai teramati, nol, tidak valid, dan sumber yang tidak tersedia. // WFDOC-INJECTED
postfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics', replace
* Jalankan aturan pemetaan waste_liquid_flag khusus tahun 2022 pada do-file anak ini. // WFDOC-INJECTED
do "dag/edges/word_rows/G0/variable_year/waste_liquid_flag_2022.do"
* Tutup tabel hitungan setelah pemetaan selesai agar metrik dapat dibaca sebagai satu hasil. // WFDOC-INJECTED
postclose cell
