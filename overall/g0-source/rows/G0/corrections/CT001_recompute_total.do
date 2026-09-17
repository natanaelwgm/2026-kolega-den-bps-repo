* Tujuan: Jumlahkan komponen bahan bakar GJ yang ada dan tidak negatif; simpan berapa komponen yang tersedia agar total parsial dapat dibedakan dari total lengkap. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CT001.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CT001_recompute_total"
use source_year source_row gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke using "corrections/data/C010.dta", clear
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component0=gj_diesel if gj_diesel>=0 & !missing(gj_diesel)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component1=gj_petrol if gj_petrol>=0 & !missing(gj_petrol)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component2=gj_kerosene if gj_kerosene>=0 & !missing(gj_kerosene)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component3=gj_coal if gj_coal>=0 & !missing(gj_coal)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component4=gj_lpg if gj_lpg>=0 & !missing(gj_lpg)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component5=gj_citygas if gj_citygas>=0 & !missing(gj_citygas)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component6=gj_othergas if gj_othergas>=0 & !missing(gj_othergas)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component7=gj_coalbriq if gj_coalbriq>=0 & !missing(gj_coalbriq)
* Ambil komponen ini hanya bila nilainya ada dan tidak negatif; hitungan komponen menentukan apakah total dapat disimpan. // WFDOC-INJECTED
generate double __component8=gj_coke if gj_coke>=0 & !missing(gj_coke)
egen byte r_gj_fuel_s1_n=rownonmiss(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8)
egen double r_gj_fuel_s1=rowtotal(__component0 __component1 __component2 __component3 __component4 __component5 __component6 __component7 __component8), missing
assert missing(r_gj_fuel_s1) if r_gj_fuel_s1_n==0
keep source_year source_row r_gj_fuel_s1 r_gj_fuel_s1_n
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CT001_recompute_total" "CT001"
