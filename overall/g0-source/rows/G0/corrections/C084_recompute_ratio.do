* Tujuan: Hitung ulang emisi/output untuk baris yang lolos C074, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/CT007.dta; corrections/data/C010.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C084.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C084_recompute_ratio"
* Hitung ulang CO2/output hanya saat domain emisi dan output memenuhi C074; simpan nilai lama untuk audit perubahan. // WFDOC-INJECTED
use source_year source_row r_co2_total_s1 using "corrections/data/CT007.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal co2_intensity_nominal)
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C074.dta", assert(match) nogen keepusing(carbon_eligible)
generate double carbon_legacy_ratio=co2_intensity_nominal
generate double ci_co2_output_repaired=.
* Hitung ulang ci_co2_output_repaired=r_co2_total_s1/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace ci_co2_output_repaired=r_co2_total_s1/gross_output_nominal if carbon_eligible
generate byte carbon_changed=(ci_co2_output_repaired!=carbon_legacy_ratio)
assert missing(ci_co2_output_repaired) if !carbon_eligible
keep source_year source_row ci_co2_output_repaired carbon_legacy_ratio carbon_changed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C084_recompute_ratio" "C084"
