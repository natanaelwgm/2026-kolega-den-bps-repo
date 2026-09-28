/*==========================================================================
  R9-02  Who made manufacturing cleaner? Each period's change in CO2 and
         energy per unit of value added (all firms taken together), split
         into: staying firms getting cleaner (within), value added shifting
         among staying firms (between, cross), firms appearing (entry) and
         firms disappearing (exit). FHK method (Foster, Haltiwanger, Krizan).
  Answers Bu Deasy R9: "Who decarbonised Indonesian manufacturing: firms
         becoming cleaner or production reallocating toward cleaner firms?"
         "Accounting decomposition, bukan causal regression. FHK
         decomposition ... Within + reallocation + entry + exit."
  Output : figures/02_fhk_decomposition.png (+ .pdf)
           tables/02_fhk_decomposition.csv       (every period x measure x
                  version: levels, the five parts, counts; year-to-year chain)
           tables/02_fhk_decomposition_table.pdf (every plotted point, then
                  all measures and versions, then the year-to-year chain)
  Uses the shared blocks "R9 UNIVERSE, WEIGHTS AND INTERVALS" (from R9-01)
  and "R9 DECOMPOSITION PROGRAMS" (tested in R9-06), copied unchanged.
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
local fname "02_fhk_decomposition"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R9-02] STARTING: FHK split of the change in CO2 and energy per unit of value added ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/6: load the variables we need"
*---------------------------------------------------------------------------
* total_gj_s1  = energy use in GJ (nine fuels + purchased electricity; partial scope)
* co2_total_s1 = CO2 in tonnes from the same fuels and electricity (energy x standard factors)
* co2_scope1_s1 / co2_scope2_s1 = the CO2 from burning fuels / from bought electricity
* value_added_nominal  = value added, current prices (masked money unit)
* gross_output_nominal = output value, current prices (for the CO2-per-output version)
* industry2_reported   = 2-digit sector (used by the extreme-record rule)
use firm_id year value_added_nominal gross_output_nominal total_gj_s1 co2_total_s1 ///
    co2_scope1_s1 co2_scope2_s1 industry2_reported identity_real_link_verified using "$DATA", clear
isid firm_id year
assert year != 2016
* the firm links of the development file are fictional: read it from the data, not typed
quietly count if identity_real_link_verified != 1
local fict_links = r(N) == _N
drop identity_real_link_verified

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
display "Step 2/6: split every period's change (FHK), main version and as filed"
*---------------------------------------------------------------------------
* Periods: the three of the chart, the whole span, and every pair of neighbouring
* files (the year-to-year chain; 2015->2017 spans the missing 2016 file).
* Measures (all per million units of the denominator; weights = the denominator's shares):
*   co2_va    CO2 (tonnes) per unit of value added          <- drawn, panel rows (dots)
*   gj_va     energy (GJ) per unit of value added            <- drawn (diamonds)
*   co2_out   CO2 per unit of output, output weights         (table only)
*   co2s1_va  scope 1 CO2 (fuels burned) per value added     (table only)
*   co2s2_va  scope 2 CO2 (bought electricity) per value added (table only)
* CO2 is computed from the same energy records, so both scopes exist wherever total CO2 does.
assert !missing(co2_scope1_s1, co2_scope2_s1) & co2_scope1_s1 >= 0 & co2_scope2_s1 >= 0 if r9_U
tempfile firmyears
save `firmyears'
local mlist "co2_va gj_va co2_out co2s1_va co2s2_va"
local num_co2_va   "co2_total_s1"
local den_co2_va   "value_added_nominal"
local num_gj_va    "total_gj_s1"
local den_gj_va    "value_added_nominal"
local num_co2_out  "co2_total_s1"
local den_co2_out  "gross_output_nominal"
local num_co2s1_va "co2_scope1_s1"
local den_co2s1_va "value_added_nominal"
local num_co2s2_va "co2_scope2_s1"
local den_co2s2_va "value_added_nominal"
local if_co2_out   "if !missing(r9_o_co2)"      // output above zero (always true in this file)

tempname h
tempfile res
postfile `h' int ord str9 interval str10 kind str14 period int(start_year end_year years_between) ///
    str80 data_warning str8 measure str8 sample ///
    long(n_stayers n_entrants n_leavers n_stayers_set_aside n_records_set_aside n_stayers_outside_universe) ///
    double(va_share_stayers_start va_share_stayers_end va_share_entrants_end va_share_leavers_start ///
           level_start level_end change within between cross entry exit sum_parts gap_rel) using `res', replace
local allp `"$R9_INTERVALS "$R9_LONG" $R9_PAIRS"'
local k 0
foreach p of local allp {
    local ++k
    local a : word 1 of `p'
    local b : word 2 of `p'
    local kind "pair"
    local pname ""
    if `k' <= 3 {
        local kind "main"
        local pname : word `k' of $R9_PERIODS
    }
    if `k' == 4 local kind "whole span"
    r9_interval_note `a' `b'
    local warn "`r(note)'"
    foreach smp in main asfiled {
        use `firmyears', clear
        * the period sample: stayers, entrants, leavers; flagged stayers set aside in both years (main)
        r9_interval_sample `a' `b' `smp'
        foreach r in n_stayers n_entrants n_leavers n_stayers_set_aside n_records_set_aside n_stayers_outside_universe {
            local `r' = r(`r')
        }
        if "`smp'" == "main" local shown "stayers `n_stayers', entrants `n_entrants', leavers `n_leavers'"
        * drawn periods (for the notes): staying firms whose value added fell between the two
        * years, and their share of all staying firms' start-year value added
        if "`smp'" == "main" & `k' <= 3 {
            preserve                   // keeps the row order the FHK runs below use
            quietly {
                bysort firm_id (year): gen byte r9n_fall = r9_grp == 1 & _N == 2 ///
                    & value_added_nominal[2] < value_added_nominal[1]
                summarize value_added_nominal if r9_grp == 1 & year == `a', meanonly
                local vstay = r(sum)
                summarize value_added_nominal if r9n_fall & year == `a', meanonly
                local fallsh_`k' = r(sum) / `vstay'
                count if r9n_fall & year == `a'
                local nfall_`k' = r(N)
            }
            restore
            display "   `a'->`b': `nfall_`k'' of `n_stayers' staying firms lost value added; they held " ///
                %4.1f 100 * `fallsh_`k'' "% of staying firms' start value added"
        }
        foreach m of local mlist {
            quietly r9_fhk `num_`m'' `den_`m'' `if_`m'', firm(firm_id) year(year) from(`a') to(`b')
            * parts add up to the change; shares sum to 1; level = total over total
            assert r(gap_rel) < 1e-9
            assert abs(r(sum_s_from) - 1) < 1e-9 & abs(r(sum_s_to) - 1) < 1e-9
            assert reldif(r(ratio_from), r(I_from)) < 1e-9 & reldif(r(ratio_to), r(I_to)) < 1e-9
            * the program finds the same stayers, entrants and leavers as the period sample
            if "`if_`m''" == "" assert r(n_stay) == `n_stayers' & r(n_enter) == `n_entrants' & r(n_exit) == `n_leavers'
            post `h' (`k') ("`a'-`b'") ("`kind'") ("`pname'") (`a') (`b') (`b' - `a') ("`warn'") ("`m'") ///
                (cond("`smp'" == "main", "main", "as filed")) ///
                (`n_stayers') (`n_entrants') (`n_leavers') (`n_stayers_set_aside') (`n_records_set_aside') ///
                (`n_stayers_outside_universe') (r(S_stay_from)) (r(S_stay_to)) (r(S_enter_to)) (r(S_exit_from)) ///
                (r(I_from)) (r(I_to)) (r(change)) (r(within)) (r(between)) (r(cross)) (r(entry)) (r(exit)) ///
                (r(sum_parts)) (r(gap_rel))
        }
    }
    display "   `a'->`b' (`kind', main version): `shown'  `warn'"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 3/6: results table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `res', clear
* "Reallocation" in Bu Deasy's words = between + cross (value added moving among staying firms)
gen double realloc = between + cross
* every part as % of the period's start level (the level of the period sample, see notes)
foreach v in change within between cross realloc entry exit {
    gen double pct_`v' = 100 * `v' / level_start
}
* year-to-year chain: running sum of each part over neighbouring files (level units).
* The sum need not equal the whole-span change: each pair has its own sample.
gen byte mo = .
local j 0
foreach m of local mlist {
    local ++j
    replace mo = `j' if measure == "`m'"
}
foreach v in change within between cross entry exit {
    bysort sample mo kind (start_year): gen double chain_`v' = sum(`v') if kind == "pair"
}
gen str40 measure_label = ""
replace measure_label = "CO2 per unit of value added"                  if measure == "co2_va"
replace measure_label = "Energy (GJ) per unit of value added"          if measure == "gj_va"
replace measure_label = "CO2 per unit of output (output weights)"      if measure == "co2_out"
replace measure_label = "Scope 1 CO2 (fuels) per unit of value added"  if measure == "co2s1_va"
replace measure_label = "Scope 2 CO2 (electricity) per unit of value added" if measure == "co2s2_va"
gen str80 note = "Development data: firm links fictional; entry and exit = sample rotation"
if !`fict_links' replace note = ""
sort ord sample mo
order ord interval kind period start_year end_year years_between data_warning measure measure_label sample ///
      n_stayers n_entrants n_leavers n_stayers_set_aside n_records_set_aside n_stayers_outside_universe ///
      va_share_* level_start level_end change within between cross realloc entry exit sum_parts gap_rel ///
      pct_* chain_* note
format va_share_* %9.4f
format level_* change within between cross realloc entry exit sum_parts chain_* %14.6f
format pct_* %9.3f
format gap_rel %9.2e
export delimited using "tables/`fname'.csv", datafmt replace
tempfile results
save `results'
list interval measure pct_change pct_within pct_between pct_cross pct_realloc pct_entry pct_exit ///
    if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va"), noobs sep(0) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 4/6: notes (numbers and years read from the data, never typed)"
*---------------------------------------------------------------------------
* how much of the value added sits in firms found in only one of the two years (drawn periods)
quietly summarize va_share_entrants_end if kind == "main" & sample == "main" & measure == "co2_va"
local nmin = r(min)
local nmax = r(max)
quietly summarize va_share_leavers_start if kind == "main" & sample == "main" & measure == "co2_va"
local nmin = round(100 * min(`nmin', r(min)))
local nmax = round(100 * max(`nmax', r(max)))
* staying firms' three parts (within, between, cross): large but mostly cancelling?
* "mostly cancel" = their sizes add up to more than 3 times their net, in every drawn case
gen byte drawn = kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va")
gen double stay_gross = abs(within) + abs(between) + abs(cross)
gen double pct_stay = 100 * (within + between + cross) / level_start
quietly count if drawn & stay_gross > 3 * abs(within + between + cross)
local ncan = r(N)
quietly count if drawn
local ndrawn = r(N)
quietly summarize pct_stay if drawn
local slo = round(r(min))
local shi = round(r(max))
foreach s in slo shi {
    local `s' = cond(``s'' > 0, "+", cond(``s'' < 0, "−", "")) + strofreal(abs(``s''))
}
local fl = round(100 * min(`fallsh_1', `fallsh_2', `fallsh_3'))
local fh = round(100 * max(`fallsh_1', `fallsh_2', `fallsh_3'))
local why "a staying firm whose value added falls shows more CO2 per unit of value added (within up) and a smaller share (cross down)"
if `ncan' == `ndrawn' local opp "Within, between and cross are large but mostly cancel (together only `slo'% to `shi'%): `why'; such firms held `fl'–`fh'% of staying firms' start value added."
else local opp "Within, between and cross can pull in opposite directions (together: `slo'% to `shi'%): `why'."
drop drawn stay_gross pct_stay
* period warnings, read from the shared block
local pw ""
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local a : word 1 of `p'
    local b : word 2 of `p'
    r9_interval_note `a' `b'
    local L = char(96 + `k')
    if "`r(note)'" != "" local pw = cond("`pw'" == "", "", "`pw'; ") + "(`L') `r(note)'"
}
if "`pw'" != "" local pw "Records: `pw'."
local fic "Entry and exit compare firms seen in one year only with the start level."
if `fict_links' local fic "Entry and exit (gray) = firms seen in one year only; firm links are fictional, so they only show the sample changing and mean nothing (they hold `nmin'–`nmax'% of value added)."
local ntext "Notes: Bookkeeping, not cause: each period's change in CO2 (or energy) per unit of value added, all firms together, split into parts adding up exactly to the total (last row), % of the start level; minus = lowers the level (cleaner). Within = staying firms' own change; between = value added moving to firms above (+) or below (−) the start average; cross = both at once; reallocation = between + cross. `opp' `fic' Levels: firms comparable in both years (slightly off Figure R9-01). Firm-years over $R9_RULE× their sector's median energy per unit of value added are set aside (other cut-offs: R9-07). `pw' Value added (output minus materials, energy and services bought) is in current prices, so price rises alone lower ratios."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 155 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
local nlines : word count `notelines'
display "   notes: `nlines' lines"
if `nlines' > 8 display as error "   WARNING: the notes run to `nlines' lines (limit 8)"

*---------------------------------------------------------------------------
display "Step 5/6: draw: one panel per period, one row per part, dots = CO2, diamonds = energy"
*---------------------------------------------------------------------------
keep if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va")
assert _N == 6
keep ord period start_year end_year years_between measure pct_* level_start n_stayers n_entrants n_leavers
* one row per part: 1 within, 2 between, 3 cross, 4 between + cross, 5 entry, 6 exit, 7 total
expand 7
bysort ord measure: gen byte part = _n
gen double val = cond(part == 1, pct_within, cond(part == 2, pct_between, cond(part == 3, pct_cross, ///
                 cond(part == 4, pct_realloc, cond(part == 5, pct_entry, cond(part == 6, pct_exit, pct_change))))))
* vertical position (top to bottom); headers sit at 1 and 6
gen double yrow = cond(part <= 4, part + 1, cond(part <= 6, part + 2, 9.4))
gen byte series = cond(measure == "co2_va", 1, 2)
gen double y = yrow + cond(series == 1, -0.17, 0.17)
gen byte gray = `fict_links' & inlist(part, 5, 6)
gen str8 lab = strofreal(round(val), "%9.0f")
replace lab = "0" if lab == "-0"
replace lab = subinstr(lab, "-", "−", 1)      // typographic minus, as in the notes
gen byte lpos = cond(val < 0, 9, 3)
rename ord panel
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local a : word 1 of `p'
    local b : word 2 of `p'
    local pn : word `k' of $R9_PERIODS
    local L = char(96 + `k')
    local len = `b' - `a'
    label define panel `k' "(`L') `a'–`=substr("`b'", 3, 2)', `pn' (`len' years)", add
}
label values panel panel
* shared x axis: symmetric around 0 with room for the value labels; about two labels each side
quietly summarize val
local M = max(abs(r(min)), abs(r(max)))
local mag = 10^floor(log10(`M'))
local half = `mag' * ceil(1.3 * `M' / `mag')
local step = `mag'
foreach f in 2 2.5 5 10 {
    if `half' / `step' > 2.5 local step = `f' * `mag'
}
local xl = `step' * floor(`half' / `step')
display "   x axis: -`half' to `half', labels every `step' (largest part `M')"
* axis labels with the same typographic minus as the point labels and notes
local xlabs ""
forvalues v = -`xl'(`step')`xl' {
    local xlabs `"`xlabs' `v' "`=cond(`v' < 0, "−", "")'`=abs(`v')'""'
}
* zero line, one per panel (keyed in the legend)
local n0 = _N
set obs `=`n0' + 6'
gen double zx = 0 if _n > `n0'
gen double zy = .
forvalues p = 1/3 {
    replace panel = `p' in `=`n0' + 2 * `p' - 1'
    replace panel = `p' in `=`n0' + 2 * `p''
    replace zy = 1.3 in `=`n0' + 2 * `p' - 1'
    replace zy = 9.9 in `=`n0' + 2 * `p''
}
local ylab `"2 "Staying firms' own change (within)" 3 "Value added shifts among them (between)" 4 "Both at once, same firm (cross)" 5 "Reallocation (between + cross)" 7 "Firms appearing (entry)" 8 "Firms disappearing (exit)" 9.4 "{bf:Total change}""'
local graykey ""
if `fict_links' local graykey `"4 "Gray = firms appearing or disappearing (fictional links: no meaning here)""'
sort panel zy series part
twoway (line zy zx, lcolor(gs8) lwidth(thin)) ///
    (scatter y val if series == 1 & !gray, msymbol(O) mcolor(black) msize(small)) ///
    (scatter y val if series == 2 & !gray, msymbol(Dh) mcolor(black) msize(small) mlwidth(medthin)) ///
    (scatter y val if series == 1 & gray, msymbol(O) mcolor(gs10) msize(small)) ///
    (scatter y val if series == 2 & gray, msymbol(Dh) mcolor(gs10) msize(small) mlwidth(medthin)) ///
    (scatter y val if !gray, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(1.2) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter y val if gray, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(1.2) mlabsize(vsmall) mlabcolor(gs10)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R9-02. Who made manufacturing cleaner? Each period's change in CO2 and energy per unit of value added," ///
              "split into staying firms' own change, value added shifting among them, and firms appearing or disappearing", ///
              size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(1.3 9.9)) ylabel(`ylab', angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall)) ///
    ytitle("") xscale(range(-`half' `half') lcolor(gs10)) ///
    xlabel(`xlabs', noticks tlength(0) labsize(vsmall) nogrid) ///
    xtitle("Part of the change, % of the period's start level (minus = lowers the level: cleaner)", size(vsmall)) ///
    legend(order(2 "CO2 (tonnes) per unit of value added" 3 "Energy (GJ) per unit of value added" `graykey' ///
                 1 "0 = no part in the change") ///
        rows(2) region(lcolor(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(10) ysize(7)

graph export "figures/`fname'.png", width(3000) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 6/6: companion tables: every plotted point, all measures, year-to-year chain (putpdf)"
*---------------------------------------------------------------------------
* Table R9-02: one row per plotted point, in chart order: panel (a) to (c), parts top
* to bottom, CO2 then energy. Built from the results saved at Step 3 (chart and CSV unchanged).
local plabs `""Staying firms' own change (within)" "Value added shifts among them (between)" "Both at once, same firm (cross)" "Reallocation (between + cross)" "Firms appearing (entry)" "Firms disappearing (exit)" "Total change""'
local pvars "within between cross realloc entry exit change"
use `results', clear
keep if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va")
expand 7
bysort ord measure: gen byte part = _n
gen byte series = cond(measure == "co2_va", 1, 2)
gen double pct = .
gen double lvl = .
forvalues j = 1/7 {
    local v : word `j' of `pvars'
    replace pct = pct_`v' if part == `j'
    replace lvl = `v' if part == `j'
}
gen str60 c_part = ""
forvalues j = 1/7 {
    local l : word `j' of `plabs'
    replace c_part = "`l'" if part == `j'
}
gen str60 c_panel = ""
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local pn : word `k' of $R9_PERIODS
    local L = char(96 + `k')
    replace c_panel = "(`L') " + string(start_year) + "–" + substr(string(end_year), 3, 2) + ", `pn' (" ///
        + string(years_between) + " years)" if ord == `k'
}
gen str40 c_line  = cond(series == 1, "CO2 (tonnes) per unit of value added", "Energy (GJ) per unit of value added")
* same rounding as the chart labels (whole %), then one more decimal, then the part in level units
gen str8  c_shown = strofreal(round(pct), "%9.0f")
replace c_shown = "0" if c_shown == "-0"
gen str10 c_pct   = strofreal(pct, "%9.1f")
replace c_pct = "0.0" if c_pct == "-0.0"
gen str12 c_lvl   = strofreal(lvl, cond(series == 1, "%12.2f", "%12.1f"))
* firms behind the point: stayers (parts 1-4), entrants (5), leavers (6), all firms (total)
gen long nf = cond(part <= 4, n_stayers, cond(part == 5, n_entrants, cond(part == 6, n_leavers, ///
              n_stayers + n_entrants + n_leavers)))
gen str8  c_firms = strofreal(nf, "%12.0fc")
gen str90 c_status = cond(`fict_links' & inlist(part, 5, 6), "gray (fictional firm links)", "drawn")
replace c_status = c_status + "; " + data_warning if data_warning != ""
* start levels for the footer (period sample)
local startl ""
forvalues k = 1/3 {
    local L = char(96 + `k')
    quietly summarize level_start if ord == `k' & series == 1 & part == 1, meanonly
    local s1 = strofreal(r(mean), "%9.2f")
    quietly summarize level_start if ord == `k' & series == 2 & part == 1, meanonly
    local s2 = strofreal(r(mean), "%9.1f")
    local startl = cond("`startl'" == "", "", "`startl'; ") + "(`L') CO2 `s1' t, energy `s2' GJ"
}
* check: every plotted point once (3 periods x 7 parts x 2 lines)
assert _N == 3 * 7 * 2
sort ord part series
by ord: replace c_panel = "" if _n > 1
by ord part: replace c_part = "" if _n > 1
local nrows = _N + 1
putpdf clear
putpdf begin, pagesize(letter) landscape font("Times New Roman", 9) margin(all, 0.6in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R9-02. Who made manufacturing cleaner? Each period's change in CO2 and energy per unit of value added, split into parts: every plotted point"), bold font("Times New Roman", 10)
matrix colw = (13, 19, 22, 5, 6, 8, 6, 21)     // column widths, % of the text width
putpdf table tb = data(c_panel c_part c_line c_shown c_pct c_lvl c_firms c_status), varnames width(colw) ///
    border(all, nil) halign(left)
putpdf table tb(.,.), margin(top, 1pt) margin(bottom, 1pt) font("Times New Roman", 8)
putpdf table tb(1,1) = ("Panel (period)"), bold font("Times New Roman", 8)
putpdf table tb(1,2) = ("Part (row on the chart)"), bold font("Times New Roman", 8)
putpdf table tb(1,3) = ("Line (legend)"), bold font("Times New Roman", 8)
putpdf table tb(1,4) = ("Shown (%)"), bold halign(right) font("Times New Roman", 8)
putpdf table tb(1,5) = ("% of start"), bold halign(right) font("Times New Roman", 8)
putpdf table tb(1,6) = ("Per million of VA"), bold halign(right) font("Times New Roman", 8)
putpdf table tb(1,7) = ("Firms"), bold halign(right) font("Times New Roman", 8)
putpdf table tb(1,8) = ("Status on chart"), bold font("Times New Roman", 8)
forvalues c = 4/7 {
    putpdf table tb(.,`c'), halign(right)
}
putpdf table tb(1,.), border(top, single, black)
putpdf table tb(1,.), border(bottom, single, black)
putpdf table tb(`nrows',.), border(bottom, single, black)
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
putpdf text (`"`ntext' Shown = the label on the chart (whole %). % of start = the part as % of the period's start level. Per million of VA = the part in tonnes of CO2 (or GJ) per million money units of value added. Start levels of the period samples: `startl'. Firms = firms behind the part: staying firms (within, between, cross), firms appearing (entry), firms disappearing (exit), all three (total). Not a regression: no coefficients or standard errors."')
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`devnote'")

* Table R9-02b: the three periods and the whole span, every measure, main version and as filed.
use `results', clear
keep if inlist(kind, "main", "whole span")
gen byte so = cond(sample == "main", 1, 2)
sort ord mo so
gen str30 t_per = string(start_year) + " to " + string(end_year)
replace t_per = t_per + " (" + period + ")" if period != ""
gen str18 t_mea = ""
replace t_mea = "CO2 / VA"           if measure == "co2_va"
replace t_mea = "Energy / VA"        if measure == "gj_va"
replace t_mea = "CO2 / output"       if measure == "co2_out"
replace t_mea = "Scope 1 CO2 / VA"   if measure == "co2s1_va"
replace t_mea = "Scope 2 CO2 / VA"   if measure == "co2s2_va"
gen str10 t_ver = sample
gen str10 t_s = strofreal(level_start, "%12.2f")
gen str10 t_e = strofreal(level_end, "%12.2f")
local tvars "t_per t_mea t_ver t_s t_e"
foreach v in change within between cross realloc entry exit {
    gen str8 t_`v' = strofreal(pct_`v', "%9.1f")
    replace t_`v' = "0.0" if t_`v' == "-0.0"
    local tvars "`tvars' t_`v'"
}
gen str8 t_nc = strofreal(n_stayers, "%12.0fc")
gen str8 t_nn = strofreal(n_entrants, "%12.0fc")
gen str8 t_nx = strofreal(n_leavers, "%12.0fc")
local tvars "`tvars' t_nc t_nn t_nx"
by ord: replace t_per = "" if _n > 1
by ord mo: replace t_mea = "" if _n > 1
local nrows2 = _N + 1
putpdf sectionbreak, pagesize(letter) landscape margin(all, 0.6in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R9-02b. The same split for every measure, main version and as filed (parts as % of the period's start level)"), bold font("Times New Roman", 10)
matrix colw2 = (13, 11, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 6)
putpdf table tc = data(`tvars'), varnames width(colw2) border(all, nil) halign(left)
putpdf table tc(.,.), margin(top, 1pt) margin(bottom, 1pt) halign(right) font("Times New Roman", 8)
putpdf table tc(.,1/3), halign(left)
local hd `""Period" "Measure" "Version" "Start level" "End level" "Total change" "Within" "Between" "Cross" "Between + cross" "Entry" "Exit" "Staying" "Entering" "Leaving""'
local c 0
foreach h of local hd {
    local ++c
    putpdf table tc(1,`c') = ("`h'"), bold font("Times New Roman", 8) halign(`=cond(`c' <= 3, "left", "right")')
}
putpdf table tc(1,.), border(top, single, black)
putpdf table tc(1,.), border(bottom, single, black)
putpdf table tc(`nrows2',.), border(bottom, single, black)
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
putpdf text ("Notes: Levels per million money units of the denominator: tonnes of CO2 (GJ for energy). VA = value added. CO2 / output uses output shares as weights. Scope 1 = CO2 from fuels burned at the firm; scope 2 = CO2 from bought electricity; the two add up to the CO2 / VA rows part by part. Main = firm-years with energy per unit of value added over $R9_RULE times their sector's median set aside (a firm set aside in one year is set aside in both); as filed = every record with value added and energy above zero. Parts as % of the start level; they add up to the total change. The whole span compares the first and last years directly.")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`devnote'")

* Table R9-02c: year-to-year chain (main version), in level units, with its running sum.
use `results', clear
keep if sample == "main" & inlist(measure, "co2_va", "gj_va") & inlist(kind, "pair", "whole span")
gen byte ko = cond(kind == "pair", 1, 3)
sort mo ko start_year
* the running sum at the last pair = sum of the year-to-year parts
by mo: gen byte lastpair = kind == "pair" & (kind[_n + 1] != "pair")
expand 2 if lastpair, gen(sumrow)
replace ko = 2 if sumrow
foreach v in change within between cross entry exit {
    replace `v' = chain_`v' if sumrow
}
sort mo ko start_year
gen str40 t_mea = cond(measure == "co2_va", "CO2 (tonnes) per million of VA", "Energy (GJ) per million of VA")
gen str32 t_yrs = string(start_year) + " to " + string(end_year)
replace t_yrs = "Sum of the year-to-year parts" if sumrow
replace t_yrs = string(start_year) + " to " + string(end_year) + " in one step" if kind == "whole span"
gen str60 t_rec = data_warning
replace t_rec = "" if sumrow | kind == "whole span"
gen str10 t_s = strofreal(level_start, "%12.2f") if !sumrow
gen str10 t_e = strofreal(level_end, "%12.2f") if !sumrow
local tvars "t_mea t_yrs t_rec t_s t_e"
foreach v in change within between cross entry exit {
    gen str10 t_`v' = strofreal(`v', "%12.2f")
    replace t_`v' = "0.00" if t_`v' == "-0.00"
    local tvars "`tvars' t_`v'"
}
by mo: replace t_mea = "" if _n > 1
local nrows3 = _N + 1
putpdf sectionbreak, pagesize(letter) landscape margin(all, 0.5in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R9-02c. Year to year: the same split for every pair of neighbouring annual files (main version, level units)"), bold font("Times New Roman", 10)
matrix colw3 = (13, 17, 25, 6, 5, 5, 5, 6, 6, 6, 6)
putpdf table td = data(`tvars'), varnames width(colw3) border(all, nil) halign(left)
putpdf table td(.,.), margin(top, 0pt) margin(bottom, 0pt) halign(right) font("Times New Roman", 8)
putpdf table td(.,1/3), halign(left)
local hd `""Measure" "Years" "Records" "Start level" "End level" "Change" "Within" "Between" "Cross" "Entry" "Exit""'
local c 0
foreach h of local hd {
    local ++c
    putpdf table td(1,`c') = ("`h'"), bold font("Times New Roman", 8) halign(`=cond(`c' <= 3, "left", "right")')
}
putpdf table td(1,.), border(top, single, black)
putpdf table td(1,.), border(bottom, single, black)
putpdf table td(`nrows3',.), border(bottom, single, black)
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
putpdf text ("Notes: Each pair of neighbouring annual files is split on its own sample (firms in both of its two years stay; the 2016 file does not exist, so one pair spans two years). The sum of the year-to-year parts need not equal the one-step split of the whole span: each pair has its own staying, appearing and disappearing firms and its own levels. Parts in tonnes of CO2 (or GJ) per million money units of value added (VA); they add up to the change in each row.")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`devnote'")
putpdf save "tables/`fname'_table.pdf", replace
display "table -> tables/`fname'_table.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
