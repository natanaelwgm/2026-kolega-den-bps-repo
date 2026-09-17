* Tujuan: Hitung emisi cakupan 2 sebagai kWh listrik yang dibeli dikali faktor jaringan; kedua komponen harus ada dan tidak negatif. // WFDOC-INJECTED
* Input: corrections/data/C010.dta; corrections/data/CT002.dta // WFDOC-INJECTED
* Output: corrections/data/CT005.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT005_recompute_total"
use source_year source_row grid_factor_s1 using "corrections/data/C010.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CT002.dta", assert(match) nogen
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=r_elec_purchased_kwh if r_elec_purchased_kwh>=0 & !missing(r_elec_purchased_kwh)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=grid_factor_s1 if grid_factor_s1>=0 & !missing(grid_factor_s1)
egen byte r_co2_scope2_s1_n=rownonmiss(__component0 __component1)
generate double r_co2_scope2_s1=.
replace r_co2_scope2_s1=__component0*__component1 if r_co2_scope2_s1_n==2
assert missing(r_co2_scope2_s1) if r_co2_scope2_s1_n==0
keep source_year source_row r_co2_scope2_s1 r_co2_scope2_s1_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT005_recompute_total" "CT005"
