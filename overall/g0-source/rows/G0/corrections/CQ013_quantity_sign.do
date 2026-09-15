* Tujuan: Untuk fuel_fueloil_ltr, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ013.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CQ013_quantity_sign"
use source_year source_row fuel_fueloil_ltr vs_fuel_fueloil_ltr using "corrections/data/C010.dta", clear
generate byte cq013_applicable=.
generate byte qs_fuel_fueloil_ltr=vs_fuel_fueloil_ltr
replace cq013_applicable=1 if source_year==2010
replace cq013_applicable=1 if source_year==2011
replace cq013_applicable=1 if source_year==2012
replace cq013_applicable=1 if source_year==2013
replace cq013_applicable=1 if source_year==2014
replace cq013_applicable=1 if source_year==2015
replace cq013_applicable=1 if source_year==2017
replace cq013_applicable=1 if source_year==2018
replace cq013_applicable=1 if source_year==2019
replace cq013_applicable=1 if source_year==2020
replace cq013_applicable=1 if source_year==2021
replace cq013_applicable=1 if source_year==2022
assert !missing(cq013_applicable)
generate byte qn_fuel_fueloil_ltr=fuel_fueloil_ltr<0 if cq013_applicable==1 & inlist(qs_fuel_fueloil_ltr,0,1,2) & !missing(fuel_fueloil_ltr)
assert missing(qn_fuel_fueloil_ltr) if cq013_applicable==0 | !inlist(qs_fuel_fueloil_ltr,0,1,2) | missing(fuel_fueloil_ltr)
keep source_year source_row qn_fuel_fueloil_ltr qs_fuel_fueloil_ltr cq013_applicable
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ013_quantity_sign" "CQ013"
