* Tujuan: Satukan hasil pemeriksaan tanda untuk kuantitas yang diuji ke satu baris per kunci tahun/baris. // WFDOC-INJECTED
* Input: corrections/data/CQ001.dta; corrections/data/CQ002.dta; dan 19 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C110.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C110_quantity_flag_states"
* Satukan status dan indikator berlaku dari seluruh pemeriksaan kuantitas dengan kunci tahun/baris yang sama. // WFDOC-INJECTED
use  using "corrections/data/CQ001.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ002.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ003.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ004.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ005.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ006.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ007.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ008.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ009.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ010.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ011.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ012.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ013.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ014.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ015.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ016.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ017.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ018.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ019.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ020.dta", assert(match) nogen
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/CQ021.dta", assert(match) nogen
keep source_year source_row qn_fuel_diesel_ltr qs_fuel_diesel_ltr cq001_applicable qn_fuel_petrol_ltr qs_fuel_petrol_ltr cq002_applicable qn_fuel_kerosene_ltr qs_fuel_kerosene_ltr cq003_applicable qn_fuel_coal_kg qs_fuel_coal_kg cq004_applicable qn_fuel_lpg_kg qs_fuel_lpg_kg cq005_applicable qn_fuel_citygas_m3 qs_fuel_citygas_m3 cq006_applicable qn_fuel_othergas_m3 qs_fuel_othergas_m3 cq007_applicable qn_fuel_coalbriq_kg qs_fuel_coalbriq_kg cq008_applicable qn_fuel_coke_kg qs_fuel_coke_kg cq009_applicable qn_fuel_firewood_kg qs_fuel_firewood_kg cq010_applicable qn_fuel_charcoal_kg qs_fuel_charcoal_kg cq011_applicable qn_fuel_dieseloil_ltr qs_fuel_dieseloil_ltr cq012_applicable qn_fuel_fueloil_ltr qs_fuel_fueloil_ltr cq013_applicable qn_fuel_lubricant_ltr qs_fuel_lubricant_ltr cq014_applicable qn_fuel_biodiesel_ltr qs_fuel_biodiesel_ltr cq015_applicable qn_fuel_natgas_kg qs_fuel_natgas_kg cq016_applicable qn_fuel_natgas_mmbtu qs_fuel_natgas_mmbtu cq017_applicable qn_fuel_biomass_kg qs_fuel_biomass_kg cq018_applicable qn_elec_pln_kwh qs_elec_pln_kwh cq019_applicable qn_elec_nonpln_kwh qs_elec_nonpln_kwh cq020_applicable qn_elec_owngen_kwh qs_elec_owngen_kwh cq021_applicable
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C110_quantity_flag_states" "C110"
