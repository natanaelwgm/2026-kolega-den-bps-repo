version 17
if "$DS_RUN"=="" error 198
use obs_id source_year dev_nominal_* using "$DS_G1", clear
isid obs_id source_year
sort obs_id source_year
tempfile master_results
save `master_results'
local g1_parent=subinstr("$DS_G1","/analysis/G1_main_with_tfp.dta","",.)
use obs_id source_year dev_nominal_* using "`g1_parent'/nominal/N06_selected_attached.dta", clear
isid obs_id source_year
sort obs_id source_year
cf _all using `master_results'
noisily display as result "G1_SIDECAR_EXACT | all nominal result columns match N06"
