* Tujuan: Jumlahkan pembelian listrik PLN dan non-PLN hanya dari komponen yang terisi serta tidak negatif; simpan banyak komponen yang membentuk total. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CT002.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT002_recompute_total"
use source_year source_row cl_elec_pln_kwh cl_elec_nonpln_kwh using "corrections/data/C010.dta", clear
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=cl_elec_pln_kwh if cl_elec_pln_kwh>=0 & !missing(cl_elec_pln_kwh)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=cl_elec_nonpln_kwh if cl_elec_nonpln_kwh>=0 & !missing(cl_elec_nonpln_kwh)
egen byte r_elec_purchased_kwh_n=rownonmiss(__component0 __component1)
egen double r_elec_purchased_kwh=rowtotal(__component0 __component1), missing
assert missing(r_elec_purchased_kwh) if r_elec_purchased_kwh_n==0
keep source_year source_row r_elec_purchased_kwh r_elec_purchased_kwh_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT002_recompute_total" "CT002"
