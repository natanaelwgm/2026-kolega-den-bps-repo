version 17
args mode
if "$DS_RUN"=="" error 198
assert _N==33049
isid obs_id year
assert source_year==year
assert !missing(year)
assert panel_empirical_ready==0 & all_downstream_ready==0 & g1_real_tfp_ready==0
if "`mode'"=="actual" assert missing(firm_id)
else {
 isid firm_id year
 assert panel_id_synthetic==1
 assert dev_nominal_development_only==1
 assert dev_nominal_real_verified==0
}
local outfile "analysis_actual"
if "`mode'"=="development" local outfile "panel_development"
sort _source_order
drop _source_order
compress
save "$DS_RUN/data/`outfile'.dta", replace
* Native exact comparison of ALL retained parent fields, not just row counts.
do "$DS_ROOT/downstream/code/fields_`mode'.do"
local fields "$DS_FIELDS"
if "`mode'"=="actual" {
 local dropped "selected_firm_id"
 local fields : list fields - dropped
}
local input "$DS_ACTUAL"
if "`mode'"=="development" local input "$DS_G1"
cf `fields' using "`input'"
noisily display as result "SOURCE VALUES EXACT | `mode'"
* Coverage uses every source row as denominator. Only aggregates exported.
tempfile audit
postfile audit str12 mode int year str32 variable long N nonmissing missing_n zero negative using `audit', replace
foreach v of varlist _all {
 capture confirm numeric variable `v'
 local numeric=(_rc==0)
 foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
  quietly count if year==`y'
  local n=r(N)
  quietly count if year==`y' & !missing(`v')
  local observed=r(N)
  local zeros=.
  local neg=.
  if `numeric' {
   quietly count if year==`y' & `v'==0
   local zeros=r(N)
   quietly count if year==`y' & `v'<0
   local neg=r(N)
  }
  post audit ("`mode'") (`y') ("`v'") (`n') (`observed') (`n'-`observed') (`zeros') (`neg')
 }
}
postclose audit
use `audit', clear
assert N==nonmissing+missing_n
export delimited using "$DS_RUN/reports/coverage_`mode'.csv", replace
noisily display as result "DATASET DONE | $DS_RUN/data/`outfile'.dta"
