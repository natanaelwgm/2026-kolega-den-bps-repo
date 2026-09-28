/*==========================================================================
  R10-01  Which firms count as exporters, importers and foreign-owned
          firms just before COVID? Each firm in the last file before COVID
          is put into each group ONCE, from its own records of that file and
          the two files before it, and keeps that group for every later
          year. How many firms are in each group, how many are left out
          because no answer is known, how do other rules change the groups,
          and how much do the three groups overlap?
  Answers Bu Deasy R10: "Pre-2019 exporter/importer/FDI x Post2020" (the
          groups), for "Were internationally integrated firms more
          resilient during COVID?"; support for every later R10 exhibit.
  Foreign-owned = 10% or more of the firm's capital held abroad
          (fdi_10_flag), the definition used in every R1-R10 exhibit.
  Cohort : the block "COVID COHORT AND STATES" is copied unchanged from R4-01
          (block-r4-covid-survival/01_cohort_states_flow.do); do not edit it here.
  Output : figures/01_covid_cohort_groups.png (+ .pdf)
           tables/01_covid_cohort_groups.csv          (numbers in the figure)
           tables/01_covid_cohort_groups_support.csv  (firms per group and
                                                       year, and how many can
                                                       be used for each outcome)
           tables/01_covid_cohort_groups_table.pdf    (every plotted bar, companion table)
           tables/01_covid_cohort_groups_profile.csv  (each group in the last
                                                       file before COVID: size,
                                                       output, industry mix)
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
cap log close
log using "logs/01_covid_cohort_groups.log", replace text
timer clear 1
timer on 1
display _newline "=== [R10-01] STARTING: exporters, importers and foreign-owned firms, grouped once before COVID ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/9: load identity, status flags and the outcomes later R10 files use"
*---------------------------------------------------------------------------
* export_flag  = any export activity (1 yes, 0 no, missing = unknown); in 2022 the
*                file records only direct exporters (export_direct_flag)
* import_flag  = imports reported above zero (never missing)
* fdi_10_flag  = 10% or more of capital held abroad (missing = unknown)
* gross_output_nominal, value_added_nominal = current prices (masked money unit);
* workers = persons employed; dev_nominal_tfp_lp = productivity residual (development only)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year export_flag export_direct_flag import_flag fdi_10_flag workers ///
    gross_output_nominal gross_output_real value_added_nominal dev_nominal_tfp_lp industry2_reported
local have : list want & allvars          // gross_output_real: used by the cohort block when filled
use `have' using "$DATA", clear
isid firm_id year
foreach v in export_flag export_direct_flag import_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}

tempfile firmyear0
save `firmyear0'                          // the firm-year rows; the cohort block keeps one row per firm

display "Step 2/9: the COVID cohort (block shared with R4, copied unchanged from R4-01)"
* The cohort file: the last annual file before COVID reached Indonesia (March 2020).
local cohort_year 2019

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
sort firm_id year
egen byte firm1 = tag(firm_id)
local pyrs "`p2'–`cohort_year'"
local eyrs "`p2'–`p1'"
display "   cohort: firms in `cohort_year'; groups from `pyrs'; followed `f1', `f2', `f3'"
quietly count if firm1 & in_cohort
local n_coh = r(N)
quietly count if firm1 & in_cohort & new_to_file == 0
local n_inc = r(N)
local n_new = `n_coh' - `n_inc'
display "   cohort firms `n_coh': in an earlier file too `n_inc', new in `cohort_year' `n_new'"
assert `n_inc' > 0 & `n_new' >= 0
tempfile firmyear
save `firmyear'

*---------------------------------------------------------------------------
display "Step 3/9: count firms in / not in / left out, per grouping and rule"
*---------------------------------------------------------------------------
* Rows 1-5 of each grouping: main rule, stricter, early files only, base file only
* (all on firms also in an earlier file), then main rule adding the firms new in `cohort_year'.
keep if firm1 & in_cohort
tempname hp
tempfile counts
postfile `hp' byte(panel row_order) str8 grouping str8 rule str80 row_label ///
    long(firms_total n_in_group n_other n_left_out_mixed n_left_out_unknown n_other_some_yes) using `counts', replace
local gi 0
foreach x in exp imp fdi {
    local ++gi
    local ri 0
    foreach r in main strict early base mainall {
        local ++ri
        local rv = cond("`r'" == "mainall", "main", "`r'")
        local smp = cond("`r'" == "mainall", "1", "new_to_file == 0")
        quietly count if `smp'
        local tot = r(N)
        quietly count if `smp' & grp_`rv'_`x' == 1
        local n1 = r(N)
        quietly count if `smp' & grp_`rv'_`x' == 0
        local n0 = r(N)
        * left out: no known answer in the rule's files; stricter rule also leaves out mixed firms
        if "`r'" == "early" {
            quietly count if `smp' & missing(grp_early_`x')
            local nu = r(N)
            local nm = 0
        }
        else if "`r'" == "base" {
            quietly count if `smp' & missing(grp_base_`x')
            local nu = r(N)
            local nm = 0
        }
        else {
            quietly count if `smp' & k_`x' == 0
            local nu = r(N)
            quietly count if `smp' & k_`x' > 0 & missing(grp_`rv'_`x')
            local nm = r(N)
        }
        assert `tot' == `n1' + `n0' + `nu' + `nm'
        * other firms that still said "yes" at least once (main rule only; 0 by definition otherwise)
        local nsy 0
        if "`rv'" == "main" {
            quietly count if `smp' & grp_main_`x' == 0 & s_`x' > 0
            local nsy = r(N)
        }
        if "`r'" == "main"    local lab "Main rule: yes in half or more"
        if "`r'" == "strict"  local lab "Stricter: yes every time"
        if "`r'" == "early"   local lab "`eyrs' answers only"
        if "`r'" == "base"    local lab "`cohort_year' answer only"
        if "`r'" == "mainall" local lab "Main rule + firms new in `cohort_year'"
        post `hp' (`gi') (`ri') ("`x'") ("`r'") ("`lab'") (`tot') (`n1') (`n0') (`nm') (`nu') (`nsy')
    }
}

display "Step 4/9: overlaps of the three groups (main rule, firms also in an earlier file)"
* Every firm falls in exactly one row; export status unknown is its own row.
keep if new_to_file == 0
gen byte combo = .
replace combo = 1 if grp_main_exp == 1 & grp_main_imp == 1 & grp_main_fdi == 1
replace combo = 2 if grp_main_exp == 1 & grp_main_imp == 1 & grp_main_fdi == 0
replace combo = 3 if grp_main_exp == 1 & grp_main_imp == 0 & grp_main_fdi == 1
replace combo = 4 if grp_main_exp == 0 & grp_main_imp == 1 & grp_main_fdi == 1
replace combo = 5 if grp_main_exp == 1 & grp_main_imp == 0 & grp_main_fdi == 0
replace combo = 6 if grp_main_exp == 0 & grp_main_imp == 1 & grp_main_fdi == 0
replace combo = 7 if grp_main_exp == 0 & grp_main_imp == 0 & grp_main_fdi == 1
replace combo = 8 if grp_main_exp == 0 & grp_main_imp == 0 & grp_main_fdi == 0
replace combo = 9 if missing(grp_main_exp) & !missing(grp_main_imp, grp_main_fdi)
replace combo = 10 if missing(combo)          // import or ownership answer unknown (none on the development file)
local c1  "All three"
local c2  "Exporter + importer only"
local c3  "Exporter + foreign-owned only"
local c4  "Importer + foreign-owned only"
local c5  "Exporter only"
local c6  "Importer only"
local c7  "Foreign-owned only"
local c8  "None of the three"
local c9  "Export answer unknown"
local c10 "Import or ownership answer unknown"
forvalues c = 1/10 {
    quietly count if combo == `c'
    local nc = r(N)
    if `c' < 10 | `nc' > 0 post `hp' (4) (`c') ("overlap") ("main") ("`c`c''") (`n_inc') (`nc') (.) (.) (.) (.)
    if `c' == 9 {
        foreach q in 1 0 {
            quietly count if combo == 9 & grp_main_imp == `q'
            local n9`q' = r(N)
        }
    }
}
postclose `hp'
display "   of the `n_inc' firms, export answer unknown: importers `n91', not importers `n90'"
* foreign-owned firms that also import (for the notes; export unknown included)
quietly count if grp_main_fdi == 1
local n_fdi = r(N)
quietly count if grp_main_fdi == 1 & grp_main_imp == 1
local pct_fdiimp = strtrim(string(100 * r(N) / `n_fdi', "%9.0f"))

*---------------------------------------------------------------------------
display "Step 5/9: figure numbers -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `counts', clear
gen double pct_in_group_of_known = 100 * n_in_group / (n_in_group + n_other) if panel < 4
gen str44 grouping_label = cond(grouping == "exp", "Exporters (any exports)", ///
    cond(grouping == "imp", "Importers (any imports)", ///
    cond(grouping == "fdi", "Foreign-owned (10% or more of capital)", "Overlap of the three groups (main rule)")))
gen str120 note = ""
replace note = "Firms also in the `p2' or `p1' file" if panel < 4 & rule != "mainall"
replace note = "Adds firms first seen in `cohort_year': their answers come from `cohort_year' only" if rule == "mainall"
replace note = "Firms also in the `p2' or `p1' file; n_in_group = firms in this row" if panel == 4
replace note = "Of which importers: `n91'; not importers: `n90'" if panel == 4 & row_order == 9
quietly summarize n_in_group if panel == 4
assert r(sum) == `n_inc'
sort panel row_order
replace note = note + "; table only, not drawn" if panel == 4
order panel row_order grouping grouping_label rule row_label firms_total n_in_group n_other ///
      n_left_out_mixed n_left_out_unknown n_other_some_yes pct_in_group_of_known note
format firms_total n_in_group n_other n_left_out_mixed n_left_out_unknown n_other_some_yes %9.0f
format pct_in_group_of_known %6.2f
export delimited using "tables/01_covid_cohort_groups.csv", datafmt replace
list panel rule row_label n_in_group n_other n_left_out_mixed n_left_out_unknown, noobs sep(5) abbreviate(24)
tempfile fig
save `fig'

*---------------------------------------------------------------------------
display "Step 6/9: support table: firms per group and file, usable for each outcome -> CSV"
*---------------------------------------------------------------------------
* Firms also in an earlier file, main-rule groups, every file from `p2' to `f3'.
* Counts: in the file; output > 0; workers > 0; value added > 0; value added per
* worker defined (both > 0); productivity residual present; export answer known
* (in `f3' also the direct-export answer). Every later R10 exhibit rests on these.
use `firmyear', clear
keep if in_cohort & new_to_file == 0 & inrange(year, `p2', `f3')
gen byte one      = 1
gen byte out_pos  = gross_output_nominal > 0 & !missing(gross_output_nominal)
gen byte wk_pos   = workers > 0 & !missing(workers)
gen byte va_pos   = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte vapw_ok  = va_pos & wk_pos
gen byte tfp_ok   = !missing(dev_nominal_tfp_lp)
gen byte exp_known    = !missing(export_flag)
gen byte expdir_known = !missing(export_direct_flag)
tempfile sup
local first 1
foreach x in all exp imp fdi {
    preserve
    if "`x'" == "all" gen byte grp = 9
    else {
        gen byte grp = grp_main_`x'
        replace grp = 8 if missing(grp)      // left out: no known answer
    }
    collapse (sum) firms_in_file = one n_output_pos = out_pos n_workers_pos = wk_pos ///
        n_va_pos = va_pos n_va_per_worker = vapw_ok n_productivity_residual = tfp_ok ///
        n_export_known = exp_known n_direct_export_known = expdir_known, by(grp year)
    gen str8 grouping = "`x'"
    if !`first' append using `sup'
    save `sup', replace
    local first 0
    restore
}
use `sup', clear
gen str40 group_label = ""
replace group_label = "All firms also in an earlier file" if grp == 9
replace group_label = "In the group"                     if grp == 1
replace group_label = "Other firms"                      if grp == 0
replace group_label = "Left out: no known answer"        if grp == 8
gen byte gorder = 1*(grouping == "all") + 2*(grouping == "exp") + 3*(grouping == "imp") + 4*(grouping == "fdi")
gen byte sorder = 1*(grp == 9) + 2*(grp == 1) + 3*(grp == 0) + 4*(grp == 8)
* each group's firms in the file, as % of its `cohort_year' count (leaving the file is not closing)
bysort grouping grp: egen long nb = total(cond(year == `cohort_year', firms_in_file, .))
gen double pct_of_cohort_file_firms = 100 * firms_in_file / nb
drop nb
gen str60 note = ""
replace note = "Groups are formed from this file and the two before" if year == `cohort_year'
replace note = "Export question asks about direct exports only" if n_direct_export_known > 0
replace note = "No productivity residual in this file" if n_productivity_residual == 0
sort gorder sorder year
foreach v of varlist firms_in_file-n_direct_export_known {
    assert `v' <= firms_in_file
}
order grouping group_label year firms_in_file pct_of_cohort_file_firms n_output_pos n_workers_pos n_va_pos ///
      n_va_per_worker n_productivity_residual n_export_known n_direct_export_known note
keep grouping-note
format firms_in_file n_* %9.0f
format pct_of_cohort_file_firms %6.1f
export delimited using "tables/01_covid_cohort_groups_support.csv", datafmt replace
quietly summarize firms_in_file if grouping != "all" & inlist(group_label, "In the group", "Other firms")
local min_cell = r(min)
display "   smallest group-file count (in the group / other firms, `p2'–`f3'): `min_cell'"
if `min_cell' < 30 display as error "   WARNING: a group has fewer than 30 firms in some file"

*---------------------------------------------------------------------------
display "Step 7/9: each group in the `cohort_year' file: size, output, value added per worker, industry -> CSV"
*---------------------------------------------------------------------------
use `firmyear', clear
keep if in_cohort & new_to_file == 0 & year == `cohort_year'
gen double va_per_worker = value_added_nominal / workers if workers > 0 & value_added_nominal > 0
gen byte large100 = workers > 100 if !missing(workers)
quietly levelsof industry2_reported, local(inds)       // every industry of these firms: absent = 0%, written
tempname hq
tempfile prof
postfile `hq' str8 grouping byte grp str40 measure double value long n using `prof', replace
foreach x in all exp imp fdi {
    if "`x'" == "all" gen byte g = 9
    else gen byte g = cond(missing(grp_main_`x'), 8, grp_main_`x')
    quietly levelsof g, local(gl)
    foreach q of local gl {
        quietly count if g == `q'
        local ng = r(N)
        post `hq' ("`x'") (`q') ("firms") (`ng') (`ng')
        foreach m in workers gross_output_nominal va_per_worker {
            quietly summarize `m' if g == `q', detail
            post `hq' ("`x'") (`q') ("median_`m'") (r(p50)) (r(N))
        }
        quietly summarize large100 if g == `q'
        post `hq' ("`x'") (`q') ("pct_over_100_workers") (100 * r(mean)) (r(N))
        foreach s of local inds {
            quietly count if g == `q' & industry2_reported == `"`s'"'
            post `hq' ("`x'") (`q') ("pct_industry_`s'") (100 * r(N) / `ng') (r(N))
        }
    }
    drop g
}
postclose `hq'
use `prof', clear
gen str40 group_label = cond(grp == 9, "All firms also in an earlier file", cond(grp == 1, "In the group", ///
    cond(grp == 0, "Other firms", "Left out: no known answer")))
gen str80 unit = ""
replace unit = "firms"                                             if measure == "firms"
replace unit = "persons"                                           if measure == "median_workers"
replace unit = "current prices, masked money unit"                 if inlist(measure, "median_gross_output_nominal", "median_va_per_worker")
replace unit = "% of the group's firms"                            if strpos(measure, "pct_")
gen byte gorder = 1*(grouping == "all") + 2*(grouping == "exp") + 3*(grouping == "imp") + 4*(grouping == "fdi")
gen byte sorder = 1*(grp == 9) + 2*(grp == 1) + 3*(grp == 0) + 4*(grp == 8)
gen long morder = _n
sort gorder sorder morder
gen int year = `cohort_year'
order grouping group_label year measure value unit n
keep grouping group_label year measure value unit n
format value %14.2f
export delimited using "tables/01_covid_cohort_groups_profile.csv", datafmt replace
list if strpos(measure, "median") | measure == "firms", noobs sep(0) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 8/9: draw the groups (stacked bars with counts); the overlap rows stay in the table"
*---------------------------------------------------------------------------
use `fig', clear
* numbers for the notes, read from the table (never typed)
quietly summarize n_in_group if panel == 4 & inlist(row_order, 1, 2)
local n_expimp = r(sum)
quietly summarize n_in_group if grouping == "exp" & rule == "main"
local n_exp = r(sum)
local pct_expimp = strtrim(string(100 * `n_expimp' / `n_exp', "%9.0f"))
quietly summarize n_left_out_unknown if grouping == "exp" & rule == "main"
local pct_expunk = strtrim(string(100 * r(mean) / `n_inc', "%9.0f"))
quietly summarize n_in_group if grouping == "imp" & rule == "main"
local pct_imp = strtrim(string(100 * r(mean) / `n_inc', "%9.0f"))
local n_inc_s = strtrim(string(`n_inc', "%9.0fc"))
* panel (d), the overlap of the three groups, is a partition of one set of firms:
* it is kept in the CSV and the companion table, and summed up in the notes
keep if panel < 4

* row positions: panel p occupies a heading line and its rows; one blank line between panels
gen double y = .
local ypos 0
local ylab ""
forvalues p = 1/3 {
    if `p' == 1 local head "(a) Exporters"
    if `p' == 2 local head "(b) Importers"
    if `p' == 3 local head "(c) Foreign-owned, 10%+"
    local ylab `"`ylab' `ypos' "{bf:`head'}""'
    quietly count if panel == `p'
    local nr = r(N)
    forvalues i = 1/`nr' {
        local ++ypos
        quietly replace y = `ypos' if panel == `p' & row_order == `i'
    }
    local ypos = `ypos' + 1.6
}
sort panel row_order
forvalues i = 1/`=_N' {
    local yy = y[`i']
    local ll = row_label[`i']
    local ylab `"`ylab' `yy' "`ll'""'
}
local ymax = `ypos' - 1

* segment ends
gen double x0 = 0
gen double x1 = n_in_group
gen double x2 = x1 + n_other
gen double x3 = x2 + n_left_out_mixed
gen double x4 = x3 + n_left_out_unknown
quietly summarize x4
local step = 10^floor(log10(r(max)))                        // axis step that grows with the counts
if r(max)/`step' < 2       local step = `step'/5
else if r(max)/`step' < 5  local step = `step'/2
local xtop = `step' * ceil(1.1*r(max)/`step')
local wide = 0.045 * `xtop'                                   // a segment this wide holds its count
* count labels: inside a segment when it is wide enough, otherwise just right of it
gen str8 l_in  = string(n_in_group, "%9.0fc")
gen double xin_in  = x1 / 2 if n_in_group >= 1.3 * `wide'     // dark segment: needs more room
gen double xin_out = x1     if n_in_group < 1.3 * `wide' & n_in_group > 0
replace xin_out = 0 if n_in_group == 0
gen str8 l_oth = string(n_other, "%9.0fc") if n_other > 0
gen double xo = (x1 + x2) / 2 if n_other > 0
gen str8 l_mix = string(n_left_out_mixed, "%9.0fc") if n_left_out_mixed >= `wide'
gen double xm = (x2 + x3) / 2 if l_mix != ""
gen str8 l_unk = string(n_left_out_unknown, "%9.0fc") if n_left_out_unknown >= `wide'
gen double xu = (x3 + x4) / 2 if l_unk != ""
* narrow left-out segments: count printed after the bar end
gen str20 l_end = ""
replace l_end = string(n_left_out_mixed, "%9.0fc") if n_left_out_mixed > 0 & n_left_out_mixed < `wide'
replace l_end = l_end + cond(l_end != "", " + ", "") + string(n_left_out_unknown, "%9.0fc") ///
    if n_left_out_unknown > 0 & n_left_out_unknown < `wide'
gen double xe = x4 if l_end != ""
gen double yl = y - 0.04          // text sits slightly low in Stata: lift the count labels to the bar centre

* Notes: one text, wrapped here into lines of at most 102 characters (PDF text runs wider than the PNG)
local ntext "Notes: Firms = the `n_inc_s' firms in the `cohort_year' file, the last before COVID, that were also in the `p2' or `p1' file. Each is grouped once, from its own `pyrs' answers, and keeps that group in later years. Main rule: in the group if yes in at least half of its known answers, else other firms; stricter: yes every time vs never yes (firms with both answers left out). No known answer = left out, never counted as no (export status unknown for `pct_expunk'% of firms). Foreign-owned = 10%+ of capital held abroad. The groups overlap: `pct_expimp'% of exporters and `pct_fdiimp'% of foreign-owned firms also import. Files from `p2' on record far more importers (likely a recording change): `pct_imp'% of these firms count as importers. This shows who the firms were before COVID, not how COVID affected them. Firm links are fictional in the development data, so a firm's earlier answers may be another firm's: use the real BPS files."
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

twoway (rbar x0 x1 y, horizontal barwidth(0.86) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar x1 x2 y, horizontal barwidth(0.86) fcolor(white) lcolor(gs6) lwidth(vthin)) ///
    (rbar x2 x3 y if n_left_out_mixed > 0, horizontal barwidth(0.86) fcolor(gs10) lcolor(gs10) lwidth(vthin)) ///
    (rbar x3 x4 y if n_left_out_unknown > 0, horizontal barwidth(0.86) fcolor(gs14) lcolor(gs12) lwidth(vthin)) ///
    (scatter yl xin_in if !missing(xin_in), msymbol(none) mlabel(l_in) mlabpos(0) mlabcolor(white) mlabsize(vsmall)) ///
    (scatter yl xin_out if !missing(xin_out), msymbol(none) mlabel(l_in) mlabpos(3) mlabgap(0.5) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter yl xo if !missing(xo), msymbol(none) mlabel(l_oth) mlabpos(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter yl xm if !missing(xm), msymbol(none) mlabel(l_mix) mlabpos(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter yl xu if !missing(xu), msymbol(none) mlabel(l_unk) mlabpos(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter yl xe if !missing(xe), msymbol(none) mlabel(l_end) mlabpos(3) mlabgap(0.5) mlabcolor(black) mlabsize(vsmall)), ///
    yscale(reverse noline range(-0.4 `=`ymax' + 0.4')) ///
    ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall) labgap(1)) ytitle("") ///
    xscale(range(0 `xtop') noline) ///
    xlabel(0(`step')`xtop', format(%9.0fc) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Number of firms", size(vsmall)) ///
    legend(order(1 "In the group" 2 "Other firms: yes in under half" ///
                 3 "Left out: yes and no (stricter rule only)" 4 "Left out: no known answer") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(4) symysize(2.5) keygap(1) colgap(16) rowgap(0.4)) ///
    title("Figure R10-01. Exporters, importers and foreign-owned firms before COVID", ///
        size(small) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(l+5 r+4)) plotregion(style(none) margin(t=1 b=1)) ///
    xsize(8) ysize(9.5)

graph export "figures/01_covid_cohort_groups.png", width(2400) replace
graph export "figures/01_covid_cohort_groups.pdf", replace

*---------------------------------------------------------------------------
display "Step 9/9: companion table - every plotted bar, from the CSV numbers"
*---------------------------------------------------------------------------
use `fig', clear
sort panel row_order
local nr = _N
local ttl "Table R10-01. Exporters, importers and foreign-owned firms before COVID: every plotted bar (and the overlap rows)"
putpdf clear
putpdf begin, landscape font("Times New Roman", 9) margin(all, 0.6in)
putpdf paragraph, halign(left)
putpdf text ("`ttl'"), bold font("Times New Roman", 11)
matrix colw = (17, 25, 10, 13, 12, 13, 10)        // column widths, % of the page
putpdf table T = (`=`nr' + 1', 7), border(all, nil) width(colw)
local c 0
foreach h in "Panel" "Row (as on the chart)" "In the group" "Other firms" ///
    "Left out: yes and no" "Left out: no known answer" "Firms in the row" {
    local ++c
    putpdf table T(1, `c') = ("`h'"), bold halign(`=cond(`c' <= 2, "left", "right")')
}
putpdf table T(1, .), border(top) border(bottom)
forvalues i = 1/`nr' {
    local r = `i' + 1
    local pn = panel[`i']
    local pl = cond(`pn' == 1, "(a) Exporters", cond(`pn' == 2, "(b) Importers", ///
        cond(`pn' == 3, "(c) Foreign-owned, 10%+", "(d) Overlap, not drawn")))
    if `i' == 1 | `pn' != panel[`i' - 1] putpdf table T(`r', 1) = ("`pl'"), halign(left)   // panel name once
    putpdf table T(`r', 2) = ("`=row_label[`i']'"), halign(left)
    local c 2
    foreach v in n_in_group n_other n_left_out_mixed n_left_out_unknown firms_total {
        local ++c
        local val = cond(missing(`v'[`i']), "", strtrim(string(`v'[`i'], "%12.0fc")))
        if `pn' == 4 & "`v'" == "firms_total" local val ""        // (d): rows split one set of firms
        putpdf table T(`r', `c') = ("`val'"), halign(right)
    }
    if `pn' != panel[`i' + 1] & `i' < `nr' putpdf table T(`r', .), border(bottom, single, lightgray)
}
putpdf table T(`=`nr' + 1', .), border(bottom)
putpdf paragraph, spacing(before, 6pt)
putpdf text ("`ntext' Other firms: main rule = yes in fewer than half of the known answers (CSV column n_other_some_yes counts those that said yes at least once); stricter rule = never yes. Panel (d) is not drawn: 'In the group' = firms with that combination of the three main-rule groups; the rows add up to the `n_inc_s' firms.")
putpdf paragraph
putpdf text ("`srcnote'")
putpdf paragraph
putpdf text ("`devnote'")
putpdf save "tables/01_covid_cohort_groups_table.pdf", replace
quietly count if panel < 4
display "   table -> tables/01_covid_cohort_groups_table.pdf (`nr' rows = `r(N)' plotted bars + `=`nr' - r(N)' overlap rows)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_covid_cohort_groups.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
