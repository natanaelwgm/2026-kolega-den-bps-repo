* Tujuan: Satukan hasil pemeriksaan tanda untuk kuantitas yang diuji ke satu baris per kunci tahun/baris. // WFDOC-INJECTED
* Input: corrections/data/CQ001.dta; corrections/data/CQ002.dta; dan 19 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C110.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L1:step-version" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 1 29 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L1:step-version" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 1 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L2:step-do" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 2 29 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L2:step-do" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 2 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L3:step-g0c_begin" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 3 29 `=_rc' // WFLOG-INJECTED
g0c_begin "C110_quantity_flag_states"
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L3:step-g0c_begin" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 3 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L4:step-use" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 4 29 `=_rc' // WFLOG-INJECTED
* Satukan status dan indikator berlaku dari seluruh pemeriksaan kuantitas dengan kunci tahun/baris yang sama. // WFDOC-INJECTED
use  using "corrections/data/CQ001.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L4:step-use" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 4 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L5:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 5 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ002.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L5:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 5 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L6:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 6 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ003.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L6:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 6 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L7:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 7 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ004.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L7:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 7 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L8:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 8 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ005.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L8:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 8 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L9:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 9 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ006.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L9:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 9 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L10:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 10 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ007.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L10:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 10 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L11:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 11 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ008.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L11:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 11 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L12:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 12 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ009.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L12:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 12 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L13:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 13 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ010.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L13:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 13 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L14:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 14 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ011.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L14:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 14 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L15:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 15 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ012.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L15:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 15 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L16:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 16 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ013.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L16:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 16 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L17:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 17 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ014.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L17:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 17 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L18:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 18 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ015.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L18:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 18 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L19:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 19 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ016.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L19:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 19 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L20:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 20 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ017.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L20:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 20 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L21:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 21 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ018.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L21:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 21 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L22:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 22 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ019.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L22:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 22 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L23:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 23 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ020.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L23:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 23 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L24:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 24 29 `=_rc' // WFLOG-INJECTED
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ021.dta", assert(match) nogen
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L24:step-merge" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 24 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L25:step-keep" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 25 29 `=_rc' // WFLOG-INJECTED
keep source_year source_row qn_fuel_diesel_ltr qs_fuel_diesel_ltr cq001_applicable qn_fuel_petrol_ltr qs_fuel_petrol_ltr cq002_applicable qn_fuel_kerosene_ltr qs_fuel_kerosene_ltr cq003_applicable qn_fuel_coal_kg qs_fuel_coal_kg cq004_applicable qn_fuel_lpg_kg qs_fuel_lpg_kg cq005_applicable qn_fuel_citygas_m3 qs_fuel_citygas_m3 cq006_applicable qn_fuel_othergas_m3 qs_fuel_othergas_m3 cq007_applicable qn_fuel_coalbriq_kg qs_fuel_coalbriq_kg cq008_applicable qn_fuel_coke_kg qs_fuel_coke_kg cq009_applicable qn_fuel_firewood_kg qs_fuel_firewood_kg cq010_applicable qn_fuel_charcoal_kg qs_fuel_charcoal_kg cq011_applicable qn_fuel_dieseloil_ltr qs_fuel_dieseloil_ltr cq012_applicable qn_fuel_fueloil_ltr qs_fuel_fueloil_ltr cq013_applicable qn_fuel_lubricant_ltr qs_fuel_lubricant_ltr cq014_applicable qn_fuel_biodiesel_ltr qs_fuel_biodiesel_ltr cq015_applicable qn_fuel_natgas_kg qs_fuel_natgas_kg cq016_applicable qn_fuel_natgas_mmbtu qs_fuel_natgas_mmbtu cq017_applicable qn_fuel_biomass_kg qs_fuel_biomass_kg cq018_applicable qn_elec_pln_kwh qs_elec_pln_kwh cq019_applicable qn_elec_nonpln_kwh qs_elec_nonpln_kwh cq020_applicable qn_elec_owngen_kwh qs_elec_owngen_kwh cq021_applicable
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L25:step-keep" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 25 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L26:step-order" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 26 29 `=_rc' // WFLOG-INJECTED
order source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L26:step-order" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 26 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L27:step-isid" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 27 29 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L27:step-isid" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 27 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L28:step-assert" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 28 29 `=_rc' // WFLOG-INJECTED
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L28:step-assert" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 28 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/C110_quantity_flag_states.do:L29:step-g0c_finish" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 29 29 `=_rc' // WFLOG-INJECTED
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C110_quantity_flag_states" "C110"
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L29:step-g0c_finish" "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "statement" 29 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/C110_quantity_flag_states.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
