/*==========================================================================
  B1-21b  EXPORT DESTINATION STRUCTURE  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-21b-export-destination/00_run.do"                  all files
      do ".../block-b1-21b-export-destination/00_run.do" "" 03            only file 03
      do ".../block-b1-21b-export-destination/00_run.do" "" paths         only set the paths
      do ".../block-b1-21b-export-destination/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_21b_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png             charts
      data/b21b_*.dta             working datasets (open and browse)
      output/b1_21b_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-05 need the prep files (01a, 01b) to have run once.

  Close b1_21b_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B21B "`c(pwd)'"
}
else global B21B "$B12_REPO/20260917-run/block-b1-21b-export-destination"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B21B/../block-0-data-preparation/analysis_ready_data.dta"

* ---- EDIT THIS LINE: folder with Proman2021/2022 (.xlsx)
global ROSTER  "/Users/schalkeanindyaputri/Documents/Research & Conferences/DEN BPS IBS/DEN BPS IBS Research/schalke-workstream/data/rosters_raw"

global B21B_DATA "$B21B/data"
global B21B_OUT  "$B21B/output"
global B21B_XLSX "$B21B_OUT/b1_21b_tables.xlsx"
capture mkdir "$B21B_DATA"
capture mkdir "$B21B_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-21b paths set. Run any file in $B21B"
    exit
}

* ---- files, in run order --------------------------------------------------
* 05 (figures) runs last because it draws from every table
local files "01a_prep_si 01b_prep_proman 02_main_destination 03_destination_concentration 04_high_standard_markets 05_figures"

* only one file? pick it by its number (e.g. "03" or "01b")
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

capture log close b21b
log using "$B21B_OUT/b1_21b_log.log", replace text name(b21b)
foreach f of local files {
    display _newline as result "######## B1-21b: `f' ########"
    do "$B21B/`f'.do"
}
log close b21b
display as result "DONE. Tables: $B21B_XLSX"
