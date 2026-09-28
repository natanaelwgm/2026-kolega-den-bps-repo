/*==========================================================================
  R9-07  The FHK split of R9-02 under other choices
         (each period's change in CO2 per unit of value added, all firms
         taken together: staying firms getting cleaner, reallocation among
         them, firms appearing and disappearing) redone under other
         choices: other cut-offs for extreme energy records (or none),
         without importers of unknown export status (their 2019-22 energy
         records are in doubt), without records far below their sector's
         median, with zero-energy firms kept, and per unit of output.
  Answers Bu Deasy R9: "Who decarbonised Indonesian manufacturing: firms
         becoming cleaner or production reallocating toward cleaner firms?"
         "Accounting decomposition, bukan causal regression. FHK
         decomposition ... Within + reallocation + entry + exit."
         (robustness of the split; planning-note check: output-weighted
         and energy versions)
  Output : figures/07_sensitivity_doubtful_records.png (+ .pdf)
           tables/07_sensitivity_doubtful_records.csv   (every version x
                  period x measure: levels, the five parts, counts, value
                  added kept)
           tables/07_sensitivity_doubtful_records_table.pdf    (every
                  plotted point)
           tables/07_sensitivity_doubtful_records_versions.pdf (every
                  version, CO2 and energy, three periods and whole span)
  Uses the shared blocks "R9 UNIVERSE, WEIGHTS AND INTERVALS" (from R9-01)
  and "R9 DECOMPOSITION PROGRAMS" (tested in R9-06), copied unchanged; the
  versions change the block's flags (r9_x, r9_U) after it has run.
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
local fname "07_sensitivity_doubtful_records"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [R9-07] STARTING: does the FHK split change under other choices? ==="

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
* co2_scope1_s1 / co2_scope2_s1 = the CO2 from burning fuels / from bought electricity
* value_added_nominal  = value added, current prices (masked money unit)
* gross_output_nominal = output value, current prices (for the CO2-per-output version)
* industry2_reported   = 2-digit sector (used by the extreme-record rule)
* import_flag, export_flag = imports (0/1) and exports (0/1, missing = no answer):
*   importers with no export answer are the group whose 2019-22 energy records are in doubt
use firm_id year value_added_nominal gross_output_nominal total_gj_s1 co2_total_s1 ///
    co2_scope1_s1 co2_scope2_s1 industry2_reported import_flag export_flag ///
    identity_real_link_verified using "$DATA", clear
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
display "Step 2/7: the versions: what each one changes, and how much it weighs"
*---------------------------------------------------------------------------
* Choices of this file (edit here); every other rule comes from the shared block.
local cuts_table "30"            // cut-offs of R9_RULE_ALT shown in the tables only (not drawn)
local low_rules  "$R9_RULE 5"    // far-low rules: a record under 1/K of its sector-year median.
                                 // 1/$R9_RULE mirrors the main rule (drawn); 1/5 = the row plan's first idea
local low_table  "5"             // far-low rules shown in the tables only (not drawn): see notes
* Versions, in chart order (top to bottom). Each is the main version with ONE thing changed:
*   asfiled     nothing set aside (every firm-year with value added and energy above zero)
*   cutK        extreme-record cut-off K times the sector-year median instead of $R9_RULE
*   main        the main version of R9-02 (cut-off $R9_RULE)
*   noimp       also sets aside importers with no export answer, in every year
*   noimpdoubt  the same, only in the years whose energy records are in doubt ($R9_DOUBT_YRS)
*   lowK        also sets aside records under 1/K of their sector-year median
*   zero        keeps firms with value added but zero recorded energy (and CO2) at ratio 0
*   output      CO2 per unit of output value, weighted by output (not by value added)
* Records set aside by a version are handled like extreme records: a staying firm
* flagged in either year of a period is set aside in BOTH years (r9_interval_sample).
numlist "$R9_RULE $R9_RULE_ALT", sort
local desc ""
foreach k in `r(numlist)' {
    local desc "`k' `desc'"                   // most lenient cut-off first
}
local vlist "asfiled"
foreach k of local desc {
    local vlist = "`vlist' " + cond(`k' == $R9_RULE, "main", "cut`k'")
}
local vlist "`vlist' noimp noimpdoubt"
foreach k of local low_rules {
    local vlist "`vlist' low`k'"
}
local vlist "`vlist' zero output"
* the years in doubt, as text (e.g. 2019–22)
local ndy : word count $R9_DOUBT_YRS
local dy1 : word 1 of $R9_DOUBT_YRS
local dy2 : word `ndy' of $R9_DOUBT_YRS
local dtxt "`dy1'–`=substr("`dy2'", 3, 2)'"
* labels (chart rows), short names (for the notes), drawn or table only, marker type
* (1 = main version, 2 = other cut-off or nothing set aside, 3 = other check)
local lab_asfiled   "Nothing set aside (as filed)"
local short_asfiled "as filed"
local draw_asfiled  1
local mark_asfiled  2
foreach k of local desc {
    local kk = strofreal(`k', "%12.0fc")
    local v = cond(`k' == $R9_RULE, "main", "cut`k'")
    local lab_`v'   "Over `kk'× sector median"
    local short_`v' "`kk'×"
    local draw_`v'  = !`: list k in cuts_table'
    local mark_`v'  2
}
local lab_main  "Over $R9_RULE× (main version)"
local draw_main 1
local mark_main 1
local lab_noimp        "Without importers of unknown export status"
local short_noimp      "without importers of unknown export status"
local lab_noimpdoubt   "Without them only in `dtxt' (records in doubt)"
local short_noimpdoubt "without importers of unknown export status only in `dtxt'"
foreach k of local low_rules {
    local lab_low`k'   "Without records under 1/`k' of sector median"
    local short_low`k' "without records under 1/`k' of the median"
    local draw_low`k'  = !`: list k in low_table'
}
local lab_zero      "Zero-energy firms kept (at 0)"
local short_zero    "zero-energy firms kept"
local lab_output    "CO2 per unit of output (output weights)"
local short_output  "per unit of output"
foreach v in noimp noimpdoubt zero output {
    local draw_`v' 1
}
foreach v of local vlist {
    if "`mark_`v''" == "" local mark_`v' 3
    display "   version `v': `lab_`v''" cond(`draw_`v'', "", "  (tables only)")
}

* The groups the versions set aside or add, and their weight (share of the year's
* value added in the main universe), for the notes and the log.
gen byte imp_unk = import_flag == 1 & missing(export_flag)     // importer, no export answer
gen byte doubt_yr = 0
foreach y of global R9_DOUBT_YRS {
    replace doubt_yr = 1 if year == `y'
}
* zero-energy firm-years: value added above zero, no recorded energy and no CO2
gen byte zero_e = value_added_nominal > 0 & !missing(value_added_nominal) ///
    & total_gj_s1 == 0 & co2_total_s1 == 0
quietly count if zero_e
local n_zero = r(N)
quietly count if value_added_nominal > 0 & total_gj_s1 == 0 & co2_total_s1 > 0 & !missing(co2_total_s1)
display "   zero-energy firm-years kept by version 'zero': `n_zero' (CO2 but no energy, left out: " r(N) ")"
bysort year: egen double w_va = total(cond(r9_M, value_added_nominal, .))
bysort year: egen double w_imp = total(cond(r9_M & imp_unk, value_added_nominal, .))
gen double sh_imp = 100 * w_imp / w_va
* their weight before and from the energy recording jump year (import answers jump that year too)
local jy : word 1 of $R9_JUMP_YRS
quietly summarize sh_imp if year < `jy'
local imp_o_lo = round(r(min))
local imp_o_hi = round(r(max))
quietly summarize sh_imp if year >= `jy'
local imp_d_lo = round(r(min))
local imp_d_hi = round(r(max))
foreach k of local low_rules {
    bysort year: egen double w_low`k' = total(cond(r9_M & r9_ratio < r9_med / `k', value_added_nominal, .))
    gen double sh_low`k' = 100 * w_low`k' / w_va
    quietly summarize sh_low`k'
    local low`k'_lo = round(r(min))
    local low`k'_hi = round(r(max))
}
preserve
bysort year: keep if _n == 1
list year sh_imp sh_low*, noobs sep(0) abbreviate(24)
restore
display "   importers of unknown export status: `imp_o_lo'–`imp_o_hi'% of value added before `jy', `imp_d_lo'–`imp_d_hi'% from `jy'"
foreach k of local low_rules {
    display "   records under 1/`k' of their sector-year median: `low`k'_lo'–`low`k'_hi'% of a year's value added"
}
drop w_va w_imp sh_imp w_low* sh_low*

*---------------------------------------------------------------------------
display "Step 3/7: split every period's change (FHK) under every version"
*---------------------------------------------------------------------------
* Measures (per million units of the denominator; weights = the denominator's shares):
*   co2_va  CO2 (tonnes) per unit of value added   <- drawn (all versions except output)
*   gj_va   energy (GJ) per unit of value added     (tables)
*   co2_out CO2 per unit of output, output weights  <- drawn for version "output"
local num_co2_va  "co2_total_s1"
local den_co2_va  "value_added_nominal"
local num_gj_va   "total_gj_s1"
local den_gj_va   "value_added_nominal"
local num_co2_out "co2_total_s1"
local den_co2_out "gross_output_nominal"
local if_co2_out  "if !missing(r9_o_co2)"      // output above zero (always true in this file)
tempfile firmyears res
save `firmyears'
tempname h
postfile `h' int(vord pord) str12 version str60 version_label byte(drawn mark) str9 interval ///
    str10 kind str14 period int(start_year end_year years_between) str80 data_warning str8 measure ///
    long(n_stayers n_entrants n_leavers n_records_set_aside n_stayers_set_aside n_stayers_outside_universe) ///
    double(va_kept_start va_kept_end level_start level_end change within between cross entry exit ///
           sum_parts gap_rel) using `res', replace
local allp `"$R9_INTERVALS "$R9_LONG""'
local vord 0
local nruns 0
foreach v of local vlist {
    local ++vord
    local mode  = cond("`v'" == "asfiled", "asfiled", "main")
    local mlist = cond("`v'" == "output", "co2_out", "co2_va gj_va")
    local pord 0
    foreach p of local allp {
        local ++pord
        local a : word 1 of `p'
        local b : word 2 of `p'
        local kind = cond(`pord' <= 3, "main", "whole span")
        local pname ""
        if `pord' <= 3 local pname : word `pord' of $R9_PERIODS
        r9_interval_note `a' `b'
        local warn "`r(note)'"
        use `firmyears', clear
        * base for "value added kept": the as-filed universe of each year
        foreach t in a b {
            quietly summarize value_added_nominal if r9_U & year == ``t'', meanonly
            local base_`t' = r(sum)
        }
        * the version: change the block's flags (r9_x = set aside, r9_U = universe) ...
        if substr("`v'", 1, 3) == "cut" {
            local k = substr("`v'", 4, .)
            quietly replace r9_x = r9_U & r9_ratio > `k' * r9_med
        }
        if "`v'" == "noimp"      quietly replace r9_x = r9_x | (r9_U & imp_unk)
        if "`v'" == "noimpdoubt" quietly replace r9_x = r9_x | (r9_U & imp_unk & doubt_yr)
        if substr("`v'", 1, 3) == "low" {
            local k = substr("`v'", 4, .)
            quietly replace r9_x = r9_x | (r9_U & r9_ratio < r9_med / `k')
        }
        if "`v'" == "zero" {
            * zero energy enters as a ratio of 0 (never an extreme record)
            quietly replace r9_U = 1 if zero_e
            foreach r in r9_ratio r9_a_co2 r9_a_gj {
                quietly replace `r' = 0 if zero_e
            }
            quietly replace r9_o_co2 = 0 if zero_e & gross_output_nominal > 0 & !missing(gross_output_nominal)
            quietly replace r9_x = 0 if zero_e
        }
        * ... then build the period sample exactly as R9-02 does
        r9_interval_sample `a' `b' `mode'
        foreach r in n_stayers n_entrants n_leavers n_records_set_aside n_stayers_set_aside n_stayers_outside_universe {
            local `r' = r(`r')
        }
        * as filed keeps every universe record: the program still counts the records the
        * main rule would flag, so report zero set aside here
        if "`mode'" == "asfiled" {
            local n_records_set_aside 0
            local n_stayers_set_aside 0
        }
        foreach t in a b {
            quietly summarize value_added_nominal if year == ``t'', meanonly
            local kept_`t' = 100 * r(sum) / `base_`t''
        }
        foreach m of local mlist {
            quietly r9_fhk `num_`m'' `den_`m'' `if_`m'', firm(firm_id) year(year) from(`a') to(`b')
            * parts add up to the change; shares sum to 1; level = total over total
            assert r(gap_rel) < 1e-9
            assert abs(r(sum_s_from) - 1) < 1e-9 & abs(r(sum_s_to) - 1) < 1e-9
            assert reldif(r(ratio_from), r(I_from)) < 1e-9 & reldif(r(ratio_to), r(I_to)) < 1e-9
            * the program finds the same stayers, entrants and leavers as the period sample
            if "`if_`m''" == "" assert r(n_stay) == `n_stayers' & r(n_enter) == `n_entrants' & r(n_exit) == `n_leavers'
            local ++nruns
            post `h' (`vord') (`pord') ("`v'") ("`lab_`v''") (`draw_`v'') (`mark_`v'') ("`a'-`b'") ("`kind'") ///
                ("`pname'") (`a') (`b') (`b' - `a') ("`warn'") ("`m'") ///
                (`n_stayers') (`n_entrants') (`n_leavers') (`n_records_set_aside') (`n_stayers_set_aside') ///
                (`n_stayers_outside_universe') (`kept_a') (`kept_b') ///
                (r(I_from)) (r(I_to)) (r(change)) (r(within)) (r(between)) (r(cross)) (r(entry)) (r(exit)) ///
                (r(sum_parts)) (r(gap_rel))
        }
        if `pord' <= 3 display "   `v' `a'->`b': stayers `n_stayers', entrants `n_entrants', leavers `n_leavers'; " ///
            "records set aside `n_records_set_aside'; value added kept " %5.1f `kept_a' "% / " %5.1f `kept_b' "%"
    }
}
postclose `h'
display "   FHK splits run: `nruns'"

*---------------------------------------------------------------------------
display "Step 4/7: results table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `res', clear
* "Reallocation" in Bu Deasy's words = between + cross; entry + exit = firms appearing and disappearing, net
gen double realloc = between + cross
gen double entex   = entry + exit
foreach v in change within between cross realloc entry exit entex {
    gen double pct_`v' = 100 * `v' / level_start
}
gen byte mo = cond(measure == "co2_va", 1, cond(measure == "gj_va", 2, 3))
gen str40 measure_label = ""
replace measure_label = "CO2 per unit of value added"             if measure == "co2_va"
replace measure_label = "Energy (GJ) per unit of value added"     if measure == "gj_va"
replace measure_label = "CO2 per unit of output (output weights)" if measure == "co2_out"
gen str80 note = "Development data: firm links fictional; entry and exit = sample rotation"
if !`fict_links' replace note = ""
sort vord pord mo
drop mo
order vord version version_label drawn mark pord interval kind period start_year end_year years_between ///
      data_warning measure measure_label n_stayers n_entrants n_leavers n_records_set_aside ///
      n_stayers_set_aside n_stayers_outside_universe va_kept_start va_kept_end level_start level_end ///
      change within between cross realloc entry exit entex sum_parts gap_rel pct_* note
format va_kept_* %9.2f
format level_* change within between cross realloc entry exit entex sum_parts %14.6f
format pct_* %9.3f
format gap_rel %9.2e
export delimited using "tables/`fname'.csv", datafmt replace
tempfile results
save `results'
list version interval pct_change pct_within pct_realloc pct_entex n_records_set_aside ///
    if kind == "main" & measure != "gj_va", noobs sep(3) abbreviate(24)

*---------------------------------------------------------------------------
display "Step 5/7: notes (numbers, versions and years read from the data, never typed)"
*---------------------------------------------------------------------------
* the drawn points: the three periods, CO2 per value added (per output for version "output")
gen byte shown = drawn & kind == "main" & measure == cond(version == "output", "co2_out", "co2_va")
* does the total keep the main version's direction? list every drawn version where it does not
bysort pord: egen double main_change = max(cond(version == "main" & measure == "co2_va", pct_change, .))
sort vord pord
local flips ""
quietly levelsof vord if shown & sign(round(pct_change)) != sign(round(main_change)), local(fv)
foreach i of local fv {
    quietly levelsof pord if shown & vord == `i' & sign(round(pct_change)) != sign(round(main_change)), local(fp)
    foreach q of local fp {
        quietly summarize pct_change if shown & vord == `i' & pord == `q', meanonly
        local val = round(r(mean))
        local val = cond(`val' > 0, "+", "−") + strofreal(abs(`val'))
        quietly levelsof version if vord == `i', local(vv) clean
        local L = char(96 + `q')
        local flips = cond("`flips'" == "", "", "`flips'; ") + "(`L') `short_`vv'' (`val'%)"
    }
}
display "   versions whose total goes the other way from the main version: `flips'"
* ---- the line under the title (built from the data): per period, does every drawn
* version move the total the same way (up or down) as the main version? Where the
* cut-off decides it, name the single records that decide it; where the doubtful
* importers are set aside in the end year only, say that the two years count different firms.
local lomin : word 1 of `desc'
foreach k of local desc {
    if !`: list k in cuts_table' & `k' < `lomin' local lomin `k'   // strictest drawn cut-off
}
local same ""
local wflip ""
forvalues q = 1/3 {
    local L = char(96 + `q')
    quietly count if shown & pord == `q' & sign(round(pct_change)) != sign(round(main_change))
    if r(N) == 0 {
        local same = cond("`same'" == "", "(`L')", "`same' and (`L')")
        continue
    }
    quietly summarize main_change if pord == `q', meanonly
    local mv = round(r(mean))
    local mtx = cond(`mv' > 0, "+", cond(`mv' < 0, "−", "")) + strofreal(abs(`mv'))
    quietly summarize start_year if pord == `q', meanonly
    local a = r(mean)
    quietly summarize end_year if pord == `q', meanonly
    local b = r(mean)
    local t ""
    * (1) the cut-off versions (as filed and every drawn cut-off)
    quietly count if shown & pord == `q' & mark <= 2 & sign(round(pct_change)) != sign(round(main_change))
    if r(N) > 0 {
        quietly summarize pct_change if shown & pord == `q' & mark <= 2
        local lo = round(r(min))
        local hi = round(r(max))
        local lo = cond(`lo' > 0, "+", cond(`lo' < 0, "−", "")) + strofreal(abs(`lo'))
        local hi = cond(`hi' > 0, "+", cond(`hi' < 0, "−", "")) + strofreal(abs(`hi'))
        local t "In (`L') the total runs from `lo'% to `hi'% across the cut-offs (main `mtx'%)"
        * records some drawn version keeps and another sets aside: over the strictest
        * drawn cut-off. The largest one in each of the two years, if it holds 10% or
        * more of that year's CO2 (as filed), is named.
        preserve
        use `firmyears', clear
        quietly keep if r9_U & inlist(year, `a', `b')
        bysort year: egen double tco2 = total(co2_total_s1)
        gen double sh = 100 * co2_total_s1 / tco2
        gen double rel = r9_ratio / r9_med
        quietly keep if rel > `lomin' & sh >= 10
        bysort year (sh): keep if _n == _N
        local recs ""
        forvalues i = 1/`=_N' {
            local rr = strofreal(round(rel[`i']), "%12.0fc")
            local ss = strofreal(round(sh[`i']))
            local yy = year[`i']
            if "`recs'" == "" local recs "one `yy' record, at `rr'× its sector's median energy per unit of value added, holds `ss'% of that year's CO2"
            else local recs "`recs'; one `yy' record, at `rr'×, holds `ss'%"
        }
        restore
        if "`recs'" != "" local t "`t' because single records decide it: `recs'"
        local t "`t'. So whether the level fell or rose in (`L') is not settled."
    }
    * (2) doubtful importers set aside only in the doubt years, when the period starts
    * before them and ends in them: the two years then count different firms
    local dyrs "$R9_DOUBT_YRS"
    local sa : list a in dyrs
    local sb : list b in dyrs
    quietly count if shown & pord == `q' & version == "noimpdoubt" & sign(round(pct_change)) != sign(round(main_change))
    if r(N) > 0 & !`sa' & `sb' {
        quietly summarize pct_change if shown & pord == `q' & version == "noimpdoubt", meanonly
        local v1 = round(r(mean))
        local v1 = cond(`v1' > 0, "+", cond(`v1' < 0, "−", "")) + strofreal(abs(`v1'))
        quietly summarize pct_change if shown & pord == `q' & version == "noimp", meanonly
        local v2 = round(r(mean))
        local v2 = cond(`v2' > 0, "+", cond(`v2' < 0, "−", "")) + strofreal(abs(`v2'))
        preserve
        use `firmyears', clear
        quietly keep if r9_M & year == `a'
        foreach g in 1 0 {
            quietly summarize co2_total_s1 if imp_unk == `g', meanonly
            local c = r(sum)
            quietly summarize value_added_nominal if imp_unk == `g', meanonly
            local lv`g' = round(1e6 * `c' / r(sum))
        }
        restore
        local t2 "setting importers of unknown export status aside only in `dtxt' gives `v1'%, but then `a' counts them and `b' does not (their `a' level: `lv1'; other firms: `lv0'); set aside in every year: `v2'%."
        local t = cond("`t'" == "", "In (`L'): `t2'", "`t' " + upper(substr("`t2'", 1, 1)) + substr("`t2'", 2, .))
    }
    * (3) any other drawn version that goes the other way
    quietly levelsof vord if shown & pord == `q' & mark == 3 & version != "noimpdoubt" ///
        & sign(round(pct_change)) != sign(round(main_change)), local(ov)
    foreach i of local ov {
        quietly levelsof version if vord == `i', local(vv) clean
        quietly summarize pct_change if shown & vord == `i' & pord == `q', meanonly
        local vo = round(r(mean))
        local vo = cond(`vo' > 0, "+", cond(`vo' < 0, "−", "")) + strofreal(abs(`vo'))
        local t = cond("`t'" == "", "In (`L'): ", "`t' ") + "`short_`vv'': `vo'%."
    }
    local wflip = strtrim("`wflip' `t'")
}
if "`wflip'" == "" local warn1 "In every period, every version moves the total the same way (up or down) as the main version."
else if "`same'" == "" local warn1 "`wflip'"
else local warn1 "In `same' every version moves the total the same way (up or down) as the main version. `wflip'"
display "   line under the title: `warn1'"
* staying firms' two parts: do they pull in opposite directions?
quietly count if shown & sign(within) != sign(realloc) & within != 0 & realloc != 0
local nopp = r(N)
quietly count if shown
local nshown = r(N)
local opp "Within and reallocation pull in opposite directions in `nopp' of the `nshown' rows (Figure R9-02 says why): read them together."
if `nopp' == 0 local opp ""
drop shown main_change
local low1 : word 1 of `low_rules'
local low2 : word 2 of `low_rules'
local fic "Entry + exit compares firms seen in one year only with the start level."
if `fict_links' local fic "Entry + exit (gray) = firms seen in one year only; firm links are fictional, so it means nothing here; the total is the real change."
local ntext "Notes: Bookkeeping, not cause. Each row redoes Figure R9-02's split of the change in CO2 per unit of value added (all firms together; % of the period's start level; minus = cleaner) with one choice changed; within + reallocation + entry + exit = total. Main version (bold): a firm-year is set aside when its energy per unit of value added is over $R9_RULE× its 2-digit sector's median that year; the cut-off has no natural break. Importers of unknown export status hold `imp_o_lo'–`imp_o_hi'% of value added before `jy' and `imp_d_lo'–`imp_d_hi'% from then; their `dtxt' energy records are in doubt. Records under 1/`low1' of the median mirror the main rule (1/`low2' would set aside `low`low2'_lo'–`low`low2'_hi'% of a year's value added: tables). Zero energy may just be unrecorded. `opp' `fic' Value added (output minus materials, energy and services bought) is in current prices, so price rises alone lower ratios. Energy: tables. Shows how far the split moves, not which choice is right."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 150 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
local nlines : word count `notelines'
display "   notes: `nlines' lines"
if `nlines' > 9 display as error "   WARNING: the notes run to `nlines' lines (limit 9)"
* the line under the title, wrapped the same way
local warnlines ""
local line ""
foreach w of local warn1 {
    if ustrlen("`line' `w'") > 150 & "`line'" != "" {
        local warnlines `"`warnlines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local warnlines `"`warnlines' "`line'""'

*---------------------------------------------------------------------------
display "Step 6/7: draw: one panel per period, one row per version (bar = total, marks = parts)"
*---------------------------------------------------------------------------
keep if drawn & kind == "main" & measure == cond(version == "output", "co2_out", "co2_va")
* rows top to bottom: header, the cut-off versions (as filed to strictest), gap,
* header, the other checks
gen byte grp = cond(mark <= 2, 1, 2)
egen int r = group(vord)                   // row among the drawn versions
bysort grp: egen int r_first = min(r)
replace r = r - r_first + 1                 // row inside its group
drop r_first
quietly summarize r if grp == 1
local n1 = r(max)
quietly summarize r if grp == 2
local n2 = r(max)
local nv = `n1' + `n2'
assert _N == 3 * `nv'
gen double y = cond(grp == 1, 1 + r, `n1' + 3 + r)
local ybot = `n1' + 3 + `n2'
rename pord panel
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local a : word 1 of `p'
    local b : word 2 of `p'
    local pn : word `k' of $R9_PERIODS
    local L = char(96 + `k')
    label define panel `k' "(`L') `a'–`=substr("`b'", 3, 2)', `pn' (`=`b' - `a'' years)", add
}
label values panel panel
* shared x axis, symmetric around 0, set by every version except "as filed": its
* few extreme records can run far beyond; such marks sit at the edge (triangle, value written)
egen double r9n_m = rowmax(pct_within pct_realloc pct_entex pct_change)
egen double r9n_n = rowmin(pct_within pct_realloc pct_entex pct_change)
quietly summarize r9n_m if version != "asfiled"
local M = r(max)
quietly summarize r9n_n if version != "asfiled"
local M = max(`M', abs(r(min)))
drop r9n_m r9n_n
local mag = 10^floor(log10(`M'))
local half = .
foreach f in 20 15 10 8 6 5 4 3 2.5 2 1.5 1 {
    if `f' * `mag' >= 1.1 * `M' local half = `f' * `mag'      // smallest round number >= 1.1 x largest
}
local step = `mag'
foreach f in 2 2.5 5 10 {
    if `half' / `step' > 2.5 local step = `f' * `mag'
}
local xl = `step' * floor(`half' / `step')
display "   x axis: -`half' to `half', labels every `step' (largest part outside the as-filed version: " %6.1f `M' ")"
local xlabs ""
forvalues v = -`xl'(`step')`xl' {
    local xlabs `"`xlabs' `v' "`=cond(`v' < 0, "−", "")'`=abs(`v')'""'
}
* marks beyond the axis: drawn at the edge
local nclip 0
foreach v in within realloc entex change {
    gen byte c_`v' = abs(pct_`v') > `half'
    gen double x_`v' = cond(c_`v', sign(pct_`v') * `half', pct_`v')
    quietly count if c_`v'
    local nclip = `nclip' + r(N)
    gen str8 l_`v' = cond(c_`v', strofreal(round(pct_`v'), "%9.0f"), "")
    replace l_`v' = subinstr(l_`v', "-", "−", 1)
    gen byte p_`v' = cond(pct_`v' > 0, 9, 3)      // label inside the edge
}
display "   marks beyond the axis: `nclip'"
list version panel pct_within pct_realloc pct_entex pct_change if c_within | c_realloc | c_entex | c_change, ///
    noobs sep(0) abbreviate(24)
* the totals column on the right of each panel
local xtot = `half' * 1.06
local xmax = `half' * 1.42
gen double xtot = `xtot'
gen str12 tlab = strofreal(round(pct_change), "%9.0f")
replace tlab = "0" if tlab == "-0"
replace tlab = subinstr(tlab, "-", "−", 1)       // typographic minus, as in the notes
replace tlab = "{bf:" + tlab + "}" if version == "main"
gen double zero = 0
gen double gl = -`half'
gen double gr = `half'
* zero line and column head: one extra row per panel
local n0 = _N
set obs `=`n0' + 3'
gen double zy0 = .
gen double zy1 = .
gen double zx  = .
gen double hy  = .
gen str10 hlab = ""
forvalues j = 1/3 {
    local i = `n0' + `j'
    replace panel = `j' in `i'
    replace zy0 = 0.4 in `i'
    replace zy1 = `ybot' + 0.6 in `i'
    replace zx  = 0 in `i'
    replace hy  = 0.2 in `i'
    replace xtot = `xtot' in `i'
    replace hlab = "Total, %" in `i'
}
* y labels (left of panel (a)): two group headers, then the versions; main in bold
local ylab `"1 "{bf:Cut-off for extreme records}" `=`n1' + 3' "{bf:Main version with one change}""'
forvalues i = 1/`n0' {
    local yy = y[`i']
    local vl = version_label[`i']
    if "`=version[`i']'" == "main" local vl "{bf:`vl'}"
    if panel[`i'] == 1 local ylab `"`ylab' `yy' "`vl'""'
}
local gray = cond(`fict_links', "gs8", "black")
local graykey "Firms appearing or disappearing (entry + exit)"
if `fict_links' local graykey "Gray = firms appearing or disappearing (entry + exit; fictional links: no meaning here)"
local clipkey ""
local cliplay ""
if `nclip' > 0 {
    * the total needs no triangle: its bar stops at the edge and the column gives the value
    local cliplay `"(scatter y x_within if c_within, msymbol(Th) mcolor(black) msize(small) mlwidth(medthin))"'
    local cliplay `"`cliplay' (scatter y x_realloc if c_realloc, msymbol(Th) mcolor(black) msize(small) mlwidth(medthin))"'
    local cliplay `"`cliplay' (scatter y x_entex if c_entex, msymbol(Th) mcolor(`gray') msize(small) mlwidth(medthin))"'
    foreach v in within realloc entex {
        local cliplay `"`cliplay' (scatter y x_`v' if c_`v', msymbol(none) mlabel(l_`v') mlabposition(12) mlabgap(0.6) mlabsize(vsmall) mlabcolor(gs4))"'
    }
    local clipkey `"9 "Beyond the axis: mark or bar cut at the edge, value written""'
}
sort panel y
twoway (rbar zero x_change y, horizontal barwidth(0.62) fcolor(gs14) lcolor(gs11) lwidth(vthin)) ///
    (pcspike y gl y gr, lcolor(gs15) lwidth(vthin)) ///
    (pcspike zy0 zx zy1 zx, lcolor(gs8) lwidth(thin)) ///
    (scatter y x_within if !c_within, msymbol(O) mcolor(black) msize(small)) ///
    (scatter y x_realloc if !c_realloc, msymbol(Dh) mcolor(black) msize(small) mlwidth(medthin)) ///
    (scatter y x_entex if !c_entex, msymbol(Sh) mcolor(`gray') msize(small) mlwidth(medthin)) ///
    (scatter y xtot, msymbol(none) mlabel(tlab) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter hy xtot, msymbol(none) mlabel(hlab) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(gs4)) ///
    `cliplay', ///
    by(panel, rows(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R9-07. Each period's change in CO2 per unit of value added, split as in Figure R9-02, with extreme records" ///
              "cut at other levels, some records set aside, zero-energy firms kept, or per unit of output", ///
              size(small) pos(11) span) ///
        subtitle(`warnlines', size(vsmall) pos(11) span color(black)) ///
        note(`notelines' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    yscale(reverse noline range(0 `=`ybot' + 0.6')) ///
    ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(vsmall)) ytitle("") ///
    xscale(range(-`half' `xmax') noline) ///
    xlabel(`xlabs', noticks tlength(0) labsize(vsmall) nogrid) ///
    xtitle("Part of the change, % of the period's start level (minus = lowers the level: cleaner)", size(vsmall)) ///
    legend(order(1 "Total change (the parts added up)" 4 "Staying firms' own change (within)" ///
                 6 "`graykey'" 5 "Reallocation among staying firms (between + cross)" ///
                 `clipkey' 3 "0 = no part in the change") ///
        cols(2) region(lcolor(none)) size(vsmall) symxsize(4) symysize(1.6) keygap(1) colgap(6) rowgap(0.3)) ///
    plotregion(style(none)) xsize(11) ysize(7.5)

graph export "figures/`fname'.png", width(3300) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion tables: every plotted point; every version, CO2 and energy (putpdf)"
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
* --- PART 2 (this exhibit) ------------------------------------------------------
* Table R9-07: one row per plotted point, in chart order: panel (a) to (c), blocks
* (parts) top to bottom, versions top to bottom. Built from the results saved at
* Step 4 (chart and CSV unchanged).
use `results', clear
keep if drawn & kind == "main" & measure == cond(version == "output", "co2_out", "co2_va")
egen int r = group(vord)
expand 4
bysort pord vord: gen byte part = _n
local pvars "within realloc entex change"
gen double pct = .
gen double lvl = .
forvalues j = 1/4 {
    local v : word `j' of `pvars'
    replace pct = pct_`v' if part == `j'
    replace lvl = `v' if part == `j'
}
gen str60 c_panel = ""
local k 0
foreach p of global R9_INTERVALS {
    local ++k
    local pn : word `k' of $R9_PERIODS
    local L = char(96 + `k')
    replace c_panel = "(`L') " + string(start_year) + "–" + substr(string(end_year), 3, 2) + ", `pn'" if pord == `k'
}
gen str60 c_part = ""
* short part names (full names in the notes)
local heads `""Within" "Reallocation" "Entry + exit" "Total change""'
forvalues j = 1/4 {
    local hq : word `j' of `heads'
    replace c_part = "`hq'" if part == `j'
}
gen str60 c_ver = version_label
* same rounding as the chart labels (whole %), then one more decimal, then level units
gen str8 c_shown = strofreal(round(pct), "%9.0f")
replace c_shown = "0" if c_shown == "-0"
gen str10 c_pct = strofreal(pct, "%9.1f")
replace c_pct = "0.0" if c_pct == "-0.0"
gen str12 c_lvl = strofreal(lvl, "%12.2f")
replace c_lvl = "0.00" if c_lvl == "-0.00"
foreach v in c_shown c_pct c_lvl {
    replace `v' = subinstr(`v', "-", "−", 1)
}
gen str10 c_start = strofreal(level_start, "%12.2f")
* firms behind the point: staying firms (within, reallocation), appearing plus
* disappearing firms (entry + exit), all firms (total)
gen long nf = cond(part <= 2, n_stayers, cond(part == 3, n_entrants + n_leavers, n_stayers + n_entrants + n_leavers))
gen str8 c_firms = strofreal(nf, "%12.0fc")
gen str8 c_set = strofreal(n_records_set_aside, "%12.0fc")
* the chart's axis half-width (Step 6) decides which points sit at the edge
gen str40 c_status = "drawn"
replace c_status = "gray (fictional links)" if `fict_links' & part == 3
replace c_status = c_status + "; cut at the edge" if abs(pct) > `half'
* period warnings go to the footer (same for every row of a panel)
local pwarn ""
forvalues k = 1/3 {
    quietly levelsof data_warning if pord == `k', local(dw) clean
    local L = char(96 + `k')
    if `"`dw'"' != "" local pwarn = cond("`pwarn'" == "", "", "`pwarn'; ") + "(`L') `dw'"
}
if "`pwarn'" != "" local pwarn "Records: `pwarn'."
* check: every plotted point once (3 periods x 4 parts x drawn versions)
quietly count
local npts = r(N)
assert `npts' == 3 * 4 * `nv'
sort pord part r
gen long rn = _n
quietly levelsof rn if (part != part[_n + 1] | pord != pord[_n + 1]) & _n < _N, local(rl)
local tabnote "`warn1' `ntext' `pwarn' Within = staying firms' own change; reallocation = between + cross among staying firms; entry + exit = firms appearing and disappearing. Shown = the label on the chart (whole %). % of start = the part as % of the period's start level (Start level, tonnes of CO2 per million money units of value added; per million of output for the output version). Per million = the part in the same units. Firms = firms behind the point: staying firms (within, reallocation), appearing plus disappearing firms (entry + exit), all three (total). Cut at the edge = beyond the chart's axis (±`half'%). Set aside = firm-years the version leaves out of the period's two years. Not a regression: no coefficients or standard errors."
order c_panel c_part c_ver c_shown c_pct c_lvl c_start c_firms c_set c_status
ctable_pdf c_panel c_part c_ver c_shown c_pct c_lvl c_start c_firms c_set c_status using "tables/`fname'_table.pdf", ///
    title("Table R9-07. Each period's change in CO2 per unit of value added, split as in Figure R9-02, under other choices: every plotted point") ///
    header("Panel (period)" "Part (block on the chart)" "Version (row on the chart)" "Shown|(%)" "% of|start" "Per|million" "Start|level" "Firms" "Set|aside" "Status on chart") ///
    right(4 5 6 7 8 9) norepeat(1 2) rules(`rl') perpage(20) fontsize(8) landscape ///
    notes("`tabnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`npts' plotted points)"

* Table R9-07b: every version (drawn and tables-only), the three periods and the
* whole span, CO2 and energy per unit of value added (CO2 per output for that version).
use `results', clear
gen byte mo = cond(measure == "gj_va", 2, 1)
sort vord pord mo
gen str70 t_ver = version_label + cond(drawn, "", " (tables only)")
gen str30 t_per = string(start_year) + " to " + string(end_year)
replace t_per = t_per + " (" + period + ")" if period != ""
gen str14 t_mea = cond(measure == "co2_va", "CO2 / VA", cond(measure == "gj_va", "Energy / VA", "CO2 / output"))
gen str10 t_s = strofreal(level_start, "%12.2f")
gen str10 t_e = strofreal(level_end, "%12.2f")
local tv "t_ver t_per t_mea t_s t_e"
foreach v in change within between cross realloc entex {
    gen str8 t_`v' = strofreal(pct_`v', "%9.1f")
    replace t_`v' = "0.0" if t_`v' == "-0.0"
    replace t_`v' = subinstr(t_`v', "-", "−", 1)
    local tv "`tv' t_`v'"
}
gen str8 t_set = strofreal(n_records_set_aside, "%12.0fc")
gen str12 t_kept = strofreal(va_kept_start, "%9.0f") + " / " + strofreal(va_kept_end, "%9.0f")
gen str8 t_nc = strofreal(n_stayers, "%12.0fc")
local tv "`tv' t_set t_kept t_nc"
gen long rn = _n
quietly levelsof rn if vord != vord[_n + 1] & _n < _N, local(rl)
order `tv'
ctable_pdf `tv' using "tables/`fname'_versions.pdf", ///
    title("Table R9-07b. Every version: the split of the change in CO2 and energy per unit of value added, each period and the whole span (% of the start level)") ///
    header("Version" "Period" "Measure" "Start|level" "End|level" "Total|change" "Within" "Between" "Cross" "Reallo-|cation" "Entry|+ exit" "Set|aside" "VA kept, %|start / end" "Staying|firms") ///
    right(4 5 6 7 8 9 10 11 12 13 14) norepeat(1 2) rules(`rl') perpage(24) fontsize(8) landscape ///
    notes("Notes: Parts as % of the period's start level; within + between + cross + entry + exit = total change; reallocation = between + cross (Bu Deasy's 'reallocating'). Levels per million money units of value added (VA), or of output for the output version: tonnes of CO2 or GJ. Each version is the main version (firm-years over $R9_RULE× their sector's median energy per unit of value added set aside; a staying firm set aside in one year is set aside in both) with one thing changed; tables-only versions are not drawn. Records under 1/`low2' of the median: `low`low2'_lo'–`low`low2'_hi'% of a year's value added, so this rule changes what is measured rather than screening records. Set aside = firm-years left out of the period's two years. VA kept = value added of the period sample as % of all firm-years with value added and energy above zero (above 100 when zero-energy firms are added). Entry and exit on this file are sample rotation of fictional firm links." ///
          "`srcnote'" "`devnote'")
display "table -> tables/`fname'_versions.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
