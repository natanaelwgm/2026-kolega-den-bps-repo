/*==========================================================================
  R1 — run every exhibit of this block, in order.
  Each exhibit is also a standalone do-file: open it and press Do.
  Development data — obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
clear all
set more off
set varabbrev off

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r1-paris-internationalisation"
* ---------------------------------------------------------------------------
* The two paths above are passed to every exhibit file, so you edit them once here.

* Exhibit files, in order (added as each exhibit passes review).
local files "01_group_shares_support 02_exporters_energy_co2_per_va 03_importers_energy_co2_per_va 04_foreign_owned_energy_co2_per_va 05_before_after_paris 06_frozen_pre_paris_groups 07_electricity_own_generation"

local n : word count `files'
local i 0
* Start clock (exhibit files run -clear all-, which resets Stata timers, so use the wall clock).
local t0 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
foreach f of local files {
    local ++i
    display _newline as result "######## R1 [`i'/`n'] running `f'.do ########"
    * Keep the two paths: each exhibit starts with -clear all-, which does not drop globals.
    do "$OUTDIR/`f'.do" "$DATA" "$OUTDIR"
}
local t1 = clock("`c(current_date)' `c(current_time)'", "DMYhms")
display _newline as result "ALL `n' R1 EXHIBITS FINISHED (elapsed " %6.0f (`t1' - `t0')/1000 " s)"
