* Tujuan: Atur lingkungan Stata, lokasi kerja, batas variabel, dan folder sementara yang dipakai oleh semua do-file tahap ini. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
set more off
set varabbrev off
* Isi blok hanya dijalankan bila c(maxvar) kurang dari 10000. // WFDOC-INJECTED
if c(maxvar)<10000 {
 clear
 set maxvar 10000
}
global WFROOT "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2"
cd "$WFROOT"
global G0D "dag/data/word_data/G0"
global G0R "dag/reports/word_data/G0"
global G0L "dag/logs/word_data/G0"
global VYD "dag/data/word_data/G0/variable_year"
global VYL "dag/logs/word_data/G0/variable_year"
global VYR "dag/reports/word_data/G0/20260910-code-verification"
