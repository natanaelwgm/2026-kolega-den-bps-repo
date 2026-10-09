/*==========================================================================
  B1-19  ELABORATE DATA PROMAN (production & exports)  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-19-proman/00_run.do"                  all files
      do ".../block-b1-19-proman/00_run.do" "" 05            only file 05
      do ".../block-b1-19-proman/00_run.do" "" paths         only set the paths
      do ".../block-b1-19-proman/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_19_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b19_*.dta             working datasets (open and browse)
      output/b1_19_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-12 need the prep files (01a, 01b) to have run once.

  Close b1_19_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B19 "`c(pwd)'"
}
else global B19 "$B12_REPO/20260917-run/block-b1-19-proman"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B19/../block-0-data-preparation/analysis_ready_data.dta"

* ---- EDIT THIS LINE: folder with Proman2021/2022 (.xlsx)
global ROSTER  "/Users/schalkeanindyaputri/Documents/Research & Conferences/DEN BPS IBS/DEN BPS IBS Research/schalke-workstream/data/rosters_raw"

global B19_DATA "$B19/data"
global B19_OUT  "$B19/output"
global B19_XLSX "$B19_OUT/b1_19_tables.xlsx"
capture mkdir "$B19_DATA"
capture mkdir "$B19_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-19 paths set. Run any file in $B19"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 12 (figures) runs last because it draws from every table
local files "01a_prep_si 01b_prep_proman 02_desc_domestic_vs_export 03_who_exports 04_exporter_profile 05_fdi 06_importer 07_medium_vs_large 08_sector 09_location 10_firm_characteristics 11_export_destination 12_figures"

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

capture log close b19
log using "$B19_OUT/b1_19_log.log", replace text name(b19)
foreach f of local files {
    display _newline as result "######## B1-19: `f' ########"
    do "$B19/`f'.do"
}
log close b19
display as result "DONE. Tables: $B19_XLSX"
