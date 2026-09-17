* Tujuan: Ubah total pembelian listrik kWh menjadi GJ dengan faktor 0,0036; hasil hanya dibuat bila komponen listrik tersedia. // WFDOC-INJECTED
* Input: corrections/data/CT002.dta // WFDOC-INJECTED
* Output: corrections/data/CT003.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT003_recompute_total"
use  using "corrections/data/CT002.dta", clear
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=r_elec_purchased_kwh if r_elec_purchased_kwh>=0 & !missing(r_elec_purchased_kwh)
egen byte r_gj_electricity_n=rownonmiss(__component0)
generate double r_gj_electricity=.
replace r_gj_electricity=__component0*.0036 if r_gj_electricity_n==1
assert missing(r_gj_electricity) if r_gj_electricity_n==0
keep source_year source_row r_gj_electricity r_gj_electricity_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT003_recompute_total" "CT003"
