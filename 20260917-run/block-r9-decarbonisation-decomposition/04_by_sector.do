/*==========================================================================
  R9-04  Each sector's part in the change: each period's change in
         CO2 per unit of value added (all firms taken together) is split
         firm by firm with the FHK method (as in R9-02) and the firms' parts
         are added up by 2-digit sector: staying firms getting cleaner
         (within), value added shifting among staying firms (reallocation =
         between + cross), firms appearing and disappearing (entry + exit).
         A second split treats sectors as the units: changes inside sectors
         versus value added moving between sectors (sector mix).
  Answers Bu Deasy R9: "Who decarbonised Indonesian manufacturing: firms
         becoming cleaner or production reallocating toward cleaner firms?"
         "Accounting decomposition, bukan causal regression. FHK
         decomposition ... Within + reallocation + entry + exit."
  Output : figures/04_by_sector.png (+ .pdf)
           tables/04_by_sector.csv              (every period x measure x
                  version x sector: firms' parts added up by sector, the
                  sector-level split, counts, shares, levels)
           tables/04_by_sector_table.pdf        (every plotted point)
           tables/04_by_sector_periods.pdf      (every period and sector, CO2)
           tables/04_by_sector_two_level.pdf    (inside sectors vs between
                  sectors, every period, CO2 and energy, main version;
                  as filed in the CSV)
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
local fname "04_by_sector"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R9-04] STARTING: FHK parts of the change in CO2 per unit of value added, by sector ==="

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
* value_added_nominal  = value added, current prices (masked money unit)
* gross_output_nominal = output value (needed by the shared block; not used for the sectors)
* industry2_reported   = 2-digit sector (text); used by the extreme-record rule and for the sectors
use firm_id year value_added_nominal gross_output_nominal total_gj_s1 co2_total_s1 ///
    industry2_reported identity_real_link_verified using "$DATA", clear
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
display "Step 2/7: 2-digit sectors as number codes"
*---------------------------------------------------------------------------
* industry2_reported is text ("10" ... "33"). A missing or non-numeric code
* becomes 99 "Not recorded" (the extreme-record rule above already uses the
* whole-year median for such records).
gen int sec = real(industry2_reported)
replace sec = 99 if missing(sec) | sec < 10 | sec > 33
quietly count if sec == 99
display "   firm-years with no usable sector code: " r(N)
* firms reported in more than one sector over the years (counted per period below)
bysort firm_id (sec): gen byte r9n_multi = sec[1] != sec[_N]
quietly count if r9n_multi
local nmulti_fy = r(N)
display "   firm-years of firms reported in more than one sector: `nmulti_fy'"
drop r9n_multi

*---------------------------------------------------------------------------
display "Step 3/7: split every period (FHK), add the firms' parts up by sector; sector-level split"
*---------------------------------------------------------------------------
* Periods: the three of R9-02, the whole span, and every pair of neighbouring
* files (2015->2017 spans the missing 2016 file). Measures (per million of value
* added, value-added weights): co2_va (drawn) and gj_va (tables).
* (A) Firm by firm: r9_fhk gives each firm its five parts (saving()). A firm's
*     parts are all measured against the all-firms start level, so the parts of
*     the firms in a sector add up to that sector's part in the all-firms change,
*     and the sectors add up to the R9-02 total exactly. A staying or leaving firm
*     counts in its start-year sector, an entrant in its end-year sector.
* (B) Sectors as the units: the same program on sector totals (sum of CO2, sum of
*     value added per sector and year) splits the all-firms change into
*       inside sectors  = sum_j S_j,start * (I_j,end - I_j,start)   sectors' own level changes
*       between sectors = sum_j (I_j,start - I_start) * (S_j,end - S_j,start)
*       cross           = sum_j (I_j,end - I_j,start) * (S_j,end - S_j,start)
*     (+ sectors appearing or disappearing, if any), S_j = sector's value-added
*     share, I_j = sector's own CO2 per value added. Sector mix = between + cross.
*     Here each firm-year counts in the sector it reported that year.
*     If no firm changes sector, (A) and (B) give the same total for every sector.
tempfile firmyears
save `firmyears'
local mlist "co2_va gj_va"
local num_co2_va "co2_total_s1"
local num_gj_va  "total_gj_s1"
local fewn 10                       // "few firms": fewer than this in the sector in either year
tempfile acc psample firmsec seccount fparts sparts piece
local nacc 0
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
        foreach r in n_stayers n_entrants n_leavers {
            local `r' = r(`r')
        }
        quietly save `psample', replace
        quietly {
            * each firm's sector: first row = start year (stayers, leavers) or end year (entrants)
            bysort firm_id (year): gen byte r9n_switch = _N == 2 & sec[1] != sec[_N]
            by firm_id: keep if _n == 1
            keep firm_id sec r9n_switch
            save `firmsec', replace
            * firms per sector in the start and in the end year of the period sample
            use `psample', clear
            gen byte r9n_fa = year == `a'
            gen byte r9n_fb = year == `b'
            collapse (sum) n_firms_start = r9n_fa n_firms_end = r9n_fb, by(sec)
            save `seccount', replace
        }
        foreach m of local mlist {
            * (A) firm by firm, then added up by sector
            use `psample', clear
            quietly r9_fhk `num_`m'' value_added_nominal, firm(firm_id) year(year) from(`a') to(`b') ///
                saving(`fparts')
            assert r(gap_rel) < 1e-9
            assert r(n_stay) == `n_stayers' & r(n_enter) == `n_entrants' & r(n_exit) == `n_leavers'
            foreach r in I_from I_to change within between cross entry exit {
                local ag_`r' = r(`r')
            }
            local tol = 1e-9 * abs(`ag_I_from')
            * (B) sectors as the units
            use `psample', clear
            quietly collapse (sum) r9n_num = `num_`m'' r9n_den = value_added_nominal, by(sec year)
            quietly r9_fhk r9n_num r9n_den, firm(sec) year(year) from(`a') to(`b') saving(`sparts')
            assert abs(r(change) - `ag_change') < `tol'          // same all-firms change
            assert abs(r(I_from) - `ag_I_from') < `tol'
            foreach r in within between cross entry exit {
                local tl_`r' = r(`r')
            }
            * add the firms' parts up by sector
            use `fparts', clear
            quietly merge 1:1 firm_id using `firmsec', assert(3) nogen
            gen byte r9n_c = status == "C"
            gen byte r9n_n = status == "N"
            gen byte r9n_x = status == "X"
            gen byte r9n_sw = r9n_switch & status == "C"
            quietly collapse (sum) within = fhk_within between = fhk_between cross = fhk_cross ///
                entry = fhk_entry exit = fhk_exit n_stayers = r9n_c n_entrants = r9n_n ///
                n_leavers = r9n_x n_switchers = r9n_sw, by(sec)
            quietly merge 1:1 sec using `seccount', nogen
            * the sector-level split, one row per sector
            preserve
            use `sparts', clear
            rename (s0 s1 a0 a1 fhk_within fhk_between fhk_cross fhk_entry fhk_exit) ///
                (va_share_start va_share_end sector_level_start sector_level_end ///
                 inside_sector between_sector cross_sector sector_enter sector_exit)
            keep sec va_share_start va_share_end sector_level_start sector_level_end ///
                inside_sector between_sector cross_sector sector_enter sector_exit
            save `piece', replace
            restore
            quietly merge 1:1 sec using `piece', nogen
            foreach v of varlist within between cross entry exit n_* inside_sector between_sector ///
                cross_sector sector_enter sector_exit {
                quietly replace `v' = 0 if missing(`v')
            }
            * checks: sectors add up to the all-firms parts; (A) and (B) agree per sector
            foreach r in within between cross entry exit {
                quietly summarize `r', meanonly
                assert abs(r(sum) - `ag_`r'') < `tol'
            }
            quietly summarize n_switchers, meanonly
            local nsw = r(sum)
            if `nsw' == 0 {
                assert abs((within + between + cross + entry + exit) ///
                    - (inside_sector + between_sector + cross_sector + sector_enter + sector_exit)) < `tol'
            }
            * the all-sectors row (sector 0) = the R9-02 split and the sector-level totals
            local n0 = _N + 1
            quietly set obs `n0'
            quietly replace sec = 0 in `n0'
            foreach r in within between cross entry exit {
                quietly replace `r' = `ag_`r'' in `n0'
            }
            foreach v in n_stayers n_entrants n_leavers n_switchers n_firms_start n_firms_end {
                quietly summarize `v', meanonly
                quietly replace `v' = r(sum) in `n0'
            }
            quietly replace va_share_start = 1 in `n0'
            quietly replace va_share_end = 1 in `n0'
            quietly replace sector_level_start = `ag_I_from' in `n0'
            quietly replace sector_level_end = `ag_I_to' in `n0'
            quietly replace inside_sector  = `tl_within' in `n0'
            quietly replace between_sector = `tl_between' in `n0'
            quietly replace cross_sector   = `tl_cross' in `n0'
            quietly replace sector_enter   = `tl_entry' in `n0'
            quietly replace sector_exit    = `tl_exit' in `n0'
            gen int ord = `k'
            gen str9 interval = "`a'-`b'"
            gen str10 kind = "`kind'"
            gen str14 period = "`pname'"
            gen int start_year = `a'
            gen int end_year = `b'
            gen int years_between = `b' - `a'
            gen str80 data_warning = "`warn'"
            gen str8 measure = "`m'"
            gen str8 sample = cond("`smp'" == "main", "main", "as filed")
            gen double level_start = `ag_I_from'
            gen double level_end = `ag_I_to'
            gen double change_all = `ag_change'
            if `nacc' > 0 append using `acc'
            quietly save `acc', replace
            local ++nacc
        }
    }
    display "   `a'->`b' (`kind', main version): stayers `n_stayers', entrants `n_entrants', leavers `n_leavers'  `warn'"
}

*---------------------------------------------------------------------------
display "Step 4/7: results table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `acc', clear
* "Reallocation" in Bu Deasy's words = between + cross (value added moving among staying firms)
gen double realloc = between + cross
gen double entex   = entry + exit                 // firms appearing plus firms disappearing (net)
gen double total   = within + between + cross + entry + exit
gen double sector_mix = between_sector + cross_sector
* every part as % of the period's all-firms start level (the level of the period sample)
foreach v in within between cross realloc entry exit entex total inside_sector between_sector ///
    cross_sector sector_mix sector_enter sector_exit {
    gen double pct_`v' = 100 * `v' / level_start
}
* sector short names, same as R3-03 (who reduces, by sector)
label define secname 10 "Food products" 11 "Beverages" 12 "Tobacco" 13 "Textiles" 14 "Clothing" ///
    15 "Leather and footwear" 16 "Wood products" 17 "Paper" 18 "Printing" 19 "Refined petroleum, coke" ///
    20 "Chemicals" 21 "Medicines" 22 "Rubber and plastics" 23 "Cement, glass, ceramics" ///
    24 "Steel and other metals" 25 "Metal products" 26 "Computers, electronics" 27 "Electrical equipment" ///
    28 "Machinery" 29 "Motor vehicles" 30 "Motorcycles, other vehicles" 31 "Furniture" 32 "Other manufacturing" ///
    33 "Machine repair" 99 "Not recorded"
gen int sector_code = sec
label values sec secname
decode sec, gen(sector_name)
replace sector_name = "All sectors" if sec == 0
replace sector_name = "Code " + string(sec) if sector_name == ""
label values sec
gen str40 row_label = sector_name + cond(inrange(sec, 1, 98), " (" + string(sec) + ")", "")
gen byte few_firms = sec > 0 & min(n_firms_start, n_firms_end) < `fewn'
gen str40 measure_label = cond(measure == "co2_va", "CO2 per unit of value added", "Energy (GJ) per unit of value added")
* the chart: CO2 per value added, main version, the three periods of R9-02 (same
* panel letters as Figures R9-02 and R9-03); one panel each
local drawk "1 2 3"
gen byte drawn = sample == "main" & measure == "co2_va" & kind == "main" & inlist(ord, `: subinstr local drawk " " ",", all')
* chart order: sectors in code order, the same rows in every panel (not sorted by
* size: the chart must not read as a ranking of sectors); all sectors last
egen int chart_row = group(sec) if drawn & sec > 0
quietly summarize chart_row
replace chart_row = r(max) + 1 if drawn & sec == 0
gen str80 note = "Development data: firm links fictional; entry and exit = sample rotation"
if !`fict_links' replace note = ""
gen byte mo = cond(measure == "co2_va", 1, 2)
gen byte so = cond(sample == "main", 1, 2)
gen byte allrow = sec == 0
sort ord mo so allrow sec
order ord interval kind period start_year end_year years_between data_warning measure measure_label sample ///
      sector_code sector_name row_label drawn chart_row few_firms n_firms_start n_firms_end n_stayers ///
      n_entrants n_leavers n_switchers va_share_start va_share_end level_start level_end change_all ///
      sector_level_start sector_level_end within between cross realloc entry exit entex total ///
      inside_sector between_sector cross_sector sector_mix sector_enter sector_exit pct_* note
drop sec mo so allrow
format va_share_* %9.4f
format level_* change_all sector_level_* within between cross realloc entry exit entex total ///
    inside_sector between_sector cross_sector sector_mix sector_enter sector_exit %14.6f
format pct_* %9.3f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile results
save `results'
list interval sector_code chart_row pct_within pct_realloc pct_entex pct_total n_firms_start n_firms_end ///
    if drawn, noobs sep(0) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 5/7: notes (numbers, sectors and years read from the data, never typed)"
*---------------------------------------------------------------------------
* signed whole number with a typographic minus, e.g. "−30" or "+31"
capture program drop _r9s
program define _r9s, rclass
    args x
    local r = round(`x')
    return local s = cond(`r' > 0, "+", cond(`r' < 0, "−", "")) + strofreal(abs(`r'))
end
* panel letters of the drawn periods (same letters as Figures R9-02 and R9-03)
local j 0
foreach kk of local drawk {
    local ++j
    local L`kk' = char(96 + `j')
}
* (1) staying firms' own change vs reallocation, in the sector with the largest own change
gen double r9n_aw = abs(pct_within) if drawn & sector_code > 0
gsort -r9n_aw
local w1 = pct_within[1]
local r1 = pct_realloc[1]
local s1 = sector_name[1]
local o1 = ord[1]
drop r9n_aw
_r9s `w1'
local w1s "`r(s)'"
_r9s `r1'
local r1s "`r(s)'"
* (why they cancel is explained under Figure R9-02: staying firms whose value added falls)
if abs(`w1' + `r1') < abs(`w1') / 3 local opp "In a few sectors within and reallocation are large but mostly cancel (largest: `s1', (`L`o1''): `w1s'% and `r1s'%; why: Figure R9-02)."
else local opp "Within and reallocation can pull in opposite directions (largest within: `s1', (`L`o1''): `w1s'%, reallocation `r1s'%)."
* (2) sector bars in which firms appearing and disappearing weigh more than the staying firms
quietly count if drawn & sector_code > 0 & abs(pct_entex) > abs(pct_within + pct_realloc)
local nE = r(N)
quietly count if drawn & sector_code > 0
local nC = r(N)
local fic "Firms appearing and disappearing = firms seen in one of the two years only."
if `fict_links' local fic "Firms appearing and disappearing (gray) = firms seen in one of the two years only (on fictional links: the sample changing)."
* the line under the title: this chart is not a ranking of sectors
local warn1 "Bookkeeping, not a ranking: each row shows where a sector's firms fall in the all-firms change, not why the change happened."
if `fict_links' local warn1 "Not a ranking of sectors. Firm links in this development file are fictional, and in `nE' of `nC' sector bars firms appearing and disappearing (gray) weigh more than the staying firms, so the sector totals mean nothing here."
* (3) sectors as the units (Table R9-04c): inside sectors / between sectors, per panel
local mix ""
foreach kk of local drawk {
    quietly summarize pct_inside_sector if drawn & ord == `kk' & sector_code == 0, meanonly
    _r9s `r(mean)'
    local mi "`r(s)'"
    quietly summarize pct_sector_mix if drawn & ord == `kk' & sector_code == 0, meanonly
    _r9s `r(mean)'
    local mix = cond("`mix'" == "", "", "`mix', ") + "(`L`kk'') `mi'% / `r(s)'%"
}
local mix "Sectors as units (Table R9-04c, no firm links needed): inside sectors / value added moving between sectors `mix'."
* (4) few firms (marked next to the total, since the rows are shared by the panels)
quietly count if drawn & few_firms
local few ""
if r(N) > 0 local few "† = fewer than `fewn' firms in the sector in one of the two years."
* (5) period warnings of the drawn periods
local pw ""
foreach kk of local drawk {
    local p : word `kk' of $R9_INTERVALS
    local a : word 1 of `p'
    local b : word 2 of `p'
    r9_interval_note `a' `b'
    if "`r(note)'" != "" local pw = cond("`pw'" == "", "", "`pw'; ") + "(`L`kk'') `r(note)'"
}
if "`pw'" != "" local pw "Records: `pw'."
local ntext "Notes: Bookkeeping, not cause: each period's change in CO2 per unit of value added, all firms together (Figure R9-02), split firm by firm and added up by 2-digit sector (staying and disappearing firms: start-year sector; appearing firms: end-year sector), % of the start level; minus = lowers the level (cleaner). Each panel's sector rows add up exactly to its last row. Within = staying firms' own change; reallocation = value added moving among staying firms (between + cross). `opp' `fic' `mix' `few' Levels as in Figure R9-02. Firm-years over $R9_RULE× their sector's median energy per unit of value added are set aside (other cut-offs: R9-07). `pw' Value added (output minus materials, energy and services bought) is in current prices, so price rises alone lower ratios. Energy: tables."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 148 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
local nlines : word count `notelines'
display "   notes: `nlines' lines"
if `nlines' > 9 display as error "   WARNING: the notes run to `nlines' lines (limit 9)"
* the warning line under the title, wrapped the same way
local warnlines ""
local line ""
foreach w of local warn1 {
    if ustrlen("`line' `w'") > 130 & "`line'" != "" {
        local warnlines `"`warnlines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local warnlines `"`warnlines' "`line'""'

*---------------------------------------------------------------------------
display "Step 6/7: draw: one panel per period, one row per sector (bar = total, marks = parts)"
*---------------------------------------------------------------------------
keep if drawn
local ndr : word count `drawk'
quietly count if sector_code == 0
assert r(N) == `ndr'
* panels (a), (b), (c) in the order of R9_INTERVALS
gen byte panel = .
local j 0
foreach kk of local drawk {
    local ++j
    replace panel = `j' if ord == `kk'
    local p : word `kk' of $R9_INTERVALS
    local a : word 1 of `p'
    local b : word 2 of `p'
    local pn : word `kk' of $R9_PERIODS
    label define panel `j' "(`=char(96 + `j')') `a'–`=substr("`b'", 3, 2)', `pn' (`=`b' - `a'' years)", add
}
label values panel panel
* rows top to bottom: sectors in code order, then a gap, then all sectors
quietly summarize chart_row if sector_code > 0
local nsec = r(max)
gen double y = cond(sector_code > 0, chart_row, `nsec' + 1.8)
* sector names as y-axis labels (printed once, left of the first panel)
local ylab ""
quietly levelsof chart_row if sector_code > 0, local(rows)
foreach r of local rows {
    quietly levelsof row_label if chart_row == `r' & sector_code > 0, local(nm) clean
    local ylab `"`ylab' `r' "`nm'""'
}
local ylab `"`ylab' `=`nsec' + 1.8' "{bf:All sectors (Figure R9-02)}""'
* shared x axis: symmetric around 0, about two labels each side (as R9-02)
egen double r9n_m = rowmax(pct_within pct_realloc pct_entex pct_total)
egen double r9n_n = rowmin(pct_within pct_realloc pct_entex pct_total)
quietly summarize r9n_m
local M = r(max)
quietly summarize r9n_n
local M = max(`M', abs(r(min)))
drop r9n_m r9n_n
local mag = 10^floor(log10(`M'))
local half = `mag' * ceil(1.15 * `M' / `mag')
local step = `mag'
foreach f in 2 2.5 5 10 {
    if `half' / `step' > 2.5 local step = `f' * `mag'
}
local xl = `step' * floor(`half' / `step')
display "   x axis: -`half' to `half', labels every `step' (largest part `M')"
local xlabs ""
forvalues v = -`xl'(`step')`xl' {
    local xlabs `"`xlabs' `v' "`=cond(`v' < 0, "−", "")'`=abs(`v')'""'
}
* room on the right of each panel for the totals column
local xtot  = `half' * 1.06
local xmax  = `half' * 1.55
gen double xtot  = `xtot'
gen str24 tlab = strofreal(round(pct_total), "%9.0f")
replace tlab = "0" if tlab == "-0"
replace tlab = subinstr(tlab, "-", "−", 1)       // typographic minus, as in the notes
replace tlab = tlab + " †" if few_firms
replace tlab = "{bf:" + tlab + "}" if sector_code == 0
gen double zero = 0
gen double gl = -`half'
gen double gr = `half'
* zero line and column head: one extra row per panel
local n0 = _N
set obs `=`n0' + `ndr''
gen double zy0 = .
gen double zy1 = .
gen double zx  = .
gen double hy  = .
gen str10 hlab = ""
forvalues j = 1/`ndr' {
    local r = `n0' + `j'
    replace panel = `j' in `r'
    replace zy0 = 0.3 in `r'
    replace zy1 = `nsec' + 2.5 in `r'
    replace zx  = 0 in `r'
    replace hy  = -0.4 in `r'
    replace xtot = `xtot' in `r'
    replace hlab = "Total, %" in `r'
}
local gray = cond(`fict_links', "gs8", "black")
local graykey "Firms appearing or disappearing (entry + exit)"
if `fict_links' local graykey "Gray = firms appearing or disappearing (entry + exit; fictional links: no meaning here)"
* text sizes: the graph is 10 in high (26 rows), so the named sizes would print larger than in
* R9-02 (7 in high); these numbers keep R9-02's printed sizes (vsmall 2.08 x 7/10, small 2.78 x 7/10)
local tv "1.46"
local ts "1.95"
local ms "0.73"                    // marker size: R9-02's "small" (1.04 x 7/10)
twoway (rbar zero pct_total y, horizontal barwidth(0.66) fcolor(gs14) lcolor(gs11) lwidth(vthin)) ///
    (pcspike y gl y gr, lcolor(gs15) lwidth(vthin)) ///
    (pcspike zy0 zx zy1 zx, lcolor(gs8) lwidth(thin)) ///
    (scatter y pct_within, msymbol(O) mcolor(black) msize(`ms')) ///
    (scatter y pct_realloc, msymbol(Dh) mcolor(black) msize(`ms') mlwidth(medthin)) ///
    (scatter y pct_entex, msymbol(Sh) mcolor(`gray') msize(`ms') mlwidth(medthin)) ///
    (scatter y xtot, msymbol(none) mlabel(tlab) mlabposition(3) mlabgap(0.5) mlabsize(`tv') mlabcolor(black)) ///
    (scatter hy xtot, msymbol(none) mlabel(hlab) mlabposition(3) mlabgap(0.5) mlabsize(`tv') mlabcolor(gs4)), ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R9-04. Each period's change in CO2 per unit of value added, added up by sector: staying firms'" ///
              "own change, value added shifting among them, and firms appearing or disappearing", ///
              size(`ts') pos(11) span) ///
        subtitle(`warnlines', size(`tv') pos(11) span color(black)) ///
        note(`notelines' "`srcnote'" "`devnote'", size(`tv') span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(`ts')) ///
    yscale(reverse noline range(-1 `=`nsec' + 2.5')) ///
    ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(`tv')) ytitle("") ///
    xscale(range(-`half' `xmax') noline) ///
    xlabel(`xlabs', noticks tlength(0) labsize(`tv') nogrid) ///
    xtitle("Part of the change, % of the period's start level (minus = lowers the level: cleaner)", size(`tv')) ///
    legend(order(1 "Sector's total (the parts added up)" 4 "Staying firms' own change (within)" ///
                 6 "`graykey'" 5 "Reallocation (between + cross)" ///
                 - " " 3 "0 = no part in the change") ///
        cols(2) region(lcolor(none)) size(`tv') symxsize(4) symysize(1.6) keygap(1) colgap(6) rowgap(0.3)) ///
    plotregion(style(none)) xsize(10) ysize(10)

graph export "figures/`fname'.png", width(3000) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion tables: every plotted point, every period by sector, sectors as units (putpdf)"
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

* Table R9-04: one row per plotted point, in chart order: panel, sector rows top
* to bottom, then the marks in legend order (total bar, within, reallocation,
* entry + exit). Built from the results saved at Step 4 (chart and CSV unchanged).
use `results', clear
keep if drawn
gen byte panel = .
gen str120 c_panel = ""
local j 0
foreach kk of local drawk {
    local ++j
    local p : word `kk' of $R9_INTERVALS
    local a : word 1 of `p'
    local b : word 2 of `p'
    local pn : word `kk' of $R9_PERIODS
    replace panel = `j' if ord == `kk'
    replace c_panel = "(`=char(96 + `j')') `a'–`=substr("`b'", 3, 2)', `pn' (`=`b' - `a'' years)" if ord == `kk'
}
expand 4
bysort panel chart_row: gen byte mark = _n
local mlabs `""Sector's total (bar)" "Within (dot)" "Reallocation (diamond)" "Entry + exit (square)""'
local mvars "total within realloc entex"
gen double pct = .
gen double lvl = .
gen str60 c_mark = ""
forvalues q = 1/4 {
    local v : word `q' of `mvars'
    local l : word `q' of `mlabs'
    replace pct = pct_`v' if mark == `q'
    replace lvl = `v' if mark == `q'
    replace c_mark = "`l'" if mark == `q'
}
gen str44 c_row = row_label + cond(few_firms, " †", "")
replace c_row = "All sectors (Figure R9-02)" if sector_code == 0
* same rounding as the chart label (whole %; only the total is labelled), then one more decimal
gen str8 c_shown = cond(mark == 1, strofreal(round(pct), "%9.0f"), "")
replace c_shown = "0" if c_shown == "-0"
gen str10 c_pct = strofreal(pct, "%9.1f")
replace c_pct = "0.0" if c_pct == "-0.0"
gen str12 c_lvl = strofreal(lvl, "%12.2f")
replace c_lvl = "0.00" if c_lvl == "-0.00"
* firms behind the point: all three groups (total), staying firms (within, reallocation),
* firms appearing plus firms disappearing (entry + exit)
gen long nf = cond(mark == 1, n_stayers + n_entrants + n_leavers, cond(mark <= 3, n_stayers, n_entrants + n_leavers))
gen str8 c_firms = strofreal(nf, "%12.0fc")
gen str90 c_status = cond(`fict_links' & mark == 4, "gray: fictional firm links", "drawn")
replace c_status = "drawn at 0: no staying firms in the sector" if inlist(mark, 2, 3) & n_stayers == 0
replace c_status = c_status + "; † < `fewn' firms in a year" if few_firms
* the period's record warning goes with the panel name (shown once per page)
replace c_panel = c_panel + "; " + data_warning if data_warning != ""
* check: every plotted point once (panels x (sectors + all sectors) x 4 marks)
quietly count
local npts = r(N)
quietly count if sector_code > 0 & mark == 1
assert `npts' == 4 * (r(N) + `ndr')
sort panel chart_row mark
* thin rule under each sector (its four marks); a page ends at a rule
gen long rn = _n
quietly levelsof rn if mark == 4 & _n < _N, local(rl)
local tabnote "`warn1' `ntext' Shown = the label on the chart (whole %; only the total is labelled). % of start = the part as % of the period's all-firms start level. Per million of VA = the part in tonnes of CO2 per million money units of value added. Firms = firms behind the point: all firms of the sector (total), its staying firms (within, reallocation), its appearing plus disappearing firms (entry + exit). Not a regression: no coefficients or standard errors."
order c_panel c_row c_mark c_shown c_pct c_lvl c_firms c_status
ctable_pdf c_panel c_row c_mark c_shown c_pct c_lvl c_firms c_status using "tables/`fname'_table.pdf", ///
    title("Table R9-04. Each period's change in CO2 per unit of value added, added up by sector: every plotted point") ///
    header("Panel (period)" "Sector (row on the chart)" "Mark (legend)" "Shown|(%)" "% of|start" "Per million|of VA" "Firms" "Status on chart") ///
    right(4 5 6 7) norepeat(1 2) rules(`rl') perpage(34) fontsize(8) landscape ///
    notes("`tabnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`npts' plotted points)"

* Table R9-04b: every period of R9-02 and the whole span, every sector, CO2 per
* value added, main version: the firms' parts added up by sector.
use `results', clear
keep if inlist(kind, "main", "whole span") & sample == "main" & measure == "co2_va"
gen byte allrow = sector_code == 0
sort ord allrow sector_code
gen str34 t_per = string(start_year) + " to " + string(end_year)
replace t_per = t_per + " (" + period + ")" if period != ""
gen str40 t_sec = row_label
local tv "t_per t_sec"
foreach v in within between cross realloc entry exit total {
    gen str8 t_`v' = strofreal(pct_`v', "%9.1f")
    replace t_`v' = "0.0" if t_`v' == "-0.0"
    local tv "`tv' t_`v'"
}
gen str8 t_sh = strofreal(100 * va_share_start, "%9.1f")
gen str8 t_nc = strofreal(n_stayers, "%12.0fc")
gen str8 t_nn = strofreal(n_entrants, "%12.0fc")
gen str8 t_nx = strofreal(n_leavers, "%12.0fc")
local tv "`tv' t_sh t_nc t_nn t_nx"
gen long rn = _n
quietly levelsof rn if ord != ord[_n + 1] & _n < _N, local(rl)
order `tv'
ctable_pdf `tv' using "tables/`fname'_periods.pdf", ///
    title("Table R9-04b. Each sector's part in the change in CO2 per unit of value added, every period (% of the period's all-firms start level)") ///
    header("Period" "Sector" "Within" "Between" "Cross" "Between|+ cross" "Entry" "Exit" "Total" "VA share|start, %" "Staying" "Entering" "Leaving") ///
    right(3 4 5 6 7 8 9 10 11 12 13) norepeat(1) rules(`rl') perpage(44) fontsize(8) landscape ///
    notes("Notes: Main version (firm-years over $R9_RULE× their sector's median energy per unit of value added set aside; a firm set aside in one year is set aside in both). Each firm's FHK parts (R9-02) are measured against the all-firms start level and added up by sector: a staying or leaving firm in its start-year sector, an entering firm in its end-year sector. The sector rows add up to the all-sectors row (= R9-02). Total = within + between + cross + entry + exit. VA share = the sector's share of all firms' value added in the start year. Energy per unit of value added, the as-filed version and every pair of neighbouring years: CSV. Entry and exit on this file are sample rotation of fictional firm links." ///
          "`srcnote'" "`devnote'")
display "table -> tables/`fname'_periods.pdf"

* Table R9-04c: sectors as the units. The all-firms change split into changes
* inside sectors and value added moving between sectors, next to the firm split
* of Figure R9-02. Main version only (the as-filed version is in the CSV).
use `results', clear
keep if inlist(kind, "main", "whole span") & sector_code == 0 & sample == "main"
gen byte mo = cond(measure == "co2_va", 1, 2)
sort ord mo
gen str34 t_per = string(start_year) + " to " + string(end_year)
replace t_per = t_per + " (" + period + ")" if period != ""
gen str14 t_mea = cond(measure == "co2_va", "CO2 (t)", "Energy (GJ)")
gen str10 t_s = strofreal(level_start, "%12.2f")
gen str10 t_e = strofreal(level_end, "%12.2f")
gen double pct_sector_ee = pct_sector_enter + pct_sector_exit
* sectors appearing or disappearing: a column only if it is ever non-zero
quietly count if abs(pct_sector_ee) > 1e-9
local see = r(N) > 0
local tv "t_per t_mea t_s t_e"
local cols "total inside_sector sector_mix between_sector cross_sector"
if `see' local cols "`cols' sector_ee"
local cols "`cols' within realloc entex"
foreach v of local cols {
    gen str8 t_`v' = strofreal(pct_`v', "%9.1f")
    replace t_`v' = "0.0" if t_`v' == "-0.0"
    local tv "`tv' t_`v'"
}
local hsee ""
if `see' local hsee `""Sectors|appearing or|disappearing""'
* worked example for the notes: the first drawn period after the start, CO2
local p : word 2 of $R9_INTERVALS
local ea : word 1 of `p'
local eb : word 2 of `p'
foreach v in level_start level_end pct_total pct_inside_sector pct_sector_mix {
    quietly summarize `v' if start_year == `ea' & end_year == `eb' & measure == "co2_va", meanonly
    local ex_`v' = r(mean)
}
foreach v in pct_total pct_inside_sector pct_sector_mix {
    local ex_`v' = subinstr(strofreal(`ex_`v'', "%9.1f"), "-", "−", 1)
}
* do inside sectors and sector mix cancel anywhere? (sizes more than 3 times their sum)
gen byte r9n_can = abs(pct_inside_sector) + abs(pct_sector_mix) > 3 * abs(pct_total)
quietly count if r9n_can
local ncan = r(N)
local cannote ""
if `ncan' > 0 {
    gsort -r9n_can mo ord
    local cannote "Where the two sector columns are large with opposite signs (e.g. `=t_per[1]', `=t_mea[1]': `=t_inside_sector[1]' and `=t_sector_mix[1]'), they mostly cancel and neither is a finding."
    sort ord mo
}
gen long rn = _n
quietly levelsof rn if ord != ord[_n + 1] & _n < _N, local(rl)
order `tv'
ctable_pdf `tv' using "tables/`fname'_two_level.pdf", ///
    title("Table R9-04c. Two ways to split the same change: by sectors (inside sectors vs value added moving between sectors) and by firms (Figure R9-02), % of the start level") ///
    header("Period" "Per million|of value|added" "Level at|start" "Level at|end" "Total|change, %" "By sectors:|change inside|sectors" "By sectors:|between sectors|(sector mix)" "of which:|between" "of which:|cross" `hsee' "By firms:|staying firms'|own change" "By firms:|reallocation" "By firms:|appearing +|disappearing") ///
    right(3 4 5 6 7 8 9 10 11 12`=cond(`see', " 13", "")') norepeat(1) rules(`rl') perpage(44) fontsize(8) landscape ///
    notes("How to read: CO2 per million of value added fell from `=strofreal(`ex_level_start', "%9.2f")' to `=strofreal(`ex_level_end', "%9.2f")' tonnes between `ea' and `eb' (`ex_pct_total'% of the start level). Treating each sector as one unit, `ex_pct_inside_sector' points of that came from sectors' own levels changing and `ex_pct_sector_mix' points from value added moving toward sectors with less (−) or more (+) CO2 per unit of value added than all firms together (sector mix). The firm columns split the same total the way Figure R9-02 does; the two splits answer different questions and their columns are not meant to match." ///
          "Notes: Change inside sectors = each sector's change in its own level, weighted by its start-year share of value added; it includes the sector's firms appearing and disappearing. Between = value added moving to sectors above (+) or below (−) the all-firms start level; cross = a sector's level and its share changing together; sector mix = between + cross. The sector split uses only each year's sector totals, not firm links (except for which records are set aside), so fictional firm links barely touch it; the values are still masked. `cannote' Each firm-year counts in the sector it reported that year; `=cond(`nmulti_fy' == 0, "no firm changes sector in this file", "firms that change sector: CSV column n_switchers")'. Main version (extreme records set aside, R9-01); the as-filed version is in the CSV. Levels: tonnes of CO2 or GJ per million money units of value added (current prices)." ///
          "`srcnote'" "`devnote'")
display "table -> tables/`fname'_two_level.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
