version 17
set more off
args dataset
if `"`dataset'"'=="" {
 display as error "Supply the full path to panel_development.dta as the argument."
 exit 198
}
use "`dataset'", clear
assert dataset_mode=="development" & panel_id_synthetic==1
isid firm_id year
xtset firm_id year
* Demonstration of calendar lag: a 2015 observation is NOT the annual lag of 2017.
generate double example_L1_va=L.va_signed_nominal
assert missing(example_L1_va) if year==2017
* A descriptive example only; source/unit admission is not established by summarize.
tabulate year
summarize workers gross_output_nominal value_added_nominal va_signed_nominal
display as result "DEVELOPMENT EXAMPLE ONLY: fictional company links, no causal claim."
