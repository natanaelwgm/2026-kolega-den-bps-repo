version 17
set more off
set varabbrev off
set linesize 120
args repository
if `"`repository'"'=="" local repository `"`c(pwd)'"'
global DS_ROOT `"`repository'"'
confirm file "$DS_ROOT/downstream/local_paths.do"
do "$DS_ROOT/downstream/local_paths.do"
if c(maxvar)<2000 {
 clear
 set maxvar 2000
}
global RUN_HOME "$DS_ROOT/demo"
global RUN_PYTHON "$DS_PYTHON"
do "$RUN_HOME/code/live_progress.do"
tempfile setup
demo_progress "0/6" "Pin G0 and accepted G1 inputs; create new output folder"
demo_shell "$DS_PYTHON" "$DS_ROOT/downstream/scripts/package.py" prepare "$DS_ROOT" "$DS_ACTUAL" "$DS_G1" "$DS_OUTPUT" "`setup'"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
do "`setup'"
capture log close DOWNSTREAM
log using "$DS_RUN/logs/00_MASTER.log", name(DOWNSTREAM) text
foreach mode in actual development {
 foreach edge in 01_project_source 02_identity 03_features 04_export_validate {
  noisily display as result "CALL | `mode' | downstream/code/`edge'.do"
  capture noisily do "$DS_ROOT/downstream/code/`edge'.do" "`mode'"
  local rc=_rc
  if `rc' {
   noisily display as error "STOP | `mode' | `edge' | r(`rc') | $DS_RUN/logs/00_MASTER.log"
   log close DOWNSTREAM
   exit `rc'
  }
 }
}
noisily display as result "CALL | downstream/code/05_g1_receipt_check.do"
do "$DS_ROOT/downstream/code/05_g1_receipt_check.do"
demo_shell "$DS_PYTHON" "$DS_ROOT/downstream/scripts/package.py" finish "$DS_ROOT" "$DS_RUN"
if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
confirm file "$DS_RUN/COMPLETE.json"
noisily display as result "ANALYSIS_DATASET_DONE | $DS_RUN"
log close DOWNSTREAM
