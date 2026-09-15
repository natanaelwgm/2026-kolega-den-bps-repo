* Pecah master menjadi wave yang benar-benar bisa dibuka sendiri di Stata.
* Jumlah wave harus kembali tepat ke jumlah baris master; tidak ada wave buatan.
capture log close WAVES
log using "$DR_RUN/logs/waves.log", name(WAVES) text replace
tempname p
postfile `p' int source_year long rows long columns using "$DR_RUN/intermediate/wave_counts.dta", replace
local total=0
foreach y of global DR_YEARS {
    use if source_year==`y' using "$DR_INPUT", clear
    assert source_year==`y'
    isid obs_id
    local total=`total'+_N
    post `p' (`y') (_N) (c(k))
    save "$DR_RUN/waves/wave_`y'.dta", replace
}
postclose `p'
assert `total'==$DR_EXPECTED_ROWS
use "$DR_RUN/intermediate/wave_counts.dta", clear
isid source_year
export delimited using "$DR_RUN/reports/wave_counts.csv", replace
log close WAVES
