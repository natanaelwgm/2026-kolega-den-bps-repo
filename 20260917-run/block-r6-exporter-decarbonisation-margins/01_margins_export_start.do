/*==========================================================================
  R6-01  When a firm starts exporting, where does the change in its value
         added per tonne of CO2 (carbon productivity) come from? One row per
         part: value added, energy used, and CO2 per GJ of energy (the fuel
         and electricity mix), plus value added per GJ and output. All rows
         use the same firms and years, so the parts combine exactly:
         value added per tonne of CO2 = value added / energy used / CO2 per GJ.
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use".
  Output : figures/01_margins_export_start.png (+ .pdf)
           tables/01_margins_export_start.csv
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Checks : the start years, comparison group, usable rows, year window and
           model are R2's (block-r2 files 03 and 05), copied in the block
           "R6 EXPORT-START SAMPLE" below. When R2's tables are present next
           door, this file must reproduce them to 4 decimals or it stops:
           R2-02 (window), R2-03 (value added per GJ, incl. its average),
           R2-04 (per tonne of CO2), R2-05 (energy use, value added),
           R2-09 (output per GJ; versions without doubtful records),
           R2-08 (import starts). Parts = whole is asserted at every point.
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
* R2's block sits next to block-0; its tables are used only for the cross-checks
* (if the folder is not there, the checks are skipped and the file still runs).
global R2DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r2-internationalisation-energy-efficiency", 1)
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE ROWS: the parts of carbon productivity (all logs, same rows) ----
local exhibit "R6-01"
local fname   "01_margins_export_start"
local ftitle  "Carbon productivity after an export start, and its parts"
local y1 "ln(value_added_nominal / co2_total_s1)"       // (1) = (3) - (4) - (5): = Figure R2-04
local y2 "ln(value_added_nominal / total_gj_s1)"       // (2) = (3) - (4):       = Figure R2-03
local y3 "ln(value_added_nominal)"                     // (3) scale: value added  (R2-05)
local y4 "ln(total_gj_s1)"                             // (4) energy used, GJ     (R2-05)
local y5 "ln(co2_total_s1 / total_gj_s1)"              // (5) CO2 per GJ: moves only with the mix
local y6 "ln(gross_output_nominal)"                    // (6) scale: output
local y7 "ln(gross_output_nominal / total_gj_s1)"      // table only: output per GJ = (6) - (4) (= R2-09 row 2)
local nall 7                                           // outcomes estimated
local nmeas 6                                          // outcomes drawn (7 = table only)
local n1 "(1) Value added per tonne of CO2"             // chart row names (the question's "carbon productivity")
local n2 "(2) Value added per GJ of energy"
local n3 "(3) Value added"
local n4 "(4) Energy used, GJ"
local n5 "(5) CO2 per GJ of energy"
local n6 "(6) Output"
local n7 "Output per GJ of energy (table only)"
local r1 "equals (3) ÷ (4) ÷ (5)"                           // gray second line: how the row is made
local r2 "equals (3) ÷ (4)"
local r3 "current prices"
local r4 "fuels burned + bought electricity"
local r5 "moves only when the energy mix changes"
local r6 "current prices"
local w1 "value added per tonne of CO2"                 // words for the notes
local w2 "value added per GJ"
local w3 "value added"
local w4 "energy used"
local w5 "CO2 per GJ"
local w6 "output"
local w7 "output per GJ"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: the parts of value added per tonne of CO2 before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy, CO2, value added and output; check the add-ons"
*---------------------------------------------------------------------------
* The regressions need reghdfe (with ftools and require). Nothing is installed here.
foreach p in reghdfe ftools require {
    capture which `p'
    if _rc {
        display as error "This file needs the Stata add-on `p': type  ssc install `p'  once (see INDEX.md), then run it again."
        exit 199
    }
}
* export_flag             = any export activity (1 yes, 0 no, missing = unknown)
* import_flag             = imports raw materials (doubtful energy records; import-start version)
* total_gj_s1             = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1            = CO2 tonnes from the same fuels and electricity (standard rates, not measured)
* value_added_nominal     = value added, current prices (masked money unit)
* gross_output_nominal    = output (value of all goods made), current prices (masked money unit)
* energy_unit_gap_2018_19 = 1 on the years the file flags for an energy-unit gap (one version leaves them out)
use firm_id year export_flag import_flag total_gj_s1 co2_total_s1 value_added_nominal ///
    gross_output_nominal energy_unit_gap_2018_19 using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year

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
display "Step 3/8: the import-start version's sample (R2-08's repairs; table only)"
*---------------------------------------------------------------------------
* Firms that start importing vs firms never seen importing (R2-08's main sample):
* import starts dated `imp_bad' left out, doubtful energy records left out; its
* own year window by R2-02's rule. This version checks the one clear gain in R2.
use `fy', clear
keep if usable & !doubt & ((!missing(g_imp) & g_imp != `imp_bad') | key_imp == 9001)
replace gA     = g_imp
replace keyA   = key_imp
replace exactA = exact_imp
replace kA     = year - gA
gen byte never = missing(gA)
save `imps'
keep if !missing(gA)
gen byte early = gA < 2016
gen byte late  = gA > 2016
collapse (count) n = firm_id (max) early late, by(kA)
gen byte passes = n >= `minfirms' & early & late
assert passes if inlist(kA, -1, 0)
local Ki 0
local go 1
while `go' {
    local kk = `Ki' + 1
    quietly count if passes & inlist(kA, -`kk', `kk')
    if r(N) == 2 local Ki = `kk'
    else local go 0
}
local wlo_i = -`Ki'
local whi_i = `Ki'
display "   import starts: each year from `wlo_i' to +`whi_i' on its own"

*---------------------------------------------------------------------------
display "Step 4/8: the firms and rows behind each version, and the parts = whole check on the data"
*---------------------------------------------------------------------------
use `smp', clear
forvalues o = 1/`nall' {
    gen double y`o' = `y`o''
}
* The parts combine exactly on every row (logs): (1) = (3) - (4) - (5), (2) = (3) - (4), output per GJ = (6) - (4).
assert reldif(y1, y3 - y4 - y5) < 1e-9
assert reldif(y2, y3 - y4) < 1e-9
assert reldif(y7, y6 - y4) < 1e-9 if !missing(y6)
quietly count if missing(y6)
display "   usable rows with no output recorded (left out of the output rows only): " r(N)
egen byte ftag = tag(firm_id)
quietly count if ftag & !never
local nst0 = r(N)
quietly count if ftag & never
local ncf0 = r(N)
display "   " %6.0fc _N " usable rows; " %5.0fc `nst0' " starters dated; " %5.0fc `ncf0' " never-exporters"
drop ftag
* Years flagged for the energy-unit gap (version "no1819" leaves them out; read from the data).
quietly levelsof year if energy_unit_gap_2018_19 == 1, local(gapyrs)
local gapyrs_txt = subinstr("`gapyrs'", " ", " and ", .)
display "   years flagged for an energy-unit gap: `gapyrs_txt'"

*---------------------------------------------------------------------------
display "Step 5/8: estimate every row with firm and year fixed effects (clustered by firm), seven versions"
*---------------------------------------------------------------------------
* R2-03's model: log outcome on one marker per year since the start, removing each
* firm's own average (firm fixed effects) and each year's average (year fixed
* effects, set mostly by the comparison firms). A firm with one usable year cannot
* be compared with itself; reghdfe drops it and reports the number. b = log
* difference from the firm's year before the start, net of the comparison firms'
* change; % = 100 x (exp(b) - 1). Every row of a version uses the same firm-years,
* so the coefficients add up exactly (asserted below).
* Versions (the chart shows "main" and "nodoubt"; all are in the table):
*   main     = R2-03's sample exactly
*   nodoubt  = without doubtful energy records (Step 2)
*   no2017   = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact    = keeps only starters seen not exporting the year just before
*   no1819   = without the years flagged for an energy-unit gap (Step 4)
*   energywt = each firm weighted by its average energy use (big energy users
*              count more: closer to what happens to the industry's totals)
*   import   = firms that start importing vs never importers (Step 3; R2-08)
local nv 7
local v1 "main"
local v2 "nodoubt"
local v3 "no2017"
local v4 "exact"
local v5 "no1819"
local v6 "energywt"
local v7 "import"
local e1 "1"
local e2 "!doubt"
local e3 "gA != 2017"                                   // comparison firms (gA missing) stay
local e4 "missing(gA) | exactA == 1"
local e5 "energy_unit_gap_2018_19 != 1"
local e6 "1"
local e7 "1"
local wt6 "[aw = wgj]"
tempname h
postfile `h' byte outcome str8 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues s = 1/`nv' {
    if `s' < 7 use `smp', clear
    else       use `imps', clear
    keep if `e`s''
    * the version's year window
    if `s' < 7 {
        local lo_s = `wlo'
        local hi_s = `whi'
    }
    else {
        local lo_s = `wlo_i'
        local hi_s = `whi_i'
    }
    local wlo`s' = `lo_s'
    local whi`s' = `hi_s'
    forvalues o = 1/`nall' {
        gen double y`o' = `y`o''
    }
    * weight of version "energywt": the firm's average energy use (GJ) over its rows here
    by firm_id: egen double wgj = mean(total_gj_s1)
    * One marker per year since the start inside the window, except -1 (the year
    * before the start = the reference, 0 by definition), plus one marker for each
    * grouped end. Comparison firms are 0 on every marker. A marker with no starter
    * row in this version is left out (R2-08).
    gen byte ev_lo = !missing(kA) & kA < `lo_s'
    local cand "ev_lo"
    forvalues k = `lo_s'/`hi_s' {
        if `k' == -1 continue
        local nm = cond(`k' < 0, "ev_m" + string(-`k'), "ev_p" + string(`k'))
        gen byte `nm' = (kA == `k')
        local cand `cand' `nm'
    }
    gen byte ev_hi = !missing(kA) & kA > `hi_s'
    local cand `cand' ev_hi
    gen byte ev_ref = (kA == -1)                        // for the counts only
    local terms ""
    local pre ""
    local pre_in ""
    local post ""
    foreach t of local cand {
        quietly count if `t'
        if r(N) == 0 continue
        local terms `terms' `t'
        if "`t'" == "ev_lo" local pre `pre' `t'
        else if substr("`t'", 4, 1) == "m" {
            local pre `pre' `t'
            local pre_in `pre_in' `t'                   // years before the start, grouped end left out
        }
        else if "`t'" != "ev_hi" local post `post' `t'
    }
    local terms`s' `terms'
    local lc = subinstr("`post'", " ", " + ", .)        // years 0..+`hi_s', for the average
    local np : word count `post'
    forvalues o = 1/`nall' {
        quietly reghdfe y`o' `terms' `wt`s'', absorb(firm_id year) vce(cluster firm_id)
        matrix B`o'_`s' = e(b)
        local df = e(df_r)
        local N`o'_`s'  = e(N)
        local G`o'_`s'  = e(N_clust)
        local sg`o'_`s' = e(num_singletons)
        if `o' <= 5 assert e(N) == `N1_`s''             // rows 1-5: the same firm-years
        capture drop es
        gen byte es = e(sample)
        * Joint test: all years before the start (with and without the grouped end) are 0.
        quietly test `pre'
        local F`o'_`s'  = r(F)
        local Fd`o'_`s' = r(df)
        local Fp`o'_`s' = r(p)
        quietly test `pre_in'
        local Fq`o'_`s' = r(p)
        * Average over the start year and the years after it inside the window.
        quietly lincom (`lc') / `np'
        local a`o'_`s'  = r(estimate)
        local as`o'_`s' = r(se)
        local al`o'_`s' = r(estimate) - invttail(`df', 0.025) * r(se)
        local ah`o'_`s' = r(estimate) + invttail(`df', 0.025) * r(se)
        local ap`o'_`s' = 2 * ttail(`df', abs(r(estimate) / r(se)))
        egen byte ftag = tag(firm_id) if es
        quietly count if ftag == 1 & !never
        local st`o'_`s' = r(N)
        quietly count if ftag == 1 & never
        local cf`o'_`s' = r(N)
        drop ftag
        foreach t in `cand' ev_ref {
            if "`t'" == "ev_lo"       local k = `lo_s' - 1
            else if "`t'" == "ev_hi"  local k = `hi_s' + 1
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
            if "`t'" == "ev_ref" {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl') (`ny')
            }
            else if !`: list t in terms' {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (.) (.) (.) (.) (.) (0) (0) (0) (0) (0)
            }
            else {
                local b  = _b[`t']
                local se = _se[`t']
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (`b') (`se') ///
                    (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                    (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl') (`ny')
            }
        }
    }
    * Version "energywt": how concentrated the weights are. Effective number of firms
    * = (sum of weights)^2 / (sum of squared weights): the number of equal-weight
    * firms that would carry the same information. Few = the version is unstable.
    if "`v`s''" == "energywt" {
        quietly reghdfe y1 `terms' `wt`s'', absorb(firm_id year)
        egen byte ftw = tag(firm_id) if e(sample)
        foreach g in 0 1 {
            quietly summarize wgj if ftw == 1 & never == `g'
            local sw = r(sum)
            gen double w2 = wgj^2 if ftw == 1 & never == `g'
            quietly summarize w2
            local eff`g' = `sw'^2 / r(sum)
            drop w2
        }
        drop ftw
        local effst = string(`eff0', "%9.0f")
        local effcf = string(`eff1', "%9.0f")
        display "   energywt: its weights act like about `effst' starters and `effcf' never-exporters (effective numbers)"
    }
    * Parts = whole, marker by marker: (1) = (3) - (4) - (5); (2) = (3) - (4);
    * output per GJ = output - energy (when output has the same rows).
    foreach t of local terms {
        assert reldif(B1_`s'[1, "`t'"], B3_`s'[1, "`t'"] - B4_`s'[1, "`t'"] - B5_`s'[1, "`t'"]) < 1e-6
        assert reldif(B2_`s'[1, "`t'"], B3_`s'[1, "`t'"] - B4_`s'[1, "`t'"]) < 1e-6
        if `N6_`s'' == `N1_`s'' & `N7_`s'' == `N1_`s'' {
            assert reldif(B7_`s'[1, "`t'"], B6_`s'[1, "`t'"] - B4_`s'[1, "`t'"]) < 1e-6
        }
    }
    assert reldif(`a1_`s'', `a3_`s'' - `a4_`s'' - `a5_`s'') < 1e-6
    local pshow = cond(`Fp1_`s'' < 0.001, "< 0.001", "= " + string(`Fp1_`s'', "%5.3f"))
    display "   `v`s'': " %6.0fc `N1_`s'' " rows, " %5.0fc `G1_`s'' " firms (" `st1_`s'' " starters); per tonne of CO2 " ///
        %5.1f 100 * (exp(`a1_`s'') - 1) "% = value added " %5.1f 100 * (exp(`a3_`s'') - 1) "%, energy " ///
        %5.1f 100 * (exp(`a4_`s'') - 1) "%, CO2 per GJ " %5.1f 100 * (exp(`a5_`s'') - 1) "%; parts = whole checked"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 6/8: percentages, cross-checks with R2's tables, and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen str40 outcome_label = ""
gen str45 outcome_log   = ""
gen str40 identity      = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''" if outcome == `o'
    replace outcome_log   = "`y`o''" if outcome == `o'
}
replace identity = "(3) - (4) - (5) in logs; = Figure R2-04" if outcome == 1
replace identity = "(3) - (4) in logs; = Figure R2-03"       if outcome == 2
replace identity = "= Figure R2-05 value added"               if outcome == 3
replace identity = "= Figure R2-05 energy use"                if outcome == 4
replace identity = "(6) - (4) in logs; = R2-09 row 2"        if outcome == 7
gen str160 version_label = ""
replace version_label = "Main: all export starters vs never-exporters (R2-03's sample and model)"  if vorder == 1
replace version_label = "Without doubtful energy records (importers, export status unknown)"      if vorder == 2
replace version_label = "Without the 2017 starters (they may have started in 2016)"               if vorder == 3
replace version_label = "Only starters seen not exporting the year just before"                   if vorder == 4
replace version_label = "Without the years flagged for an energy-unit gap (`gapyrs_txt')"         if vorder == 5
replace version_label = "Each firm weighted by its average energy use (big users count more). Unstable: the weights act like about `effst' starters and `effcf' never-exporters; left out of the notes" if vorder == 6
replace version_label = "Import starts vs never-importers (R2-08's repairs; its own window)"       if vorder == 7
gen int window_first = .
gen int window_last  = .
forvalues s = 1/`nv' {
    replace window_first = `wlo`s'' if vorder == `s'
    replace window_last  = `whi`s'' if vorder == `s'
}
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = string(window_first - 1) + " or earlier (grouped)" if term == "ev_lo"
replace column = "+" + string(window_last + 1) + " or later (grouped)" if term == "ev_hi"
* % difference = 100 x (exp(b) - 1); the interval ends are converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
* Numbers for the whole outcome x version (repeated on each of its rows).
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_se avg_after_p ///
    avg_after_pct avg_after_pct_lo avg_after_pct_hi {
    gen double `v' = .
}
forvalues o = 1/`nall' {
    forvalues s = 1/`nv' {
        local c "outcome == `o' & vorder == `s'"
        quietly {
            replace n_rows              = `N`o'_`s''  if `c'
            replace n_firms             = `G`o'_`s''  if `c'
            replace n_starters          = `st`o'_`s'' if `c'
            replace n_comparison        = `cf`o'_`s'' if `c'
            replace n_one_year_dropped  = `sg`o'_`s'' if `c'
            replace before_F            = `F`o'_`s''  if `c'
            replace before_df           = `Fd`o'_`s'' if `c'
            replace before_p            = `Fp`o'_`s'' if `c'
            replace before_p_no_grouped = `Fq`o'_`s'' if `c'
            replace avg_after_b         = `a`o'_`s''  if `c'
            replace avg_after_se        = `as`o'_`s'' if `c'
            replace avg_after_p         = `ap`o'_`s'' if `c'
            replace avg_after_pct       = 100 * (exp(`a`o'_`s'')  - 1) if `c'
            replace avg_after_pct_lo    = 100 * (exp(`al`o'_`s'') - 1) if `c'
            replace avg_after_pct_hi    = 100 * (exp(`ah`o'_`s'') - 1) if `c'
        }
    }
}
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
* ---- Cross-checks with R2's tables (when present): stop on any mismatch ----
* Each spec: R2 table | its outcome number (0 = one-outcome table) | this file's
* outcome | versions compared (R2's names = ours) | how R2's b is built.
* R2-05's CO2 row = this file's (4) + (5) (CO2 = energy x CO2 per GJ).
gen double b_r2 = .
gen str60 r2_check = ""
local nck 0
foreach spec in "03_energy_efficiency_export_start|0|2|main no2017 exact" ///
                "04_co2_efficiency_export_start|0|1|main no2017 exact" ///
                "05_energy_co2_va_export_start|1|4|main no2017 exact" ///
                "05_energy_co2_va_export_start|3|3|main no2017 exact" ///
                "09_other_efficiency_measures|1|2|nodoubt" ///
                "09_other_efficiency_measures|3|1|nodoubt" ///
                "09_other_efficiency_measures|2|7|main no2017 exact nodoubt" {
    gettoken tf rest : spec, parse("|")
    gettoken bar rest : rest, parse("|")
    gettoken ro rest : rest, parse("|")
    gettoken bar rest : rest, parse("|")
    gettoken mo rest : rest, parse("|")
    gettoken bar vs : rest, parse("|")
    capture confirm file "$R2DIR/tables/`tf'.csv"
    if _rc {
        display "   $R2DIR/tables/`tf'.csv not found: cross-check skipped"
        continue
    }
    preserve
    import delimited using "$R2DIR/tables/`tf'.csv", clear varnames(1)
    if `ro' > 0 keep if outcome == `ro'
    gen byte keepv = 0
    foreach v of local vs {
        replace keepv = 1 if version == "`v'"
    }
    keep if keepv
    keep version event_time b avg_after_b
    rename (b avg_after_b) (fig_b fig_avg)
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == `mo'
    gen byte keepv = 0
    foreach v of local vs {
        replace keepv = 1 if version == "`v'"
    }
    keep if keepv
    quietly merge 1:1 version event_time using `fig'
    quietly count if _merge != 3 | abs(b - fig_b) > 0.00005 + 1e-9 | abs(avg_after_b - fig_avg) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "$R2DIR/tables/`tf'.csv does not match this file (outcome `mo'; versions `vs'): the R6 sample no longer equals R2's."
        exit 459
    }
    quietly count
    display "   `tf'.csv (outcome `ro'): all " r(N) " coefficients and the averages reproduced to 4 decimals"
    restore
    replace r2_check = strtrim(r2_check + " `tf'") if outcome == `mo' & strpos(" `vs' ", " " + version + " ")
    local ++nck
}
* R2-05's CO2 row = (4) + (5), per version.
capture confirm file "$R2DIR/tables/05_energy_co2_va_export_start.csv"
if !_rc {
    preserve
    keep if inlist(outcome, 4, 5) & inlist(version, "main", "no2017", "exact")
    keep outcome version event_time b avg_after_b
    reshape wide b avg_after_b, i(version event_time) j(outcome)
    gen double co2_b   = b4 + b5
    gen double co2_avg = avg_after_b4 + avg_after_b5
    tempfile mine
    save `mine'
    import delimited using "$R2DIR/tables/05_energy_co2_va_export_start.csv", clear varnames(1)
    keep if outcome == 2 & inlist(version, "main", "no2017", "exact")
    keep version event_time b avg_after_b
    quietly merge 1:1 version event_time using `mine'
    quietly count if _merge != 3 | abs(co2_b - b) > 0.0001 + 1e-9 | abs(co2_avg - avg_after_b) > 0.0001 + 1e-9
    if r(N) > 0 {
        display as error "R2-05's CO2 row is not energy used + CO2 per GJ here: the R6 sample no longer equals R2's."
        exit 459
    }
    display "   R2-05 CO2 row = energy used + CO2 per GJ at every point"
    restore
}
* R2-08's import panel (version 1): its outcomes 1-4 = this file's 2, 1, 4, 3.
capture confirm file "$R2DIR/tables/08_efficiency_import_foreign_start.csv"
if !_rc {
    preserve
    import delimited using "$R2DIR/tables/08_efficiency_import_foreign_start.csv", clear varnames(1)
    keep if panel == "imp" & version == 1 & !missing(b)
    gen byte mo = cond(outcome == 1, 2, cond(outcome == 2, 1, cond(outcome == 3, 4, 3)))
    keep mo event_time b avg_b
    rename (mo b avg_b) (outcome fig_b fig_avg)
    tempfile fig
    save `fig'
    restore, preserve
    keep if version == "import" & inrange(outcome, 1, 4) & !missing(b)
    quietly merge 1:1 outcome event_time using `fig'
    quietly count if _merge != 3 | abs(b - fig_b) > 0.00005 + 1e-9 | abs(avg_after_b - fig_avg) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "R2-08's import panel does not match this file's import version: the samples differ."
        exit 459
    }
    quietly count
    display "   08_efficiency_import_foreign_start.csv (import panel): all " r(N) " coefficients and averages reproduced"
    restore
    replace r2_check = strtrim(r2_check + " 08_efficiency_import_foreign_start") if version == "import" & inrange(outcome, 1, 4)
}
drop b_r2
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before " + string(window_first) + "; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +" + string(window_last) + "; each firm counted once" if term == "ev_hi"
replace note = "No starter row in this version: marker left out" if missing(b) & !reference
sort outcome vorder event_time
order outcome outcome_label outcome_log identity version version_label column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_se avg_after_p avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
      window_first window_last r2_check note
drop term vorder
format b se lo hi avg_after_b avg_after_se before_F %9.4f
format pct pct_lo pct_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi %9.1f
format p before_p before_p_no_grouped avg_after_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
tempfile full                                         // full precision, for the companion tables (Step 8)
save `full'
export delimited using "tables/`fname'.csv", datafmt replace
set linesize 220                                      // one line per row in the log listing
list outcome version avg_after_pct avg_after_pct_lo avg_after_pct_hi avg_after_p before_p ///
    n_rows n_starters n_comparison if column == "0", noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 7/8: one row per part (average of years 0 to +`whi'), main and without doubtful records"
*---------------------------------------------------------------------------
keep if reference & outcome <= `nmeas'
keep outcome version avg_after_pct avg_after_pct_lo avg_after_pct_hi avg_after_p before_p ///
     n_rows n_starters n_comparison
* Numbers for the notes, read from the table (never typed).
gen byte clear = avg_after_pct_lo > 0 | avg_after_pct_hi < 0          // interval does not cross 0
gen byte sgn   = cond(avg_after_pct > 0, 1, -1)
* A short text per outcome and version: "+10% (95% interval -6% to +30%)".
gen str60 ptxt = cond(avg_after_pct > 0, "+", "") + string(round(avg_after_pct), "%9.0f") + "%"
gen str60 itxt = ptxt + " (95% interval " + cond(avg_after_pct_lo > 0, "+", "") + string(round(avg_after_pct_lo), "%9.0f") ///
    + "% to " + cond(avg_after_pct_hi > 0, "+", "") + string(round(avg_after_pct_hi), "%9.0f") + "%)"
forvalues o = 1/`nmeas' {
    foreach v in main nodoubt no2017 exact no1819 energywt import {
        quietly levelsof itxt if outcome == `o' & version == "`v'", local(tt) clean
        local it`o'`v' "`tt'"
        quietly levelsof ptxt if outcome == `o' & version == "`v'", local(tt) clean
        local pt`o'`v' "`tt'"
        quietly summarize clear if outcome == `o' & version == "`v'"
        local cl`o'`v' = r(mean)
        quietly summarize sgn if outcome == `o' & version == "`v'"
        local sg`o'`v' = r(mean)
    }
}
* (a) the question's rows first: carbon productivity (1) and energy productivity (2)
local q1 = cond(`cl1main', "clearly different from 0", "not clearly different from 0")
local q2 = cond(`cl2main', "clear", "not clear either")
if `cl1main' != `cl2main' local q2 = cond(`cl2main', "clear", "not clear")
local headtxt "After the start, `w1' changes by `it1main', `q1'; `w2' by `pt2main', `q2'."
* (b) the parts (3)-(6) that are clearly different from 0
local nclr 0
forvalues o = 3/`nmeas' {
    if `cl`o'main' {
        local ++nclr
        local clr`nclr' "`w`o'' (`pt`o'main')"
    }
}
local clrtxt ""
forvalues j = 1/`nclr' {
    local sep = cond(`j' == 1, "", cond(`j' == `nclr', " and ", ", "))
    local clrtxt "`clrtxt'`sep'`clr`j''"
}
if `nclr' == 0 local parttxt "None of the parts is clearly different from 0."
else local parttxt "Clearly different from 0 among the parts: `clrtxt'."
* (c) before-start check (main): parts already changing differently before the start
local nfail 0
forvalues o = 1/`nmeas' {
    quietly summarize before_p if outcome == `o' & version == "main"
    if r(mean) < 0.05 {
        local ++nfail
        local fail`nfail' "`w`o''"
    }
}
local failtxt ""
forvalues j = 1/`nfail' {
    local sep = cond(`j' == 1, "", cond(`j' == `nfail', " and ", ", "))
    local failtxt "`failtxt'`sep'`fail`j''"
}
if `nfail' == 0 local btxt "Before the start, no row differed clearly (right column; p below 0.05 would be a warning)."
else local btxt "Warning: `failtxt' already differed before the start (right column, p below 0.05), so later dots may partly continue that."
* (d) how many answers (clear or not; direction when clear) change in the other
* versions: without doubtful records (drawn hollow gray) and three in the table.
* The energy-weighted version is left out: its weights sit on a handful of firms
* (effective numbers in its CSV label), so its intervals are too wide to count.
local vs_nodoubt "without doubtful records"
local vs_no2017  "without the 2017 starters"
local vs_exact   "only starters seen not exporting the year before"
local vs_no1819  "without `gapyrs_txt'"
local nlost 0
local ngain 0
local nflip 0
local nother 0
local losttxt ""
local gaintxt ""
local fliptxt ""
foreach v in nodoubt no2017 exact no1819 {
    local ++nother
    forvalues o = 1/`nmeas' {
        if `cl`o'main' == 1 & `cl`o'`v'' == 0 {
            local losttxt = "`losttxt'" + cond(`nlost' > 0, "; ", "") + "`w`o'', `vs_`v''"
            local ++nlost
        }
        if `cl`o'main' == 0 & `cl`o'`v'' == 1 {
            local gaintxt = "`gaintxt'" + cond(`ngain' > 0, "; ", "") + "`w`o'', `vs_`v''"
            local ++ngain
        }
        if `cl`o'main' == 1 & `cl`o'`v'' == 1 & `sg`o'main' != `sg`o'`v'' {
            local fliptxt = "`fliptxt'" + cond(`nflip' > 0, "; ", "") + "`w`o'', `vs_`v''"
            local ++nflip
        }
    }
}
local nothers = `nother' - 1
local dtxt "Hollow gray dots leave out importers of unknown export status in years their energy records jump or drop."
local vtxt = "Leaving them out, or using `nothers' other versions (table): " ///
    + cond(`nlost' == 0, "no clear answer becomes", "`nlost' clear answer" + cond(`nlost' == 1, " becomes", "s become")) + " unclear" ///
    + cond(`nlost' > 0, " (`losttxt')", "") + "; " ///
    + cond(`ngain' == 0, "no unclear answer becomes", "`ngain' unclear answer" + cond(`ngain' == 1, " becomes", "s become")) + " clear" ///
    + cond(`ngain' > 0, " (`gaintxt')", "") ///
    + cond(`nflip' > 0, "; `nflip' clear answer" + cond(`nflip' == 1, "", "s") + " change direction (`fliptxt')", "") + "."
* (e) import starts (table only): rows 1 and 4
local imptxt = "Firms that start importing (table): `w1' `pt1import' (" + cond(`cl1import', "clear", "not clear") ///
    + "), energy used `pt4import' (" + cond(`cl4import', "clear", "not clear") + ")."
display "   `headtxt'"
display "   `parttxt'"
display "   `btxt'"
display "   `dtxt'"
display "   `vtxt'"
display "   `imptxt'"
* Plot rows: (1)-(2) the question, (3)-(5) its parts, (6) output; gaps between groups.
gen double ypos = .
replace ypos = 9.0 if outcome == 1
replace ypos = 8.0 if outcome == 2
replace ypos = 6.6 if outcome == 3
replace ypos = 5.6 if outcome == 4
replace ypos = 4.6 if outcome == 5
replace ypos = 3.2 if outcome == 6
gen double yalt = ypos - 0.26                           // hollow gray: just under its row
* x-axis: a round step that grows with the numbers; 0 always inside.
quietly summarize avg_after_pct_lo if version == "main"
local xmin = min(r(min), 0)
quietly summarize avg_after_pct_hi if version == "main"
local xmax = max(r(max), 0)
quietly summarize avg_after_pct if inlist(version, "main", "nodoubt")
local xmin = min(`xmin', r(min))
local xmax = max(`xmax', r(max))
local rng = `xmax' - `xmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
if `rng'/`step' > 6       local step = `step'*2         // at most about 5 labels: the axis is narrow here
local xbot = `step' * floor(`xmin'/`step')
local xtop = `step' * ceil(`xmax'/`step')
local xfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local span = `xtop' - `xbot'
* Layout left to right (x-axis units): row names, the dots (xbot..xtop, the only
* part with an axis), then one column: the before-start check.
local xn  = `xbot' - 1.45 * `span'                      // row names start here (left-aligned)
local xc3 = `xtop' + 0.45 * `span'                      // column: before-start check (left-aligned)
local xr  = `xtop' + 1.00 * `span'
gen double xnm = `xn'
gen double xc3 = `xc3'
gen double ysub = ypos - 0.42
local nb = uchar(160)                                   // no-break space: "< 0.001" stays together
gen str24 c3 = cond(before_p < 0.001, "<`nb'0.001", string(before_p, "%5.3f")) if version == "main"
replace c3 = c3 + ", differs" if version == "main" & before_p < 0.05
gen double pr = round(avg_after_pct)
gen str8 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") + "%" if version == "main"
gen str60 nm  = ""
gen str70 sub = ""
forvalues o = 1/`nmeas' {
    replace nm  = "`n`o''" if outcome == `o' & version == "main"
    replace sub = "`r`o''" if outcome == `o' & version == "main"
}
gen str8 hdr = "Measure" if _n == 1
local yh = 9.0 + 0.9                                    // column headers, above the first row
gen double yhdr = `yh'
quietly summarize n_starters if version == "main" & outcome == 1
local nst = string(r(mean), "%9.0fc")
quietly summarize n_comparison if version == "main" & outcome == 1
local ncf = string(r(mean), "%9.0fc")
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local txt "Notes: `headtxt' `parttxt' Starters = firms first seen exporting after a year seen not exporting (`nst';"
local txt "`txt' they stay starters if they stop); never-exporters = firms never seen exporting (`ncf'). Each dot = starters'"
local txt "`txt' change since the year before the start minus never-exporters' change, averaged over years 0 to +`whi';"
local txt "`txt' bars = 95% intervals. All rows use the same firm-years, so they combine exactly as written under their names."
local txt "`txt' `btxt' `dtxt' `vtxt' `imptxt' CO2 = energy used x standard rates, not measured. Value added = output minus"
local txt "`txt' materials, energy and services bought (current prices); GJ = gigajoules. Shows timing, not which part caused"
local txt "`txt' what; firm links are fictional: this tests the method, not a finding."
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
twoway (pci 2.7 0 9.5 0, lcolor(gs8) lwidth(thin)) ///
    (rspike avg_after_pct_hi avg_after_pct_lo ypos if version == "main", horizontal lcolor(black) lwidth(thin)) ///
    (scatter ypos avg_after_pct if version == "main", msymbol(O) msize(small) mcolor(black)) ///
    (scatter yalt avg_after_pct if version == "nodoubt", msymbol(Oh) msize(small) mcolor(gs8)) ///
    (scatter ypos avg_after_pct_hi if version == "main", msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) ///
        mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnm if version == "main", msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xnm if version == "main" & sub != "", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) ///
        mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc3 if version == "main", msymbol(none) mlabel(c3) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter yhdr xnm if hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    text(`yh' `xc3' "Before the start, p", size(vsmall) placement(e)) ///
    yscale(range(2.6 10.1) off) ylabel(, nogrid) ytitle("") ///
    xscale(range(`xn' `xr') noline) ///
    xlabel(`xbot'(`step')`xtop', labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`xfmt')) ///
    xtitle("") ///
    legend(order(3 "Average of years 0 to +`whi' (each year counts equally)" 4 "Without doubtful energy records (hollow gray)" ///
                 2 "95% interval" 1 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
    subtitle("% change after the start (years 0 to +`whi'), starters minus never-exporters", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    xsize(9) ysize(8.5) scale(`=7.5/8.5')                   // text as in R2-03 (9 x 7.5 in)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the dots"
*---------------------------------------------------------------------------
* Both tables use the numbers saved in Step 6 just before the CSV (full precision,
* so a 4-decimal CSV value is never rounded twice), after the chart is saved.
* Written with putpdf (built into Stata; no add-on).
local ptab "tables/`fname'_table.pdf"
local rtab "tables/`fname'_regression.pdf"
local tfont "Times New Roman"
use `full', clear                                     // = the CSV, before rounding to 4 decimals
tempfile csv
save `csv'
* ---- (a) every plotted point, in chart order (row by row, black dot then hollow gray) ----
keep if reference == 1 & outcome <= `nmeas' & inlist(version, "main", "nodoubt")
gen byte vo = cond(version == "main", 1, 2)
sort outcome vo
local np = _N
assert `np' == 2 * `nmeas'                              // every drawn dot, once
local ncol 10
putpdf clear
putpdf begin, pagesize(letter) landscape font("`tfont'", 9) margin(all, 0.6in)
putpdf paragraph, spacing(after, 6pt)
putpdf text ("Table `exhibit'. `ftitle': every plotted point"), bold font("`tfont'", 11)
matrix PW = (18, 27, 6, 5, 5, 5, 9, 7, 7, 11)
putpdf table P = (`=`np' + 1', `ncol'), border(all, nil) width(PW)
local c 0
foreach h in "Row on the chart" "Series (legend)" "% change (dot)" "95% low" "95% high" "Starters" ///
    "Never-exporters" "Rows (firm-years)" "Before the start, p" "Status" {
    local ++c
    local al = cond(inlist(`c', 1, 2, 10), "left", "right")
    putpdf table P(1, `c') = ("`h'"), halign(`al')
}
forvalues i = 1/`np' {
    local r = `i' + 1
    local o = outcome[`i']
    local isn = version[`i'] == "main"
    local ser = cond(`isn', "Average of years 0 to +`whi' (each year counts equally)", "Without doubtful energy records (hollow gray)")
    local st  = cond(`isn', "black dot, 95% bar", "hollow gray, no bar")
    local f1 = cond(avg_after_pct[`i'] > 0, "+", "") + string(avg_after_pct[`i'], "%9.1f")
    local f2 = string(avg_after_pct_lo[`i'], "%9.1f")
    local f3 = string(avg_after_pct_hi[`i'], "%9.1f")
    local f4 = string(n_starters[`i'], "%9.0fc")
    local f5 = string(n_comparison[`i'], "%9.0fc")
    local f6 = string(n_rows[`i'], "%9.0fc")
    local f7 = cond(before_p[`i'] < 0.001, "< 0.001", string(before_p[`i'], "%5.3f"))
    putpdf table P(`r', 1) = ("`n`o''"), halign(left)
    putpdf table P(`r', 2) = ("`ser'"), halign(left)
    putpdf table P(`r', 3) = ("`f1'"), halign(right)
    putpdf table P(`r', 4) = ("`f2'"), halign(right)
    putpdf table P(`r', 5) = ("`f3'"), halign(right)
    putpdf table P(`r', 6) = ("`f4'"), halign(right)
    putpdf table P(`r', 7) = ("`f5'"), halign(right)
    putpdf table P(`r', 8) = ("`f6'"), halign(right)
    putpdf table P(`r', 9) = ("`f7'"), halign(right)
    putpdf table P(`r', 10) = ("`st'"), halign(left)
}
forvalues j = 1/`ncol' {
    putpdf table P(., `j'), margin(top, 0pt) margin(bottom, 0pt)     // tight rows (built-in cell margins)
}
putpdf table P(1, .), border(top, single) border(bottom, single)
putpdf table P(`=`np' + 1', .), border(bottom, single)
putpdf paragraph, font("`tfont'", 8) spacing(before, 6pt)
putpdf text ("% change = 100 x (exp(b) - 1) of the average coefficient over years 0 to +`whi' (the chart label rounds it to a whole number). ")
putpdf text ("Starters and never-exporters = firms in the estimate (firms with one usable year are dropped). The regressions behind each dot: `rtab'.")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`txt'")                                  // the chart's notes, unwrapped
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("`tfont'", 8)
putpdf text ("`devnote'")
putpdf save "`ptab'", replace
display "   table -> `ptab' (`np' plotted points)"
* ---- (b) the regressions behind the dots: one column per chart row, panel A = black
* dots (main), panel B = hollow gray dots (without doubtful records) ----
use `csv', clear
keep if outcome <= `nmeas' & inlist(version, "main", "nodoubt")
sort version outcome event_time
quietly levelsof event_time, local(evs)
local nev : word count `evs'
local nstat 11                                          // summary rows under the coefficients
local nrr = 1 + `nev' + `nstat'                   // b and (se) share one cell
putpdf clear
putpdf begin, pagesize(letter) landscape font("`tfont'", 8) margin(left, 0.6in) margin(right, 0.6in) margin(top, 0.3in) margin(bottom, 0.3in)
local pan 0
foreach v in main nodoubt {
    local ++pan
    if `pan' == 2 putpdf pagebreak
    local ptitle = cond("`v'" == "main", "Panel A. Black dots: R2-03's sample (all starters and never-exporters)", ///
        "Panel B. Hollow gray dots: without doubtful energy records (importers of unknown export status)")
    putpdf paragraph, spacing(after, 4pt)
    putpdf text ("Table `exhibit' (regressions). `ftitle': the regressions behind each dot"), bold font("`tfont'", 11)
    putpdf paragraph, spacing(after, 4pt)
    putpdf text ("`ptitle'"), italic
    matrix RW = (28, 12, 12, 12, 12, 12, 12)
    putpdf table R = (`nrr', 7), border(all, nil) width(RW)
    putpdf table R(1, 1) = ("Years since the export start"), halign(left)
    forvalues o = 1/`nmeas' {
        putpdf table R(1, `=`o' + 1') = ("`n`o''"), halign(right)
    }
    local r 1
    foreach e of local evs {
        local ++r
        local lab = cond(`e' > 0, "+", "") + string(`e')
        if `e' == `wlo' - 1 local lab "≤ `e' (grouped)"
        if `e' == `whi' + 1 local lab "≥ +`e' (grouped)"
        if `e' == -1 local lab "-1 (reference)"
        putpdf table R(`r', 1) = ("`lab'"), halign(left)
        forvalues o = 1/`nmeas' {
            quietly summarize b if version == "`v'" & outcome == `o' & event_time == `e'
            local bb = r(mean)
            quietly summarize se if version == "`v'" & outcome == `o' & event_time == `e'
            local ss = r(mean)
            if `e' == -1 {
                putpdf table R(`r', `=`o' + 1') = ("0 (reference)"), halign(right)
            }
            else {
                putpdf table R(`r', `=`o' + 1') = ("`=string(`bb', "%9.3f")'"), halign(right) linebreak
                putpdf table R(`r', `=`o' + 1') = ("(`=string(`ss', "%9.3f")')"), append
            }
        }
    }
    * summary rows (the same model run as the coefficients)
    local s1 "Average of years 0 to +`whi' (the dot), b"
    local s2 "  standard error"
    local s3 "  as % change = 100 x (exp(b) - 1) [95% interval]"
    local s4 "Before the start, joint test p"
    local s5 "Observations (firm-years)"
    local s6 "Firms (clusters): starters + never-exporters"
    local s7 "Firm fixed effects"
    local s8 "Year fixed effects"
    local s9 "Industry x year, province x year"
    local s10 "Weights"
    local s11 "Standard errors"
    forvalues k = 1/`nstat' {
        local rr = 1 + `nev' + `k'
        putpdf table R(`rr', 1) = ("`s`k''"), halign(left)
        forvalues o = 1/`nmeas' {
            quietly summarize avg_after_b if version == "`v'" & outcome == `o'
            local ab = r(mean)
            quietly summarize avg_after_se if version == "`v'" & outcome == `o'
            local as = r(mean)
            quietly summarize avg_after_pct if version == "`v'" & outcome == `o'
            local apc = r(mean)
            quietly summarize avg_after_pct_lo if version == "`v'" & outcome == `o'
            local apl = r(mean)
            quietly summarize avg_after_pct_hi if version == "`v'" & outcome == `o'
            local aph = r(mean)
            quietly summarize before_p if version == "`v'" & outcome == `o'
            local bp = r(mean)
            quietly summarize n_rows if version == "`v'" & outcome == `o'
            local nr = r(mean)
            quietly summarize n_firms if version == "`v'" & outcome == `o'
            local nf = r(mean)
            quietly summarize n_starters if version == "`v'" & outcome == `o'
            local ns = r(mean)
            quietly summarize n_comparison if version == "`v'" & outcome == `o'
            local nc = r(mean)
            if `k' == 1  local cell = string(`ab', "%9.3f")
            if `k' == 2  local cell = "(" + string(`as', "%9.3f") + ")"
            if `k' == 3  local cell = cond(`apc' > 0, "+", "") + string(`apc', "%9.1f") + " [" + string(`apl', "%9.1f") + ", " + string(`aph', "%9.1f") + "]"
            if `k' == 4  local cell = cond(`bp' < 0.001, "< 0.001", string(`bp', "%5.3f"))
            if `k' == 5  local cell = string(`nr', "%9.0fc")
            if `k' == 6  local cell = string(`nf', "%9.0fc") + " (" + string(`ns', "%9.0fc") + " + " + string(`nc', "%9.0fc") + ")"
            if `k' == 7  local cell "Yes"
            if `k' == 8  local cell "Yes"
            if `k' == 9  local cell "No"
            if `k' == 10 local cell "None"
            if `k' == 11 local cell "By firm"
            putpdf table R(`rr', `=`o' + 1') = ("`cell'"), halign(right)
        }
    }
    forvalues j = 1/7 {
        putpdf table R(., `j'), margin(top, 0pt) margin(bottom, 0pt) // tight rows: one page per panel
    }
    putpdf table R(1, .), border(top, single) border(bottom, single)
    putpdf table R(`=1 + `nev'', .), border(bottom, single)
    putpdf table R(`nrr', .), border(bottom, single)
    * Notes once (under Panel A), Source and development-data line under Panel B:
    * each panel with its footer then fits one landscape page.
    putpdf paragraph, font("`tfont'", 8) spacing(before, 3pt)
    if `pan' == 2 {
        putpdf text ("`srcnote' `devnote'")
        continue
    }
    putpdf text ("Notes (both panels): log of the row's measure on one marker per year since the export start (`wlo' to +`whi'; ends grouped; ")
    putpdf text ("-1 = reference), with firm and year fixed effects; never-exporters are 0 on every marker. Log points; standard errors ")
    putpdf text ("clustered by firm in parentheses; no stars. Average of years 0 to +`whi' = the dot on Figure `exhibit'; (1) = (3) - (4) - (5) ")
    putpdf text ("and (2) = (3) - (4) exactly. Other versions (energy-weighted one unstable): tables/`fname'.csv.")
}
putpdf save "`rtab'", replace
display "   table -> `rtab' (" 2 * `nmeas' " regressions, `nev' years since the start each)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
