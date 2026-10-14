/*==========================================================================
  B1-16  ELABORATE ENERGY USE  --  run this block

  Row 16 of "List do file yang perlu dibuat" (PIC Toar), on the block 0
  analysis-ready data, in the layout of the 20260917-run b1 blocks.

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-16-energy-use/00_run.do"                  all files
      do ".../block-b1-16-energy-use/00_run.do" "" 05            only file 05
      do ".../block-b1-16-energy-use/00_run.do" "" paths         only set the paths
      do ".../block-b1-16-energy-use/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_16_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png          charts
      data/b16_si.dta          working dataset (open and browse)
      output/b1_16_log.log       log

  One do-file = one line of the row; the file number is the line number.
  After "paths" (or a full run) any file can be run on its own.
  All files need the prep file 01a_prep_si to have run once.
  This block uses only the SI panel (no roster files), so nothing needs editing.

  Close b1_16_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B16 "`c(pwd)'"
}
else global B16 "$B12_REPO/20261005-run/block-b1-16-energy-use"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B16/../../20260917-run/block-0-data-preparation/analysis_ready_data.dta"

global B16_DATA "$B16/data"
global B16_OUT  "$B16/output"
global B16_XLSX "$B16_OUT/b1_16_tables.xlsx"
capture mkdir "$B16_DATA"
capture mkdir "$B16_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-16 paths set. Run any file in $B16"
    exit
}

* ---- files, in run order --------------------------------------------------
* the figures file runs last because it draws from every table
local files "01a_prep_si 01_energy_overview 02_by_main_energy_source 03_by_sector 04_by_tfp 05_by_productivity_and_scale 06_by_workers 07_by_fdi 08_by_trade 09_by_emissions 10_by_location 11_by_rnd 12_figures"

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

capture log close b16
log using "$B16_OUT/b1_16_log.log", replace text name(b16)
foreach f of local files {
    display _newline as result "######## B1-16: `f' ########"
    do "$B16/`f'.do"
}
log close b16
display as result "DONE. Tables: $B16_XLSX"
