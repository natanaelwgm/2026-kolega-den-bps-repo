* Tujuan: Hitung ulang biaya energi/output untuk baris yang lolos C072, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/C061.dta; corrections/data/C010.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/data/C082.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C082_recompute_ratio"
* Hitung ulang biaya energi/output hanya saat domain biaya dan output memenuhi C072; simpan nilai lama untuk audit perubahan. // WFDOC-INJECTED
use source_year source_row energy_exp_observed_repaired using "corrections/data/C061.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal energy_intensity_monetary)
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C072.dta", assert(match) nogen keepusing(monetary_eligible)
generate double monetary_legacy_ratio=energy_intensity_monetary
generate double ei_money_output_repaired=.
* Hitung ulang ei_money_output_repaired=energy_exp_observed_repaired/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace ei_money_output_repaired=energy_exp_observed_repaired/gross_output_nominal if monetary_eligible
generate byte monetary_changed=(ei_money_output_repaired!=monetary_legacy_ratio)
assert missing(ei_money_output_repaired) if !monetary_eligible
keep source_year source_row ei_money_output_repaired monetary_legacy_ratio monetary_changed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C082_recompute_ratio" "C082"
