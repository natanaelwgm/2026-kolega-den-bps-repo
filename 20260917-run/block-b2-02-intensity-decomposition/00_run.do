/*==========================================================================
  B2-02  DECOMPOSE CARBON INTENSITY (CO2/VA = GJ/VA x CO2/GJ)  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b2-02-intensity-decomposition/00_run.do"                  all files
      do ".../block-b2-02-intensity-decomposition/00_run.do" "" 04            only file 04
      do ".../block-b2-02-intensity-decomposition/00_run.do" "" paths         only set the paths
      do ".../block-b2-02-intensity-decomposition/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b2_02_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b202_si.dta           working dataset (open and browse)
      output/b2_02_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 01-06 need 01a_prep_si to have run once.

  Close b2_02_tables.xlsx in Excel before running, otherwise Stata cannot
  write to it.
==========================================================================*/
version 17
clear all
set more off
* new variables in double precision, so ln CO2/VA = ln GJ/VA + ln CO2/GJ
* holds to rounding error in every table (Stata's default is float)
set type double

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
    global B202 "`c(pwd)'"
}
else global B202 "$B12_REPO/20260917-run/block-b2-02-intensity-decomposition"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B202/../block-0-data-preparation/analysis_ready_data.dta"

global B202_DATA "$B202/data"
global B202_OUT  "$B202/output"
global B202_XLSX "$B202_OUT/b2_02_tables.xlsx"
capture mkdir "$B202_DATA"
capture mkdir "$B202_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B2-02 paths set. Run any file in $B202"
    exit
}

* ---- files, in run order --------------------------------------------------
* 06 (figures) runs last because it draws from the tables
local files "01a_prep_si 01_decomposition 02_overview 03_energy_term 04_clean_energy_term 05_synthesis 06_figures"

* only one file? pick it by its number (e.g. "04" or "01a")
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

capture log close b202
log using "$B202_OUT/b2_02_log.log", replace text name(b202)
foreach f of local files {
    display _newline as result "######## B2-02: `f' ########"
    do "$B202/`f'.do"
}
log close b202
display as result "DONE. Tables: $B202_XLSX"
