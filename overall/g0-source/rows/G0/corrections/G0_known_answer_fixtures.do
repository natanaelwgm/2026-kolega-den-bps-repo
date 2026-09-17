* Tujuan: Periksa dengan angka contoh yang diketahui bahwa pembagian bertanda/nonnegatif hanya berjalan pada domain yang benar dan nilai tanpa penyebut layak tetap missing. // WFDOC-INJECTED
* Input: /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do; corrections/fixtures/postfile_precision.dta // WFDOC-INJECTED
* Output: corrections/fixtures/precision_source.dta; corrections/fixtures/fixture_results.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0C_KNOWN_ANSWER_FIXTURES"
clear
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
g0c_ratio numerator denominator, generate(signed_ratio) signed
g0c_ratio numerator denominator, generate(nonnegative_ratio)
assert signed_ratio==expected_signed
assert nonnegative_ratio==expected_nonnegative
generate double stale=99
replace stale=.
replace stale=numerator/denominator if numerator>=0 & !missing(numerator,denominator) & denominator>0
assert stale==expected_nonnegative
g0c_log numerator, generate(log_positive)
assert missing(log_positive) if numerator<=0 | missing(numerator)
assert abs(log_positive-ln(10))<1e-14 if numerator==10
display "G0C_FIXTURE_PASS ratio_signed_zero_missing_and_log"
clear
set obs 1001
generate double va=0
replace va=5 in 1001
egen double q=pctile(abs(va)), p(99)
assert q==0
generate byte tail=abs(va)>10*q if !missing(va,q) & q>=0
assert tail==0 in 1/1000
assert tail==1 in 1001
replace va=-5 in 1001
replace tail=abs(va)>10*q if !missing(va,q) & q>=0
assert tail==1 in 1001
display "G0C_FIXTURE_PASS zero_heavy_signed_tail"
clear
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input double fuel pln nonpln expected byte expected_n
. . . . 0
0 . . 0 1
10 5 . 15 2
10 5 2 17 3
-10 5 . 5 1
end
* Ulangi blok untuk v: fuel, pln, nonpln. // WFDOC-INJECTED
foreach v in fuel pln nonpln {
    replace `v'=. if `v'<0
}
egen byte n=rownonmiss(fuel pln nonpln)
egen double subtotal=rowtotal(fuel pln nonpln), missing
replace subtotal=. if n==0
assert n==expected_n & subtotal==expected
display "G0C_FIXTURE_PASS partial_cost_zero_not_complete"
clear
* Nilai setelah baris ini membentuk data contoh yang dipakai untuk pemeriksaan di file ini. // WFDOC-INJECTED
input byte a b aa ab expected_decision expected_complete
1 . 1 1 1 0
0 . 1 1 . 0
0 0 1 1 0 1
. . 1 1 . 0
. . 0 0 . .
0 . 1 0 0 1
end
generate byte n_applicable=aa+ab
generate byte unknown=(aa & missing(a))+(ab & missing(b))
generate byte yes=(aa & a==1)+(ab & b==1)
generate byte decision=1 if yes>0
replace decision=0 if yes==0 & unknown==0 & n_applicable>0
generate byte complete=unknown==0 if n_applicable>0
assert decision==expected_decision & complete==expected_complete
display "G0C_FIXTURE_PASS_three_valued_tests_and_retired_alias"
clear
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
generate double eligible=value if source_gate & (value>=0 | signed)
quietly count if !missing(eligible) & !source_gate
assert r(N)==0
quietly count if eligible==0 & !source_gate
assert r(N)==0
quietly count if !missing(eligible) & source_gate & !signed
assert r(N)==2
quietly count if eligible<0 & !missing(eligible) & signed
assert r(N)==1
display "G0C_FIXTURE_PASS_aggregate_same_eligible_domain"
clear
set obs 3
generate byte original=(_n==1)
generate double continuous=original
collapse (mean) continuous
local storage : type continuous
assert "`storage'"=="double"
assert continuous==1/3
display "G0C_FIXTURE_PASS_collapse_double_storage"
tempname p
postfile `p' double first double second double third using "corrections/fixtures/postfile_precision.dta", replace
post `p' (1/3) (1/3) (1/3)
postclose `p'
* Gunakan angka contoh yang diketahui untuk memastikan pembagian bertanda, pembagian nonnegatif, dan pembagi nol/negatif/kosong memberi hasil yang diharapkan. // WFDOC-INJECTED
use "corrections/fixtures/postfile_precision.dta", clear
* Ulangi blok untuk v: first, second, third. // WFDOC-INJECTED
foreach v in first second third {
    local storage : type `v'
    assert "`storage'"=="double"
    assert `v'==1/3
}
display "G0C_FIXTURE_PASS_postfile_double_each_field"
clear
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
generate str60 unicode_note=`"Sumber: biaya — nilai ‘asli’; "kutipan""'
save "corrections/fixtures/precision_source.dta", replace
g0c_roundtrip, input("corrections/fixtures/precision_source.dta") output("corrections/fixtures/precision_roundtrip.csv")
display "G0C_FIXTURE_PASS_17_digit_roundtrip"
clear
set obs 1
generate byte fixtures_pass=1
generate str120 groups="ratio/log; signed tail; cost completeness; three-valued tests; summary domain; precision"
save "corrections/fixtures/fixture_results.dta", replace
export delimited using "corrections/fixtures/fixture_results.csv", replace
display "G0C_KNOWN_ANSWER_FIXTURES_SUCCESS"
capture log close G0CHILD
