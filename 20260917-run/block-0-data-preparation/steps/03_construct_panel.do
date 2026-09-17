/* CONSTRUCT PANEL
   Input: the validated numeric checkpoint from step 2.
   Output: an obscured panel with fictional firm identifiers.
   Construct and validate firm-year links without adding another noise pass.
   Fictional links are for development; they do not establish actual identity.
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
b0_step 3 "Construct firm panel"
capture log close B0_STEP
log using "$B0_RUN/logs/03_construct_panel.log", name(B0_STEP) text append
demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" panel "$B0_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
display as result "COMPLETE 3/4: panel constructed without another numeric change."
capture log close B0_STEP
