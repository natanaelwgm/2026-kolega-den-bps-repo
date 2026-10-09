/*==========================================================================
  B2-05  ENERGY TRANSITION AND CARBON LOCK-IN AT PLANT LEVEL  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-05-energy-mix/00_run.do"                  all files
      do ".../block-b2-05-energy-mix/00_run.do" "" 03            only file 03
      do ".../block-b2-05-energy-mix/00_run.do" "" paths         only set the paths
      do ".../block-b2-05-energy-mix/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_05_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b205_*.dta            working datasets (open and browse)
      output/b2_05_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-05 need 01a to have run once; 03-05 need 02; 04-05 need 03.
  This block uses the SI panel only (no roster files).

  Close b2_05_tables.xlsx in Excel before running, otherwise Stata cannot
  write to it.
==========================================================================*/
version 17
clear all
set more off

args repo which
if `"`repo'"' != "" global B12_REPO `"`repo'"'

* ---- paths --------------------------------------------------------------
if "$B12_REPO" == "" {
    * no repo set: assume the working directory is this folder
    capture confirm file "../block-0-data-preparation/analysis_ready_data.dta"
    if _rc {
        display as error "Set the repository root once per session, then re-run:"
        display as error `"    global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo""'
        exit 198
    }
    global B205 "`c(pwd)'"
}
else global B205 "$B12_REPO/20260917-run/block-b2-05-energy-mix"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B205/../block-0-data-preparation/analysis_ready_data.dta"

global B205_DATA "$B205/data"
global B205_OUT  "$B205/output"
global B205_XLSX "$B205_OUT/b2_05_tables.xlsx"
capture mkdir "$B205_DATA"
capture mkdir "$B205_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-05 paths set. Run any file in $B205"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 5 (charts by sector) is also the figures file, so it runs last
local files "01a_prep_si 02_energy_mix 03_classify 04_transition_matrix 05_figures_by_sector"

* only one file? pick it by its number (e.g. "03" or "01a")
if "`which'" != "" {
    local pick ""
    foreach f of local files {
        if substr("`f'", 1, strlen("`which'")) == "`which'" local pick "`pick' `f'"
    }
    if "`pick'" == "" {
        display as error "No file `which' in this block. Available: `files'"
        exit 198
    }
    local files "`pick'"
}

capture log close b205
log using "$B205_OUT/b2_05_log.log", replace text name(b205)
foreach f of local files {
    display _newline as result "######## B2-05: `f' ########"
    do "$B205/`f'.do"
}
log close b205
display as result "DONE. Tables: $B205_XLSX"
