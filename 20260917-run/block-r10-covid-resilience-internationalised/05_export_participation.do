/*==========================================================================
  R10-05  Did exporters, importers and foreign-owned firms keep exporting
          after COVID better than similar firms? For each group (put in the
          group ONCE from its own answers before COVID), the share of firms
          that export in each year's file, 2017-2022, next to the same lines
          for the firms of an earlier file followed through years without
          COVID (2010-2015, gray). Each panel prints the group's change in
          the share exporting minus that of firms of the same industry and
          province, against the last file before COVID ("2020-21 vs 2019")
          and against the three files before COVID together ("2020-21 vs
          2017-19", Bu Deasy's x Post2020), the same two numbers for the
          normal years, and COVID minus normal years.
  Answers Bu Deasy R10: "Were internationally integrated firms more
          resilient during COVID?" - outcome "export participation";
          strategy "Pre-2019 exporter/importer/FDI x Post2020" (the pooled
          term) and "Event study 2017-22 jika memungkinkan" (the yearly
          terms, in the regression table).
  Why the gray lines: the exporters' group is chosen because it exported
          in 2017-19, so its share is high in those years by construction
          and falls back later even without COVID. The gray lines (and the
          COVID minus normal number) show how large that fall-back is in
          normal years. Where the group was already moving apart before
          COVID, the number against 2017-19 carries that earlier change and
          does not measure COVID: read the number against 2019.
  2022    : the file asks about direct exports only (no firm answers "no" to
          export_flag; export_direct_flag holds the answers). 2022 is drawn
          dotted and left out of every printed number; a table-only version
          includes it. The file finds such years from the data.
  Blocks : "COVID COHORT AND STATES" (from R4-01) and "R10 FROZEN PRE-COVID
          GROUPS" (from R10-01) are copied unchanged from
          01_covid_cohort_groups.do; do not edit them here. They run twice:
          for the last file before COVID and for the normal-years file.
  Foreign-owned = 10% or more of the firm's capital held abroad
          (fdi_10_flag), the definition used in every R1-R10 exhibit.
  Output : figures/05_export_participation.png (+ .pdf)
           tables/05_export_participation.csv         (every plotted share)
           tables/05_export_participation_models.csv  (every estimate; the
                  numbers printed in the panels have in_figure = 1)
           tables/05_export_participation_table.pdf       (every plotted point)
           tables/05_export_participation_regression.pdf  (the models)
  Needs  : Stata add-ons reghdfe and ftools from SSC (reghdfe 6 also needs
           require), installed once (ssc install reghdfe, ssc install ftools,
           ssc install require); the file never installs anything and stops
           with a plain message if one is missing.
  Development data - obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
args data_arg outdir_arg        // optional: 00_run.do passes the two paths
clear all
set more off
set varabbrev off
set linesize 120
set type double                 // new variables keep full precision

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r10-covid-resilience-internationalised"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE DESIGN ------------------------------------------------------------
local covid_first 2020        // COVID reached Indonesia in March 2020: the first COVID-year file
local min_n       30          // a share is drawn only if at least 30 firms of the series answered
                              // the export question that year; a yearly difference is shown only
                              // if the group and the other firms each have 30 in that year and in
                              // the start file
local fname "05_export_participation"
* ---------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R10-05] STARTING: share of firms exporting around COVID, by group, with normal years ==="

* reghdfe (with ftools) runs regressions that take out many sets of averages at once
foreach p in reghdfe ftools {
    capture which `p'
    if _rc {
        display as error "R10-05 needs the Stata add-on `p'. Install it once: ssc install `p'  - then run this file again."
        log close
        exit 199
    }
}

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/9: load identity, industry, province, status flags and the export answers"
*---------------------------------------------------------------------------
* export_flag        = any export activity (1 yes, 0 no, missing = unknown)
* export_direct_flag = direct exports (1 yes, 0 no); asked in the files where the export
*                      question covers direct exports only (2022 in this file)
* import_flag        = imports reported above zero (never missing)
* fdi_10_flag        = 10% or more of capital held abroad (missing = unknown)
* industry2_reported, province_code = never change within a firm
* workers, gross_output_nominal = needed by the cohort block (not used here)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year export_flag export_direct_flag import_flag fdi_10_flag workers ///
    gross_output_nominal gross_output_real industry2_reported province_code
local have : list want & allvars          // gross_output_real: used by the cohort block when filled
use `have' using "$DATA", clear
isid firm_id year
capture confirm numeric variable export_direct_flag
if _rc gen byte export_direct_flag = .    // a file without the direct-export question
foreach v in export_flag export_direct_flag import_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}
assert !missing(industry2_reported, province_code)
* Files that ask about direct exports only: no firm answers "no" to export_flag, while
* export_direct_flag has answers. In those files the direct-export answer is used, drawn
* dotted and kept out of every printed number (the question changed).
quietly levelsof year, local(allfiles)
local dir_yrs ""
foreach y of local allfiles {
    quietly count if year == `y' & export_flag == 0
    local n_no = r(N)
    quietly count if year == `y' & !missing(export_direct_flag)
    if `n_no' == 0 & r(N) > 0 local dir_yrs "`dir_yrs' `y'"
}
local dir_yrs = strtrim("`dir_yrs'")
gen byte dir_only = 0
foreach y of local dir_yrs {
    quietly replace dir_only = 1 if year == `y'
    assert `y' >= `covid_first'               // groups use earlier files only
}
* outcome: 100 = exports, 0 = does not, missing = unknown answer (never counted as "no");
* a share of such values is a percentage and a difference is in percentage points
gen double ex = 100 * export_flag if !dir_only
replace ex = 100 * export_direct_flag if dir_only
display "   files asking about direct exports only: `dir_yrs'"
tempfile firmyear0
save `firmyear0'                          // the firm-year rows; the cohort block keeps one row per firm

*---------------------------------------------------------------------------
display "Step 2/9: the two start files (read from the data)"
*---------------------------------------------------------------------------
* COVID start file = the last annual file before 2020, followed in the next files.
* Normal-years start file (as R10-02): the latest file with two files before it whose
* next three files are the next three calendar years, all before 2020 (no missing year,
* no COVID year). Same code, same rules: it shows what the method gives without COVID.
local nfiles : word count `allfiles'
local covid_start ""
local bench_start ""
forvalues i = 1/`nfiles' {
    local c : word `i' of `allfiles'
    if `c' < `covid_first' local covid_start `c'
    if `i' >= 3 & `i' + 3 <= `nfiles' {
        local n1 : word `=`i' + 1' of `allfiles'
        local n3 : word `=`i' + 3' of `allfiles'
        if `n1' == `c' + 1 & `n3' == `c' + 3 & `n3' < `covid_first' local bench_start `c'
    }
}
assert "`covid_start'" != "" & "`bench_start'" != ""
display "   COVID start file `covid_start'; normal-years start file `bench_start'"

*---------------------------------------------------------------------------
display "Step 3/9: for each start file, its firms and their groups (blocks copied unchanged)"
*---------------------------------------------------------------------------
* The two blocks below are copied unchanged from R10-01 (the first from R4-01), with the
* lines between them. After them, keep the firm-year rows of the firms of the start file
* that were also in one of the two files before it (new_to_file == 0, R10's main sample).
tempfile panel
local first 1
foreach cohort_year in `covid_start' `bench_start' {
use `firmyear0', clear
capture label drop grp          // the group block defines this label; the loop runs it twice
*===========================================================================
* COVID COHORT AND STATES (copy exactly into later R4 and R10 files)
*   Version 2 - written and reviewed in R4-01 (28 Sep 2026). Do not edit a copy;
*   change R4-01 and re-copy. Set -local cohort_year- before the block; R4-02
*   runs it once per starting file (2012 ... 2019).
*   In : firm-year rows in memory (one row per firm and year): firm_id year
*        workers gross_output_nominal (gross_output_real is used instead when
*        present and filled for 95%+ of the cohort-file and last-file rows).
*        The block collapses to one row per firm: every other variable in memory
*        is dropped. Build traits in a tempfile first and merge them back by
*        firm_id after the block.
*   Out: one row per firm in the cohort file or in one of the next three files.
*        in_cohort = 1 for the firms of the cohort file (the cohort); the others
*        are newcomers (new_in_file = the later file they first appear in).
*        Locals: f1 f2 f3 = the next three files, p1 p2 = the two files before,
*        outbasis = output variable used, band_pct = neutral band in percent
*        (10 = within 10% either way), band_lo band_hi = its limits as ratios.
*   The years come from the data, so the block runs unchanged on the real files.
*===========================================================================
isid firm_id year
* -- the annual files in the data, and the files around the cohort file --
quietly levelsof year, local(c_files)
local c_pos : list posof "`cohort_year'" in c_files
local c_nf : word count `c_files'
if `c_pos' == 0 | `c_pos' + 3 > `c_nf' {
    display as error "cohort file `cohort_year' must be a file year with three later files"
    exit 198
}
local f1 : word `=`c_pos' + 1' of `c_files'
local f2 : word `=`c_pos' + 2' of `c_files'
local f3 : word `=`c_pos' + 3' of `c_files'
local p1 ""
local p2 ""
if `c_pos' > 1 local p1 : word `=`c_pos' - 1' of `c_files'
if `c_pos' > 2 local p2 : word `=`c_pos' - 2' of `c_files'
* -- output: constant prices when the file has them, else current prices --
local outbasis "gross_output_nominal"
capture confirm numeric variable gross_output_real
if !_rc {
    quietly count if inlist(year, `cohort_year', `f3')
    local c_nrows = r(N)
    quietly count if inlist(year, `cohort_year', `f3') & !missing(gross_output_real)
    if r(N) >= 0.95 * `c_nrows' & `c_nrows' > 0 local outbasis "gross_output_real"
}
* -- neutral band: a stayer is "about the same" if its last-file level is
*    within band_pct percent of its cohort-file level, up or down (10: 0.90 to 1.10 times);
*    the limits match the words on the chart ("down more than 10%") exactly --
if "`band_pct'" == "" local band_pct 10
local band_lo = 1 - `band_pct'/100
local band_hi = 1 + `band_pct'/100
* -- which files each firm is in (1 = in the file, 0 = not) --
gen byte c_base    = (year == `cohort_year')
gen byte c_f1      = (year == `f1')
gen byte c_f2      = (year == `f2')
gen byte c_f3      = (year == `f3')
gen byte c_earlier = (year <  `cohort_year')                    // any file before the cohort file
gen byte c_p1      = cond("`p1'" == "", ., (year == real("`p1'")))
gen byte c_p2      = cond("`p2'" == "", ., (year == real("`p2'")))
gen double c_wk0   = workers     if year == `cohort_year'
gen double c_wk3   = workers     if year == `f3'
gen double c_out0  = `outbasis'  if year == `cohort_year'
gen double c_out3  = `outbasis'  if year == `f3'
keep if year <= `f3'
collapse (max) seen_base = c_base seen_f1 = c_f1 seen_f2 = c_f2 seen_f3 = c_f3 ///
    seen_earlier = c_earlier seen_p1 = c_p1 seen_p2 = c_p2 ///
    workers_base = c_wk0 workers_f3 = c_wk3 output_base = c_out0 output_f3 = c_out3, by(firm_id)
keep if seen_base | seen_f1 | seen_f2 | seen_f3                  // firms of the cohort file or a later one
gen int  cohort_year = `cohort_year'
gen byte in_cohort   = (seen_base == 1)
* -- new_to_file = 1: in the cohort file but in neither of the two files before
*    (it may still be in an older file); 0 = "incumbent" (R10 uses 0 as incumbent) --
gen byte new_to_file = .
if "`p1'" != "" replace new_to_file = (seen_p1 == 0 & (seen_p2 == 0 | missing(seen_p2))) if in_cohort
* -- presence in the next three files, e.g. "110" = in f1 and f2, not in f3 --
gen str3 pattern = string(seen_f1) + string(seen_f2) + string(seen_f3) if in_cohort
* -- state by the last file (f3) --
*    1 stayed           = in all three later files
*    2 absent then back = missed f1 and/or f2, in f3 again ("temporary disappearance")
*    3 left the files   = not in f3 (the file has no closure record: not proof of closure)
gen byte state_file = cond(pattern == "111", 1, cond(seen_f3 == 1, 2, 3)) if in_cohort
*    left_when: 1 = gone from f1 on ("000"), 2 = in f1 or f2, gone by f3
gen byte left_when = cond(pattern == "000", 1, 2) if state_file == 3
* -- stayers: change from the cohort file to f3; 0 in f3 counts as shrank;
*    no positive cohort-file level (or no f3 level) = not classified (missing) --
gen double ratio_wk  = workers_f3 / workers_base if state_file == 1 & workers_base > 0 & !missing(workers_base, workers_f3)
gen double ratio_out = output_f3  / output_base  if state_file == 1 & output_base  > 0 & !missing(output_base,  output_f3)
foreach m in wk out {
    gen byte size_`m' = cond(ratio_`m' < `band_lo', 1, cond(ratio_`m' > `band_hi', 3, 2)) if !missing(ratio_`m')
    *   outcome5: 1 left the files, 2 absent then back, 3 shrank, 4 about the same, 5 grew
    gen byte outcome5_`m' = cond(state_file == 3, 1, cond(state_file == 2, 2, 2 + size_`m')) if in_cohort
    replace  outcome5_`m' = . if state_file == 1 & missing(size_`m')
}
* -- newcomers: the later file a firm not in the cohort file first appears in --
gen int new_in_file = cond(seen_f1, `f1', cond(seen_f2, `f2', `f3')) if !in_cohort
gen str80 outcome_basis = "`outbasis'"
label define c_state 1 "stayed" 2 "absent then back" 3 "left the files", replace
label define c_left  1 "gone from the first later file" 2 "gone later", replace
label define c_size  1 "shrank" 2 "about the same" 3 "grew", replace
label define c_out5  1 "left the files" 2 "absent then back" 3 "stayed, shrank" 4 "stayed, about the same" 5 "stayed, grew", replace
label values state_file c_state
label values left_when c_left
label values size_wk size_out c_size
label values outcome5_wk outcome5_out c_out5
* -- structural checks (hold on any data) --
isid firm_id
assert !missing(state_file, pattern) if in_cohort
assert missing(state_file) & !missing(new_in_file) if !in_cohort
assert (state_file == 1) == (pattern == "111") if in_cohort
assert !missing(outcome5_wk) if in_cohort & state_file != 1
order firm_id cohort_year in_cohort new_to_file seen_* pattern state_file left_when ///
    workers_base workers_f3 ratio_wk size_wk outcome5_wk output_base output_f3 ratio_out size_out ///
    outcome5_out new_in_file outcome_basis
display "   cohort file `cohort_year'; later files `f1' `f2' `f3'; earlier files `p2' `p1'; output: `outbasis'; band +/-`band_pct'%"
*===========================================================================
* END OF COVID COHORT AND STATES
*===========================================================================

* back to firm-year rows: attach the cohort markers to every record of each firm
keep firm_id in_cohort new_to_file pattern state_file left_when
tempfile cohort
save `cohort'
use `firmyear0', clear
merge m:1 firm_id using `cohort', keep(master match) nogenerate
replace in_cohort = 0 if missing(in_cohort)       // firms seen only before the cohort file

*===========================================================================
* R10 FROZEN PRE-COVID GROUPS (copy exactly into later R10 files)
*===========================================================================
* Needs: firm-year data with firm_id year export_flag import_flag fdi_10_flag,
* in_cohort and new_to_file, and the locals cohort_year p1 p2 from the cohort block
* (p1 = the file just before the cohort file, p2 = the one before that).
* Each firm is put in each group ONCE, from its own records in the files
* `p2', `p1' and `cohort_year' (the last file before COVID and the two before it).
* Answers from later files NEVER change a group.
*   main rule   : in the group (1) if it answered "yes" in at least half of its
*                 known answers in those files; other firms (0) = "yes" in fewer
*                 than half (most never said "yes"; e.g. yes in 1 of 3 = other);
*                 no known answer = left out (missing), never counted as "no".
*   stricter    : 1 only if "yes" in EVERY known answer; 0 only if never "yes";
*                 firms with both answers ("mixed") are left out (missing).
*   early files : main rule on the files `p2' and `p1' only (Bu Deasy's literal "pre-2019").
*   base file   : the answer in the `cohort_year' file only.
* Variable names: grp_<rule>_<x>, x = exp (export_flag), imp (import_flag),
* fdi (fdi_10_flag); rule = main, strict, early, base. Also k_<x> (known
* answers) and s_<x> (of which "yes") in the three files.
* Main sample of R10 = cohort firms that are not new to the file (new_to_file == 0):
* a firm first seen in `cohort_year' has only one year of answers and no earlier years.
if "`p1'" == "" | "`p2'" == "" {
    display as error "the groups need two files before the cohort file `cohort_year'"
    exit 198
}
local grp_rule_min 0.5
gen byte in_pre   = inlist(year, `p2', `p1', `cohort_year')
gen byte in_early = inlist(year, `p2', `p1')
foreach x in exp imp fdi {
    if "`x'" == "exp" local v export_flag
    if "`x'" == "imp" local v import_flag
    if "`x'" == "fdi" local v fdi_10_flag
    bysort firm_id: egen byte k_`x' = total(in_pre & !missing(`v'))
    bysort firm_id: egen byte s_`x' = total(in_pre & `v' == 1)
    gen byte grp_main_`x'   = s_`x' / k_`x' >= `grp_rule_min' if k_`x' > 0
    gen byte grp_strict_`x' = cond(k_`x' == 0, ., cond(s_`x' == k_`x', 1, cond(s_`x' == 0, 0, .)))
    bysort firm_id: egen byte ke = total(in_early & !missing(`v'))
    bysort firm_id: egen byte se = total(in_early & `v' == 1)
    gen byte grp_early_`x'  = se / ke >= `grp_rule_min' if ke > 0
    bysort firm_id: egen byte grp_base_`x' = max(cond(year == `cohort_year', `v', .))
    drop ke se
    * groups exist only for firms in the cohort; they are constant within a firm
    foreach r in main strict early base {
        replace grp_`r'_`x' = . if !in_cohort
        bysort firm_id: assert grp_`r'_`x' == grp_`r'_`x'[1]
    }
    replace k_`x' = . if !in_cohort
    replace s_`x' = . if !in_cohort
}
drop in_pre in_early
label define grp 1 "in the group" 0 "other firms"
label values grp_* grp
*===========================================================================
* END R10 FROZEN PRE-COVID GROUPS
*===========================================================================
* ---- keep the start file's firms also in one of the two files before, their files p2 to f3 ----
local s = cond(`cohort_year' == `covid_start', 1, 2)      // 1 = COVID years, 2 = normal years
keep if in_cohort & new_to_file == 0 & inrange(year, `p2', `f3')
gen byte section = `s'
gen byte stayer  = (state_file == 1)        // in every later file (a table-only check)
keep firm_id year section stayer ex dir_only industry2_reported province_code ///
    grp_main_exp grp_main_imp grp_main_fdi
foreach q in p2 p1 f1 f2 f3 {
    local `q'_`s' ``q''
}
local start_`s' `cohort_year'
if !`first' append using `panel'
save `panel', replace
local first 0
}
* the files of each section: two before the start file, the start file, three after
forvalues s = 1/2 {
    local win_`s' "`p2_`s'' `p1_`s'' `start_`s'' `f1_`s'' `f2_`s'' `f3_`s''"
    local pre_`s' "`p2_`s'' `p1_`s''"
}
* later files in the printed numbers. COVID years: the later files before the first
* direct-only file. Normal years: the same number of later files after its start file,
* so both numbers cover the same distance from their start file.
local post_1 ""
local stop 0
foreach q in f1 f2 f3 {
    local yy ``q'_1'
    local isdir : list yy in dir_yrs
    if `isdir' local stop 1
    if !`stop' local post_1 "`post_1' `yy'"
}
local post_1 = strtrim("`post_1'")
local npost : word count `post_1'
assert `npost' >= 1
local post_2 ""
forvalues k = 1/`npost' {
    local post_2 "`post_2' `f`k'_2'"
}
local post_2 = strtrim("`post_2'")
forvalues s = 1/2 {
    local mw_`s' "`pre_`s'' `start_`s'' `post_`s''"      // the files of the main models
}
foreach y of local win_2 {
    local isdir : list y in dir_yrs
    assert !`isdir'                                        // the normal years keep one question
}
local lastmain : word `npost' of `post_1'
assert `f3_2' < `p2_1'                                     // the two windows do not overlap
use `panel', clear
egen int ind  = group(industry2_reported)
egen int prov = group(province_code)
save `panel', replace
forvalues s = 1/2 {
    quietly count if section == `s' & year == `start_`s''
    local nf_`s' = r(N)                                    // firms of the start file (one row each)
    quietly summarize grp_main_imp if section == `s' & year == `start_`s'', meanonly
    local impsh_`s' = strtrim(string(100 * r(mean), "%9.0f"))
}
display "   COVID years: `nf_1' firms, files `win_1', printed numbers use `post_1'"
display "   normal years: `nf_2' firms, files `win_2', printed numbers use `post_2'"

*---------------------------------------------------------------------------
display "Step 4/9: share exporting per group and file (the lines)"
*---------------------------------------------------------------------------
* Share = firms that export / firms of the series in that file with a known answer, in %.
* Firms that left the files are not in the later files; an unknown answer is left out.
* 95% interval (table only): Wilson interval for a share.
tempname pf
tempfile shr
postfile `pf' byte(section gi) str8 grouping byte grp int year byte pos byte(dir_only drawn) ///
    double(n_infile n_known n_yes pct ci_lo ci_hi) using `shr', replace
forvalues s = 1/2 {
    local gi 0
    foreach x in exp imp fdi {
        local ++gi
        foreach g in 1 0 {
            local pp 0
            foreach y of local win_`s' {
                local ++pp
                quietly count if section == `s' & grp_main_`x' == `g' & year == `y'
                local nin = r(N)
                quietly count if section == `s' & grp_main_`x' == `g' & year == `y' & !missing(ex)
                local N = r(N)
                quietly count if section == `s' & grp_main_`x' == `g' & year == `y' & ex == 100
                local n = r(N)
                local lo .
                local hi .
                if `N' > 0 {
                    quietly cii proportions `N' `n', wilson
                    local lo = 100 * r(lb)
                    local hi = 100 * r(ub)
                }
                local isdir : list y in dir_yrs
                post `pf' (`s') (`gi') ("`x'") (`g') (`y') (`pp' - 3) (`isdir') (`N' >= `min_n') ///
                    (`nin') (`N') (`n') (cond(`N' > 0, 100 * `n' / `N', .)) (`lo') (`hi')
            }
        }
    }
}
postclose `pf'

*---------------------------------------------------------------------------
display "Step 5/9: regressions: group x each file (start file = reference), pooled, COVID minus normal"
*---------------------------------------------------------------------------
* Model (linear probability): exports (100 or 0) = firm's own average + one average per
* industry and file + one per province and file + the group's extra change in each file,
* against the start file:
*   b_year = (group's change in % exporting since the start file) - (other firms' change),
*   in percentage points.
* Versions: covid  = COVID start file, files p2 to the last file before the direct-only file
*           normal = normal-years start file, the same number of files after it
*           with22 = covid plus the direct-only file(s) (table only)
*           stay   = covid, firms in every later file only (table only)
*           fy     = covid, firm + year averages only (table only)
* Printed in each panel: the average of the covid (and normal) markers after the start file
* (against the start file alone), the pooled term (Bu Deasy's "x Post2020": group x every
* later file, against the start file and the two before together; its own regression, same
* rows), and COVID minus normal (both start files in one model; errors clustered by firm).
local versions "covid normal stay fy"
if "`dir_yrs'" != "" local versions "covid normal with22 stay fy"
tempname P
tempfile res
postfile `P' byte section str8 grouping str8 version str20 term int year byte pos double(b se df_r) ///
    long(rows firms singletons n_g1 n_g0 ref_g1 ref_g0 firms_g1 firms_g0) double before_p using `res', replace
foreach x in exp imp fdi {
    display "   group `x'"
    foreach v of local versions {
        local s = cond("`v'" == "normal", 2, 1)
        local wl "`mw_`s''"
        if "`v'" == "with22" local wl "`win_1'"
        local sf `start_`s''
        use `panel', clear
        keep if section == `s' & !missing(grp_main_`x', ex)
        gen byte inw = 0
        foreach y of local wl {
            quietly replace inw = 1 if year == `y'
        }
        keep if inw
        if "`v'" == "stay" keep if stayer
        gen double X = grp_main_`x'
        local terms ""
        local pre_terms ""
        local lc ""
        local np 0
        foreach y of local wl {
            if `y' != `sf' {
                gen double t`y' = X * (year == `y')
                local terms "`terms' t`y'"
                if `y' < `sf' local pre_terms "`pre_terms' t`y'"
                else {
                    local lc "`lc' + t`y'"
                    local ++np
                }
            }
        }
        gen double tpost = X * (year > `sf')
        local ab "firm_id ind#year prov#year"
        if "`v'" == "fy" local ab "firm_id year"
        * --- year by year ---
        quietly reghdfe ex `terms', absorb(`ab') vce(cluster firm_id)
        capture drop es
        gen byte es = e(sample)
        local N  = e(N)
        local G  = e(N_clust)
        local df = e(df_r)
        local S  = e(num_singletons)
        if "`S'" == "" local S 0
        * before-start check: the markers before the start file are 0 together
        capture test `pre_terms'
        local bp = cond(_rc, ., r(p))
        * average of the markers after the start file
        quietly lincom (`=substr("`lc'", 4, .)') / `np'
        local ab_ = r(estimate)
        local as_ = r(se)
        * firms behind each marker: group (X = 1) and other firms (X = 0)
        quietly count if es & year == `sf' & X == 1
        local r1 = r(N)
        quietly count if es & year == `sf' & X == 0
        local r0 = r(N)
        capture drop ft
        egen byte ft = tag(firm_id) if es
        quietly count if ft == 1 & X == 1
        local fg1 = r(N)
        quietly count if ft == 1 & X == 0
        local fg0 = r(N)
        foreach y of local wl {
            if `y' == `sf' continue
            local pp : list posof "`y'" in win_`s'
            quietly count if es & year == `y' & X == 1
            local n1 = r(N)
            quietly count if es & year == `y' & X == 0
            local n0 = r(N)
            capture local sechk = _se[t`y']
            if _rc local sechk = .
            if `sechk' == 0 | missing(`sechk') {
                post `P' (`s') ("`x'") ("`v'") ("`y'") (`y') (`pp' - 3) (.) (.) (`df') (`N') (`G') (`S') ///
                    (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp')
            }
            else {
                post `P' (`s') ("`x'") ("`v'") ("`y'") (`y') (`pp' - 3) (_b[t`y']) (_se[t`y']) (`df') (`N') (`G') ///
                    (`S') (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp')
                if inlist("`v'", "covid", "normal") local bk_`x'_`y' = _b[t`y']
            }
        }
        post `P' (`s') ("`x'") ("`v'") ("avgpost") (.) (.) (`ab_') (`as_') (`df') (`N') (`G') (`S') ///
            (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp')
        if inlist("`v'", "covid", "normal") local ba_`x'_`s' = `ab_'
        * --- pooled term (Bu Deasy's "x Post2020"), same rows ---
        quietly reghdfe ex tpost if es, absorb(`ab') vce(cluster firm_id)
        assert e(N) == `N'
        * singletons: those the yearly model dropped (the pooled model runs on its rows, so it drops none)
        post `P' (`s') ("`x'") ("`v'") ("pooled") (.) (.) (_b[tpost]) (_se[tpost]) (e(df_r)) (e(N)) ///
            (e(N_clust)) (`S') (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp')
    }
    * --- COVID minus normal years: both start files in one model ---
    * The two windows share no file, so the industry x file and province x file averages are
    * separate by start file; a firm in both start files gets one average per start file (fs)
    * and one cluster (firm_id). Same markers as the two separate models (checked below).
    use `panel', clear
    keep if !missing(grp_main_`x', ex)
    gen byte inw = 0
    forvalues s = 1/2 {
        foreach y of local mw_`s' {
            quietly replace inw = 1 if section == `s' & year == `y'
        }
    }
    keep if inw
    egen long fs = group(section firm_id)
    gen double X = grp_main_`x'
    local terms ""
    local lc1 ""
    local lc2 ""
    forvalues s = 1/2 {
        foreach y of local mw_`s' {
            if `y' != `start_`s'' {
                gen double t`y' = X * (year == `y' & section == `s')
                local terms "`terms' t`y'"
                if `y' > `start_`s'' local lc`s' "`lc`s'' + t`y'"
            }
        }
    }
    quietly reghdfe ex `terms', absorb(fs ind#year prov#year) vce(cluster firm_id)
    forvalues s = 1/2 {
        foreach y of local mw_`s' {
            if `y' != `start_`s'' & "`bk_`x'_`y''" != "" assert abs(_b[t`y'] - `bk_`x'_`y'') < 1e-6
        }
    }
    local S3 = e(num_singletons)
    if "`S3'" == "" local S3 0
    local N3 = e(N)
    local G3 = e(N_clust)
    local df3 = e(df_r)
    quietly lincom (`=substr("`lc1'", 4, .)') / `npost' - (`=substr("`lc2'", 4, .)') / `npost'
    assert abs(r(estimate) - (`ba_`x'_1' - `ba_`x'_2')) < 1e-6
    post `P' (3) ("`x'") ("diff") ("covid_minus_normal") (.) (.) (r(estimate)) (r(se)) (`df3') (`N3') ///
        (`G3') (`S3') (.) (.) (.) (.) (.) (.) (.)
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 6/9: tables -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
* (1) the shares drawn as lines
use `shr', clear
gen str20 section_name = cond(section == 1, "COVID years", "Normal years")
gen int start_file = cond(section == 1, `start_1', `start_2')
gen str30 grouping_label = cond(gi == 1, "Exporters", cond(gi == 2, "Importers", "Foreign-owned (10%+)"))
gen str20 group_label = cond(grp == 1, "In the group", "Other firms")
gen str60 on_chart = ""
replace on_chart = cond(section == 1, "black line", "gray line") + cond(grp == 1, ", solid", ", dashed") ///
    if drawn & !dir_only
replace on_chart = "dotted, square (direct exports only)" if drawn & dir_only
replace on_chart = "not drawn: fewer than `min_n' firms answered" if !drawn
gen str80 note = ""
replace note = "Share of direct exporters: the question asks about direct exports only" if dir_only
replace note = "Outside the printed numbers (they use the first `npost' later files)" ///
    if section == 2 & pos > `npost' & note == ""
* structural checks
assert n_yes <= n_known & n_known <= n_infile
assert inrange(pct, 0, 100) if !missing(pct)
assert ci_lo <= pct + 1e-9 & pct <= ci_hi + 1e-9 if !missing(pct)
sort gi section grp year
order section section_name start_file grouping grouping_label grp group_label year pos dir_only ///
    n_infile n_known n_yes pct ci_lo ci_hi drawn on_chart note
format pct ci_lo ci_hi %6.2f
format n_infile n_known n_yes %9.0f
export delimited section-note using "tables/`fname'.csv", datafmt replace
list section grouping grp year n_known n_yes pct drawn, noobs sepby(section grouping grp) abbreviate(24)
tempfile shares
save `shares'

* (2) every estimate; the printed numbers have in_figure = 1
use `res', clear
* reference rows (0 by definition) for the yearly versions
preserve
keep if term == "avgpost"
gen int sf = cond(section == 1, `start_1', `start_2')
replace term = string(sf)
replace year = sf
replace pos = 0
replace b = 0
replace se = .
replace n_g1 = ref_g1
replace n_g0 = ref_g0
drop sf
tempfile refrows
save `refrows'
restore
append using `refrows'
gen byte yearly = !missing(year)
gen byte reference = yearly & pos == 0
* support: a yearly difference is shown only if the group and the other firms each have
* min_n firms in that year and in the start file
gen byte shown = !missing(b) & ((n_g1 >= `min_n' & n_g0 >= `min_n' & ref_g1 >= `min_n' & ref_g0 >= `min_n') ///
    | !yearly)
gen double tcrit = invttail(df_r, 0.025)
gen double lo = b - tcrit * se if shown & !reference
gen double hi = b + tcrit * se if shown & !reference
gen double p  = 2 * ttail(df_r, abs(b / se)) if shown & se > 0 & !missing(se)
gen byte clear = lo > 0 | hi < 0 if !missing(lo)
gen byte gi = cond(grouping == "exp", 1, cond(grouping == "imp", 2, 3))
gen str30 grouping_label = cond(gi == 1, "Exporters", cond(gi == 2, "Importers", "Foreign-owned (10%+)"))
local pf1 : word 1 of `post_1'
local post_rng  = cond(`npost' == 1, "`pf1'", "`pf1'–" + substr("`lastmain'", 3, 2))
local bpost_l : word `npost' of `post_2'
local bf1 : word 1 of `post_2'
local bpost_rng = cond(`npost' == 1, "`bf1'", "`bf1'–" + substr("`bpost_l'", 3, 2))
local pool_rng  = "`p2_1'–" + substr("`start_1'", 3, 2)
local bpool_rng = "`p2_2'–" + substr("`start_2'", 3, 2)
local w22_rng   = "`: word 1 of `post_1''–" + substr("`f3_1'", 3, 2)
gen str80 version_label = ""
replace version_label = "COVID years: `start_1' firms, files `p2_1'-`lastmain'; firm + industry x year + province x year" if version == "covid"
replace version_label = "Normal years: `start_2' firms, files `p2_2'-`bpost_l'; firm + industry x year + province x year" if version == "normal"
replace version_label = "COVID years with `dir_yrs' (direct exports only), files `p2_1'-`f3_1'" if version == "with22"
replace version_label = "COVID years, firms in every file `f1_1'-`f3_1' only" if version == "stay"
replace version_label = "COVID years, firm + year averages only" if version == "fy"
replace version_label = "COVID years minus normal years (one model, both start files)" if version == "diff"
gen str80 period = ""
replace period = "year " + term if yearly
replace period = "reference: " + term + " (0 by definition)" if reference
replace period = "average of the markers after the start file, against the start file" if term == "avgpost"
replace period = "pooled: group x the later files, against the start file and the two before" if term == "pooled"
replace period = "average `post_rng' vs `start_1' minus average `bpost_rng' vs `start_2'" if term == "covid_minus_normal"
gen str60 on_chart = "table only"
replace on_chart = "printed, line 1 (right)" if version == "covid" & term == "avgpost"
replace on_chart = "printed, line 2 (right): x Post2020" if version == "covid" & term == "pooled"
replace on_chart = "printed, gray line (left)" if version == "normal" & term == "avgpost"
replace on_chart = "printed, line 2 (left)" if version == "diff"
gen byte in_figure = on_chart != "table only"
gen str120 note = ""
replace note = "Fewer than `min_n' firms of a group in this year or in the start file: left empty" ///
    if !shown & !missing(b) & yearly
replace note = "No rows in this file for this version (not estimable)" if missing(b) & yearly
replace note = "Its own regression on the rows of the yearly model" if term == "pooled"
* structural checks
assert b == 0 if reference
assert lo <= b + 1e-9 & b <= hi + 1e-9 if !missing(lo)
assert n_g1 <= firms_g1 & n_g0 <= firms_g0 if !missing(n_g1)
gen byte vorder = cond(version == "covid", 1, cond(version == "normal", 2, cond(version == "with22", 3, ///
    cond(version == "stay", 4, cond(version == "fy", 5, 6)))))
gen int torder = cond(yearly, pos, cond(term == "avgpost", 91, cond(term == "pooled", 92, 93)))
sort gi vorder torder
order grouping grouping_label version version_label term period year pos reference in_figure on_chart ///
    shown b se df_r p lo hi clear n_g1 n_g0 ref_g1 ref_g0 firms_g1 firms_g0 rows firms singletons before_p note
format b se lo hi %9.4f
format p before_p %6.4f
format df_r rows firms singletons n_g* ref_g* firms_g* %9.0f
export delimited grouping-note using "tables/`fname'_models.csv", datafmt replace
list grouping version term b lo hi clear n_g1 n_g0 if inlist(version, "covid", "normal", "diff"), ///
    noobs sepby(grouping version) abbreviate(24)
list grouping version before_p firms_g1 firms_g0 rows singletons if term == "pooled", noobs sepby(grouping) abbreviate(24)
tempfile ctsrc
save `ctsrc'

*---------------------------------------------------------------------------
display "Step 7/9: numbers for the panel texts and notes, read from the tables (never typed)"
*---------------------------------------------------------------------------
capture program drop r10_pts
program define r10_pts, rclass
    * whole percentage points with a sign and a true minus: +12, −3, 0
    args v
    local r = round(`v')
    local sg = cond(`r' > 0, "+", cond(`r' < 0, "−", ""))
    return local s "`sg'`=string(abs(`r'), "%9.0f")'"
end
local olab1 "exporters"
local olab2 "importers"
local olab3 "foreign-owned firms"
local apart ""
local n_apart 0
forvalues g = 1/3 {
    quietly count if gi == `g' & version == "covid" & yearly & pos < 0 & clear == 1
    local flag_`g' = r(N) > 0
    if r(N) > 0 {
        local ++n_apart
        local apart "`apart'; `olab`g''"
    }
    * v1 = COVID years vs the start file, v2 = pooled (x Post2020), v3 = normal years vs
    * their start file, v4 = COVID minus normal years
    local k 0
    foreach vt in "covid avgpost" "covid pooled" "normal avgpost" "diff covid_minus_normal" {
        local ++k
        gettoken vv tt : vt
        local tt = strtrim("`tt'")
        foreach q in b lo hi {
            quietly summarize `q' if gi == `g' & version == "`vv'" & term == "`tt'", meanonly
            r10_pts `=r(mean)'
            local `q'_ `r(s)'
        }
        local v`k'_`g' "`b_' (`lo_' to `hi_')"
    }
    local pt1_`g' "`post_rng' vs `start_1': `v1_`g''"
    local pt2_`g' "`post_rng' vs `pool_rng': `v2_`g''"
    local ptA_`g' "Normal years, `bpost_rng' vs `start_2': `v3_`g''"
    local ptB_`g' "COVID minus normal years: `v4_`g''"
    local pt3_`g' = cond(`flag_`g'', "Already apart before COVID", "")
    * "mostly also seen in normal years": the COVID-years number (against the start file)
    * is clearly away from 0, the normal-years number too, with the same sign and at least
    * half its size, and COVID minus normal years is not: the change is mostly the
    * fall-back also seen without COVID (for exporters: chosen for exporting before)
    foreach vt in "covid avgpost 1" "normal avgpost 3" "diff covid_minus_normal 4" {
        local vv : word 1 of `vt'
        local tt : word 2 of `vt'
        local kk : word 3 of `vt'
        quietly summarize b if gi == `g' & version == "`vv'" & term == "`tt'", meanonly
        local bb`kk' = r(mean)
        quietly summarize clear if gi == `g' & version == "`vv'" & term == "`tt'", meanonly
        local cl`kk' = r(mean)
    }
    local fb_`g' = (`cl1' == 1 & `cl3' == 1 & `cl4' == 0 & sign(`bb1') == sign(`bb3') & abs(`bb3') >= 0.5 * abs(`bb1'))
    local ptF_`g' = cond(`fb_`g'', "Mostly also seen in normal years: fall-back, not COVID", "")
    display "   panel `g': `ptA_`g'' | `ptB_`g'' | `pt1_`g'' | `pt2_`g'' | `pt3_`g''"
}
local apart = substr("`apart'", 3, .)
display "   groups already apart before COVID: `n_apart' (`apart')"
local pre_txt = subinstr("`pre_1'", " ", " or ", .)
local n1s = strtrim(string(`nf_1', "%9.0fc"))
local n2s = strtrim(string(`nf_2', "%9.0fc"))

*---------------------------------------------------------------------------
display "Step 8/9: three panels (one per grouping), black = COVID years, gray = normal years"
*---------------------------------------------------------------------------
use `shares', clear
gen double yv = pct if drawn & !dir_only                    // solid and dashed lines
gen double ydot = .                                         // dotted: last main file to the direct-only file
if "`dir_yrs'" != "" replace ydot = pct if section == 1 & drawn & (dir_only | year == `lastmain')
gen double ysq = pct if section == 1 & drawn & dir_only     // hollow squares
* endpoint labels: first and last drawn point of each line, and the direct-only points
bysort section gi grp: egen int fyr = min(cond(!missing(yv), year, .))
by section gi grp: egen int lyr = max(cond(!missing(yv), year, .))
gen str8 lab = string(round(pct), "%9.0f") if !missing(yv) & (year == fyr | year == lyr)
replace lab = string(round(pct), "%9.0f") if !missing(ysq)
gen byte lpos = .
replace lpos = 9 if section == 2 & year == fyr & lab != ""
replace lpos = 3 if section == 2 & year == lyr & lab != ""
replace lpos = cond(grp == 1, 12, 6) if section == 1 & lab != "" & !dir_only
replace lpos = cond(grp == 1, 2, 4) if !missing(ysq)       // right, apart when close
gen double ylab = pct if lab != ""
* calendar years without an annual file inside the axis (drawn as a gray band)
local xfirst `p2_2'
local xlast  `f3_1'
local nofile ""
forvalues y = `xfirst'/`xlast' {
    local isin : list y in allfiles
    if !`isin' local nofile "`nofile' `y'"
}
local nnf : word count `nofile'
* per panel: the gray band(s), the COVID line and the five text lines (above the lines)
local ytop 100
local ty1 = `ytop' + 0.52 * `ytop'
local ty2 = `ytop' + 0.35 * `ytop'
local ty3 = `ytop' + 0.18 * `ytop'
local yroof = `ytop' + 0.58 * `ytop'
local xl = `xfirst' - 0.6
local xr = `xlast' + 0.8
local xtr = `p2_1' - 0.30                                  // right text block starts here
local n0 = _N
local nex = 3 * max(`nnf', 1)
set obs `=_N + `nex''
foreach v in bx by0 by1 cx cy0 cy1 txl txr ty1 ty2 ty3 {
    gen double `v' = .
}
foreach v in tA tB tF t1 t2 t3 {
    gen str80 `v' = ""
}
local r = `n0'
forvalues g = 1/3 {
    forvalues k = 1/`=max(`nnf', 1)' {
        local ++r
        quietly replace gi = `g' in `r'
        if `nnf' > 0 {
            quietly replace bx  = `: word `k' of `nofile'' in `r'
            quietly replace by0 = 0 in `r'
            quietly replace by1 = `ytop' in `r'
        }
        if `k' == 1 {
            quietly replace cx  = `start_1' + 0.5 in `r'
            quietly replace cy0 = 0 in `r'
            quietly replace cy1 = `ytop' in `r'
            quietly replace txl = `xl' + 0.1 in `r'
            quietly replace txr = `xtr' in `r'
            quietly replace ty1 = `ty1' in `r'
            quietly replace ty2 = `ty2' in `r'
            quietly replace ty3 = `ty3' in `r'
            quietly replace tA = "`ptA_`g''" in `r'
            quietly replace tB = "`ptB_`g''" in `r'
            quietly replace tF = "`ptF_`g''" in `r'
            quietly replace t1 = "`pt1_`g''" in `r'
            quietly replace t2 = "`pt2_`g''" in `r'
            quietly replace t3 = "`pt3_`g''" in `r'
        }
    }
}
label define gi 1 "(a) Exporters vs other firms" 2 "(b) Importers vs other firms" ///
    3 "(c) Foreign-owned (10%+) vs other firms", replace
label values gi gi
sort gi section grp year
* Notes: one text, wrapped into lines of at most 104 characters (PDF text runs wider than the PNG)
local dirtxt ""
if "`dir_yrs'" != "" local dirtxt "`dir_yrs' asks about direct exports only: dotted, outside the printed numbers (with `dir_yrs': regression table)."
if `n_apart' > 0 local aparttxt "Already apart before COVID (a `pre_txt' difference clearly away from 0): `apart'. There the group was already moving away from similar firms before COVID, so the `pool_rng' number includes that earlier change and does not measure COVID: read the `start_1' number."
else local aparttxt "No difference before COVID is clearly away from 0 (only `: word count `pre_1'' earlier files: weak evidence of equal paths)."
local ntext "Notes: Lines = % exporting among firms answering the export question. Black: `n1s' firms of the `start_1' file also in `p2_1' or `p1_1', grouped once from their `pool_rng' answers (yes in at least half of known answers; none known = left out); gray: the same for `n2s' firms of `start_2', in normal years. Printed, % points (95% interval; crossing 0 = no clear difference): the group's change since the start file minus that of similar firms (same industry, province); `post_rng' vs `pool_rng' = Bu Deasy's ×~Post2020. `aparttxt' Exporters were chosen for exporting in `pool_rng', so their share falls back even without COVID (gray lines); COVID minus normal years takes that out. `dirtxt' Importers: `impsh_1'% of `start_1' firms, `impsh_2'% of `start_2' firms (imports recorded differently later). Under `min_n' answering: not drawn. Association, not the effect of COVID. Firm links are fictional in the development data: following a firm means nothing here."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 104 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
local notelines : subinstr local notelines "~" " ", all      // "~" keeps words together; prints as a space
display `"   note lines: `notelines'"'
local nfkey ""
if `nnf' > 0 local nfkey `"1 "No annual file (`=strtrim("`nofile'")')""'
local dirkey ""
if "`dir_yrs'" != "" local dirkey `"9 "`dir_yrs': direct exports only (question changed)""'
local xlab ""
forvalues y = `xfirst'/`xlast' {
    local xlab "`xlab' `y'"
}
* Stata draws markers about twice as large in the PNG as in the PDF, so each file gets its own
* marker size (same data, same layout)
foreach out in png pdf {
    local msz = cond("`out'" == "png", "vsmall", "small")
    twoway (rbar by0 by1 bx, barwidth(0.8) fcolor(gs14) lcolor(gs14) lwidth(none)) ///
        (rspike cy0 cy1 cx, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
        (connected yv year if section == 2 & grp == 1, sort(year) cmissing(n) lcolor(gs9) lpattern(solid) ///
            lwidth(medthin) msymbol(T) mcolor(gs9) msize(`msz')) ///
        (connected yv year if section == 2 & grp == 0, sort(year) cmissing(n) lcolor(gs9) lpattern(shortdash) ///
            lwidth(medthin) msymbol(Th) mcolor(gs9) msize(`msz')) ///
        (connected yv year if section == 1 & grp == 1, sort(year) cmissing(n) lcolor(black) lpattern(solid) ///
            lwidth(medthin) msymbol(O) mcolor(black) msize(`msz')) ///
        (connected yv year if section == 1 & grp == 0, sort(year) cmissing(n) lcolor(black) lpattern(shortdash) ///
            lwidth(medthin) msymbol(Oh) mcolor(black) msize(`msz')) ///
        (line ydot year if section == 1 & grp == 1, sort(year) cmissing(n) lcolor(black) lpattern(dot) lwidth(medthin)) ///
        (line ydot year if section == 1 & grp == 0, sort(year) cmissing(n) lcolor(black) lpattern(dot) lwidth(medthin)) ///
        (scatter ysq year, msymbol(Sh) mcolor(black) msize(`msz')) ///
        (scatter ylab year if section == 1, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(0.6) ///
            mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ylab year if section == 2, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(0.6) ///
            mlabsize(vsmall) mlabcolor(gs7)) ///
        (scatter ty1 txl, msymbol(none) mlabel(tA) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs7)) ///
        (scatter ty2 txl, msymbol(none) mlabel(tB) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty3 txl, msymbol(none) mlabel(tF) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty1 txr, msymbol(none) mlabel(t1) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty2 txr, msymbol(none) mlabel(t2) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty3 txr, msymbol(none) mlabel(t3) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
        by(gi, cols(1) imargin(small) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+2)) ///
            legend(pos(6)) ///
            title("Figure R10-05. Share of firms exporting around COVID: exporters, importers and" ///
                  "foreign-owned firms vs other firms; gray = the same in normal years (no COVID)", ///
                  size(small) pos(11) span) ///
            note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
        subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
        yscale(range(0 `yroof') noline) ///
        ylabel(0(20)`ytop', angle(0) format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
        ytitle("% of firms answering that export", size(vsmall)) ///
        xscale(range(`xl' `xr') noline) xlabel(`xlab', noticks tlength(0) labsize(vsmall) nogrid) ///
        xtitle("Year of the survey file", size(vsmall)) ///
        legend(order(5 "`start_1' firms: in the group" 6 "`start_1' firms: other firms" ///
                     3 "`start_2' firms (normal years, no COVID): in the group" 4 "`start_2' firms: other firms" ///
                     `dirkey' 2 "COVID (from March `covid_first')" `nfkey') ///
            cols(2) region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(6) rowgap(0.3)) ///
        plotregion(style(none)) xsize(8) ysize(12.5)
    if "`out'" == "png" graph export "figures/`fname'.png", width(2400) replace
    else graph export "figures/`fname'.pdf", replace
}

*---------------------------------------------------------------------------
display "Step 9/9: companion tables: every plotted point, and the regression table"
*---------------------------------------------------------------------------
* ==== COMPANION TABLE (pattern for all exhibits) =============================
* Owner rule, 28 Sep 2026: every chart gets a table of every plotted point, and
* every chart of regression coefficients also gets a regression table, written
* by the same do-file (spec: TABLE_BRIEF.md). This step runs AFTER the graph
* export, so the chart and the CSV stay byte-identical.
*
* How to use it in another exhibit file:
*   PART 1 (the writer, program ctable_pdf) is copied UNCHANGED.
*   PART 2 is the only exhibit-specific part: put the numbers in memory (the
*   tempfile saved right after the CSV export, or the CSV itself), build one
*   STRING variable per table column, one row per plotted point in chart order
*   (years not drawn included, with the reason in a status column), then call
*   ctable_pdf. Format numbers with string(x, "%9.1f") etc. so the table shows
*   exactly the rounding of the chart labels.
*
* ctable_pdf strvars using "tables/NN_name_table.pdf",
*     title("Table R1-02. ...: every plotted point")    first line, bold
*     header("Col 1" "Col 2" ...)       one text per column; "|" = line break
*     [right(numlist)]                  columns right-aligned (numbers)
*     [norepeat(numlist)]               columns whose repeated text is shown
*                                       only on the first row of a run
*     [rules(numlist)]                  thin gray line under these data rows
*     [notes("line 1" "line 2" ...)]    footer paragraphs (Notes, Source, dev line)
*     [subtitle(text)] [fontsize(#)] [perpage(#)] [landscape|portrait]
* Landscape is chosen automatically when there are more than 6 columns. Long
* tables continue on a new page with the header repeated ("(continued)"); a page
* never breaks inside a block whose first column is empty (e.g. an SE row).
* --- PART 1: the writer (identical in every file; do not edit) ---------------
capture program drop ctable_pdf
program define ctable_pdf
    version 17
    syntax varlist(string) using/, TItle(string) HEADer(string asis) ///
        [RIGHT(numlist integer >0) NOREPeat(numlist integer >0) RULES(numlist integer >0) ///
         NOTEs(string asis) SUBtitle(string) FONTsize(real 9.5) PERpage(integer 0) ///
         LANDscape PORTrait]
    local nc : word count `varlist'
    local nh : word count `header'
    if `nh' != `nc' {
        display as error "ctable_pdf: `nc' columns but `nh' header texts"
        exit 198
    }
    local orient = cond(`nc' > 6, "landscape", "")
    if "`landscape'" != "" local orient "landscape"
    if "`portrait'"  != "" local orient ""
    * rows per page: a conservative guess for 9-10 pt text (wrapped cells take more)
    if `perpage' == 0 local perpage = cond("`orient'" == "landscape", 24, 40)
    preserve
    quietly {
        keep `varlist'
        rename (`varlist') (__c#), addnumber      // __c1 __c2 ... in the order given
        forvalues j = 1/`nc' {
            replace __c`j' = strtrim(__c`j')
        }
        local N = _N
        gen long row = _n
        * page chunks: fill up to perpage rows; prefer to end a page at a rule,
        * never start a page on a row whose first column is empty
        gen int chunk = .
        local start 1
        local k 0
        while `start' <= `N' {
            local ++k
            local end = min(`start' + `perpage' - 1, `N')
            if `end' < `N' {
                local best 0
                foreach r of local rules {
                    if `r' >= `start' + floor(`perpage' / 2) & `r' <= `end' & `r' > `best' local best `r'
                }
                if `best' > 0 local end `best'
                else {
                    while `end' > `start' & __c1[`end' + 1] == "" {
                        local --end
                    }
                }
            }
            replace chunk = `k' in `start'/`end'
            local start = `end' + 1
        }
        local nk `k'
        * blank repeated labels inside each page; a column is blanked only while the
        * norepeat columns to its left are unchanged too (a new panel shows its series)
        gen byte same = _n > 1 & chunk == chunk[_n - 1]
        foreach j of local norepeat {
            gen strL o`j' = __c`j'
            replace same = same & o`j' == o`j'[_n - 1]
            replace __c`j' = "" if same
            drop o`j'
        }
        drop same
        * column widths (% of the page), from the longest text in each column;
        * long text columns are capped so they wrap instead of squeezing numbers
        matrix W = J(1, `nc', 0)
        local tot 0
        forvalues j = 1/`nc' {
            gen long L`j' = udstrlen(__c`j')
            summarize L`j', meanonly
            local w = max(r(max), 3)
            local h : word `j' of `header'
            local h = subinstr(`"`h'"', "|", " ", .)
            foreach hw of local h {
                local w = max(`w', udstrlen(`"`hw'"'))
            }
            local w = min(`w', 34) + 2          // + 2 = room for the cell margins
            matrix W[1, `j'] = `w'
            local tot = `tot' + `w'
            drop L`j'
        }
        local used 0
        forvalues j = 1/`nc' {
            if `j' < `nc' {
                matrix W[1, `j'] = max(floor(100 * W[1, `j'] / `tot'), 3)
                local used = `used' + W[1, `j']
            }
            else matrix W[1, `j'] = 100 - `used'
        }
    }
    putpdf clear
    putpdf begin, pagesize(A4) `orient' font("Times New Roman", `fontsize') ///
        margin(left, 0.8in) margin(right, 0.8in) margin(top, 0.5in) margin(bottom, 0.5in)
    forvalues k = 1/`nk' {
        if `k' > 1 putpdf pagebreak
        putpdf paragraph, spacing(after, 4pt)
        local tt = cond(`k' == 1, `"`title'"', `"`title' (continued)"')
        putpdf text (`"`tt'"'), bold font("Times New Roman", `=`fontsize' + 1.5')
        if `k' == 1 & `"`subtitle'"' != "" {
            putpdf paragraph, spacing(after, 4pt)
            putpdf text (`"`subtitle'"')
        }
        quietly count if chunk == `k'
        local nr = r(N) + 1
        quietly putpdf table T`k' = data(__c1-__c`nc') if chunk == `k', varnames border(all, nil) width(W)
        forvalues j = 1/`nc' {
            * header text; "|" starts a new line inside the cell
            local rest : word `j' of `header'
            local opt ""
            while `"`rest'"' != "" {
                gettoken part rest : rest, parse("|")
                if `"`part'"' == "|" {
                    putpdf table T`k'(1, `j') = (""), linebreak append
                    continue
                }
                putpdf table T`k'(1, `j') = (`"`part'"'), valign(bottom) `opt'
                local opt "append"
            }
            local al = cond(`: list j in right', "right", "left")
            putpdf table T`k'(., `j'), halign(`al') margin(top, 0pt) margin(bottom, 0pt)
        }
        putpdf table T`k'(1, .), border(top, single, black) border(bottom, single, black)
        putpdf table T`k'(`nr', .), border(bottom, single, black)
        foreach r of local rules {
            quietly summarize row if chunk == `k', meanonly
            if `r' >= r(min) & `r' < r(max) {
                putpdf table T`k'(`=`r' - r(min) + 2', .), border(bottom, single, "A6A6A6")
            }
        }
    }
    local first 1
    foreach n of local notes {
        putpdf paragraph, spacing(before, `=cond(`first', 6, 1)'pt)
        putpdf text (`"`n'"'), font("Times New Roman", `=`fontsize' - 0.5')
        local first 0
    }
    putpdf save `"`using'"', replace
    restore
end
* --- end of PART 1 ------------------------------------------------------------
* --- PART 2: the rows of this exhibit (the only part that changes per file) ---
* Sources: the two tables saved right after the CSV exports (full precision, same run
* as the chart).
* (1) Points table: per panel, the gray lines (group, other firms), the year with no file,
*     the black lines (group, other firms), then the numbers printed in the panel.
use `shares', clear
quietly count if drawn
local n_drawn = r(N)                   // every drawn point of every line
gen byte srow = cond(section == 2, cond(grp == 1, 1, 2), cond(grp == 1, 4, 5))
local nfrows 0
foreach y of local nofile {
    forvalues g = 1/3 {
        local ++nfrows
        set obs `=_N + 1'
        quietly replace gi = `g' in l
        quietly replace year = `y' in l
        quietly replace srow = 3 in l
    }
}
gen str70 t_series = ""
replace t_series = "`start_2' firms: in the group (gray, solid)" if srow == 1
replace t_series = "`start_2' firms: other firms (gray, dashed)" if srow == 2
replace t_series = "No annual file (gray band)" if srow == 3
replace t_series = "`start_1' firms: in the group (black, solid)" if srow == 4
replace t_series = "`start_1' firms: other firms (black, dashed)" if srow == 5
gen str40 t_pos = string(year)
gen str12 t_v  = string(pct, "%9.1f") if !missing(pct)
gen str12 t_lo = string(ci_lo, "%9.1f") if !missing(ci_lo)
gen str12 t_hi = string(ci_hi, "%9.1f") if !missing(ci_hi)
gen str16 t_n  = string(n_known, "%12.0fc") if !missing(n_known)
gen str16 t_y  = string(n_yes, "%12.0fc") if !missing(n_yes)
gen str80 t_status = ""
replace t_status = "drawn" if drawn == 1 & !dir_only
replace t_status = "drawn; not in the printed numbers" if drawn == 1 & section == 2 & pos > `npost'
replace t_status = "drawn: dotted, hollow square (direct exports only)" if drawn == 1 & dir_only
replace t_status = "not drawn: fewer than `min_n' firms answered" if drawn == 0
replace t_status = "not drawn: no annual file" if srow == 3
keep gi srow year t_*
tempfile ptrows
save `ptrows'
* the numbers printed in each panel (whole points, as on the chart)
use `ctsrc', clear
keep if in_figure
gen byte srow = cond(version == "normal", 6, cond(version == "diff", 7, cond(term == "avgpost", 8, 9)))
gen str70 t_series = ""
replace t_series = "Printed, left (gray): normal years" if srow == 6
replace t_series = "Printed, left: COVID minus normal years" if srow == 7
replace t_series = "Printed, right: COVID years" if srow == 8
replace t_series = "Printed, right: × Post2020 (Bu Deasy)" if srow == 9
gen str40 t_pos = ""
replace t_pos = "`bpost_rng' vs `start_2'" if srow == 6
replace t_pos = "difference of the two" if srow == 7
replace t_pos = "`post_rng' vs `start_1'" if srow == 8
replace t_pos = "`post_rng' vs `pool_rng'" if srow == 9
foreach q in b lo hi {
    gen str12 s_`q' = ""
    forvalues i = 1/`=_N' {
        r10_pts `=`q'[`i']'
        quietly replace s_`q' = "`r(s)'" in `i'
    }
}
rename (s_b s_lo s_hi) (t_v t_lo t_hi)
gen str16 t_n = string(firms_g1, "%12.0fc") + " / " + string(firms_g0, "%12.0fc") if srow != 7
replace t_n = string(firms, "%12.0fc") if srow == 7
gen str16 t_y = ""
gen str80 t_status = ""
replace t_status = "printed, left line 1 (whole points)" if srow == 6
replace t_status = "printed, left line 2 (whole points)" if srow == 7
replace t_status = "printed, right line 1 (whole points)" if srow == 8
replace t_status = "printed, right line 2 (whole points)" if srow == 9
replace year = .                        // printed numbers have no single year
keep gi srow year t_*
append using `ptrows'
* the "Already apart before COVID" text, where printed
forvalues g = 1/3 {
    if `flag_`g'' {
        set obs `=_N + 1'
        quietly replace gi = `g' in l
        quietly replace srow = 10 in l
        quietly replace t_series = "Printed, right: text" in l
        quietly replace t_pos = "`pre_txt'" in l
        quietly replace t_status = "printed, right line 3: Already apart before COVID" in l
    }
}
forvalues g = 1/3 {
    if `fb_`g'' {
        set obs `=_N + 1'
        quietly replace gi = `g' in l
        quietly replace srow = 11 in l
        quietly replace t_series = "Printed, left: text" in l
        quietly replace t_pos = "`post_rng' vs normal years"  in l
        quietly replace t_status = "printed, left line 3: Mostly also seen in normal years" in l
    }
}
local pl1 "(a) Exporters"
local pl2 "(b) Importers"
local pl3 "(c) Foreign-owned (10%+)"
gen str40 t_panel = ""
forvalues g = 1/3 {
    replace t_panel = "`pl`g''" if gi == `g'
}
foreach v of varlist t_* {
    replace `v' = "" if `v' == "."
}
assert t_status != ""
* check: every drawn point and every printed number is in the table once
quietly count if strpos(t_status, "drawn") == 1
assert r(N) == `n_drawn'
quietly count if strpos(t_status, "printed") == 1 & srow < 10
assert r(N) == 12
sort gi srow year
local nrows = _N
local rl ""
forvalues i = 1/`=_N - 1' {
    if gi[`i'] != gi[`i' + 1] local rl "`rl' `i'"
}
local tnote "Table: every point of Figure R10-05, panel by panel. Lines: one decimal (the chart labels the first and last point, whole), 95% Wilson"
local tnote "`tnote' interval (not drawn). Printed numbers: whole points as on the chart; firms = group / other firms in the model (difference: all firms)."
local ntab : subinstr local ntext "~" " ", all
order t_panel t_series t_pos t_v t_lo t_hi t_n t_y t_status
ctable_pdf t_panel t_series t_pos t_v t_lo t_hi t_n t_y t_status using "tables/`fname'_table.pdf", ///
    title("Table R10-05. Share of firms exporting around COVID, by group, with normal years (no COVID): every plotted point") ///
    subtitle("Lines: % of firms answering that export. Printed numbers: group minus similar firms, percentage points") ///
    header("Panel" "Series" "Year" "%|or points" "95%|low" "95%|high" "Firms|answering" "Of which|export" "Status") ///
    right(4 5 6 7 8) norepeat(1 2) rules(`rl') perpage(32) fontsize(7.5) ///
    notes("`ntab'" "`tnote'" "`srcnote' `devnote'")
display "table -> tables/`fname'_table.pdf (`nrows' rows; `n_drawn' drawn points, 12 printed numbers)"

* (2) Regression table (AER style): coefficient on the first line, (standard error) on the
* second, in percentage points. One panel per group; columns = the models.
use `ctsrc', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'_models.csv", clear varnames(1) stringcols(1 3 5)
keep grouping version term b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 grouping version term using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
local cols "covid normal"
if "`dir_yrs'" != "" local cols "`cols' with22"
local cols "`cols' stay fy"
local nc : word count `cols'
local hdr `"" ""'
local c 0
foreach v of local cols {
    local ++c
    if "`v'" == "covid"  local hdr `"`hdr' "(`c')|COVID years""'
    if "`v'" == "normal" local hdr `"`hdr' "(`c')|Normal years|(no COVID)""'
    if "`v'" == "with22" local hdr `"`hdr' "(`c')|COVID years|with `dir_yrs'""'
    if "`v'" == "stay"   local hdr `"`hdr' "(`c')|COVID years|stayers""'
    if "`v'" == "fy"     local hdr `"`hdr' "(`c')|COVID years|firm + year""'
}
local tv ""
forvalues c = 1/`nc' {
    local tv "`tv' t`c'"
}
tempname Q
tempfile R
postfile `Q' str70 t_lab str24(`tv') using `R', replace
local nterm 0
local rl ""
local plab1 "Panel A. Exporters"
local plab2 "Panel B. Importers"
local plab3 "Panel C. Foreign-owned (10%+)"
local empty ""
forvalues c = 1/`nc' {
    local empty `"`empty' ("")"'
}
capture program drop r10_num
program define r10_num, rclass
    * a number with 2 decimals and a true minus
    args v
    local s = string(`v', "%9.2f")
    return local s = subinstr("`s'", "-", "−", 1)
end
forvalues g = 1/3 {
    post `Q' ("`plab`g''") `empty'
    local ++nterm
    foreach tm in -2 -1 0 1 2 3 avgpost pooled covid_minus_normal {
        local l1 ""
        local l2 ""
        local any 0
        foreach v of local cols {
            if inlist("`tm'", "avgpost", "pooled") local cond `"term == "`tm'""'
            else if "`tm'" == "covid_minus_normal" local cond `"term == "`tm'""'
            else local cond "yearly & pos == `tm'"
            local vv "`v'"
            if "`tm'" == "covid_minus_normal" & "`v'" == "covid" local vv "diff"
            quietly count if gi == `g' & version == "`vv'" & `cond'
            if r(N) == 0 {
                local l1 `"`l1' ("")"'
                local l2 `"`l2' ("")"'
                continue
            }
            local any 1
            quietly summarize b if gi == `g' & version == "`vv'" & `cond', meanonly
            local bb = r(mean)
            quietly summarize se if gi == `g' & version == "`vv'" & `cond', meanonly
            local ss = r(mean)
            if "`tm'" == "0" {
                local l1 `"`l1' ("—")"'
                local l2 `"`l2' ("")"'
            }
            else if missing(`bb') {
                local l1 `"`l1' ("n.a.")"'
                local l2 `"`l2' ("")"'
            }
            else {
                r10_num `bb'
                local l1 `"`l1' ("`r(s)'")"'
                local l2 `"`l2' ("(`=string(`ss', "%9.2f")')")"'
            }
        }
        if !`any' continue
        if "`tm'" == "avgpost" local lab "Average after the start file"
        else if "`tm'" == "pooled" local lab "Pooled × Post"
        else if "`tm'" == "covid_minus_normal" local lab "COVID minus normal: (1) − (2)"
        else {
            local y1 : word `=`tm' + 3' of `win_1'
            local y2 : word `=`tm' + 3' of `win_2'
            local lab "Group × `y1' [`y2']"
            if "`tm'" == "0" local lab "Group × `y1' [`y2'] (reference)"
        }
        post `Q' ("`lab'") `l1'
        local ++nterm
        if "`tm'" != "0" {
            post `Q' ("") `l2'
            local ++nterm
        }
    }
    * whole-model rows (the yearly model of each column)
    foreach st in before_p rows firms firms_g1 {
        local ll ""
        foreach v of local cols {
            quietly summarize `st' if gi == `g' & version == "`v'" & term == "avgpost", meanonly
            if "`st'" == "before_p" local cv = cond(missing(r(mean)), "n.a.", cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f")))
            else local cv = string(r(mean), "%12.0fc")
            local ll `"`ll' ("`cv'")"'
        }
        if "`st'" == "before_p" local lab "Before-start test, p"
        if "`st'" == "rows"     local lab "Observations"
        if "`st'" == "firms"    local lab "Firms (clusters)"
        if "`st'" == "firms_g1" local lab "Firms in the group"
        post `Q' ("`lab'") `ll'
        local ++nterm
    }
    local rl "`rl' `nterm'"
}
* design rows, the same for every panel
foreach d in files firm indyr provyr yr sample wgt clu {
    local ll ""
    foreach v of local cols {
        if "`d'" == "files"  local cv = cond("`v'" == "normal", "`bpost_rng' vs `start_2'", cond("`v'" == "with22", "`w22_rng' vs `start_1'", "`post_rng' vs `start_1'"))
        if "`d'" == "firm"   local cv "Yes"
        if "`d'" == "indyr"  local cv = cond("`v'" == "fy", "No", "Yes")
        if "`d'" == "provyr" local cv = cond("`v'" == "fy", "No", "Yes")
        if "`d'" == "yr"     local cv = cond("`v'" == "fy", "Yes", "In ind. × year")
        if "`d'" == "sample" local cv = cond("`v'" == "stay", "Stayers", "All firms")
        if "`d'" == "wgt"    local cv "None"
        if "`d'" == "clu"    local cv "Firm"
        local ll `"`ll' ("`cv'")"'
    }
    if "`d'" == "files"  local lab "Later files vs start file"
    if "`d'" == "firm"   local lab "Firm FE"
    if "`d'" == "indyr"  local lab "Industry × year FE"
    if "`d'" == "provyr" local lab "Province × year FE"
    if "`d'" == "yr"     local lab "Year FE"
    if "`d'" == "sample" local lab "Sample"
    if "`d'" == "wgt"    local lab "Weights"
    if "`d'" == "clu"    local lab "SE clustered by"
    post `Q' ("`lab'") `ll'
}
postclose `Q'
use `R', clear
local rnote "Notes: Each column is one linear probability regression of exporting (100 = exports, 0 = does not; firms with a known answer)"
local rnote "`rnote' on the group times each file except the start file (the reference, set to 0), with the fixed effects listed. Rows name the"
local rnote "`rnote' COVID-years file; [ ] = the file of column (2). Firms: the `n1s' firms of the `start_1' file also in the `p2_1' or `p1_1' file,"
local rnote "`rnote' grouped once from their `pool_rng' answers (in the group if yes in at least half of the known answers; no known answer = left out);"
local rnote "`rnote' column (2): the `n2s' firms of the `start_2' file, grouped from `bpool_rng', in normal years (no COVID). Average = mean of the markers"
local rnote "`rnote' after the start file, against the start file alone. Pooled × Post = the same model with one term, group × every later file (Bu Deasy's"
local rnote "`rnote' × Post2020), against the start file and the two before together (its own regression, same rows); where the markers before the"
local rnote "`rnote' start file are away from 0 (small before-start p) it includes that earlier change; the average does not. COVID minus normal"
local rnote "`rnote' = the average of (1) minus that of (2), from one model with both start files (a firm in both has one average per start file; errors clustered by firm)."
if "`dir_yrs'" != "" local rnote "`rnote' Column (3) adds `dir_yrs', whose question covers direct exports only (the answer used there), so its `dir_yrs' marker mixes a change of question with the change of firms."
local rnote "`rnote' Stayers = firms in every file `f1_1'–`f3_1'. Blank = file not in that model. FE = fixed effects (averages taken out)."
local rnote "`rnote' Singleton firms dropped by reghdfe. No stars."
ctable_pdf t_lab `tv' using "tables/`fname'_regression.pdf", ///
    title("Table R10-05, regression. Share of firms exporting around COVID: the models behind the printed numbers") ///
    subtitle("Coefficient in percentage points; (standard error, clustered by firm).") ///
    header(`hdr') right(`=substr("2 3 4 5 6 7", 1, 2 * `nc' - 1)') rules(`rl') portrait fontsize(9) perpage(48) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
