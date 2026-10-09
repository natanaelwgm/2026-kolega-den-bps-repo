/*==========================================================================
  B2-03  HOW CONCENTRATED ARE INDUSTRIAL EMISSIONS?  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-03-emission-concentration/00_run.do"                  all files
      do ".../block-b2-03-emission-concentration/00_run.do" "" 09            only file 09
      do ".../block-b2-03-emission-concentration/00_run.do" "" paths         only set the paths
      do ".../block-b2-03-emission-concentration/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_03_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b203_si.dta           working dataset (open and browse)
      output/b2_03_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number (lines 2-6 share one file). After "paths" (or a full run) any file
  can be run on its own. Files 02-11 need 01a to have run once.
  This block uses only the SI panel, so there is no roster folder to set.

  Close b2_03_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B203 "`c(pwd)'"
}
else global B203 "$B12_REPO/20260917-run/block-b2-03-emission-concentration"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B203/../block-0-data-preparation/analysis_ready_data.dta"

global B203_DATA "$B203/data"
global B203_OUT  "$B203/output"
global B203_XLSX "$B203_OUT/b2_03_tables.xlsx"
capture mkdir "$B203_DATA"
capture mkdir "$B203_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-03 paths set. Run any file in $B203"
    exit
}

* ---- files, in run order --------------------------------------------------
* 11 (figures) runs last because it draws from every table
local files "01a_prep_si 02-06_top_emitter_shares 07_top_emitter_other_shares 08_within_kbli5_distribution 09_gini_lorenz 10_synthesis 11_figures"

* only one file? pick it by its number (e.g. "09" or "01a")
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

capture log close b203
log using "$B203_OUT/b2_03_log.log", replace text name(b203)
foreach f of local files {
    display _newline as result "######## B2-03: `f' ########"
    do "$B203/`f'.do"
}
log close b203
display as result "DONE. Tables: $B203_XLSX"
