* Tujuan: Pertahankan flag ekor harga lama, tetapi biarkan banyak observasi yang dinilai kosong karena penyebut belum diketahui. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C130.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C130_price_flag_scope"
* Pertahankan flag ekor harga lama, tetapi jumlah observasi yang dinilai dibiarkan kosong karena denominator belum diketahui. // WFDOC-INJECTED
use source_year source_row any_implausible_price using "corrections/data/C010.dta", clear
generate byte legacy_price_tail_flag=any_implausible_price
generate int price_tail_evaluated_n=.
generate str60 price_tail_source_gate="unknown_denominator; inherited_empirical_tail_only"
keep source_year source_row legacy_price_tail_flag price_tail_evaluated_n price_tail_source_gate
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C130_price_flag_scope" "C130"
