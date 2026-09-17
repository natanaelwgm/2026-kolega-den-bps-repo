demo_progress "G1" "Prepare estimators from this run's NEW G0.5"
tempfile g1reply
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/g1_bridge.py" prepare "$OVERALL_RUN" "$OVERALL_REPO" "0" "`g1reply'"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
do "`g1reply'"
cd "$OVERALL_REPO"
capture log close G1_OVERALL
log using "$OVERALL_RUN/logs/G1_execution.log", name(G1_OVERALL) text replace
global G1_MODE "development"
set type double
use "$G1_RUN/S01_input.dta", clear
forvalues e=1/19 {
 local edge : display %02.0f `e'
 demo_progress "G1 AUDIT E`edge'" "CALL work-items/G1/stata/edges/G1_E`edge'.do"
 do "$G1_CODE/edges/G1_E`edge'.do"
}
noisily display as result "G1 REAL-PRIMARY AUDIT COMPLETE; NOMINAL DEVELOPMENT ESTIMATION FOLLOWS"
global G1_VARIANTS "primary"
if "$OVERALL_SENSITIVITY"=="1" global G1_VARIANTS "primary low_l high_l poly2"
foreach stage in N01_inputs N02_risk N03_samples N04_fits {
 demo_progress "G1" "CALL demo/code/nominal/`stage'.do"
 do "$OVERALL_REPO/demo/code/nominal/`stage'.do"
}
if "$OVERALL_BOOTSTRAP"=="1" {
 demo_progress "G1" "CALL demo/code/nominal/N05_bootstrap.do"
 do "$OVERALL_REPO/demo/code/nominal/N05_bootstrap.do"
}
foreach stage in N06_outputs N07_master {
 demo_progress "G1" "CALL demo/code/nominal/`stage'.do"
 do "$OVERALL_REPO/demo/code/nominal/`stage'.do"
}
demo_progress "G1 N08-N13" "CALL overall/code/05_g1_diagnostics.do"
do "$OVERALL_REPO/overall/code/05_g1_diagnostics.do" "$OVERALL_REPO" "$OVERALL_RUN/g1" "$OVERALL_RUN/g1-deep"
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/g1_bridge.py" finish "$OVERALL_RUN" "g1"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
capture log close G1_OVERALL
