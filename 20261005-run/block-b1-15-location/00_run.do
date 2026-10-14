/*==========================================================================
  B1-15  LOCATION BY PROVINCE AND JAVA VS OUTSIDE JAVA  --  run this block

  Row 15 of "List do file yang perlu dibuat" (PIC Toar), on the block 0
  analysis-ready data, in the layout of the 20260917-run b1 blocks.

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-15-location/00_run.do"                  all files
      do ".../block-b1-15-location/00_run.do" "" 05            only file 05
      do ".../block-b1-15-location/00_run.do" "" paths         only set the paths
      do ".../block-b1-15-location/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_15_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png          charts
      data/b15_si.dta          working dataset (open and browse)
      output/b1_15_log.log       log

  One do-file = one line of the row; the file number is the line number.
  After "paths" (or a full run) any file can be run on its own.
  All files need the prep file 01a_prep_si to have run once.
  This block uses only the SI panel (no roster files), so nothing needs editing.

  Close b1_15_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B15 "`c(pwd)'"
}
else global B15 "$B12_REPO/20261005-run/block-b1-15-location"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B15/../../20260917-run/block-0-data-preparation/analysis_ready_data.dta"

global B15_DATA "$B15/data"
global B15_OUT  "$B15/output"
global B15_XLSX "$B15_OUT/b1_15_tables.xlsx"
capture mkdir "$B15_DATA"
capture mkdir "$B15_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-15 paths set. Run any file in $B15"
    exit
}

* ---- files, in run order --------------------------------------------------
* the figures file runs last because it draws from every table
local files "01a_prep_si 01_overview 02_sector 03_tfp 04_va_output_capital 05_workers 06_fdi 07_export_import 08_energy_use 09_emissions 10_rnd 11_figures"

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

capture log close b15
log using "$B15_OUT/b1_15_log.log", replace text name(b15)
foreach f of local files {
    display _newline as result "######## B1-15: `f' ########"
    do "$B15/`f'.do"
}
log close b15
display as result "DONE. Tables: $B15_XLSX"
