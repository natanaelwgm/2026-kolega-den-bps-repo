/*==========================================================================
  B1-12  SOE VS PRIVATE FIRMS  --  run this block

  Row 12 of "List do file yang perlu dibuat" (PIC Toar), on the block 0
  analysis-ready data, in the layout of the 20260917-run b1 blocks.

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-12-soe-status/00_run.do"                  all files
      do ".../block-b1-12-soe-status/00_run.do" "" 05            only file 05
      do ".../block-b1-12-soe-status/00_run.do" "" paths         only set the paths
      do ".../block-b1-12-soe-status/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_12_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png          charts
      data/b12_si.dta          working dataset (open and browse)
      output/b1_12_log.log       log

  One do-file = one line of the row; the file number is the line number.
  After "paths" (or a full run) any file can be run on its own.
  All files need the prep file 01a_prep_si to have run once.
  This block uses only the SI panel (no roster files), so nothing needs editing.
  Row 12 cannot run yet: block 0 has no SOE variable (see README).

  Close b1_12_tables.xlsx in Excel before running, otherwise Stata cannot
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
    capture confirm file "../../20260917-run/block-0-data-preparation/analysis_ready_data.dta"
    if _rc {
        display as error "Set the repository root once per session, then re-run:"
        display as error `"    global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo""'
        exit 198
    }
    global B12 "`c(pwd)'"
}
else global B12 "$B12_REPO/20261005-run/block-b1-12-soe-status"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B12/../../20260917-run/block-0-data-preparation/analysis_ready_data.dta"

global B12_DATA "$B12/data"
global B12_OUT  "$B12/output"
global B12_XLSX "$B12_OUT/b1_12_tables.xlsx"
capture mkdir "$B12_DATA"
capture mkdir "$B12_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-12 paths set. Run any file in $B12"
    exit
}

* ---- files, in run order --------------------------------------------------
* the figures file runs last because it draws from every table
local files "01a_prep_si 01_overview 02_tfp 03_va_output_capital 04_workers_and_size 05_sector 06_energy_use 07_emissions 08_location 09_rnd 10_figures"

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

capture log close b12
log using "$B12_OUT/b1_12_log.log", replace text name(b12)
foreach f of local files {
    display _newline as result "######## B1-12: `f' ########"
    do "$B12/`f'.do"
}
log close b12
display as result "DONE. Tables: $B12_XLSX"
