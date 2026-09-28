/*==========================================================================
  R9-06  Do the two decomposition methods (FHK and Melitz-Polanec) add up
         exactly, and do they give the hand-worked answer on small made-up
         examples? This file tests the programs r9_fhk and r9_mp that
         R9-02 to R9-05 and R9-07 use on the data.
  Answers Bu Deasy R9: "Accounting decomposition, bukan causal regression.
         FHK decomposition + Melitz-Polanec dynamic decomposition.
         Within + reallocation + entry + exit."
  Output : figures/06_reconciliation_toy_tests.png (+ .pdf)
           tables/06_reconciliation_toy_tests_cases.csv            (made-up examples: expected vs computed)
           tables/06_reconciliation_toy_tests_data.csv  (the data: parts vs actual change)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r9-decarbonisation-decomposition"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/06_reconciliation_toy_tests.log", replace text
timer clear 1
timer on 1
display _newline "=== [R9-06] STARTING: test the FHK and Melitz-Polanec programs on made-up examples and on the data ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*###########################################################################
*## R9 DECOMPOSITION PROGRAMS (copy exactly into R9-02..05, 07)          ##
*## Tested here in R9-06. Never edit one copy alone: change it here,     ##
*## rerun R9-06, then copy this whole block again into every R9 file.    ##
*###########################################################################
* What the programs split: an aggregate ratio I in year t, e.g. total CO2 /
* total value added, is the value-added-weighted average of the firms' ratios:
*     I_t = sum_i num_it / sum_i den_it = sum_i s_it * a_it
*     a_it = scale * num_it / den_it   firm i's ratio (e.g. tonnes CO2 per million of value added)
*     s_it = den_it / sum_j den_jt     firm i's share of the year's value added (shares add to 1)
* Between a start year (from) and an end year (to) every firm is one of:
*     C = stays (in both years), N = enters (end year only), X = exits (start year only).
* FHK (Foster, Haltiwanger and Krizan), dI = I_to - I_from = sum of five parts:
*     within  = sum_C s_i,from * (a_i,to - a_i,from)            staying firms get cleaner
*     between = sum_C (a_i,from - I_from) * (s_i,to - s_i,from) value added shifts among staying firms
*     cross   = sum_C (a_i,to - a_i,from) * (s_i,to - s_i,from) both at once
*     entry   = sum_N s_i,to * (a_i,to - I_from)
*     exit    = - sum_X s_i,from * (a_i,from - I_from)
* Melitz-Polanec, dI = sum of four parts (each group G has share S_G, own level
* I_G = sum_G s_i a_i / S_G, plain average abar_G over its n_G firms and
*     cov_G = sum_G (s_i/S_G - 1/n_G) * (a_i - abar_G) = I_G - abar_G,
* i.e. n_G times the covariance of within-group shares and ratios):
*     stayers_mean = abar_C,to - abar_C,from                      staying firms' plain average
*     stayers_cov  = cov_C,to - cov_C,from                        shift of value added among staying firms
*     entry        = S_N,to   * (I_N,to - I_C,to)
*     exit         = S_X,from * (I_C,from - I_X,from)
* The two methods measure entry and exit against different benchmarks, so
* their parts need not match (R9-06 example 5 shows why); both add up exactly.
* Usage (r9_mp takes the same options except saving()):
*     r9_fhk num den [if], firm(id) year(year) from(#) to(#) [scale(#) setaside(flag) saving(file)]
*     num den    numerator and denominator (den above zero, num zero or more, never missing:
*                the calling file chooses its universe with -if-, the program never drops rows silently)
*     scale()    multiplies the firm ratios (default 1,000,000: per million units of the denominator)
*     setaside() 0/1 firm-year flag (e.g. extreme record); a firm flagged in EITHER year is left out
*                in BOTH years, so setting a record aside never creates a fake entrant or leaver
*     saving()   r9_fhk only: one row per firm with its five parts (zero where a part does not
*                apply), so R9-04 and R9-05 can add the parts up by group
* The data in memory are never changed. Results come back in r(); see -return list-.
* R9 samples: build each period's sample with r9_interval_sample (R9-01 block) first,
* then call without setaside(): that program already sets aside extreme records and
* firms outside the universe in one of the two years. setaside() is for other uses.
capture program drop _r9_prep
program define _r9_prep, rclass
    * Helper for r9_fhk and r9_mp, run on a preserved copy of the data: keeps the
    * two years, applies the set-aside rule, leaves one row per firm with
    * a0 s0 (start year) a1 s1 (end year) and status C, N or X.
    version 17
    syntax varlist(min=2 max=2 numeric) [if] [in], FIRM(varname) YEAR(varname numeric) ///
        FROM(integer) TO(integer) SCALE(real) [SETASIDE(varname numeric)]
    tokenize `varlist'
    local num `1'
    local den `2'
    if `from' >= `to' {
        display as error "R9 programs: from() must be an earlier year than to()"
        exit 198
    }
    marksample touse, novarlist
    quietly keep if `touse' & inlist(`year', `from', `to')
    keep `firm' `year' `num' `den' `setaside'
    capture isid `firm' `year'
    if _rc {
        display as error "R9 programs: firm() and year() must identify the rows"
        exit 459
    }
    quietly count if missing(`num', `den') | `den' <= 0 | `num' < 0
    if r(N) > 0 {
        display as error "R9 programs: `den' must be above zero and `num' zero or more, never missing"
        display as error "              (choose the universe with -if- before calling)"
        exit 459
    }
    local n_set = 0
    if "`setaside'" != "" {
        tempvar anyflag
        quietly bysort `firm': egen byte `anyflag' = max(`setaside' == 1)
        quietly count if `anyflag' == 1
        local n_set = r(N)
        quietly drop if `anyflag' == 1
    }
    tempname sn
    foreach t in from to {
        quietly count if `year' == ``t''
        if r(N) == 0 {
            display as error "R9 programs: no firms left in year ``t''"
            exit 2000
        }
        * Level straight from the totals, to check the weighted-average form.
        quietly summarize `num' if `year' == ``t'', meanonly
        scalar `sn' = r(sum)
        quietly summarize `den' if `year' == ``t'', meanonly
        return scalar ratio_`t' = `scale' * `sn' / r(sum)
    }
    tempvar tot a s
    quietly bysort `year': egen double `tot' = total(`den')
    quietly generate double `a' = `scale' * `num' / `den'
    quietly generate double `s' = `den' / `tot'
    sort `firm' `year'
    quietly by `firm': generate double a0 = `a'[1]  if `year'[1]  == `from'
    quietly by `firm': generate double s0 = `s'[1]  if `year'[1]  == `from'
    quietly by `firm': generate double a1 = `a'[_N] if `year'[_N] == `to'
    quietly by `firm': generate double s1 = `s'[_N] if `year'[_N] == `to'
    quietly by `firm': keep if _n == 1
    quietly generate str1 status = cond(!missing(s0) & !missing(s1), "C", cond(missing(s0), "N", "X"))
    keep `firm' status a0 s0 a1 s1
    return scalar n_setaside = `n_set'
end

capture program drop r9_fhk
program define r9_fhk, rclass
    version 17
    syntax varlist(min=2 max=2 numeric) [if] [in], FIRM(varname) YEAR(varname numeric) ///
        FROM(integer) TO(integer) [SCALE(real 1000000) SETASIDE(varname numeric) SAVING(string asis)]
    preserve
    _r9_prep `varlist' `if' `in', firm(`firm') year(`year') from(`from') to(`to') ///
        scale(`scale') setaside(`setaside')
    tempname Ia Ib ra rb nset ssa ssb v
    scalar `ra'   = r(ratio_from)
    scalar `rb'   = r(ratio_to)
    scalar `nset' = r(n_setaside)
    tempvar w0 w1
    quietly generate double `w0' = s0 * a0
    quietly generate double `w1' = s1 * a1
    quietly summarize `w0', meanonly
    scalar `Ia' = r(sum)
    quietly summarize `w1', meanonly
    scalar `Ib' = r(sum)
    quietly summarize s0, meanonly
    scalar `ssa' = r(sum)
    quietly summarize s1, meanonly
    scalar `ssb' = r(sum)
    * The five parts, firm by firm (zero where a part does not apply to the firm).
    quietly {
        generate double fhk_within  = cond(status == "C", s0 * (a1 - a0), 0)
        generate double fhk_between = cond(status == "C", (a0 - `Ia') * (s1 - s0), 0)
        generate double fhk_cross   = cond(status == "C", (a1 - a0) * (s1 - s0), 0)
        generate double fhk_entry   = cond(status == "N", s1 * (a1 - `Ia'), 0)
        generate double fhk_exit    = cond(status == "X", -s0 * (a0 - `Ia'), 0)
    }
    tempname tsum
    scalar `tsum' = 0
    foreach p in within between cross entry exit {
        tempname `p'
        quietly summarize fhk_`p', meanonly
        scalar ``p'' = r(sum)
        scalar `tsum' = `tsum' + ``p''
    }
    foreach g in C N X {
        quietly count if status == "`g'"
        local n_`g' = r(N)
    }
    tempname SCa SCb SNb SXa
    quietly summarize s0 if status == "C", meanonly
    scalar `SCa' = r(sum)
    quietly summarize s1 if status == "C", meanonly
    scalar `SCb' = r(sum)
    quietly summarize s1 if status == "N", meanonly
    scalar `SNb' = r(sum)
    quietly summarize s0 if status == "X", meanonly
    scalar `SXa' = r(sum)
    if `"`saving'"' != "" {
        quietly generate int from = `from'
        quietly generate int to   = `to'
        label variable status "C = stays (both years), N = enters (end year only), X = exits (start year only)"
        label variable s0 "share of value added, start year"
        label variable s1 "share of value added, end year"
        label variable a0 "firm ratio, start year"
        label variable a1 "firm ratio, end year"
        quietly save `saving', replace
    }
    restore
    display as text "FHK " `from' "->" `to' ": level " %9.4g `Ia' " -> " %9.4g `Ib' ///
        "  within " %9.4g `within' "  between " %9.4g `between' "  cross " %9.4g `cross' ///
        "  entry " %9.4g `entry' "  exit " %9.4g `exit' "  gap " %9.2e (`Ib' - `Ia' - `tsum')
    return scalar from       = `from'
    return scalar to         = `to'
    return scalar I_from     = `Ia'
    return scalar I_to       = `Ib'
    return scalar change     = `Ib' - `Ia'
    return scalar within     = `within'
    return scalar between    = `between'
    return scalar cross      = `cross'
    return scalar entry      = `entry'
    return scalar exit       = `exit'
    return scalar sum_parts  = `tsum'
    return scalar gap        = (`Ib' - `Ia') - `tsum'
    return scalar gap_rel    = abs((`Ib' - `Ia') - `tsum') / abs(`Ia')
    return scalar n_stay     = `n_C'
    return scalar n_enter    = `n_N'
    return scalar n_exit     = `n_X'
    return scalar S_stay_from = `SCa'
    return scalar S_stay_to   = `SCb'
    return scalar S_enter_to  = `SNb'
    return scalar S_exit_from = `SXa'
    return scalar sum_s_from  = `ssa'
    return scalar sum_s_to    = `ssb'
    return scalar ratio_from  = `ra'
    return scalar ratio_to    = `rb'
    return scalar n_setaside  = `nset'
end

capture program drop r9_mp
program define r9_mp, rclass
    version 17
    syntax varlist(min=2 max=2 numeric) [if] [in], FIRM(varname) YEAR(varname numeric) ///
        FROM(integer) TO(integer) [SCALE(real 1000000) SETASIDE(varname numeric)]
    preserve
    _r9_prep `varlist' `if' `in', firm(`firm') year(`year') from(`from') to(`to') ///
        scale(`scale') setaside(`setaside')
    tempname nset Ia Ib
    scalar `nset' = r(n_setaside)
    tempvar w0 w1
    quietly generate double `w0' = s0 * a0
    quietly generate double `w1' = s1 * a1
    quietly summarize `w0', meanonly
    scalar `Ia' = r(sum)
    quietly summarize `w1', meanonly
    scalar `Ib' = r(sum)
    quietly count if status == "C"
    local n_C = r(N)
    quietly count if status == "N"
    local n_N = r(N)
    quietly count if status == "X"
    local n_X = r(N)
    tempname SCa SCb ICa ICb mCa mCb cCa cCb SNb INb SXa IXa pm pc pn px tsum
    foreach q in SCa SCb ICa ICb mCa mCb cCa cCb pm pc {
        scalar ``q'' = .
    }
    if `n_C' > 0 {
        * Staying firms: share, own level, plain average, covariance (written out, see block header).
        tempvar t
        foreach k in 0 1 {
            local sfx = cond(`k' == 0, "a", "b")
            quietly summarize s`k' if status == "C", meanonly
            scalar `SC`sfx'' = r(sum)
            quietly summarize a`k' if status == "C", meanonly
            scalar `mC`sfx'' = r(mean)
            quietly generate double `t' = s`k' * a`k' / `SC`sfx'' if status == "C"
            quietly summarize `t', meanonly
            scalar `IC`sfx'' = r(sum)
            quietly replace `t' = (s`k' / `SC`sfx'' - 1 / `n_C') * (a`k' - `mC`sfx'') if status == "C"
            quietly summarize `t', meanonly
            scalar `cC`sfx'' = r(sum)
            drop `t'
        }
        scalar `pm' = `mCb' - `mCa'
        scalar `pc' = `cCb' - `cCa'
    }
    * Entrants (end year) and leavers (start year): share and own level.
    quietly summarize s1 if status == "N", meanonly
    scalar `SNb' = r(sum)
    tempvar u
    quietly generate double `u' = s1 * a1 if status == "N"
    quietly summarize `u', meanonly
    scalar `INb' = cond(`SNb' > 0, r(sum) / `SNb', .)
    quietly summarize s0 if status == "X", meanonly
    scalar `SXa' = r(sum)
    quietly replace `u' = s0 * a0 if status == "X"
    quietly summarize `u' if status == "X", meanonly
    scalar `IXa' = cond(`SXa' > 0, r(sum) / `SXa', .)
    if `n_C' > 0 {
        scalar `pn' = cond(`SNb' > 0, `SNb' * (`INb' - `ICb'), 0)
        scalar `px' = cond(`SXa' > 0, `SXa' * (`ICa' - `IXa'), 0)
        scalar `tsum' = `pm' + `pc' + `pn' + `px'
    }
    else {
        * No staying firm: the method is not defined (its benchmark is the stayers' level).
        scalar `pn'   = .
        scalar `px'   = .
        scalar `tsum' = .
    }
    restore
    display as text "MP  " `from' "->" `to' ": level " %9.4g `Ia' " -> " %9.4g `Ib' ///
        "  stayers' average " %9.4g `pm' "  stayers' reallocation " %9.4g `pc' ///
        "  entry " %9.4g `pn' "  exit " %9.4g `px' "  gap " %9.2e (`Ib' - `Ia' - `tsum')
    return scalar from         = `from'
    return scalar to           = `to'
    return scalar defined      = (`n_C' > 0)
    return scalar I_from       = `Ia'
    return scalar I_to         = `Ib'
    return scalar change       = `Ib' - `Ia'
    return scalar stayers_mean = `pm'
    return scalar stayers_cov  = `pc'
    return scalar entry        = `pn'
    return scalar exit         = `px'
    return scalar sum_parts    = `tsum'
    return scalar gap          = (`Ib' - `Ia') - `tsum'
    return scalar gap_rel      = abs((`Ib' - `Ia') - `tsum') / abs(`Ia')
    return scalar n_stay       = `n_C'
    return scalar n_enter      = `n_N'
    return scalar n_exit       = `n_X'
    return scalar mean_stay_from = `mCa'
    return scalar mean_stay_to   = `mCb'
    return scalar cov_stay_from  = `cCa'
    return scalar cov_stay_to    = `cCb'
    return scalar I_stay_from    = `ICa'
    return scalar I_stay_to      = `ICb'
    return scalar S_stay_from    = `SCa'
    return scalar S_stay_to      = `SCb'
    return scalar I_enter_to     = `INb'
    return scalar S_enter_to     = `SNb'
    return scalar I_exit_from    = `IXa'
    return scalar S_exit_from    = `SXa'
    return scalar n_setaside     = `nset'
end
*###########################################################################
*## END OF R9 DECOMPOSITION PROGRAMS                                     ##
*###########################################################################

*---------------------------------------------------------------------------
display "Step 1/7: made-up examples with answers worked out by hand"
*---------------------------------------------------------------------------
* Each example: 2 or 3 firms, two years (1 and 2), value added (va) and CO2.
* The firm ratio a = CO2 / va is chosen so every answer can be checked with
* pen and paper. Expected parts are typed below; the programs must match them.
*   1 No change          A: va 50, a 6; B: va 50, a 10, both years.            I 8 -> 8
*   2 Firms get cleaner  va 50/50 both years; A: a 10 -> 6; B: a 10.           I 10 -> 8
*   3 Value added moves  A a 6, B a 10 both years; va 50/50 -> 75/25.         I 8 -> 7
*   4 Cleaner firm enters A, B: a 10, va 50 both years; C enters, a 4, va 100. I 10 -> 7
*   5 Dirtier firm exits A, B: a 10, va 50 both years; C exits, a 16, va 100.  I 13 -> 10
*     FHK measures C against the start level 13: exit -1.5, and A and B gain
*     share while being below 13: between -1.5. Melitz-Polanec measures C
*     against the staying firms' level 10: exit -3. Both add up to -3.
*   6 All at once        start: A va 50 a 10, B va 30 a 20, X va 20 a 30 (exits)
*                        end:   A va 60 a 5,  B va 20 a 23, N va 20 a 10 (enters)
*                        I 17 -> 9.6; every part of both methods is non-zero.
*   7 Set-aside rule     example 6 plus stayer Z (flagged in year 1 only) and
*                        entrant W (flagged): with setaside() the answer must
*                        equal example 6 exactly, and 3 firm-years are set aside.
tempfile toyres
tempname toy
postfile `toy' byte case str40 example str24 method str24 part double(expected computed abs_diff) byte pass ///
    using `toyres', replace
local tol_toy = 1e-12          // made-up examples: computed must equal the hand answer to 12 decimals

capture program drop _toy_post
program define _toy_post
    * Posts one method's results against the hand answers: args = handle case example method, then
    * pairs "part=expected" in the global TOYEXP; reads the r() results just produced.
    args h case example method
    foreach pe of global TOYEXP {
        gettoken part expv : pe, parse("=")
        local expv = substr("`expv'", 2, .)
        local rname = cond("`part'" == "level_start", "I_from", cond("`part'" == "level_end", "I_to", "`part'"))
        post `h' (`case') ("`example'") ("`method'") ("`part'") (`expv') (r(`rname')) ///
            (abs(r(`rname') - `expv')) ((abs(r(`rname') - `expv') < $TOL_TOY))
    }
end
global TOL_TOY `tol_toy'

capture program drop _toy_data
program define _toy_data
    * Builds one made-up example from "firm year va co2 flag, firm year va co2 flag, ..."
    * (-input- cannot be used inside a loop in a do-file).
    clear
    local rows `"`0'"'
    local n = 0
    while `"`rows'"' != "" {
        gettoken row rows : rows, parse(",")
        if `"`row'"' == "," continue
        local ++n
        local r`n' `"`row'"'
    }
    quietly set obs `n'
    generate str1 firm = ""
    generate byte year = .
    generate double va = .
    generate double co2 = .
    generate byte flag = .
    forvalues i = 1/`n' {
        tokenize `"`r`i''"'
        quietly replace firm = "`1'" in `i'
        quietly replace year = `2'   in `i'
        quietly replace va   = `3'   in `i'
        quietly replace co2  = `4'   in `i'
        quietly replace flag = `5'   in `i'
    }
end

local d1 "A 1 50 300 0, B 1 50 500 0, A 2 50 300 0, B 2 50 500 0"
local d2 "A 1 50 500 0, B 1 50 500 0, A 2 50 300 0, B 2 50 500 0"
local d3 "A 1 50 300 0, B 1 50 500 0, A 2 75 450 0, B 2 25 250 0"
local d4 "A 1 50 500 0, B 1 50 500 0, A 2 50 500 0, B 2 50 500 0, C 2 100 400 0"
local d5 "A 1 50 500 0, B 1 50 500 0, C 1 100 1600 0, A 2 50 500 0, B 2 50 500 0"
local d6 "A 1 50 500 0, B 1 30 600 0, X 1 20 600 0, A 2 60 300 0, B 2 20 460 0, N 2 20 200 0"
* 7 = example 6 plus Z (stays; extreme record in year 1, a = 500) and W (enters; flagged).
local d7 "`d6', Z 1 100 50000 1, Z 2 100 100 0, W 2 1000 1000000 1"
local x1 "1 No change"
local x2 "2 Staying firms get cleaner"
local x3 "3 Value added moves to cleaner firm"
local x4 "4 Cleaner firm appears"
local x5 "5 Dirtier firm disappears"
local x6 "6 All at once"
local x7 "7 Set-aside rule (= example 6)"
* Hand answers: FHK parts, then Melitz-Polanec parts.
local f1 "level_start=8 level_end=8 change=0 within=0 between=0 cross=0 entry=0 exit=0"
local m1 "change=0 stayers_mean=0 stayers_cov=0 entry=0 exit=0"
local f2 "level_start=10 level_end=8 change=-2 within=-2 between=0 cross=0 entry=0 exit=0"
local m2 "change=-2 stayers_mean=-2 stayers_cov=0 entry=0 exit=0"
local f3 "level_start=8 level_end=7 change=-1 within=0 between=-1 cross=0 entry=0 exit=0"
local m3 "change=-1 stayers_mean=0 stayers_cov=-1 entry=0 exit=0"
local f4 "level_start=10 level_end=7 change=-3 within=0 between=0 cross=0 entry=-3 exit=0"
local m4 "change=-3 stayers_mean=0 stayers_cov=0 entry=-3 exit=0"
local f5 "level_start=13 level_end=10 change=-3 within=0 between=-1.5 cross=0 entry=0 exit=-1.5"
local m5 "change=-3 stayers_mean=0 stayers_cov=0 entry=0 exit=-3"
local f6 "level_start=17 level_end=9.6 change=-7.4 within=-1.6 between=-1 cross=-0.8 entry=-1.4 exit=-2.6"
local m6 "change=-7.4 stayers_mean=-1 stayers_cov=-3.25 entry=0.1 exit=-3.25"
local f7 "`f6' n_setaside=3"
local m7 "`m6' n_setaside=3"

forvalues c = 1/7 {
    _toy_data `d`c''
    local ex "`x`c''"
    local fexp "`f`c''"
    local mexp "`m`c''"
    local sa = cond(`c' == 7, "setaside(flag)", "")
    display as text _newline "   example `ex'"
    global TOYEXP `fexp'
    r9_fhk co2 va, firm(firm) year(year) from(1) to(2) scale(1) `sa'
    _toy_post `toy' `c' "`ex'" "FHK"
    global TOYEXP `mexp'
    r9_mp co2 va, firm(firm) year(year) from(1) to(2) scale(1) `sa'
    _toy_post `toy' `c' "`ex'" "Melitz-Polanec"
    if `c' == 6 {
        * The firm-by-firm file (used by R9-04 and R9-05) must add up to the same parts.
        tempfile ff
        global TOYEXP "within=-1.6 between=-1 cross=-0.8 entry=-1.4 exit=-2.6"
        quietly r9_fhk co2 va, firm(firm) year(year) from(1) to(2) scale(1) saving(`ff')
        preserve
        use `ff', clear
        foreach p in within between cross entry exit {
            quietly summarize fhk_`p', meanonly
            local fs_`p' = r(sum)
        }
        restore
        foreach p in within between cross entry exit {
            local e = cond("`p'" == "within", -1.6, cond("`p'" == "between", -1, cond("`p'" == "cross", -0.8, ///
                      cond("`p'" == "entry", -1.4, -2.6))))
            post `toy' (6) ("`ex'") ("FHK firm-by-firm file") ("`p'") (`e') (`fs_`p'') (abs(`fs_`p'' - `e')) ///
                ((abs(`fs_`p'' - `e') < `tol_toy'))
        }
    }
}
postclose `toy'

preserve
use `toyres', clear
format expected computed %9.4f
format abs_diff %9.1e
export delimited using "tables/06_reconciliation_toy_tests_cases.csv", datafmt replace
quietly count if pass == 0
local toy_fail = r(N)
quietly count
local toy_n = r(N)
quietly summarize abs_diff, meanonly
local toy_maxgap = r(max)
display as text "   made-up examples: `toy_n' checks, `toy_fail' failed, largest gap " %9.1e `toy_maxgap'
list case method part expected computed pass if pass == 0, noobs sep(0) abbreviate(24)
tempfile toysave
save `toysave'
restore

*---------------------------------------------------------------------------
display "Step 2/7: load the data and build the universe (R9-01 block, copied exactly)"
*---------------------------------------------------------------------------
* value_added_nominal = value added, current prices (masked money unit)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity; partial scope)
* co2_total_s1        = CO2 in tonnes from the same energy (= scope 1 + scope 2)
* gross_output_nominal = output value, current prices (for the CO2-per-output check)
use firm_id year value_added_nominal gross_output_nominal total_gj_s1 co2_total_s1 co2_scope1_s1 co2_scope2_s1 ///
    industry2_reported export_flag import_flag fdi_10_flag using "$DATA", clear
isid firm_id year
* ===========================================================================
* R9 UNIVERSE, WEIGHTS AND INTERVALS (copy exactly into later R9 files)
* ---------------------------------------------------------------------------
* Needs in memory, one row per firm and year (isid firm_id year):
*   firm_id year value_added_nominal gross_output_nominal total_gj_s1
*   co2_total_s1 industry2_reported
* Makes (all firm-year variables start with r9_):
*   r9_U      1 = in the as-filed universe: value added > 0 and energy > 0,
*               CO2 known. Energy 0 is left out, not read as "no energy":
*               the energy fields cover only some fuels.
*   r9_ratio  energy (GJ) per unit of value added (universe only)
*   r9_med    median r9_ratio of universe firms in the same 2-digit sector
*               and year (whole-year median if the sector is unknown)
*   r9_x      1 = extreme record: r9_ratio more than $R9_RULE times r9_med.
*               The rule is on energy and also sets the record aside for CO2.
*               A sector-year with one or two firms can never be flagged.
*   r9_M      1 = in the main universe (r9_U and not r9_x)
*   r9_s      value-added share among the year's main universe (sums to 1)
*   r9_so     output share among the year's main universe with output > 0
*   r9_a_co2  tonnes CO2 per million of value added   (firm ratio a_it)
*   r9_a_gj   GJ per million of value added
*   r9_o_co2  tonnes CO2 per million of output
*   Aggregate level I_t = sum of CO2 / sum of value added = sum_i r9_s * r9_a_co2
* Globals: R9_RULE, R9_RULE_ALT (other cut-offs, shown as checks),
*   R9_INTERVALS (the three periods, start and end year), R9_PERIODS (their names), R9_LONG (whole span), R9_JUMP_YRS (energy
*   recording jump), R9_DOUBT_YRS (energy records partly doubtful),
*   R9_YEARS (years with a file), R9_PAIRS (every pair of consecutive files).
* Programs:
*   r9_interval_sample A B [asfiled]  keeps one period's two years (A, B);
*       stayer = firm in both years; entrant = in B only; leaver = in A only.
*       Main version: extreme records are set aside and a stayer with an
*       extreme record in either year is set aside in BOTH years (so it does
*       not turn into a fake entrant or leaver). Likewise a firm in both files
*       but outside the universe in one of them (energy 0, value added <= 0)
*       is set aside in both years. "asfiled" keeps every universe record.
*       Recomputes r9_s and r9_so inside the period sample; makes r9_grp
*       (1 stayer, 2 entrant, 3 leaver). Use it between preserve/restore.
*   r9_interval_note A B  returns r(note): data warnings for that period.
* ---------------------------------------------------------------------------
global R9_RULE      100                  // extreme = more than 100 x the sector-year median
global R9_RULE_ALT  "30 50 300 1000"     // other cut-offs, reported as checks (R9-01 table, R9-07)
global R9_INTERVALS `""2010 2015" "2015 2018" "2018 2022""'
global R9_PERIODS   `""before Paris" "across Paris" "after Paris""'
global R9_LONG      "2010 2022"
global R9_JUMP_YRS  "2017"               // energy records jump: never a period end
global R9_DOUBT_YRS "2019 2020 2021 2022" // energy records partly doubtful (importers, export status unknown)

* universe and firm ratios
capture drop r9_*
gen byte r9_U = value_added_nominal > 0 & total_gj_s1 > 0 ///
    & !missing(value_added_nominal, total_gj_s1, co2_total_s1)
assert co2_total_s1 >= 0 if r9_U
gen double r9_ratio = total_gj_s1 / value_added_nominal if r9_U
gen double r9_a_co2 = 1e6 * co2_total_s1 / value_added_nominal if r9_U
gen double r9_a_gj  = 1e6 * total_gj_s1  / value_added_nominal if r9_U
gen double r9_o_co2 = 1e6 * co2_total_s1 / gross_output_nominal ///
    if r9_U & gross_output_nominal > 0 & !missing(gross_output_nominal)

* extreme-record rule (medians via pctile: egen median() computes in float)
bysort year industry2_reported: egen double r9_med = pctile(r9_ratio) if r9_U, p(50)
bysort year: egen double r9_medy = pctile(r9_ratio) if r9_U, p(50)
replace r9_med = r9_medy if r9_U & missing(industry2_reported)
drop r9_medy
gen byte r9_x = r9_U & r9_ratio > $R9_RULE * r9_med
gen byte r9_M = r9_U & !r9_x

* value-added and output weights on the main universe, per year
bysort year: egen double r9_tva = total(cond(r9_M, value_added_nominal, .))
gen double r9_s = value_added_nominal / r9_tva if r9_M
bysort year: egen double r9_tgo = total(cond(r9_M & !missing(r9_o_co2), gross_output_nominal, .))
gen double r9_so = gross_output_nominal / r9_tgo if r9_M & !missing(r9_o_co2)
drop r9_tva r9_tgo
bysort year: egen double r9_chk = total(r9_s)
assert abs(r9_chk - 1) < 1e-12 if r9_M
drop r9_chk

* years with a file and every pair of consecutive files (2015-2017 spans the missing 2016)
quietly levelsof year if r9_U, local(r9_yrs)
global R9_YEARS "`r9_yrs'"
global R9_PAIRS ""
local r9_prev ""
foreach y of global R9_YEARS {
    if "`r9_prev'" != "" global R9_PAIRS `"$R9_PAIRS "`r9_prev' `y'""'
    local r9_prev `y'
}
* every period end must have a file and must not be a jump year or 2016
local r9_jump "$R9_JUMP_YRS"
foreach p of global R9_INTERVALS {
    foreach y of local p {
        assert `: list y in r9_yrs'
        assert `: list y in r9_jump' == 0
    }
}

capture program drop r9_interval_sample
program define r9_interval_sample, rclass
    args a b mode
    if !inlist("`mode'", "", "main", "asfiled") {
        display as error "r9_interval_sample: third argument must be main or asfiled"
        exit 198
    }
    quietly {
        keep if inlist(year, `a', `b')
        * a firm in both files but outside the universe in one year (energy 0 or
        * value added <= 0) would look like an entrant or leaver: set aside in main
        bysort firm_id: gen byte r9_fstay = _N == 2
        bysort firm_id: egen byte r9_ufirm = min(r9_U)
        count if r9_fstay & !r9_ufirm & r9_U
        return scalar n_stayers_outside_universe = r(N)
        if "`mode'" != "asfiled" drop if r9_fstay & !r9_ufirm
        keep if r9_U
        drop r9_fstay r9_ufirm
        bysort firm_id: gen byte r9_stay = _N == 2
        bysort firm_id: egen byte r9_xfirm = max(r9_x)
        count if r9_stay & r9_xfirm & year == `a'
        return scalar n_stayers_set_aside = r(N)
        count if r9_x | (r9_stay & r9_xfirm)
        return scalar n_records_set_aside = r(N)
        if "`mode'" != "asfiled" drop if r9_x | (r9_stay & r9_xfirm)
        gen byte r9_grp = cond(r9_stay, 1, cond(year == `b', 2, 3))
        label define r9_grp 1 "stayer" 2 "entrant (appears)" 3 "leaver (disappears)", replace
        label values r9_grp r9_grp
        drop r9_stay r9_xfirm r9_s r9_so
        bysort year: egen double r9_tva = total(value_added_nominal)
        gen double r9_s = value_added_nominal / r9_tva
        bysort year: egen double r9_tgo = total(cond(!missing(r9_o_co2), gross_output_nominal, .))
        gen double r9_so = gross_output_nominal / r9_tgo if !missing(r9_o_co2)
        drop r9_tva r9_tgo
        count if r9_grp == 1 & year == `a'
        return scalar n_stayers = r(N)
        count if r9_grp == 2
        return scalar n_entrants = r(N)
        count if r9_grp == 3
        return scalar n_leavers = r(N)
    }
end

capture program drop r9_interval_note
program define r9_interval_note, rclass
    args a b
    local note ""
    local yrs "$R9_YEARS"
    forvalues y = `=`a' + 1'/`=`b' - 1' {
        if !`: list y in yrs' local note = cond("`note'" == "", "", "`note'; ") + "no annual file for `y'"
    }
    foreach y of global R9_JUMP_YRS {
        if inlist(`y', `a', `b') local note = cond("`note'" == "", "", "`note'; ") + "energy recording jump in `y'"
    }
    local d ""
    foreach y of global R9_DOUBT_YRS {
        if inlist(`y', `a', `b') local d "energy records partly doubtful"
    }
    if "`d'" != "" local note = cond("`note'" == "", "", "`note'; ") + "`d'"
    return local note "`note'"
end
* ============ end of R9 UNIVERSE, WEIGHTS AND INTERVALS ============
quietly count if r9_U
display "   firm-years in the universe: " r(N) " of " _N
quietly count if r9_x
display "   firm-years flagged as extreme records: " r(N)
* CO2 is computed from the same energy, so its scope parts must be present wherever energy is.
assert !missing(co2_scope1_s1, co2_scope2_s1) & co2_scope1_s1 >= 0 & co2_scope2_s1 >= 0 if r9_U
* Groups for the "each group on its own" check (status in that year; 9 = no answer).
gen byte grp_export  = cond(missing(export_flag), 9, export_flag)
gen byte grp_import  = cond(missing(import_flag), 9, import_flag)
gen byte grp_foreign = cond(missing(fdi_10_flag), 9, fdi_10_flag)
encode industry2_reported, generate(grp_sector)
tempfile firmyears
save `firmyears'

*---------------------------------------------------------------------------
display "Step 3/7: intervals, measures and samples to check"
*---------------------------------------------------------------------------
* Intervals: the three main ones of R9-02/03, every pair of neighbouring
* observed years (2015->2017 spans the missing 2016 file) and the whole span
* (all from the R9-01 block globals).
local ivals ""
foreach p of global R9_INTERVALS {
    local ivals "`ivals' `p' main"
}
foreach p of global R9_PAIRS {
    local ivals "`ivals' `p' year_to_year"
}
local ivals "`ivals' $R9_LONG whole_period"
* Measures: name numerator denominator (all ratios per million of the denominator).
local measures "co2_va co2_total_s1 value_added_nominal gj_va total_gj_s1 value_added_nominal co2_out co2_total_s1 gross_output_nominal co2s1_va co2_scope1_s1 value_added_nominal co2s2_va co2_scope2_s1 value_added_nominal"
local tol_data = 1e-9          // data: gap between parts and change below 1e-9 of the start level

*---------------------------------------------------------------------------
display "Step 4/7: run both programs on every interval x measure x sample"
*---------------------------------------------------------------------------
* Each period's sample comes from r9_interval_sample (R9-01 block), exactly as in
* R9-02 to R9-07: main = extreme records set aside, and a firm in both files set
* aside in both years if either record is extreme or outside the universe.
tempfile datres
tempname dr
postfile `dr' int(from to years_apart) str14 interval_type str80 caution str10 measure str9 sample str8 grouping ///
    int(groups groups_mp_undefined) long(n_stay n_enter n_exit firm_years_set_aside stayers_outside_universe) ///
    double(level_from level_to change fhk_within fhk_between fhk_cross fhk_entry fhk_exit ///
           mp_stayers_mean mp_stayers_cov mp_entry mp_exit ///
           gap_rel_fhk gap_rel_mp shares_err level_err scope_gap_rel_fhk scope_gap_rel_mp firmfile_gap_rel) ///
    byte pass using `datres', replace

local nruns = 0
local ni : word count `ivals'
forvalues k = 1(3)`ni' {
    local y0 : word `k' of `ivals'
    local y1 : word `=`k' + 1' of `ivals'
    local it : word `=`k' + 2' of `ivals'
    r9_interval_note `y0' `y1'
    local caution "`r(note)'"
    display as text "   interval `y0'->`y1' (`it')"
    foreach smp in asfiled main {
        use `firmyears', clear
        r9_interval_sample `y0' `y1' `smp'
        local n_sa = cond("`smp'" == "main", r(n_records_set_aside), 0)
        local n_ou = r(n_stayers_outside_universe)
        local nm : word count `measures'
        forvalues m = 1(3)`nm' {
            local mname : word `m' of `measures'
            local num   : word `=`m' + 1' of `measures'
            local den   : word `=`m' + 2' of `measures'
            local ifc = cond("`mname'" == "co2_out", "if !missing(r9_o_co2)", "")
            * --- all firms: both programs ---
            quietly r9_fhk `num' `den' `ifc', firm(firm_id) year(year) from(`y0') to(`y1')
            foreach q in I_from I_to change within between cross entry exit gap_rel n_stay n_enter n_exit ///
                         sum_s_from sum_s_to ratio_from ratio_to {
                local F_`q' = r(`q')
            }
            local sh_err = max(abs(`F_sum_s_from' - 1), abs(`F_sum_s_to' - 1))
            local lv_err = max(abs(`F_ratio_from' - `F_I_from') / `F_I_from', abs(`F_ratio_to' - `F_I_to') / `F_I_to')
            quietly r9_mp `num' `den' `ifc', firm(firm_id) year(year) from(`y0') to(`y1')
            foreach q in stayers_mean stayers_cov entry exit gap_rel {
                local M_`q' = r(`q')
            }
            local nruns = `nruns' + 1
            * keep the parts for the scope check (scope 1 + scope 2 = total)
            foreach q in within between cross entry exit {
                local keepF_`mname'_`q' = `F_`q''
            }
            foreach q in stayers_mean stayers_cov entry exit {
                local keepM_`mname'_`q' = `M_`q''
            }
            local keepI_`mname' = `F_I_from'
            * --- firm-by-firm FHK file adds up (main intervals only) ---
            local ff_gap = .
            if "`it'" == "main" {
                tempfile ff
                quietly r9_fhk `num' `den' `ifc', firm(firm_id) year(year) from(`y0') to(`y1') saving(`ff')
                preserve
                use `ff', clear
                local ff_gap = 0
                foreach q in within between cross entry exit {
                    quietly summarize fhk_`q', meanonly
                    local ff_gap = max(`ff_gap', abs(r(sum) - `F_`q'') / `F_I_from')
                }
                restore
            }
            * --- scope check, once the three CO2-per-value-added measures are done ---
            local sgF = .
            local sgM = .
            if "`mname'" == "co2s2_va" {
                local sgF = 0
                foreach q in within between cross entry exit {
                    local sgF = max(`sgF', abs(`keepF_co2s1_va_`q'' + `keepF_co2s2_va_`q'' - `keepF_co2_va_`q'') / `keepI_co2_va')
                }
                local sgM = 0
                foreach q in stayers_mean stayers_cov entry exit {
                    local sgM = max(`sgM', abs(`keepM_co2s1_va_`q'' + `keepM_co2s2_va_`q'' - `keepM_co2_va_`q'') / `keepI_co2_va')
                }
            }
            local ok = (`F_gap_rel' < `tol_data') & (`M_gap_rel' < `tol_data') & (`sh_err' < `tol_data') ///
                     & (`lv_err' < `tol_data') & (missing(`ff_gap') | `ff_gap' < `tol_data') ///
                     & (missing(`sgF') | (`sgF' < `tol_data' & `sgM' < `tol_data'))
            post `dr' (`y0') (`y1') (`y1' - `y0') ("`it'") ("`caution'") ("`mname'") ("`smp'") ("all") (1) (0) ///
                (`F_n_stay') (`F_n_enter') (`F_n_exit') (`n_sa') (`n_ou') ///
                (`F_I_from') (`F_I_to') (`F_change') (`F_within') (`F_between') (`F_cross') (`F_entry') (`F_exit') ///
                (`M_stayers_mean') (`M_stayers_cov') (`M_entry') (`M_exit') ///
                (`F_gap_rel') (`M_gap_rel') (`sh_err') (`lv_err') (`sgF') (`sgM') (`ff_gap') (`ok')
            * --- each group on its own (main intervals only) ---
            if "`it'" == "main" {
                foreach g in sector export import foreign {
                    local gF = 0
                    local gM = 0
                    local ng = 0
                    local nu = 0
                    quietly levelsof grp_`g', local(glev)
                    foreach v of local glev {
                        local ifg = cond("`ifc'" == "", "if grp_`g' == `v'", "`ifc' & grp_`g' == `v'")
                        * a group needs firms in both end years to have a change at all
                        quietly count if grp_`g' == `v' & year == `y0'
                        local c0 = r(N)
                        quietly count if grp_`g' == `v' & year == `y1'
                        if `c0' == 0 | r(N) == 0 continue
                        capture quietly r9_fhk `num' `den' `ifg', firm(firm_id) year(year) from(`y0') to(`y1')
                        if _rc == 2000 continue          // no firm of the group left in one year
                        else if _rc error _rc
                        local gF = max(`gF', r(gap_rel))
                        quietly r9_mp `num' `den' `ifg', firm(firm_id) year(year) from(`y0') to(`y1')
                        if r(defined) local gM = max(`gM', r(gap_rel))
                        else local ++nu
                        local ++ng
                    }
                    local ok = (`gF' < `tol_data') & (`gM' < `tol_data')
                    post `dr' (`y0') (`y1') (`y1' - `y0') ("`it'") ("`caution'") ("`mname'") ("`smp'") ("`g'") ///
                        (`ng') (`nu') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ///
                        (`gF') (`gM') (.) (.) (.) (.) (.) (`ok')
                }
            }
        }
    }
}
postclose `dr'
display "   decompositions run on all firms: `nruns' (each with both methods)"

*---------------------------------------------------------------------------
display "Step 5/7: write the numbers (before drawing)"
*---------------------------------------------------------------------------
use `datres', clear
format level_from level_to change fhk_* mp_* %12.6f
format gap_rel_* shares_err level_err scope_gap_* firmfile_gap_rel %9.2e
export delimited using "tables/06_reconciliation_toy_tests_data.csv", datafmt replace
list from to measure sample grouping groups change gap_rel_fhk gap_rel_mp pass ///
    if grouping == "all" & measure == "co2_va", noobs sep(0) abbreviate(24)
quietly count if pass == 0
local data_fail = r(N)
* Summary rows for the figure (read from the results, never typed).
quietly count if grouping == "all"
local r_all = r(N)
quietly summarize gap_rel_fhk if grouping == "all", meanonly
local g1 = r(max)
quietly summarize gap_rel_mp if grouping == "all", meanonly
local g2 = r(max)
quietly summarize groups if grouping != "all", meanonly
local r_grp = r(sum)
quietly summarize groups_mp_undefined if grouping != "all", meanonly
local r_grp_mpu = r(sum)
quietly summarize gap_rel_fhk if grouping != "all", meanonly
local g3a = r(max)
quietly summarize gap_rel_mp if grouping != "all", meanonly
local g3 = max(`g3a', r(max))
quietly summarize shares_err, meanonly
local g4 = r(max)
quietly summarize level_err, meanonly
local g5 = r(max)
quietly count if !missing(scope_gap_rel_fhk)
local r_scope = r(N)
quietly summarize scope_gap_rel_fhk, meanonly
local g6a = r(max)
quietly summarize scope_gap_rel_mp, meanonly
local g6 = max(`g6a', r(max))
quietly count if !missing(firmfile_gap_rel)
local r_ff = r(N)
quietly summarize firmfile_gap_rel, meanonly
local g7 = r(max)
quietly levelsof interval_type if grouping == "all", local(dummy)
quietly count if grouping == "all" & measure == "co2_va" & sample == "main"
local n_int = r(N)
display "   data checks: `data_fail' failed; largest gaps FHK " %9.1e `g1' ", MP " %9.1e `g2' ///
    ", groups " %9.1e `g3' ", shares " %9.1e `g4' ", level " %9.1e `g5' ", scope " %9.1e `g6' ", firm file " %9.1e `g7'

*---------------------------------------------------------------------------
display "Step 6/7: draw the two-panel table"
*---------------------------------------------------------------------------
* The figure is a table drawn in Stata: panel (a) the made-up examples (hand
* answers, which the programs matched), panel (b) the checks on the data.
use `toysave', clear
quietly count if pass == 0 & case <= 6
local anyfail_toy = r(N)
* keep one value per example and part: the hand answer (the programs matched it)
keep if inlist(method, "FHK", "Melitz-Polanec") & case <= 6
gen str24 key = cond(method == "FHK", "F_", "M_") + part
keep case key expected pass
bysort case: egen byte case_ok = min(pass)
drop pass
reshape wide expected case_ok, i(key) j(case)
* read the hand answers into locals (v_<key>_<example>) for the layout below
forvalues j = 1/`=_N' {
    local k = key[`j']
    forvalues c = 1/6 {
        local v_`k'_`c' = string(expected`c'[`j'], "%5.2f")
    }
}
forvalues c = 1/6 {
    quietly summarize case_ok`c', meanonly
    local ok`c' = cond(r(min) == 1 & `anyfail_toy' == 0, "yes", "NO")
}

* Layout: x runs 0-100 across the page, y runs 0-100 down the page (100 = top).
clear
set obs 400
gen double y = .
gen double x = .
gen str80 txt = ""
gen byte al = .            // 3 = left-aligned text, 9 = right-aligned number, 12 = small panel title
gen double ry = .          // horizontal rules: y, from x0 to x1
gen double rx0 = .
gen double rx1 = .
gen byte rw = .            // 1 = thin rule, 2 = medium rule
local i = 0
local r = 0
* column right edges for the six examples
local xc1 42
local xc2 53.6
local xc3 65.2
local xc4 76.8
local xc5 88.4
local xc6 100
* ---- panel (a)
local yy = 99
local ++i
quietly replace y = `yy' in `i'
quietly replace x = 0 in `i'
quietly replace txt = "(a) Made-up examples: the level and its parts, worked out by hand (tonnes CO2 per unit of value added)" in `i'
quietly replace al = 12 in `i'
local ++r
quietly replace ry = 97 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 2 in `r'
local h1 `""1 No" "2 Firms" "3 Value added" "4 Cleaner" "5 Dirtier" "6 All""'
local h2 `""change" "get cleaner" "moves to cleaner" "firm appears" "firm disappears" "at once""'
forvalues c = 1/6 {
    local a1 : word `c' of `h1'
    local a2 : word `c' of `h2'
    local ++i
    quietly replace y = 95.2 in `i'
    quietly replace x = `xc`c'' in `i'
    quietly replace txt = "`a1'" in `i'
    quietly replace al = 9 in `i'
    local ++i
    quietly replace y = 93.0 in `i'
    quietly replace x = `xc`c'' in `i'
    quietly replace txt = "`a2'" in `i'
    quietly replace al = 9 in `i'
}
local ++r
quietly replace ry = 91.5 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 1 in `r'
* rows: key | label | indent
local rows `""F_level_start|Level, first year|0" "F_level_end|Level, second year|0" "F_change|Change (second minus first)|0" "HDR|FHK method (Foster, Haltiwanger, Krizan)|0" "F_within|Within: staying firms get cleaner|1" "F_between|Between: value added shifts among staying firms|1" "F_cross|Cross: both at the same firm|1" "F_entry|Entry: firms that appear|1" "F_exit|Exit: firms that disappear|1" "HDR|Melitz-Polanec method|0" "M_stayers_mean|Staying firms: plain average|1" "M_stayers_cov|Staying firms: shift of value added|1" "M_entry|Entry: firms that appear|1" "M_exit|Exit: firms that disappear|1" "OK|Programs give the hand answer (every part)|0""'
local yy = 89.3
foreach rr of local rows {
    tokenize "`rr'", parse("|")
    local key `1'
    local lab `3'
    local ind `5'
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = cond(`ind' == 1, 2, 0) in `i'
    quietly replace txt = "`lab'" in `i'
    quietly replace al = 3 in `i'
    if "`key'" != "HDR" {
        forvalues c = 1/6 {
            local ++i
            quietly replace y = `yy' in `i'
            quietly replace x = `xc`c'' in `i'
            quietly replace txt = cond("`key'" == "OK", "`ok`c''", "`v_`key'_`c''") in `i'
            quietly replace al = 9 in `i'
        }
    }
    if "`key'" == "OK" {
        local ++r
        quietly replace ry = `yy' + 1.35 in `r'
        quietly replace rx0 = 0 in `r'
        quietly replace rx1 = 100 in `r'
        quietly replace rw = 1 in `r'
    }
    local yy = `yy' - 2.7
}
local ++r
quietly replace ry = `yy' + 1.35 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 2 in `r'
* ---- panel (b)
local yy = `yy' - 3.2
local ++i
quietly replace y = `yy' in `i'
quietly replace x = 0 in `i'
quietly replace txt = "(b) Checks on the data: parts against the actual change, all intervals, measures and samples" in `i'
quietly replace al = 12 in `i'
local ++r
quietly replace ry = `yy' - 2 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 2 in `r'
local yy = `yy' - 3.8
foreach hh in "70|Checked" "88|Largest gap" "100|Passed" {
    tokenize "`hh'", parse("|")
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = `1' in `i'
    quietly replace txt = "`3'" in `i'
    quietly replace al = 9 in `i'
}
local ++i
quietly replace y = `yy' in `i'
quietly replace x = 0 in `i'
quietly replace txt = "What must hold" in `i'
quietly replace al = 3 in `i'
local ++i
quietly replace y = `yy' - 2.2 in `i'
quietly replace x = 88 in `i'
quietly replace txt = "(share of the level)" in `i'
quietly replace al = 9 in `i'
local ++r
quietly replace ry = `yy' - 3.6 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 1 in `r'
local yy = `yy' - 5.8
local pass_all = cond(`data_fail' == 0, "yes", "NO")
local b1 "FHK parts add up to the change (all firms)|`r_all'|`g1'"
local b2 "Melitz-Polanec parts add up to the change (all firms)|`r_all'|`g2'"
local b3 "Both methods, each sector, export, import and foreign-owned group alone|`=2 * `r_grp' - `r_grp_mpu''|`g3'"
local b4 "Value-added shares add up to 1 in both years|`r_all'|`g4'"
local b5 "Level = total CO2 / total value added = weighted average of firms|`r_all'|`g5'"
local b6 "Scope 1 parts + scope 2 parts = total parts (both methods)|`=2 * `r_scope''|`g6'"
local b7 "Firm-by-firm FHK file (used by R9-04, R9-05) adds up to the parts|`r_ff'|`g7'"
forvalues b = 1/7 {
    tokenize "`b`b''", parse("|")
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = 0 in `i'
    quietly replace txt = "`1'" in `i'
    quietly replace al = 3 in `i'
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = 70 in `i'
    quietly replace txt = strtrim(string(`3', "%9.0fc")) in `i'
    quietly replace al = 9 in `i'
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = 88 in `i'
    quietly replace txt = cond(`5' == 0, "0", strtrim(string(`5', "%7.0e"))) in `i'
    quietly replace al = 9 in `i'
    local ++i
    quietly replace y = `yy' in `i'
    quietly replace x = 100 in `i'
    quietly replace txt = cond(`5' < `tol_data', "yes", "NO") in `i'
    quietly replace al = 9 in `i'
    local yy = `yy' - 2.7
}
local ++r
quietly replace ry = `yy' + 1.35 in `r'
quietly replace rx0 = 0 in `r'
quietly replace rx1 = 100 in `r'
quietly replace rw = 2 in `r'
local ybot = `yy' + 0.5

* Notes (also printed under the companion table)
local nl1 "Notes: Both methods split the change in an overall level (for example total CO2 / total value added) into parts: staying firms getting"
local nl2 "cleaner, value added shifting between firms, firms appearing, firms disappearing. A minus sign means the part lowers the level (cleaner)."
local nl3 "Panel (a): made-up firms whose right answer is worked out by hand; the programs used in R9-02 to R9-07 must return it. The methods measure"
local nl4 "entry and exit against different benchmarks, so their parts differ (example 5), but both add up. Panel (b): 1e-12 means 0.000000000001 of"
local nl5 "the level, i.e. computer rounding. Value added = output value minus materials, energy and services bought, current prices. This checks the"
local nl6 "arithmetic only: it cannot show whether the data are right, and on this file firms appearing or disappearing are rotation of fictional firm"
local nl7 "links, not real events."
local n_nl = 7

twoway (pcspike ry rx0 ry rx1 if rw == 2, lcolor(black) lwidth(medthin)) ///
       (pcspike ry rx0 ry rx1 if rw == 1, lcolor(gs8) lwidth(vthin)) ///
       (scatter y x if al == 3,  msymbol(none) mlabel(txt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
       (scatter y x if al == 9,  msymbol(none) mlabel(txt) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
       (scatter y x if al == 12, msymbol(none) mlabel(txt) mlabposition(3) mlabgap(0) mlabsize(small) mlabcolor(black)), ///
    title("Table R9-06. Do the two decomposition methods add up? Checks on made-up examples and on the data", ///
          size(small) position(11) span) ///
    note("`nl1'" "`nl2'" "`nl3'" "`nl4'" "`nl5'" "`nl6'" "`nl7'" "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    xscale(off range(0 100)) yscale(off range(`ybot' 100)) ylabel(none) xlabel(none) legend(off) ///
    plotregion(style(none) margin(l=1 r=2 t=0 b=0)) graphregion(color(white) margin(l=2 r=3 t=2 b=2)) ///
    xsize(8) ysize(8) scale(0.68)

graph export "figures/06_reconciliation_toy_tests.png", width(2400) replace
graph export "figures/06_reconciliation_toy_tests.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion table (every cell of the figure, with the program's exact result)"
*---------------------------------------------------------------------------
* Panel (a): one row per drawn cell (row x example), in the figure's order,
* with the hand answer shown on the figure and the program's own result.
* Checks not drawn (example 7, the firm-by-firm file, the Melitz-Polanec copy
* of the change) are listed after them with the reason.
use `toysave', clear
gen str24 key = cond(method == "FHK", "F_", cond(method == "Melitz-Polanec", "M_", "")) + part
gen int roword = .
local o = 0
foreach k in F_level_start F_level_end F_change F_within F_between F_cross F_entry F_exit ///
             M_stayers_mean M_stayers_cov M_entry M_exit {
    local ++o
    quietly replace roword = `o' if key == "`k'" & case <= 6
}
gen str60 rowlab = ""
local labs `""Level, first year" "Level, second year" "Change (second minus first)" "FHK within: staying firms get cleaner" "FHK between: value added shifts among staying firms" "FHK cross: both at the same firm" "FHK entry: firms that appear" "FHK exit: firms that disappear" "MP staying firms: plain average" "MP staying firms: shift of value added" "MP entry: firms that appear" "MP exit: firms that disappear""'
forvalues o = 1/12 {
    local l : word `o' of `labs'
    quietly replace rowlab = "`l'" if roword == `o'
}
gen str50 status = "drawn" if !missing(roword)
replace status = "extra (same as FHK change)" if key == "M_change" & case <= 6
replace status = "extra: set-aside rule" if case == 7
replace status = "extra: firm-by-firm file" if method == "FHK firm-by-firm file"
replace rowlab = method + ": " + part if missing(roword)
replace roword = 100 + _n if missing(roword)
gen str1 panel = "a"
gen str40 column = example
gen str12 shown = string(expected, "%5.2f") if status == "drawn"
gen str24 program = string(computed, "%18.12f")
gen str10 gap = string(abs_diff, "%7.1e")
gen str4 passed = cond(pass == 1, "yes", "NO")
keep panel case column roword rowlab shown program gap passed status
sort roword case
* Panel (b): the seven drawn rows (Passed = that row's largest gap below 1e-9 of the level).
local nb = _N
quietly set obs `=`nb' + 7'
forvalues b = 1/7 {
    tokenize "`b`b''", parse("|")
    local j = `nb' + `b'
    quietly replace panel  = "b" in `j'
    quietly replace column = "all checks" in `j'
    quietly replace roword = 200 + `b' in `j'
    quietly replace rowlab = "`1'" in `j'
    quietly replace shown  = cond(`5' == 0, "0", strtrim(string(`5', "%7.0e"))) in `j'
    quietly replace program = strtrim(string(`3', "%9.0fc")) + " checked" in `j'
    quietly replace gap    = strtrim(string(`5', "%9.2e")) in `j'
    quietly replace passed = cond(`5' < `tol_data', "yes", "NO") in `j'
    quietly replace status = "drawn" in `j'
}
quietly count if status == "drawn"
display "   companion table rows drawn on the figure: " r(N) " (the yes row of panel (a) is the Passed column)"
keep panel column rowlab shown program gap passed status
order panel column rowlab shown program gap passed status
putpdf clear
putpdf begin, pagesize(letter) landscape font("Times New Roman", 9) margin(all, 0.6in)
putpdf paragraph, font("Times New Roman", 11)
putpdf text ("Table R9-06. Do the two decomposition methods add up? Every cell of the figure")
putpdf paragraph
putpdf text ("Shown = number on the figure (hand answer in panel (a); largest gap in panel (b)). Program = what r9_fhk or r9_mp returned. Gap = absolute difference in panel (a) (tonnes CO2 per unit of value added, made-up units), share of the level in panel (b).")
local nr = _N + 1
matrix colw = (4, 19, 33, 6, 12, 7, 5, 14)     // column widths, % of the page width
putpdf table tb = data(panel column rowlab shown program gap passed status), varnames border(all, nil) ///
    halign(center) width(colw)
putpdf table tb(1,1) = ("Panel")
putpdf table tb(1,2) = ("Column (example)")
putpdf table tb(1,3) = ("Row, as on the figure")
putpdf table tb(1,4) = ("Shown")
putpdf table tb(1,5) = ("Program")
putpdf table tb(1,6) = ("Gap")
putpdf table tb(1,7) = ("Passed")
putpdf table tb(1,8) = ("Status")
putpdf table tb(1,.), border(top) border(bottom)
putpdf table tb(`nr',.), border(bottom)
putpdf table tb(.,4/7), halign(right)
local allnotes ""
forvalues k = 1/`n_nl' {
    local allnotes "`allnotes' `nl`k''"
}
putpdf paragraph
putpdf text ("`=strtrim("`allnotes'")'")
putpdf paragraph
putpdf text ("`srcnote'")
putpdf paragraph
putpdf text ("`devnote'")
putpdf save "tables/06_reconciliation_toy_tests_table.pdf", replace
display "   table -> tables/06_reconciliation_toy_tests_table.pdf"

* The tests must pass before R9-02 to R9-07 are believed (CSV and figure written first, so a failure can be read).
if `toy_fail' > 0 | `data_fail' > 0 {
    display as error "R9-06: `toy_fail' made-up checks and `data_fail' data checks FAILED - see tables/06_reconciliation_toy_tests_*.csv"
    exit 9
}

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/06_reconciliation_toy_tests.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
