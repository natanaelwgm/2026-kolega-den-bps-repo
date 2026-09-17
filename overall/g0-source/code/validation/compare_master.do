* Tujuan: Bandingkan master gabungan dengan snapshot pembanding untuk memastikan baris dan kolom sama. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta // WFDOC-INJECTED
* Output: validation/V085.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "data/analysis/G0_analysis_ready.dta", clear
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _N==33049 & c(k)==4593
* Pastikan satu pasangan tahun/nomor baris hanya muncul sekali; pasangan ini mengenali baris, bukan firmID. // WFDOC-INJECTED
isid source_year source_row
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert rd17_own_token_class=="" & rd17_external_token_class=="" if source_year!=2017
drop rd17_own_token_class rd17_external_token_class
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta", all
display "WF_MASTER_ORIGINAL_4591_VALUES_EXACT"
