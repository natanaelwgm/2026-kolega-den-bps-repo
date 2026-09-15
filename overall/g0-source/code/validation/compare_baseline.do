* Tujuan: Bandingkan keluaran baseline dengan master yang dipatok; perbedaan nilai atau kunci menghentikan validasi. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta; /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta // WFDOC-INJECTED
* Output: validation/V070.receipt // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", clear
* Bandingkan kolom satu per satu dengan berkas pembanding; perbedaan menghentikan pemeriksaan. // WFDOC-INJECTED
cf _all using "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-rebuild/dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta", all
display "WF_BASELINE_VALUES_EXACT"
