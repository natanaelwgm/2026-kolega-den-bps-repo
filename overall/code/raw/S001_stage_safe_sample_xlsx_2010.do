version 17
set more off
set varabbrev off
display as text "[DEEP DAG] OPERATION S001: import all Excel cells as strings; sanitize source headers; preserve source row"
import excel using "$OVERALL_RAW/sampel_mfg2010_aman.xlsx", sheet("Sheet1") allstring clear
local column_index=0
foreach variable of varlist _all {
 local ++column_index
 local header=`variable'[1]
 local base=lower(strtoname(`"`header'"'))
 if `"`base'"'=="" local base "column`column_index'"
 local clean=substr("raw_`base'",1,28)
 capture confirm new variable `clean'
 if _rc local clean=substr("raw_`base'",1,23)+"_`column_index'"
 rename `variable' `clean'
 label variable `clean' `"`header'"'
}
drop in 1
generate int source_year=2010
generate long source_row=_n
order source_year source_row
isid source_year source_row
compress
save "$OVERALL_RUN/G0-rebuild/dag/data/staged/sample_mfg2010_raw.dta", replace
cf _all using "$OVERALL_RUN/raw-reference/sample_mfg2010_raw.dta", all
