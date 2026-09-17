* Tujuan: Bandingkan flag own-generation lama dengan indikator nilai kWh positif; simpan apakah indikator tidak diketahui dan apakah hasilnya berbeda. // WFDOC-INJECTED
* Input: corrections/data/C090.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C100.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C100_own_generation_delta"
* Bandingkan flag own-generation lama dengan indikator positif dari angka yang dilaporkan; simpan tanda unknown dan apakah flag berubah. // WFDOC-INJECTED
use source_year source_row own_gen_positive_reported using "corrections/data/C090.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(own_generation_reported)
generate byte own_gen_legacy_flag=own_generation_reported
generate byte own_gen_unknown=missing(own_gen_positive_reported)
generate byte own_gen_flag_changed=own_gen_positive_reported!=own_gen_legacy_flag
keep source_year source_row own_gen_legacy_flag own_gen_unknown own_gen_flag_changed
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C100_own_generation_delta" "C100"
