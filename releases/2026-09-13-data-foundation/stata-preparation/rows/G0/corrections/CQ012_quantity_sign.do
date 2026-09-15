* Tujuan: Untuk fuel_dieseloil_ltr, teruskan status sumber dan tetapkan apakah pemeriksaan berlaku per tahun; nilai negatif dicatat terpisah dari nilai kosong. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/CQ012.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L1:step-version" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 1 27 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L1:step-version" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 1 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L2:step-do" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 2 27 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L2:step-do" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 2 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L3:step-g0c_begin" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 3 27 `=_rc' // WFLOG-INJECTED
g0c_begin "CQ012_quantity_sign"
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L3:step-g0c_begin" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 3 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L4:step-use" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 4 27 `=_rc' // WFLOG-INJECTED
use source_year source_row fuel_dieseloil_ltr vs_fuel_dieseloil_ltr using "corrections/data/C010.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L4:step-use" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 4 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L5:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 5 27 `=_rc' // WFLOG-INJECTED
generate byte cq012_applicable=.
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L5:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 5 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L6:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 6 27 `=_rc' // WFLOG-INJECTED
generate byte qs_fuel_dieseloil_ltr=vs_fuel_dieseloil_ltr
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L6:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 6 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L7:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 7 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2010
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L7:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 7 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L8:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 8 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2011
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L8:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 8 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L9:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 9 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2012
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L9:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 9 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L10:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 10 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2013
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L10:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 10 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L11:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 11 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2014
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L11:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 11 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L12:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 12 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2015
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L12:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 12 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L13:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 13 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2017
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L13:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 13 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L14:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 14 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2018
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L14:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 14 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L15:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 15 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2019
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L15:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 15 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L16:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 16 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L16:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 16 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L17:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 17 27 `=_rc' // WFLOG-INJECTED
replace qs_fuel_dieseloil_ltr=7 if source_year==2020
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L17:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 17 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L18:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 18 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2021
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L18:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 18 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L19:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 19 27 `=_rc' // WFLOG-INJECTED
replace cq012_applicable=1 if source_year==2022
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L19:step-replace" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 19 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L20:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 20 27 `=_rc' // WFLOG-INJECTED
assert !missing(cq012_applicable)
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L20:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 20 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L21:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 21 27 `=_rc' // WFLOG-INJECTED
generate byte qn_fuel_dieseloil_ltr=fuel_dieseloil_ltr<0 if cq012_applicable==1 & inlist(qs_fuel_dieseloil_ltr,0,1,2) & !missing(fuel_dieseloil_ltr)
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L21:step-generate" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 21 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L22:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 22 27 `=_rc' // WFLOG-INJECTED
assert missing(qn_fuel_dieseloil_ltr) if cq012_applicable==0 | !inlist(qs_fuel_dieseloil_ltr,0,1,2) | missing(fuel_dieseloil_ltr)
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L22:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 22 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L23:step-keep" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 23 27 `=_rc' // WFLOG-INJECTED
keep source_year source_row qn_fuel_dieseloil_ltr qs_fuel_dieseloil_ltr cq012_applicable
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L23:step-keep" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 23 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L24:step-order" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 24 27 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L24:step-order" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 24 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L25:step-isid" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 25 27 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L25:step-isid" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 25 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L26:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 26 27 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L26:step-assert" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 26 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/CQ012_quantity_sign.do:L27:step-g0c_finish" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 27 27 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "CQ012_quantity_sign" "CQ012"
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L27:step-g0c_finish" "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "statement" 27 27 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/CQ012_quantity_sign.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
