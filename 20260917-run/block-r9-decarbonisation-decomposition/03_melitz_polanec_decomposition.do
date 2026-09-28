/*==========================================================================
  R9-03  Who decarbonised? The Melitz-Polanec split of the change in all
         firms' CO2 and energy per unit of value added: staying firms'
         plain average, value added shifting among staying firms, firms
         appearing, firms disappearing. Three periods: before, across and
         after the Paris Agreement.
  Answers Bu Deasy R9: "Who decarbonised Indonesian manufacturing: firms
         becoming cleaner or production reallocating toward cleaner firms?"
         Strategy: "Accounting decomposition, bukan causal regression. ...
         Melitz-Polanec dynamic decomposition. Within + reallocation +
         entry + exit."
  Output : figures/03_melitz_polanec_decomposition.png (+ .pdf)
           tables/03_melitz_polanec_decomposition.csv       (every period,
                  measure and sample: the four parts, group sizes, shares,
                  plain averages, levels and covariance terms)
           tables/03_melitz_polanec_decomposition_table.pdf (every plotted
                  point, and each group's numbers behind the parts)
  The FHK split of the same changes is R9-02; the programs are tested in R9-06.
  "Within" here is the staying firms' PLAIN average (each firm once); in R9-02
  it is weighted by value added, so the two can differ, even in sign.
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
local fname "03_melitz_polanec_decomposition"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R9-03] STARTING: Melitz-Polanec split of CO2 and energy per unit of value added, three periods ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load the variables we need"
*---------------------------------------------------------------------------
* total_gj_s1  = energy use in GJ (nine fuels + purchased electricity; partial scope)
* co2_total_s1 = CO2 in tonnes from the same fuels and electricity (energy x standard factors)
*                = co2_scope1_s1 (fuels burned at the plant) + co2_scope2_s1 (bought electricity)
* value_added_nominal  = value added, current prices (masked money unit)
* gross_output_nominal = output value, current prices (for the CO2-per-output variant)
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
display "Step 2/7: universe, extreme records and yearly levels (checks)"
*---------------------------------------------------------------------------
display "   extreme-record rule: more than $R9_RULE x the sector-year median energy per value added"
display `"   periods: $R9_INTERVALS  (whole span $R9_LONG)"'
quietly count if r9_U
display "   firm-years in the universe (as filed): " r(N) " of " _N
quietly count if r9_x
display "   firm-years set aside as extreme records: " r(N)
* scope 1 and scope 2 CO2 must be known wherever total CO2 is (the programs refuse missing numbers)
assert !missing(co2_scope1_s1, co2_scope2_s1) & co2_scope1_s1 >= 0 & co2_scope2_s1 >= 0 if r9_U
assert reldif(co2_scope1_s1 + co2_scope2_s1, co2_total_s1) < 1e-9 if r9_U
* Measures: short name | numerator | denominator | extra condition | description
*   co2_va   = tonnes CO2 per million of value added   (drawn, panel dots)
*   gj_va    = GJ of energy per million of value added (drawn, panel diamonds)
*   co2_out  = tonnes CO2 per million of output value, output weights (table only)
*   co2s1_va / co2s2_va = scope 1 (fuels) / scope 2 (bought electricity) CO2 per million of value added (table only)
local measures `""co2_va|co2_total_s1|value_added_nominal||CO2 (tonnes) per million of value added" "gj_va|total_gj_s1|value_added_nominal||Energy (GJ) per million of value added" "co2_out|co2_total_s1|gross_output_nominal|!missing(r9_o_co2)|CO2 (tonnes) per million of output value" "co2s1_va|co2_scope1_s1|value_added_nominal||Scope 1 CO2 (fuels) per million of value added" "co2s2_va|co2_scope2_s1|value_added_nominal||Scope 2 CO2 (bought electricity) per million of value added""'
* Yearly levels of every measure on all main-universe (or as-filed) firms of the year:
* the line of Figure R9-01. The period levels below differ slightly (see notes).
tempfile firmyears yearly
save `firmyears'
foreach smp in main asfiled {
    foreach ms of local measures {
        tokenize "`ms'", parse("|")
        local mname `1'
        local num `3'
        local den `5'
        local cnd = cond("`mname'" == "co2_out", "& !missing(r9_o_co2)", "")
        use `firmyears', clear
        if "`smp'" == "main"    keep if r9_M `cnd'
        if "`smp'" == "asfiled" keep if r9_U `cnd'
        collapse (sum) n = `num' d = `den', by(year)
        gen double level_yearly = 1e6 * n / d
        gen str8 sample = "`smp'"
        gen str8 measure = "`mname'"
        keep year sample measure level_yearly
        capture append using `yearly'
        save `yearly', replace
    }
}

*---------------------------------------------------------------------------
display "Step 3/7: Melitz-Polanec split, every period x measure x sample"
*---------------------------------------------------------------------------
* Periods: the three main ones (drawn), the whole span, and every pair of
* neighbouring files (2015->2017 spans the missing 2016 file). Each period's
* sample comes from r9_interval_sample (R9-01 block): stayer = firm in both
* years; a stayer with an extreme or zero-energy record in either year is left
* out in BOTH years (main sample), so it never becomes a fake entrant or leaver.
* Then r9_mp (R9-06 block) splits the change:
*   change = stayers' plain-average change + change in the stayers' covariance
*            term + entry + exit      (formulae in the program block above)
tempfile res
tempname h
postfile `h' str9 interval str10 kind str14 period int(from to years_between) str8 sample str8 measure ///
    long(n_stayers n_entrants n_leavers n_records_set_aside n_stayers_set_aside n_stayers_outside_universe) ///
    double(level_from level_to change mp_stayers_mean mp_stayers_cov mp_entry mp_exit sum_parts gap_rel ///
           S_stay_from S_stay_to mean_stay_from mean_stay_to I_stay_from I_stay_to cov_stay_from cov_stay_to ///
           S_enter_to I_enter_to S_exit_from I_exit_from) str80 data_warning using `res', replace
local allp `"$R9_INTERVALS "$R9_LONG" $R9_PAIRS"'
local mpres "defined I_from I_to change stayers_mean stayers_cov entry exit sum_parts gap_rel S_stay_from S_stay_to mean_stay_from mean_stay_to I_stay_from I_stay_to cov_stay_from cov_stay_to S_enter_to I_enter_to S_exit_from I_exit_from"
local k 0
local nruns 0
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
        foreach ms of local measures {
            tokenize "`ms'", parse("|")
            local mname `1'
            local num `3'
            local den `5'
            local ifc = cond("`7'" == "|", "", "if `7'")
            use `firmyears', clear
            r9_interval_sample `a' `b' `smp'
            foreach r in n_stayers n_entrants n_leavers n_records_set_aside n_stayers_set_aside n_stayers_outside_universe {
                local `r' = r(`r')
            }
            * the sample is already cut, so no setaside() here
            quietly r9_mp `num' `den' `ifc', firm(firm_id) year(year) from(`a') to(`b')
            * keep the results as scalars (full precision) before any other command
            foreach q of local mpres {
                scalar M_`q' = r(`q')
            }
            assert M_defined == 1                       // every period has staying firms
            assert M_gap_rel < 1e-9                     // the four parts add up to the change
            * the value-added-weighted level of the period sample = the program's level
            if "`mname'" == "co2_va" {
                gen double w = r9_s * r9_a_co2
                quietly summarize w if year == `a'
                assert reldif(r(sum), M_I_from) < 1e-12
                drop w
            }
            local ++nruns
            post `h' ("`a'-`b'") ("`kind'") ("`pname'") (`a') (`b') (`b' - `a') ("`smp'") ("`mname'") ///
                (`n_stayers') (`n_entrants') (`n_leavers') (`n_records_set_aside') (`n_stayers_set_aside') ///
                (`n_stayers_outside_universe') ///
                (M_I_from) (M_I_to) (M_change) (M_stayers_mean) (M_stayers_cov) (M_entry) (M_exit) ///
                (M_sum_parts) (M_gap_rel) (M_S_stay_from) (M_S_stay_to) (M_mean_stay_from) (M_mean_stay_to) ///
                (M_I_stay_from) (M_I_stay_to) (M_cov_stay_from) (M_cov_stay_to) (M_S_enter_to) (M_I_enter_to) ///
                (M_S_exit_from) (M_I_exit_from) ("`warn'")
        }
    }
}
postclose `h'
display "   Melitz-Polanec splits run: `nruns'"

*---------------------------------------------------------------------------
display "Step 4/7: table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `res', clear
gen int row = _n                          // keep the row order through the merges
* the same years on Figure R9-01's yearly line (all main-universe firms of the year)
foreach e in from to {
    gen int year = `e'
    merge m:1 year sample measure using `yearly', keep(master match) nogenerate
    rename level_yearly level_`e'_yearly
    drop year
}
sort row
* each part as % of the period's start level (what the figure draws)
foreach q in change mp_stayers_mean mp_stayers_cov mp_entry mp_exit {
    gen double pct_`q' = 100 * `q' / level_from
}
rename pct_mp_* pct_*
* the covariance term split into its level and plain-average pieces (cov = I - abar)
assert abs(cov_stay_from - (I_stay_from - mean_stay_from)) < 1e-9 * level_from
assert abs(cov_stay_to   - (I_stay_to   - mean_stay_to))   < 1e-9 * level_from
* neighbouring pairs added up, from the first pair (a running sum; it does not have to
* equal the whole-span split: each pair has its own staying firms and set-aside records)
foreach q in change mp_stayers_mean mp_stayers_cov mp_entry mp_exit {
    bysort kind sample measure (from): gen double run_`q' = sum(`q') if kind == "pair"
}
sort row
drop row
gen str80 note = "Development data: firm links fictional; entry/exit = sample rotation"
if !`fict_links' replace note = ""
order interval kind period from to years_between sample measure data_warning n_stayers n_entrants n_leavers ///
      n_records_set_aside n_stayers_set_aside n_stayers_outside_universe level_from level_to ///
      level_from_yearly level_to_yearly change mp_stayers_mean mp_stayers_cov mp_entry mp_exit sum_parts gap_rel ///
      pct_change pct_stayers_mean pct_stayers_cov pct_entry pct_exit ///
      S_stay_from S_stay_to mean_stay_from mean_stay_to I_stay_from I_stay_to cov_stay_from cov_stay_to ///
      S_enter_to I_enter_to S_exit_from I_exit_from run_* note
format level_* change mp_* sum_parts mean_* I_* cov_* run_* %14.4f
format pct_* %9.2f
format S_* %9.4f
format gap_rel %9.2e
export delimited using "tables/`fname'.csv", datafmt replace
tempfile results
save `results'
list interval measure n_stayers level_from level_to pct_change pct_stayers_mean pct_stayers_cov pct_entry pct_exit ///
    if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va"), noobs sep(0) abbreviate(24)
list interval measure level_from pct_change pct_stayers_mean pct_stayers_cov pct_entry pct_exit ///
    if kind != "pair" & sample == "asfiled" & inlist(measure, "co2_va", "gj_va"), noobs sep(0) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 5/7: notes (numbers and years read from the data, never typed)"
*---------------------------------------------------------------------------
* value-added share of staying firms at the two ends of the drawn periods
quietly summarize S_stay_from if kind == "main" & sample == "main" & measure == "co2_va"
local smin = r(min)
local smax = r(max)
quietly summarize S_stay_to if kind == "main" & sample == "main" & measure == "co2_va"
local smin = strofreal(100 * min(`smin', r(min)), "%9.0f")
local smax = strofreal(100 * max(`smax', r(max)), "%9.0f")
* appearing and disappearing firms' share of value added = 100 minus the stayers' share
local nmin = 100 - `smax'
local nmax = 100 - `smin'
* period warnings, read from the shared block (same sentence as R9-02)
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
local fic "Entry and exit = share of value added times the gap to staying firms."
if `fict_links' local fic "Entry and exit (gray) = share of value added times the gap to staying firms; firm links are fictional, so they only show the sample changing and mean nothing (they hold `nmin'–`nmax'% of value added)."
* Within here is NOT the within of R9-02: plain average here, value-added weights there.
local ntext "Notes: Bookkeeping, not cause: each period's change in CO2 (or energy) per unit of value added, all firms together, split the Melitz–Polanec way into parts adding up exactly to the total (last row), % of the start level; minus = lowers the level (cleaner). Within = change in staying firms' plain average: each firm counts once whatever its size, so a few small firms with very high ratios can move it a lot. Figure R9-02's within weights firms by value added, so the two can differ, even in sign. Reallocation = change in how far staying firms' value-added-weighted level sits from their plain average: it moves when value added shifts to cleaner (−) or dirtier (+) firms and when big firms change differently from small ones. The two add up to the staying firms' own change (third row): read them together. `fic' Levels: firms comparable in both years (slightly off Figure R9-01). Firm-years over $R9_RULE× their sector's median energy per unit of value added are set aside. `pw' Value added (output minus materials, energy and services bought) is in current prices, so price rises alone lower ratios."
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
if `nlines' > 10 display as error "   WARNING: the notes run to `nlines' lines (limit 10)"

*---------------------------------------------------------------------------
display "Step 6/7: draw: one panel per period, rows = the four parts, staying firms together, and the total"
*---------------------------------------------------------------------------
* One row per plotted point: 3 periods x 6 rows x 2 measures (CO2 dots, energy diamonds).
keep if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va")
keep interval period from to years_between measure n_stayers n_entrants n_leavers level_from level_to ///
     change mp_stayers_mean mp_stayers_cov mp_entry mp_exit pct_change pct_stayers_mean pct_stayers_cov pct_entry pct_exit ///
     I_stay_from I_stay_to
* staying firms together = within + reallocation = change in the staying firms' own
* value-added-weighted level (checked): the two stayer parts often cancel, so draw their sum
gen double mp_stay_sum  = mp_stayers_mean + mp_stayers_cov
gen double pct_stay_sum = pct_stayers_mean + pct_stayers_cov
assert abs(mp_stay_sum - (I_stay_to - I_stay_from)) < 1e-9 * level_from
drop I_stay_from I_stay_to
gen int pno = .
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local a : word 1 of `p'
    replace pno = `k' if from == `a'
}
assert !missing(pno)
* panel titles from the data: "(a) Before Paris, 2010–2015 (5 years)"
local plet "a b c"
forvalues k = 1/3 {
    quietly summarize from if pno == `k', meanonly
    local a = r(min)
    quietly summarize to if pno == `k', meanonly
    local b = r(min)
    local pn : word `k' of $R9_PERIODS
    local l : word `k' of `plet'
    local ptl`k' "(`l') `a'–`=substr("`b'", 3, 2)', `pn' (`=`b' - `a'' years)"
}
label define pno 1 "`ptl1'" 2 "`ptl2'" 3 "`ptl3'"
label values pno pno
* long form: one row per part
rename (pct_stayers_mean pct_stayers_cov pct_entry pct_exit pct_change pct_stay_sum) (pct1 pct2 pct3 pct4 pct5 pct6)
rename (mp_stayers_mean mp_stayers_cov mp_entry mp_exit change mp_stay_sum) (u1 u2 u3 u4 u5 u6)
reshape long pct u, i(pno measure) j(part)
gen byte ser = cond(measure == "co2_va", 1, 2)
* firms behind each point: staying firms (parts 1, 2, 6), appearing, disappearing, all firms of the two years
gen long nfirms = cond(inlist(part, 1, 2, 6), n_stayers, cond(part == 3, n_entrants, cond(part == 4, n_leavers, ///
    n_stayers + n_entrants + n_leavers)))
* rotation rows (entry, exit) drawn gray on this file (fictional firm links)
gen byte gray = `fict_links' & inlist(part, 3, 4)
* rows top to bottom as in R9-02: within, reallocation, staying firms together, a gap,
* entry, exit, total; CO2 slightly above the row, energy slightly below
gen double yrow = cond(part <= 2, part + 1, cond(part == 6, 4, cond(part <= 4, part + 3, 8.4)))
gen double yy = yrow + cond(ser == 1, -0.17, 0.17)
gen str8 lab = strofreal(round(pct), "%9.0f")
replace lab = "0" if lab == "-0"
replace lab = subinstr(lab, "-", "−", 1)      // typographic minus, as in R9-02 and the notes
* labels on the outer side of each dot (left of negative values, right of positive ones)
gen byte lpos = cond(pct < 0, 9, 3)
sort pno yrow ser
tempfile pts
save `pts'          // kept for the companion points table (Step 7)

* shared x axis (same rule as R9-02): symmetric around 0, about two labels each side
quietly summarize pct
local M = max(abs(r(min)), abs(r(max)))
local mag = 10^floor(log10(`M'))
local half = `mag' * ceil(1.3 * `M' / `mag')
local step = `mag'
foreach f in 2 2.5 5 10 {
    if `half' / `step' > 2.5 local step = `f' * `mag'
}
local xl = `step' * floor(`half' / `step')
display "   x axis: -`half' to `half', labels every `step' (largest part `M')"
* axis labels with the same typographic minus as the point labels (as R9-02)
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
    replace pno = `p' in `=`n0' + 2 * `p' - 1'
    replace pno = `p' in `=`n0' + 2 * `p''
    replace zy = 1.3 in `=`n0' + 2 * `p' - 1'
    replace zy = 8.9 in `=`n0' + 2 * `p''
}
replace gray = 0 if missing(gray)
local ylab `"2 "Staying firms' plain average (within)" 3 "Reallocation among them (covariance)" 4 "Staying firms together (sum)" 6 "Firms appearing (entry)" 7 "Firms disappearing (exit)" 8.4 "{bf:Total change}""'
local graykey ""
if `fict_links' local graykey `"4 "Gray = firms appearing or disappearing (fictional links: no meaning here)""'
sort pno zy ser part
twoway (line zy zx, lcolor(gs8) lwidth(thin)) ///
    (scatter yy pct if ser == 1 & !gray, msymbol(O) mcolor(black) msize(small)) ///
    (scatter yy pct if ser == 2 & !gray, msymbol(Dh) mcolor(black) msize(small) mlwidth(medthin)) ///
    (scatter yy pct if ser == 1 & gray, msymbol(O) mcolor(gs10) msize(small)) ///
    (scatter yy pct if ser == 2 & gray, msymbol(Dh) mcolor(gs10) msize(small) mlwidth(medthin)) ///
    (scatter yy pct if !gray, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(1.2) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yy pct if gray, msymbol(none) mlabel(lab) mlabvposition(lpos) mlabgap(1.2) mlabsize(vsmall) mlabcolor(gs10)), ///
    by(pno, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R9-03. Who made manufacturing cleaner? The changes of Figure R9-02 split another way (Melitz–Polanec):" ///
              "staying firms' plain average, reallocation among them, and firms appearing or disappearing", ///
              size(small) pos(11) span) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(1.3 8.9)) ylabel(`ylab', angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall)) ///
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
display "Step 7/7: companion tables: every plotted point, and each group behind the parts (putpdf)"
*---------------------------------------------------------------------------
* Table R9-03: one row per plotted point, in chart order: panel (a) to (c); rows
* top to bottom; CO2 then energy. No 95% interval: the parts are bookkeeping on
* all firms of the file, not estimates. Not a coefficient chart: no regression table.
use `pts', clear
quietly count
local npts = r(N)
assert `npts' == 3 * 6 * 2                        // 3 periods x 6 rows x 2 measures
local rlab1 "Staying firms: plain average (within)"
local rlab2 "Reallocation among staying firms"
local rlab3 "Firms appearing (entry)"
local rlab4 "Firms disappearing (exit)"
local rlab5 "Total change"
local rlab6 "Staying firms together (sum)"
gen str44 c_panel = ""
forvalues k = 1/3 {
    * panel title without the "(n years)" tail, so the column stays on one line
    local t = usubstr("`ptl`k''", 1, ustrpos("`ptl`k''", " (", 4) - 1)
    replace c_panel = "`t'" if pno == `k'
}
gen str36 c_row = ""
forvalues q = 1/6 {
    replace c_row = "`rlab`q''" if part == `q'
}
gen str44 c_ser  = cond(ser == 1, "CO2 (tonnes)", "Energy (GJ)")
* one more decimal than the chart label; the part in its own units (per million of value added)
gen str10 c_pct  = strofreal(pct, "%9.1f")
replace c_pct = "0.0" if c_pct == "-0.0"
gen str12 c_u    = strofreal(u, cond(ser == 1, "%12.2f", "%12.1f"))
replace c_u = "0.00" if c_u == "-0.00"
replace c_u = "0.0" if c_u == "-0.0"
gen str30 c_lev  = strofreal(level_from, cond(ser == 1, "%12.2f", "%12.1f")) + " → " + ///
                   strofreal(level_to, cond(ser == 1, "%12.2f", "%12.1f"))
gen str8  c_n    = strofreal(nfirms, "%12.0fc")
gen str60 c_stat = cond(gray, "gray: rotation (fictional links)", "black")
* check against the CSV numbers still in memory: the chart label is this value rounded
assert subinstr(strofreal(round(pct), "%9.0f"), "-", "−", 1) == lab | (lab == "0" & strofreal(round(pct), "%9.0f") == "-0")
sort pno yrow ser
* show the panel and row names only where they change (easier to read)
by pno: replace c_panel = "" if _n > 1
by pno yrow: replace c_row = "" if _n > 1
putpdf clear
putpdf begin, pagesize(letter) landscape font("Times New Roman", 9) margin(left, 0.6in) margin(right, 0.6in) margin(top, 0.45in) margin(bottom, 0.45in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R9-03. Melitz–Polanec split of the change in CO2 and energy per unit of value added, all firms together: every plotted point"), bold font("Times New Roman", 10)
matrix colw = (16, 22, 9, 9, 11, 11, 6, 16)      // column widths, % of the text width
* two blocks so the notes never sit alone on a page: panels (a)-(b), then (c) with the notes;
* the header row is repeated on the second page
local blk1 "pno <= 2"
local blk2 "pno == 3"
forvalues j = 1/2 {
    if `j' == 2 putpdf pagebreak
    quietly count if `blk`j''
    local nrows = r(N) + 1
    putpdf table tb`j' = data(c_panel c_row c_ser c_pct c_u c_lev c_n c_stat) if `blk`j'', varnames width(colw) ///
        border(all, nil) halign(left)
    putpdf table tb`j'(.,.), margin(top, 1pt) margin(bottom, 1pt) font("Times New Roman", 8.5)
    putpdf table tb`j'(1,1) = ("Panel (period)"), bold
    putpdf table tb`j'(1,2) = ("Row"), bold
    putpdf table tb`j'(1,3) = ("Series"), bold
    putpdf table tb`j'(1,4) = ("% of start level"), bold halign(right)
    putpdf table tb`j'(1,5) = ("Part per million VA"), bold halign(right)
    putpdf table tb`j'(1,6) = ("Level, start → end"), bold halign(right)
    putpdf table tb`j'(1,7) = ("Firms"), bold halign(right)
    putpdf table tb`j'(1,8) = ("Status on chart"), bold
    foreach c in 4 5 6 7 {
        putpdf table tb`j'(.,`c'), halign(right)
    }
    putpdf table tb`j'(1,.), border(top, single, black)
    putpdf table tb`j'(1,.), border(bottom, single, black)
    putpdf table tb`j'(`nrows',.), border(bottom, single, black)
}
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
putpdf text (`"`ntext' Part = the part in tonnes of CO2 or GJ per million money units of value added; % of start level = 100 × part / start level (chart labels are this, rounded). Level = all the period's firms together (tonnes or GJ per million of value added). Staying firms together = within + reallocation = change in the staying firms' own weighted level. Firms = staying firms (first three rows), appearing firms, disappearing firms, or all firms of the two years (total). No 95% interval: the parts are bookkeeping on every firm of the file, not estimates."')
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`devnote'")

* Table R9-03b: the groups behind the parts. For each period and measure: staying
* firms in the start and end year, appearing firms (end year), disappearing firms
* (start year): number, share of value added S, plain average of firm ratios,
* value-added-weighted level I, and the covariance term I - plain average.
use `results', clear
keep if kind == "main" & sample == "main" & inlist(measure, "co2_va", "gj_va")
gen int pno = .
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local a : word 1 of `p'
    replace pno = `k' if from == `a'
}
gen byte ser = cond(measure == "co2_va", 1, 2)
expand 4
bysort pno ser: gen byte g = _n           // 1 stayers start, 2 stayers end, 3 appearing, 4 disappearing
gen str20 t_per = ""
forvalues k = 1/3 {
    local l : word `k' of `plet'
    quietly summarize from if pno == `k', meanonly
    local a = r(min)
    quietly summarize to if pno == `k', meanonly
    replace t_per = "(`l') `a'–`=r(min)'" if pno == `k'
}
gen str12 t_ser = cond(ser == 1, "CO2 (tonnes)", "Energy (GJ)")
gen str36 t_grp = cond(g <= 2, "Staying firms", cond(g == 3, "Appearing firms", "Disappearing firms"))
gen int t_yr = cond(inlist(g, 1, 4), from, to)
gen long t_n = cond(g <= 2, n_stayers, cond(g == 3, n_entrants, n_leavers))
gen double t_S = cond(g == 1, S_stay_from, cond(g == 2, S_stay_to, cond(g == 3, S_enter_to, S_exit_from)))
gen double t_m = cond(g == 1, mean_stay_from, cond(g == 2, mean_stay_to, .))
gen double t_I = cond(g == 1, I_stay_from, cond(g == 2, I_stay_to, cond(g == 3, I_enter_to, I_exit_from)))
gen double t_c = cond(g == 1, cov_stay_from, cond(g == 2, cov_stay_to, .))
gen double t_L = cond(inlist(g, 1, 4), level_from, level_to)
local dec1 "%12.2f"
local dec2 "%12.1f"
gen str20 c_per = t_per
gen str12 c_ser = t_ser
gen str20 c_grp = t_grp
gen str4  c_yr  = string(t_yr)
gen str8  c_n   = strofreal(t_n, "%12.0fc")
gen str8  c_S   = strofreal(100 * t_S, "%9.1f")
gen str12 c_m   = cond(ser == 1, strofreal(t_m, "`dec1'"), strofreal(t_m, "`dec2'")) if !missing(t_m)
gen str12 c_I   = cond(ser == 1, strofreal(t_I, "`dec1'"), strofreal(t_I, "`dec2'"))
gen str12 c_c   = cond(ser == 1, strofreal(t_c, "`dec1'"), strofreal(t_c, "`dec2'")) if !missing(t_c)
gen str12 c_L   = cond(ser == 1, strofreal(t_L, "`dec1'"), strofreal(t_L, "`dec2'"))
foreach v in c_m c_I c_c c_L {
    replace `v' = "0.00" if `v' == "-0.00"
    replace `v' = "0.0" if `v' == "-0.0"
}
replace c_m = "–" if missing(t_m)
replace c_c = "–" if missing(t_c)
sort pno ser g
by pno: replace c_per = "" if _n > 1
by pno ser: replace c_ser = "" if _n > 1
local nrows2 = _N + 1
putpdf sectionbreak, pagesize(letter) landscape margin(all, 0.45in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table R9-03b. The firm groups behind the parts: number, share of value added, plain average, weighted level and covariance term"), bold font("Times New Roman", 10)
matrix colw2 = (11, 11, 14, 5, 7, 9, 11, 11, 12, 9)
putpdf table tc = data(c_per c_ser c_grp c_yr c_n c_S c_m c_I c_c c_L), varnames width(colw2) border(all, nil) halign(left)
putpdf table tc(.,.), margin(top, 0.5pt) margin(bottom, 0.5pt) font("Times New Roman", 9)
putpdf table tc(1,1) = ("Period"), bold font("Times New Roman", 9)
putpdf table tc(1,2) = ("Series"), bold font("Times New Roman", 9)
putpdf table tc(1,3) = ("Group"), bold font("Times New Roman", 9)
putpdf table tc(1,4) = ("Year"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,5) = ("Firms"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,6) = ("% of value added"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,7) = ("Plain average of firms"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,8) = ("Weighted level of group"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,9) = ("Covariance term (level − average)"), bold halign(right) font("Times New Roman", 9)
putpdf table tc(1,10) = ("All firms, level"), bold halign(right) font("Times New Roman", 9)
forvalues c = 4/10 {
    putpdf table tc(.,`c'), halign(right)
}
putpdf table tc(1,.), border(top, single, black)
putpdf table tc(1,.), border(bottom, single, black)
putpdf table tc(`nrows2',.), border(bottom, single, black)
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
putpdf text ("Notes: Per million money units of value added (tonnes of CO2 or GJ of energy). How the parts of the figure come from this table: within (staying firms' plain average) = plain average end year minus start year; reallocation = covariance term end year minus start year (covariance term = weighted level minus plain average, i.e. the number of firms times the covariance of value-added shares and firm ratios); appearing firms = their share × (their level − staying firms' level, end year); disappearing firms = their share × (staying firms' level − their level, start year). All-firms levels are for each period's own firms, so they differ slightly from Figure R9-01's yearly line. CSV: as filed, CO2 per unit of output, scope 1 and 2, whole span, neighbouring years.")
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
