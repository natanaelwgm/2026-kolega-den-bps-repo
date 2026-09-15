* Tujuan: Untuk fuel_biomass_kg, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ018.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L1:step-version" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 1 26 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L1:step-version" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 1 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L2:step-do" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 2 26 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L2:step-do" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 2 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L3:step-g0c_begin" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 3 26 `=_rc' // WFLOG-INJECTED
g0c_begin "CQ018_quantity_sign"
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L3:step-g0c_begin" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 3 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L4:step-use" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 4 26 `=_rc' // WFLOG-INJECTED
use source_year source_row fuel_biomass_kg vs_fuel_biomass_kg using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L4:step-use" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 4 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L5:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 5 26 `=_rc' // WFLOG-INJECTED
generate byte cq018_applicable=.
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L5:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 5 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L6:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 6 26 `=_rc' // WFLOG-INJECTED
generate byte qs_fuel_biomass_kg=vs_fuel_biomass_kg
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L6:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 6 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L7:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 7 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L7:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 7 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L8:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 8 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L8:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 8 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L9:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 9 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L9:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 9 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L10:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 10 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L10:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 10 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L11:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 11 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L11:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 11 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L12:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 12 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L12:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 12 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L13:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 13 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L13:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 13 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L14:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 14 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L14:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 14 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L15:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 15 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L15:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 15 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L16:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 16 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L16:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 16 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L17:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 17 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L17:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 17 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L18:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 18 26 `=_rc' // WFLOG-INJECTED
replace cq018_applicable=1 if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L18:step-replace" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 18 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L19:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 19 26 `=_rc' // WFLOG-INJECTED
assert !missing(cq018_applicable)
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L19:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 19 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L20:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 20 26 `=_rc' // WFLOG-INJECTED
generate byte qn_fuel_biomass_kg=fuel_biomass_kg<0 if cq018_applicable==1 & inlist(qs_fuel_biomass_kg,0,1,2) & !missing(fuel_biomass_kg)
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L20:step-generate" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 20 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L21:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 21 26 `=_rc' // WFLOG-INJECTED
assert missing(qn_fuel_biomass_kg) if cq018_applicable==0 | !inlist(qs_fuel_biomass_kg,0,1,2) | missing(fuel_biomass_kg)
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L21:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 21 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L22:step-keep" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 22 26 `=_rc' // WFLOG-INJECTED
keep source_year source_row qn_fuel_biomass_kg qs_fuel_biomass_kg cq018_applicable
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L22:step-keep" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 22 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L23:step-order" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 23 26 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L23:step-order" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 23 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L24:step-isid" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 24 26 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L24:step-isid" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 24 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L25:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 25 26 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L25:step-assert" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 25 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ018_quantity_sign.do:L26:step-g0c_finish" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 26 26 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ018_quantity_sign" "CQ018"
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L26:step-g0c_finish" "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "statement" 26 26 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CQ018_quantity_sign.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
