* Tujuan: Gunakan contoh kunci cocok/tidak cocok untuk memastikan merge 1:1 menolak duplikasi atau pasangan hilang. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; code/merge_guard.do // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
do "code/merge_guard.do"
clear
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input int source_year long source_row double x
2010 1 10
2010 2 20
end
tempfile good bad base
save `good'
drop x
save `base'
wf_merge_guard, using("`good'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==source_row*10
capture noisily wf_merge_guard, using("`good'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
use `base', clear
capture noisily wf_merge_guard, using("`good'") fields("absent_field") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
use `good', clear
replace source_row=1
save `bad'
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
use `good', clear
replace source_year=2011
save `bad', replace
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
use `good', clear
replace source_row=3 if source_row==2
save `bad', replace
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
use `good', clear
replace x=999 if source_row==1
save `bad', replace
use `base', clear
wf_merge_guard, using("`bad'") fields("x") year(2010)
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==999 if source_row==1
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==20 if source_row==2
display "WF_MERGE_FIXTURES_PASS_7"
