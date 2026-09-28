/*==========================================================================
  R10-06  Do the answers of R10-02 to R10-05 hold under other choices? The
          two printed numbers of each exhibit - the group minus similar
          firms after COVID against the last file before COVID ("vs 2019")
          and against the three files before COVID together ("vs 2017-19",
          Bu Deasy's x Post2020) - recomputed with: firm + year averages
          only; other firms reweighted so that before COVID they look like
          the group (entropy balancing); three other group rules; firms new
          in 2019 added; other samples (all firms in the files, the R10-04
          what-if counting leavers as closed, firms in every file); and the
          same method in normal years (2012 firms followed 2013-2015, a
          "placebo COVID"). Table only: a longer look-back (2013-2015 added
          as files before COVID).
  Answers Bu Deasy R10: "Were internationally integrated firms more
          resilient during COVID?" - "Pre-2019 exporter/importer/FDI x
          Post2020" (how firm the answer is to the choices made), for the
          outcomes "survival, output, employment, productivity, export
          participation".
  Main rows: the numbers printed in R10-02 (still in the files), R10-03
          (output, workers, value added per worker: firms in every later
          file), R10-05 (exporting: 2020-21, because 2022 asks about direct
          exports only). The file rebuilds them with the same code and, when
          those exhibits' CSVs are in tables/, stops if any differs.
  Reweighting: entropy balancing (Hainmueller 2012), written out in Mata
          (R1-10's code, block-r1 10_reweighted_frozen_groups.do), so no
          add-on is needed. Each other firm gets one weight, as close to
          equal as possible, such that the weighted other firms match the
          group's own 2017-19 averages of workers, output and value added per
          worker (logs), its shares in the other two groups, and its
          industry and island mix.
  Blocks : "COVID COHORT AND STATES" (from R4-01) and "R10 FROZEN PRE-COVID
          GROUPS" (from R10-01) are copied unchanged from
          01_covid_cohort_groups.do; do not edit them here. They run twice:
          for the last file before COVID and for the normal-years file.
  Foreign-owned = 10% or more of the firm's capital held abroad
          (fdi_10_flag), the definition used in every R1-R10 exhibit.
  Output : figures/06_robustness_reweighted_rules.png (+ .pdf)
           tables/06_robustness_reweighted_rules.csv          (every estimate;
                  the figure uses the rows with in_figure = 1)
           tables/06_robustness_reweighted_rules_balance.csv  (before-COVID
                  averages, group vs other firms, before and after weighting)
           tables/06_robustness_reweighted_rules_table.pdf      (every plotted point)
           tables/06_robustness_reweighted_rules_regression.pdf (every model drawn,
                  and the look-back version)
  Needs  : Stata add-ons reghdfe and ftools from SSC (reghdfe 6 also needs
           require), installed once (ssc install reghdfe, ssc install ftools,
           ssc install require); the file never installs anything and stops
           with a plain message if one is missing.
  Runtime: about 1-2 minutes on the development file (about 300 regressions).
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
local min_n       30          // a version is drawn only if the group and the other firms each have at
                              // least 30 firms in the reference file (the start file) of its model
local min_worth   30          // ... and, reweighted, the other firms of that file are worth 30+ firms (as R1-10)
local lb_n        3           // look-back version: this many more files before the three used (table only)
local eb_tol      1e-6        // reweighting: balance is reached when every weighted gap is below a
local eb_maxit    500         // millionth of a spread; at most this many Newton steps (as R1-10)
local fname "06_robustness_reweighted_rules"
* ---------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R10-06] STARTING: the printed numbers of R10-02 to R10-05 under other choices ==="

* reghdfe (with ftools) runs regressions that take out many sets of averages at once
foreach p in reghdfe ftools {
    capture which `p'
    if _rc {
        display as error "R10-06 needs the Stata add-on `p'. Install it once: ssc install `p'  - then run this file again."
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
display "Step 1/10: load identity, industry, province, status flags, the outcomes and the export answers"
*---------------------------------------------------------------------------
* export_flag        = any export activity (1 yes, 0 no, missing = unknown)
* export_direct_flag = direct exports (1 yes, 0 no); asked in the files where the export
*                      question covers direct exports only (2022 in this file)
* import_flag        = imports reported above zero (never missing)
* fdi_10_flag        = 10% or more of capital held abroad (missing = unknown)
* gross_output_nominal = output value, current prices (masked money unit); the file has
*                no price index filled in (gross_output_real is empty)
* value_added_nominal  = output value minus materials, energy and services bought
* workers      = persons employed
* industry2_reported, province_code = never change within a firm
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year export_flag export_direct_flag import_flag fdi_10_flag workers ///
    gross_output_nominal gross_output_real value_added_nominal industry2_reported province_code
local have : list want & allvars          // gross_output_real: used by the cohort block when filled
use `have' using "$DATA", clear
isid firm_id year
capture confirm numeric variable export_direct_flag
if _rc gen byte export_direct_flag = .    // a file without the direct-export question
foreach v in export_flag export_direct_flag import_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}
assert !missing(industry2_reported, province_code)
* Files that ask about direct exports only (as R10-05): no firm answers "no" to export_flag,
* while export_direct_flag has answers. There the direct-export answer is used; those files
* are kept out of the export numbers (the question changed).
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
* exporting: 100 = exports, 0 = does not, missing = unknown answer (never counted as "no")
gen double ex = 100 * export_flag if !dir_only
replace ex = 100 * export_direct_flag if dir_only
display "   files asking about direct exports only: `dir_yrs'"
tempfile firmyear0
save `firmyear0'                          // the firm-year rows; the cohort block keeps one row per firm

*---------------------------------------------------------------------------
display "Step 2/10: the two start files (read from the data)"
*---------------------------------------------------------------------------
* COVID start file = the last annual file before 2020, followed in the next files.
* Normal-years start file (as R10-02 and R10-05): the latest file with two files before it
* whose next three files are the next three calendar years, all before 2020 (no missing
* year, no COVID year). Same code, same rules: it shows what the method gives without COVID.
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
display "Step 3/10: for each start file, its firms and their groups under every rule (blocks copied unchanged)"
*---------------------------------------------------------------------------
* The two blocks below are copied unchanged from R10-01 (the first from R4-01), with the
* lines between them. After them, keep the firm-year rows of every firm of the start file
* (also the firms new to it: one version adds them).
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
* ---- keep every firm of the start file (incumbents and firms new to it), its files ----
local s = cond(`cohort_year' == `covid_start', 1, 2)      // 1 = COVID years, 2 = normal years
local lo `p2'
local lb_`s' ""
if `s' == 1 {
    * look-back version (table only): up to lb_n more files before p2
    local before ""
    foreach c of local allfiles {
        if `c' < `p2' local before "`before' `c'"
    }
    local nb : word count `before'
    forvalues i = `=max(1, `nb' - `lb_n' + 1)'/`nb' {
        local lb_`s' "`lb_`s'' `: word `i' of `before''"
    }
    local lb_`s' = strtrim("`lb_`s''")
    if "`lb_`s''" != "" local lo : word 1 of `lb_`s''
}
keep if in_cohort & inrange(year, `lo', `f3')
gen byte section = `s'
gen byte stayer  = (state_file == 1)        // in every later file
gen double outv  = `outbasis'               // output as chosen by the cohort block
local ob_`s' "`outbasis'"
keep firm_id year section new_to_file stayer state_file left_when pattern grp_main_* grp_strict_* ///
    grp_early_* grp_base_* ex dir_only workers outv value_added_nominal industry2_reported province_code
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
* exporting (as R10-05): COVID years use the later files before the first direct-only file;
* normal years the same number of later files after their start file
local post_1 ""
local stop 0
foreach q in f1 f2 f3 {
    local yy ``q'_1'
    local isdir : list yy in dir_yrs
    if `isdir' local stop 1
    if !`stop' local post_1 "`post_1' `yy'"
}
local post_1 = strtrim("`post_1'")
local npost_ex : word count `post_1'
assert `npost_ex' >= 1
local post_2 ""
forvalues k = 1/`npost_ex' {
    local post_2 "`post_2' `f`k'_2'"
}
local post_2 = strtrim("`post_2'")
forvalues s = 1/2 {
    local mw_`s' "`pre_`s'' `start_`s'' `post_`s''"      // the files of the export models
}
foreach y of local win_2 {
    local isdir : list y in dir_yrs
    assert !`isdir'                                        // the normal years keep one question
}
assert `f3_2' < `p2_1'                                     // the two windows do not overlap
local out_prices = cond("`ob_1'" == "gross_output_real", "constant prices", "current prices")
use `panel', clear
egen int ind  = group(industry2_reported)
egen int prov = group(province_code)
* island group from the province code's first digit (BPS numbering, as R1-10): 1-2 = Sumatra
* (21 = Riau Islands), 3 = Java, 5-9 = the other islands (a firm with no province code gets
* no island and is left out of the reweighting, counted)
gen byte island = cond(inlist(substr(province_code, 1, 1), "1", "2"), 1, cond(substr(province_code, 1, 1) == "3", 2, 3)) ///
    if province_code != ""
display "   COVID years: files `win_1' (look-back files: `lb_1'); exports use `mw_1'"
display "   normal years: files `win_2'; exports use `mw_2'"

*---------------------------------------------------------------------------
display "Step 4/10: the outcomes (as in R10-02 to R10-05)"
*---------------------------------------------------------------------------
* 1 still in the files (R10-02): one row per firm, below
* 2 output, 3 workers, 4 value added per worker: logs, so a difference reads as a % difference
*   (zero or missing = not used; as R10-03)
* 5 exporting: 100 or 0, unknown answer = missing (as R10-05)
gen double y2 = ln(outv) if outv > 0 & !missing(outv)
gen double y3 = ln(workers) if workers > 0 & !missing(workers)
gen double y4 = ln(value_added_nominal / workers) ///
    if value_added_nominal > 0 & workers > 0 & !missing(value_added_nominal, workers)
gen double y5 = ex
compress
save `panel', replace
forvalues s = 1/2 {
    egen byte ft = tag(firm_id) if section == `s' & new_to_file == 0
    quietly count if ft == 1
    local n_inc_`s' = r(N)
    quietly count if ft == 1 & stayer
    local n_stay_`s' = r(N)
    drop ft
    egen byte ft = tag(firm_id) if section == `s' & new_to_file == 1
    quietly count if ft == 1
    local n_new_`s' = r(N)
    drop ft
}
display "   `start_1' file: `n_inc_1' firms also in `p2_1' or `p1_1' (`n_stay_1' in every file `f1_1'-`f3_1'), `n_new_1' new"
display "   `start_2' file: `n_inc_2' firms also in `p2_2' or `p1_2' (`n_stay_2' in every file `f1_2'-`f3_2'), `n_new_2' new"

* (1) still in the files, one row per firm of each start file (R10-02's code): still in k files
* later = in that file or a later one (a firm that misses a file and comes back was still there)
keep if (section == 1 & year == `start_1') | (section == 2 & year == `start_2')
isid section firm_id
forvalues k = 1/3 {
    gen byte infile_`k' = substr(pattern, `k', 1) == "1"
}
gen byte still_1 = infile_1 | infile_2 | infile_3
gen byte still_2 = infile_2 | infile_3
gen byte still_3 = infile_3
assert (still_1 == 0) == (left_when == 1)
assert (still_3 == 0) == (state_file == 3)
keep section firm_id new_to_file stayer ind prov island grp_* still_*
tempfile firms
save `firms'

* (2) R10-04's what-if (its code): firms of the COVID start file also in p2 or p1, one row for
* every file p2 to f3; a firm not in a later file and in none after it counts as CLOSED from
* that file on (output and workers 0). Other added rows (absent, then back) are dropped.
* Outcome: change from the firm's own start-file level on the midpoint scale, in %:
*   200 x (level - start level) / (level + start level), -200 = fell to 0.
use `panel', clear
keep if section == 1 & new_to_file == 0 & inrange(year, `p2_1', `f3_1')
keep firm_id year workers outv ind prov stayer state_file grp_main_exp grp_main_imp grp_main_fdi
fillin firm_id year
foreach v in ind prov stayer state_file grp_main_exp grp_main_imp grp_main_fdi {
    bysort firm_id (_fillin year): replace `v' = `v'[1]     // firm traits never change: copy them
}
bysort firm_id: egen int last_seen = max(cond(_fillin == 0, year, .))
gen byte closed = _fillin & year > `start_1' & year > last_seen
drop if _fillin & !closed
assert closed == 0 if stayer
bysort firm_id: egen byte cl_last = max(closed & year == `f3_1')
assert cl_last == (state_file == 3)
drop cl_last _fillin
local outname2 "outv"
local outname3 "workers"
forvalues k = 2/3 {
    bysort firm_id: egen double base`k' = max(cond(year == `start_1', `outname`k'', .))
    gen double lev`k' = cond(closed, 0, `outname`k'')
    gen double y`k' = 200 * (lev`k' - base`k') / (lev`k' + base`k') ///
        if base`k' > 0 & !missing(base`k') & (closed | (lev`k' > 0 & !missing(lev`k')))
    assert y`k' == -200 if closed & !missing(y`k')
    assert y`k' == 0 if year == `start_1' & !missing(y`k')
}
egen byte ft = tag(firm_id)
quietly count if ft & state_file == 3
local n_left = r(N)
drop ft
tempfile cldata
save `cldata'

*---------------------------------------------------------------------------
display "Step 5/10: weights: other firms made to match each group before COVID (entropy balancing)"
*---------------------------------------------------------------------------
* Balancing measures, from each firm's own records in the files p2 to the start file (before
* COVID only), records with output, value added and workers above zero; logs, so a few very
* large firms do not dominate: m1 workers, m2 output, m3 value added per worker. Also the
* firm's other two groups (0/100: 100 = known to be in that group; an unknown export answer
* is not a target of its own - with it, importers could not be balanced), industry and island.
* Two sets per grouping: all firms of the COVID start file also in p2 or p1
* (for "still in the files" and exporting) and the firms in every later file (for output,
* workers and value added per worker, whose main sample they are).
use `panel', clear
keep if section == 1 & new_to_file == 0
gen byte cv = inrange(year, `p2_1', `start_1') & outv > 0 & value_added_nominal > 0 & workers > 0 ///
    & !missing(outv, value_added_nominal, workers)
bysort firm_id: egen double m1 = mean(cond(cv, ln(workers), .))
bysort firm_id: egen double m2 = mean(cond(cv, ln(outv), .))
bysort firm_id: egen double m3 = mean(cond(cv, ln(value_added_nominal / workers), .))
egen byte firm1 = tag(firm_id)
keep if firm1
keep firm_id ind island m1 m2 m3 stayer grp_main_exp grp_main_imp grp_main_fdi
tempfile firmdata
save `firmdata'

* ---- Entropy balancing, written out (Hainmueller 2012) -----------------------------------
mata:
// C = the other firms' balancing measures (one row per firm); m = the group's averages (targets).
// Returns one weight per other firm (adding up to 1). The weights are as close to equal weights
// as possible (smallest "entropy" distance) while the weighted averages C'w equal m exactly.
// They take the form w = exp(Z*lam) / sum(exp(Z*lam)) with Z = (C - m) / spread, one lam per
// measure; lam is found by Newton steps that minimise ln(sum(exp(Z*lam))) (the "dual" problem),
// whose slope is exactly the remaining weighted gap. Done when every gap is below tol spreads.
real colvector r110eb(real matrix C, real rowvector m, real scalar tol, real scalar maxit)
{
    real matrix Z, H
    real colvector lam, e, w, step
    real rowvector s, g
    real scalar it, L, Lnew, a, top
    s   = sqrt(diagonal(variance(C)))'       // each measure's spread among the other firms
    Z   = (C :- m) :/ s                       // distance from the group's average, in spreads
    lam = J(cols(Z), 1, 0)                    // start from equal weights
    for (it = 0; it <= maxit; it++) {
        e   = Z * lam
        top = max(e)                          // (taking out the largest avoids overflow in exp)
        w   = exp(e :- top)
        L   = ln(sum(w)) + top                // the dual: what the Newton steps make smaller
        w   = w / sum(w)
        g   = w' * Z                          // remaining weighted gap per measure (= the slope)
        if (max(abs(g)) < tol) break
        H   = (Z :* w)' * Z - g' * g          // curvature = weighted spread of Z
        step = -cholsolve(H, g')
        if (hasmissing(step)) step = -pinv(H) * g'
        a = 1                                 // halve the step until the dual falls enough
        while (a > 1e-12) {
            e    = Z * (lam + a * step)
            top  = max(e)
            Lnew = ln(sum(exp(e :- top))) + top
            if (Lnew <= L + 1e-4 * a * (g * step)) break
            a = a / 2
        }
        if (a <= 1e-12) break                 // no further progress possible (rounding): stop here
        lam = lam + a * step
    }
    st_numscalar("r110_iter", it)
    st_numscalar("r110_gap", max(abs(g)))
    return(w)
}
end

tempname hb
tempfile balance
postfile `hb' str8 grouping str4 sample str12 measure double(mean_g mean_o mean_ow sd_pool std_before std_after) ///
    long(firms_g1 firms_g0 drop_g1 drop_g0 drop_nomeas iter) double(worth_g0 wmax_ratio gap_max) byte balanced ///
    using `balance', replace
foreach x in exp imp fdi {
    foreach ws in all stay {
        use `firmdata', clear
        keep if !missing(grp_main_`x')
        if "`ws'" == "stay" keep if stayer
        quietly count if missing(m1, m2, m3) | missing(ind, island)
        local dnm = r(N)                            // no usable record before COVID (or no
        drop if missing(m1, m2, m3) | missing(ind, island)  // industry or province code)
        gen byte t  = grp_main_`x'
        gen byte t0 = 1 - t
        * an industry or island with firms of only one kind cannot be balanced: its firms are left out
        bysort ind: egen long n1i = total(t)
        bysort ind: egen long n0i = total(t0)
        bysort island: egen long n1r = total(t)
        bysort island: egen long n0r = total(t0)
        gen byte off = n1i == 0 | n0i == 0 | n1r == 0 | n0r == 0
        quietly count if off & t == 1
        local d1 = r(N)
        quietly count if off & t == 0
        local d0 = r(N)
        drop if off
        quietly count if t == 1
        local n1 = r(N)
        quietly count if t == 0
        local n0 = r(N)
        * the other two groups: share of firms known to be in each (0/100: 100 = in that group;
        * a firm whose answer is unknown is simply not known to be in it)
        local stv ""
        foreach z in exp imp fdi {
            if "`z'" == "`x'" continue
            gen double st_`z' = 100 * (grp_main_`z' == 1)
            local stv "`stv' st_`z'"
        }
        * industry and island shares as 0/100 columns; one category of each is left out (shares add to 100)
        quietly tab ind, gen(I_)
        quietly tab island, gen(R_)
        foreach v of varlist I_* R_* {
            quietly replace `v' = 100 * `v'
        }
        drop I_1 R_1
        local X "m1 m2 m3 `stv' I_* R_*"
        unab X : `X'
        * a measure that is the same for every other firm cannot be moved by weights: left out of the
        * targets here; the balance check below still tests it
        local XX ""
        foreach v of local X {
            quietly summarize `v' if t == 0
            if r(sd) > 0 local XX "`XX' `v'"
        }
        mata: r110w = r110eb(st_data(., "`XX'", "t0"), mean(st_data(., "`XX'", "t")), `eb_tol', `eb_maxit')
        gen double w = 1 if t == 1
        mata: st_store(., "w", "t0", r110w * `n1')
        local it  = scalar(r110_iter)
        local gap = scalar(r110_gap)
        * what the weighted other firms are worth: as many equally weighted firms as (sum w)^2 / sum w^2
        gen double w2 = w^2
        quietly summarize w if t == 0
        local sw = r(sum)
        local wmr = r(max) / r(mean)                // largest weight / average weight
        quietly summarize w2 if t == 0
        local worth = `sw'^2 / r(sum)
        * balance check on every target: weighted gap in spreads
        local bal = `gap' < `eb_tol'
        foreach v of local X {
            quietly summarize `v' if t == 1
            local mg = r(mean)
            local vg = r(Var)
            quietly summarize `v' if t == 0
            local vo = r(Var)
            quietly summarize `v' [aw = w] if t == 0
            if abs(`mg' - r(mean)) > 1e-5 * sqrt((`vg' + `vo') / 2) local bal 0
        }
        display "   `x' (`ws'): `n1' in group, `n0' others, worth " %6.1f `worth' ///
            "; steps `it'; balanced: " cond(`bal', "yes", "NO")
        if !`bal' {
            display as error "   balance NOT reached for `x' (`ws'): its reweighted rows are left empty"
            replace w = .
        }
        * the balance table: every measure, each industry and island, before and after weighting
        quietly levelsof ind, local(inds)
        foreach l of local inds {
            gen double ind_`l' = 100 * (ind == `l')
        }
        quietly levelsof island, local(isls)
        foreach l of local isls {
            gen double isl_`l' = 100 * (island == `l')
        }
        foreach v of varlist m1 m2 m3 `stv' ind_* isl_* {
            quietly summarize `v' if t == 1
            local mg = r(mean)
            local vg = r(Var)
            quietly summarize `v' if t == 0
            local mo = r(mean)
            local vo = r(Var)
            local sdp = sqrt((`vg' + `vo') / 2)
            local mow = .
            if `bal' {
                quietly summarize `v' [aw = w] if t == 0
                local mow = r(mean)
            }
            local sb = cond(`sdp' > 0, (`mg' - `mo') / `sdp', .)
            local sa = cond(`sdp' > 0, (`mg' - `mow') / `sdp', .)
            post `hb' ("`x'") ("`ws'") ("`v'") (`mg') (`mo') (`mow') (`sdp') (`sb') (`sa') ///
                (`n1') (`n0') (`d1') (`d0') (`dnm') (`it') (`worth') (`wmr') (`gap') (`bal')
        }
        keep firm_id w
        tempfile w_`x'_`ws'
        save `w_`x'_`ws''
    }
}
postclose `hb'

*---------------------------------------------------------------------------
display "Step 6/10: regressions: every outcome x group x version (as R10-02 to R10-05)"
*---------------------------------------------------------------------------
* r106_es: the yearly model and the pooled term of R10-03, R10-04 and R10-05, on the rows in
* memory (X = 1 group, 0 other firms). Outcome = firm's own average + one average per industry
* and file + one per province and file (or the given averages) + the group's extra change in
* each file against the reference (start) file:
*   b_file = (group's change since the start file) - (other firms' change).
* Posted: one row per file, the average of the markers after the start file ("vs 2019") and
* the pooled term (Bu Deasy's "x Post2020": group x every later file, against the start file
* and the files before it together; its own regression on the same rows, "vs 2017-19").
capture program drop r106_es
program define r106_es
    args P oid x v y ref wl ab wt
    local terms ""
    local pre_terms ""
    local lc ""
    local np 0
    foreach yy of local wl {
        if `yy' != `ref' {
            gen double t`yy' = X * (year == `yy')
            local terms "`terms' t`yy'"
            if `yy' < `ref' local pre_terms "`pre_terms' t`yy'"
            else {
                local lc "`lc' + t`yy'"
                local ++np
            }
        }
    }
    gen double tpost = X * (year > `ref')
    local wexp ""
    if "`wt'" != "" local wexp "[pw = `wt']"
    * --- year by year ---
    quietly reghdfe `y' `terms' `wexp', absorb(`ab') vce(cluster firm_id)
    gen byte es = e(sample)
    local N  = e(N)
    local G  = e(N_clust)
    local df = e(df_r)
    local S  = e(num_singletons)
    if "`S'" == "" local S 0
    * before-start check: all markers before the start file are 0 together
    capture test `pre_terms'
    local bp = cond(_rc, ., r(p))
    * average of the markers after the start file
    quietly lincom (`=substr("`lc'", 4, .)') / `np'
    local ab_ = r(estimate)
    local as_ = r(se)
    * firms behind each marker: group (X = 1) and other firms (X = 0)
    quietly count if es & year == `ref' & X == 1
    local r1 = r(N)
    quietly count if es & year == `ref' & X == 0
    local r0 = r(N)
    egen byte ft = tag(firm_id) if es
    quietly count if ft == 1 & X == 1
    local fg1 = r(N)
    quietly count if ft == 1 & X == 0
    local fg0 = r(N)
    * what the weighted other firms of the start file are worth (as many firms counted equally)
    local wo .
    if "`wt'" != "" {
        gen double w2_ = `wt'^2
        quietly summarize `wt' if es & year == `ref' & X == 0
        local sw = r(sum)
        quietly summarize w2_ if es & year == `ref' & X == 0
        local wo = `sw'^2 / r(sum)
    }
    foreach yy of local wl {
        if `yy' == `ref' continue
        quietly count if es & year == `yy' & X == 1
        local n1 = r(N)
        quietly count if es & year == `yy' & X == 0
        local n0 = r(N)
        * a file with no rows for this outcome is dropped by reghdfe: left empty
        capture local sechk = _se[t`yy']
        if _rc local sechk = .
        if `sechk' == 0 | missing(`sechk') {
            post `P' (`oid') ("`x'") ("`v'") ("`yy'") (`yy') (`ref') (.) (.) (`df') (`N') (`G') (`S') ///
                (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp') (`wo')
        }
        else {
            post `P' (`oid') ("`x'") ("`v'") ("`yy'") (`yy') (`ref') (_b[t`yy']) (_se[t`yy']) (`df') (`N') (`G') ///
                (`S') (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp') (`wo')
        }
    }
    post `P' (`oid') ("`x'") ("`v'") ("avgpost") (.) (`ref') (`ab_') (`as_') (`df') (`N') (`G') (`S') ///
        (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp') (`wo')
    * --- pooled term (Bu Deasy's "x Post2020"), same rows ---
    quietly reghdfe `y' tpost if es `wexp', absorb(`ab') vce(cluster firm_id)
    assert e(N) == `N'
    * singletons: those the yearly model dropped (the pooled model runs on its rows, so it drops none)
    post `P' (`oid') ("`x'") ("`v'") ("pooled") (.) (`ref') (_b[tpost]) (_se[tpost]) (e(df_r)) (e(N)) ///
        (e(N_clust)) (`S') (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp') (`wo')
    drop `terms' tpost es ft
    capture drop w2_
end

* r106_surv: R10-02's gap in "still in the files" (0 or 100) on the firms in memory, one row per
* firm, expanded to one row per firm and later file; each file gets its own average for every
* industry and province (or only its own average: version fy). Year by year and the average of
* the three later files ("vs 2019": every firm is in the start file, so the gap there is 0).
capture program drop r106_surv
program define r106_surv
    args P x v ref wl fe wt
    quietly count if X == 1
    local ng = r(N)
    quietly count if X == 0
    local no = r(N)
    local wexp ""
    local wo .
    if "`wt'" != "" {
        local wexp "[pw = `wt']"
        gen double w2_ = `wt'^2
        quietly summarize `wt' if X == 0
        local sw = r(sum)
        quietly summarize w2_ if X == 0
        local wo = `sw'^2 / r(sum)
        drop w2_
    }
    expand 3
    bysort firm_id: gen byte step = _n
    gen double still = 100 * cond(step == 1, still_1, cond(step == 2, still_2, still_3))
    forvalues k = 1/3 {
        gen byte g_`k' = X * (step == `k')
    }
    local ctrl "i.step#i.ind i.step#i.prov"
    if "`fe'" == "fy" local ctrl "i.step"
    * year by year
    quietly regress still g_1 g_2 g_3 `ctrl' `wexp', vce(cluster firm_id)
    local nobs = e(N)
    local ncl  = e(N_clust)
    local dfr  = e(df_r)
    forvalues k = 1/3 {
        local yy : word `k' of `wl'
        quietly count if e(sample) & step == `k' & X == 1
        local n1 = r(N)
        quietly count if e(sample) & step == `k' & X == 0
        local n0 = r(N)
        post `P' (1) ("`x'") ("`v'") ("`yy'") (`yy') (`ref') (_b[g_`k']) (_se[g_`k']) (`dfr') (`nobs') (`ncl') ///
            (0) (`n1') (`n0') (`ng') (`no') (`ng') (`no') (.) (`wo')
    }
    * average of the three later files (R10-02's printed gap)
    quietly regress still X `ctrl' `wexp', vce(cluster firm_id)
    post `P' (1) ("`x'") ("`v'") ("avgpost") (.) (`ref') (_b[X]) (_se[X]) (e(df_r)) (e(N)) (e(N_clust)) ///
        (0) (.) (.) (`ng') (`no') (`ng') (`no') (.) (`wo')
end

* Versions (each changes ONE thing against the main rows; the main rows are R10-02/03/05's):
*   main   the exhibit's own numbers        fy     firm + year averages only (no industry or
*   eb     other firms reweighted                  province averages; R10-02: file averages only)
*   strict group = yes in every known answer, other firms = never yes (mixed left out)
*   early  group from the two files before the start file only (Bu Deasy's literal "pre-2019")
*   base   group from the start file's answer only
*   newc   firms new in the start file added (their group comes from that file alone)
*   allf   output, workers, value added per worker: every firm in whatever files it is in
*   closed output, workers: R10-04's what-if, firms that left counted as closed (midpoint scale)
*   stay   exporting: only firms in every later file
*   bench  normal years: the same, for the firms of the normal-years start file
*   look   the files before COVID extended by up to lb_n earlier files (table only)
tempname P
tempfile res
postfile `P' byte oid str8 grouping str8 version str8 term int year int ref_year double(b se df_r) ///
    long(rows firms singletons n_g1 n_g0 ref_g1 ref_g0 firms_g1 firms_g0) double(before_p worth_g0) ///
    using `res', replace
foreach x in exp imp fdi {
    display "   group `x'"
    * ---- output, workers, value added per worker (2-4) and exporting (5) ----
    foreach v in main fy eb strict early base newc allf stay bench look {
        foreach oid in 2 3 4 5 {
            if "`v'" == "allf" & `oid' == 5 continue        // exporting: all firms is its main sample
            if "`v'" == "stay" & `oid' <= 4 continue        // output etc.: stayers are the main sample
            if "`v'" == "look" & "`lb_1'" == "" continue    // no earlier files in the data
            local s = cond("`v'" == "bench", 2, 1)
            local G "grp_main_`x'"
            if inlist("`v'", "strict", "early", "base") local G "grp_`v'_`x'"
            * the files of the model
            if `oid' <= 4 local wl "`win_`s''"
            else local wl "`mw_`s''"
            if "`v'" == "look" local wl "`lb_1' `wl'"
            use `panel', clear
            keep if section == `s'
            if "`v'" != "newc" keep if new_to_file == 0
            keep if !missing(`G', y`oid')
            gen byte inw = 0
            foreach yy of local wl {
                quietly replace inw = 1 if year == `yy'
            }
            keep if inw
            if (`oid' <= 4 & "`v'" != "allf") | (`oid' == 5 & "`v'" == "stay") keep if stayer
            gen double X = `G'
            local wt ""
            if "`v'" == "eb" {
                local ws = cond(`oid' <= 4, "stay", "all")
                merge m:1 firm_id using `w_`x'_`ws'', keep(master match) nogenerate
                keep if !missing(w)
                local wt "w"
            }
            quietly count
            if r(N) == 0 continue                          // balance not reached: left empty
            local ab "firm_id ind#year prov#year"
            if "`v'" == "fy" local ab "firm_id year"
            r106_es `P' `oid' `x' `v' y`oid' `start_`s'' "`wl'" "`ab'" "`wt'"
        }
    }
    * ---- R10-04's what-if: output (2) and workers (3), leavers counted as closed ----
    foreach oid in 2 3 {
        use `cldata', clear
        keep if !missing(grp_main_`x')
        gen double X = grp_main_`x'
        r106_es `P' `oid' `x' closed y`oid' `start_1' "`win_1'" "firm_id ind#year prov#year" ""
    }
    * ---- still in the files (1) ----
    foreach v in main fy eb strict early base newc bench {
        local s = cond("`v'" == "bench", 2, 1)
        local G "grp_main_`x'"
        if inlist("`v'", "strict", "early", "base") local G "grp_`v'_`x'"
        use `firms', clear
        keep if section == `s'
        if "`v'" != "newc" keep if new_to_file == 0
        keep if !missing(`G')
        gen double X = `G'
        local wt ""
        if "`v'" == "eb" {
            merge m:1 firm_id using `w_`x'_all', keep(master match) nogenerate
            keep if !missing(w)
            local wt "w"
        }
        quietly count
        if r(N) == 0 continue
        r106_surv `P' `x' `v' `start_`s'' "`f1_`s'' `f2_`s'' `f3_`s''" "`v'" "`wt'"
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 7/10: tables -> CSV (numbers written before drawing), and the check against R10-02 to R10-05"
*---------------------------------------------------------------------------
use `res', clear
gen byte yearly = !missing(year)
gen byte reference = 0
* a version is drawn only if the group and the other firms each have min_n firms in its start file
* (reweighted: and the weighted other firms there are worth min_worth firms counted equally)
gen byte shown = !missing(b) & ref_g1 >= `min_n' & ref_g0 >= `min_n' & (missing(worth_g0) | worth_g0 >= `min_worth')
gen double tcrit = invttail(df_r, 0.025)
gen double lo = b - tcrit * se if shown
gen double hi = b + tcrit * se if shown
gen double p  = 2 * ttail(df_r, abs(b / se)) if shown & se > 0 & !missing(se)
* the number on the chart: log outcomes as % difference = 100 x (exp(b) - 1); the others
* (still in the files, exporting, R10-04's midpoint scale) are already in % points
gen byte logscale = inrange(oid, 2, 4) & version != "closed"
gen double val    = cond(logscale, 100 * (exp(b) - 1), b)   if shown
gen double val_lo = cond(logscale, 100 * (exp(lo) - 1), lo) if shown
gen double val_hi = cond(logscale, 100 * (exp(hi) - 1), hi) if shown
gen byte clear = lo > 0 | hi < 0 if !missing(lo)
* "already apart before the start file": a marker before the start file with 30+ firms on each
* side is clearly away from 0 (then the number against the three files before includes that
* earlier change and does not measure COVID)
gen byte pre_clear = yearly & year < ref_year & clear == 1 & n_g1 >= `min_n' & n_g0 >= `min_n'
bysort oid grouping version: egen byte apart = max(pre_clear)
drop pre_clear
* labels
gen byte gi = cond(grouping == "exp", 1, cond(grouping == "imp", 2, 3))
gen str30 grouping_label = cond(gi == 1, "Exporters", cond(gi == 2, "Importers", "Foreign-owned (10%+)"))
gen str60 outcome_label = ""
replace outcome_label = "Still in the survey files (% points)"                       if oid == 1
replace outcome_label = "Output (log, `out_prices'; % difference)"                   if oid == 2
replace outcome_label = "Workers (log; % difference)"                                 if oid == 3
replace outcome_label = "Value added per worker (log, `out_prices'; % difference)"   if oid == 4
replace outcome_label = "Exporting (% points)"                                        if oid == 5
replace outcome_label = "Output: change since `start_1', midpoint % points"          if oid == 2 & version == "closed"
replace outcome_label = "Workers: change since `start_1', midpoint % points"         if oid == 3 & version == "closed"
local f3r = "`f1_1'–" + substr("`f3_1'", 3, 2)
gen str100 version_label = ""
replace version_label = "Main: as printed in R10-0" + cond(oid == 1, "2", cond(oid == 5, "5", "3")) if version == "main"
replace version_label = "Firm + year averages only (no industry or province averages)"      if version == "fy"
replace version_label = "File averages only (no industry or province averages)"             if version == "fy" & oid == 1
replace version_label = "Other firms reweighted to match the group before COVID"            if version == "eb"
replace version_label = "Stricter rule: yes in every known answer vs never yes"            if version == "strict"
replace version_label = "Group from the `p2_1' and `p1_1' answers only"                      if version == "early"
replace version_label = "Group from the `start_1' answer only"                               if version == "base"
replace version_label = "Firms new in the `start_1' file added"                              if version == "newc"
replace version_label = "All firms in that year's file (R10-03's hollow circles)"           if version == "allf"
replace version_label = "What-if: leavers counted as closed (R10-04; midpoint scale)"      if version == "closed"
replace version_label = "Only firms in every file `f3r'"                                     if version == "stay"
replace version_label = "Normal years: `start_2' firms, same method"                         if version == "bench"
replace version_label = "Longer look-back: files `lb_1' added before COVID (table only)"   if version == "look"
gen str90 period = ""
replace period = "file " + term if yearly
replace period = "average of the markers after the start file (" + string(ref_year) + "), against it" if term == "avgpost"
replace period = "pooled: group x every later file, against the start file and the files before it" if term == "pooled"
gen byte vorder = 0
local vo 0
foreach v in main fy eb strict early base newc allf closed stay bench look {
    local ++vo
    replace vorder = `vo' if version == "`v'"
}
* what the figure draws: every version but the look-back, the two printed numbers
* (still in the files: only the average after the start file; see Notes)
gen str50 on_chart = "table only"
replace on_chart = "solid dot (vs the start file)" if term == "avgpost" & version != "look" & shown
replace on_chart = "hollow diamond (vs the three files before)" if term == "pooled" & version != "look" & shown
replace on_chart = "not drawn: too few firms" if inlist(term, "avgpost", "pooled") & version != "look" ///
    & !shown & !missing(b)
gen byte in_figure = inlist(on_chart, "solid dot (vs the start file)", "hollow diamond (vs the three files before)")
gen str120 note = ""
replace note = "Fewer than `min_n' firms of a group or of the other firms in the start file: left empty" if !shown & !missing(b)
replace note = "Reweighted other firms worth fewer than `min_worth' firms in the start file: left empty" ///
    if !shown & !missing(b) & ref_g1 >= `min_n' & ref_g0 >= `min_n' & worth_g0 < `min_worth'
replace note = "Its own regression on the rows of the yearly model; singletons = the yearly model's" if term == "pooled" & shown
replace note = "WHAT-IF (assumption, not a finding): leavers counted as closed" if version == "closed" & note == ""
replace note = "Already apart before the start file: the pooled number includes that earlier change" ///
    if term == "pooled" & apart == 1 & shown
* structural checks
assert lo <= b + 1e-9 & b <= hi + 1e-9 if !missing(lo)
assert n_g1 <= firms_g1 & n_g0 <= firms_g0 if !missing(n_g1)
assert apart == 0 if oid == 1                            // no file before the start file: nothing to test
gen int torder = cond(yearly, year, cond(term == "avgpost", 9001, 9002))
sort gi oid vorder torder
order oid outcome_label grouping grouping_label version version_label term period year ref_year shown ///
    in_figure on_chart b se df_r p lo hi val val_lo val_hi clear apart n_g1 n_g0 ref_g1 ref_g0 firms_g1 ///
    firms_g0 rows firms singletons before_p worth_g0 note
format b se lo hi %9.4f
format val val_lo val_hi %8.2f
format p before_p %6.4f
format worth_g0 %9.1f
format df_r rows firms singletons n_g* ref_g* firms_g* %9.0f
export delimited oid-note using "tables/`fname'.csv", datafmt replace
list oid grouping version term val val_lo val_hi clear apart ref_g1 ref_g0 if inlist(term, "avgpost", "pooled"), ///
    noobs sepby(grouping oid) abbreviate(24)
tempfile ctsrc
save `ctsrc'

* ---- the check: the rows R10-02 to R10-05 printed or tabled must come out the same here ----
* (only when their CSVs are in tables/, e.g. after 00_run.do; the CSVs have 4 decimals)
* source file | its rows (version) -> the version here
local nchk 0
foreach src in 02 03 04 05 {
    if "`src'" == "02" local cf "tables/02_left_the_file_by_group_gaps.csv"
    if "`src'" == "03" local cf "tables/03_survivors_output_jobs_productivity.csv"
    if "`src'" == "04" local cf "tables/04_all_firms_output_jobs.csv"
    if "`src'" == "05" local cf "tables/05_export_participation_models.csv"
    capture confirm file "`cf'"
    if _rc {
        display "   check skipped: `cf' not found (run R10-0`=substr("`src'", 2, 1)' first to compare)"
        continue
    }
    preserve
    import delimited using "`cf'", clear varnames(1) stringcols(_all)
    destring b, replace
    if "`src'" == "02" {
        destring section, replace
        keep if section <= 2 & model != "diff"
        gen byte oid = 1
        gen str8 version = cond(section == 1, "main", "bench")
        gen str8 t2 = cond(model == "average", "avgpost", year)
    }
    else if "`src'" == "03" {
        destring outcome_id, replace
        keep if outcome_id <= 3 & inlist(version, "stay", "all", "fystay")
        gen byte oid = outcome_id + 1
        replace version = cond(version == "stay", "main", cond(version == "all", "allf", "fy"))
        gen str8 t2 = term
    }
    else if "`src'" == "04" {
        destring outcome_id, replace
        keep if version == "closed"
        gen byte oid = outcome_id + 1
        gen str8 t2 = term
    }
    else {
        keep if inlist(version, "covid", "normal", "stay", "fy")
        gen byte oid = 5
        replace version = cond(version == "covid", "main", cond(version == "normal", "bench", version))
        gen str8 t2 = term
    }
    keep if !missing(b)
    capture confirm variable reference
    if !_rc keep if reference != "1"                 // the start file's 0 (by definition)
    keep oid grouping version t2 b
    rename (t2 b) (term b_src)
    tempfile chk
    save `chk'
    restore
    merge 1:1 oid grouping version term using `chk', keep(master match using)
    assert _merge != 2                                   // every row of the source is here too
    quietly count if _merge == 3
    local n_`src' = r(N)
    local nchk = `nchk' + r(N)
    assert abs(b - b_src) <= 0.00005 + 1e-9 if _merge == 3
    display "   R10-`src': `n_`src'' estimates compared, all equal (4 decimals)"
    drop _merge b_src
}
display "   estimates compared with R10-02 to R10-05: `nchk'"

* the balance table (before-COVID averages, group vs other firms, before and after weighting)
use `balance', clear
gen byte gi = cond(grouping == "exp", 1, cond(grouping == "imp", 2, 3))
gen str70 measure_label = ""
replace measure_label = "Workers (log), average `p2_1'–" + substr("`start_1'", 3, 2) if measure == "m1"
replace measure_label = "Output (log), average `p2_1'–" + substr("`start_1'", 3, 2) if measure == "m2"
replace measure_label = "Value added per worker (log), average `p2_1'–" + substr("`start_1'", 3, 2) if measure == "m3"
replace measure_label = "Exporter (% of firms)"                   if measure == "st_exp"
replace measure_label = "Importer (% of firms)"                   if measure == "st_imp"
replace measure_label = "Foreign-owned, 10%+ (% of firms)"        if measure == "st_fdi"
replace measure_label = "Industry " + substr(measure, 5, .) + " (% of firms; code order)" if substr(measure, 1, 4) == "ind_"
replace measure_label = "Island: Sumatra (% of firms)"            if measure == "isl_1"
replace measure_label = "Island: Java (% of firms)"               if measure == "isl_2"
replace measure_label = "Island: other islands (% of firms)"      if measure == "isl_3"
gen str60 sample_label = cond(sample == "all", "All firms (still in the files, exporting)", ///
    "Firms in every later file (output, workers, VA per worker)")
* balance reached: every weighted gap below a millionth of a spread
assert abs(std_after) < 1e-4 if balanced == 1 & !missing(std_after)
sort gi sample measure
order grouping sample sample_label measure measure_label mean_g mean_o mean_ow sd_pool std_before std_after ///
    firms_g1 firms_g0 drop_g1 drop_g0 drop_nomeas iter worth_g0 wmax_ratio gap_max balanced
format mean_g mean_o mean_ow sd_pool std_before std_after %9.4f
format worth_g0 wmax_ratio %9.1f
export delimited grouping-balanced using "tables/`fname'_balance.csv", datafmt replace
list grouping sample measure std_before std_after firms_g1 firms_g0 worth_g0 if inlist(measure, "m1", "m2", "m3"), ///
    noobs sepby(grouping) abbreviate(24)
tempfile baltab
save `baltab'

*---------------------------------------------------------------------------
display "Step 8/10: numbers and labels for the notes and rows, read from the tables (never typed)"
*---------------------------------------------------------------------------
use `ctsrc', clear
local n_inc_s  = strtrim(string(`n_inc_1', "%9.0fc"))
local n_stay_s = strtrim(string(`n_stay_1', "%9.0fc"))
local post_rng = "`f1_1'–" + substr("`f3_1'", 3, 2)              // 2020–22
local pool_rng = "`p2_1'–" + substr("`start_1'", 3, 2)           // 2017–19
local ex_last : word `npost_ex' of `post_1'
local ex_rng  = cond(`npost_ex' == 1, "`post_1'", "`f1_1'–" + substr("`ex_last'", 3, 2))   // 2020–21
local bpost_rng = "`f1_2'–" + substr("`f3_2'", 3, 2)             // 2013–15
local bpool_rng = "`p2_2'–" + substr("`start_2'", 3, 2)          // 2010–12
local early_rng = "`p2_1'–" + substr("`p1_1'", 3, 2)             // 2017–18
quietly count if in_figure & version == "closed"
local n_closed_drawn = r(N)
quietly count if in_figure & term == "pooled" & apart == 1
local n_apart = r(N)
display "   drawn: " _N " estimates in the CSV; pooled numbers flagged 'already apart': `n_apart'"
* groups whose reweighted rows are empty because the weighted other firms count as too few
* firms (read from the table, so the notes name them on any data)
local ebmiss ""
local ebn 0
foreach x in exp imp fdi {
    quietly count if version == "eb" & grouping == "`x'" & inlist(term, "avgpost", "pooled") & !shown ///
        & !missing(b) & ref_g1 >= `min_n' & ref_g0 >= `min_n' & worth_g0 < `min_worth'
    if r(N) > 0 {
        local ++ebn
        local gl = cond("`x'" == "exp", "exporters'", cond("`x'" == "imp", "importers'", "foreign-owned firms'"))
        local ebmiss = cond(`ebn' == 1, "`gl'", "`ebmiss' and `gl'")
    }
}
local ebtxt ""
if `ebn' > 0 {
    local ebcap = ustrupper(usubstr("`ebmiss'", 1, 1)) + usubstr("`ebmiss'", 2, .)
    local ebtxt "`ebcap' reweighted rows are empty: weighted, the other firms count as fewer than `min_worth' firms."
}
display "   reweighted rows left empty: `ebmiss'"
* the rows of each section (top to bottom) and their labels
local rows_1 "main fy eb strict early base newc bench"
local rows_2 "main fy eb strict early base newc allf closed bench"
local rows_3 "`rows_2'"
local rows_4 "main fy eb strict early base newc allf bench"
local rows_5 "main fy eb strict early base newc stay bench"
local rl_main   "Main (as printed)"
local rl_fy     "Firm + year averages only"
local rl_eb     "Other firms reweighted"
local rl_strict "Stricter rule: always vs never"
local rl_early  "Group from `early_rng' answers only"
local rl_base   "Group from `start_1' answer only"
local rl_newc   "Firms new in `start_1' added"
local rl_allf   "All firms in each file"
local rl_closed "What-if: leavers counted as closed"
local rl_stay   "Only firms in every file `post_rng'"
local rl_bench  "Normal years: `start_2' firms"
local hd_1 "Still in the survey files, % points (R10-02)"
local hd_2 "Output, % (R10-03)"
local hd_3 "Workers, % (R10-03)"
local hd_4 "Value added per worker, % (R10-03)"
local hd_5 "Exporting, % points, `ex_rng' (R10-05)"

*---------------------------------------------------------------------------
display "Step 9/10: dot plot: every version, three groups side by side, one shared scale"
*---------------------------------------------------------------------------
keep if inlist(term, "avgpost", "pooled") & version != "look"
* one row per group, section and version, also for versions with no estimate (e.g. balance
* not reached): they get the text "too few firms" or "not estimable"
preserve
clear
local nr 0
forvalues g = 1/3 {
    forvalues o = 1/5 {
        foreach v of local rows_`o' {
            local ++nr
        }
    }
}
set obs `nr'
gen byte gi = .
gen byte oid = .
gen str8 version = ""
local i 0
forvalues g = 1/3 {
    forvalues o = 1/5 {
        foreach v of local rows_`o' {
            local ++i
            quietly replace gi = `g' in `i'
            quietly replace oid = `o' in `i'
            quietly replace version = "`v'" in `i'
        }
    }
}
tempfile frame
save `frame'
restore
merge m:1 gi oid version using `frame', nogenerate
replace term = "avgpost" if missing(term)
* y positions (top to bottom; the axis is reversed): a heading, then one row per version
local yy = 0
forvalues o = 1/5 {
    if `o' > 1 local yy = `yy' + 0.6
    local yy = `yy' + 1
    local yh_`o' = `yy'
    foreach v of local rows_`o' {
        local yy = `yy' + 1
        local yr_`o'_`v' = `yy'
    }
    local ye_`o' = `yy' + 0.5
}
local ymax = `yy' + 0.6
gen double yrow = .
forvalues o = 1/5 {
    foreach v of local rows_`o' {
        quietly replace yrow = `yr_`o'_`v'' if oid == `o' & version == "`v'"
    }
}
assert !missing(yrow)
* the y-axis labels: section headings (bold) and the row labels
local ylab ""
forvalues o = 1/5 {
    local ylab `"`ylab' `yh_`o'' "{bf:`hd_`o''}""'
    foreach v of local rows_`o' {
        local ylab `"`ylab' `yr_`o'_`v'' "`rl_`v''""'
    }
}
* marker sets: ● = against the start file (just above the row; still in the files: on the row),
* ◇ = against the three files before (just below), gray ◇ where already apart before COVID
gen double yd = yrow - cond(oid == 1, 0, 0.2) if term == "avgpost" & shown
gen double xd = val    if term == "avgpost" & shown
gen double ld = val_lo if term == "avgpost" & shown
gen double hd = val_hi if term == "avgpost" & shown
gen double yp = yrow + 0.2 if term == "pooled" & shown
gen double xp = val    if term == "pooled" & shown & apart == 0
gen double lp = val_lo if term == "pooled" & shown & apart == 0
gen double hp = val_hi if term == "pooled" & shown & apart == 0
gen double xq = val    if term == "pooled" & shown & apart == 1
gen double lq = val_lo if term == "pooled" & shown & apart == 1
gen double hq = val_hi if term == "pooled" & shown & apart == 1
* rows with nothing drawn: a gray text on the row
gen str24 miss = ""
bysort gi oid version: egen byte anyshown = max(shown)
replace miss = "too few firms" if anyshown != 1 & term == "avgpost" & !missing(b)
replace miss = "not estimable" if anyshown != 1 & term == "avgpost" & missing(b) & missing(miss)
* one shared x scale: a round step that grows with the numbers; 0 always inside
egen double xmn = rowmin(ld lp lq)
egen double xmx = rowmax(hd hp hq)
quietly summarize xmn
local xmin = min(r(min), 0)
quietly summarize xmx
local xmax = max(r(max), 0)
local rng = `xmax' - `xmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local xlo = `step' * floor(`xmin'/`step')
local xhi = `step' * ceil(`xmax'/`step')
display "   x from `xlo' to `xhi' by `step'"
* labelled every second step, always through 0; faint grid at every step
local xlab "0"
forvalues m = 1/20 {
    if -2 * `m' * `step' >= `xlo' local xlab "`=-2 * `m' * `step'' `xlab'"
    if  2 * `m' * `step' <= `xhi' local xlab "`xlab' `=2 * `m' * `step''"
}
gen double mx = `xlo' + 0.02 * (`xhi' - `xlo') if miss != ""
gen double my = yrow if miss != ""
* per panel and section: the 0 line and a dotted line at the main row's ● (for comparison)
local n0 = _N
set obs `=_N + 15'
gen double zx = .
gen double zy0 = .
gen double zy1 = .
gen double rx = .
gen double ry0 = .
gen double ry1 = .
local r = `n0'
forvalues g = 1/3 {
    forvalues o = 1/5 {
        local ++r
        quietly replace gi = `g' in `r'
        quietly replace zx = 0 in `r'
        quietly replace zy0 = `yh_`o'' + 0.5 in `r'
        quietly replace zy1 = `ye_`o'' in `r'
        quietly summarize val if gi == `g' & oid == `o' & version == "main" & term == "avgpost" & shown, meanonly
        if r(N) == 1 {
            quietly replace rx = r(mean) in `r'
            quietly replace ry0 = `yh_`o'' + 0.5 in `r'
            quietly replace ry1 = `ye_`o'' in `r'
        }
    }
}
label define gi 1 "(a) Exporters" 2 "(b) Importers" 3 "(c) Foreign-owned"
label values gi gi
sort gi oid yrow term
* Notes: one text, wrapped here into lines of at most 102 characters (PDF text runs wider than the PNG)
local ntext "Notes: Each row redoes one number of R10-02, R10-03 or R10-05 with one change. Main rows: the `n_inc_s' firms of the `start_1' file also in `p2_1' or `p1_1', grouped from their `pool_rng' answers (output, workers, VA per worker: the `n_stay_s' in every file `post_rng'). ●~=~the group's change since `start_1' minus that of similar firms (same industry and province), `post_rng' (exporting: `ex_rng'; `f3_1' asks about direct exports only). ◇~=~the same against `pool_rng' (Bu Deasy's ×~Post2020; none for still in the files); gray~◇: already apart before COVID, so not a COVID measure. Line = 95% interval; crossing 0 = no clear difference. Reweighted: other firms weighted to look like the group before COVID. `ebtxt' Normal years: `start_2' firms, no COVID. What-if: an assumption, not a finding. Under `min_n' firms: not shown. VA = value added = output minus materials, energy and services bought; `out_prices'. Association only. Foreign-owned = 10%+ of capital held abroad. Firm links are fictional here: who stayed or left means nothing."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 102 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
* "~" keeps a symbol with its words on one line; it prints as a space
local notelines : subinstr local notelines "~" " ", all
display `"   note lines: `notelines'"'

* Stata draws markers about twice as large in the PNG as in the PDF, so each file gets its own
* marker size (same data, same layout)
foreach out in png pdf {
    local msz = cond("`out'" == "png", "vsmall", "small")
    twoway (rspike zy0 zy1 zx, lcolor(gs8) lpattern(dash) lwidth(thin)) ///
        (rspike ry0 ry1 rx, lcolor(gs11) lpattern(shortdash) lwidth(thin)) ///
        (rspike lq hq yp, horizontal lcolor(gs12) lwidth(thin)) ///
        (rspike lp hp yp, horizontal lcolor(gs8) lwidth(thin)) ///
        (rspike ld hd yd, horizontal lcolor(black) lwidth(medthin)) ///
        (scatter yp xq, msymbol(Dh) mcolor(gs10) mlwidth(medthin) msize(`msz')) ///
        (scatter yp xp, msymbol(Dh) mcolor(black) mlwidth(medthin) msize(`msz')) ///
        (scatter yd xd, msymbol(O) mcolor(black) msize(`msz')) ///
        (scatter my mx, msymbol(none) mlabel(miss) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs8)), ///
        by(gi, rows(1) imargin(small) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+4)) ///
            legend(pos(6)) ///
            title("Figure R10-06. Do the answers hold under other choices?" ///
                  "R10-02, R10-03 and R10-05 redone, one change at a time", size(small) pos(11) span) ///
            note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
        subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
        yscale(reverse noline range(0.4 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ///
        ytitle("") ///
        xscale(range(`xlo' `xhi') noline) ///
        xlabel(`xlab', format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
        xmtick(`xlo'(`step')`xhi', noticks tlength(0) grid glcolor(gs15) glwidth(vthin)) ///
        xtitle("Group minus similar firms: change since `start_1', % (still in the files, exporting: % points)", size(vsmall)) ///
        legend(order(8 "`post_rng' vs `start_1' (exporting: `ex_rng')" 5 "95% interval of ●" ///
                     7 "vs `pool_rng' together: Bu Deasy's × Post2020" 4 "95% interval of ◇" ///
                     6 "Gray ◇: apart before COVID, does not measure COVID" 2 "Main row's ●, for comparison" ///
                     1 "0 = no difference") ///
            cols(2) region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(8) rowgap(0.3)) ///
        plotregion(style(none)) xsize(8) ysize(15.5)
    if "`out'" == "png" graph export "figures/`fname'.png", width(2400) replace
    else graph export "figures/`fname'.pdf", replace
}
display "figure -> figures/`fname'.png"

*---------------------------------------------------------------------------
display "Step 10/10: companion tables: every plotted point, and the regression table"
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
* Source: the table saved right after the CSV export (full precision, same estimation run as
* the chart).
* (1) Points table: one row per point of the chart, panel by panel, section by section, row by
*     row: the ● (against the start file) then the ◇ (against the three files before).
use `ctsrc', clear
quietly count if in_figure
local n_fig = r(N)
keep if inlist(term, "avgpost", "pooled") & version != "look"
gen byte srow = 0
forvalues o = 1/5 {
    local k 0
    foreach v of local rows_`o' {
        local ++k
        replace srow = `k' if oid == `o' & version == "`v'"
    }
}
assert srow > 0
gen str30 t_panel = cond(gi == 1, "(a) Exporters", cond(gi == 2, "(b) Importers", "(c) Foreign-owned"))
gen str40 t_sec = ""
replace t_sec = "Still in the files (pts)" if oid == 1
replace t_sec = "Output (%)"               if oid == 2
replace t_sec = "Workers (%)"              if oid == 3
replace t_sec = "VA per worker (%)"        if oid == 4
replace t_sec = "Exporting (pts)"          if oid == 5
gen str40 t_row = ""
foreach v in main fy eb strict early base newc allf closed stay bench {
    replace t_row = "`rl_`v''" if version == "`v'"
}
* the comparison, as in the legend
local bex_last : word `npost_ex' of `post_2'
local bex_rng = cond(`npost_ex' == 1, "`post_2'", "`f1_2'–" + substr("`bex_last'", 3, 2))
gen str30 t_num = ""
replace t_num = "`post_rng' vs `start_1'" if term == "avgpost"
replace t_num = "`ex_rng' vs `start_1'" if term == "avgpost" & oid == 5
replace t_num = "`bpost_rng' vs `start_2'" if term == "avgpost" & version == "bench"
replace t_num = "`bex_rng' vs `start_2'" if term == "avgpost" & version == "bench" & oid == 5
replace t_num = "vs `pool_rng', × Post2020" if term == "pooled"
replace t_num = "vs `bpool_rng'" if term == "pooled" & version == "bench"
* values: markers carry no number on the chart, so one decimal
gen str12 t_v  = cond(val > 0.05, "+", "") + string(val, "%9.1f") if shown
gen str12 t_lo = cond(val_lo > 0.05, "+", "") + string(val_lo, "%9.1f") if shown
gen str12 t_hi = cond(val_hi > 0.05, "+", "") + string(val_hi, "%9.1f") if shown
gen str12 t_n1 = string(ref_g1, "%12.0fc")
gen str12 t_n0 = string(ref_g0, "%12.0fc")
gen str12 t_w = string(worth_g0, "%12.0fc") if !missing(worth_g0)
gen str40 t_status = ""
replace t_status = "black dot" if in_figure & term == "avgpost"
replace t_status = "hollow diamond" if in_figure & term == "pooled" & apart == 0
replace t_status = "gray diamond: apart before" if in_figure & term == "pooled" & apart == 1
replace t_status = "not drawn: under `min_n' firms" if !shown & !missing(b) & (ref_g1 < `min_n' | ref_g0 < `min_n')
replace t_status = "not drawn: reweighted others under `min_worth'" if !shown & !missing(b) & t_status == ""
replace t_status = "not estimable" if missing(b)
replace t_status = t_status + " (what-if)" if version == "closed"
assert t_status != ""
* check: every drawn point is in the table once
quietly count if in_figure
assert r(N) == `n_fig'
sort gi oid srow term
local nrows = _N
local rl ""
forvalues i = 1/`=_N - 1' {
    if oid[`i'] != oid[`i' + 1] | gi[`i'] != gi[`i' + 1] local rl "`rl' `i'"
}
local tnote "Table: every point of Figure R10-06, panel by panel, section by section. Output, workers and VA per worker: % difference"
local tnote "`tnote' = 100 × (exp(b) − 1) with b the coefficient in the regression table (what-if: midpoint % points); still in the files"
local tnote "`tnote' and exporting: % points. Full precision in tables/`fname'.csv. Firms: group and other firms in the start file of the"
local tnote "`tnote' model; worth = what the reweighted other firms are worth, as firms counted equally. Gray diamond: the group was"
local tnote "`tnote' already apart before COVID, so that number does not measure COVID. What-if rows (R10-04's midpoint scale, % points):"
local tnote "`tnote' an assumption, not a finding."
local ntab : subinstr local ntext "~" " ", all
order t_panel t_sec t_row t_num t_v t_lo t_hi t_n1 t_n0 t_w t_status
ctable_pdf t_panel t_sec t_row t_num t_v t_lo t_hi t_n1 t_n0 t_w t_status using "tables/`fname'_table.pdf", ///
    title("Table R10-06. The numbers of R10-02, R10-03 and R10-05 under other choices: every plotted point") ///
    subtitle("Group minus similar firms (same industry and province) after COVID") ///
    header("Panel" "Section" "Row" "Comparison" "Estimate" "Interval|from" "Interval|to" "Firms:|in group" ///
        "Firms:|others" "Others'|worth" "Status") ///
    right(5 6 7 8 9 10) norepeat(1 2) rules(`rl') perpage(34) fontsize(8) landscape ///
    notes("`ntab'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`nrows' rows; `n_fig' drawn)"

* (2) Regression table (AER style): one column per version; per outcome and group the first
* later file, the average after the start file and the pooled term: coefficient, (standard
* error), [% difference = 100 × (exp(b) − 1)] for the log outcomes.
use `ctsrc', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1) stringcols(3 5 7)
keep oid grouping version term b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 oid grouping version term using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
local cols "main fy eb strict early base newc alt closed bench look"
local nc : word count `cols'
local tv ""
forvalues c = 1/`nc' {
    local tv "`tv' t`c'"
}
tempname Q
tempfile R
postfile `Q' str60 t_lab str24(`tv') using `R', replace
local nterm 0
local rl ""
local plab1 "Exporters"
local plab2 "Importers"
local plab3 "Foreign-owned (10%+)"
local olab1 "still in the files"
local olab2 "output"
local olab3 "workers"
local olab4 "VA per worker"
local olab5 "exporting"
local pan 0
forvalues o = 1/5 {
    forvalues g = 1/3 {
        local ++pan
        local cells ""
        forvalues c = 1/`nc' {
            local cells `"`cells' ("")"'
        }
        post `Q' ("Panel `pan'. `plab`g'': `olab`o''") `cells'
        local ++nterm
        foreach tm in first avgpost pooled {
            if "`tm'" == "pooled" & `o' == 1 continue
            local l1 ""
            local l2 ""
            local l3 ""
            forvalues c = 1/`nc' {
                local vv : word `c' of `cols'
                if "`vv'" == "alt" local vv = cond(`o' == 5, "stay", "allf")
                local tt "`tm'"
                if "`tm'" == "first" local tt = cond("`vv'" == "bench", "`f1_2'", "`f1_1'")
                quietly count if gi == `g' & oid == `o' & version == "`vv'" & term == "`tt'"
                local have = r(N)
                quietly summarize b if gi == `g' & oid == `o' & version == "`vv'" & term == "`tt'", meanonly
                local bb = r(mean)
                quietly summarize se if gi == `g' & oid == `o' & version == "`vv'" & term == "`tt'", meanonly
                local ss = r(mean)
                quietly summarize shown if gi == `g' & oid == `o' & version == "`vv'" & term == "`tt'", meanonly
                local sh = r(mean)
                local lg = inrange(`o', 2, 4) & "`vv'" != "closed"
                local fm = cond(`lg', "%9.3f", "%9.2f")
                if `have' == 0 {
                    local l1 `"`l1' ("")"'
                    local l2 `"`l2' ("")"'
                    local l3 `"`l3' ("")"'
                }
                else if missing(`bb') | `sh' != 1 {
                    local l1 `"`l1' ("too few")"'
                    local l2 `"`l2' ("")"'
                    local l3 `"`l3' ("")"'
                }
                else {
                    local l1 `"`l1' ("`=string(`bb', "`fm'")'")"'
                    local l2 `"`l2' ("(`=string(`ss', "`fm'")')")"'
                    if `lg' {
                        local pv = 100 * (exp(`bb') - 1)
                        local l3 `"`l3' ("[`=cond(`pv' > 0, "+", "")'`=string(`pv', "%9.1f")'%]")"'
                    }
                    else local l3 `"`l3' ("")"'
                }
            }
            if "`tm'" == "first"   local lab "Group × first later file"
            if "`tm'" == "avgpost" local lab "Average after start file"
            if "`tm'" == "pooled"  local lab "Pooled × Post2020"
            post `Q' ("`lab'") `l1'
            post `Q' ("") `l2'
            local nterm = `nterm' + 2
            if inrange(`o', 2, 4) {
                post `Q' ("") `l3'
                local ++nterm
            }
        }
        * whole-model rows (the yearly model of each column)
        foreach st in before_p rows firms firms_g1 worth_g0 {
            if "`st'" == "before_p" & `o' == 1 continue
            local ll ""
            local any 0
            forvalues c = 1/`nc' {
                local vv : word `c' of `cols'
                if "`vv'" == "alt" local vv = cond(`o' == 5, "stay", "allf")
                quietly summarize `st' if gi == `g' & oid == `o' & version == "`vv'" & term == "avgpost", meanonly
                if r(N) == 0 | missing(r(mean)) local cv ""
                else if "`st'" == "before_p" local cv = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
                else local cv = string(r(mean), "%12.0fc")
                if "`cv'" != "" local any 1
                local ll `"`ll' ("`cv'")"'
            }
            if "`st'" == "before_p" local lab "Before-start test, p"
            if "`st'" == "rows"     local lab "Observations"
            if "`st'" == "firms"    local lab "Firms (clusters)"
            if "`st'" == "firms_g1" local lab "Firms in the group"
            if "`st'" == "worth_g0" local lab "Other firms' worth"
            if `any' {
                post `Q' ("`lab'") `ll'
                local ++nterm
            }
        }
        local rl "`rl' `nterm'"
    }
}
* design rows, the same for every panel
foreach d in firm indprov yr wgt files rule clu {
    local ll ""
    forvalues c = 1/`nc' {
        local vv : word `c' of `cols'
        if "`d'" == "firm"    local cv "Yes"
        if "`d'" == "indprov" local cv = cond("`vv'" == "fy", "No", "Yes")
        if "`d'" == "yr"      local cv = cond("`vv'" == "fy", "Yes", "Yes, by ind.")
        if "`d'" == "wgt"     local cv = cond("`vv'" == "eb", "Reweighted", "None")
        if "`d'" == "files"   local cv = cond("`vv'" == "bench", "`p2_2'–" + substr("`f3_2'", 3, 2), cond("`vv'" == "look", "`: word 1 of `lb_1''–" + substr("`f3_1'", 3, 2), "`p2_1'–" + substr("`f3_1'", 3, 2)))
        if "`d'" == "rule"    local cv = cond("`vv'" == "strict", "Always/never", cond("`vv'" == "early", "`early_rng'", cond("`vv'" == "base", "`start_1' only", "Half or more")))
        if "`d'" == "clu"     local cv "Firm"
        local ll `"`ll' ("`cv'")"'
    }
    if "`d'" == "firm"    local lab "Firm FE (still in files: no)"
    if "`d'" == "indprov" local lab "Ind./prov. × year FE"
    if "`d'" == "yr"      local lab "Year FE"
    if "`d'" == "wgt"     local lab "Weights"
    if "`d'" == "files"   local lab "Files"
    if "`d'" == "rule"    local lab "Group rule"
    if "`d'" == "clu"     local lab "SE clustered by"
    post `Q' ("`lab'") `ll'
}
postclose `Q'
use `R', clear
local rnote "Notes: Units: still in the files and exporting, % points; output, workers, value added (VA) per worker, log points (column 9:"
local rnote "`rnote' R10-04's midpoint % points). Each cell is one regression of R10-02, R10-03 or R10-05 with one change (column). Output, workers, VA per worker:"

local rnote "`rnote' log outcome on the group times each file except the start file (set to 0), firm averages and the fixed effects listed; the"
local rnote "`rnote' average is the mean of the markers after the start file; the pooled term (Bu Deasy's × Post2020) is its own regression with one"
local rnote "`rnote' term, group × every later file, against the start file and the files before it together (column 11: `lb_1' too). Still in the"
local rnote "`rnote' files: one row per firm and later file, 0 or 100, gap per file and average (R10-02; industry × file and province × file"
local rnote "`rnote' averages; column 2: file averages only); every firm is in the start file, so there is no pooled term. Exporting: 0 or 100,"
local rnote "`rnote' `ex_rng' (`f3_1' asks about direct exports only). Columns: (1) main, as printed in R10-02/03/05; (2) firm + year averages only;"
local rnote "`rnote' (3) other firms reweighted to match the group's `pool_rng' averages (entropy balancing, R1-10's code; weights treated as"
local rnote "`rnote' known); (4) group = yes in every known answer vs never; (5) group from `early_rng' answers; (6) from the `start_1' answer; (7) firms"
local rnote "`rnote' new in `start_1' added; (8) output etc.: all firms in whatever files they are in; exporting: only firms in every file `post_rng';"
local rnote "`rnote' (9) R10-04's what-if, leavers counted as closed, midpoint scale (an assumption, not a finding); (10) normal years: `start_2'"
local rnote "`rnote' firms, `bpost_rng' (exporting `bex_rng') vs `start_2', pooled vs `bpool_rng'; its first later file is `f1_2'; (11) longer look-back (table"
local rnote "`rnote' only). Where a before-start marker is clearly away from 0 (small p), the pooled term includes that earlier change and"
local rnote "`rnote' does not measure COVID. too few = fewer than `min_n' firms in the start file (reweighted: others worth under `min_worth')."
local rnote "`rnote' FE = fixed effects (averages taken out). Singleton firms dropped by reghdfe. Output and VA: `out_prices'. No stars."
ctable_pdf t_lab `tv' using "tables/`fname'_regression.pdf", ///
    title("Table R10-06, regression. The numbers of R10-02, R10-03 and R10-05 under other choices: estimates behind the chart") ///
    subtitle("Coefficient; (standard error, clustered by firm); [% difference = 100 × (exp(b) − 1)] for log outcomes.") ///
    header(" " "(1)|Main" "(2)|Firm +|year" "(3)|Re-|weighted" "(4)|Stricter|rule" "(5)|`early_rng'|answers" ///
        "(6)|`start_1'|answer" "(7)|New in|`start_1'" "(8)|Other|sample" "(9)|What-if:|closed" "(10)|Normal|years" ///
        "(11)|Longer|look-back") ///
    right(2 3 4 5 6 7 8 9 10 11 12) rules(`rl') landscape fontsize(8) perpage(30) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
