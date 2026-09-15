* Input tunggal yang dipakai seluruh modul. Tidak membuka kembali file perusahaan.
capture log close INPUT_CHECK
log using "$DR_RUN/logs/input.log", name(INPUT_CHECK) text replace
use "$DR_INPUT", clear
confirm variable obs_id source_year psid psid_status
isid obs_id
assert !missing(source_year) & source_year==floor(source_year)
assert _N==$DR_EXPECTED_ROWS
local rows=_N
local columns=c(k)
quietly count if missing(psid)
local missing_ids=r(N)
if `missing_ids'==0 {
    assert psid>0 & psid==floor(psid) & psid<=9007199254740991
    isid psid source_year
}
* Nilai actual tidak boleh membawa status identitas development.
if "$DR_MODE"=="actual" {
    assert !inlist(psid_status,"synthetic_development","supplied_development")
}
tempname p
postfile `p' long rows long columns long missing_firm_ids str20 data_mode using "$DR_RUN/intermediate/input_check.dta", replace
post `p' (`rows') (`columns') (`missing_ids') ("$DR_MODE")
postclose `p'
use "$DR_RUN/intermediate/input_check.dta", clear
export delimited using "$DR_RUN/reports/input_check.csv", replace
log close INPUT_CHECK
