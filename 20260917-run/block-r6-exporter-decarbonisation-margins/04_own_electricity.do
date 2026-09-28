/*==========================================================================
  R6-04  When a firm starts exporting, does it start making (more of) its
         own electricity? Three measures, year by year around the start:
         (a) share of firms making some own electricity, (b) own electricity
         as % of the electricity the firm uses (bought + own), (c) amount of
         own electricity among firms that make some.
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use" (margin: own electricity).
  Output : figures/04_own_electricity.png (+ .pdf)
           tables/04_own_electricity.csv
           tables/04_own_electricity_table.pdf       (every plotted point)
           tables/04_own_electricity_regression.pdf  (the regressions behind the dots)
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Own electricity is NEVER added to energy used (GJ): the fuel burnt in the
  firm's generators is already counted among its fuels. The file's own flag
  says the same (own_generation_added = 0, checked below).
  Development data — obscured values, fictional firm panel. Not BPS findings.
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r6-exporter-decarbonisation-margins"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
* R2's block sits next to block-0; its table is used only for the window check
* (if the folder is not there, the check is skipped and the file still runs).
global R2DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r2-internationalisation-energy-efficiency", 1)
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE MEASURES AND THE RECORDING RULE --------------------------------------
local exhibit "R6-04"
local fname   "04_own_electricity"
local ftitle  "Own electricity after an export start"
* own = elec_owngen_kwh (made by the firm); bought = elec_purchased_kwh (PLN + other suppliers)
local nall 4                                           // measures estimated
local nmeas 3                                          // measures drawn (4 = table only)
local n1 "(a) Firms making some own electricity"
local n2 "(b) Own electricity, % of electricity used"
local n3 "(c) Own electricity made, among firms making some"
local n4 "Electricity used, bought + own (table only)"
local u1 "percentage points"                           // unit of the drawn number
local u2 "percentage points"
local u3 "%"
local u4 "%"
local w1 "the share of firms making some own electricity"      // words for the notes
local w2 "own electricity as a share of electricity used"
local w3 "the amount made by firms that make some"
local w4 "electricity used (bought + own)"
local og_min 75        // R1-05/R1-07's rule: a year is used only if own electricity is recorded
                       // for at least 75% of the rows of BOTH groups (starters, never-exporters);
                       // in the thinly recorded years the unrecorded firms are mostly firms that
                       // make none, so dividing by recorded firms inflates the share.
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: own electricity before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
* graph combine rescales relative text sizes, so text is set in points (as in R1-07)
local sm "13pt"
local vs "10pt"

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy, CO2, value added and electricity; check the add-ons"
*---------------------------------------------------------------------------
* The regressions need reghdfe (with ftools and require). Nothing is installed here.
foreach p in reghdfe ftools require {
    capture which `p'
    if _rc {
        display as error "This file needs the Stata add-on `p': type  ssc install `p'  once (see INDEX.md), then run it again."
        exit 199
    }
}
* export_flag          = any export activity (1 yes, 0 no, missing = unknown)
* import_flag          = imports raw materials (used for the doubtful energy records)
* total_gj_s1          = energy use in GJ (nine fuels + bought electricity); gj_fuel_s1, gj_electricity = its parts
* co2_total_s1         = CO2 tonnes (standard rates); value_added_nominal = value added, current prices
* elec_purchased_kwh   = electricity bought from PLN and other suppliers (kWh); never missing
* elec_owngen_kwh      = electricity the firm makes itself (kWh); missing = not recorded
* own_gen_unknown      = 1 when own electricity is not recorded
* own_generation_added = 1 if own electricity were inside the energy total (it must be 0)
use firm_id year export_flag import_flag total_gj_s1 co2_total_s1 value_added_nominal ///
    gj_fuel_s1 gj_electricity elec_purchased_kwh elec_owngen_kwh own_gen_unknown own_generation_added ///
    using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
* Own electricity is never part of energy used: energy = fuels + BOUGHT electricity only.
assert own_generation_added == 0
assert reldif(total_gj_s1, gj_fuel_s1 + gj_electricity) < 1e-9
assert reldif(gj_electricity, 0.0036 * elec_purchased_kwh) < 1e-9
assert own_gen_unknown == missing(elec_owngen_kwh)          // "not recorded" means exactly "missing"
assert elec_owngen_kwh >= 0 if !missing(elec_owngen_kwh)
assert !missing(elec_purchased_kwh) & elec_purchased_kwh >= 0
drop gj_fuel_s1 gj_electricity own_generation_added

*###########################################################################
*## R6 EXPORT-START SAMPLE (copy exactly into later R6 files)
*## = R2's start years (rule A), comparison group, usable-row rule, doubtful
*##   energy records, year window (R2-02's rule) and markers, from block-r2
*##   files 03, 05, 08 and 09. Model: Step 5 (reghdfe, firm and year fixed
*##   effects, clustered by firm; average of years 0..+whi; before-start test).
*###########################################################################
display "Step 2/8: R6 export-start sample: start years, usable rows, doubtful records, year window"
* Years whose energy records are in doubt for importers with unknown export
* status (their recorded energy jumps far up, then falls to about a fifth,
* while value added per worker stays flat; R1-03/R1-04 reviews, R2-06).
* Re-checked below on any data.
local doubt_yrs "2017 2019 2020 2021 2022"
* Import starts dated in this year are left out (import-start version only): from
* this file on far more firms count as importers (likely a recording change; R2-08).
local imp_bad "2017"
local minfirms 30               // R2-02's rule: 30+ starters for a year of its own
* --- Start years, rule A (R2's code; R2-08's loop form, run for exporting and importing) ---
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry: the first year the firm is seen participating,
*   if it was seen NOT participating in some earlier year. Firms participating
*   when first seen cannot be dated and are left out.
* Comparison group: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (excluded) · 9003 status never observed (excluded).
foreach m in exp imp {
    if "`m'" == "exp" local x export_flag
    if "`m'" == "imp" local x import_flag
    by firm_id: egen int first_yes = min(cond(`x' == 1, year, .))
    by firm_id: egen int first_no  = min(cond(`x' == 0, year, .))
    by firm_id: egen int n_known   = total(!missing(`x'))
    gen int keyA = .
    replace keyA = 9003 if n_known == 0                                     // status never observed
    replace keyA = 9001 if n_known > 0 & missing(first_yes)                 // never seen participating
    replace keyA = 9002 if n_known > 0 & !missing(first_yes) & (missing(first_no) | first_no > first_yes)
    replace keyA = first_yes if n_known > 0 & !missing(first_yes) & !missing(first_no) & first_no < first_yes
    assert !missing(keyA)
    gen int gA = keyA if keyA < 9000                                        // start year, rule A
    by firm_id: egen int last_no_before = max(cond(`x' == 0 & year < gA, year, .))
    gen byte exactA = !missing(gA) & last_no_before == gA - 1               // seen "no" the year just before
    rename (keyA gA exactA) (key_`m' g_`m' exact_`m')
    drop first_yes first_no n_known last_no_before
}
* The export start is the event of this block: gA / keyA / exactA as in R2-03.
gen int gA     = g_exp
gen int keyA   = key_exp
gen byte exactA = exact_exp
* Years since the start = calendar year minus start year (0 = start year,
* -1 = the year before). A firm's 2016 is simply missing (no file).
gen int kA = year - gA                                  // missing for non-starters
* Usable row = energy, CO2 and value added all above zero, so every log exists
* (the same rows in R2-03, R2-04 and R2-05). A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
* Doubtful energy records (R2-06's definition): importers whose export status is
* unknown, in the years listed above. Kept in the main version; left out in
* version "nodoubt" (drawn hollow gray) and in the import-start version.
local dlist = subinstr(strtrim(itrim("`doubt_yrs'")), " ", ",", .)
gen byte doubt = missing(export_flag) & import_flag == 1 & inlist(year, `dlist')
* Re-check on these data (R2-06's rule): in each listed year the doubtful rows'
* middle (median) energy per unit of value added should be far from the other
* rows' (above double or below half). If not, the year list needs a new look.
gen double gjva = total_gj_s1 / value_added_nominal if usable
foreach yy of local doubt_yrs {
    quietly summarize gjva if doubt & year == `yy', detail
    local md = r(p50)
    local nd = r(N)
    quietly summarize gjva if !doubt & year == `yy', detail
    local ratio = `md' / r(p50)
    if `nd' == 0 display "   WARNING: no doubtful rows in `yy' - re-check doubt_yrs at the top"
    else if inrange(`ratio', 0.5, 2) display "   WARNING: in `yy' doubtful rows look normal (median ratio " %4.2f `ratio' ") - re-check doubt_yrs"
    else display "   `yy': " %5.0fc `nd' " doubtful rows; their median energy per unit of value added = " %5.2f `ratio' " x the other rows'"
}
drop gjva
tempfile fy smp imps est
save `fy'
* Which years since the start get their own point: R2-02's rule, computed here so
* this file also runs on its own. A year passes when `minfirms'+ starters have a
* usable row in it, from starts both before and after 2016; take the widest
* window -K..+K in which every year passes (further out = grouped ends).
use `fy', clear
keep if !missing(gA) & usable
gen byte early = gA < 2016
gen byte late  = gA > 2016
collapse (count) n = firm_id (max) early late, by(kA)
gen byte passes = n >= `minfirms' & early & late
assert passes if inlist(kA, -1, 0)
local K 0
local go 1
while `go' {
    local kk = `K' + 1
    quietly count if passes & inlist(kA, -`kk', `kk')
    if r(N) == 2 local K = `kk'
    else local go 0
}
local wlo = -`K'
local whi = `K'
* If R2-02's table is present, it must show the same window.
capture confirm file "$R2DIR/tables/02_event_time_support.csv"
if !_rc {
    import delimited using "$R2DIR/tables/02_event_time_support.csv", clear varnames(1)
    if window_first[1] != `wlo' | window_last[1] != `whi' | min_firms[1] != `minfirms' {
        display as error "R2-02's table shows another year window: the R6 sample no longer matches R2's."
        exit 459
    }
    display "   window matches R2-02's table"
}
else display "   R2-02's table not found in $R2DIR: window check skipped"
local nout = `whi' + 1                                  // first grouped year on each side
display "   window (R2-02's rule, computed here): each year from `wlo' to +`whi' on its own; `nout'+ years before or after grouped"
* The firms compared: the starters (rule A) and the firms never seen exporting
* (the comparison group, all their rows). Left out: firms already exporting when
* first seen (start year unknown) and firms whose export status is never recorded.
use `fy', clear
keep if !missing(gA) | keyA == 9001
keep if usable
gen byte never = missing(gA)
save `smp'
*###########################################################################
*## END OF R6 EXPORT-START SAMPLE (markers and model: Step 5)
*###########################################################################

*---------------------------------------------------------------------------
display "Step 3/8: the own-electricity measures, and which years record own electricity for enough firms"
*---------------------------------------------------------------------------
use `smp', clear
* Only rows where own electricity is recorded (yes or no) are used; "not recorded"
* is never read as "makes none".
gen byte rec   = !missing(elec_owngen_kwh)
gen byte maker = rec & elec_owngen_kwh > 0
* (a) makes some own electricity: 100 = yes, 0 = no (so the average is a % of firms)
gen double y1 = 100 * maker if rec
* (b) own electricity as % of electricity used (bought + own); 0 for firms making none
gen double y2 = 100 * elec_owngen_kwh / (elec_owngen_kwh + elec_purchased_kwh) ///
    if rec & elec_owngen_kwh + elec_purchased_kwh > 0
* (c) amount made, kWh, in logs, only for firms making some (compares each firm with itself)
gen double y3 = ln(elec_owngen_kwh) if maker
* table only: electricity used = bought + own, kWh, in logs. A separate measure:
* it is NOT energy used (GJ), which already counts the generators' fuel.
gen double y4 = ln(elec_owngen_kwh + elec_purchased_kwh) if rec & elec_owngen_kwh + elec_purchased_kwh > 0
* The recording rule (R1-05, R1-07): per calendar year, the % of each group's rows
* with own electricity recorded. A year is used only if both groups reach `og_min'%.
preserve
collapse (mean) rec_pct = rec mk_pct = y1 (count) nrows = firm_id, by(year never)
replace rec_pct = 100 * rec_pct
reshape wide rec_pct mk_pct nrows, i(year) j(never)
gen byte yr_ok = rec_pct0 >= `og_min' & rec_pct1 >= `og_min'
display "   own electricity recorded, % of rows (starters | never-exporters), and % making some among recorded rows:"
list year nrows0 rec_pct0 mk_pct0 nrows1 rec_pct1 mk_pct1 yr_ok, noobs abbreviate(24) clean
quietly levelsof year if !yr_ok, local(badyrs)
quietly levelsof year if yr_ok, local(okyrs)
* Numbers for the notes (read from the data, never typed)
gen double rec_both = min(rec_pct0, rec_pct1)
gen double rec_all  = (rec_pct0 * nrows0 + rec_pct1 * nrows1) / (nrows0 + nrows1)
gen double mk_all   = (mk_pct0 * rec_pct0 * nrows0 + mk_pct1 * rec_pct1 * nrows1) / (rec_pct0 * nrows0 + rec_pct1 * nrows1)
local badtxt ""
local recrng ""
local mkrng ""
local mkok ""
if "`badyrs'" != "" {
    local badtxt = subinstr("`badyrs'", " ", " and ", .)
    quietly summarize rec_all if !yr_ok
    local recrng = string(r(min), "%9.0f") + cond(round(r(min)) != round(r(max)), "–" + string(r(max), "%9.0f"), "") + "%"
    quietly summarize mk_all if !yr_ok
    local mkrng = string(r(min), "%9.0f") + cond(round(r(min)) != round(r(max)), "–" + string(r(max), "%9.0f"), "") + "%"
    * the used year just before the first thin year, for comparison
    local b1 : word 1 of `badyrs'
    quietly summarize year if yr_ok & year < `b1'
    if r(N) > 0 {
        local yprev = r(max)
        quietly summarize mk_all if year == `yprev'
        local mkok = string(r(mean), "%9.0f") + "% in `yprev'"
    }
    display "   years left out of the main version (recorded for under `og_min'% of a group's rows): `badtxt'"
    display "   recorded there for `recrng' of rows; `mkrng' of recorded rows make some (`mkok')"
}
else display "   every year records own electricity for at least `og_min'% of both groups' rows"
keep year yr_ok
tempfile yrs
save `yrs'
restore
merge m:1 year using `yrs', assert(match) nogenerate
* Every measure only where recorded
assert missing(y1) if !rec
assert !missing(y1) if rec
* The makers' own electricity relative to bought electricity (middle firm) by
* year: it falls sharply from the 2017 file on (a likely recording change, R1-07).
* Year fixed effects remove such a common shift; (c) compares each firm with itself.
gen double ownratio = elec_owngen_kwh / elec_purchased_kwh if maker & elec_purchased_kwh > 0
preserve
collapse (p50) ownratio, by(year)
list year ownratio, noobs clean
quietly summarize ownratio if year < 2016
local orb = string(r(min), "%4.2f") + "–" + string(r(max), "%4.2f")
quietly summarize ownratio if year > 2016
local ora = string(r(min), "%4.2f") + "–" + string(r(max), "%4.2f")
restore
display "   makers' own / bought electricity, middle firm: `orb' before 2016, `ora' after"
drop ownratio
save `smp', replace

*---------------------------------------------------------------------------
display "Step 4/8: the firms and rows behind each version"
*---------------------------------------------------------------------------
* Versions (the chart draws "main" and "nodoubt"; all are in the CSV):
*   main     = R6 export-start sample, own electricity recorded, years that pass the rule
*   nodoubt  = main without doubtful energy records (Step 2)
*   no2017   = main without the 2017 starters (no 2016 file: they may have started in 2016)
*   exact    = main with only starters seen not exporting the year just before
*   no2017r  = main without the 2017 rows (in 2017 far more firms report making their own)
*   allyrs   = every row where own electricity is recorded, thin years included
*   allyrsnd = allyrs without doubtful energy records
local nv 7
local v1 "main"
local v2 "nodoubt"
local v3 "no2017"
local v4 "exact"
local v5 "no2017r"
local v6 "allyrs"
local v7 "allyrsnd"
local e1 "yr_ok"
local e2 "yr_ok & !doubt"
local e3 "yr_ok & gA != 2017"                           // comparison firms (gA missing) stay
local e4 "yr_ok & (missing(gA) | exactA == 1)"
local e5 "yr_ok & year != 2017"
local e6 "1"
local e7 "!doubt"
forvalues s = 1/`nv' {
    quietly count if rec & `e`s''
    local nr = r(N)
    egen byte ft = tag(firm_id) if rec & `e`s''
    quietly count if ft == 1 & !never
    local ns = r(N)
    quietly count if ft == 1 & never
    display "   `v`s'': " %6.0fc `nr' " rows with own electricity recorded; " %5.0fc `ns' " starters, " %5.0fc r(N) " never-exporters"
    drop ft
}

*---------------------------------------------------------------------------
display "Step 5/8: estimate each measure with firm and year fixed effects (clustered by firm), seven versions"
*---------------------------------------------------------------------------
* R2-03's model (block file 01, Step 5): outcome on one marker per year since the
* start, except -1 (the year before the start = the reference, 0 by definition),
* plus one marker for each grouped end, with firm and year fixed effects.
* Never-exporters are 0 on every marker. (a), (b): b is in percentage points.
* (c) and the table-only row: logs, % = 100 x (exp(b) - 1).
* A marker with no starter row in a measure and version is left out (R2-08).
gen byte ev_lo = !missing(kA) & kA < `wlo'
local cand "ev_lo"
forvalues k = `wlo'/`whi' {
    if `k' == -1 continue
    local nm = cond(`k' < 0, "ev_m" + string(-`k'), "ev_p" + string(`k'))
    gen byte `nm' = (kA == `k')
    local cand `cand' `nm'
}
gen byte ev_hi = !missing(kA) & kA > `whi'
local cand `cand' ev_hi
gen byte ev_ref = (kA == -1)                            // for the counts only
tempname h
postfile `h' byte outcome str8 version str8 term int event_time byte(grouped reference estimated) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) ///
    double(n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
    before_p_no_grouped avg_after_b avg_after_se avg_after_p avg_after_lo avg_after_hi n_after_years ///
    level_starters_ref level_never) using `est'
forvalues s = 1/`nv' {
    forvalues o = 1/`nall' {
        local cond "!missing(y`o') & `e`s''"
        local terms ""
        foreach t of local cand {
            quietly count if `t' & `cond'
            if r(N) > 0 local terms `terms' `t'
        }
        quietly reghdfe y`o' `terms' if `cond', absorb(firm_id year) vce(cluster firm_id)
        local df = e(df_r)
        local NN = e(N)
        local GG = e(N_clust)
        local SG = e(num_singletons)
        capture drop es
        gen byte es = e(sample)
        * A marker whose rows all drop out (firms with one row) cannot be estimated.
        local est_t ""
        foreach t of local terms {
            if _se[`t'] > 0 & !missing(_se[`t']) local est_t `est_t' `t'
        }
        local pre ""
        local pre_in ""
        local post ""
        foreach t of local est_t {
            if "`t'" == "ev_lo" local pre `pre' `t'
            else if substr("`t'", 4, 1) == "m" {
                local pre `pre' `t'
                local pre_in `pre_in' `t'               // years before the start, grouped end left out
            }
            else if "`t'" != "ev_hi" local post `post' `t'
        }
        * Joint test: all years before the start are 0 (with and without the grouped end).
        quietly test `pre'
        local F  = r(F)
        local Fd = r(df)
        local Fp = r(p)
        quietly test `pre_in'
        local Fq = r(p)
        * Average over the start year and the years after it inside the window.
        local lc = subinstr("`post'", " ", " + ", .)
        local np : word count `post'
        quietly lincom (`lc') / `np'
        local a  = r(estimate)
        local as = r(se)
        local al = r(estimate) - invttail(`df', 0.025) * r(se)
        local ah = r(estimate) + invttail(`df', 0.025) * r(se)
        local ap = 2 * ttail(`df', abs(r(estimate) / r(se)))
        egen byte ftag = tag(firm_id) if es
        quietly count if ftag == 1 & !never
        local ST = r(N)
        quietly count if ftag == 1 & never
        local CF = r(N)
        drop ftag
        * Levels, for reading (a) and (b): starters' average the year before the start,
        * never-exporters' average over all their rows (same estimation rows).
        local lvs = .
        local lvn = .
        if `o' <= 2 {
            quietly summarize y`o' if es & kA == -1
            local lvs = r(mean)
            quietly summarize y`o' if es & never
            local lvn = r(mean)
        }
        foreach t in `cand' ev_ref {
            if "`t'" == "ev_lo"       local k = `wlo' - 1
            else if "`t'" == "ev_hi"  local k = `whi' + 1
            else if "`t'" == "ev_ref" local k = -1
            else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
            * starters behind each point (a firm counts once in a grouped end)
            egen byte ft = tag(firm_id) if es & `t'
            quietly count if ft == 1
            local nf = r(N)
            quietly count if es & `t'
            local nr = r(N)
            quietly count if ft == 1 & gA < 2016
            local ne = r(N)
            quietly count if ft == 1 & gA > 2016
            local nl = r(N)
            quietly levelsof gA if es & `t'
            local ny : word count `r(levels)'
            drop ft
            local grp = inlist("`t'", "ev_lo", "ev_hi")
            local whole (`NN') (`GG') (`ST') (`CF') (`SG') (`F') (`Fd') (`Fp') (`Fq') (`a') (`as') (`ap') (`al') (`ah') (`np') (`lvs') (`lvn')
            if "`t'" == "ev_ref" {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (0) (1) (0) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl') (`ny') `whole'
            }
            else if !`: list t in est_t' {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (0) (.) (.) (.) (.) (.) (`nf') (`nr') (`ne') (`nl') (`ny') `whole'
            }
            else {
                local b  = _b[`t']
                local se = _se[`t']
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (1) (`b') (`se') ///
                    (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                    (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl') (`ny') `whole'
            }
        }
    }
    display "   `v`s'': done"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 6/8: the numbers as drawn (points or %), and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen str50 outcome_label = ""
gen str20 unit = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''" if outcome == `o'
    replace unit          = "`u`o''" if outcome == `o'
}
gen str170 version_label = ""
replace version_label = "Main: export starters vs never-exporters (R6 sample), own electricity recorded, years recorded for `og_min'%+ of both groups" if vorder == 1
replace version_label = "Main without doubtful energy records (importers, export status unknown)"            if vorder == 2
replace version_label = "Main without the 2017 starters (they may have started in 2016)"                   if vorder == 3
replace version_label = "Main with only starters seen not exporting the year just before"                  if vorder == 4
replace version_label = "Main without the 2017 rows"                                                       if vorder == 5
replace version_label = "Every recorded row, thin years included (`badtxt')"                               if vorder == 6
replace version_label = "Every recorded row, thin years included, without doubtful energy records"         if vorder == 7
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = string(`wlo' - 1) + " or earlier (grouped)" if term == "ev_lo"
replace column = "+" + string(`whi' + 1) + " or later (grouped)" if term == "ev_hi"
* The drawn number: (a), (b) b itself (percentage points); (c) and the table-only
* row 100 x (exp(b) - 1) (%). Interval ends converted the same way.
gen byte in_logs = outcome >= 3
foreach v in b lo hi {
    gen double shown_`v' = cond(in_logs, 100 * (exp(`v') - 1), `v')
}
rename shown_b shown
foreach v in b lo hi {
    local w = cond("`v'" == "b", "", "_`v'")
    gen double avg_after_shown`w' = cond(in_logs, 100 * (exp(avg_after_`v') - 1), avg_after_`v')
}
replace shown = 0 if reference
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before " + string(`wlo') + "; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +" + string(`whi') + "; each firm counted once" if term == "ev_hi"
replace note = "No starter row that can be compared in this version: marker left out" if !estimated & !reference
gen int window_first = `wlo'
gen int window_last  = `whi'
sort outcome vorder event_time
order outcome outcome_label unit in_logs version version_label column event_time grouped reference estimated ///
      b se lo hi p shown shown_lo shown_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped level_starters_ref level_never ///
      before_F before_df before_p before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p ///
      avg_after_shown avg_after_shown_lo avg_after_shown_hi n_after_years window_first window_last note
drop term vorder
format b se lo hi avg_after_b avg_after_se avg_after_lo avg_after_hi before_F %9.4f
format shown shown_lo shown_hi avg_after_shown avg_after_shown_lo avg_after_shown_hi level_starters_ref level_never %9.2f
format p before_p before_p_no_grouped avg_after_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped ///
    before_df n_after_years %9.0f
tempfile full                                         // full precision, for the chart and the tables
save `full'
export delimited using "tables/`fname'.csv", datafmt replace
set linesize 220
list outcome version avg_after_shown avg_after_shown_lo avg_after_shown_hi avg_after_p before_p ///
    n_rows n_starters n_comparison level_starters_ref level_never if column == "0", noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 7/8: three panels, year by year: main (black) and without doubtful records (gray triangles)"
*---------------------------------------------------------------------------
use `full', clear
keep if outcome <= `nall' & reference                  // one row per measure and version
* Numbers for the panel titles and notes, read from the table (never typed).
* Text per measure and version: "+8.1 points (95% interval +3.7 to +12.4)".
gen byte clear = avg_after_shown_lo > 0 | avg_after_shown_hi < 0          // interval does not cross 0
gen str10 uw = cond(in_logs, "%", " points")
gen str12 fm = cond(in_logs, "%9.0f", "%9.1f")
gen str40 ptxt = ""
gen str90 itxt = ""
forvalues i = 1/`=_N' {
    local f = fm[`i']
    local dd = cond(in_logs[`i'], 1, 0.1)               // rounding step of the text
    local a  = round(avg_after_shown[`i'], `dd')          // round first: no "-0.0"
    local al = round(avg_after_shown_lo[`i'], `dd')
    local ah = round(avg_after_shown_hi[`i'], `dd')
    local u  = uw[`i']
    local pt = cond(`a' > 0, "+", "") + string(`a', "`f'") + "`u'"
    replace ptxt = "`pt'" in `i'
    replace itxt = "`pt' (95% interval " + cond(`al' > 0, "+", "") + string(`al', "`f'") + " to " ///
        + cond(`ah' > 0, "+", "") + string(`ah', "`f'") + ")" in `i'
}
forvalues o = 1/`nall' {
    forvalues s = 1/`nv' {
        local v "`v`s''"
        quietly levelsof itxt if outcome == `o' & version == "`v'", local(tt) clean
        local it`o'`v' "`tt'"
        quietly levelsof ptxt if outcome == `o' & version == "`v'", local(tt) clean
        local pt`o'`v' "`tt'"
        quietly summarize clear if outcome == `o' & version == "`v'"
        local cl`o'`v' = r(mean)
        quietly summarize before_p if outcome == `o' & version == "`v'"
        local bp`o'`v' = cond(r(mean) < 0.001, "p < 0.001", "p = " + string(r(mean), "%5.3f"))
        local bf`o'`v' = r(mean) < 0.05
        local bpn`o'`v' = r(mean)
        quietly summarize level_starters_ref if outcome == `o' & version == "`v'"
        local ls`o'`v' = string(r(mean), "%9.0f")
        quietly summarize level_never if outcome == `o' & version == "`v'"
        local ln`o'`v' = string(r(mean), "%9.0f")
        quietly summarize n_starters if outcome == `o' & version == "`v'"
        local ns`o'`v' = string(r(mean), "%9.0fc")
    }
}
forvalues o = 1/`nall' {
    local q`o' = cond(`cl`o'main', "clear", "not clear")
    local qd`o' = cond(`cl`o'nodoubt', "clear", "not clear")
    local qa`o' = cond(`cl`o'allyrs', "clear", "not clear")
    local qn`o' = cond(`cl`o'allyrsnd', "clear", "not clear")
    display "   (`o') main `it`o'main' `q`o''; without doubtful `it`o'nodoubt' `qd`o''; before-start `bp`o'main'"
    display "       thin years included `it`o'allyrs' `qa`o''; and without doubtful `it`o'allyrsnd' `qn`o''"
}
* All seven versions (CSV): the range of each drawn average and the versions in
* which it is clear, and the versions whose before-start check fails, so no single
* version can be quoted on its own (as in R6-02).
local vs_main     "all"
local vs_nodoubt  "without doubtful records"
local vs_no2017   "without 2017 starters"
local vs_exact    "exact starters"
local vs_no2017r  "without 2017 rows"
local vs_allyrs   = cond("`badtxt'" != "", "`badtxt' counted", "every recorded year")
local vs_allyrsnd = cond("`badtxt'" != "", "`badtxt' counted, without doubtful records", "every recorded year, without doubtful records")
local L1 "(a)"
local L2 "(b)"
local L3 "(c)"
local rngtxt ""
local failtxt ""
forvalues o = 1/`nmeas' {
    quietly summarize avg_after_shown if outcome == `o'
    local dd = cond(`o' == 3, 1, 0.1)
    local fm = cond(`o' == 3, "%9.0f", "%9.1f")
    local uu = cond(`o' == 3, "%", " points")
    local rlo = round(r(min), `dd')
    local rhi = round(r(max), `dd')
    local rlo = cond(`rlo' > 0, "+", "") + string(`rlo', "`fm'")
    local rhi = cond(`rhi' > 0, "+", "") + string(`rhi', "`fm'") + "`uu'"
    local nclr 0
    local clist ""
    local nlist ""
    forvalues s = 1/`nv' {
        local v "`v`s''"
        if `cl`o'`v'' {
            local ++nclr
            local clist = "`clist'" + cond("`clist'" != "", "; ", "") + "`vs_`v''"
        }
        else local nlist = "`nlist'" + cond("`nlist'" != "", "; ", "") + "`vs_`v''"
    }
    if `nclr' == 0             local ctx "never clear"
    else if `nclr' == `nv'     local ctx "clear in all"
    else if 2 * `nclr' > `nv'  local ctx "clear in `nclr' of `nv'; not in: `nlist'"
    else                       local ctx "clear only in: `clist'"
    local rngtxt = "`rngtxt'" + cond(`o' > 1, "; ", "") + "`L`o'' `rlo' to `rhi' (`ctx')"
}
* versions whose before-start check fails (p below 0.05), grouped by version
forvalues s = 1/`nv' {
    local v "`v`s''"
    local ff ""
    forvalues o = 1/`nmeas' {
        if `bpn`o'`v'' < 0.05 local ff = "`ff'" + cond("`ff'" != "", ", ", "") + "`L`o'' p = " + string(`bpn`o'`v'', "%5.3f")
    }
    if "`ff'" != "" local failtxt = "`failtxt'" + cond("`failtxt'" != "", "; ", "") + "`vs_`v'': `ff'"
}
local vtxt "Seven versions (CSV): all; without doubtful records; without 2017 starters; exact starters (seen not exporting"
local vtxt = "`vtxt' the year before); without 2017 rows; and the first two with " + cond("`badtxt'" != "", "`badtxt'", "every year")
local vtxt "`vtxt' counted. The average runs: `rngtxt'."
if "`failtxt'" != "" local vtxt "`vtxt' Before-start check fails (p below 0.05) for `failtxt'."
display "   `vtxt'"
* Single years whose interval does not cross 0 (black dots), each with the number
* of versions in which that year is clear, and how many would be clear by chance.
use `full', clear
keep if outcome <= `nmeas' & !reference
local ndots 0
local sytxt ""
local pretxt ""
local nonel ""
forvalues o = 1/`nmeas' {
    quietly count if outcome == `o' & version == "main" & estimated
    local ndots = `ndots' + r(N)
    quietly levelsof event_time if outcome == `o' & version == "main" & estimated & (lo > 0 | hi < 0), local(ks)
    local part ""
    local nk 0
    foreach k of local ks {
        local ++nk
        quietly summarize shown if outcome == `o' & version == "main" & event_time == `k'
        local pv = cond(`o' == 3, round(r(mean)), round(r(mean), 0.1))
        local pv = cond(`pv' > 0, "+", "") + string(`pv', cond(`o' == 3, "%9.0f", "%9.1f")) + cond(`o' == 3, "%", "")
        quietly count if outcome == `o' & event_time == `k' & estimated & (lo > 0 | hi < 0)
        local nvc = r(N)
        local kl = cond(`k' > 0, "+", "") + string(`k')
        quietly summarize grouped if outcome == `o' & event_time == `k' & version == "main", meanonly
        if r(max) == 1 local kl = cond(`k' < 0, "≤ ", "≥ ") + "`kl'"
        local part = "`part'" + cond(`nk' > 1, ", ", "") + "`kl' (`pv', `nvc')"
        if `k' < -1 local pretxt = "`pretxt'" + cond("`pretxt'" != "", ", ", "") + "`kl' in `L`o''"
    }
    if `nk' > 0 local sytxt = "`sytxt'" + cond("`sytxt'" != "", "; ", "") + "`L`o'' `part'"
    else local nonel = "`nonel'" + cond("`nonel'" != "", ", ", "") + "`L`o''"
}
if "`sytxt'" == "" local sytxt "No single year's interval excludes 0."
else {
    local sytxt "Single years whose interval excludes 0 (value; in how many of the `nv' versions it is clear): `sytxt'"
    if "`nonel'" != "" local sytxt "`sytxt'; `nonel' none"
    local sytxt "`sytxt'."
    local sytxt "`sytxt' Of `ndots' dots about `=round(0.05*`ndots')' would be clear by chance, so read the averages."
}
if "`pretxt'" != "" local sytxt "`sytxt' A clear year before the start (`pretxt') means starters already differed then."
display "   `sytxt'"
* Chart data: the three drawn measures, main and without doubtful records.
use `full', clear
keep if outcome <= `nmeas' & inlist(version, "main", "nodoubt")
gen byte mn = version == "main"
gen double x  = event_time
gen double xg = event_time - 0.32                       // gray triangles sit just left of the black dot (its label is on the right)
gen str12 lbl = ""
replace lbl = cond(round(shown, 0.1) > 0, "+", "") + string(round(shown, 0.1), "%9.1f") if mn & estimated & !in_logs
replace lbl = "0.0" if lbl == "-0.0"                    // no minus sign on a zero
replace lbl = cond(round(shown) > 0, "+", "") + string(round(shown), "%9.0f") if mn & estimated & in_logs
* Scales: (a) and (b) share one (both in percentage points), (c) has its own (%).
* A round step that grows with the numbers; 0 always inside (lesson 10).
gen byte sc = cond(in_logs, 2, 1)
quietly count if (mn & (estimated | reference)) | (!mn & estimated)
local ndrawn = r(N)                                     // points drawn (checked in the points table)
forvalues g = 1/2 {
    quietly summarize shown_lo if sc == `g' & mn & estimated
    local ymin = min(r(min), 0)
    quietly summarize shown_hi if sc == `g' & mn & estimated
    local ymax = max(r(max), 0)
    quietly summarize shown if sc == `g' & estimated
    local ymin = min(`ymin', r(min))
    local ymax = max(`ymax', r(max))
    local rng = `ymax' - `ymin'
    local step = 10^floor(log10(`rng'))
    if `rng'/`step' < 2       local step = `step'/5
    else if `rng'/`step' < 5  local step = `step'/2
    if `rng'/`step' > 6       local step = `step'*2         // at most about 6 labels per panel
    local ybot`g' = `step' * floor(`ymin'/`step')
    local ytop`g' = `step' * ceil(`ymax'/`step')
    local ystp`g' = `step'
    local yfmt`g' = cond(`step' >= 1, "%9.0f", "%9.1f")
}
local xl = `wlo' - 3.1                                  // room on the left for the row names under the axis
local xr = `whi' + 1.6
* Panel texts: the average of years 0..+whi, the gray triangles' average, the before-start check, levels.
local sub1 "Average of years 0 to +`whi': `it1main', `q1'. Gray triangles: `pt1nodoubt', `qd1'. Before the start: `bp1main'."
local sub1b "The year before the start, `ls1main'% of starters made some; never-exporters `ln1main'% on average."
* The pair with the thin years counted sits under the headline pair, so neither is quoted alone.
local sub1c ""
if "`badtxt'" != "" local sub1c "With `badtxt' counted: `pt1allyrs', `qa1'. Gray triangles: `pt1allyrsnd', `qn1'. Before the start: `bp1allyrs'."
local sub2 "Average of years 0 to +`whi': `it2main', `q2'. Gray triangles: `pt2nodoubt', `qd2'. Before the start: `bp2main'."
local sub2b "The year before the start, starters made `ls2main'% of their electricity; never-exporters `ln2main'% on average."
local sub3 "Average of years 0 to +`whi': `it3main', `q3'. Gray triangles: `pt3nodoubt', `qd3'. Before the start: `bp3main'."
local sub3b "Only firms making some in at least two years (`ns3main' starters): each is compared with itself."
* Without doubtful records far fewer makers remain in (c): say so next to the triangles.
local ns3a = real(subinstr("`ns3main'", ",", "", .))
local ns3b = real(subinstr("`ns3nodoubt'", ",", "", .))
if `ns3b' < 0.8 * `ns3a' local sub3b "Only firms making some in at least two years (`ns3main' starters; gray triangles only `ns3nodoubt', so they swing widely): each is compared with itself."
local yt1 "percentage points"
local yt2 "percentage points"
local yt3 "% change"
forvalues o = 1/`nmeas' {
    preserve
    keep if outcome == `o'
    local g = cond(`o' == 3, 2, 1)
    * Under each panel, two rows drawn as text: years since the start, then the
    * starters behind each black dot (they differ by panel: each measure has its
    * own rows). Drawn as marker labels, because two-line axis labels in points
    * print far too large in combined graphs.
    local span = `ytop`g'' - `ybot`g''
    gen double y_yr = `ybot`g'' - 0.16 * `span'
    gen double y_nf = `ybot`g'' - 0.30 * `span'
    gen str8 t_yr = cond(x > 0, "+", "") + string(x) if mn
    replace t_yr = "≤ " + t_yr if mn & grouped & x < 0
    replace t_yr = "≥ " + t_yr if mn & grouped & x > 0
    gen str8 t_nf = string(firms, "%9.0fc") if mn
    local ylo = `ybot`g'' - 0.36 * `span'                // room for the two text rows
    local yrow = `ybot`g'' - 0.16 * `span'
    local nrow = `ybot`g'' - 0.30 * `span'
    local subs `""`sub`o''" "`sub`o'b'""'
    local leg "legend(off)"
    local fys 30
    if `o' == 1 & "`sub1c'" != "" {
        local subs `"`subs' "`sub1c'""'
        local fys 33                                     // one more subtitle line
    }
    if `o' == `nmeas' {
        local leg `"legend(order(4 "Each single year before or after the start" 5 "Years `nout'+ before or after, combined" 6 "Year before the start (reference = 0)" 7 "Without doubtful energy records (no bar)" 3 "95% interval" 1 "0 = no difference" 2 "Start of exporting") cols(2) position(6) region(lstyle(none)) size(`vs') symxsize(5) keygap(1) colgap(4) rowgap(0.3))"'
        local fys 50
    }
    twoway (pci 0 `=`wlo' - 1.5' 0 `xr', lcolor(gs8) lwidth(thin)) ///
        (pci `ybot`g'' -0.5 `ytop`g'' -0.5, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
        (rspike shown_hi shown_lo x if mn & estimated, lcolor(black) lwidth(thin)) ///
        (scatter shown x if mn & estimated & !grouped, msymbol(O) msize(4.5pt) mcolor(black)) ///
        (scatter shown x if mn & estimated & grouped, msymbol(Oh) msize(4.5pt) mcolor(black)) ///
        (scatter shown x if mn & reference, msymbol(D) msize(5pt) mcolor(gs8)) ///
        (scatter shown xg if !mn & estimated, msymbol(Th) msize(4.5pt) mcolor(gs7)) ///
        (scatter y_yr x if mn, msymbol(none) mlabel(t_yr) mlabposition(0) mlabsize(`vs') mlabcolor(black)) ///
        (scatter y_nf x if mn, msymbol(none) mlabel(t_nf) mlabposition(0) mlabsize(`vs') mlabcolor(gs6)) ///
        (scatter shown_hi x if mn & estimated, msymbol(none) mlabel(lbl) mlabposition(12) mlabgap(2pt) ///
            mlabsize(`vs') mlabcolor(black)), ///
        text(`yrow' `xl' "Year", size(`vs') placement(e) color(black)) ///
        text(`nrow' `xl' "Starters", size(`vs') placement(e) color(gs6)) ///
        title("`n`o''", size(`sm') position(11) justification(left) margin(b+0.5)) ///
        subtitle(`subs', size(`vs') position(11) justification(left) margin(b+1)) ///
        xscale(range(`xl' `xr') off) xtitle("") ///
        yscale(range(`ylo' `=`ytop`g'' + 0.10 * `span'') noline) ///
        ylabel(`ybot`g''(`ystp`g'')`ytop`g'', angle(0) labsize(`vs') noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt`g'')) ///
        ytitle("`yt`o''", size(`vs')) ///
        `leg' graphregion(color(white) lcolor(white)) plotregion(style(none)) ///
        fysize(`fys') name(p`o', replace) nodraw
    restore
}
* Notes as one text, wrapped by printed width (widths in em; R2-05's rule).
local txt "Notes: Starters = firms first seen exporting after a year seen not exporting (they stay starters if they stop); never-exporters"
local txt "`txt' = firms never seen exporting. Each black dot = starters' change since the year before the start minus never-exporters'"
local txt "`txt' change: (a), (b) in percentage points of firms or of electricity used; (c) in %. A 95% bar crossing 0"
local txt "`txt' = no clear difference. Own electricity is used only where it is recorded, in years recorded for `og_min'%+ of both groups (as in"
local txt "`txt' R1-05, R1-07): `badtxt' are left out, recorded for only `recrng' of rows, `mkrng' of them making some"
local txt "`txt' (`mkok'); panel (a) also gives the answer with them counted."
local txt "`txt' Gray triangles leave out importers of unknown export status in the years their energy records jump or drop."
local txt "`txt' `sytxt' `vtxt'"
local txt "`txt' Makers' own electricity per unit bought drops from the 2017 file on (middle firm `orb' before, `ora' after;"
local txt "`txt' likely a recording change; year effects remove what all firms share). Own electricity is never added to energy used"
local txt "`txt' (GJ): the generators' fuel is already counted. Cannot show why firms make their own or which fuel feeds it; timing,"
local txt "`txt' not cause; firm links are fictional: this tests the method, not a finding."
local maxw 60                                           // widest note line that fits the 9-inch PDF at 10 pt
local nl 0
local line ""
local lw 0
foreach w of local txt {
    local n  = ustrlen(`"`w'"')
    local na = `n' - ustrlen(ustrregexra(`"`w'"', "[ijltfr.,;:'()\-]", ""))
    local wi = `n' - ustrlen(ustrregexra(`"`w'"', "[A-Zmw]", ""))
    local pc = `n' - ustrlen(ustrregexra(`"`w'"', "%", ""))
    local dg = `n' - ustrlen(ustrregexra(`"`w'"', "[0-9+=]", ""))
    local ww = 0.29*`na' + 0.7*`wi' + 0.83*`pc' + 0.52*`dg' + 0.47*(`n' - `na' - `wi' - `pc' - `dg')
    local try = `lw' + 0.25*(`"`line'"' != "") + `ww'
    if `try' > `maxw' & `"`line'"' != "" {
        local ++nl
        local L`nl' `"`line'"'
        local W`nl' = `lw'
        local line `"`w'"'
        local lw = `ww'
    }
    else {
        local line = strtrim(`"`line' `w'"')
        local lw = `try'
    }
}
local ++nl
local L`nl' `"`line'"'
local W`nl' = `lw'
local notes ""
forvalues j = 1/`nl' {
    display "   note line `j': " udstrlen(`"`L`j''"') " characters, width " %4.1f `W`j'' " of `maxw' em"
    local notes `"`notes' "`L`j''""'
}
graph combine p1 p2 p3, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("Figure `exhibit'. `ftitle'", size(16pt) position(11) justification(left) span) ///
    subtitle("Starters minus never-exporters, change since the year before the start; (a) and (b) on the same scale" ///
        "Under each panel: Year = years since the start (0 = start year); Starters = starter firms behind each black dot", ///
        size(`sm') position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(`vs') span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) xsize(9) ysize(14.5)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the dots"
*---------------------------------------------------------------------------
* Both tables use the numbers saved in Step 6 just before the CSV (full precision,
* so a 4-decimal CSV value is never rounded twice), after the chart is saved.
* Written with putpdf (built into Stata; no add-on) by the block's table writer.
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
* --- PART 2: the rows of this exhibit ----------------------------------------
* (1) Points table: one row per point of the chart, panel by panel, left to right;
* black dots first, then the gray triangles.
use `full', clear
keep if outcome <= `nmeas' & inlist(version, "main", "nodoubt")
drop if version == "nodoubt" & reference               // the reference is drawn once (black series)
gen byte vo = cond(version == "main", 1, 2)
sort outcome vo event_time
gen str60 t_pan = ""
forvalues o = 1/`nmeas' {
    replace t_pan = "`n`o''" if outcome == `o'
}
replace t_pan = t_pan + " (" + cond(in_logs, "%", "points") + ")"
gen str60 t_ser = cond(vo == 1, "Black dots: all firms compared", "Gray triangles: no doubtful records")
gen str16 t_pos = cond(event_time > 0, "+", "") + string(event_time)
replace t_pos = "≤ " + t_pos if grouped & event_time < 0
replace t_pos = "≥ " + t_pos if grouped & event_time > 0
* value and interval: one decimal (the chart labels round (c) to whole numbers)
gen str12 t_v  = cond(round(shown, 0.1) > 0, "+", "") + string(shown, "%9.1f") if estimated | reference
replace t_v = "0 (reference)" if reference
gen str12 t_lo = string(shown_lo, "%9.1f") if estimated
gen str12 t_hi = string(shown_hi, "%9.1f") if estimated
gen str12 t_n  = string(firms, "%12.0fc")
gen str12 t_r  = string(rows, "%12.0fc")
gen str70 t_status = "black dot, 95% bar"
replace t_status = "hollow black dot, 95% bar; combined" if grouped & vo == 1
replace t_status = "gray diamond, 0 by definition" if reference
replace t_status = "gray triangle, no bar" if vo == 2
replace t_status = t_status + "; combined" if vo == 2 & grouped
replace t_status = "not drawn: no starter row" if !estimated & !reference
foreach v in t_v t_lo t_hi {
    replace `v' = "" if missing(`v')
}
local npts = _N
* check: every point the chart draws appears once (count kept in Step 7)
quietly count if estimated | reference
assert r(N) == `ndrawn'
quietly count if outcome == 1
local r1 = r(N)
quietly count if outcome <= 2
local r2 = r(N)
* the table shows every interval itself, so its footer leaves out the single-years sentence (keeps page 3 whole)
local txt_t = itrim(subinstr(`"`txt'"', `"`sytxt'"', "", 1))
local tnote "Table: every point of Figure `exhibit' in chart order; Year = years since the start. Change: (a), (b) in"
local tnote "`tnote' percentage points; (c) % = 100 × (exp(b) − 1). Combined = years `nout'+"
local tnote "`tnote' before or after, each firm once. Standard errors: tables/`fname'_regression.pdf; all versions: the CSV."
ctable_pdf t_pan t_ser t_pos t_v t_lo t_hi t_n t_r t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Starters minus never-exporters, change since the year before the start (average of years 0 to +`whi' in the regression table)") ///
    header("Panel" "Series" "Year" "Change" "95%|low" "95%|high" "Starter|firms" "Starter|firm-years" "Status") ///
    right(3 4 5 6 7 8) norepeat(1 2) rules(`r1' `r2') fontsize(8) perpage(40) ///
    notes("`txt_t'" "`tnote' `srcnote' `devnote'")
display "   table -> tables/`fname'_table.pdf (`npts' rows)"

* (2) Regression table (AER style): one column per drawn model (black dots and gray
* triangles of each panel), plus panel (a) with the thin years counted.
use `full', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep outcome version event_time b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 outcome version event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
* the columns: measure | version
local ncm 8
local cm1 "1 main"
local cm2 "1 nodoubt"
local cm3 "2 main"
local cm4 "2 nodoubt"
local cm5 "3 main"
local cm6 "3 nodoubt"
local cm7 "1 allyrs"
local cm8 "1 allyrsnd"
gen byte m = 0
forvalues j = 1/`ncm' {
    local oo : word 1 of `cm`j''
    local vv : word 2 of `cm`j''
    replace m = `j' if outcome == `oo' & version == "`vv'"
}
keep if m > 0
sort m event_time
tempname P
tempfile R
local cols ""
forvalues j = 1/`ncm' {
    local cols `cols' t`j'
}
postfile `P' str60 t_lab str28(`cols') using `R'
quietly levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k', meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k', meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    if `rf' {
        local row `"("`lab' (reference)")"'
        forvalues j = 1/`ncm' {
            local row `"`row' ("0")"'
        }
        post `P' `row'
        local ++nterm
        continue
    }
    local rb `"("`lab'")"'
    local rs `"("")"'
    forvalues j = 1/`ncm' {
        quietly summarize b if event_time == `k' & m == `j', meanonly
        local bb = cond(r(N) == 0 | missing(r(mean)), "—", string(r(mean), "%9.3f"))
        quietly summarize se if event_time == `k' & m == `j', meanonly
        local ss = cond(r(N) == 0 | missing(r(mean)), "", "(" + string(r(mean), "%9.3f") + ")")
        local rb `"`rb' ("`bb'")"'
        local rs `"`rs' ("`ss'")"'
    }
    post `P' `rb'
    post `P' `rs'
    local nterm = `nterm' + 2
}
* whole-model rows (the same number on every row of a model: take the mean)
forvalues j = 1/`ncm' {
    foreach v in avg_after_b avg_after_se avg_after_shown avg_after_shown_lo avg_after_shown_hi before_p before_p_no_grouped ///
        n_rows n_firms n_starters n_comparison level_starters_ref level_never in_logs {
        quietly summarize `v' if m == `j', meanonly
        local `v'`j' = r(mean)
    }
    local s_ab`j' = string(`avg_after_b`j'', "%9.3f")
    local s_as`j' = "(" + string(`avg_after_se`j'', "%9.3f") + ")"
    local u = cond(`in_logs`j'', "%", "")
    foreach q in avg_after_shown avg_after_shown_lo avg_after_shown_hi {
        local `q'`j' = round(``q'`j'', 0.1)              // round first: no "-0.0"
    }
    local s_ap`j' = cond(`avg_after_shown`j'' > 0, "+", "") + string(`avg_after_shown`j'', "%9.1f") + "`u' [" ///
        + string(`avg_after_shown_lo`j'', "%9.1f") + ", " + string(`avg_after_shown_hi`j'', "%9.1f") + "]"
    local s_bp`j' = cond(`before_p`j'' < 0.001, "< 0.001", string(`before_p`j'', "%5.3f"))
    local s_bq`j' = cond(`before_p_no_grouped`j'' < 0.001, "< 0.001", string(`before_p_no_grouped`j'', "%5.3f"))
    local s_ls`j' = cond(missing(`level_starters_ref`j''), "", string(`level_starters_ref`j'', "%9.1f"))
    local s_ln`j' = cond(missing(`level_never`j''), "", string(`level_never`j'', "%9.1f"))
    local s_nr`j' = string(`n_rows`j'', "%12.0fc")
    local s_nf`j' = string(`n_firms`j'', "%12.0fc")
    local s_ns`j' = string(`n_starters`j'', "%12.0fc")
    local s_nc`j' = string(`n_comparison`j'', "%12.0fc")
}
* column heads and row label name the thin years (generic if every year passes the rule)
local yrlab = cond("`badtxt'" != "", "`badtxt'", "under the rule")
local yrhd  = cond("`badtxt'" != "", "`badtxt'", "all years")
foreach r in "ab|Average of years 0 to +`whi'" "as|" "ap|  as drawn [95% interval]" "bp|Before-start test, joint p" ///
    "bq|  same, grouped end left out" "ls|Level the year before the start: starters" "ln|Level: never-exporters (all rows)" ///
    "nr|Observations (firm-years)" "nf|Firms (clusters)" "ns|  of which starters" "nc|  of which never-exporters" ///
    "fe|Firm fixed effects" "ye|Year fixed effects" "ix|Industry × year, province × year" "yr|Years `yrlab'" ///
    "wt|Weights" "cl|Standard errors clustered by" {
    gettoken key lab : r, parse("|")
    local lab = substr("`lab'", 2, .)
    local row `"("`lab'")"'
    forvalues j = 1/`ncm' {
        if "`key'" == "fe" local cell "Yes"
        else if "`key'" == "ye" local cell "Yes"
        else if "`key'" == "ix" local cell "No"
        else if "`key'" == "wt" local cell "None"
        else if "`key'" == "cl" local cell "Firm"
        else if "`key'" == "yr" {
            local vv : word 2 of `cm`j''
            local cell = cond(inlist("`vv'", "allyrs", "allyrsnd"), "Included", "Left out")
        }
        else local cell "`s_`key'`j''"
        local row `"`row' ("`cell'")"'
    }
    post `P' `row'
}
postclose `P'
use `R', clear
local rnote "Notes: Each column is one regression of the measure on one marker per year since the export start, `wlo' to +`whi', except −1"
local rnote "`rnote' (the year before the start: the reference, set to 0), and one marker for each grouped end (`nout'+ years before or after),"
local rnote "`rnote' with firm and year fixed effects; never-exporters are 0 on every marker. (1)–(4), (7), (8): the measure is 0 or 100 (a) or"
local rnote "`rnote' a % of electricity used (b), so b is in percentage points; (5), (6): log kWh, so b is in log points and the chart shows"
local rnote "`rnote' 100 × (exp(b) − 1). Rows: own electricity recorded; (1)–(6) leave out `badtxt' (recorded for under `og_min'% of a"
local rnote "`rnote' group's rows). Even columns leave out doubtful energy records. Average = mean of years 0 to +`whi' (the panel title)."
local rnote "`rnote' Before-start test: all years before the start are 0 together. Firms with one row are dropped. No stars."
local rnote "`rnote' Other versions (without 2017 starters or 2017 rows; exact starters) and the table-only measure (electricity used): tables/`fname'.csv."
ctable_pdf t_lab `cols' using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("Coefficient; (standard error). (1)–(4), (7), (8) in percentage points; (5), (6) in log points.") ///
    header("Years since the start" "(1)|(a) Making|some" "(2)|(a) Without|doubtful" "(3)|(b) Own, %|of used" ///
        "(4)|(b) Without|doubtful" "(5)|(c) Amount,|makers" "(6)|(c) Without|doubtful" "(7)|(a) With|`yrhd'" ///
        "(8)|(a) With `yrhd',|w/o doubtful") ///
    right(2 3 4 5 6 7 8 9) rules(`nterm' `=`nterm' + 5') fontsize(8) perpage(30) ///
    notes("`rnote'" "`srcnote' `devnote'")
display "   table -> tables/`fname'_regression.pdf (`ncm' regressions)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
