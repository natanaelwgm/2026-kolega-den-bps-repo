/* ESTIMATE PRODUCTIVITY
   Input: the exact obscured panel from step 3.
   Output: output/analysis_ready_data.dta with labels and definitions.
   Fit Olley-Pakes, Levinsohn-Petrin, ACF and Wooldridge specifications.
   Retain all observations; estimates exist only for eligible model samples.
   Results are nominal development residuals on fictional panel links.
   Do not obscure the estimated dataset again.
*/
version 17
if "$B0_HOME"=="" global B0_HOME `"`c(pwd)'"'
capture confirm file "$B0_HOME/settings.do"
if _rc {
    capture confirm file "$B0_HOME/../settings.do"
    if !_rc {
        local before `"`c(pwd)'"'
        quietly cd "$B0_HOME/.."
        global B0_HOME `"`c(pwd)'"'
        quietly cd `"`before'"'
    }
}
do "$B0_HOME/support/setup.do"
b0_setup
b0_step 4 "Estimate productivity and save dataset"
capture log close B0_STEP
log using "$B0_RUN/logs/04_estimate_productivity.log", name(B0_STEP) text append
demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" estimate "$B0_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
use "$B0_RUN/output/analysis_ready_data.dta", clear
isid firm_id year
xtset firm_id year
summarize workers value_added_nominal dev_nominal_tfp_op dev_nominal_tfp_lp dev_nominal_tfp_acf dev_nominal_tfp_wrdg
display as result "COMPLETE 4/4: analysis_ready_data.dta available."
capture log close B0_STEP
