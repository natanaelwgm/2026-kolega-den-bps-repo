* Tujuan: Tentukan baris yang layak untuk energi/output: energi harus ada dan tidak negatif; output harus ada dan positif. // WFDOC-INJECTED
* Input: corrections/data/CT006.dta; corrections/data/C010.dta // WFDOC-INJECTED
* Output: corrections/data/C073.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C073_ratio_domain"
* Tentukan apakah energi per output dapat dihitung: energi tidak negatif dan output positif, keduanya terisi. // WFDOC-INJECTED
use source_year source_row r_total_gj_s1 using "corrections/data/CT006.dta", clear
* Pasangkan hasil per baris dengan kunci tahun dan nomor baris; `1:1` memeriksa kunci tunggal dan `assert(match)` menghentikan proses bila pasangan tidak lengkap. // WFDOC-INJECTED
merge 1:1 source_year source_row using "corrections/data/C010.dta", assert(match) nogen keepusing(gross_output_nominal)
generate byte energy_num_state=cond(missing(r_total_gj_s1),3,cond(r_total_gj_s1<0,2,cond(r_total_gj_s1==0,1,0)))
generate byte energy_den_state=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0)))
* Tandai hanya baris yang memenuhi batas pembilang/penyebut yang dijelaskan di atas; missing dan penyebut nol tidak lolos. // WFDOC-INJECTED
generate byte energy_eligible=(r_total_gj_s1>=0 & !missing(r_total_gj_s1)) & gross_output_nominal>0 & !missing(gross_output_nominal)
keep source_year source_row energy_num_state energy_den_state energy_eligible
order source_year source_row
isid source_year source_row
* Pastikan keluaran tetap memuat 33.049 baris; kalau tidak, proses berhenti sebelum tabel disimpan. // WFDOC-INJECTED
assert _N==33049
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C073_ratio_domain" "C073"
