/*==========================================================================
  B2-04  WHO DROVE AGGREGATE MANUFACTURING DECARBONISATION?  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-04-who-drove-decarbonisation/00_run.do"                  all files
      do ".../block-b2-04-who-drove-decarbonisation/00_run.do" "" 06            only file 06
      do ".../block-b2-04-who-drove-decarbonisation/00_run.do" "" paths         only set the paths
      do ".../block-b2-04-who-drove-decarbonisation/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_04_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b204_*.dta            working datasets (open and browse)
      output/b2_04_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number (02-05 = lines 2 to 5, which are one calculation). _decompose.do is
  a helper that 02-05 and 06 call. After "paths" (or a full run) any file can
  be run on its own. Files 02-07 need 01a to have run once.

  Close b2_04_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B204 "`c(pwd)'"
}
else global B204 "$B12_REPO/20260917-run/block-b2-04-who-drove-decarbonisation"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B204/../block-0-data-preparation/analysis_ready_data.dta"

global B204_DATA "$B204/data"
global B204_OUT  "$B204/output"
global B204_XLSX "$B204_OUT/b2_04_tables.xlsx"
capture mkdir "$B204_DATA"
capture mkdir "$B204_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-04 paths set. Run any file in $B204"
    exit
}

* ---- files, in run order --------------------------------------------------
* 07 (figures) runs last because it draws from the tables
local files "01a_prep_si 02-05_decomposition 06_by_group 07_figures"

* only one file? pick it by its number (e.g. "06" or "01a")
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

capture log close b204
log using "$B204_OUT/b2_04_log.log", replace text name(b204)
foreach f of local files {
    display _newline as result "######## B2-04: `f' ########"
    do "$B204/`f'.do"
}
log close b204
display as result "DONE. Tables: $B204_XLSX"
