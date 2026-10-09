/*==========================================================================
  B2-09  GREEN TRANSITION AND EMPLOYMENT  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-09-green-transition-employment/00_run.do"                  all files
      do ".../block-b2-09-green-transition-employment/00_run.do" "" 04            only file 04
      do ".../block-b2-09-green-transition-employment/00_run.do" "" paths         only set the paths
      do ".../block-b2-09-green-transition-employment/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_09_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b209_*.dta            working datasets (open and browse)
      output/b2_09_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 03-12 need 01a and 02 to have run once.

  Close b2_09_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B209 "`c(pwd)'"
}
else global B209 "$B12_REPO/20260917-run/block-b2-09-green-transition-employment"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B209/../block-0-data-preparation/analysis_ready_data.dta"

global B209_DATA "$B209/data"
global B209_OUT  "$B209/output"
global B209_XLSX "$B209_OUT/b2_09_tables.xlsx"
capture mkdir "$B209_DATA"
capture mkdir "$B209_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-09 paths set. Run any file in $B209"
    exit
}

* ---- files, in run order --------------------------------------------------
* 12 (figures) runs last because it draws from every table
local files "01a_prep_si 02_classify_carbon_trend 03_overview 04_employment 05_production_workers 06_nonproduction_workers 07_male_female 08_wages 09_va_per_worker 10_capital_per_worker 11_synthesis 12_figures"

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

capture log close b209
log using "$B209_OUT/b2_09_log.log", replace text name(b209)
foreach f of local files {
    display _newline as result "######## B2-09: `f' ########"
    do "$B209/`f'.do"
}
log close b209
display as result "DONE. Tables: $B209_XLSX"
