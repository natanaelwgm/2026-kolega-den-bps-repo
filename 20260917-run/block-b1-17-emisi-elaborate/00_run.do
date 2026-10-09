/*==========================================================================
  B1-17  ELABORATE EMISI (emissions)  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-17-emisi-elaborate/00_run.do"                  all files
      do ".../block-b1-17-emisi-elaborate/00_run.do" "" 05            only file 05
      do ".../block-b1-17-emisi-elaborate/00_run.do" "" paths         only set the paths
      do ".../block-b1-17-emisi-elaborate/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_17_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b17_*.dta             working datasets (open and browse)
      output/b1_17_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 01-12 need the prep file 01a_prep_si to have run once.
  This block uses only the SI panel (no roster files), so nothing needs editing.

  Close b1_17_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B17 "`c(pwd)'"
}
else global B17 "$B12_REPO/20260917-run/block-b1-17-emisi-elaborate"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B17/../block-0-data-preparation/analysis_ready_data.dta"

global B17_DATA "$B17/data"
global B17_OUT  "$B17/output"
global B17_XLSX "$B17_OUT/b1_17_tables.xlsx"
capture mkdir "$B17_DATA"
capture mkdir "$B17_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-17 paths set. Run any file in $B17"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 12 (figures) runs last because it draws from every table
local files "01a_prep_si 01_emissions_overview 02_by_main_energy_source 03_by_sector 04_by_tfp 05_by_productivity_and_scale 06_by_workers 07_by_fdi 08_by_trade 09_by_energy_use 10_by_location 11_by_rnd 12_figures"

* only one file? pick it by its number (e.g. "05" or "01a"; "01" runs 01a and 01)
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

capture log close b17
log using "$B17_OUT/b1_17_log.log", replace text name(b17)
foreach f of local files {
    display _newline as result "######## B1-17: `f' ########"
    do "$B17/`f'.do"
}
log close b17
display as result "DONE. Tables: $B17_XLSX"
