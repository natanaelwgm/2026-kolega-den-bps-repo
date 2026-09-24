/*==========================================================================
  R2 — run every exhibit of this block, in order.
  Each exhibit is also a standalone do-file: open it and press Do.
  Development data — obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
clear all
set more off
set varabbrev off

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
* The two paths above are passed to every exhibit file, so you edit them once here.
* Needs Stata add-ons (install once, see INDEX.md): reghdfe ftools require csdid drdid eventstudyinteract avar did_imputation did_multiplegt_dyn gtools

* Exhibit files, in order (added as each exhibit passes review).
local files "01_export_entry_cohorts 02_event_time_support 03_energy_efficiency_export_start 04_co2_efficiency_export_start 05_energy_co2_va_export_start 06_efficiency_by_start_year 07_efficiency_by_method"

local n : word count `files'
local i 0
* Start clock (exhibit files run -clear all-, which resets Stata timers, so use the wall clock).
local t0 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
foreach f of local files {
    local ++i
    display _newline as result "######## R2 [`i'/`n'] running `f'.do ########"
    * Keep the two paths: each exhibit starts with -clear all-, which does not drop globals.
    do "$OUTDIR/`f'.do" "$DATA" "$OUTDIR"
}
local t1 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
display _newline as result "ALL `n' R2 EXHIBITS FINISHED (elapsed " %6.0f (`t1' - `t0')/1000 " s)"
