* Tujuan: Hitung ulang nilai tambah/output untuk baris yang lolos C071, sambil menyimpan rasio lama dan tanda perubahan. // WFDOC-INJECTED
* Input: corrections/data/C010.dta; corrections/data/C071.dta // WFDOC-INJECTED
* Output: corrections/data/C081.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C081_recompute_ratio"
* Hitung ulang porsi nilai tambah/output pada baris yang lolos pemeriksaan domain; simpan rasio lama untuk membandingkan perubahan. // WFDOC-INJECTED
use source_year source_row value_added_nominal gross_output_nominal value_added_share_of_output using "corrections/data/C010.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C071.dta", assert(match) nogen keepusing(output_share_eligible)
generate double output_share_legacy_ratio=value_added_share_of_output
generate double va_share_output_repaired=.
* Hitung ulang va_share_output_repaired=value_added_nominal/gross_output_nominal hanya untuk baris yang sudah dinyatakan layak; nilai lain tetap missing. // WFDOC-INJECTED
replace va_share_output_repaired=value_added_nominal/gross_output_nominal if output_share_eligible
generate byte output_share_changed=(va_share_output_repaired!=output_share_legacy_ratio)
assert missing(va_share_output_repaired) if !output_share_eligible
keep source_year source_row va_share_output_repaired output_share_legacy_ratio output_share_changed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C081_recompute_ratio" "C081"
