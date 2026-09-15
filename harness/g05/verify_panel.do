version 17
* Full G0.5 panel contract check. This do-file runs no TFP/causal estimation.
* Arguments: adapter-exported development DTA, new aggregate JSON receipt path.
args input_path receipt_path expected_firms
if "`input_path'" == "" | "`receipt_path'" == "" exit 198
use "`input_path'", clear
local label : data label
assert "`label'" == "DEASY G0.5 DEVELOPMENT"
assert _N == 33049
isid obs_id
assert !missing(psid) & psid == floor(psid) & psid > 0 & psid <= 2^48
assert psid_status == "synthetic_development"
isid psid source_year
assert source_year != 2016
gen str2 sector2 = substr(industry_code, 1, 2)
sort psid source_year
by psid: assert province_code == province_code[1]
by psid: assert sector2 == sector2[1]
* xtset must use the real calendar; two supplied waves need not be adjacent years.
xtset psid source_year
gen double check_labor_lag = L.workers
by psid: gen double expected_labor_lag = workers[_n-1] if source_year == source_year[_n-1] + 1
assert check_labor_lag == expected_labor_lag
by psid: gen byte crosses_absent_2016 = source_year == 2017 & source_year[_n-1] == 2015
assert missing(check_labor_lag) if crosses_absent_2016
quietly count if !missing(check_labor_lag)
local calendar_lags = r(N)
quietly count if crosses_absent_2016
local gap_links = r(N)
by psid: gen byte firm_first = _n == 1
quietly count if firm_first
local firms = r(N)
if "`expected_firms'" != "" assert `firms' == real("`expected_firms'")
* A receipt is written only after all assertions pass. No observation values.
file open receipt using "`receipt_path'", write text
file write receipt "{" _n
file write receipt `"  "status": "PASS", "rows": 33049, "synthetic_firms": `firms',"' _n
file write receipt `"  "stata_version": "`c(stata_version)'", "firm_year_unique": true,"' _n
file write receipt `"  "calendar_lags_checked": `calendar_lags', "two_year_gap_links_checked": `gap_links',"' _n
file write receipt `"  "province_sector_constant": true, "downstream_estimation_executed": false"' _n
file write receipt "}" _n
file close receipt
display as result "G05_PANEL_STATA_PASS"
exit, clear
