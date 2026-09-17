demo_progress "G0 RESULTS" "CALL native Stata summaries for freshly rebuilt actual G0"
global DR_RUN "$OVERALL_RUN"
global DR_INPUT "$OVERALL_G0/data/analysis/G0_analysis_ready.dta"
global DR_YEARS "2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022"
global DR_EXTRA_FIELDS ""
capture mkdir "$OVERALL_RUN/intermediate"
capture mkdir "$OVERALL_RUN/scratch"
use "$DR_INPUT", clear
isid source_year source_row
local n=_N
local k=c(k)
quietly count if missing(psid)
local missing=r(N)
tempname check
postfile `check' long rows long columns long missing_firm_ids str20 data_mode using "$OVERALL_RUN/intermediate/input_check.dta", replace
post `check' (`n') (`k') (`missing') ("actual")
postclose `check'
use "$OVERALL_RUN/intermediate/input_check.dta", clear
export delimited using "$OVERALL_RUN/reports/input_check.csv", replace
noisily display as result "CALL | demo/code/summaries.do"
do "$OVERALL_REPO/demo/code/summaries.do"
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/overall.py" present "$OVERALL_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
