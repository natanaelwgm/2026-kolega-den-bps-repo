version 17
set more off
set varabbrev off
* Run from this block folder, or provide the block folder as an argument.
args block_dir
if `"`block_dir'"'!="" cd `"`block_dir'"'
capture confirm file "analysis_ready_data.dta"
if _rc {
    display as error "Set cd to 20260917-run/block-0-data-preparation first."
    exit 601
}
use "analysis_ready_data.dta", clear
isid obs_id
isid firm_id year
xtset firm_id year
display as result "OBSCURED DEVELOPMENT DATA: fictional company IDs; nominal G1 residuals"
describe workers value_added_nominal dev_nominal_tfp_lp
notes dev_nominal_tfp_lp
browse
