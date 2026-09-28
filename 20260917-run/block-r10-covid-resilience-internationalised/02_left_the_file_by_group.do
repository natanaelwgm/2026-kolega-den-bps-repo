/*==========================================================================
  R10-02  Did exporters, importers and foreign-owned firms stay in the
          survey files more often than other firms after COVID? The firms
          of the last annual file before COVID are grouped once from their
          own earlier answers and followed in the next three files; the same
          count for the firms of a normal-years file shows what the method
          gives when nothing special happens.
  Answers Bu Deasy R10: "Were internationally integrated firms more
          resilient during COVID?" - outcome "survival", strategy
          "Pre-2019 exporter/importer/FDI x Post2020".
  Survival here = still in the survey files. The files have no closure
          record, and on the development data firm links are fictional, so
          who stays or leaves means nothing here: read it on the real BPS panel.
  Blocks : "COVID COHORT AND STATES" (from R4-01) and "R10 FROZEN PRE-COVID
          GROUPS" (from R10-01) are copied unchanged from
          01_covid_cohort_groups.do; do not edit them here. They run once per
          starting file (the COVID-years file and the normal-years file).
  Output : figures/02_left_the_file_by_group.png (+ .pdf)
           tables/02_left_the_file_by_group.csv        (plotted shares; states)
           tables/02_left_the_file_by_group_gaps.csv   (gaps to other firms, same
                                                        industry and province)
           tables/02_left_the_file_by_group_table.pdf      (every plotted point)
           tables/02_left_the_file_by_group_regression.pdf (the gap models)
  Uses base Stata only (regress); no add-on needed.
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
log using "logs/02_left_the_file_by_group.log", replace text
timer clear 1
timer on 1
display _newline "=== [R10-02] STARTING: firms still in the survey files after COVID, by group ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load identity, industry, province and the three status flags"
*---------------------------------------------------------------------------
* export_flag  = any export activity (1 yes, 0 no, missing = unknown)
* import_flag  = imports reported above zero (never missing)
* fdi_10_flag  = 10% or more of capital held abroad (missing = unknown)
* industry2_reported, province_code = never change within a firm (used for the gap)
* workers, gross_output_nominal = needed by the cohort block (not used here)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year export_flag import_flag fdi_10_flag workers ///
    gross_output_nominal gross_output_real industry2_reported province_code
local have : list want & allvars          // gross_output_real: used by the cohort block when filled
use `have' using "$DATA", clear
isid firm_id year
foreach v in export_flag import_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}
assert !missing(industry2_reported, province_code)
tempfile firmyear0
save `firmyear0'

*---------------------------------------------------------------------------
display "Step 2/8: the two starting files (read from the data)"
*---------------------------------------------------------------------------
* COVID reached Indonesia in March 2020: the COVID-years starting file is the last
* annual file before 2020, followed in the next three files (the COVID years).
* Normal-years starting file: the latest file with two files before it whose next
* three files are the next three calendar years, all before 2020 (no missing year,
* no COVID year). Same code, same rules: it shows what the method gives without COVID.
local covid_first 2020
quietly levelsof year, local(allfiles)
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
display "   COVID-years starting file `covid_start'; normal-years starting file `bench_start'"

*---------------------------------------------------------------------------
display "Step 3/8: for each starting file, its firms, their groups and later files"
*---------------------------------------------------------------------------
* The two blocks below are copied unchanged from R10-01 (the first from R4-01).
* After them, keep one row per firm: firms of the starting file that were also in
* one of the two files before it (new_to_file == 0, R10's main sample).
tempfile firms
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
* ---- one row per firm: firms of the starting file also in one of the two files before ----
keep if in_cohort & new_to_file == 0 & year == `cohort_year'
isid firm_id
gen int  start_file = `cohort_year'
gen byte section    = cond(`cohort_year' == `covid_start', 1, 2)     // 1 = COVID years, 2 = normal years
* in the k-th later file (1 = yes), read from the presence pattern, e.g. "110"
forvalues k = 1/3 {
    gen byte infile_`k' = substr(pattern, `k', 1) == "1"
}
* still in the files k files later = in that file or in a later one: a firm that
* misses a file and comes back later was still there. still_3 = in the last file.
gen byte still_1 = infile_1 | infile_2 | infile_3
gen byte still_2 = infile_2 | infile_3
gen byte still_3 = infile_3
* the same count as the R4 states: left at once = not still in the first later file,
* left the files = not still in the last later file
assert (still_1 == 0) == (left_when == 1)
assert (still_3 == 0) == (state_file == 3)
local lf_`cohort_year' "`f1' `f2' `f3'"          // the three later files
local ef_`cohort_year' "`p2' `p1'"               // the two files before
keep firm_id start_file section industry2_reported province_code pattern state_file left_when ///
    grp_main_exp grp_main_imp grp_main_fdi infile_* still_*
if !`first' append using `firms'
save `firms', replace
local first 0
}
foreach s in covid bench {
    local q = cond("`s'" == "covid", "`covid_start'", "`bench_start'")
    forvalues k = 1/3 {
        local `s'_f`k' : word `k' of `lf_`q''
    }
    local `s'_p2 : word 1 of `ef_`q''
    local `s'_p1 : word 2 of `ef_`q''
}
display "   `covid_start' firms followed in `covid_f1' `covid_f2' `covid_f3'; `bench_start' firms in `bench_f1' `bench_f2' `bench_f3'"

*---------------------------------------------------------------------------
display "Step 4/8: share of each group still in the files, per later file (drawn) and the four states"
*---------------------------------------------------------------------------
* Shares: firms still in the files / the group's firms in the starting file, in %.
* 95% interval: Wilson interval for a share. States (as in R4, table only):
* stayed = in all three later files; absent, then back; left later; left at once.
use `firms', clear
local gl_exp "Exporters"
local gl_imp "Importers"
local gl_fdi "Foreign-owned, 10%+"
tempname pf
tempfile res
postfile `pf' byte(section gi) str8 grouping int start_file byte grp str12 row_kind byte step int year ///
    str48 item byte drawn double(firms base_firms pct ci_lo ci_hi firms_in_file) using `res', replace
foreach s in 1 2 {
    local sf = cond(`s' == 1, `covid_start', `bench_start')
    forvalues k = 1/3 {
        local y`k' = cond(`s' == 1, `covid_f`k'', `bench_f`k'')      // the k-th later file
    }
    local gi 0
    foreach x in exp imp fdi {
        local ++gi
        * firms left out of this grouping: no known answer in the three files
        quietly count if section == `s' & missing(grp_main_`x')
        post `pf' (`s') (`gi') ("`x'") (`sf') (.) ("left_out") (0) (`sf') ("Left out: no known answer") (0) ///
            (r(N)) (.) (.) (.) (.) (.)
        foreach g in 1 0 {
            quietly count if section == `s' & grp_main_`x' == `g'
            local N = r(N)
            post `pf' (`s') (`gi') ("`x'") (`sf') (`g') ("share") (0) (`sf') ("Starting file") (1) ///
                (`N') (`N') (cond(`N' > 0, 100, .)) (.) (.) (`N')
            forvalues k = 1/3 {
                quietly count if section == `s' & grp_main_`x' == `g' & still_`k'
                local n = r(N)
                quietly count if section == `s' & grp_main_`x' == `g' & infile_`k'
                local nf = r(N)
                local lo .
                local hi .
                if `N' > 0 {
                    quietly cii proportions `N' `n', wilson
                    local lo = 100 * r(lb)
                    local hi = 100 * r(ub)
                }
                post `pf' (`s') (`gi') ("`x'") (`sf') (`g') ("share") (`k') (`y`k'') ///
                    ("Still in the files") (1) (`n') (`N') (cond(`N' > 0, 100 * `n' / `N', .)) (`lo') (`hi') (`nf')
            }
            * the four states by the last later file (they add up to the group's firms)
            local j 0
            foreach c in "state_file == 1" "state_file == 2" "state_file == 3 & left_when == 2" "left_when == 1" {
                local ++j
                local it = cond(`j' == 1, "Stayed: in all three later files", cond(`j' == 2, ///
                    "Absent, then back in the last later file", cond(`j' == 3, ///
                    "Left later: gone by the last later file", "Left at once: in none of the three")))
                quietly count if section == `s' & grp_main_`x' == `g' & `c'
                post `pf' (`s') (`gi') ("`x'") (`sf') (`g') ("state") (`j') (`y3') ("`it'") (0) ///
                    (r(N)) (`N') (cond(`N' > 0, 100 * r(N) / `N', .)) (.) (.) (.)
            }
        }
    }
}
postclose `pf'

*---------------------------------------------------------------------------
display "Step 5/8: gap to other firms of the same industry and province (linear probability model)"
*---------------------------------------------------------------------------
* One row per firm and later file (three rows per firm). Outcome: still in the files,
* 0 or 100, so a coefficient is a gap in percentage points. Each file gets its own
* average for every industry and every province, so the gap compares firms of the
* same industry and province. Year by year: one gap per later file; average: one gap
* for the three later files. Difference: the COVID-years gap minus the normal-years
* gap (the survival version of Bu Deasy's "x Post2020": the normal-years firms play
* the "before" role, because every firm of the starting file is in the files up to
* it by construction). Standard errors clustered by firm. Base Stata regress (the
* averages enter as dummy variables).
use `firms', clear
egen int ind  = group(industry2_reported)
egen int prov = group(province_code)
tempname pg
tempfile gaps
postfile `pg' byte(section gi) str8 grouping int start_file str8 model byte step int year ///
    double(b se ci_lo ci_hi p n_obs n_firms n_group n_other pct_other) using `gaps', replace
foreach s in 1 2 {
    local sf = cond(`s' == 1, `covid_start', `bench_start')
    forvalues k = 1/3 {
        local y`k' = cond(`s' == 1, `covid_f`k'', `bench_f`k'')      // the k-th later file
    }
    local gi 0
    foreach x in exp imp fdi {
        local ++gi
        preserve
        keep if section == `s' & !missing(grp_main_`x')
        quietly count if grp_main_`x' == 1
        local ng = r(N)
        quietly count if grp_main_`x' == 0
        local no = r(N)
        expand 3
        bysort firm_id: gen byte step = _n
        gen double still = 100 * cond(step == 1, still_1, cond(step == 2, still_2, still_3))
        forvalues k = 1/3 {
            gen byte g_`k' = grp_main_`x' * (step == `k')
        }
        * year by year
        quietly regress still g_1 g_2 g_3 i.step#i.ind i.step#i.prov, vce(cluster firm_id)
        local nobs = e(N)
        local ncl  = e(N_clust)
        matrix T = r(table)
        forvalues k = 1/3 {
            quietly summarize still if step == `k' & grp_main_`x' == 0 & e(sample)
            local mo = r(mean)
            post `pg' (`s') (`gi') ("`x'") (`sf') ("by_file") (`k') (`y`k'') ///
                (T[1, `k']) (T[2, `k']) (T[5, `k']) (T[6, `k']) (T[4, `k']) (`nobs') (`ncl') (`ng') (`no') (`mo')
        }
        * average of the three later files (drawn as the gap on the chart)
        quietly regress still grp_main_`x' i.step#i.ind i.step#i.prov, vce(cluster firm_id)
        matrix T = r(table)
        quietly summarize still if grp_main_`x' == 0 & e(sample)
        post `pg' (`s') (`gi') ("`x'") (`sf') ("average") (0) (.) ///
            (T[1, 1]) (T[2, 1]) (T[5, 1]) (T[6, 1]) (T[4, 1]) (e(N)) (e(N_clust)) (`ng') (`no') (r(mean))
        restore
    }
}
* COVID-years gap minus normal-years gap: both starting files in one model, every
* average and each gap separate by starting file (same point estimates as above);
* a firm can be in both starting files, so errors are clustered by firm
local gi 0
foreach x in exp imp fdi {
    local ++gi
    preserve
    keep if !missing(grp_main_`x')
    expand 3
    bysort section firm_id: gen byte step = _n
    gen double still = 100 * cond(step == 1, still_1, cond(step == 2, still_2, still_3))
    gen byte g_covid  = grp_main_`x' * (section == 1)
    gen byte g_normal = grp_main_`x' * (section == 2)
    quietly regress still g_covid g_normal i.section#i.step#i.ind i.section#i.step#i.prov, vce(cluster firm_id)
    local nobs = e(N)
    local ncl  = e(N_clust)
    local dfr  = e(df_r)
    quietly lincom g_covid - g_normal
    post `pg' (3) (`gi') ("`x'") (.) ("diff") (0) (.) ///
        (r(estimate)) (r(se)) (r(lb)) (r(ub)) (2 * ttail(`dfr', abs(r(estimate) / r(se)))) ///
        (`nobs') (`ncl') (.) (.) (.)
    restore
}
postclose `pg'

*---------------------------------------------------------------------------
display "Step 6/8: write the tables (numbers before drawing)"
*---------------------------------------------------------------------------
use `res', clear
* structural checks: states add up to the group; shares never rise over the later files
bysort section grouping grp: egen double c_sum = total(firms) if row_kind == "state"
assert c_sum == base_firms if row_kind == "state"
drop c_sum
sort section grouping grp row_kind step
by section grouping grp row_kind: assert pct <= pct[_n - 1] + 1e-9 if row_kind == "share" & _n > 1
gen str20 section_name = cond(section == 1, "COVID years", "Normal years")
gen str24 grouping_label = cond(grouping == "exp", "`gl_exp'", cond(grouping == "imp", "`gl_imp'", "`gl_fdi'"))
gen str20 group_label = cond(grp == 1, "In the group", cond(grp == 0, "Other firms", "Left out"))
gen str24 later_files = cond(section == 1, "`covid_f1' `covid_f2' `covid_f3'", "`bench_f1' `bench_f2' `bench_f3'")
gen byte korder = cond(row_kind == "share", 1, cond(row_kind == "state", 2, 3))
gen byte gorder = cond(grp == 1, 1, cond(grp == 0, 2, 3))
sort section gi korder gorder step
format firms base_firms firms_in_file %9.0f
format pct ci_lo ci_hi %6.1f
order section section_name start_file later_files grouping grouping_label grp group_label row_kind step year ///
    item drawn firms base_firms pct ci_lo ci_hi firms_in_file
keep section-firms_in_file gi korder gorder
export delimited section-firms_in_file using "tables/02_left_the_file_by_group.csv", datafmt replace
list section start_file grouping group_label step year firms base_firms pct ci_lo ci_hi if row_kind == "share", ///
    noobs sepby(section grouping grp) abbreviate(24)
tempfile shares
save `shares'

use `gaps', clear
gen str20 section_name = cond(section == 1, "COVID years", cond(section == 2, "Normal years", "COVID minus normal"))
gen str24 grouping_label = cond(grouping == "exp", "`gl_exp'", cond(grouping == "imp", "`gl_imp'", "`gl_fdi'"))
gen str60 term = cond(model == "average", "In the group, average of the three later files", ///
    "In the group x " + string(year) + " file")
replace term = "COVID-years average gap minus normal-years average gap" if model == "diff"
gen str100 note = "Percentage points; industry x file and province x file averages; SE clustered by firm"
replace note = note + " (both starting files in one model)" if model == "diff"
replace note = note + "; printed on the chart" if inlist(model, "average", "diff")
sort section gi model step
format b se ci_lo ci_hi pct_other %9.4f
format p %6.4f
format n_obs n_firms n_group n_other %9.0f
order section section_name start_file grouping grouping_label model step year term b se ci_lo ci_hi p ///
    n_obs n_firms n_group n_other pct_other note
export delimited section-note using "tables/02_left_the_file_by_group_gaps.csv", datafmt replace
list section grouping model year b se ci_lo ci_hi n_firms n_group n_other pct_other, noobs sepby(section grouping) abbreviate(24)
tempfile gapres
save `gapres'

*---------------------------------------------------------------------------
display "Step 7/8: lines per group, three panels side by side, gaps printed in each panel"
*---------------------------------------------------------------------------
* numbers for the notes and panel texts, read from the tables (never typed)
use `firms', clear
quietly count if section == 1
local n_c = strtrim(string(r(N), "%9.0fc"))
quietly count if section == 2
local n_b = strtrim(string(r(N), "%9.0fc"))
* importer share of each starting file's grouped firms (the import question was
* recorded differently in the later files, so the two importer groups differ)
foreach s in 1 2 {
    quietly summarize grp_main_imp if section == `s', meanonly
    local impsh_`s' = strtrim(string(100 * r(mean), "%9.0f"))
}
use `gapres', clear
keep if inlist(model, "average", "diff")
forvalues i = 1/`=_N' {
    local s  = section[`i']
    local g  = gi[`i']
    local bs = strtrim(string(b[`i'], "%9.1f"))
    if b[`i'] >= 0.05 local bs "+`bs'"
    local gap_`s'_`g' "`bs' (`=strtrim(string(ci_lo[`i'], "%9.1f"))' to `=strtrim(string(ci_hi[`i'], "%9.1f"))')"
}
use `shares', clear
keep if row_kind == "share"
local sh = 4.9                                    // panel k sits at x = step + (k - 1) * sh
gen double x = step + (gi - 1) * `sh'
* shared y scale: 100 at the top, a round number below the lowest point
quietly summarize pct
local ybot = 10 * floor((r(min) - 3) / 10)
local span = 100 - `ybot'
local ytop = 100 + 0.38 * `span'                  // room for the panel headings and gaps
* endpoint labels (last later file): at the line end, pushed apart when they would overlap
gen str8 elab = strtrim(string(pct, "%5.1f")) if step == 3
gen double ey = pct if step == 3
gsort gi -ey
by gi: replace ey = min(ey, ey[_n - 1] - 0.065 * `span') if step == 3 & _n > 1 & !missing(ey[_n - 1])
gen double ex = x + 0.12 if step == 3
sort section gi grp step
* x labels: the COVID-years file, the normal-years file in brackets
local xl ""
forvalues g = 1/3 {
    forvalues k = 0/3 {
        local xc = cond(`k' == 0, "`covid_start'", "`covid_f`k''")
        local xb = cond(`k' == 0, "`bench_start'", "`bench_f`k''")
        local xl `"`xl' `=`k' + (`g' - 1) * `sh'' `""`xc'" "(`xb')""'"'
    }
}
* one line per series and panel (so no line runs from one panel into the next)
local plots ""
local np 0
forvalues g = 1/3 {
    foreach s in 1 2 {
        foreach q in 1 0 {
            local lc = cond(`s' == 1, "black", "gs9")
            local lp = cond(`q' == 1, "solid", "shortdash")
            local ms = cond(`s' == 1, cond(`q' == 1, "O", "Oh"), cond(`q' == 1, "T", "Th"))
            local plots `"`plots' (connected pct x if gi == `g' & section == `s' & grp == `q', sort(x) lcolor(`lc') lpattern(`lp') lwidth(medthin) msymbol(`ms') msize(small) mcolor(`lc') mlwidth(thin))"'
            local ++np
        }
    }
}
* panel headings and the gaps (average of the three later files, 95% range)
local head1 "(a) Exporters"
local head2 "(b) Importers"
local head3 "(c) Foreign-owned, 10%+"
local txt ""
forvalues g = 1/3 {
    local x0 = (`g' - 1) * `sh' - 0.25
    local txt `"`txt' text(`=100 + 0.34 * `span'' `x0' "{bf:`head`g''}", placement(e) size(vsmall))"'
    local txt `"`txt' text(`=100 + 0.255 * `span'' `x0' "Gap `covid_f1'–`covid_f3': `gap_1_`g''", placement(e) size(vsmall) color(black))"'
    local txt `"`txt' text(`=100 + 0.185 * `span'' `x0' "Gap `bench_f1'–`bench_f3': `gap_2_`g''", placement(e) size(vsmall) color(gs8))"'
    local txt `"`txt' text(`=100 + 0.105 * `span'' `x0' "COVID − normal: `gap_3_`g''", placement(e) size(vsmall) color(black))"'
}
local ystep = cond(`span' > 50, 20, 10)
local charttitle "Figure R10-02. Firms still in the survey files after `covid_start': exporters, importers and foreign-owned firms"

* Notes: one text, wrapped into lines of at most 122 characters (PDF text runs wider than the PNG)
local ntext "Notes: Firms = the `n_c' firms in the `covid_start' file that were also in the `covid_p2' or `covid_p1' file, grouped once from their own `covid_p2'–`covid_start' answers: in the group if yes in at least half of the known answers, else other firms; no known answer = left out. Still in the files = in that year's file or a later one. Gray lines: the same for the `n_b' firms of the `bench_start' file (groups from `bench_p2'–`bench_start'), followed through three years without COVID. Gap = in the group minus other firms of the same industry and province, percentage points, average of the three later files, with its 95% range; it can differ from the distance between the lines, which compare all firms. COVID − normal = the first gap minus the second: where its range crosses zero, the group did not clearly fare differently in the COVID years than in normal years. Importers are `impsh_1'% of the `covid_start' firms but `impsh_2'% of the `bench_start' firms (the import question was recorded differently in the later files). Leaving the files is not proof of closing. Foreign-owned = 10%+ of capital held abroad."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 122 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
local fict "Firm links are fictional in the development data, so who stays in the files or leaves them means nothing here: use the real BPS files."

twoway `plots' ///
    (scatter ey ex if section == 1, msymbol(none) mlabel(elab) mlabpos(3) mlabgap(0.3) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter ey ex if section == 2, msymbol(none) mlabel(elab) mlabpos(3) mlabgap(0.3) mlabcolor(gs8) mlabsize(vsmall)), ///
    `txt' ///
    yscale(noline range(`ybot' `ytop')) ///
    ylabel(`ybot'(`ystep')100, format(%9.0f) angle(0) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
    ytitle("% of the starting file's firms still in the files", size(vsmall)) ///
    xscale(noline range(-0.3 `=2 * `sh' + 3.9')) xlabel(`xl', noticks tlength(0) labsize(vsmall) nogrid) ///
    xtitle("Annual file (in brackets: the file for the gray lines)", size(vsmall)) ///
    legend(order(1 "`covid_start' firms: in the group (COVID years)" 2 "`covid_start' firms: other firms" ///
                 3 "`bench_start' firms: in the group (normal years)" 4 "`bench_start' firms: other firms") ///
           cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(6) keygap(1) rowgap(0.3) colgap(6)) ///
    title("`charttitle'", size(small) position(11) justification(left) span) ///
    subtitle("`fict'", size(vsmall) position(11) justification(left) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) plotregion(style(none) margin(t=0 b=1)) ///
    xsize(8) ysize(6.5)

graph export "figures/02_left_the_file_by_group.png", width(2400) replace
graph export "figures/02_left_the_file_by_group.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables - every plotted point, and the gap models (putpdf, no add-on)"
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
* (1) Points table: every point of the chart, panel by panel, line by line (legend
* order), left to right; read from the table saved right after the CSV export.
use `shares', clear
keep if row_kind == "share"
gen byte sorder = cond(section == 1, cond(grp == 1, 1, 2), cond(grp == 1, 3, 4))   // legend order
sort gi sorder step
local npts = _N
gen str28 t_pan = cond(gi == 1, "`head1'", cond(gi == 2, "`head2'", "`head3'"))
gen str48 t_ser = string(start_file) + " firms: " + cond(grp == 1, "in the group", "other firms")
replace t_ser = t_ser + cond(section == 1, " (COVID years)", " (normal years)") if grp == 1
gen str16 t_pos = string(year) + cond(step == 0, " (start)", "")
gen str12 t_v  = string(pct, "%5.1f")
gen str12 t_lo = string(ci_lo, "%5.1f") if step > 0
gen str12 t_hi = string(ci_hi, "%5.1f") if step > 0
gen str12 t_n  = string(firms, "%12.0fc")
gen str12 t_b  = string(base_firms, "%12.0fc")
gen str60 t_status = "drawn"
replace t_status = "drawn; 100% by definition" if step == 0
replace t_status = "drawn; value printed at the line end" if step == 3
replace t_status = t_status + "; gray line" if section == 2
assert _N == `npts' & t_v != ""
quietly count if gi == 1
local r1 = r(N)
quietly count if gi <= 2
local r2 = r(N)
local tnote "Table: every point of Figure R10-02. Percent = firms still in the files (in that file or a later one) / the"
local tnote "`tnote' group's firms in the starting file; 95% Wilson interval for a share (not drawn). Firms still in = the"
local tnote "`tnote' numerator; firms at start = the denominator. Full precision and the four states (stayed, absent then back,"
local tnote "`tnote' left later, left at once) by group: tables/02_left_the_file_by_group.csv."
ctable_pdf t_pan t_ser t_pos t_v t_lo t_hi t_n t_b t_status using "tables/02_left_the_file_by_group_table.pdf", ///
    title("Table R10-02. Firms still in the survey files after `covid_start', by group: every plotted point") ///
    subtitle("Percent of the starting file's firms still in the files; gray lines = the `bench_start' firms (normal years)") ///
    header("Panel" "Line (as in the legend)" "Annual file" "Percent" "95%|low" "95%|high" "Firms|still in" "Firms|at start" "Status") ///
    right(4 5 6 7 8) norepeat(1 2) rules(`r1' `r2') fontsize(9) perpage(28) ///
    notes("`ntext'" "`fict'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/02_left_the_file_by_group_table.pdf (`npts' rows = `npts' plotted points)"

* (2) Regression table (AER style): one column per grouping, coefficient on the
* first line, (standard error) on the second; one panel per starting file.
use `gapres', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/02_left_the_file_by_group_gaps.csv", clear varnames(1) ///
    stringcols(2 4 5 6 9 19)
keep section grouping model step b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 section grouping model step using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9
drop b_csv
tempfile gp
save `gp'
tempname P
tempfile R
postfile `P' str80 t_lab str24(t1 t2 t3) using `R'
local rules ""
local nrow 0
foreach s in 1 2 {
    use `gp', clear
    keep if section == `s'
    local sf = start_file[1]
    forvalues k = 1/3 {
        local y`k' = cond(`s' == 1, `covid_f`k'', `bench_f`k'')
    }
    local pt = cond(`s' == 1, "A. `sf' firms, followed `covid_f1'–`covid_f3' (COVID)", ///
        "B. `sf' firms, followed `bench_f1'–`bench_f3' (normal years)")
    post `P' ("`pt'") ("") ("") ("")
    local ++nrow
    foreach m in by_file average {
        local ks = cond("`m'" == "by_file", "1 2 3", "0")
        foreach k of local ks {
            forvalues g = 1/3 {
                quietly summarize b if model == "`m'" & step == `k' & gi == `g', meanonly
                local b`g' = string(r(mean), "%9.2f")
                quietly summarize se if model == "`m'" & step == `k' & gi == `g', meanonly
                local s`g' = "(" + string(r(mean), "%9.2f") + ")"
            }
            local lab = cond("`m'" == "average", "In the group, average of the three later files (on the chart)", ///
                "In the group × `y`k'' file")
            post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'")
            post `P' ("")      ("`s1'") ("`s2'") ("`s3'")
            local nrow = `nrow' + 2
        }
    }
    forvalues g = 1/3 {
        quietly summarize pct_other if model == "average" & gi == `g', meanonly
        local mo`g' = string(r(mean), "%9.1f")
        foreach v in n_obs n_firms n_group n_other {
            quietly summarize `v' if model == "average" & gi == `g', meanonly
            local `v'`g' = string(r(mean), "%12.0fc")
        }
    }
    post `P' ("Other firms still in the files, % (average of the three files)") ("`mo1'") ("`mo2'") ("`mo3'")
    post `P' ("Observations (firm × later file)") ("`n_obs1'") ("`n_obs2'") ("`n_obs3'")
    post `P' ("Firms (clusters)")                 ("`n_firms1'") ("`n_firms2'") ("`n_firms3'")
    post `P' ("Firms in the group / other firms") ("`n_group1' / `n_other1'") ("`n_group2' / `n_other2'") ("`n_group3' / `n_other3'")
    local nrow = `nrow' + 4
    local rules `rules' `nrow'
}
* panel C: the COVID-years gap minus the normal-years gap (one model, both files)
use `gp', clear
keep if model == "diff"
post `P' ("C. COVID years minus normal years (Bu Deasy's × Post2020)") ("") ("") ("")
forvalues g = 1/3 {
    quietly summarize b if gi == `g', meanonly
    local b`g' = string(r(mean), "%9.2f")
    quietly summarize se if gi == `g', meanonly
    local s`g' = "(" + string(r(mean), "%9.2f") + ")"
    foreach v in n_obs n_firms {
        quietly summarize `v' if gi == `g', meanonly
        local `v'`g' = string(r(mean), "%12.0fc")
    }
}
post `P' ("Average gap, `covid_start' firms minus `bench_start' firms (on the chart)") ("`b1'") ("`b2'") ("`b3'")
post `P' ("")                                  ("`s1'") ("`s2'") ("`s3'")
post `P' ("Observations (firm × later file)")  ("`n_obs1'") ("`n_obs2'") ("`n_obs3'")
post `P' ("Firms (clusters)")                  ("`n_firms1'") ("`n_firms2'") ("`n_firms3'")
local nrow = `nrow' + 5
local rules `rules' `nrow'
post `P' ("Industry × file averages")        ("Yes") ("Yes") ("Yes")
post `P' ("Province × file averages")        ("Yes") ("Yes") ("Yes")
post `P' ("Weights")                         ("None") ("None") ("None")
post `P' ("Standard errors clustered by")    ("Firm") ("Firm") ("Firm")
postclose `P'
use `R', clear
local rnote "Notes: Linear probability model, one row per firm and later file: still in the files (0 or 100) = a gap for firms"
local rnote "`rnote' in the group in each later file + an average for each industry and file + an average for each province and"
local rnote "`rnote' file. Average row: the same model with one gap for the three later files; it is the gap printed on Figure"
local rnote "`rnote' R10-02. Panel C: both starting files in one model (every average and each gap separate by starting file),"
local rnote "`rnote' COVID-years gap minus normal-years gap = Bu Deasy's × Post2020 for staying in the files (every firm is in the"
local rnote "`rnote' files up to its starting file, so the normal-years firms give the before-COVID comparison); a firm can be in"
local rnote "`rnote' both starting files. Percentage points; standard errors in parentheses; no stars. Firms: those of"
local rnote "`rnote' the starting file also in one of the two files before it, with a known answer for the grouping; groups from"
local rnote "`rnote' the starting file and the two before it (in the group if yes in at least half of the known answers, else"
local rnote "`rnote' other firms). Still in the files = in that file or a later one. Leaving the files is not proof of closing."
ctable_pdf t_lab t1 t2 t3 using "tables/02_left_the_file_by_group_regression.pdf", ///
    title("Table R10-02, regression. Firms still in the survey files after `covid_start': gaps to other firms") ///
    subtitle("Outcome: still in the survey files (0 or 100). Percentage points; standard errors in parentheses.") ///
    header("Term" "(1)|Exporters" "(2)|Importers" "(3)|Foreign-owned,|10%+") ///
    right(2 3 4) rules(`rules') fontsize(9) perpage(60) portrait ///
    notes("`rnote'" "`fict'" "`srcnote'" "`devnote'")
display "table -> tables/02_left_the_file_by_group_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/02_left_the_file_by_group.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
