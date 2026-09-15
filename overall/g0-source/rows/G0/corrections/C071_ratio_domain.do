* Tujuan: Tentukan baris yang layak untuk porsi nilai tambah/output: nilai tambah harus ada dan output harus ada serta positif. // WFDOC-INJECTED
* Input: corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C071.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C071_ratio_domain"
* Tentukan apakah pembagian nilai tambah dengan output dapat dihitung: pembilang harus ada dan output harus positif serta terisi. // WFDOC-INJECTED
use source_year source_row value_added_nominal gross_output_nominal using "corrections/data/C010.dta", clear
generate byte output_share_num_state=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0)))
generate byte output_share_den_state=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)))
* Tandai hanya baris yang memenuhi batas pembilang/penyebut yang dijelaskan di atas; missing dan penyebut nol tidak lolos. // WFDOC-INJECTED
generate byte output_share_eligible=(!missing(value_added_nominal)) & gross_output_nominal>0 & !missing(gross_output_nominal)
keep source_year source_row output_share_num_state output_share_den_state output_share_eligible
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C071_ratio_domain" "C071"
