* Tujuan: Gunakan contoh kunci cocok/tidak cocok untuk memastikan merge 1:1 menolak duplikasi atau pasangan hilang. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; code/merge_guard.do // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L1:step-do" "code/validation/merge_fixtures.do:L1:file" "statement" 1 41 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L1:step-do" "code/validation/merge_fixtures.do:L1:file" "statement" 1 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L2:step-do" "code/validation/merge_fixtures.do:L1:file" "statement" 2 41 `=_rc' // WFLOG-INJECTED
do "code/merge_guard.do"
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L2:step-do" "code/validation/merge_fixtures.do:L1:file" "statement" 2 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L3:step-clear" "code/validation/merge_fixtures.do:L1:file" "statement" 3 41 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L3:step-clear" "code/validation/merge_fixtures.do:L1:file" "statement" 3 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L4:step-input" "code/validation/merge_fixtures.do:L1:file" "statement" 4 41 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input int source_year long source_row double x
2010 1 10
2010 2 20
end
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L4:step-input" "code/validation/merge_fixtures.do:L1:file" "statement" 4 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L8:step-tempfile" "code/validation/merge_fixtures.do:L1:file" "statement" 5 41 `=_rc' // WFLOG-INJECTED
tempfile good bad base
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L8:step-tempfile" "code/validation/merge_fixtures.do:L1:file" "statement" 5 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L9:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 6 41 `=_rc' // WFLOG-INJECTED
save `good'
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L9:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 6 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L10:step-drop" "code/validation/merge_fixtures.do:L1:file" "statement" 7 41 `=_rc' // WFLOG-INJECTED
drop x
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L10:step-drop" "code/validation/merge_fixtures.do:L1:file" "statement" 7 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L11:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 8 41 `=_rc' // WFLOG-INJECTED
save `base'
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L11:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 8 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L12:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 9 41 `=_rc' // WFLOG-INJECTED
wf_merge_guard, using("`good'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L12:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 9 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L13:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 10 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==source_row*10
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L13:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 10 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L14:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 11 41 `=_rc' // WFLOG-INJECTED
capture noisily wf_merge_guard, using("`good'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L14:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 11 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L15:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 12 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L15:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 12 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L16:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 13 41 `=_rc' // WFLOG-INJECTED
use `base', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L16:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 13 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L17:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 14 41 `=_rc' // WFLOG-INJECTED
capture noisily wf_merge_guard, using("`good'") fields("absent_field") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L17:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 14 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L18:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 15 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L18:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 15 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L19:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 16 41 `=_rc' // WFLOG-INJECTED
use `good', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L19:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 16 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L20:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 17 41 `=_rc' // WFLOG-INJECTED
replace source_row=1
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L20:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 17 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L21:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 18 41 `=_rc' // WFLOG-INJECTED
save `bad'
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L21:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 18 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L22:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 19 41 `=_rc' // WFLOG-INJECTED
use `base', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L22:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 19 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L23:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 20 41 `=_rc' // WFLOG-INJECTED
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L23:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 20 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L24:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 21 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L24:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 21 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L25:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 22 41 `=_rc' // WFLOG-INJECTED
use `good', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L25:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 22 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L26:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 23 41 `=_rc' // WFLOG-INJECTED
replace source_year=2011
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L26:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 23 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L27:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 24 41 `=_rc' // WFLOG-INJECTED
save `bad', replace
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L27:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 24 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L28:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 25 41 `=_rc' // WFLOG-INJECTED
use `base', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L28:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 25 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L29:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 26 41 `=_rc' // WFLOG-INJECTED
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L29:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 26 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L30:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 27 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L30:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 27 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L31:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 28 41 `=_rc' // WFLOG-INJECTED
use `good', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L31:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 28 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L32:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 29 41 `=_rc' // WFLOG-INJECTED
replace source_row=3 if source_row==2
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L32:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 29 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L33:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 30 41 `=_rc' // WFLOG-INJECTED
save `bad', replace
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L33:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 30 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L34:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 31 41 `=_rc' // WFLOG-INJECTED
use `base', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L34:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 31 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L35:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 32 41 `=_rc' // WFLOG-INJECTED
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L35:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 32 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L36:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 33 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert _rc!=0
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L36:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 33 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L37:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 34 41 `=_rc' // WFLOG-INJECTED
use `good', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L37:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 34 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L38:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 35 41 `=_rc' // WFLOG-INJECTED
replace x=999 if source_row==1
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L38:step-replace" "code/validation/merge_fixtures.do:L1:file" "statement" 35 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L39:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 36 41 `=_rc' // WFLOG-INJECTED
save `bad', replace
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L39:step-save" "code/validation/merge_fixtures.do:L1:file" "statement" 36 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L40:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 37 41 `=_rc' // WFLOG-INJECTED
use `base', clear
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L40:step-use" "code/validation/merge_fixtures.do:L1:file" "statement" 37 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L41:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 38 41 `=_rc' // WFLOG-INJECTED
wf_merge_guard, using("`bad'") fields("x") year(2010)
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L41:step-wf_merge_guard" "code/validation/merge_fixtures.do:L1:file" "statement" 38 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L42:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 39 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==999 if source_row==1
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L42:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 39 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L43:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 40 41 `=_rc' // WFLOG-INJECTED
* Pastikan syarat pembanding ini benar; jika tidak, validasi berhenti di sini. // WFDOC-INJECTED
assert x==20 if source_row==2
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L43:step-assert" "code/validation/merge_fixtures.do:L1:file" "statement" 40 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "code/validation/merge_fixtures.do:L44:step-display" "code/validation/merge_fixtures.do:L1:file" "statement" 41 41 `=_rc' // WFLOG-INJECTED
display "WF_MERGE_FIXTURES_PASS_7"
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L44:step-display" "code/validation/merge_fixtures.do:L1:file" "statement" 41 41 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "code/validation/merge_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
