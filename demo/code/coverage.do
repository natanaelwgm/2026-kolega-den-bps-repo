* Satu pass per wave, sehingga pemeriksaan tidak memindai 33.049 baris kembali
* untuk setiap kombinasi variabel-tahun. Rumus count tetap sama.
capture log close COVERAGE
log using "$DR_RUN/logs/coverage.log", name(COVERAGE) text replace
tempname p s
postfile `p' str32 variable int source_year str12 storage long rows long observed long missing_rows long zeros long negatives using "$DR_RUN/intermediate/coverage.dta", replace
postfile `s' str32 variable str12 storage str244 label using "$DR_RUN/intermediate/schema.dta", replace
local first=1
foreach y of global DR_YEARS {
    noisily display "COVERAGE | year=`y'"
    use if source_year==`y' using "$DR_INPUT", clear
    local n=_N
    noisily display as result "COVERAGE | tahun `y' | `n' baris | menghitung isi seluruh kolom"
    unab variables : _all
    foreach v of local variables {
        local storage : type `v'
        if `first' {
            local label : variable label `v'
            post `s' ("`v'") ("`storage'") (`"`label'"')
        }
        quietly count if !missing(`v')
        local observed=r(N)
        local zero=.
        local negative=.
        capture confirm numeric variable `v'
        if !_rc {
            quietly count if `v'==0
            local zero=r(N)
            quietly count if `v'<0 & !missing(`v')
            local negative=r(N)
        }
        post `p' ("`v'") (`y') ("`storage'") (`n') (`observed') (`n'-`observed') (`zero') (`negative')
    }
    local first=0
}
postclose `p'
postclose `s'
use "$DR_RUN/intermediate/coverage.dta", clear
isid variable source_year
assert observed+missing_rows==rows
sort variable source_year
export delimited using "$DR_RUN/tables/variable_year_coverage.csv", replace
use "$DR_RUN/intermediate/schema.dta", clear
isid variable
export delimited using "$DR_RUN/tables/schema.csv", replace
log close COVERAGE
