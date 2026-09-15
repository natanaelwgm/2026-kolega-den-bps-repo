* Tujuan: Untuk elec_nonpln_kwh, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "CQ020_quantity_sign"
use source_year source_row elec_nonpln_kwh vs_elec_nonpln_kwh using "corrections/data/C010.dta", clear
generate byte cq020_applicable=.
generate byte qs_elec_nonpln_kwh=vs_elec_nonpln_kwh
replace cq020_applicable=1 if source_year==2010
replace cq020_applicable=1 if source_year==2011
replace cq020_applicable=1 if source_year==2012
replace cq020_applicable=1 if source_year==2013
replace cq020_applicable=1 if source_year==2014
replace cq020_applicable=1 if source_year==2015
replace cq020_applicable=1 if source_year==2017
replace cq020_applicable=1 if source_year==2018
replace cq020_applicable=1 if source_year==2019
replace cq020_applicable=1 if source_year==2020
replace cq020_applicable=1 if source_year==2021
replace cq020_applicable=1 if source_year==2022
assert !missing(cq020_applicable)
generate byte qn_elec_nonpln_kwh=elec_nonpln_kwh<0 if cq020_applicable==1 & inlist(qs_elec_nonpln_kwh,0,1,2) & !missing(elec_nonpln_kwh)
assert missing(qn_elec_nonpln_kwh) if cq020_applicable==0 | !inlist(qs_elec_nonpln_kwh,0,1,2) | missing(elec_nonpln_kwh)
keep source_year source_row qn_elec_nonpln_kwh qs_elec_nonpln_kwh cq020_applicable
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ020_quantity_sign" "CQ020"
