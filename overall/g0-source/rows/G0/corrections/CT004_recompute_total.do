* Tujuan: Jumlahkan komponen emisi bahan bakar yang tersedia dan tidak negatif untuk membentuk total cakupan 1; jumlah komponen tetap dicatat. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CT004.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT004_recompute_total"
use source_year source_row co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1 using "corrections/data/C010.dta", clear
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=co2_diesel_s1 if co2_diesel_s1>=0 & !missing(co2_diesel_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=co2_petrol_s1 if co2_petrol_s1>=0 & !missing(co2_petrol_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component2=co2_kerosene_s1 if co2_kerosene_s1>=0 & !missing(co2_kerosene_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component3=co2_coal_s1 if co2_coal_s1>=0 & !missing(co2_coal_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component4=co2_lpg_s1 if co2_lpg_s1>=0 & !missing(co2_lpg_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component5=co2_citygas_s1 if co2_citygas_s1>=0 & !missing(co2_citygas_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component6=co2_othergas_s1 if co2_othergas_s1>=0 & !missing(co2_othergas_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component7=co2_coalbriq_s1 if co2_coalbriq_s1>=0 & !missing(co2_coalbriq_s1)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component8=co2_coke_s1 if co2_coke_s1>=0 & !missing(co2_coke_s1)
egen byte r_co2_scope1_s1_n=rownonmiss(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8)
egen double r_co2_scope1_s1=rowtotal(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8), missing
assert missing(r_co2_scope1_s1) if r_co2_scope1_s1_n==0
keep source_year source_row r_co2_scope1_s1 r_co2_scope1_s1_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT004_recompute_total" "CT004"
