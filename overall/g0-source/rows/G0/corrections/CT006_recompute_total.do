* Tujuan: Jumlahkan total GJ bahan bakar dan listrik hanya jika kedua subtotal ada; bila salah satu belum ada, total gabungan dibuat missing. // WFDOC-INJECTED
* Input: corrections/data/CT001.dta; corrections/data/CT003.dta // WFDOC-INJECTED
* Output: corrections/data/CT006.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT006_recompute_total"
use  using "corrections/data/CT001.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CT003.dta", assert(match) nogen
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=r_gj_fuel_s1 if r_gj_fuel_s1>=0 & !missing(r_gj_fuel_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=r_gj_electricity if r_gj_electricity>=0 & !missing(r_gj_electricity)
egen byte r_total_gj_s1_n=rownonmiss(__component0 __component1)
egen double r_total_gj_s1=rowtotal(__component0 __component1), missing
replace r_total_gj_s1=. if r_total_gj_s1_n!=2
assert missing(r_total_gj_s1) if r_total_gj_s1_n==0
keep source_year source_row r_total_gj_s1 r_total_gj_s1_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT006_recompute_total" "CT006"
