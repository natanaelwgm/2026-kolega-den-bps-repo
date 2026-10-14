/*==========================================================================
  R10 — run every exhibit of this block, in order.
  Each exhibit is also a standalone do-file: open it and press Do.
  Development data — obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
clear all
set more off
set varabbrev off
args data_arg outdir_arg

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "`c(pwd)'/../block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "`c(pwd)'"
if `"`data_arg'"' != "" global DATA `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
* ---------------------------------------------------------------------------
* The two paths above are passed to every exhibit file, so you edit them once here.

* Exhibit files, in order (added as each exhibit passes review).
local files "01_covid_cohort_groups 02_left_the_file_by_group 03_survivors_output_jobs_productivity 04_all_firms_output_jobs 05_export_participation 06_robustness_reweighted_rules"

local n : word count `files'
local i 0
* Start clock (exhibit files run -clear all-, which resets Stata timers, so use the wall clock).
local t0 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
foreach f of local files {
    local ++i
    display _newline as result "######## R10 [`i'/`n'] running `f'.do ########"
    * Keep the two paths: each exhibit starts with -clear all-, which does not drop globals.
    do "$OUTDIR/`f'.do" "$DATA" "$OUTDIR"
}
local t1 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
display _newline as result "ALL `n' R10 EXHIBITS FINISHED (elapsed " %6.0f (`t1' - `t0')/1000 " s)"
