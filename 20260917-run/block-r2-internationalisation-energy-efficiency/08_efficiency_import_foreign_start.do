/*==========================================================================
  R2-08  Beyond exporting: before and after a firm starts importing, or gets
         a foreign owner (10% or more of its capital), does it get more
         value added out of each unit of energy, compared with firms that
         never do? (value added per GJ drawn; per tonne of CO2, energy use
         and value added in the table)
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya hanya
         Ganti tahun" (the previous paper's import-start and foreign-owner-
         start treatments; its outcome ln VA per GJ; firm and year fixed
         effects; standard errors clustered by firm).
  Output : figures/08_efficiency_import_foreign_start.png (+ .pdf)
           tables/08_efficiency_import_foreign_start.csv
  Needs  : Stata add-ons from SSC, installed once (the file never installs
           or updates anything): ssc install reghdfe, ssc install ftools,
           ssc install require (needed for any output); for the Sun-Abraham
           check only: ssc install eventstudyinteract, ssc install avar
           (if missing, that version gets an "unavailable" row and the file
           still finishes).
  Built from the R2-03 template: same start rule (rule A), year-window rule
         (R2-02) and model; only the start event and the data repairs differ.
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
local exhibit "R2-08"
local fname   "08_efficiency_import_foreign_start"
* ---- KNOWN RECORDING PROBLEMS (chosen on the development files; Step 1 re-checks
* each one on any data and prints a WARNING if it no longer looks like a problem) ----
* Import starts dated in this year are left out: from this file on, far more
* firms count as importers than in the file before (likely a change in how
* imports were recorded), so a "start" here may be a recording change.
local imp_bad "2017"
* Foreign-ownership answers of this year are treated as unknown: in this file
* far more firms are marked foreign-owned than in any other year.
local fdi_bad "2020"
* Years whose energy records are in doubt for importers with unknown export
* status (their recorded energy jumps far up, then falls to about a fifth,
* while value added per worker stays flat; R1-03/R1-04 reviews, R2-06).
local doubt_yrs "2017 2019 2020 2021 2022"
local minfirms 30               // R2-02's rule: 30+ starters for a year of its own
* ---------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: value added per GJ before and after firms start importing or get a foreign owner ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load import, foreign-ownership and export status, energy, CO2 and value added; re-check the known problems"
*---------------------------------------------------------------------------
* import_flag         = imports reported above zero (1 yes, 0 no; never missing)
* fdi_10_flag         = foreign ownership of 10% or more (the previous paper's rule)
* export_flag         = any export activity (used only to find doubtful energy records)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year import_flag fdi_10_flag export_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
tsset firm_id year                 // L. and F. below mean exact calendar years
* The calendar year with no annual file (found in the data, never typed).
quietly summarize year
local gapyr ""
forvalues t = `r(min)'/`r(max)' {
    quietly count if year == `t'
    if r(N) == 0 local gapyr `gapyr' `t'
}
local gap1 : word 1 of `gapyr'
if "`gap1'" == "" local gap1 = 9999
display "   calendar years with no file: `gapyr'"
* Shares of firms importing / foreign-owned each year (for the guards, the notes and the CSV).
preserve
collapse (mean) sh_imp = import_flag sh_fdi = fdi_10_flag (count) file_rows = firm_id, by(year)
tempfile shares
save `shares'
* Guard 1: the import share in `imp_bad' should be far above the file before it.
quietly summarize year if year < `imp_bad'
local imp_prev = r(max)
quietly summarize sh_imp if year == `imp_prev'
local shi0 = r(mean)
quietly summarize sh_imp if year == `imp_bad'
local shi1 = r(mean)
if `shi1' < 1.5 * `shi0' display "   WARNING: import share `imp_prev' -> `imp_bad' does not jump (" %4.2f `shi0' " -> " %4.2f `shi1' ") - re-check imp_bad at the top"
else display "   import share `imp_prev' -> `imp_bad': " %4.2f `shi0' " -> " %4.2f `shi1' " (starts dated `imp_bad' left out)"
* Guard 2: the foreign-owned share in `fdi_bad' should be far above the other years' middle.
quietly summarize sh_fdi if year != `fdi_bad', detail
local shf0 = r(p50)
quietly summarize sh_fdi if year == `fdi_bad'
local shf1 = r(mean)
if `shf1' < 2 * `shf0' display "   WARNING: foreign-owned share in `fdi_bad' looks normal (" %4.2f `shf1' " vs " %4.2f `shf0' ") - re-check fdi_bad at the top"
else display "   foreign-owned share: `fdi_bad' " %4.2f `shf1' " vs middle of other years " %4.2f `shf0' " (`fdi_bad' answers treated as unknown)"
restore
* Usable row = energy, CO2 and value added all above zero, so every log exists
* (as in R2-03 to R2-07). A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
* Doubtful energy records (R2-06's definition): importers whose export status is
* unknown, in the years listed at the top. Left out of the main version.
local dlist = subinstr(strtrim(itrim("`doubt_yrs'")), " ", ",", .)
gen byte doubt = missing(export_flag) & import_flag == 1 & inlist(year, `dlist')
* Guard 3 (R2-06's re-check): in each listed year the doubtful rows' middle
* energy per unit of value added should be far from the other rows' (above
* double or below half). If not, the year list needs a new look.
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
* Foreign ownership with the `fdi_bad' answers treated as unknown (main version).
gen byte fdi_fixed = fdi_10_flag
replace fdi_fixed = . if year == `fdi_bad'

*---------------------------------------------------------------------------
display "Step 2/7: date each firm's start (rule A, same code as every R2 file) for importing and foreign ownership"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry: the first year the firm is seen participating,
*   if it was seen NOT participating in some earlier year. Firms participating
*   when first seen cannot be dated and are left out.
* Comparison group: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (excluded) · 9003 status never observed (excluded).
* Three start events: imp = importing; fdi = foreign owner 10%+ with the
* `fdi_bad' answers unknown (main); fdiraw = the same, answers as filed.
* (The previous paper's stricter rule B is counted in R2-01's table only.)
foreach m in imp fdi fdiraw {
    if "`m'" == "imp"    local x import_flag
    if "`m'" == "fdi"    local x fdi_fixed
    if "`m'" == "fdiraw" local x fdi_10_flag
    * --- Rule A ---
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
* Firms moved by the repairs (CSV and log): import starts dated `imp_bad';
* foreign-owner starts dated `fdi_bad' as filed and where they go once that
* year's answers are unknown.
egen byte ftag = tag(firm_id)
quietly count if ftag & g_imp == `imp_bad'
local n_impbad = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad'
local n_fdibad = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad' & key_fdi == 9001
local n_fdibad_never = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad' & !missing(g_fdi)
local n_fdibad_redated = r(N)
display "   import starts dated `imp_bad' (left out): `n_impbad'; foreign-owner starts dated `fdi_bad' as filed: `n_fdibad', of which `n_fdibad_never' become never foreign-owned and `n_fdibad_redated' get a later start year"
drop ftag

*---------------------------------------------------------------------------
display "Step 3/7: the year window (R2-02's rule) for each main sample; both panels use the narrower one"
*---------------------------------------------------------------------------
* Main samples: importing = starters except those dated `imp_bad', plus firms never
* seen importing; foreign owner = starters (`fdi_bad' answers unknown) plus firms
* never seen foreign-owned. Both: usable rows, doubtful energy records left out.
gen byte main_imp = usable & !doubt & ((!missing(g_imp) & g_imp != `imp_bad') | key_imp == 9001)
gen byte main_fdi = usable & !doubt & (!missing(g_fdi) | key_fdi == 9001)
tempfile fy est sums
save `fy'
* A year since the start passes when `minfirms'+ starters have a usable row in it,
* from starts both before and after the missing file; take the widest window
* -K..+K in which every year passes (further out = grouped ends).
local K 99
foreach m in imp fdi {
    use `fy', clear
    keep if main_`m' & !missing(g_`m')
    gen int k = year - g_`m'
    gen byte early = g_`m' < `gap1'
    gen byte late  = g_`m' > `gap1'
    collapse (count) n = firm_id (max) early late, by(k)
    gen byte passes = n >= `minfirms' & early & late
    assert passes if inlist(k, -1, 0)
    local K_`m' 0
    local go 1
    while `go' {
        local kk = `K_`m'' + 1
        quietly count if passes & inlist(k, -`kk', `kk')
        if r(N) == 2 local K_`m' = `kk'
        else local go 0
    }
    local K = min(`K', `K_`m'')
    display "   `m': R2-02's rule allows -`K_`m'' to +`K_`m''"
}
local wlo = -`K'
local whi = `K'
local nout = `whi' + 1                                  // first grouped year on each side
display "   window used in both panels: each year from `wlo' to +`whi' on its own; `nout'+ years before or after grouped"

*---------------------------------------------------------------------------
display "Step 4/7: estimate each panel and version (firm and year fixed effects, clustered by firm)"
*---------------------------------------------------------------------------
* Log outcome on one marker per year since the start (-1 = the year before the
* start = reference, 0 by definition; grouped ends), removing each firm's own
* average (firm fixed effects) and each year's average (year fixed effects).
* A firm with one usable year cannot be compared with itself; reghdfe drops it.
* Coefficient b = log difference from the starters' year before the start, net
* of the comparison firms' change; drawn as 100 x (exp(b) - 1) = % difference.
* Versions (the figure draws 1 in black and 2 in hollow gray; the rest are in the table):
*   1 main        = repaired starts (above), doubtful energy records left out
*   2 as_filed    = every start and every record as filed
*   3 keep_doubt  = repaired starts, doubtful energy records kept
*   4 before_gap  = repaired starts dated before the missing file, years before it only
*                   (no known recording problem in these years)
*   5 sun_abraham = version 1 with start years kept apart (Sun-Abraham,
*                   eventstudyinteract), never-starters as the only comparison
* Outcomes: 1 ln(value added / GJ) (drawn); 2 ln(value added / CO2); 3 ln GJ;
* 4 ln value added (outcome 1 = 4 minus 3, checked). Outcomes 2-4 for version 1 only.
local ok_sa 1
foreach c in eventstudyinteract avar {
    capture which `c'
    if _rc local ok_sa 0
}
if !`ok_sa' display "   NOTE: eventstudyinteract/avar not installed - the Sun-Abraham version gets an 'unavailable' row"
tempname h s
postfile `h' str6 panel byte(version outcome) str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late) using `est'
postfile `s' str6 panel byte(version outcome) long(n_rows n_firms n_starters n_comparison n_one_year_dropped) ///
    double(before_p avg_b avg_se avg_lo avg_hi) str80 status using `sums'
foreach m in imp fdi {
    forvalues v = 1/5 {
        use `fy', clear
        * which start dating and which rows
        local gv "g_`m'"
        local kv "key_`m'"
        if `v' == 2 & "`m'" == "fdi" {
            local gv "g_fdiraw"
            local kv "key_fdiraw"
        }
        if `v' == 2      keep if usable & (!missing(`gv') | `kv' == 9001)
        else if `v' == 3 keep if usable & (!missing(`gv') | `kv' == 9001) & !(`gv' == `imp_bad' & "`m'" == "imp")
        else             keep if main_`m'
        if `v' == 4      keep if year < `gap1' & (missing(`gv') | `gv' < `gap1')
        gen int gA = `gv'
        gen byte never = missing(gA)
        assert `kv' == 9001 if never                        // comparison = never seen participating only
        gen int kA = year - gA
        gen double y1 = ln(value_added_nominal / total_gj_s1)
        gen double y2 = ln(value_added_nominal / co2_total_s1)
        gen double y3 = ln(total_gj_s1)
        gen double y4 = ln(value_added_nominal)
        * markers; a marker with no starter row in this sample is left out
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
        gen byte ev_ref = (kA == -1)
        local terms ""
        local pre ""
        local post ""
        foreach t of local cand {
            quietly count if `t'
            if r(N) == 0 continue
            local terms `terms' `t'
            if "`t'" == "ev_lo" | substr("`t'", 4, 1) == "m" local pre `pre' `t'
            if "`t'" != "ev_hi" & "`t'" != "ev_lo" & substr("`t'", 4, 1) == "p" local post `post' `t'
        }
        local lc = subinstr("`post'", " ", " + ", .)        // years 0..+`whi', for the average
        local np : word count `post'
        local nout_o = cond(`v' == 1, 4, 1)
        forvalues o = 1/`nout_o' {
            if `v' == 5 & !`ok_sa' {
                post `s' ("`m'") (`v') (`o') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ("unavailable: eventstudyinteract/avar not installed")
                continue
            }
            if `v' == 5 {
                capture quietly eventstudyinteract y`o' `terms', cohort(gA) control_cohort(never) ///
                    absorb(i.firm_id i.year) vce(cluster firm_id)
                if _rc {
                    post `s' ("`m'") (`v') (`o') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ("failed: eventstudyinteract error r(`=_rc')")
                    continue
                }
                local df = e(df_r)
                local N  = e(N)
                capture drop es
                gen byte es = e(sample)
                matrix bsa = e(b_iw)
                matrix vsa = e(V_iw)
                ereturn post bsa vsa, dof(`df')
                local sg = .
            }
            else {
                quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
                local df = e(df_r)
                local N  = e(N)
                local sg = e(num_singletons)
                capture drop es
                gen byte es = e(sample)
                if `v' == 1 matrix b`m'`o' = e(b)
                if `v' == 1 local terms1 `terms'
            }
            quietly test `pre'
            local bp = r(p)
            quietly lincom (`lc') / `np'
            local ab = r(estimate)
            local ase = r(se)
            local alo = r(estimate) - invttail(`df', 0.025) * r(se)
            local ahi = r(estimate) + invttail(`df', 0.025) * r(se)
            egen byte ftag = tag(firm_id) if es
            quietly count if ftag & !never
            local st = r(N)
            quietly count if ftag & never
            local cf = r(N)
            quietly count if ftag
            local G = r(N)
            drop ftag
            post `s' ("`m'") (`v') (`o') (`N') (`G') (`st') (`cf') (`sg') (`bp') (`ab') (`ase') (`alo') (`ahi') ("ok")
            foreach t in `cand' ev_ref {
                if "`t'" == "ev_lo"       local k = `wlo' - 1
                else if "`t'" == "ev_hi"  local k = `whi' + 1
                else if "`t'" == "ev_ref" local k = -1
                else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
                egen byte ft = tag(firm_id) if es & `t'
                quietly count if ft == 1
                local nf = r(N)
                quietly count if es & `t'
                local nr = r(N)
                quietly count if ft == 1 & gA < `gap1'
                local ne = r(N)
                quietly count if ft == 1 & gA > `gap1'
                local nl = r(N)
                drop ft
                local grp = inlist("`t'", "ev_lo", "ev_hi")
                if "`t'" == "ev_ref" {
                    post `h' ("`m'") (`v') (`o') ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl')
                }
                else if !`: list t in terms' | `nr' == 0 {
                    post `h' ("`m'") (`v') (`o') ("`t'") (`k') (`grp') (0) (.) (.) (.) (.) (.) (0) (0) (0) (0)
                }
                else {
                    local b  = _b[`t']
                    local se = _se[`t']
                    post `h' ("`m'") (`v') (`o') ("`t'") (`k') (`grp') (0) (`b') (`se') ///
                        (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                        (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl')
                }
            }
        }
        display "   `m' version `v': done"
    }
    * Identity check: value added per GJ = value added minus energy use (in logs), marker by marker.
    foreach t of local terms1 {
        assert reldif(b`m'1[1, "`t'"], b`m'4[1, "`t'"] - b`m'3[1, "`t'"]) < 1e-6 | abs(b`m'1[1, "`t'"]) < 1e-12
    }
}
postclose `h'
postclose `s'

*---------------------------------------------------------------------------
display "Step 5/7: percentages, labels and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
merge m:1 panel version outcome using `sums', nogenerate
gen str80 panel_label = cond(panel == "imp", "Starting to import", "Getting a foreign owner (10%+ of capital)")
gen str90 version_label = ""
replace version_label = "Main: repaired starts, doubtful energy records left out (drawn black)" if version == 1
replace version_label = "Every start and record as filed (drawn hollow gray)"                   if version == 2
replace version_label = "Repaired starts, doubtful energy records kept"                          if version == 3
replace version_label = "Repaired starts dated before the missing file, years before it only"   if version == 4
replace version_label = "Main sample, start years kept apart (Sun-Abraham, eventstudyinteract)" if version == 5
gen str40 outcome_label = ""
replace outcome_label = "ln(value added / GJ)"    if outcome == 1
replace outcome_label = "ln(value added / CO2)"   if outcome == 2
replace outcome_label = "ln(energy use, GJ)"      if outcome == 3
replace outcome_label = "ln(value added)"         if outcome == 4
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if term == "ev_lo"
replace column = "+`nout' or later (grouped)"      if term == "ev_hi"
replace column = "" if missing(term)
* % difference = 100 x (exp(b) - 1); interval ends converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
* Mirror (outcomes 1-2 only): energy or CO2 per unit of value added = -b.
gen double mirror_pct    = 100 * (exp(-b)  - 1) if inlist(outcome, 1, 2)
gen double mirror_pct_lo = 100 * (exp(-hi) - 1) if inlist(outcome, 1, 2)
gen double mirror_pct_hi = 100 * (exp(-lo) - 1) if inlist(outcome, 1, 2)
gen double avg_pct    = 100 * (exp(avg_b)  - 1)
gen double avg_pct_lo = 100 * (exp(avg_lo) - 1)
gen double avg_pct_hi = 100 * (exp(avg_hi) - 1)
gen int window_first = `wlo'
gen int window_last  = `whi'
* The repairs, repeated on every row of their panel: starts dated in the problem
* year as filed, and where they went (left out / later start year / never).
gen long problem_year_starts = cond(panel == "imp", `n_impbad', `n_fdibad')      if inlist(version, 1, 3, 4, 5)
gen long starts_left_out     = cond(panel == "imp", `n_impbad', 0)               if inlist(version, 1, 3, 4, 5)
gen long starts_redated      = cond(panel == "imp", 0, `n_fdibad_redated')       if inlist(version, 1, 3, 4, 5)
gen long moved_to_never      = cond(panel == "imp", 0, `n_fdibad_never')         if inlist(version, 1, 3, 4, 5)
assert problem_year_starts == starts_left_out + starts_redated + moved_to_never if inlist(version, 1, 3, 4, 5)
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference == 1
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "No starter row in this version" if !reference & missing(b) & !missing(term) & status == "ok"
gen byte porder = 1 + (panel == "fdi")
sort porder version outcome event_time
order panel panel_label version version_label outcome outcome_label status column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi mirror_pct mirror_pct_lo mirror_pct_hi firms rows firms_early firms_late ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_p avg_b avg_se avg_pct avg_pct_lo avg_pct_hi ///
      window_first window_last problem_year_starts starts_left_out starts_redated moved_to_never note
drop term porder avg_lo avg_hi
format b se lo hi avg_b avg_se %9.4f
format pct pct_lo pct_hi mirror_pct mirror_pct_lo mirror_pct_hi avg_pct avg_pct_lo avg_pct_hi %9.1f
format p before_p %9.3f
format firms rows firms_early firms_late n_rows n_firms n_starters n_comparison n_one_year_dropped problem_year_starts starts_left_out starts_redated moved_to_never %9.0f
tempfile res
save `res'
* The yearly shares behind the repairs go at the end of the same CSV.
use `shares', clear
gen str6 panel = "share"
gen str90 note = "Yearly share of firms importing (sh_imp) and with 10%+ foreign ownership (sh_fdi)"
format sh_imp sh_fdi %9.3f
append using `res'
gen byte porder = cond(panel == "imp", 1, cond(panel == "fdi", 2, 3))
sort porder version outcome event_time year
drop porder
order panel panel_label version version_label outcome outcome_label status column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi mirror_pct mirror_pct_lo mirror_pct_hi firms rows firms_early firms_late ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_p avg_b avg_se avg_pct avg_pct_lo avg_pct_hi ///
      window_first window_last problem_year_starts starts_left_out starts_redated moved_to_never year sh_imp sh_fdi file_rows note
export delimited using "tables/`fname'.csv", datafmt replace
list panel version column pct pct_lo pct_hi firms if outcome == 1 & inlist(version, 1, 2), noobs sepby(panel version) abbreviate(24) clean
list panel version outcome n_rows n_starters n_comparison before_p avg_pct avg_pct_lo avg_pct_hi status ///
    if event_time == 0, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 6/7: numbers for the panels and notes (read from the table, never typed)"
*---------------------------------------------------------------------------
drop if panel == "share"
keep if outcome == 1 & inlist(version, 1, 2)
foreach m in imp fdi {
    quietly summarize avg_pct if panel == "`m'" & version == 1
    local a = r(mean)
    quietly summarize avg_pct_lo if panel == "`m'" & version == 1
    local al = r(mean)
    quietly summarize avg_pct_hi if panel == "`m'" & version == 1
    local ah = r(mean)
    quietly summarize before_p if panel == "`m'" & version == 1
    local bp = r(mean)
    local bps = cond(`bp' < 0.001, "p < 0.001", "p = " + string(`bp', "%5.3f"))
    local bpw = cond(`bp' < 0.05, "a clear difference, a warning sign", "no clear difference")
    local clr = cond(`al' > 0 | `ah' < 0, "clear", "not clear")
    local avg_`m' = "Average of years 0 to +`whi': " + cond(`a' > 0, "+", "") + string(`a', "%9.0f") + "% (95% interval " ///
        + cond(`al' > 0, "+", "") + string(`al', "%9.0f") + "% to " + cond(`ah' > 0, "+", "") + string(`ah', "%9.0f") + "%, `clr')." ///
        + " Before the start: `bpw' (`bps')."
    * The same two numbers for the gray triangles (every start and record as filed).
    quietly summarize avg_pct if panel == "`m'" & version == 2
    local g = r(mean)
    quietly summarize avg_pct_lo if panel == "`m'" & version == 2
    local gl = r(mean)
    quietly summarize avg_pct_hi if panel == "`m'" & version == 2
    local gh = r(mean)
    quietly summarize before_p if panel == "`m'" & version == 2
    local gp = r(mean)
    local gps = cond(`gp' < 0.001, "p < 0.001", "p = " + string(`gp', "%5.3f"))
    local gpw = cond(`gp' < 0.05, "a clear difference, a warning sign", "no clear difference")
    local gclr = cond(`gl' > 0 | `gh' < 0, "clear", "not clear")
    local gry_`m' = "Gray triangles, as filed: average " + cond(`g' > 0, "+", "") + string(`g', "%9.0f") + "% (`gclr')." ///
        + " Before the start: `gpw' (`gps')."
    quietly summarize n_starters if panel == "`m'" & version == 1
    local ns = string(r(mean), "%9.0fc")
    quietly summarize n_comparison if panel == "`m'" & version == 1
    local nc = string(r(mean), "%9.0fc")
    if "`m'" == "imp" local ptl_`m' "(a) Starting to import: `ns' starters vs `nc' firms never seen importing"
    else              local ptl_`m' "(b) Getting a foreign owner (10%+): `ns' starters vs `nc' firms never seen foreign-owned"
}
* Shares quoted in the notes (whole %), from Step 1.
local s_i0 = string(100 * `shi0', "%9.0f")
local s_i1 = string(100 * `shi1', "%9.0f")
local s_f1 = string(100 * `shf1', "%9.0f")
local s_f0 = string(100 * `shf0', "%9.0f")
* The doubtful years as text: runs of consecutive files joined by a dash
* (the missing file counts as a break), e.g. "2017 and 2019–2022".
local runs ""
local r0 ""
local rp ""
foreach yy of local doubt_yrs {
    local nxt = `rp' + 1
    if "`r0'" != "" & `yy' == `nxt' local rp `yy'
    else {
        if "`r0'" != "" local runs `"`runs' "`=cond(`rp' > `r0', "`r0'–`rp'", "`r0'")'""'
        local r0 `yy'
        local rp `yy'
    }
}
local runs `"`runs' "`=cond(`rp' > `r0', "`r0'–`rp'", "`r0'")'""'
local nr : word count `runs'
local dtxt ""
forvalues j = 1/`nr' {
    local rj : word `j' of `runs'
    local sep = cond(`j' == 1, "", cond(`j' == `nr', " and ", ", "))
    local dtxt "`dtxt'`sep'`rj'"
}

*---------------------------------------------------------------------------
display "Step 7/7: two panels on one scale: main (black) and as filed (hollow gray)"
*---------------------------------------------------------------------------
gen double x = event_time
gen double xg = event_time - 0.26                        // as-filed marks sit just left of the black dot
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !reference & version == 1 & !missing(pct)
gen str9 reflbl = "reference" if reference & version == 1 & panel == "imp"
gen double refx = x - 0.2 if reference
* y-axis: one scale for both panels (black intervals and gray marks); 0 always inside.
quietly summarize pct_lo if version == 1
local ymin = min(r(min), 0)
quietly summarize pct_hi if version == 1
local ymax = max(r(max), 0)
quietly summarize pct if version == 2
local ymin = min(`ymin', r(min))
local ymax = max(`ymax', r(max))
local rng = `ymax' - `ymin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
if (`ytop' - `ybot')/`step' > 8 {                  // at most 8 steps: fewer, clearer labels
    local step = 2 * `step'
    local ybot = `step' * floor(`ymin'/`step')
    local ytop = `step' * ceil(`ymax'/`step')
}
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local span = `ytop' - `ybot'
local ycnt = `ybot' - 0.13 * `span'                      // row of starter counts, under the lowest gridline
local yavg = `ytop' + 0.27 * `span'                      // the panel's average, above the highest gridline
local ygry = `ytop' + 0.13 * `span'                      // the same for the gray triangles, one line lower
local xl = `wlo' - 2.6                                   // room for the "Starters" row name
local xr = `whi' + 1.6
* Starter counts behind each black dot, one row per panel inside the panel.
gen str8 nlbl = string(firms, "%9.0fc") if version == 1
gen double ycnt = `ycnt'
gen double yavg = `yavg'
gen double ygry = `ygry'
gen double xlft = `xl'
gen str12 cname = "Starters" if version == 1 & reference
gen str200 atxt = ""
replace atxt = "`avg_imp'" if version == 1 & reference & panel == "imp"
replace atxt = "`avg_fdi'" if version == 1 & reference & panel == "fdi"
gen str200 gtxt = ""
replace gtxt = "`gry_imp'" if version == 1 & reference & panel == "imp"
replace gtxt = "`gry_fdi'" if version == 1 & reference & panel == "fdi"
* x labels: years since the start (grouped ends as <= / >=).
local xlab ""
forvalues k = `=`wlo'-1'/`nout' {
    local s = cond(`k' > 0, "+", "") + string(`k')
    if `k' < `wlo' local s "≤ `k'"
    if `k' > `whi' local s "≥ +`k'"
    local xlab `"`xlab' `k' "`s'""'
}
* Reference lines as data, one row per panel: 0 line and start line.
gen double zl_y = 0       if reference & version == 1
gen double zl_x0 = `wlo' - 1.6 if reference & version == 1
gen double zl_x1 = `xr'   if reference & version == 1
gen double sl_x = -0.5    if reference & version == 1
gen double sl_y0 = `ybot' if reference & version == 1
gen double sl_y1 = `ytop' if reference & version == 1
gen byte pnum = 1 + (panel == "fdi")
label define pnl 1 "`ptl_imp'" 2 "`ptl_fdi'"
label values pnum pnl
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local txt "Notes: Start = first year a firm is seen importing (a), or with a foreign owner holding 10%+ of its capital (b), after a year"
local txt "`txt' seen without (it stays a starter if it stops later). Each black dot = starters' change since their year before the start, minus the same years' change among"
local txt "`txt' firms never seen importing (a) or never foreign-owned (b). Bars = 95% intervals; crossing 0 = no clear difference."
local txt "`txt' 'Before the start': p below 0.05 = starters were already changing differently (a warning sign). Black dots leave out records"
local txt "`txt' in doubt; gray triangles keep them: import starts dated `imp_bad' (importers rise from `s_i0'% of firms in `imp_prev' to `s_i1'% in"
local txt "`txt' `imp_bad', likely a recording change); all `fdi_bad' foreign-ownership answers (`s_f1'% of firms, about `s_f0'% in other years);"
local txt "`txt' importers with unknown export status in `dtxt' (energy records jump or drop far from other years). Value added ="
local txt "`txt' output value minus materials, energy and services bought (current prices); GJ = gigajoules. Timing, not proof of cause;"
local txt "`txt' firm links are fictional: a test of the method only."
local maxw 53.5                                         // widest note line that fits the 9-inch PDF
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
twoway (pcspike zl_y zl_x0 zl_y zl_x1, lcolor(gs8) lwidth(thin)) ///
    (pcspike sl_y0 sl_x sl_y1 sl_x, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if version == 1 & !reference, lcolor(black) lwidth(thin)) ///
    (scatter pct x if version == 1 & !reference & !grouped, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if version == 1 & grouped, msymbol(Oh) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct xg if version == 2 & !reference, msymbol(Th) msize(small) mcolor(gs8)) ///
    (scatter pct x if version == 1 & reference, msymbol(D) msize(small) mcolor(gs8)) ///
    (scatter pct refx if reflbl != "", msymbol(none) mlabel(reflbl) mlabposition(6) mlabgap(1.5) ///
        mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ycnt x if version == 1, msymbol(none) mlabel(nlbl) mlabposition(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter ycnt xlft if cname != "", msymbol(none) mlabel(cname) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yavg xlft if atxt != "", msymbol(none) mlabel(atxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ygry xlft if gtxt != "", msymbol(none) mlabel(gtxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    by(pnum, cols(1) iscale(1) imargin(small) ixaxes scale(`=7.5/9') ///
        title("Figure `exhibit'. Importing, foreign owners and energy efficiency", size(medium) position(11) justification(left) span) ///
        subtitle("Value added per GJ: % change since the year before the start, starters minus firms that never start", ///
            size(small) position(11) justification(left) span) ///
        note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
        legend(position(6)) graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none))) ///
    subtitle(, size(small) position(11) justification(left) nobox fcolor(white) lcolor(white) margin(b+1)) ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1)) ///
    xtitle("Years since the start (0 = start year)", size(vsmall) margin(t+1)) ///
    yscale(range(`ycnt' `yavg') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") ///
    legend(order(4 "Each single year (records in doubt left out)" 5 "Years `nout'+ before or after, combined" ///
                 7 "Year before the start (reference = 0)" 3 "95% interval" ///
                 6 "Every start and record as filed (nothing left out)" 1 "0 = no difference" 2 "Start (importing / foreign owner)") ///
        cols(2) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(9) ysize(12)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
