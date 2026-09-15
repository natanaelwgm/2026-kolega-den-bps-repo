* WFDOC: Membentuk enam pasangan empat metode; common_N memakai record dengan kedua nilai tersedia dan assert menegaskan belum ada pasangan.
* WFDOC: CSV berstatus BLOCKED_NO_PREDICTIONS; korelasi missing tidak dapat dipakai untuk meranking metode.
tempname pairs
postfile `pairs' str8 method_a str8 method_b double common_N double rho_spearman double rho_pearson using "$G1_RUN/comparison.dta", replace
local methods op lp acf wrdg
forvalues a=1/3 {
    local b0=`a'+1
    forvalues b=`b0'/4 {
        local ma : word `a' of `methods'
        local mb : word `b' of `methods'
        quietly count if !missing(tfp_`ma',tfp_`mb')
        assert r(N)==0
        post `pairs' ("`ma'") ("`mb'") (r(N)) (.) (.)
    }
}
postclose `pairs'
preserve
use "$G1_RUN/comparison.dta", clear
gen str60 status = "BLOCKED_NO_PREDICTIONS"
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/tfp_method_comparison.csv", replace
restore
