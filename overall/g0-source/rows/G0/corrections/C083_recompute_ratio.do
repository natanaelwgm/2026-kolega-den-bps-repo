* Tujuan: Hitung ulang energi/output untuk baris yang lolos C073, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/CT006.dta; corrections/data/C010.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C083.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C083_recompute_ratio"
* Hitung ulang GJ energi/output hanya saat domain energi dan output memenuhi C073; simpan nilai lama untuk audit perubahan. // WFDOC-INJECTED
use source_year source_row r_total_gj_s1 using "corrections/data/CT006.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal energy_intensity_gj_nominal)
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C073.dta", assert(match) nogen keepusing(energy_eligible)
generate double energy_legacy_ratio=energy_intensity_gj_nominal
generate double ei_gj_output_repaired=.
* Hitung ulang ei_gj_output_repaired=r_total_gj_s1/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace ei_gj_output_repaired=r_total_gj_s1/gross_output_nominal if energy_eligible
generate byte energy_changed=(ei_gj_output_repaired!=energy_legacy_ratio)
assert missing(ei_gj_output_repaired) if !energy_eligible
keep source_year source_row ei_gj_output_repaired energy_legacy_ratio energy_changed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C083_recompute_ratio" "C083"
