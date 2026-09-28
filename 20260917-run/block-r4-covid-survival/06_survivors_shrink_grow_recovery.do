/*==========================================================================
  R4-06  Among the firms of the last file before COVID (2019) that are in
         all three later files (2020, 2021, 2022), did workers and output
         shrink, grow, or fall and then come back up? And was that
         different from normal years (the 2012 firms, followed 2013-2015)?
  Answers Bu Deasy R4: "Which firms survived and recovered?" - Strategy
         "multinomial outcomes: ... survive-shrink, survive-grow".
  Method : each stayer's workers and output in each later file divided by
           its own level in the starting file (x 100). Lines = the middle
           firm (median) with a 95% interval; bars = share down more than
           10%, within 10% either way, up more than 10% by the third later
           file; dots = of the firms down more than 10% in the first later
           file, the share back within 10% or above by the third.
  Stayers: the "stayed" state of the shared block (in all three later
           files), the same firms R10-03 calls "in every file after COVID";
           see the note in Step 3 on how this file and R10-03 differ.
  Output : figures/06_survivors_shrink_grow_recovery.png (+ .pdf)
           tables/06_survivors_shrink_grow_recovery.csv (every number; the
                  chart uses the rows with in_figure = 1; also the 5% and 20%
                  bands, firms also in an earlier file only, the middle level
                  of all firms in each file, other normal years)
           tables/06_survivors_shrink_grow_recovery_table.pdf (every plotted
                  point, then two table-only checks: R10-03's firms, and the
                  middle level of all firms in each file)
  Prices : output is in current prices on the development file (no price index
           in it); it includes price rises, which differ between the two
           periods. Workers (a) are free of prices. Constant-price output is
           used automatically when the file has it (shared block).
  Uses the block "COVID COHORT AND STATES" of R4-01, copied exactly (Step 3).
  Firm links are fictional in the development data, so who stays, leaves or
  comes back means nothing here; read these results on the real BPS files.
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r4-covid-survival"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
local fname "06_survivors_shrink_grow_recovery"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R4-06] STARTING: firms in all three files after 2019 - shrank, grew or came back up, against 2012 ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load firm, year, workers and output"
*---------------------------------------------------------------------------
* workers              = persons engaged (price-free: the main size measure)
* gross_output_nominal = output value in current prices
* gross_output_real    = output in constant prices; empty in the development
*                        file, used automatically when filled (shared block)
quietly describe using "$DATA", varlist
local allvars `r(varlist)'
local want firm_id year workers gross_output_nominal gross_output_real
local have : list want & allvars
use `have' using "$DATA", clear
isid firm_id year
assert !missing(firm_id, year)
tempfile panel
save `panel'

*---------------------------------------------------------------------------
display "Step 2/8: the starting files"
*---------------------------------------------------------------------------
* The two drawn starting files, as in R4-04: the last file before COVID reached
* Indonesia (March 2020) and a normal-years file whose three later files end
* before COVID (2012, followed 2013, 2014, 2015 - three consecutive years).
local cohort_covid  2019
local cohort_normal 2012
local covid_first   2020        // first annual file after COVID reached Indonesia
local band_pct      10          // the shared block's neutral band: within 10% either way
local bands         5 10 20     // the 5% and 20% bands go to the CSV only
local min_firms     30          // a point is drawn only if it rests on at least 30 firms
* Other normal-years starting files, CSV only (the R4-03 rule): the next three files
* are the next three calendar years and end before the COVID starting file.
quietly levelsof year, local(files)
local normal_bases ""
foreach b of local files {
    local ok = (`b' + 3 < `cohort_covid')
    forvalues k = 1/3 {
        local nx = `b' + `k'
        local isin : list posof "`nx'" in files
        if `isin' == 0 local ok 0
    }
    if `ok' local normal_bases `normal_bases' `b'
}
local isin : list posof "`cohort_normal'" in normal_bases
if `isin' == 0 {
    display as error "the normal-years starting file `cohort_normal' needs three later consecutive files"
    exit 198
}
local cohorts `cohort_covid' `cohort_normal'
foreach b of local normal_bases {
    if `b' != `cohort_normal' local cohorts `cohorts' `b'
}
display "   drawn: `cohort_covid' and `cohort_normal'; all starting files: `cohorts'"

*---------------------------------------------------------------------------
display "Step 3/8: for each starting file: the shared cohort block, then each stayer's levels in the later files"
*---------------------------------------------------------------------------
* How this file and R10-03 (block-r10 03_survivors_output_jobs_productivity.do) agree
* and differ. Same: stayers = the block's state "stayed" (in all three later files),
* the same output variable rule (constant prices when filled, else current prices)
* and workers = persons engaged. Different: (1) R10-03 keeps only firms also in one
* of the two files before (new_to_file == 0); here every firm of the starting file
* counts, and R10-03's firms are the CSV sample "also_in_earlier_file"; (2) R10-03
* compares groups with similar firms in regressions on logs; here each firm is set
* against its own starting level and the middle firm is shown, with no model;
* (3) a firm with 0 workers in a later file drops out of R10-03's logs; here it
* counts as down 100% (as in the block).
tempfile stack
local first 1
foreach cohort_year of local cohorts {
    use `panel', clear
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
    * -- counts for the whole starting file (CSV section "count") --
    quietly count if in_cohort
    local nc_`cohort_year' = r(N)
    quietly count if state_file == 1
    local ns_`cohort_year' = r(N)
    quietly count if state_file == 2
    local nb_`cohort_year' = r(N)
    quietly count if state_file == 3
    local nl_`cohort_year' = r(N)
    quietly count if state_file == 1 & new_to_file == 0
    local ni_`cohort_year' = r(N)
    local f1_`cohort_year' `f1'
    local f2_`cohort_year' `f2'
    local f3_`cohort_year' `f3'
    local ob_`cohort_year' `outbasis'
    local p1_`cohort_year' `p1'
    local p2_`cohort_year' `p2'
    * the normal-years files must be followed only through files before COVID
    if `cohort_year' != `cohort_covid' assert `f3' < `covid_first'
    * -- the stayers: in all three later files --
    keep if in_cohort & state_file == 1
    keep firm_id cohort_year new_to_file workers_base output_base ratio_wk ratio_out size_wk size_out
    tempfile st
    save `st'
    * -- each stayer's workers and output in each later file (from the firm-year rows) --
    use `panel', clear
    keep if inlist(year, `f1', `f2', `f3')
    gen byte k = cond(year == `f1', 1, cond(year == `f2', 2, 3))
    gen double lv_wk  = workers
    gen double lv_out = `outbasis'
    keep firm_id k lv_wk lv_out
    quietly reshape wide lv_wk lv_out, i(firm_id) j(k)
    merge 1:1 firm_id using `st', keep(using match)
    assert _merge == 3                        // every stayer is in all three later files
    drop _merge
    * level in each later file against the starting file, the block's rule: no positive
    * starting level (or no later level) = not comparable (missing); 0 later = ratio 0
    forvalues k = 1/3 {
        gen double r_wk`k'  = lv_wk`k'  / workers_base if workers_base > 0 & !missing(workers_base, lv_wk`k')
        gen double r_out`k' = lv_out`k' / output_base  if output_base  > 0 & !missing(output_base,  lv_out`k')
    }
    * the third later file must give exactly the block's own ratios
    assert r_wk3 == ratio_wk
    assert r_out3 == ratio_out
    if `first' {
        save `stack'
        local first 0
    }
    else {
        append using `stack'
        save `stack', replace
    }
}

* -- check for panel (b): the middle level of ALL firms in each file (not the same firms),
*    starting file = 100. A change shared by every firm of a file (price rises; on the
*    development file also the masking) moves this line too. Table and CSV only. --
use `panel', clear
foreach c of local cohorts {
    forvalues k = 0/3 {
        local yy `c'
        if `k' > 0 local yy `f`k'_`c''
        foreach m in wk out {
            local v = cond("`m'" == "wk", "workers", "`ob_`c''")
            quietly count if year == `yy' & !missing(`v')
            local fn_`m'_`c'_`k' = r(N)
            local fm_`m'_`c'_`k' = .
            if r(N) > 0 {
                quietly _pctile `v' if year == `yy', p(50)
                local fm_`m'_`c'_`k' = r(r1)
            }
        }
    }
}

*---------------------------------------------------------------------------
display "Step 4/8: middle firm (median) per later file, and the shares that shrank, stayed or grew"
*---------------------------------------------------------------------------
* Samples: all      = every stayer of the starting file (drawn)
*          also_in_earlier_file = stayers also in one of the two files before
*                     (R10-03's firms; CSV only)
* Median: -centile- gives the median and its 95% interval from the order of the
*         firms (exact binomial method; no assumption about the spread).
* Shares: Wilson 95% interval (-cii proportions-), treating the firms as a sample.
use `stack', clear
forvalues k = 1/3 {
    gen double ix_wk`k'  = 100 * r_wk`k'
    gen double ix_out`k' = 100 * r_out`k'
}
tempname pf
tempfile res
postfile `pf' str9 section str1 panel int cohort_year str14 later_files str20 sample str7 measure ///
    str20 outcome_basis double band_pct byte position int file_year str60 stat ///
    double value lo hi n_firms k_firms byte chart_row str50 status using `res', replace
foreach c of local cohorts {
    local lf "`f1_`c'' `f2_`c'' `f3_`c''"
    local drawn = inlist(`c', `cohort_covid', `cohort_normal')
    * -- counts (whole starting file) --
    foreach s in nc ns nb nl ni {
        if "`s'" == "nc" local lab "firms in the starting file"
        if "`s'" == "ns" local lab "stayed: in all three later files"
        if "`s'" == "nb" local lab "absent, then back in the third later file"
        if "`s'" == "nl" local lab "left: not in the third later file"
        if "`s'" == "ni" local lab "stayed and also in an earlier file"
        local nval ``s'_`c''
        local nst ""
        if "`s'" == "ni" & "`p1_`c''" == "" {
            local nval .
            local nst "no earlier file in the data"
        }
        post `pf' ("count") ("") (`c') ("`lf'") ("all") ("") ("`ob_`c''") (.) (.) (`c') ("`lab'") ///
            (.) (.) (.) (`nval') (.) (0) ("`nst'")
    }
    * -- the middle level of all firms in each file (not the same firms), start = 100 --
    foreach m in wk out {
        local mname = cond("`m'" == "wk", "workers", "output")
        local pn = cond("`m'" == "wk", "a", "b")
        forvalues k = 0/3 {
            local yy `c'
            if `k' > 0 local yy `f`k'_`c''
            local fv = 100 * `fm_`m'_`c'_`k'' / `fm_`m'_`c'_0'
            post `pf' ("file_med") ("`pn'") (`c') ("`lf'") ("all_firms_in_file") ("`mname'") ("`ob_`c''") (.) (`k') ///
                (`yy') ("middle level of all firms in the file, starting file = 100") (`fv') (.) (.) ///
                (`fn_`m'_`c'_`k'') (.) (0) ("table only: all firms in the file")
        }
    }
    foreach smp in all also_in_earlier_file {
        local sc = cond("`smp'" == "all", "1", "new_to_file == 0")
        * a starting file with no file before it has no "also in an earlier file" firms
        local noearl = ("`smp'" == "also_in_earlier_file" & "`p1_`c''" == "")
        foreach m in wk out {
            local mname = cond("`m'" == "wk", "workers", "output")
            local pn = cond("`m'" == "wk", "a", "b")
            local crow = `drawn' & "`smp'" == "all"
            * -- position 0: the starting file, 100 by definition --
            quietly count if cohort_year == `c' & (`sc') & (!missing(r_`m'1) | !missing(r_`m'2) | !missing(r_`m'3))
            post `pf' ("median") ("`pn'") (`c') ("`lf'") ("`smp'") ("`mname'") ("`ob_`c''") (.) (0) (`c') ///
                ("starting file = 100") (100) (.) (.) (r(N)) (.) (`crow') ("")
            * -- positions 1-3: the median of the later level against the starting level --
            forvalues k = 1/3 {
                quietly count if cohort_year == `c' & (`sc') & !missing(ix_`m'`k')
                local n = r(N)
                local med = .
                local mlo = .
                local mhi = .
                if `n' > 0 {
                    quietly centile ix_`m'`k' if cohort_year == `c' & (`sc'), centile(50)
                    local med = r(c_1)
                    local mlo = r(lb_1)
                    local mhi = r(ub_1)
                }
                local stt = cond(`n' >= `min_firms', "", "not drawn: fewer than `min_firms' firms")
                if `noearl' local stt "no earlier file in the data"
                post `pf' ("median") ("`pn'") (`c') ("`lf'") ("`smp'") ("`mname'") ("`ob_`c''") (.) (`k') ///
                    (`f`k'_`c'') ("median, starting file = 100") (`med') (`mlo') (`mhi') (`n') (.) (`crow') ("`stt'")
            }
            * -- shares by the third later file, and "came back up", for each band --
            foreach b of local bands {
                local blo = 1 - `b'/100
                local bhi = 1 + `b'/100
                local crowb = `crow' & `b' == `band_pct'
                * class: 1 down more than b%, 2 within b% either way, 3 up more than b% (the block's rule)
                capture drop cl1 cl3
                gen byte cl1 = cond(r_`m'1 < `blo', 1, cond(r_`m'1 > `bhi', 3, 2)) if !missing(r_`m'1)
                gen byte cl3 = cond(r_`m'3 < `blo', 1, cond(r_`m'3 > `bhi', 3, 2)) if !missing(r_`m'3)
                if `b' == `band_pct' assert cl3 == size_`m'          // same firms as the block's classes
                quietly count if cohort_year == `c' & (`sc') & !missing(cl3)
                local N = r(N)
                forvalues j = 1/3 {
                    if `j' == 1 local lab "down more than `b'%"
                    if `j' == 2 local lab "within `b'% either way"
                    if `j' == 3 local lab "up more than `b'%"
                    quietly count if cohort_year == `c' & (`sc') & cl3 == `j'
                    local kk = r(N)
                    local sh = .
                    local slo = .
                    local shi = .
                    if `N' > 0 {
                        quietly cii proportions `N' `kk', wilson
                        local sh  = 100 * `kk' / `N'
                        local slo = 100 * r(lb)
                        local shi = 100 * r(ub)
                    }
                    local stt = cond(`N' >= `min_firms', "", "not drawn: fewer than `min_firms' firms")
                    if `noearl' local stt "no earlier file in the data"
                    post `pf' ("share") ("c") (`c') ("`lf'") ("`smp'") ("`mname'") ("`ob_`c''") (`b') (3) ///
                        (`f3_`c'') ("`lab'") (`sh') (`slo') (`shi') (`N') (`kk') (`crowb') ("`stt'")
                }
                * down more than b% in the first later file (CSV only)
                quietly count if cohort_year == `c' & (`sc') & !missing(cl1)
                local N1 = r(N)
                quietly count if cohort_year == `c' & (`sc') & cl1 == 1
                local k1 = r(N)
                local sh = .
                local slo = .
                local shi = .
                if `N1' > 0 {
                    quietly cii proportions `N1' `k1', wilson
                    local sh  = 100 * `k1' / `N1'
                    local slo = 100 * r(lb)
                    local shi = 100 * r(ub)
                }
                post `pf' ("share_f1") ("") (`c') ("`lf'") ("`smp'") ("`mname'") ("`ob_`c''") (`b') (1) ///
                    (`f1_`c'') ("down more than `b'% in the first later file") (`sh') (`slo') (`shi') (`N1') (`k1') (0) ///
                    (cond(`noearl', "no earlier file in the data", ""))
                * came back up: down more than b% in the first later file, and within b% or
                * above by the third (share of the firms down in the first)
                quietly count if cohort_year == `c' & (`sc') & cl1 == 1 & !missing(cl3)
                local D = r(N)
                quietly count if cohort_year == `c' & (`sc') & cl1 == 1 & inlist(cl3, 2, 3)
                local R = r(N)
                local sh = .
                local slo = .
                local shi = .
                if `D' > 0 {
                    quietly cii proportions `D' `R', wilson
                    local sh  = 100 * `R' / `D'
                    local slo = 100 * r(lb)
                    local shi = 100 * r(ub)
                }
                local stt = cond(`D' >= `min_firms', "", "not drawn: fewer than `min_firms' firms")
                if `noearl' local stt "no earlier file in the data"
                post `pf' ("recovered") ("d") (`c') ("`lf'") ("`smp'") ("`mname'") ("`ob_`c''") (`b') (3) ///
                    (`f3_`c'') ("back within `b'% or above") (`sh') (`slo') (`shi') (`D') (`R') (`crowb') ("`stt'")
            }
        }
    }
}
postclose `pf'
use `res', clear
gen byte in_figure = chart_row & status == ""
replace status = "drawn" if in_figure & position > 0
replace status = "reference: 100 by definition" if in_figure & position == 0 & section == "median"
replace status = "not in the chart (table only)" if !chart_row & status == ""
* structural checks: the three classes add up to the firms with a ratio
bysort section cohort_year sample measure band_pct: egen double ksum = total(k_firms) if section == "share"
assert ksum == n_firms if section == "share"
drop ksum
quietly count if in_figure
assert r(N) > 0

*---------------------------------------------------------------------------
display "Step 5/8: write the table (numbers before drawing)"
*---------------------------------------------------------------------------
gsort -chart_row section cohort_year sample measure band_pct position stat
gen int row_id = _n
order row_id section panel cohort_year later_files sample measure outcome_basis band_pct position file_year stat ///
    value lo hi n_firms k_firms chart_row in_figure status
format value lo hi %12.4f
format n_firms k_firms %9.0f
export delimited using "tables/`fname'.csv", replace datafmt
list panel cohort_year measure position stat value lo hi n_firms k_firms if in_figure, ///
    noobs abbreviate(12) sepby(panel measure)

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes, read from the table just written (never typed)"
*---------------------------------------------------------------------------
import delimited using "tables/`fname'.csv", clear varnames(1) encoding("utf-8") ///
    stringcols(2 3 5 6 7 8 12 20)
tempfile csv
save `csv'
foreach c in `cohort_covid' `cohort_normal' {
    foreach s in "firms in the starting file" "stayed: in all three later files" "absent, then back in the third later file" {
        quietly summarize n_firms if section == "count" & cohort_year == `c' & stat == "`s'"
        local v = strtrim(string(r(mean), "%12.0fc"))
        if "`s'" == "firms in the starting file"             local ncoh_`c' "`v'"
        if "`s'" == "stayed: in all three later files"       local nst_`c'  "`v'"
        if "`s'" == "absent, then back in the third later file" local nbk_`c' "`v'"
    }
}
local lf1 "`f1_`cohort_covid''–`f3_`cohort_covid''"
local lf2 "`f1_`cohort_normal''–`f3_`cohort_normal''"
local outword = cond("`ob_`cohort_covid''" == "gross_output_real", "constant prices", "current prices")
* prices: say plainly what current prices do to panel (b)
local outnote = cond("`outword'" == "current prices", ///
    "(b) is in current prices (no price index in this file): output rises with prices even if a firm makes the same amount, and prices rose by different amounts in the two periods, so part of the gap between the two lines can be prices; workers (a) are not affected by prices.", ///
    "(b) is in constant prices (price changes taken out).")
* R10-03 uses only the stayers also in one of the two files before the starting file
local r10yrs "`p2_`cohort_covid'' or `p1_`cohort_covid''"
display "   2019: `nst_`cohort_covid'' of `ncoh_`cohort_covid'' stayed; 2012: `nst_`cohort_normal'' of `ncoh_`cohort_normal''; output `outword'"

*---------------------------------------------------------------------------
display "Step 7/8: draw (a)-(b) lines of the middle firm and (c)-(d) shares, then combine"
*---------------------------------------------------------------------------
* graph combine shrinks relative text sizes, so text is set in points (as in R3-06):
local sm "12pt"
local vs "9.5pt"
local k1 "`cohort_covid' firms, followed `lf1' (COVID years)"
local k2 "`cohort_normal' firms, followed `lf2' (normal years)"
* ---- top: (a) workers and (b) output, side by side in one plain twoway ----
* the right panel's positions are shifted by sh
local sh 4.6
use `csv' if section == "median" & chart_row == 1, clear
gen byte ser = cond(cohort_year == `cohort_covid', 1, 2)
gen byte pm  = cond(measure == "workers", 1, 2)
replace value = . if in_figure == 0
replace lo = .    if in_figure == 0
replace hi = .    if in_figure == 0
* the two series sit a little apart so their intervals do not overlap; they meet at 100
gen double x = position + (pm == 2) * `sh' + cond(position == 0, 0, cond(ser == 1, -0.07, 0.07))
* value labels: 100 once at the start; each series at its last point (higher one above)
gen str8 lab = string(value, "%5.1f") if position == 3 & !missing(value)
replace lab = "100" if position == 0 & ser == 1
bysort pm position (ser): gen double other = value[3 - _n] if _N == 2
gen byte lpos = cond(position == 0, 9, cond(value >= other | missing(other), 2, 4))
sort pm ser position
* one y scale for both panels, a round step that grows with the numbers; 100 always inside
quietly summarize lo
local dmin = min(r(min), 100)
quietly summarize hi
local dmax = max(r(max), 100)
local rng = `dmax' - `dmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`dmin' / `step')
local ytop = `step' * ceil(`dmax' / `step')
local yttl = `ytop' + 0.16 * (`ytop' - `ybot')
local yx1  = `ybot' - 0.08 * (`ytop' - `ybot')          // x labels: the 2019 firms' file
local yx2  = `ybot' - 0.15 * (`ytop' - `ybot')          // the 2012 firms' file, below it
local ylow = `ybot' - 0.19 * (`ytop' - `ybot')
display "   y from `ybot' to `ytop' by `step'"
* per panel: faint grid, the dashed 100 line, x labels (two lines: the 2019 firms' file
* on top, the 2012 firms' file below) and the panel title
local grid ""
local ref ""
local xl ""
local txt ""
local ttl1 "(a) Workers"
local ttl2 "(b) Output (`outword')"
forvalues p = 1/2 {
    local o = (`p' - 1) * `sh'
    forvalues g = `ybot'(`step')`ytop' {
        if `g' != 100 local grid `grid' `g' `=`o' - 0.3' `g' `=`o' + 3.45'
    }
    local ref `ref' 100 `o' 100 `=`o' + 3.45'          // starts at the first point: the "100" label sits left of it
    forvalues k = 0/3 {
        local ya `cohort_covid'
        local yb `cohort_normal'
        if `k' > 0 local ya `f`k'_`cohort_covid''
        if `k' > 0 local yb `f`k'_`cohort_normal''
        local xl `"`xl' text(`yx1' `=`o' + `k'' "`ya'", size(`vs') place(c))"'
        local xl `"`xl' text(`yx2' `=`o' + `k'' "`yb'", size(`vs') place(c) color(gs6))"'
    }
    local txt `"`txt' text(`yttl' `=`o' - 0.35' "`ttl`p''", place(e) size(`sm'))"'
}
twoway (pci `grid', lcolor(gs15) lwidth(vthin)) ///
    (pci `ref', lcolor(gs8) lpattern(dash) lwidth(0.6pt)) ///
    (rcap lo hi x if ser == 2 & position > 0, lcolor(gs7) lwidth(0.6pt) msize(3pt)) ///
    (rcap lo hi x if ser == 1 & position > 0, lcolor(black) lwidth(0.6pt) msize(3pt)) ///
    (connected value x if ser == 2 & pm == 1, lcolor(gs5) lpattern(dash) lwidth(0.8pt) msymbol(Oh) mcolor(gs5) ///
        msize(4.5pt) mlwidth(0.7pt) mlabel(lab) mlabvposition(lpos) mlabsize(`vs') mlabcolor(gs5) mlabgap(1)) ///
    (connected value x if ser == 2 & pm == 2, lcolor(gs5) lpattern(dash) lwidth(0.8pt) msymbol(Oh) mcolor(gs5) ///
        msize(4.5pt) mlwidth(0.7pt) mlabel(lab) mlabvposition(lpos) mlabsize(`vs') mlabcolor(gs5) mlabgap(1)) ///
    (connected value x if ser == 1 & pm == 1, lcolor(black) lpattern(solid) lwidth(0.8pt) msymbol(O) mcolor(black) ///
        msize(4.5pt) mlabel(lab) mlabvposition(lpos) mlabsize(`vs') mlabcolor(black) mlabgap(1)) ///
    (connected value x if ser == 1 & pm == 2, lcolor(black) lpattern(solid) lwidth(0.8pt) msymbol(O) mcolor(black) ///
        msize(4.5pt) mlabel(lab) mlabvposition(lpos) mlabsize(`vs') mlabcolor(black) mlabgap(1)), ///
    `txt' `xl' ///
    ytitle("Middle firm's level (starting file = 100)", size(`vs')) ///
    ylabel(`ybot'(`step')`ytop', angle(0) noticks tlength(0) nogrid labsize(`vs') format(%9.0f)) ///
    yscale(noline range(`ylow' `=`ytop' + 0.2 * (`ytop' - `ybot')')) ///
    xlabel(none) xscale(noline range(-0.6 `=`sh' + 3.55')) ///
    xtitle("Annual file (upper year: the `cohort_covid' firms; lower year: the `cohort_normal' firms)", size(`vs')) ///
    legend(order(7 "`k1'" 5 "`k2'" 4 "95% interval of the middle firm" 2 "100 = level in the starting file") ///
        pos(6) cols(2) region(lcolor(none) margin(zero)) size(`vs') symxsize(8) keygap(1) colgap(4) rowgap(0.3)) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none)) fysize(52) name(pA, replace) nodraw

* ---- bottom: (c) change by the third later file, (d) came back up; one row per measure and starting file ----
local sh2 125
use `csv' if inlist(section, "share", "recovered") & chart_row == 1, clear
gen byte ser = cond(cohort_year == `cohort_covid', 1, 2)
gen byte pm  = cond(measure == "workers", 1, 2)
gen byte cls = cond(strpos(stat, "down") == 1, 1, cond(strpos(stat, "within") == 1, 2, 3)) if section == "share"
gen double y = (pm - 1) * 3.3 + ser
replace value = . if in_figure == 0
replace lo = .    if in_figure == 0
replace hi = .    if in_figure == 0
* one row per measure and starting file: the three pieces of the bar and the dot
keep pm ser y section cls value lo hi in_figure
gen str4 key = cond(section == "share", "s" + string(cls), "r")
drop section cls
reshape wide value lo hi in_figure, i(pm ser y) j(key) string
rename (valuer lor hir in_figurer) (rec rec_lo rec_hi rec_in)
drop los* his* in_figures*
gen double c1 = values1
gen double c2 = values1 + values2
gen double c3 = values1 + values2 + values3
gen double zero = 0
* piece labels (1 decimal), inside the piece when it is wide enough
gen double m1 = c1 / 2
gen double m2 = (c1 + c2) / 2
gen double m3 = (c2 + c3) / 2
gen double ylab_y = y - 0.04
forvalues j = 1/3 {
    gen str6 l`j' = string(values`j', "%4.1f") if values`j' >= 7
}
gen str40 nd = "not drawn: fewer than `min_firms' firms" if missing(c3)
gen double ndx = 1 if missing(c3)
* came back up: dot and 95% interval in the right panel, value label right of the interval
gen double rx  = rec + `sh2'
gen double rlo = rec_lo + `sh2'
gen double rhi = rec_hi + `sh2'
gen str6 rlab = string(rec, "%4.1f") if !missing(rec)
gen str40 rnd = "not drawn: fewer than `min_firms' firms" if missing(rec)
gen double rndx = `sh2' + 1 if missing(rec)
* rows: a bold heading per measure, then the two starting files
local s1n "`cohort_covid' firms"
local s2n "`cohort_normal' firms"
local ylb `"0 "{bf:Workers}" 1 "`s1n'" 2 "`s2n'" 3.3 "{bf:Output}" 4.3 "`s1n'" 5.3 "`s2n'""'
local ymx 5.8
* faint grid and panel titles
local grid ""
local xl ""
foreach o in 0 `sh2' {
    forvalues g = 0(20)100 {
        local grid `grid' -0.4 `=`o' + `g'' `ymx' `=`o' + `g''
        local xl `"`xl' `=`o' + `g'' "`g'""'
    }
}
local tc "(c) Third later file against the starting file"
local td "(d) Of those down at first: % back up"
twoway (pci `grid', lcolor(gs15) lwidth(vthin)) ///
    (rbar zero c1 y, horizontal barwidth(0.7) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar c1 c2 y, horizontal barwidth(0.7) fcolor(gs12) lcolor(gs12) lwidth(vthin)) ///
    (rbar c2 c3 y, horizontal barwidth(0.7) fcolor(white) lcolor(gs4) lwidth(0.5pt)) ///
    (rspike rlo rhi y, horizontal lcolor(black) lwidth(0.6pt)) ///
    (scatter y rx, msymbol(O) mcolor(black) msize(4.5pt)) ///
    (scatter ylab_y m1, msymbol(none) mlabel(l1) mlabposition(0) mlabsize(`vs') mlabcolor(white)) ///
    (scatter ylab_y m2, msymbol(none) mlabel(l2) mlabposition(0) mlabsize(`vs') mlabcolor(black)) ///
    (scatter ylab_y m3, msymbol(none) mlabel(l3) mlabposition(0) mlabsize(`vs') mlabcolor(black)) ///
    (scatter y rhi, msymbol(none) mlabel(rlab) mlabposition(3) mlabgap(1) mlabsize(`vs') mlabcolor(black)) ///
    (scatter ylab_y ndx, msymbol(none) mlabel(nd) mlabposition(3) mlabsize(`vs') mlabcolor(gs6)) ///
    (scatter ylab_y rndx, msymbol(none) mlabel(rnd) mlabposition(3) mlabsize(`vs') mlabcolor(gs6)), ///
    text(-1.1 -1 "`tc'", place(e) size(`sm')) text(-1.1 `=`sh2' - 1' "`td'", place(e) size(`sm')) ///
    yscale(reverse noline range(-1.3 `ymx')) ylabel(`ylb', angle(0) noticks tlength(0) nogrid labsize(`vs')) ytitle("") ///
    xscale(noline range(-1 `=`sh2' + 112')) xlabel(`xl', noticks tlength(0) labsize(`vs')) ///
    xtitle("% of the firms in the row", size(`vs')) ///
    legend(order(2 "Down more than `band_pct'%" 3 "Within `band_pct'% either way" 4 "Up more than `band_pct'%" ///
                 6 "Came back up" 5 "95% interval") ///
        pos(6) rows(1) region(lcolor(none) margin(zero)) size(`vs') symxsize(4) symysize(2.5) keygap(1.5) colgap(7)) ///
    graphregion(color(white) lcolor(white) margin(l+14)) plotregion(style(none)) fysize(36) name(pB, replace) nodraw

* Notes: one text, wrapped into lines of at most 136 characters (checked in the PDF: text runs wider than the PNG)
local ntext "Notes: Firm links are fictional in the development data, so who stays or leaves means nothing here; read this chart on the real BPS files. Stayers = firms of the starting file in all three later files (`nst_`cohort_covid'' of the `ncoh_`cohort_covid'' `cohort_covid' firms; `nst_`cohort_normal'' of the `ncoh_`cohort_normal'' `cohort_normal' firms), each against its own starting level. (a), (b): dot = the middle firm (median: half of the stayers above it, half below); bar = 95% interval. `outnote' (c): third later file against the starting file. (d): of the stayers more than `band_pct'% down in the first later file, the share back within `band_pct'% or above by the third. Firms that left the files (not proof of closure) are in Figure R4-01. Figure R10-03 compares exporters, importers and foreign-owned stayers with similar stayers, using only stayers also in `r10yrs' (table: this chart's numbers for those firms). What happened to the stayers, not the effect of COVID."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 136 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'
local tl1 "Figure R4-06. The `cohort_covid' firms still in every file `lf1': did their workers and output shrink, grow or come back up?"
local tl2 "Against the `cohort_normal' firms still in every file `lf2' (normal years)"
graph combine pA pB, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("`tl1'" "`tl2'", size(`sm') pos(11) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(`vs') span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) xsize(8.5) ysize(10.5)

graph export "figures/`fname'.png", width(2550) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion table - every plotted point, one row each (putpdf, no add-on)"
*---------------------------------------------------------------------------
* The medians and shares are not regression coefficients, so there is no regression
* table. The table is read back from the CSV written in Step 5 (the chart's numbers),
* after the chart is saved, so the chart and the CSV are not touched here.
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
* --- PART 2: this exhibit's rows ---------------------------------------------
* grp 1 = every plotted point (chart order); then two table-only checks:
* grp 2 = the same numbers for the stayers also in one of the two files before the
*         starting file (R10-03's firms); grp 3 = the middle level of ALL firms in
*         each file (not the same firms), for reading panel (b) against price rises.
use `csv' if (chart_row == 1 & inlist(section, "median", "share", "recovered")) | ///
    (sample == "also_in_earlier_file" & inlist(cohort_year, `cohort_covid', `cohort_normal') & ///
     ((section == "median" & position > 0) | (inlist(section, "share", "recovered") & band_pct == `band_pct'))) | ///
    (section == "file_med" & inlist(cohort_year, `cohort_covid', `cohort_normal') & position > 0), clear
quietly count if in_figure == 1
local n_fig = r(N)
gen byte grp = cond(chart_row == 1, 1, cond(section == "file_med", 3, 2))
gen byte ser = cond(cohort_year == `cohort_covid', 1, 2)
gen byte pm  = cond(measure == "workers", 1, 2)
gen byte pnl = cond(panel == "a", 1, cond(panel == "b", 2, cond(panel == "c", 3, 4)))
gen byte cls = cond(strpos(stat, "down") == 1, 1, cond(strpos(stat, "within") == 1, 2, 3)) if section == "share"
replace cls = position if inlist(section, "median", "file_med")
replace cls = 1 if section == "recovered"
* short panel names (the chart's full titles wrap in the table column)
local tc "(c) Third later file"
local td "(d) Of those down: % back up"
gen str80 t_panel = cond(pnl == 1, "(a) Workers", cond(pnl == 2, "(b) Output (`outword')", cond(pnl == 3, "`tc'", "`td'")))
gen str70 t_series = cond(ser == 1, "`cohort_covid' firms (COVID years)", "`cohort_normal' firms (normal years)")
replace t_series = "Check 1: `cohort_covid' firms of R10-03" if grp == 2 & ser == 1
replace t_series = "Check 1: `cohort_normal' firms, same rule" if grp == 2 & ser == 2
replace t_series = "Check 2: all firms, `cohort_covid' = 100" if grp == 3 & ser == 1
replace t_series = "Check 2: all firms, `cohort_normal' = 100" if grp == 3 & ser == 2
replace t_series = cond(pm == 1, "Workers: ", "Output: ") + t_series if pnl >= 3 & grp == 1
gen str60 t_pos = ""
replace t_pos = string(file_year) + " (starting file)" if section == "median" & position == 0
replace t_pos = string(file_year) + " (" + cond(position == 1, "1st", cond(position == 2, "2nd", "3rd")) + " later file)" ///
    if inlist(section, "median", "file_med") & position > 0
replace t_pos = string(file_year) + ": " + stat if section == "share"
replace t_pos = string(file_year) + ": " + stat if section == "recovered" & grp == 1
replace t_pos = string(file_year) + ": back up" if section == "recovered" & grp == 2
replace t_pos = cond(pm == 1, "Workers, ", "Output, ") + t_pos if pnl >= 3 & grp == 2
* values as on the chart labels: one decimal
gen str16 t_v  = string(value, "%5.1f") if !missing(value)
replace t_v = "100 (reference)" if section == "median" & position == 0
gen str20 t_ci = string(lo, "%5.1f") + " to " + string(hi, "%5.1f") if !missing(lo, hi)
gen str24 t_n = strtrim(string(n_firms, "%12.0fc"))
replace t_n = strtrim(string(k_firms, "%12.0fc")) + " of " + t_n if inlist(section, "share", "recovered")
gen str60 t_status = status
replace t_status = "same point as the `cohort_covid' firms (100)" if section == "median" & position == 0 & ser == 2 & in_figure
replace t_status = "drawn: bar piece" if section == "share" & in_figure
replace t_status = "drawn: dot and bar" if section == "recovered" & in_figure
replace t_status = "drawn: dot and bar" if section == "median" & position > 0 & in_figure
replace t_status = "table only: R10-03's firms" if grp == 2 & status == "not in the chart (table only)"
replace t_status = "table only: not the same firms" if grp == 3
assert t_status != ""
sort grp pnl pm ser cls
* check: every drawn point is in the table once, and the drawn rows come first
quietly count if in_figure == 1
assert r(N) == `n_fig'
quietly count if grp == 1
assert r(N) == `n_fig'
local nrows = _N
local rl ""
forvalues i = 1/`=_N - 1' {
    if pnl[`i'] != pnl[`i' + 1] | grp[`i'] != grp[`i' + 1] local rl "`rl' `i'"
}
local tnote "Table: first every point of Figure R4-06, panel by panel (status drawn), then two checks that are not drawn. Values rounded as the chart"
local tnote "`tnote' labels (one decimal). Median interval: exact 95% interval from the order of the firms (Stata centile); share intervals: Wilson."
local tnote "`tnote' Firms: stayers behind the point; for (c) firms in the piece of all stayers in the row; for (d) firms back up of the firms down"
local tnote "`tnote' in the first later file. Check 1: the same numbers for the stayers also in one of the two files before the starting file (`r10yrs' for the"
local tnote "`tnote' `cohort_covid' firms), the firms Figure R10-03 uses (R10-03 compares exporters, importers and foreign-owned stayers with similar stayers in regressions;"
local tnote "`tnote' here each firm is set against its own starting level, no model; a firm with 0 workers later counts here as down 100% and is"
local tnote "`tnote' left out of R10-03's logs). Check 2: the middle level of all firms in each file (not the same firms, no interval), starting file"
local tnote "`tnote' = 100: a change shared by every firm of a file, such as price rises (on the development file also the masking), moves it too."
local tnote "`tnote' The 5% and 20% bands and other normal-years starting files: tables/`fname'.csv."
order t_panel t_series t_pos t_v t_ci t_n t_status
ctable_pdf t_panel t_series t_pos t_v t_ci t_n t_status using "tables/`fname'_table.pdf", ///
    title("Table R4-06. The `cohort_covid' firms still in every file `lf1' against the `cohort_normal' firms: every plotted point") ///
    subtitle("Level against the starting file (= 100), and % of stayers. Every plotted point first (`n_fig' rows), then two checks that are not drawn.") ///
    header("Panel" "Starting file" "File" "Plotted|value" "95% interval" "Firms" "Status") ///
    right(4 5 6) norepeat(1 2) rules(`rl') perpage(32) fontsize(8.5) landscape ///
    notes("`ntext'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`nrows' rows; `n_fig' drawn)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
