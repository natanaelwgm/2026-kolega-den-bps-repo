version 17
set more off
set varabbrev off
args input_file metadata_do output_file verify_do
if `"`input_file'"'=="" | `"`metadata_do'"'=="" | `"`output_file'"'=="" error 198
use `"`input_file'"', clear
quietly datasignature
local before_signature "`r(datasignature)'"
isid obs_id
isid firm_id year
do `"`metadata_do'"'
quietly datasignature
assert "`r(datasignature)'"=="`before_signature'"
* Idempotence: reapplying updates only the edge-owned note, never duplicates it.
quietly do `"`metadata_do'"'
quietly datasignature
assert "`r(datasignature)'"=="`before_signature'"
char _dta[g1_metadata_input_signature] "`before_signature'"
save `"`output_file'"', replace
* Reopen serialized output before admitting metadata and unchanged data.
use `"`output_file'"', clear
quietly datasignature
assert "`r(datasignature)'"=="`before_signature'"
do `"`verify_do'"'
noisily cf _all using `"`input_file'"', all
notes dev_nominal_tfp_lp
notes workers
noisily display "E065_METADATA_PASS"
