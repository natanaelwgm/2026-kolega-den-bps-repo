/*==========================================================================
  B1-18  ELABORATE DATA BAHAN BAKU (raw materials)  --  run this block

  SET THIS ONCE PER STATA SESSION (same as every other block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../block-b1-18-bahan-baku/00_run.do"                  all files
      do ".../block-b1-18-bahan-baku/00_run.do" "" 05            only file 05
      do ".../block-b1-18-bahan-baku/00_run.do" "" paths         only set the paths
      do ".../block-b1-18-bahan-baku/00_run.do" "/path/to/repo"  set the repo inline

  With no B12_REPO set it assumes the working directory is this folder.

  Results:
      output/b1_18_tables.xlsx   all tables, 1 sheet = 1 table
      output/fig*.png            charts
      data/b18_*.dta             working datasets (open and browse)
      output/b1_18_log.log       log

  One do-file = one line of the to-do list; the file number is the line
  number. After "paths" (or a full run) any file can be run on its own.
  Files 02-19 need the prep files (01a-01c) and 13 to have run once.

  Close b1_18_tables.xlsx in Excel before running, otherwise Stata cannot
  write to it.
==========================================================================*/
version 17
clear all
set more off

args repo which roster_dir
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
    global B18 "`c(pwd)'"
}
else global B18 "$B12_REPO/20260917-run/block-b1-18-bahan-baku"

* Statistik Industri 2010-2022 (block 0 output)
global SI_DATA "$B18/../block-0-data-preparation/analysis_ready_data.dta"

* ---- EDIT THIS LINE: folder with Bahanbaku2021/2022 and Proman2021/2022 (.xlsx)
* Optional third argument overrides the current session setting.
if `"`roster_dir'"' != "" global ROSTER `"`roster_dir'"'
if "$ROSTER" == "" global ROSTER "$B18/../../inputs/rosters"

global B18_DATA "$B18/data"
global B18_OUT  "$B18/output"
global B18_XLSX "$B18_OUT/b1_18_tables.xlsx"
capture mkdir "$B18_DATA"
capture mkdir "$B18_OUT"

capture confirm file "$SI_DATA"
if _rc {
    display as error "Not found: $SI_DATA  -- check B12_REPO."
    exit 601
}
if "`which'" == "paths" {
    display as result "B1-18 paths set. Run any file in $B18"
    exit
}

* ---- files, in run order --------------------------------------------------
* line 12 (figures) runs last because it draws from every table
local files "01a_prep_si 01b_prep_bahanbaku 01c_prep_proman 02_desc_domestic_vs_import 03_who_imports 04_import_reliance_profile 05_fdi 06_exporter 07_medium_vs_large 08_sector 09_location 10_firm_characteristics 11_import_origin 13_construct 14_imported_input_share 15_import_variety 16_domestic_import_mix 17_sourcing_concentration 18_industry_dependence 19_compare_import_vs_not 12_figures"

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

capture log close b18
log using "$B18_OUT/b1_18_log.log", replace text name(b18)
foreach f of local files {
    display _newline as result "######## B1-18: `f' ########"
    do "$B18/`f'.do"
}
log close b18
display as result "DONE. Tables: $B18_XLSX"
