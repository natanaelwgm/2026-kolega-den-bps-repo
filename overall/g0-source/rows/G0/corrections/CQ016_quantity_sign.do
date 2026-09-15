* Tujuan: Untuk fuel_natgas_kg, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ016.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CQ016_quantity_sign"
use source_year source_row fuel_natgas_kg vs_fuel_natgas_kg using "corrections/data/C010.dta", clear
generate byte cq016_applicable=.
generate byte qs_fuel_natgas_kg=vs_fuel_natgas_kg
replace cq016_applicable=1 if source_year==2010
replace cq016_applicable=1 if source_year==2011
replace cq016_applicable=1 if source_year==2012
replace cq016_applicable=1 if source_year==2013
replace cq016_applicable=1 if source_year==2014
replace cq016_applicable=1 if source_year==2015
replace cq016_applicable=1 if source_year==2017
replace cq016_applicable=1 if source_year==2018
replace cq016_applicable=1 if source_year==2019
replace cq016_applicable=0 if source_year==2020
replace cq016_applicable=0 if source_year==2021
replace cq016_applicable=0 if source_year==2022
assert !missing(cq016_applicable)
generate byte qn_fuel_natgas_kg=fuel_natgas_kg<0 if cq016_applicable==1 & inlist(qs_fuel_natgas_kg,0,1,2) & !missing(fuel_natgas_kg)
assert missing(qn_fuel_natgas_kg) if cq016_applicable==0 | !inlist(qs_fuel_natgas_kg,0,1,2) | missing(fuel_natgas_kg)
keep source_year source_row qn_fuel_natgas_kg qs_fuel_natgas_kg cq016_applicable
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ016_quantity_sign" "CQ016"
