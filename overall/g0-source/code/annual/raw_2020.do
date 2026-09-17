* Tujuan: Ambil data sumber tahun 2020, cek tahun dan keunikan baris, lalu simpan salinan tahunan berkolom raw_*. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/staged/sample_mfg2020_raw.dta // WFDOC-INJECTED
* Output: data/intermediate/raw_wave_2020.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Muat berkas sumber untuk satu tahun; barisnya lalu diberi kunci tahun dan nomor baris. // WFDOC-INJECTED
use "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/staged/sample_mfg2020_raw.dta", clear
assert source_year==2020
isid source_year source_row
save "data/intermediate/raw_wave_2020.dta", replace
