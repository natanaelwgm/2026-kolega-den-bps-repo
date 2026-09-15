* Tujuan: Periksa dengan angka contoh yang diketahui bahwa pembagian bertanda/nonnegatif hanya berjalan pada domain yang benar dan nilai tanpa penyebut layak tetap missing. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do; corrections/fixtures/postfile_precision.dta // WFDOC-INJECTED
* Output: corrections/fixtures/precision_source.dta; corrections/fixtures/fixture_results.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L1:step-version" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 1 90 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L1:step-version" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 1 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L2:step-do" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 2 90 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L2:step-do" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 2 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L3:step-g0c_begin" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 3 90 `=_rc' // WFLOG-INJECTED
g0c_begin "G0C_KNOWN_ANSWER_FIXTURES"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L3:step-g0c_begin" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 3 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L4:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 4 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L4:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 4 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L5:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 5 90 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input double numerator denominator expected_signed expected_nonnegative
-10 2 -5 .
0 2 0 0
10 2 5 5
10 0 . .
10 -1 . .
10 . . .
. 2 . .
end
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L5:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 5 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L14:step-g0c_ratio" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 6 90 `=_rc' // WFLOG-INJECTED
g0c_ratio numerator denominator, generate(signed_ratio) signed
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L14:step-g0c_ratio" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 6 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L15:step-g0c_ratio" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 7 90 `=_rc' // WFLOG-INJECTED
g0c_ratio numerator denominator, generate(nonnegative_ratio)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L15:step-g0c_ratio" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 7 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L16:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 8 90 `=_rc' // WFLOG-INJECTED
assert signed_ratio==expected_signed
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L16:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 8 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L17:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 9 90 `=_rc' // WFLOG-INJECTED
assert nonnegative_ratio==expected_nonnegative
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L17:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 9 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L18:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 10 90 `=_rc' // WFLOG-INJECTED
generate double stale=99
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L18:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 10 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L19:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 11 90 `=_rc' // WFLOG-INJECTED
replace stale=.
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L19:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 11 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L20:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 12 90 `=_rc' // WFLOG-INJECTED
replace stale=numerator/denominator if numerator>=0 & !missing(numerator,denominator) & denominator>0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L20:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 12 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L21:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 13 90 `=_rc' // WFLOG-INJECTED
assert stale==expected_nonnegative
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L21:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 13 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L22:step-g0c_log" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 14 90 `=_rc' // WFLOG-INJECTED
g0c_log numerator, generate(log_positive)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L22:step-g0c_log" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 14 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L23:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 15 90 `=_rc' // WFLOG-INJECTED
assert missing(log_positive) if numerator<=0 | missing(numerator)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L23:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 15 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L24:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 16 90 `=_rc' // WFLOG-INJECTED
assert abs(log_positive-ln(10))<1e-14 if numerator==10
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L24:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 16 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L25:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 17 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS ratio_signed_zero_missing_and_log"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L25:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 17 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L26:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 18 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L26:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 18 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L27:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 19 90 `=_rc' // WFLOG-INJECTED
set obs 1001
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L27:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 19 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L28:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 20 90 `=_rc' // WFLOG-INJECTED
generate double va=0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L28:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 20 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L29:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 21 90 `=_rc' // WFLOG-INJECTED
replace va=5 in 1001
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L29:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 21 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L30:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 22 90 `=_rc' // WFLOG-INJECTED
egen double q=pctile(abs(va)), p(99)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L30:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 22 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L31:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 23 90 `=_rc' // WFLOG-INJECTED
assert q==0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L31:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 23 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L32:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 24 90 `=_rc' // WFLOG-INJECTED
generate byte tail=abs(va)>10*q if !missing(va,q) & q>=0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L32:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 24 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L33:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 25 90 `=_rc' // WFLOG-INJECTED
assert tail==0 in 1/1000
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L33:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 25 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L34:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 26 90 `=_rc' // WFLOG-INJECTED
assert tail==1 in 1001
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L34:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 26 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L35:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 27 90 `=_rc' // WFLOG-INJECTED
replace va=-5 in 1001
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L35:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 27 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L36:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 28 90 `=_rc' // WFLOG-INJECTED
replace tail=abs(va)>10*q if !missing(va,q) & q>=0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L36:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 28 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L37:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 29 90 `=_rc' // WFLOG-INJECTED
assert tail==1 in 1001
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L37:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 29 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L38:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 30 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS zero_heavy_signed_tail"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L38:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 30 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L39:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 31 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L39:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 31 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L40:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 32 90 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input double fuel pln nonpln expected byte expected_n
. . . . 0
0 . . 0 1
10 5 . 15 2
10 5 2 17 3
-10 5 . 5 1
end
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L40:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 32 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L47:step-foreach" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "loop" 33 90 `=_rc' "in" `"fuel pln nonpln"' // WFLOG-INJECTED
* Ulangi blok untuk v: fuel, pln, nonpln. // WFDOC-INJECTED
foreach v in fuel pln nonpln {
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L47:iteration-body" "rows/G0/corrections/G0_known_answer_fixtures.do:L47:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L48:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L47:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
    replace `v'=. if `v'<0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L48:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L47:iteration-body" "statement" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L47:iteration-body" "rows/G0/corrections/G0_known_answer_fixtures.do:L47:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L47:step-foreach" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "loop" 33 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L50:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 34 90 `=_rc' // WFLOG-INJECTED
egen byte n=rownonmiss(fuel pln nonpln)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L50:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 34 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L51:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 35 90 `=_rc' // WFLOG-INJECTED
egen double subtotal=rowtotal(fuel pln nonpln), missing
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L51:step-egen" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 35 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L52:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 36 90 `=_rc' // WFLOG-INJECTED
replace subtotal=. if n==0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L52:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 36 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L53:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 37 90 `=_rc' // WFLOG-INJECTED
assert n==expected_n & subtotal==expected
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L53:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 37 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L54:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 38 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS partial_cost_zero_not_complete"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L54:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 38 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L55:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 39 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L55:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 39 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L56:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 40 90 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input byte a b aa ab expected_decision expected_complete
1 . 1 1 1 0
0 . 1 1 . 0
0 0 1 1 0 1
. . 1 1 . 0
. . 0 0 . .
0 . 1 0 0 1
end
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L56:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 40 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L64:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 41 90 `=_rc' // WFLOG-INJECTED
generate byte n_applicable=aa+ab
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L64:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 41 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L65:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 42 90 `=_rc' // WFLOG-INJECTED
generate byte unknown=(aa & missing(a))+(ab & missing(b))
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L65:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 42 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L66:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 43 90 `=_rc' // WFLOG-INJECTED
generate byte yes=(aa & a==1)+(ab & b==1)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L66:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 43 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L67:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 44 90 `=_rc' // WFLOG-INJECTED
generate byte decision=1 if yes>0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L67:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 44 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L68:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 45 90 `=_rc' // WFLOG-INJECTED
replace decision=0 if yes==0 & unknown==0 & n_applicable>0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L68:step-replace" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 45 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L69:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 46 90 `=_rc' // WFLOG-INJECTED
generate byte complete=unknown==0 if n_applicable>0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L69:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 46 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L70:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 47 90 `=_rc' // WFLOG-INJECTED
assert decision==expected_decision & complete==expected_complete
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L70:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 47 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L71:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 48 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS_three_valued_tests_and_retired_alias"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L71:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 48 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L72:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 49 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L72:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 49 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L73:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 50 90 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input double value byte source_gate signed
10 0 0
0 0 0
-10 0 0
10 1 0
0 1 0
-10 1 0
10 1 1
0 1 1
-10 1 1
end
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L73:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 50 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L84:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 51 90 `=_rc' // WFLOG-INJECTED
generate double eligible=value if source_gate & (value>=0 | signed)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L84:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 51 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L85:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 52 90 `=_rc' // WFLOG-INJECTED
quietly count if !missing(eligible) & !source_gate
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L85:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 52 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L86:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 53 90 `=_rc' // WFLOG-INJECTED
assert r(N)==0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L86:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 53 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L87:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 54 90 `=_rc' // WFLOG-INJECTED
quietly count if eligible==0 & !source_gate
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L87:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 54 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L88:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 55 90 `=_rc' // WFLOG-INJECTED
assert r(N)==0
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L88:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 55 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L89:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 56 90 `=_rc' // WFLOG-INJECTED
quietly count if !missing(eligible) & source_gate & !signed
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L89:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 56 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L90:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 57 90 `=_rc' // WFLOG-INJECTED
assert r(N)==2
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L90:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 57 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L91:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 58 90 `=_rc' // WFLOG-INJECTED
quietly count if eligible<0 & !missing(eligible) & signed
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L91:step-count" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 58 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L92:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 59 90 `=_rc' // WFLOG-INJECTED
assert r(N)==1
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L92:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 59 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L93:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 60 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS_aggregate_same_eligible_domain"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L93:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 60 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L94:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 61 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L94:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 61 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L95:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 62 90 `=_rc' // WFLOG-INJECTED
set obs 3
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L95:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 62 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L96:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 63 90 `=_rc' // WFLOG-INJECTED
generate byte original=(_n==1)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L96:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 63 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L97:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 64 90 `=_rc' // WFLOG-INJECTED
generate double continuous=original
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L97:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 64 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L98:step-collapse" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 65 90 `=_rc' // WFLOG-INJECTED
collapse (mean) continuous
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L98:step-collapse" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 65 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L99:step-local" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 66 90 `=_rc' // WFLOG-INJECTED
local storage : type continuous
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L99:step-local" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 66 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L100:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 67 90 `=_rc' // WFLOG-INJECTED
assert "`storage'"=="double"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L100:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 67 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L101:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 68 90 `=_rc' // WFLOG-INJECTED
assert continuous==1/3
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L101:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 68 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L102:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 69 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS_collapse_double_storage"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L102:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 69 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L103:step-tempname" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 70 90 `=_rc' // WFLOG-INJECTED
tempname p
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L103:step-tempname" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 70 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L104:step-postfile" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 71 90 `=_rc' // WFLOG-INJECTED
postfile `p' double first double second double third using "corrections/fixtures/postfile_precision.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L104:step-postfile" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 71 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L105:step-post" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 72 90 `=_rc' // WFLOG-INJECTED
post `p' (1/3) (1/3) (1/3)
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L105:step-post" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 72 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L106:step-postclose" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 73 90 `=_rc' // WFLOG-INJECTED
postclose `p'
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L106:step-postclose" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 73 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L107:step-use" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 74 90 `=_rc' // WFLOG-INJECTED
* Gunakan angka contoh yang diketahui untuk memastikan pembagian bertanda, pembagian nonnegatif, dan pembagi nol/negatif/kosong memberi hasil yang diharapkan. // WFDOC-INJECTED
use "corrections/fixtures/postfile_precision.dta", clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L107:step-use" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 74 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L108:step-foreach" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "loop" 75 90 `=_rc' "in" `"first second third"' // WFLOG-INJECTED
* Ulangi blok untuk v: first, second, third. // WFDOC-INJECTED
foreach v in first second third {
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L109:step-local" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
    local storage : type `v'
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L109:step-local" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L110:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
    assert "`storage'"=="double"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L110:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L111:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
    assert `v'==1/3
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L111:step-assert" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L108:iteration-body" "rows/G0/corrections/G0_known_answer_fixtures.do:L108:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L108:step-foreach" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "loop" 75 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L113:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 76 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS_postfile_double_each_field"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L113:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 76 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L114:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 77 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L114:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 77 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L115:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 78 90 `=_rc' // WFLOG-INJECTED
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input double number str8 key
0.1 "001"
.33333333333333331 "002"
1e-300 "003"
1e300 "004"
-10 "005"
. "006"
.a "007"
end
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L115:step-input" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 78 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L124:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 79 90 `=_rc' // WFLOG-INJECTED
generate str60 unicode_note=`"Sumber: biaya — nilai ‘asli’; "kutipan""'
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L124:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 79 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L125:step-save" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 80 90 `=_rc' // WFLOG-INJECTED
save "corrections/fixtures/precision_source.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L125:step-save" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 80 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L126:step-g0c_roundtrip" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 81 90 `=_rc' // WFLOG-INJECTED
g0c_roundtrip, input("corrections/fixtures/precision_source.dta") output("corrections/fixtures/precision_roundtrip.csv")
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L126:step-g0c_roundtrip" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 81 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L127:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 82 90 `=_rc' // WFLOG-INJECTED
display "G0C_FIXTURE_PASS_17_digit_roundtrip"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L127:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 82 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L128:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 83 90 `=_rc' // WFLOG-INJECTED
clear
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L128:step-clear" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 83 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L129:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 84 90 `=_rc' // WFLOG-INJECTED
set obs 1
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L129:step-set" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 84 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L130:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 85 90 `=_rc' // WFLOG-INJECTED
generate byte fixtures_pass=1
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L130:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 85 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L131:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 86 90 `=_rc' // WFLOG-INJECTED
generate str120 groups="ratio/log; signed tail; cost completeness; three-valued tests; summary domain; precision"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L131:step-generate" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 86 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L132:step-save" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 87 90 `=_rc' // WFLOG-INJECTED
save "corrections/fixtures/fixture_results.dta", replace
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L132:step-save" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 87 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L133:step-export" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 88 90 `=_rc' // WFLOG-INJECTED
export delimited using "corrections/fixtures/fixture_results.csv", replace
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L133:step-export" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 88 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L134:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 89 90 `=_rc' // WFLOG-INJECTED
display "G0C_KNOWN_ANSWER_FIXTURES_SUCCESS"
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L134:step-display" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 89 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/corrections/G0_known_answer_fixtures.do:L135:step-log" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 90 90 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L135:step-log" "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "statement" 90 90 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/corrections/G0_known_answer_fixtures.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
