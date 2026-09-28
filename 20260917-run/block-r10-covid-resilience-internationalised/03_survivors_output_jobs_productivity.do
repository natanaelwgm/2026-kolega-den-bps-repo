/*==========================================================================
  R10-03  Among firms still in the survey files after COVID, did exporters,
          importers and foreign-owned firms keep their output, workers and
          value added per worker better than similar firms? Year by year,
          each group's change from the last file before COVID, minus the
          change of firms of the same industry and province. Firms are
          grouped once from their own answers before COVID.
  Answers Bu Deasy R10: "Were internationally integrated firms more
          resilient during COVID?" - outcomes "output, employment,
          productivity"; strategy "Pre-2019 exporter/importer/FDI x Post2020"
          (the pooled term, printed in each panel) and "Event study 2017-22
          jika memungkinkan" (the year-by-year markers). Each panel also prints
          the average of the 2020-22 markers against 2019 alone: where the
          group was already moving apart before COVID, the pooled term (against
          2017-19) carries that earlier change and must not be read as COVID.
  Productivity = value added per worker (drawn); gross output per worker and
          the productivity residual are table-only checks.
  Conditional on staying: the markers drawn solid use only firms that are in
          every file after COVID. Firms that left the files are not in them
          (R10-02 counts who left; R10-04 counts leavers as closed).
  Blocks : "COVID COHORT AND STATES" (from R4-01) and "R10 FROZEN PRE-COVID
          GROUPS" (from R10-01) are copied unchanged from
          01_covid_cohort_groups.do; do not edit them here.
  Foreign-owned = 10% or more of the firm's capital held abroad
          (fdi_10_flag), the definition used in every R1-R10 exhibit.
  Output : figures/03_survivors_output_jobs_productivity.png (+ .pdf)
           tables/03_survivors_output_jobs_productivity.csv  (every estimate;
                  the figure uses the rows with in_figure = 1)
           tables/03_survivors_output_jobs_productivity_table.pdf      (every plotted point)
           tables/03_survivors_output_jobs_productivity_regression.pdf (the drawn models)
           tables/03_survivors_output_jobs_productivity_checks.pdf     (table-only versions)
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
local min_n       30          // a marker is drawn only if the group and the other firms each have at
                              // least 30 firms in that year and in the reference year
local fname "03_survivors_output_jobs_productivity"
* ---------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R10-03] STARTING: output, workers and value added per worker around COVID, firms still in the files ==="

* reghdfe (with ftools) runs regressions that take out many sets of averages at once
foreach p in reghdfe ftools {
    capture which `p'
    if _rc {
        display as error "R10-03 needs the Stata add-on `p'. Install it once: ssc install `p'  - then run this file again."
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
display "Step 1/8: load identity, industry, province, status flags and the outcomes"
*---------------------------------------------------------------------------
* export_flag  = any export activity (1 yes, 0 no, missing = unknown)
* import_flag  = imports reported above zero (never missing)
* fdi_10_flag  = 10% or more of capital held abroad (missing = unknown)
* gross_output_nominal = output value, current prices (masked money unit); the file has
*                no price index filled in (gross_output_real is empty), see the notes
* value_added_nominal  = output value minus materials, energy and services bought
* workers      = persons employed
* dev_nominal_tfp_lp   = productivity residual (development only; table-only check)
* industry2_reported, province_code = never change within a firm
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year export_flag import_flag fdi_10_flag workers gross_output_nominal ///
    gross_output_real value_added_nominal dev_nominal_tfp_lp industry2_reported province_code
local have : list want & allvars          // gross_output_real: used by the cohort block when filled
use `have' using "$DATA", clear
isid firm_id year
foreach v in export_flag import_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}
assert !missing(industry2_reported, province_code)
tempfile firmyear0
save `firmyear0'                          // the firm-year rows; the cohort block keeps one row per firm

*---------------------------------------------------------------------------
display "Step 2/8: the COVID cohort and the frozen groups (blocks copied unchanged from R10-01)"
*---------------------------------------------------------------------------
* The cohort file: the last annual file before COVID (read from the data).
quietly levelsof year, local(allfiles)
local cohort_year ""
foreach c of local allfiles {
    if `c' < `covid_first' local cohort_year `c'
}
assert "`cohort_year'" != ""
display "   cohort file: `cohort_year'"

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

*---------------------------------------------------------------------------
display "Step 3/8: the sample, the outcomes and who stayed"
*---------------------------------------------------------------------------
* Sample: firms of the cohort file that were also in one of the two files before it
* (new_to_file == 0, R10's main sample), their records in the files `p2' to `f3'.
keep if in_cohort & new_to_file == 0 & inrange(year, `p2', `f3')
* stayer = in every later file (`f1', `f2' and `f3'): the sample of the solid markers
gen byte stayer = (state_file == 1)
egen int ind  = group(industry2_reported)
egen int prov = group(province_code)
* outcomes in logs, so a difference reads as a % difference (zero or missing = not used)
gen double y1 = ln(`outbasis') if `outbasis' > 0 & !missing(`outbasis')            // output
gen double y2 = ln(workers) if workers > 0 & !missing(workers)                      // workers
gen double y3 = ln(value_added_nominal / workers) ///
    if value_added_nominal > 0 & workers > 0 & !missing(value_added_nominal, workers) // value added per worker
gen double y4 = dev_nominal_tfp_lp                                                   // table only: productivity residual
gen double y5 = ln(`outbasis' / workers) if `outbasis' > 0 & workers > 0 & !missing(`outbasis', workers) // table only
local out_prices = cond("`outbasis'" == "gross_output_real", "constant prices", "current prices")
* the files of the window, the reference file, the files before and after it
quietly levelsof year, local(evyrs)
local pre_list ""
local post_list ""
foreach y of local evyrs {
    if `y' < `cohort_year' local pre_list "`pre_list' `y'"
    if `y' > `cohort_year' local post_list "`post_list' `y'"
}
local npost : word count `post_list'
local npre1 = `: word count `pre_list'' + 1          // files before COVID incl. the reference
* calendar years with no annual file, from the year before `p2' to `f3' (drawn as a gray band)
local nofile ""
forvalues y = `=`p2' - 1'/`f3' {
    local isin : list y in allfiles
    if !`isin' local nofile "`nofile' `y'"
}
local xfirst `p2'
local ybefore = `p2' - 1
local isin : list ybefore in nofile
if `isin' local xfirst `ybefore'           // the axis starts at the missing year before the window
display "   files `evyrs'; reference `cohort_year'; before:`pre_list'; after:`post_list'; no file:`nofile'"
gen byte post = year > `cohort_year'
egen byte f1tag = tag(firm_id)
quietly count if f1tag
local n_inc = r(N)
quietly count if f1tag & stayer
local n_stay = r(N)
display "   firms `n_inc', of which in every later file (stayers) `n_stay'"
compress
tempfile evdata
save `evdata'

*---------------------------------------------------------------------------
display "Step 4/8: regressions: group x each file (reference `cohort_year'), and the pooled term"
*---------------------------------------------------------------------------
* Model: outcome = firm's own average + one average per industry and file + one per
* province and file + the group's extra change in each file, against `cohort_year':
*   b_year = (group's change from `cohort_year' to that year) - (other firms' change), log points.
* Versions:  stay   = stayers only (firms in every later file): drawn, solid dot
*            all    = every firm of the sample in whatever files it is in: drawn, hollow circle
*            fystay = stayers, firm + year averages only (table only)
* Outcomes 4 (productivity residual) and 5 (output per worker): stayers, main averages, table only.
* Pooled (Bu Deasy's "x Post2020"): the same model with one term, group x every file after
* `cohort_year', against the files `p2' to `cohort_year' together (a separate regression).
local ab_stay   "firm_id ind#year prov#year"
local ab_all    "firm_id ind#year prov#year"
local ab_fystay "firm_id year"
tempname P
tempfile res
postfile `P' str8 grouping str8 version byte outcome_id str8 term int year double(b se df_r) ///
    long(rows firms singletons n_g1 n_g0 ref_g1 ref_g0 firms_g1 firms_g0) double before_p using `res', replace
foreach x in exp imp fdi {
    display "   group `x'"
    foreach v in stay all fystay {
        use `evdata', clear
        keep if !missing(grp_main_`x')
        if "`v'" != "all" keep if stayer
        gen double X = grp_main_`x'
        local terms ""
        foreach y of local evyrs {
            if `y' != `cohort_year' {
                gen double t`y' = X * (year == `y')
                local terms "`terms' t`y'"
            }
        }
        local pre_terms ""
        foreach y of local pre_list {
            local pre_terms "`pre_terms' t`y'"
        }
        gen double tpost = X * post
        local ks "1 2 3"
        if "`v'" == "stay" local ks "1 2 3 4 5"
        foreach k of local ks {
            * --- year by year ---
            quietly reghdfe y`k' `terms', absorb(`ab_`v'') vce(cluster firm_id)
            capture drop es
            gen byte es = e(sample)
            local N  = e(N)
            local G  = e(N_clust)
            local df = e(df_r)
            local S  = e(num_singletons)
            if "`S'" == "" local S 0
            * before-COVID check: all markers before `cohort_year' are 0 together
            capture test `pre_terms'
            local bp = cond(_rc, ., r(p))
            * average of the markers after `cohort_year'
            local lc ""
            foreach y of local post_list {
                local lc "`lc' + t`y'"
            }
            quietly lincom (`=substr("`lc'", 4, .)') / `npost'
            local ab = r(estimate)
            local as = r(se)
            * firms behind each marker: group (X = 1) and other firms (X = 0) in that year
            quietly count if es & year == `cohort_year' & X == 1
            local r1 = r(N)
            quietly count if es & year == `cohort_year' & X == 0
            local r0 = r(N)
            capture drop ft
            egen byte ft = tag(firm_id) if es
            quietly count if ft == 1 & X == 1
            local fg1 = r(N)
            quietly count if ft == 1 & X == 0
            local fg0 = r(N)
            foreach y of local evyrs {
                if `y' == `cohort_year' continue
                quietly count if es & year == `y' & X == 1
                local n1 = r(N)
                quietly count if es & year == `y' & X == 0
                local n0 = r(N)
                * a file with no rows for this outcome (e.g. no residual) is dropped by reghdfe: left empty
                capture local sechk = _se[t`y']
                if _rc local sechk = .
                if `sechk' == 0 | missing(`sechk') {
                    post `P' ("`x'") ("`v'") (`k') ("`y'") (`y') (.) (.) (`df') (`N') (`G') (`S') ///
                        (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp')
                }
                else {
                    post `P' ("`x'") ("`v'") (`k') ("`y'") (`y') (_b[t`y']) (_se[t`y']) (`df') (`N') (`G') (`S') ///
                        (`n1') (`n0') (`r1') (`r0') (`fg1') (`fg0') (`bp')
                }
            }
            post `P' ("`x'") ("`v'") (`k') ("avgpost") (.) (`ab') (`as') (`df') (`N') (`G') (`S') ///
                (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp')
            * --- pooled term (Bu Deasy's "x Post2020"), same rows ---
            quietly reghdfe y`k' tpost if es, absorb(`ab_`v'') vce(cluster firm_id)
            assert e(N) == `N'
            * singletons: those the yearly model dropped (the pooled model runs on its rows, so it drops none)
            post `P' ("`x'") ("`v'") (`k') ("pooled") (.) (_b[tpost]) (_se[tpost]) (e(df_r)) (e(N)) (e(N_clust)) ///
                (`S') (.) (.) (`r1') (`r0') (`fg1') (`fg0') (`bp')
        }
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 5/8: table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `res', clear
* reference rows (0 by definition) and rows for years with no annual file
preserve
keep if term == "avgpost"
replace term = "`cohort_year'"
replace year = `cohort_year'
replace b = 0
replace se = .
replace n_g1 = ref_g1
replace n_g0 = ref_g0
tempfile refrows
save `refrows'
restore
append using `refrows'
foreach y of local nofile {
    preserve
    keep if term == "avgpost"
    replace term = "`y'"
    replace year = `y'
    foreach v in b se n_g1 n_g0 {
        replace `v' = .
    }
    tempfile nf`y'
    save `nf`y''
    restore
    append using `nf`y''
}
gen byte reference = term == "`cohort_year'"
gen byte no_file = 0
foreach y of local nofile {
    replace no_file = 1 if term == "`y'"
}
gen byte yearly = !missing(year)
* support: a marker is shown only if the group and the other firms each have min_n firms in
* that year and in the reference year
gen byte shown = !missing(b) & ((n_g1 >= `min_n' & n_g0 >= `min_n' & ref_g1 >= `min_n' & ref_g0 >= `min_n') ///
    | !yearly)
replace shown = 0 if no_file
gen double tcrit = invttail(df_r, 0.025)
gen double lo = b - tcrit * se if shown & !reference
gen double hi = b + tcrit * se if shown & !reference
gen double p  = 2 * ttail(df_r, abs(b / se)) if shown & se > 0 & !missing(se)
gen double pct    = 100 * (exp(b) - 1)  if shown
gen double pct_lo = 100 * (exp(lo) - 1) if shown
gen double pct_hi = 100 * (exp(hi) - 1) if shown
gen byte clear = pct_lo > 0 | pct_hi < 0 if !missing(pct_lo)
* labels
gen byte gi = cond(grouping == "exp", 1, cond(grouping == "imp", 2, 3))
gen str30 grouping_label = cond(gi == 1, "Exporters", cond(gi == 2, "Importers", "Foreign-owned (10%+)"))
gen str50 outcome_label = ""
replace outcome_label = "Output (log, `out_prices')"            if outcome_id == 1
replace outcome_label = "Workers (log)"                           if outcome_id == 2
replace outcome_label = "Value added per worker (log)"            if outcome_id == 3
replace outcome_label = "Productivity residual (development)"     if outcome_id == 4
replace outcome_label = "Output per worker (log, `out_prices')"   if outcome_id == 5
gen str70 version_label = ""
replace version_label = "Stayers (in every file `f1'-`f3'); firm + industry x year + province x year" if version == "stay"
replace version_label = "All sample firms in that year's file; firm + industry x year + province x year" if version == "all"
replace version_label = "Stayers; firm + year averages only" if version == "fystay"
gen str70 period = ""
replace period = "year " + term if yearly
replace period = "reference: " + term + " (0 by definition)" if reference
replace period = "average of the markers" + "`post_list'" if term == "avgpost"
replace period = "pooled: group x" + "`post_list'" + " vs `p2'-`cohort_year'" if term == "pooled"
gen str40 on_chart = "table only"
replace on_chart = "solid dot" if version == "stay" & outcome_id <= 3 & yearly & shown & !reference
replace on_chart = "hollow circle" if version == "all" & outcome_id <= 3 & yearly & shown & !reference
replace on_chart = "gray diamond (reference)" if version == "stay" & outcome_id <= 3 & reference
replace on_chart = "same diamond (reference)" if version == "all" & outcome_id <= 3 & reference
replace on_chart = "printed in the panel" if version == "stay" & outcome_id <= 3 & inlist(term, "pooled", "avgpost")
gen byte in_figure = inlist(on_chart, "solid dot", "hollow circle", "gray diamond (reference)", "printed in the panel")
gen str120 note = ""
replace note = "No annual file" if no_file
replace note = "No rows in this file for this outcome (not estimable)" if missing(b) & yearly & !no_file
replace note = "Fewer than `min_n' firms of a group in this year or in `cohort_year': left empty" ///
    if !shown & !missing(b) & yearly
replace note = "Average of the markers after `cohort_year', against `cohort_year' only; table only" if term == "avgpost"
replace note = "Average of the markers after `cohort_year', against `cohort_year' only; printed in the panel" ///
    if term == "avgpost" & in_figure
* structural checks
assert pct_lo <= pct + 1e-9 & pct <= pct_hi + 1e-9 if !missing(pct_lo)
assert b == 0 if reference
assert n_g1 <= firms_g1 & n_g0 <= firms_g0 if !missing(n_g1)
gen byte vorder = cond(version == "stay", 1, cond(version == "all", 2, 3))
gen int torder = cond(yearly, year, cond(term == "avgpost", 9001, 9002))
sort gi vorder outcome_id torder
order grouping grouping_label version version_label outcome_id outcome_label term period year reference ///
    in_figure on_chart shown b se df_r p lo hi pct pct_lo pct_hi clear n_g1 n_g0 ref_g1 ref_g0 ///
    firms_g1 firms_g0 rows firms singletons before_p note
format b se lo hi %9.4f
format p before_p %6.4f
format pct pct_lo pct_hi %8.2f
format df_r rows firms singletons n_g* ref_g* firms_g* %9.0f
export delimited grouping-note using "tables/`fname'.csv", datafmt replace
list grouping version outcome_id term pct pct_lo pct_hi clear n_g1 n_g0 if version != "fystay" & outcome_id <= 3 ///
    & (yearly | term == "pooled"), noobs sepby(grouping version outcome_id) abbreviate(24)
list grouping version outcome_id before_p firms_g1 firms_g0 rows singletons if term == "pooled", ///
    noobs sepby(grouping) abbreviate(24)
tempfile ctsrc
save `ctsrc'

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes and panel texts, read from the table (never typed)"
*---------------------------------------------------------------------------
* markers before COVID that are clearly away from 0 (stayers, drawn outcomes): named in the notes
* and flagged in the panel (there the pooled term carries a change that started before COVID)
local olab1 "output"
local olab2 "workers"
local olab3 "value added per worker"
local glab1 "exporters'"
local glab2 "importers'"
local glab3 "foreign-owned firms'"
local apart ""
local n_apart 0
forvalues g = 1/3 {
    forvalues k = 1/3 {
        quietly count if gi == `g' & outcome_id == `k' & version == "stay" & yearly & year < `cohort_year' & clear == 1
        local flag_`g'_`k' = r(N) > 0
        if r(N) > 0 {
            local ++n_apart
            local apart "`apart'; `glab`g'' `olab`k''"
        }
    }
}
local apart = substr("`apart'", 3, .)
display "   drawn panels already apart before COVID (stayers): `n_apart' (`apart')"
local pre_txt = subinstr(strtrim("`pre_list'"), " ", " or ", .)
local post_first : word 1 of `post_list'
local post_last  : word `npost' of `post_list'
local post_rng = "`post_first'–" + substr("`post_last'", 3, 2)
local pool_rng = "`p2'–" + substr("`cohort_year'", 3, 2)
local n_inc_s  = strtrim(string(`n_inc', "%9.0fc"))
local n_stay_s = strtrim(string(`n_stay', "%9.0fc"))
* two numbers per panel (stayers), whole %, with their 95% intervals:
*   line 1 = average of the markers after COVID, against `cohort_year' alone
*   line 2 = the pooled term (Bu Deasy's x Post2020), against `p2'-`cohort_year' together
*   line 3 = "Already apart before COVID" where a stayers' marker before `cohort_year' is clear
forvalues g = 1/3 {
    forvalues k = 1/3 {
        foreach tm in avgpost pooled {
            quietly summarize pct if gi == `g' & outcome_id == `k' & version == "stay" & term == "`tm'"
            local pv = r(mean)
            quietly summarize pct_lo if gi == `g' & outcome_id == `k' & version == "stay" & term == "`tm'"
            local pl = r(mean)
            quietly summarize pct_hi if gi == `g' & outcome_id == `k' & version == "stay" & term == "`tm'"
            local ph = r(mean)
            local s1 = cond(round(`pv') > 0, "+", "") + string(round(`pv'), "%9.0f")
            local s2 = cond(round(`pl') > 0, "+", "") + string(round(`pl'), "%9.0f")
            local s3 = cond(round(`ph') > 0, "+", "") + string(round(`ph'), "%9.0f")
            local v_`tm' "`s1'% (`s2' to `s3')"
        }
        local ptxt1_`g'_`k' "`post_rng' vs `cohort_year': `v_avgpost'"
        local ptxt2_`g'_`k' "`post_rng' vs `pool_rng': `v_pooled'"
        local ptxt3_`g'_`k' = cond(`flag_`g'_`k'', "Already apart before COVID", "")
    }
}

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker panels: 3 groups x 3 outcomes, one shared scale"
*---------------------------------------------------------------------------
keep if version != "fystay" & outcome_id <= 3 & yearly & !no_file
gen byte panel = 3 * (gi - 1) + outcome_id
label define panel 1 "(a) Exporters: output" 2 "(b) Exporters: workers" 3 "(c) Exporters: VA per worker" ///
    4 "(d) Importers: output" 5 "(e) Importers: workers" 6 "(f) Importers: VA per worker" ///
    7 "(g) Foreign-owned: output" 8 "(h) Foreign-owned: workers" 9 "(i) Foreign-owned: VA per worker"
label values panel panel
* marker sets: stayers just left of the year, all firms just right; the reference once
gen double xs = year - 0.15 if version == "stay" & shown & !reference
gen double ys = pct         if version == "stay" & shown & !reference
gen double ls = pct_lo      if version == "stay" & shown & !reference
gen double hs = pct_hi      if version == "stay" & shown & !reference
gen double xa = year + 0.15 if version == "all" & shown & !reference
gen double ya = pct         if version == "all" & shown & !reference
gen double la = pct_lo      if version == "all" & shown & !reference
gen double ha = pct_hi      if version == "all" & shown & !reference
gen double xr = year        if version == "stay" & reference
gen double yr = 0           if version == "stay" & reference
* one shared y scale: a round step that grows with the numbers; 0 always inside
egen double ymn = rowmin(ls la)
egen double ymx = rowmax(hs ha)
quietly summarize ymn
local ymin = min(r(min), 0)
quietly summarize ymx
local ymax = max(r(max), 0)
local rng = `ymax' - `ymin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
local ytx1 = `ytop' + 0.52 * (`ytop' - `ybot')          // three text lines above the markers
local ytx2 = `ytop' + 0.33 * (`ytop' - `ybot')
local ytx3 = `ytop' + 0.14 * (`ytop' - `ybot')
local yroof = `ytop' + 0.60 * (`ytop' - `ybot')
display "   y from `ybot' to `ytop' by `step'"
* labelled every second step, always through 0 (short panels); faint grid at every step
local ylab "0"
forvalues m = 1/20 {
    if -2 * `m' * `step' >= `ybot' local ylab "`=-2 * `m' * `step'' `ylab'"
    if  2 * `m' * `step' <= `ytop' local ylab "`ylab' `=2 * `m' * `step''"
}
* per panel: the gray no-file band, the 0 line, the COVID line and the three text lines
local xl = `xfirst' - 0.5
local xr2 = `f3' + 0.5
local n0 = _N
set obs `=_N + 9'
gen double bx = .
gen double by0 = .
gen double by1 = .
gen double zy = .
gen double zx0 = .
gen double zx1 = .
gen double cx = .
gen double cy0 = .
gen double cy1 = .
gen double tx = .
gen double ty1 = .
gen double ty2 = .
gen double ty3 = .
gen str60 ttx1 = ""
gen str60 ttx2 = ""
gen str60 ttx3 = ""
local nf1 : word 1 of `nofile'
forvalues pp = 1/9 {
    local r = `n0' + `pp'
    local g = ceil(`pp' / 3)
    local k = `pp' - 3 * (`g' - 1)
    quietly replace panel = `pp' in `r'
    if "`nf1'" != "" {
        quietly replace bx  = `nf1' in `r'
        quietly replace by0 = `ybot' in `r'
        quietly replace by1 = `ytop' in `r'
    }
    quietly replace zy  = 0 in `r'
    quietly replace zx0 = `xl' in `r'
    quietly replace zx1 = `xr2' in `r'
    quietly replace cx  = `cohort_year' + 0.5 in `r'
    quietly replace cy0 = `ybot' in `r'
    quietly replace cy1 = `ytop' in `r'
    quietly replace tx  = `xl' + 0.05 in `r'
    quietly replace ty1 = `ytx1' in `r'
    quietly replace ty2 = `ytx2' in `r'
    quietly replace ty3 = `ytx3' in `r'
    quietly replace ttx1 = "`ptxt1_`g'_`k''" in `r'
    quietly replace ttx2 = "`ptxt2_`g'_`k''" in `r'
    quietly replace ttx3 = "`ptxt3_`g'_`k''" in `r'
}
sort panel
* x labels: every calendar year of the axis, two digits (three panels side by side leave no room for four)
local xlab ""
forvalues y = `xfirst'/`f3' {
    local xlab `"`xlab' `y' "`=substr("`y'", 3, 2)'""'
}
* Notes: one text, wrapped here into lines of at most 102 characters (PDF text runs wider than the PNG)
if `n_apart' > 0 local aparttxt "Already apart before COVID (a `pre_txt' ● clearly away from 0): `apart'. There the group was already moving away from similar firms before COVID, so the `pool_rng' number includes that earlier change and does not measure COVID: read the `cohort_year' number."
else local aparttxt "No ● before COVID is clearly away from 0; with only `: word count `pre_list'' earlier files this is weak evidence that the paths were the same."
local ntext "Notes: Firms = the `n_inc_s' firms of the `cohort_year' file (the last before COVID) also in the `p2' or `p1' file, grouped once from their own `pool_rng' answers (in the group if yes in at least half of its known answers; no known answer = left out). ●~=~the group's change since `cohort_year' minus that of firms of the same industry and province, each firm against its own average, among the `n_stay_s' firms in every file `f1'–`f3' (conditional on staying: firms that left are not in it). ○~=~the same with every firm in whatever files it is in. Line = 95% interval; crossing 0 = no clear difference. Printed in each panel, ●~firms: `post_rng' vs `cohort_year' = average of the `npost' ● after COVID; `post_rng' vs `pool_rng' = Bu Deasy's ×~Post2020 term (against the `npre1' files before COVID together). `aparttxt' Productivity = value added (VA) per worker; VA = output minus materials, energy and services bought. Output = value of goods produced; `out_prices'. Association, not the effect of COVID. Firm links are fictional in the development data, so who stayed means nothing here: run on the real BPS panel."
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
local nfkey ""
local f3rng = "`f1'–" + substr("`f3'", 3, 2)
if "`nf1'" != "" local nfkey `"1 "No annual file (`nf1')""'

* Stata draws markers about twice as large in the PNG as in the PDF, so each file gets its own
* marker size (same data, same layout)
foreach out in png pdf {
    local msz = cond("`out'" == "png", "vsmall", "small")
    twoway (rbar by0 by1 bx, barwidth(0.8) fcolor(gs14) lcolor(gs14) lwidth(none)) ///
        (rspike zx0 zx1 zy, horizontal lcolor(gs8) lwidth(thin)) ///
        (rspike cy0 cy1 cx, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
        (rspike la ha xa, lcolor(gs10) lwidth(thin)) ///
        (rspike ls hs xs, lcolor(black) lwidth(medthin)) ///
        (scatter ya xa, msymbol(O) mfcolor(white) mlcolor(gs5) mlwidth(medthin) msize(`msz')) ///
        (scatter ys xs, msymbol(O) mcolor(black) msize(`msz')) ///
        (scatter yr xr, msymbol(D) mcolor(gs8) msize(`msz')) ///
        (scatter ty1 tx, msymbol(none) mlabel(ttx1) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty2 tx, msymbol(none) mlabel(ttx2) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ty3 tx, msymbol(none) mlabel(ttx3) mlabpos(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
        by(panel, cols(3) imargin(small) graphregion(color(white) lcolor(white) ilcolor(white) margin(r+2)) ///
            legend(pos(6)) ///
            title("Figure R10-03. Output, workers and value added per worker around COVID:" ///
                  "internationalised firms vs similar firms, among firms still in the files", ///
                  size(small) pos(11) span) ///
            note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
        subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
        yscale(range(`ybot' `yroof') noline) ///
        ylabel(`ylab', angle(0) format(%9.0f) noticks tlength(0) labsize(vsmall) grid glcolor(gs15) glwidth(vthin)) ///
        ymtick(`ybot'(`step')`ytop', noticks tlength(0) grid glcolor(gs15) glwidth(vthin)) ///
        ytitle("Group minus similar firms: change since `cohort_year', %", size(vsmall)) ///
        xscale(range(`xl' `xr2') noline) xlabel(`xlab', noticks tlength(0) labsize(vsmall) nogrid) ///
        xtitle("Year of the survey file (`=substr("`xfirst'", 3, 2)' = `xfirst')", size(vsmall)) ///
        legend(order(7 "Stayers (in every file `f3rng')" 6 "All firms in that year's file" ///
                     8 "`cohort_year' = reference (0)" 5 "95% interval, stayers" 4 "95% interval, all firms" ///
                     3 "COVID (from March `covid_first')" 2 "0 = no difference" `nfkey') ///
            cols(3) region(lcolor(none)) size(vsmall) symxsize(6) keygap(1) colgap(6) rowgap(0.3)) ///
        plotregion(style(none)) xsize(8) ysize(12)
    if "`out'" == "png" graph export "figures/`fname'.png", width(2400) replace
    else graph export "figures/`fname'.pdf", replace
}

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regression tables"
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
* Source: the table saved right after the CSV export (full precision, same
* estimation run as the chart).
* (1) Points table: one row per point of the chart, panel by panel, stayers then all
*     firms, left to right (the no-file year included), then the number printed in the panel.
use `ctsrc', clear
quietly count if in_figure
local n_fig = r(N)                     // drawn markers + reference diamonds + printed pooled terms
keep if version != "fystay" & outcome_id <= 3 & (yearly | inlist(term, "pooled", "avgpost"))
drop if version == "all" & !yearly                          // the panel prints the stayers' two numbers only
gen byte panel = 3 * (gi - 1) + outcome_id
local pl1 "(a) Exporters: output"
local pl2 "(b) Exporters: workers"
local pl3 "(c) Exporters: VA per worker"
local pl4 "(d) Importers: output"
local pl5 "(e) Importers: workers"
local pl6 "(f) Importers: VA per worker"
local pl7 "(g) Foreign-owned: output"
local pl8 "(h) Foreign-owned: workers"
local pl9 "(i) Foreign-owned: VA per worker"
gen str60 t_panel = ""
forvalues pp = 1/9 {
    replace t_panel = "`pl`pp''" if panel == `pp'
}
gen byte srow = cond(term == "pooled", 4, cond(term == "avgpost", 3, cond(version == "stay", 1, 2)))
gen str60 t_series = cond(srow == 1, "Stayers (in every file `f1'–`f3')", cond(srow == 2, ///
    "All firms in that year's file", "Printed in the panel (stayers)"))
gen str24 t_pos = cond(yearly, string(year), cond(term == "avgpost", "`post_rng' vs `cohort_year'", "`post_rng' vs `pool_rng'"))
* values: markers carry no label on the chart, so one decimal; the printed pooled term is whole %
gen str12 t_v  = cond(pct > 0.05, "+", "") + string(pct, "%9.1f") if yearly & !missing(pct)
gen str12 t_lo = cond(pct_lo > 0.05, "+", "") + string(pct_lo, "%9.1f") if yearly & !missing(pct_lo)
gen str12 t_hi = cond(pct_hi > 0.05, "+", "") + string(pct_hi, "%9.1f") if yearly & !missing(pct_hi)
replace t_v  = cond(round(pct) > 0, "+", "") + string(round(pct), "%9.0f") if !yearly
replace t_lo = cond(round(pct_lo) > 0, "+", "") + string(round(pct_lo), "%9.0f") if !yearly
replace t_hi = cond(round(pct_hi) > 0, "+", "") + string(round(pct_hi), "%9.0f") if !yearly
replace t_v = "0" if reference
gen str12 t_n1 = string(n_g1, "%12.0fc") if !missing(n_g1)
gen str12 t_n0 = string(n_g0, "%12.0fc") if !missing(n_g0)
replace t_n1 = string(firms_g1, "%12.0fc") if !yearly
replace t_n0 = string(firms_g0, "%12.0fc") if !yearly
gen str80 t_status = ""
replace t_status = "drawn: solid dot" if on_chart == "solid dot"
replace t_status = "drawn: hollow circle" if on_chart == "hollow circle"
replace t_status = "gray diamond: reference (0 by definition)" if reference & srow == 1
replace t_status = "same gray diamond (reference)" if reference & srow == 2
replace t_status = "printed, line 1 (whole %)" if term == "avgpost"
replace t_status = "printed, line 2: × Post2020 (whole %)" if term == "pooled"
replace t_status = "not drawn: no annual file" if no_file
replace t_status = "not drawn: fewer than `min_n' firms in a group" if t_status == "" & !missing(b) & !shown
replace t_status = "not drawn: no rows in this file" if t_status == ""
assert t_status != ""
* check: every drawn marker, reference diamond and printed number is in the table once
quietly count if in_figure
assert r(N) == `n_fig'
sort panel srow torder
local nrows = _N
local rl ""
forvalues i = 1/`=_N - 1' {
    if panel[`i'] != panel[`i' + 1] local rl "`rl' `i'"
}
local tnote "Table: every point of Figure R10-03, panel by panel, left to right. % difference = 100 × (exp(b) − 1), b = the"
local tnote "`tnote' coefficient in the regression table (full precision in tables/`fname'.csv). Markers carry no number on the chart, so"
local tnote "`tnote' one decimal is shown; the two numbers printed in each panel are whole on the chart. Firms: group and other firms with a record"
local tnote "`tnote' in that year behind the marker; for the printed numbers, all firms of the regression (every year)."
local ntab : subinstr local ntext "~" " ", all
ctable_pdf t_panel t_series t_pos t_v t_lo t_hi t_n1 t_n0 t_status using "tables/`fname'_table.pdf", ///
    title("Table R10-03. Output, workers and value added per worker around COVID, firms still in the files: every plotted point") ///
    subtitle("Group minus similar firms (same industry and province), change since `cohort_year', %") ///
    header("Panel" "Series" "Year" "%|difference" "95%|low" "95%|high" "Group|firms" "Other|firms" "Status") ///
    right(4 5 6 7 8) norepeat(1 2) rules(`rl') perpage(32) fontsize(9) ///
    notes("`ntab'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`nrows' rows; `n_fig' drawn or printed)"

* (2) Regression tables (AER style): coefficient on the first line, (standard error)
* on the second, [% difference = 100 × (exp(b) − 1)] on the third. One panel per group.
*   _regression.pdf : the six models drawn (3 outcomes x stayers / all firms)
*   _checks.pdf     : table-only versions (stayers): firm + year averages only; the
*                     productivity residual; output per worker
use `ctsrc', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1) stringcols(1 3 7)
keep grouping version outcome_id term b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 grouping version outcome_id term using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
tempfile regsrc
save `regsrc'
local ntabs 2
local cols1 "stay:1 all:1 stay:2 all:2 stay:3 all:3"
local cols2 "fystay:1 fystay:2 fystay:3 stay:4 stay:5"
local file1 "`fname'_regression"
local file2 "`fname'_checks"
local ttl1 "Table R10-03, regression. Output, workers and value added per worker around COVID: estimates behind the chart"
local ttl2 "Table R10-03, checks. Table-only versions for the stayers: estimates not drawn"
local hdr1 `"" " "(1)|Output|stayers" "(2)|Output|all firms" "(3)|Workers|stayers" "(4)|Workers|all firms" "(5)|VA per worker|stayers" "(6)|VA per worker|all firms""'
local hdr2 `"" " "(1)|Output|firm + year" "(2)|Workers|firm + year" "(3)|VA per worker|firm + year" "(4)|Productivity|residual" "(5)|Output per|worker""'
local plab1 "Panel A. Exporters"
local plab2 "Panel B. Importers"
local plab3 "Panel C. Foreign-owned"
local pre_eq = subinstr(strtrim("`pre_list'"), " ", ", ", .)
forvalues tb = 1/`ntabs' {
    local nc : word count `cols`tb''
    tempname Q
    tempfile R
    local tv ""
    forvalues c = 1/`nc' {
        local tv "`tv' t`c'"
    }
    postfile `Q' str70 t_lab str24(`tv') using `R', replace
    local nterm 0
    local rl ""
    forvalues g = 1/3 {
        * the posted row: label + one cell per column
        local cells ""
        forvalues c = 1/`nc' {
            local cells `"`cells' ("")"'
        }
        post `Q' ("`plab`g''") `cells'
        local ++nterm
        foreach tm in `evyrs' avgpost pooled {
            local l1 ""
            local l2 ""
            local l3 ""
            forvalues c = 1/`nc' {
                local cs : word `c' of `cols`tb''
                gettoken vv kk : cs, parse(":")
                local kk = substr("`kk'", 2, .)
                quietly summarize b if gi == `g' & version == "`vv'" & outcome_id == `kk' & term == "`tm'", meanonly
                local bb = r(mean)
                quietly summarize se if gi == `g' & version == "`vv'" & outcome_id == `kk' & term == "`tm'", meanonly
                local ss = r(mean)
                if "`tm'" == "`cohort_year'" {
                    local l1 `"`l1' ("—")"'
                }
                else if missing(`bb') {
                    local l1 `"`l1' ("n.a.")"'
                    local l2 `"`l2' ("")"'
                    local l3 `"`l3' ("")"'
                }
                else {
                    local pv = 100 * (exp(`bb') - 1)
                    local l1 `"`l1' ("`=string(`bb', "%9.3f")'")"'
                    local l2 `"`l2' ("(`=string(`ss', "%9.3f")')")"'
                    local l3 `"`l3' ("[`=cond(`pv' > 0, "+", "")'`=string(`pv', "%9.1f")'%]")"'
                }
            }
            if "`tm'" == "`cohort_year'" local lab "Group × `tm' (reference)"
            else if "`tm'" == "avgpost" local lab "Average `post_rng'"
            else if "`tm'" == "pooled" local lab "Pooled `post_rng'"
            else local lab "Group × `tm'"
            post `Q' ("`lab'") `l1'
            local ++nterm
            if "`tm'" != "`cohort_year'" {
                post `Q' ("") `l2'
                post `Q' ("") `l3'
                local nterm = `nterm' + 2
            }
        }
        * whole-model rows (the yearly model of each column)
        foreach st in before_p rows firms firms_g1 {
            local ll ""
            forvalues c = 1/`nc' {
                local cs : word `c' of `cols`tb''
                gettoken vv kk : cs, parse(":")
                local kk = substr("`kk'", 2, .)
                quietly summarize `st' if gi == `g' & version == "`vv'" & outcome_id == `kk' & term == "avgpost", meanonly
                if "`st'" == "before_p" local cv = cond(missing(r(mean)), "n.a.", cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f")))
                else local cv = string(r(mean), "%12.0fc")
                local ll `"`ll' ("`cv'")"'
            }
            if "`st'" == "before_p" local lab "Before-COVID test, p"
            if "`st'" == "rows"     local lab "Observations"
            if "`st'" == "firms"    local lab "Firms (clusters)"
            if "`st'" == "firms_g1" local lab "Firms in the group"
            post `Q' ("`lab'") `ll'
            local ++nterm
        }
        local rl "`rl' `nterm'"
    }
    * design rows, the same for every panel
    foreach d in firm indyr provyr yr sample wgt clu {
        local ll ""
        forvalues c = 1/`nc' {
            local cs : word `c' of `cols`tb''
            gettoken vv kk : cs, parse(":")
            if "`d'" == "firm"   local cv "Yes"
            if "`d'" == "indyr"  local cv = cond("`vv'" == "fystay", "No", "Yes")
            if "`d'" == "provyr" local cv = cond("`vv'" == "fystay", "No", "Yes")
            if "`d'" == "yr"     local cv = cond("`vv'" == "fystay", "Yes", "In ind. × year")
            if "`d'" == "sample" local cv = cond("`vv'" == "all", "All firms", "Stayers")
            if "`d'" == "wgt"    local cv "None"
            if "`d'" == "clu"    local cv "Firm"
            local ll `"`ll' ("`cv'")"'
        }
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
    preserve
    use `R', clear
    local rnote "Notes: Each column is one regression of the log outcome (column 4 of the checks: the productivity residual, already"
    local rnote "`rnote' a log) on the group times each file from `p2' to `f3' except `cohort_year' (the reference, set to 0), with the"
    local rnote "`rnote' fixed effects listed; firms: the `n_inc_s' firms of the `cohort_year' file also in the `p2' or `p1' file, grouped once"
    local rnote "`rnote' from their `pool_rng' answers (in the group if yes in at least half of the known answers; no known answer = left out)."
    local rnote "`rnote' Stayers = the `n_stay_s' of them in every file `f1'–`f3' (conditional on staying); all firms = every record of the"
    local rnote "`rnote' `n_inc_s' in those files. Pooled = the same model with one term, group × every file after `cohort_year' (Bu Deasy's ×"
    local rnote "`rnote' Post2020), compared with `pool_rng' together (its own regression, same rows). Average = mean of the `post_rng'"
    local rnote "`rnote' markers, against `cohort_year' alone. Where the markers `pre_eq' are away from 0 (small before-COVID p), the"
    local rnote "`rnote' group was already moving apart before COVID and the pooled term includes that earlier change; the average does not."
    local rnote "`rnote' Before-COVID test: joint p that the markers `pre_eq' are all 0. FE = fixed effects"
    local rnote "`rnote' (averages taken out); VA = value added; productivity = VA per worker (drawn). n.a. = no rows in that file"
    local rnote "`rnote' (the productivity residual starts later, so its pooled term compares with the files it has before COVID)."
    if `tb' == 2 local rnote "`rnote' Output per worker = value of goods produced per worker, before inputs are subtracted (a check on VA per worker)."
    local rnote "`rnote' Output = value of goods produced, `out_prices'. Singleton firms dropped by reghdfe. No stars."
    ctable_pdf t_lab `tv' using "tables/`file`tb''.pdf", ///
        title("`ttl`tb''") ///
        subtitle("Coefficient in log points; (standard error, clustered by firm); [% difference = 100 × (exp(b) − 1)].") ///
        header(`hdr`tb'') right(`=substr("2 3 4 5 6 7", 1, 2 * `nc' - 1)') rules(`rl') portrait fontsize(9) perpage(36) ///
        notes("`rnote'" "`srcnote'" "`devnote'")
    restore
    display "table -> tables/`file`tb''.pdf"
}
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
