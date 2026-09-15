/*****************************************************************************
 RAW INPUTS -> ALL G0 STAGES -> NEW G0.5 -> G1
 Open this file from the repository root. Run the WHOLE file.
 The existing demo/00_MASTER.do is a separate, unchanged fast runner.
*****************************************************************************/
version 17
set more off
set varabbrev off
set linesize 120
capture window manage forward results
args repository
if `"`repository'"'=="" local repository `"`c(pwd)'"'
global OVERALL_REPO `"`repository'"'
global OVERALL_OUTPUT "$OVERALL_REPO/../kolega-overall-runs"
global OVERALL_RAW_ZIP "$OVERALL_REPO/inputs/raw/Deasy-Imed-17-Raw-Inputs-20260915.zip"
global OVERALL_WITNESS "$OVERALL_REPO/g0-original"
global OVERALL_PYTHON "python3"
global OVERALL_SEED 20260913
global OVERALL_SENSITIVITY 1
global OVERALL_BOOTSTRAP 1
capture confirm file "$OVERALL_REPO/overall.local.do"
if !_rc do "$OVERALL_REPO/overall.local.do"
global RUN_HOME "$OVERALL_REPO/demo"
global RUN_PYTHON "$OVERALL_PYTHON"
do "$RUN_HOME/code/live_progress.do"
demo_progress "OVERALL 0" "PREPARE: raw sources and complete G0 code"
tempfile prepared
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/overall.py" prepare "$OVERALL_OUTPUT" "$OVERALL_RAW_ZIP" "$OVERALL_WITNESS" "`prepared'"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
confirm file "`prepared'"
do "`prepared'"
capture log close OVERALL
log using "$OVERALL_RUN/logs/00_MASTER_OVERALL.log", name(OVERALL) text replace
if c(maxvar)<10000 {
 clear
 set maxvar 10000
}
noisily display as result "CALL | overall/code/01_raw_imports.do"
do "$OVERALL_REPO/overall/code/01_raw_imports.do"
noisily display as result "CALL | overall/code/02_all_g0.do"
do "$OVERALL_REPO/overall/code/02_all_g0.do"
noisily display as result "CALL | overall/code/03_build_g05.do"
do "$OVERALL_REPO/overall/code/03_build_g05.do"
noisily display as result "CALL | overall/code/04_all_g1.do"
do "$OVERALL_REPO/overall/code/04_all_g1.do"
demo_shell "$OVERALL_PYTHON" "$OVERALL_REPO/overall/scripts/overall.py" complete "$OVERALL_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
confirm file "$OVERALL_RUN/OVERALL_COMPLETE.json"
noisily display as result "OVERALL_DONE | $OVERALL_RUN"
capture log close OVERALL
