* Shared configuration for individual steps and the complete preparation run.
version 17
set more off
set varabbrev off
if "$B0_HOME"=="" global B0_HOME `"`c(pwd)'"'
capture program drop b0_setup
program define b0_setup
    capture confirm file "$B0_HOME/settings.do"
    if _rc {
        display as error "Set the Stata working directory to block-0-data-preparation and rerun."
        exit 601
    }
    local previous `"`c(pwd)'"'
    quietly cd "$B0_HOME/../.."
    global B0_REPO `"`c(pwd)'"'
    quietly cd `"`previous'"'
    global B0_SEED_FILE ""
    global B0_ACCEPTED_RAW ""
    do "$B0_HOME/settings.do"
    global B0_ACCEPTED_RAW "$REUSE_CLEAN_RUN"
    if "$WORK_DIR"=="" {
        display as error "Set WORK_DIR in settings.do."
        exit 198
    }
    global RUN_HOME "$B0_REPO/demo"
    global RUN_PYTHON "$PYTHON"
    quietly do "$B0_HOME/support/progress.do"
    global DEMO_CURRENT_STAGE "Initialize working directory"
    local resume "$RESUME_RUN"
    if "$B0_RUN"!="" local resume "$B0_RUN"
    tempfile configured
    demo_shell "$PYTHON" "$B0_REPO/downstream/simple/engine.py" init "$WORK_DIR" "$RAW_DATA" "$REFERENCE_DATA" "$B0_SEED_FILE" "`resume'" "`configured'" "$B0_ACCEPTED_RAW"
    if $DEMO_HELPER_RC!=0 exit $DEMO_HELPER_RC
    do "`configured'"
end
capture program drop b0_step
program define b0_step
    args number title
    global DEMO_CURRENT_STAGE "`number'/4 - `title'"
    capture window manage forward results
    display _n as result "============================================================"
    display as result "STEP `number' OF 4: `title'"
    display as text "Started: `c(current_time)'"
    display as text "Run folder: $B0_RUN"
    display as result "============================================================"
end
