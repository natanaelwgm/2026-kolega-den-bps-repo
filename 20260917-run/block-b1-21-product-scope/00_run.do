/*==========================================================================
  B1-21  PRODUCT SCOPE AND PRODUCT RESTRUCTURING  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-21-product-scope/00_run.do"                  all files
      do ".../block-b1-21-product-scope/00_run.do" "" 05            only file 05
      do ".../block-b1-21-product-scope/00_run.do" "" paths         only set the paths
      do ".../block-b1-21-product-scope/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_21_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b21_*.dta             working datasets (open and browse)
      output/b1_21_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-09 need the prep files (01a, 01b) to have run once.

  Close b1_21_tables.xlsx in Excel before running, otherwise Stata cannot
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
    global B21 "`c(pwd)'"
}
else global B21 "$B12_REPO/20260917-run/block-b1-21-product-scope"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B21/../block-0-data-preparation/analysis_ready_data.dta"

* ---- EDIT THIS LINE: folder with Proman2021/2022 (.xlsx)
global ROSTER  "/Users/schalkeanindyaputri/Documents/Research & Conferences/DEN BPS IBS/DEN BPS IBS Research/schalke-workstream/data/rosters_raw"

global B21_DATA "$B21/data"
global B21_OUT  "$B21/output"
global B21_XLSX "$B21_OUT/b1_21_tables.xlsx"
capture mkdir "$B21_DATA"
capture mkdir "$B21_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-21 paths set. Run any file in $B21"
    exit
}

* ---- files, in run order --------------------------------------------------
* 10 (figures) runs last because it draws from the tables
local files "01a_prep_si 01b_prep_proman 02_n_products 03_product_hhi 04_product_entry_exit 05_core_product_share 06_export_share_per_product 07_export_destination 08_compare_groups 09_synthesis 10_figures"

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

capture log close b21
log using "$B21_OUT/b1_21_log.log", replace text name(b21)
foreach f of local files {
    display _newline as result "######## B1-21: `f' ########"
    do "$B21/`f'.do"
}
log close b21
display as result "DONE. Tables: $B21_XLSX"
