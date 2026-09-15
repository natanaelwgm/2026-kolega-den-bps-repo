* Tujuan: Bandingkan nilai hasil koreksi dengan berkas keluaran yang diharapkan; pemeriksaan memakai kunci tahun/baris. // WFDOC-INJECTED
* Input: corrections/data/C140.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta // WFDOC-INJECTED
* Output: validation/V080.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "corrections/data/C140.dta", clear
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/corrections/data/C140.dta", all
display "WF_CORRECTED_VALUES_EXACT"
