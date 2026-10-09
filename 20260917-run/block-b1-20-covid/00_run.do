/*==========================================================================
  B1-20  WHAT HAPPENED DURING COVID  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-20-covid/00_run.do"                  all files
      do ".../block-b1-20-covid/00_run.do" "" 07            only file 07
      do ".../block-b1-20-covid/00_run.do" "" paths         only set the paths
      do ".../block-b1-20-covid/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_20_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b20_*.dta             working datasets (open and browse)
      output/b1_20_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-16 need 01a and 01b; 07 needs 04-06; 15 and 16 need 09-14.

  FIRM LINKS: lines 4-7 and 9-16 follow firms across years on firm_id.
  In the development data these links are FICTIONAL, so those results only
  mean something on the real BPS data. The code is written for the real data.

  Close b1_20_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B20 "`c(pwd)'"
}
else global B20 "$B12_REPO/20260917-run/block-b1-20-covid"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B20/../block-0-data-preparation/analysis_ready_data.dta"

global B20_DATA "$B20/data"
global B20_OUT  "$B20/output"
global B20_XLSX "$B20_OUT/b1_20_tables.xlsx"
capture mkdir "$B20_DATA"
capture mkdir "$B20_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-20 paths set. Run any file in $B20"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 8 (figures) runs last because it draws from every table
local files "01a_prep_si 01b_firm_panel 02_before_after 03_firms_by_sector 04-06_entry_exit_survival 07_characteristics 09-14_recovery_trajectories 15_pre_covid_characteristics 16_follow_recovery 08_figures"

* only one file? pick it by its number (e.g. "07" or "01a")
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

capture log close b20
log using "$B20_OUT/b1_20_log.log", replace text name(b20)
foreach f of local files {
    display _newline as result "######## B1-20: `f' ########"
    do "$B20/`f'.do"
}
log close b20
display as result "DONE. Tables: $B20_XLSX"
