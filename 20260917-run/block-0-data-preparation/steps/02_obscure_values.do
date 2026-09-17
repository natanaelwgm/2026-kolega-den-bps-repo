/* OBSCURE VALUES
   Input: intermediate/clean_data.dta.
   Output: intermediate/obscured_values.dta (local only; source keys remain).
   Apply seeded changes to base values and recompute derived quantities.
   Preserve categories and missingness; round count variables to integers.
   The owner retains the private seed and exact recovery information.
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
b0_step 2 "Obscure values"
capture log close B0_STEP
log using "$B0_RUN/logs/02_obscure_values.log", name(B0_STEP) text append
demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" mask "$B0_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
display as result "COMPLETE 2/4: values obscured and numerical replay verified."
capture log close B0_STEP
