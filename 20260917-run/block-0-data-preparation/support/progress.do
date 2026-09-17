* Native Results output stays live while one owned Python helper is running.
capture program drop demo_progress
program define demo_progress
    args step description
    global DEMO_CURRENT_STAGE `"`step': `description'"'
    capture window manage forward results
    noisily display _n as result "======================================================================"
    noisily display as result "STAGE `step' | `description'"
    noisily display as text "Started: `c(current_time)'"
    noisily display as result "======================================================================"
end

capture program drop _demo_poll
program define _demo_poll
    args stream done
    local printed=0
    local ticks=0
    while 1 {
        tempname reader
        file open `reader' using "`stream'", read text
        local line_number=0
        file read `reader' line
        while r(eof)==0 {
            local ++line_number
            if `line_number'>`printed' noisily display as text `"`line'"'
            file read `reader' line
        }
        file close `reader'
        local printed=`line_number'
        capture confirm file "`done'"
        if !_rc continue, break
        if mod(`ticks',3)==0 {
            noisily display as result "RUNNING | $DEMO_CURRENT_STAGE | `ticks' seconds | `c(current_time)'"
        }
        sleep 1000
        local ++ticks
    }
end

capture program drop demo_shell
program define demo_shell
    local command `"`0'"'
    tempfile stream done pid
    shell "$RUN_PYTHON" "$RUN_HOME/scripts/live_helper.py" start "`stream'" "`done'" "`pid'" -- `command'
    confirm file "`stream'"
    capture noisily _demo_poll "`stream'" "`done'"
    local poll_rc=_rc
    if `poll_rc' {
        shell "$RUN_PYTHON" "$RUN_HOME/scripts/live_helper.py" stop "`stream'" "`done'" "`pid'"
        noisily display as error "STOPPED | helper terminated with the Stata run"
        exit `poll_rc'
    }
    quietly do "`done'"
    if $DEMO_HELPER_RC!=0 noisily display as error "HELPER ERROR | rc=$DEMO_HELPER_RC | $DEMO_CURRENT_STAGE"
end
