* Tujuan: Untuk fuel_citygas_m3, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ006.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CQ006_quantity_sign"
use source_year source_row fuel_citygas_m3 vs_fuel_citygas_m3 using "corrections/data/C010.dta", clear
generate byte cq006_applicable=.
generate byte qs_fuel_citygas_m3=vs_fuel_citygas_m3
replace cq006_applicable=1 if source_year==2010
replace cq006_applicable=1 if source_year==2011
replace cq006_applicable=1 if source_year==2012
replace cq006_applicable=1 if source_year==2013
replace cq006_applicable=1 if source_year==2014
replace cq006_applicable=1 if source_year==2015
replace cq006_applicable=1 if source_year==2017
replace cq006_applicable=1 if source_year==2018
replace cq006_applicable=1 if source_year==2019
replace cq006_applicable=1 if source_year==2020
replace cq006_applicable=1 if source_year==2021
replace cq006_applicable=1 if source_year==2022
assert !missing(cq006_applicable)
generate byte qn_fuel_citygas_m3=fuel_citygas_m3<0 if cq006_applicable==1 & inlist(qs_fuel_citygas_m3,0,1,2) & !missing(fuel_citygas_m3)
assert missing(qn_fuel_citygas_m3) if cq006_applicable==0 | !inlist(qs_fuel_citygas_m3,0,1,2) | missing(fuel_citygas_m3)
keep source_year source_row qn_fuel_citygas_m3 qs_fuel_citygas_m3 cq006_applicable
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ006_quantity_sign" "CQ006"
