* Tujuan: Tandai laporan own-generation yang dapat dinilai hanya jika status sumbernya 0/1 dan kWh ada serta tidak negatif; flag positif hanya berlaku untuk nilai di atas nol. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C090.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C090_own_generation_domain"
* Anggap laporan own-generation layak dinilai hanya bila status sumbernya 0/1 dan nilai kWh terisi serta tidak negatif. // WFDOC-INJECTED
use source_year source_row elec_owngen_kwh st_elec_owngen_kwh using "corrections/data/C010.dta", clear
generate byte own_gen_source_state=st_elec_owngen_kwh
* Luluskan nilai hanya jika status sumber 0/1, kWh tidak kosong, dan nilainya tidak negatif. // WFDOC-INJECTED
generate byte own_gen_observed_valid=inlist(own_gen_source_state,0,1) & elec_owngen_kwh>=0 & !missing(elec_owngen_kwh)
generate byte own_gen_positive_reported=elec_owngen_kwh>0 if own_gen_observed_valid
assert missing(own_gen_positive_reported) if !own_gen_observed_valid
keep source_year source_row own_gen_source_state own_gen_observed_valid own_gen_positive_reported
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C090_own_generation_domain" "C090"
