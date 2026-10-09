/*==========================================================================
  B2-10  REGIONAL ASPECTS OF MANUFACTURING DECARBONISATION  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-10-regional/00_run.do"                  all files
      do ".../block-b2-10-regional/00_run.do" "" 05            only file 05
      do ".../block-b2-10-regional/00_run.do" "" paths         only set the paths
      do ".../block-b2-10-regional/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_10_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b210_si.dta           working dataset (open and browse)
      output/b2_10_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-11 need 01a_prep_si to have run once.

  Close b2_10_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B210 "`c(pwd)'"
}
else global B210 "$B12_REPO/20260917-run/block-b2-10-regional"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B210/../block-0-data-preparation/analysis_ready_data.dta"

global B210_DATA "$B210/data"
global B210_OUT  "$B210/output"
global B210_XLSX "$B210_OUT/b2_10_tables.xlsx"
capture mkdir "$B210_DATA"
capture mkdir "$B210_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-10 paths set. Run any file in $B210"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 11 (figures) runs last because it draws from the tables of 03-10
local files "01a_prep_si 02_overview 03_va 04_energy 05_emissions 06_carbon_intensity 07_exporter_concentration 08_fdi_concentration 09_energy_mix 10_ranking 11_figures"

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

capture log close b210
log using "$B210_OUT/b2_10_log.log", replace text name(b210)
foreach f of local files {
    display _newline as result "######## B2-10: `f' ########"
    do "$B210/`f'.do"
}
log close b210
display as result "DONE. Tables: $B210_XLSX"
