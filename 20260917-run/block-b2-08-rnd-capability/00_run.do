/*==========================================================================
  B2-08  R&D, INNOVATION AND ENVIRONMENTAL CAPABILITY  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-08-rnd-capability/00_run.do"                  all files
      do ".../block-b2-08-rnd-capability/00_run.do" "" 05            only file 05
      do ".../block-b2-08-rnd-capability/00_run.do" "" paths         only set the paths
      do ".../block-b2-08-rnd-capability/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_08_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b208_si.dta           working dataset (open and browse)
      output/b2_08_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-09 need 01a_prep_si to have run once.

  Close b2_08_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B208 "`c(pwd)'"
}
else global B208 "$B12_REPO/20260917-run/block-b2-08-rnd-capability"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B208/../block-0-data-preparation/analysis_ready_data.dta"

global B208_DATA "$B208/data"
global B208_OUT  "$B208/output"
global B208_XLSX "$B208_OUT/b2_08_tables.xlsx"
capture mkdir "$B208_DATA"
capture mkdir "$B208_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-08 paths set. Run any file in $B208"
    exit
}

* ---- files, in run order --------------------------------------------------
* 09 (figures) runs last because it draws from the tables
local files "01a_prep_si 02_availability 03_rnd_incidence 04_rnd_intensity 05_innovation 06_amdal 07_waste 08_crosstabs 09_figures"

* only one file? pick it by its number (e.g. "05" or "01a")
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

capture log close b208
log using "$B208_OUT/b2_08_log.log", replace text name(b208)
foreach f of local files {
    display _newline as result "######## B2-08: `f' ########"
    do "$B208/`f'.do"
}
log close b208
display as result "DONE. Tables: $B208_XLSX"
