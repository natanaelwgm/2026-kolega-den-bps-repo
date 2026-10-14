/*==========================================================================
  PROMAN-MERGE  --  merge the production rosters (Proman, Bahan Baku) into
                    the ready-to-use SI file  --  run this folder

  Kept apart from the main pipeline: every script and every output lives in
  20261014-1532-proman-merge/. The ready-to-use file is read, never changed.

  SET THIS ONCE PER STATA SESSION (same as every block's 00_run.do):

      global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo"

  Then:
      do ".../20261014-1532-proman-merge/00_run.do" "" check     FIRST: read + map the files only,
                                                   then look at output/intake_report.csv
      do ".../20261014-1532-proman-merge/00_run.do"              everything (01-06)
      do ".../20261014-1532-proman-merge/00_run.do" "" 04        only file 04
      do ".../20261014-1532-proman-merge/00_run.do" "" paths     only set the paths / settings
  With no B12_REPO set it assumes the working directory is this folder.

  Files:
      01_intake.do           find every roster file, find the header row and
                             the columns by name -> output/proman_std.dta, bahanbaku_std.dta, intake_report.csv
      02_clean_proman.do     numbers, codes, export rules -> proman_rows.dta
      03_clean_bahanbaku.do  numbers, codes, import rules -> bahanbaku_rows.dta
      04_firm_year.do        merge key per year, one row per firm (or cell) x year
                             -> key_by_year.csv, roster_firm_year.dta
      05_merge.do            ready-to-use file + roster columns
                             -> analysis_ready_with_roster.dta
      06_checks.do           match rates, units check, everything that was changed
                             -> merge_report.csv, units_check.csv, cleaning_report.csv
      _column_map.do         WHICH HEADER MEANS WHAT -- edit here if a column is missed
      _helpers.do            programs (reading, header detection, number parsing)

  Inputs: every .xlsx / .xls / .csv / .dta in "Data Roster Produksi/" (and its
  sub-folders) whose name says Proman or Bahan Baku (see _column_map.do). The
  year comes from the file name (2021, or Proman21) or from a year column.
  Any number of years (2010-2022) and any number of files per year.

  Close the output files in Excel before running.
==========================================================================*/
version 17
clear all
set more off
set varabbrev off

args repo which
if `"`repo'"' != "" global B12_REPO `"`repo'"'

* ---- paths --------------------------------------------------------------
if "$B12_REPO" == "" {
    * no repo set: assume the working directory is this folder
    capture confirm file "_column_map.do"
    if _rc {
        display as error "Set the repository root once per session, then re-run:"
        display as error `"    global B12_REPO "/absolute/path/to/2026-kolega-den-bps-repo""'
        exit 198
    }
    global PM "`c(pwd)'"
}
else global PM "$B12_REPO/20261014-1532-proman-merge"

global PM_OUT "$PM/output"
capture mkdir "$PM_OUT"

* ===========================================================================
* SETTINGS -- EDIT HERE FOR THE REAL DATA
*
* !! BUILT AND TESTED ON SAMPLE / SYNTHETIC DATA ONLY (October 2026): the
* !! sample rosters 2021-2022 (Kipb and district masked) and generated test
* !! files for 2010-2022, merged into block 0 (obscured values, fictional
* !! firm links). AT THE WORKSHOP WITH THE REAL DATA: realign the two paths
* !! below to where the real files are given (PM_RAW = folder of the real
* !! Proman / Bahan Baku files, PM_MAIN = the real ready-to-use file with
* !! Kipb), check the variable names, then run "check" first (README).
* ===========================================================================
* folder with the roster files (Proman, Bahan Baku), sub-folders included
global PM_RAW "$PM/Data Roster Produksi"
* the ready-to-use SI file to merge into (default: block 0, obscured)
global PM_MAIN "$PM/../20260917-run/block-0-data-preparation/analysis_ready_data.dta"
* variable names in that file
global PM_KIPB        "kipb"                    // firm ID (block 0 has none -> cell merge)
global PM_MAIN_YEAR   "year"
global PM_MAIN_PROV   "province_code"
global PM_MAIN_KAB    "district_code"           // district; blank in block 0
global PM_MAIN_KBLI   "industry_code"           // 5-digit KBLI
global PM_MAIN_OUTPUT "gross_output_nominal"    // only for the units check in 06
global PM_MAIN_MAT    "val_rtlvcu"              // only for the units check in 06

* merge key: auto = per year, Kipb if the rosters and the main file carry it,
*            else province x district x KBLI5 if both carry the district,
*            else province x KBLI5.   Or force: kipb | cell_kab | cell
global PM_KEY "auto"
* a key part counts as available in a year if at least this share of rows has it
global PM_MIN_FILL 0.5
* export share: auto = a year where at least 90% of the positive shares are <= 1
*               is read as a fraction and multiplied by 100.  Or force: percent | fraction
global PM_SHARE_SCALE "auto"
* ===========================================================================

foreach f in "$PM/_column_map.do" "$PM/_helpers.do" {
    capture confirm file "`f'"
    if _rc {
        display as error "Not found: `f'"
        exit 601
    }
}
do "$PM/_column_map.do"
do "$PM/_helpers.do"
capture confirm file "$PM_MAIN"
if _rc {
    display as error "Ready-to-use file not found: $PM_MAIN  -- set PM_MAIN above."
    exit 601
}
mata: st_numscalar("pm_rawdir", direxists(st_global("PM_RAW")))
if scalar(pm_rawdir) == 0 {
    display as error "Roster folder not found: $PM_RAW"
    exit 601
}
if "`which'" == "paths" {
    display as result "PROMAN-MERGE paths and settings set. Run any file in $PM"
    exit
}

* ---- files, in run order --------------------------------------------------
local files "01_intake 02_clean_proman 03_clean_bahanbaku 04_firm_year 05_merge 06_checks"
if "`which'" == "check" local files "01_intake"
else if "`which'" != "" {
    local pick ""
    foreach f of local files {
        if substr("`f'", 1, strlen("`which'")) == "`which'" local pick "`pick' `f'"
    }
    if "`pick'" == "" {
        display as error "No file `which' in this folder. Available: `files'"
        exit 198
    }
    local files "`pick'"
}

* a full run starts from an empty output folder (no stale results)
if "`which'" == "" {
    local old : dir "$PM_OUT" files "*"
    foreach f of local old {
        if "`f'" != "proman_merge_log.log" capture erase "$PM_OUT/`f'"
    }
}

capture log close pm
log using "$PM_OUT/proman_merge_log.log", replace text name(pm)
foreach f of local files {
    display _newline as result "######## PROMAN-MERGE: `f' ########"
    do "$PM/`f'.do"
}
log close pm
if "`which'" == "check" display as result "CHECK DONE. Look at $PM_OUT/intake_report.csv, then run everything."
else display as result "DONE. Merged file: $PM_OUT/analysis_ready_with_roster.dta"
