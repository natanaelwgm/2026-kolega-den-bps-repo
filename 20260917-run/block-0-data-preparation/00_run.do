/* DATA PREPARATION
   Configure settings.do, set the working directory to this folder,
   then execute this entire file with Do.

   Output: WORK_DIR / dated-run / output / analysis_ready_data.dta
*/
version 17
set more off
set varabbrev off
args folder
if `"`folder'"'=="" local folder `"`c(pwd)'"'
global B0_HOME `"`folder'"'
global B0_RUN ""
do "$B0_HOME/support/setup.do"
b0_setup

* Each step reads the validated output of the preceding step.
do "$B0_HOME/steps/01_clean_data.do"
do "$B0_HOME/steps/02_obscure_values.do"
do "$B0_HOME/steps/03_construct_panel.do"
do "$B0_HOME/steps/04_estimate_productivity.do"

display _n as result "COMPLETE: analysis dataset and metadata are available."
display as text "File: $B0_RUN/output/analysis_ready_data.dta"
use "$B0_RUN/output/analysis_ready_data.dta", clear
isid firm_id year
xtset firm_id year
summarize workers value_added_nominal dev_nominal_tfp_lp
browse
