/* CLEAN DATA
   Inputs: annual Excel files and accepted validation references.
   Output: intermediate/clean_data.dta.
   Import annual waves, harmonize names and units, construct economic,
   energy and emissions variables, then validate against reference inputs.
   Source mapping: documentation/source_concordance.csv.
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
b0_step 1 "Clean annual data"
capture log close B0_STEP
log using "$B0_RUN/logs/01_clean_data.log", name(B0_STEP) text append

tempfile clean_settings
demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" clean-prepare "$B0_RUN" "`clean_settings'"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
do "`clean_settings'"
if $B0_CLEAN_REUSED==0 {
    if $B0_RAW_REUSED==0 {
        global OVERALL_REPO "$B0_REPO"
        global OVERALL_PYTHON "$PYTHON"
        display as result "Import, construct and validate data; resume after the last completed stage."
        do "$B0_RAW_DRIVER"
    }
    display as result "Select variables for the shared dataset."
    demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" clean-finish "$B0_RUN"
    if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
}
use "$B0_RUN/intermediate/clean_data.dta", clear
isid obs_id
tabulate year
summarize workers value_added_nominal
display as result "COMPLETE 1/4: clean data available."
capture log close B0_STEP
