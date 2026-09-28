/*==========================================================================
  R2-09  Does Figure R2-03's answer hold for the previous paper's other
         efficiency measures? After firms start exporting: output (instead
         of value added) per GJ and per tonne of CO2, and value added per GJ
         of bought electricity and per GJ of fuels. Value added per GJ
         (Figure R2-03) and per tonne of CO2 (Figure R2-04) are repeated as
         reference rows, so all six of the previous paper's measures are on
         one scale.
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya hanya
         Ganti tahun" (its six outcomes ln_va_per_gj_s1, ln_output_per_gj_s1,
         ln_va_per_co2_s1, ln_output_per_co2_s1, ln_va_per_elec_gj_s1,
         ln_va_per_fuel_gj_s1; firm and year fixed effects; standard errors
         clustered by firm).
  Output : figures/09_other_efficiency_measures.png (+ .pdf)
           tables/09_other_efficiency_measures.csv
           tables/09_other_efficiency_measures_table.pdf (every plotted point)
           tables/09_other_efficiency_measures_regression.pdf (one column per measure)
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Checks : the year window (R2-02's rule, computed here) against
           tables/02_event_time_support.csv when present; rows 1 and 3
           against tables/03_... and tables/04_... when present; output rows
           = value-added rows + output per unit of value added (exact).
           Each average is also measured against the average of all single
           years before the start (not only the year just before): CSV
           columns avg_vs_before_*.
  Template: R2-03 (Steps 1-3 as R2-03 with only rule A, as R2-08; Step 4-5
           loop over the measures as R2-05); chart = R2-07's one row per estimate.
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

* ---- THE MEASURES: the previous paper's six, in its order (one chart row each) ----
local exhibit "R2-09"
local fname   "09_other_efficiency_measures"
local y1 "ln(value_added_nominal / total_gj_s1)"      // = Figure R2-03
local y2 "ln(gross_output_nominal / total_gj_s1)"
local y3 "ln(value_added_nominal / co2_total_s1)"     // = Figure R2-04
local y4 "ln(gross_output_nominal / co2_total_s1)"
local y5 "ln(value_added_nominal / gj_electricity)"   // bought electricity only
local y6 "ln(value_added_nominal / gj_fuel_s1)"       // the nine fuels burned
local y7 "ln(gross_output_nominal / value_added_nominal)"  // helper, table only: output rows = value-added rows + this
local y8 "ln(gj_electricity)"                         // helper, table only: row 5 = value added minus this
local y9 "ln(gj_fuel_s1)"                             // helper, table only: row 6 = value added minus this
local n1 "Value added per GJ of energy"                // chart row names
local n2 "Output per GJ of energy"
local n3 "Value added per tonne of CO2"
local n4 "Output per tonne of CO2"
local n5 "Value added per GJ of bought electricity"
local n6 "Value added per GJ of fuels"
local n7 "Output per unit of value added (helper)"
local n8 "Bought electricity used, GJ (helper)"
local n9 "Fuels burned, GJ (helper)"
local nall 9                                           // measures estimated (7-9 = helpers, table only)
local r1 "same rows and model as Figure R2-03"                              // gray second line under the row name
local r3 "same rows and model as Figure R2-04"
local r5 "years with no bought electricity left out"
local r6 "years with no fuel recorded left out"
local w1 "value added per GJ"                          // words for the notes
local w2 "output per GJ"
local w3 "value added per tonne of CO2"
local w4 "output per tonne of CO2"
local w5 "value added per GJ of bought electricity"
local w6 "value added per GJ of fuels"
local nmeas 6                                          // measures drawn (7-9 = helpers)
local qf1 "03_energy_efficiency_export_start"          // tables that rows 1 and 3 must reproduce
local qf3 "04_co2_efficiency_export_start"
* Years whose energy records are in doubt for importers with unknown export
* status (their recorded energy jumps far up, then falls to about a fifth,
* while value added per worker stays flat; see the R1-03/R1-04 reviews and
* R2-06). Step 4 re-checks them on any data.
local doubt_yrs "2017 2019 2020 2021 2022"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: the previous paper's six efficiency measures before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export status, energy by type, CO2, value added and output; check the add-ons"
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
* import_flag          = imports raw materials (used only to find doubtful energy records)
* total_gj_s1          = energy use in GJ = gj_fuel_s1 (nine fuels burned) + gj_electricity (bought electricity)
* co2_total_s1         = CO2 tonnes from the same fuels and electricity
* value_added_nominal  = value added, current prices (masked money unit)
* gross_output_nominal = output (value of all goods made), current prices (masked money unit)
use firm_id year export_flag import_flag total_gj_s1 gj_fuel_s1 gj_electricity co2_total_s1 ///
    value_added_nominal gross_output_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
* Energy use is the sum of its two types (checked, so rows 5 and 6 split row 1's energy).
assert reldif(total_gj_s1, gj_fuel_s1 + gj_electricity) < 1e-9 if !missing(total_gj_s1, gj_fuel_s1, gj_electricity)
sort firm_id year

*---------------------------------------------------------------------------
display "Step 2/8: date each firm's export start (rule A, same code as every R2 file)"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry: the first year the firm is seen participating,
*   if it was seen NOT participating in some earlier year. Firms participating
*   when first seen cannot be dated and are left out.
* Comparison group: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (excluded) · 9003 status never observed (excluded).
* (The previous paper's stricter rule B is counted in R2-01 and estimated in R2-07.)
local x export_flag
    by firm_id: egen int first_yes = min(cond(`x' == 1, year, .))
    by firm_id: egen int first_no  = min(cond(`x' == 0, year, .))
    by firm_id: egen int n_known   = total(!missing(`x'))
    gen int keyA = .
    replace keyA = 9003 if n_known == 0                                     // status never observed
    replace keyA = 9001 if n_known > 0 & missing(first_yes)                 // never seen participating
    replace keyA = 9002 if n_known > 0 & !missing(first_yes) & (missing(first_no) | first_no > first_yes)
    replace keyA = first_yes if n_known > 0 & !missing(first_yes) & !missing(first_no) & first_no < first_yes
    assert !missing(keyA)
    gen int gA = keyA if keyA < 9000                                        // entry year, rule A
    by firm_id: egen int last_no_before = max(cond(`x' == 0 & year < gA, year, .))
    gen byte exactA = !missing(gA) & last_no_before == gA - 1               // seen "no" the year just before

*---------------------------------------------------------------------------
display "Step 3/8: set the year window (R2-02's rule) and check it against R2-02's table if present"
*---------------------------------------------------------------------------
* Years since the start = calendar year minus start year (0 = start year,
* -1 = the year before). A firm's 2016 is simply missing (no file).
gen int kA = year - gA                                  // missing for non-starters
* Usable row = energy, CO2 and value added all above zero, so every log exists
* (the same rows in R2-03, R2-04 and R2-05). A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
by firm_id: egen int first_seen = min(year)             // first year the firm is in the file
tempfile fy est
save `fy'
* Which years since the start get their own point: R2-02's rule, computed here so
* this file also runs on its own. A year passes when `minfirms'+ starters have a
* usable row in it, from starts both before and after 2016; take the widest
* window -K..+K in which every year passes (further out = grouped ends).
local minfirms 30
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
capture confirm file "tables/02_event_time_support.csv"
if !_rc {
    import delimited using "tables/02_event_time_support.csv", clear varnames(1)
    if window_first[1] != `wlo' | window_last[1] != `whi' | min_firms[1] != `minfirms' {
        display as error "tables/02_event_time_support.csv shows another year window: re-run 02_event_time_support.do."
        exit 459
    }
}
local nout = `whi' + 1                                  // first grouped year on each side
display "   window (R2-02's rule, computed here): each year from `wlo' to +`whi' on its own; `nout'+ years before or after grouped"

*---------------------------------------------------------------------------
display "Step 4/8: the firms compared, the six measures, doubtful energy records, and the markers"
*---------------------------------------------------------------------------
use `fy', clear
* Keep the starters (rule A) and the firms never seen exporting (the comparison
* group, all their rows). Left out: firms already exporting when first seen
* (start year unknown) and firms whose export status is never recorded.
keep if !missing(gA) | keyA == 9001
keep if usable                                          // R2-03's rows
local nuse = _N                                         // for the notes: share of rows without a value
* The measures, in logs. A log needs both parts above zero: a year with no
* bought electricity (or no fuel recorded) has no value for that measure and
* is left out of that row only - never read as "zero use". Output is checked
* the same way (on the development file it is above zero in every row).
forvalues o = 1/`nall' {
    gen double y`o' = `y`o''
    quietly count if missing(y`o')
    display "   measure `o' (`n`o''): " %6.0fc r(N) " of " %6.0fc _N " rows have no value (a part is zero or missing)"
}
* Output rows minus value-added rows = the helper (output per unit of value added).
assert reldif(y2, y1 + y7) < 1e-9 if !missing(y2, y1, y7)
assert reldif(y4, y3 + y7) < 1e-9 if !missing(y4, y3, y7)
* Rows where all six measures exist (version "common": the same firm-years in every row).
gen byte all6 = !missing(y1, y2, y3, y4, y5, y6)
* Doubtful energy records (R2-06's definition): importers whose export status is
* unknown, in the years listed at the top. Kept in the main version; left out
* in version "nodoubt" (drawn hollow gray).
local dlist = subinstr(strtrim(itrim("`doubt_yrs'")), " ", ",", .)
gen byte doubt = missing(export_flag) & import_flag == 1 & inlist(year, `dlist')
* Re-check on these data (R2-06's rule): in each listed year the doubtful rows'
* middle (median) energy per unit of value added should be far from the other
* rows' (above double or below half). If not, the year list needs a new look.
gen double gjva = total_gj_s1 / value_added_nominal
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
* The previous paper's control, used in one version only: firm "age" squared,
* where age = years since the firm first appears in the file (the file has no
* founding year).
gen double age2 = (year - first_seen + 1)^2
* One marker per year since the start inside the window, except -1 (the year
* before the start = the reference, 0 by definition), plus one marker for each
* grouped end. Comparison firms are 0 on every marker.
gen byte ev_lo = !missing(kA) & kA < `wlo'
local terms "ev_lo"
local pre   "ev_lo"
local post  ""
local pre_in ""
forvalues k = `wlo'/`whi' {
    if `k' == -1 continue
    local nm = cond(`k' < 0, "ev_m" + string(-`k'), "ev_p" + string(`k'))
    gen byte `nm' = (kA == `k')
    local terms `terms' `nm'
    if `k' < -1 local pre `pre' `nm'
    if `k' < -1 local pre_in `pre_in' `nm'              // years before the start, grouped end left out
    if `k' >= 0 local post `post' `nm'
}
gen byte ev_hi = !missing(kA) & kA > `whi'
local terms `terms' ev_hi
gen byte ev_ref = (kA == -1)                            // for the counts only

*---------------------------------------------------------------------------
display "Step 5/8: estimate each measure with firm and year fixed effects (clustered by firm), seven versions"
*---------------------------------------------------------------------------
* Log measure on the markers, removing each firm's own average level (firm fixed
* effects) and each year's average (year fixed effects, set mostly by the
* comparison firms). A firm with one usable year cannot be compared with itself;
* reghdfe drops it and reports the number. Coefficient b = log difference from
* the firm's year before the start, net of the comparison firms' change; drawn
* as 100 x (exp(b) - 1) = % difference. Main = exactly R2-03's rows and model.
* Versions (the chart shows "main" and "nodoubt"; all are in the table):
*   age2     = adds the previous paper's control (age squared, see Step 4)
*   no2017   = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact    = keeps only starters seen not exporting the year just before
*   nodoubt  = without doubtful energy records (Step 4)
*   common   = only firm-years where all six measures exist (same rows in every row)
*   no2017yr = without every 2017 record (the year firms making their own
*              electricity report far more fuel; most of those rows are doubtful)
local nv 7
local v1 "main"
local v2 "age2"
local v3 "no2017"
local v4 "exact"
local v5 "nodoubt"
local v6 "common"
local v7 "no2017yr"
local e1 "1"
local e2 "1"
local e3 "gA != 2017"                                   // comparison firms (gA missing) stay
local e4 "missing(gA) | exactA == 1"
local e5 "!doubt"
local e6 "all6"
local e7 "year != 2017"
local c2 "age2"
local lc = subinstr("`post'", " ", " + ", .)            // years 0..+`whi', for the average
local np : word count `post'
* Second base (a check): the average of every single year before the start
* (`wlo' to -1, the year just before counting as 0), instead of the year just
* before only. A year just before that happens to be high or low moves the
* main average; it moves this one much less.
local lb = subinstr("`pre_in'", " ", " + ", .)          // years `wlo'..-2
local nbase : word count `pre_in'
local nbase = `nbase' + 1                                    // plus the year just before (0)
tempname h
postfile `h' byte outcome str8 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues o = 1/`nall' {
  forvalues s = 1/`nv' {
    quietly reghdfe y`o' `terms' `c`s'' if `e`s'', absorb(firm_id year) vce(cluster firm_id)
    matrix B`o'_`s' = e(b)
    local df = e(df_r)
    local N`o'_`s'  = e(N)
    local G`o'_`s'  = e(N_clust)
    local sg`o'_`s' = e(num_singletons)
    local ab_09 "`e(absvars)'"                   // for the regression table (Step 8)
    local cl_09 "`e(clustvar)'"
    capture drop es
    gen byte es = e(sample)
    * rows of this version where this measure has no value (a part is zero)
    quietly count if missing(y`o') & (`e`s'')
    local z`o'_`s' = r(N)
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
    * The same average, measured against the average of the years before the start.
    if `nbase' > 1 quietly lincom (`lc') / `np' - (`lb') / `nbase'
    else        quietly lincom (`lc') / `np'
    local vb`o'_`s'  = r(estimate)
    local vbs`o'_`s' = r(se)
    local vbl`o'_`s' = r(estimate) - invttail(`df', 0.025) * r(se)
    local vbh`o'_`s' = r(estimate) + invttail(`df', 0.025) * r(se)
    local vbp`o'_`s' = 2 * ttail(`df', abs(r(estimate) / r(se)))
    egen byte ftag = tag(firm_id) if es
    quietly count if ftag == 1 & !missing(gA)
    local st`o'_`s' = r(N)
    quietly count if ftag == 1 & keyA == 9001
    local cf`o'_`s' = r(N)
    drop ftag
    foreach t in `terms' ev_ref {
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
        if "`t'" == "ev_ref" {
            post `h' (`o') ("`v`s''") ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl') (`ny')
        }
        else {
            local b  = _b[`t']
            local se = _se[`t']
            post `h' (`o') ("`v`s''") ("`t'") (`k') (inlist("`t'", "ev_lo", "ev_hi")) (0) (`b') (`se') ///
                (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl') (`ny')
        }
    }
    if `s' == 1 | `s' == 5 {
        local pshow = cond(`Fp`o'_`s'' < 0.001, "< 0.001", "= " + string(`Fp`o'_`s'', "%5.3f"))
        display "   `o' `v`s'': " %6.0fc `N`o'_`s'' " rows, " %5.0fc `G`o'_`s'' " firms (" `st`o'_`s'' " starters); average " ///
            %5.1f 100 * (exp(`a`o'_`s'') - 1) "%; before-start test p `pshow'"
        display "      same average against all years before the start: " %5.1f 100 * (exp(`vb`o'_`s'') - 1) "% (p " %5.3f `vbp`o'_`s'' ")"
    }
  }
}
postclose `h'
* Output rows = value-added rows + the helper (output per unit of value added),
* marker by marker, whenever the three use the same rows (on the development
* file they always do: output is above zero wherever value added is).
forvalues s = 1/`nv' {
    foreach pr in "2 1" "4 3" {
        local ou : word 1 of `pr'
        local va : word 2 of `pr'
        if `N`ou'_`s'' == `N`va'_`s'' & `N7_`s'' == `N`va'_`s'' {
            foreach t of local terms {
                assert reldif(B`ou'_`s'[1, "`t'"], B`va'_`s'[1, "`t'"] + B7_`s'[1, "`t'"]) < 1e-6
            }
        }
        else display "   version `v`s'': measures `ou' and `va' use different rows - identity check skipped"
    }
}
display "   identity holds: output rows = value-added rows + output per unit of value added"

*---------------------------------------------------------------------------
display "Step 6/8: percentages, cross-checks with R2-03 and R2-04, and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen str80 outcome_label = ""
gen str60 outcome_log   = ""
gen str14 figure_ref    = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''" if outcome == `o'
    replace outcome_log   = "`y`o''" if outcome == `o'
}
replace figure_ref = "Figure R2-03" if outcome == 1
replace figure_ref = "Figure R2-04" if outcome == 3
gen str70 version_label = ""
replace version_label = "Main: all starters vs never exporters; firm and year fixed effects" if vorder == 1
replace version_label = "Adds the previous paper's control: age squared (years in the file)" if vorder == 2
replace version_label = "Without the 2017 starters (they may have started in 2016)"         if vorder == 3
replace version_label = "Only starters seen not exporting the year just before"             if vorder == 4
replace version_label = "Without doubtful energy records (importers, export status unknown)" if vorder == 5
replace version_label = "Only firm-years where all six measures exist"                      if vorder == 6
replace version_label = "Without every 2017 record (own-generation fuel jump that year)"    if vorder == 7
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if term == "ev_lo"
replace column = "+`nout' or later (grouped)"      if term == "ev_hi"
* % difference = 100 x (exp(b) - 1); the interval ends are converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
* Numbers for the whole measure x version (repeated on each of its rows).
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped rows_no_value before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_se avg_after_p ///
    avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
    avg_vs_before_b avg_vs_before_se avg_vs_before_p avg_vs_before_pct avg_vs_before_pct_lo avg_vs_before_pct_hi {
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
            replace rows_no_value       = `z`o'_`s''  if `c'
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
            replace avg_vs_before_b      = `vb`o'_`s''  if `c'
            replace avg_vs_before_se     = `vbs`o'_`s'' if `c'
            replace avg_vs_before_p      = `vbp`o'_`s'' if `c'
            replace avg_vs_before_pct    = 100 * (exp(`vb`o'_`s'')  - 1) if `c'
            replace avg_vs_before_pct_lo = 100 * (exp(`vbl`o'_`s'') - 1) if `c'
            replace avg_vs_before_pct_hi = 100 * (exp(`vbh`o'_`s'') - 1) if `c'
        }
    }
}
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
* If R2-03's / R2-04's tables are present, rows 1 and 3 must reproduce their
* coefficients (same rows, markers and model) to the 4 decimals they are written with.
foreach o in 1 3 {
    capture confirm file "tables/`qf`o''.csv"
    if _rc {
        display "   tables/`qf`o''.csv not found: cross-check skipped"
        continue
    }
    preserve
    import delimited using "tables/`qf`o''.csv", clear varnames(1)
    keep version event_time b
    rename b fig_b
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == `o' & inlist(version, "main", "age2", "no2017", "exact")
    merge 1:1 version event_time using `fig', keep(master match using)
    quietly count if _merge != 3 | abs(b - fig_b) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "tables/`qf`o''.csv does not match (window or data differ): re-run `qf`o''.do."
        exit 459
    }
    quietly count
    display "   `qf`o''.csv: all " r(N) " coefficients reproduced to 4 decimals"
    restore
}
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "Helper, not drawn: output rows = value-added rows + this" if outcome == 7 & note == ""
replace note = "Helper, not drawn: row 5 = value added minus this, on row 5's rows" if outcome == 8 & note == ""
replace note = "Helper, not drawn: row 6 = value added minus this, on row 6's rows" if outcome == 9 & note == ""
sort outcome vorder event_time
order outcome outcome_label outcome_log figure_ref version version_label column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped rows_no_value before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_se avg_after_p avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
      avg_vs_before_b avg_vs_before_se avg_vs_before_p avg_vs_before_pct avg_vs_before_pct_lo avg_vs_before_pct_hi ///
      window_first window_last note
drop term vorder
format b se lo hi avg_after_b avg_after_se avg_vs_before_b avg_vs_before_se before_F %9.4f
format pct pct_lo pct_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi avg_vs_before_pct avg_vs_before_pct_lo avg_vs_before_pct_hi %9.1f
format p before_p before_p_no_grouped avg_after_p avg_vs_before_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped ///
       rows_no_value before_df %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion tables (Step 8)
quietly save `ctsrc'
set linesize 220                                      // one line per row in the log listing
list outcome version avg_after_pct avg_after_pct_lo avg_after_pct_hi before_p avg_vs_before_pct avg_vs_before_p ///
    n_rows n_starters n_comparison rows_no_value if column == "0", noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 7/8: one row per measure (average of years 0 to +`whi'), main and without doubtful records"
*---------------------------------------------------------------------------
* One line per measure x version (the summary numbers are on every row; take the reference row).
keep if reference & outcome <= `nmeas'
keep outcome version avg_after_pct avg_after_pct_lo avg_after_pct_hi avg_after_p before_p ///
     n_rows n_starters n_comparison rows_no_value
* Numbers for the notes, read from the table (never typed).
gen byte clear = avg_after_pct_lo > 0 | avg_after_pct_hi < 0          // interval does not cross 0
gen byte sgn   = cond(avg_after_pct > 0, 1, -1)
* (a) the measures whose average is clearly different from 0 (main version)
local nclr 0
forvalues o = 1/`nmeas' {
    quietly summarize clear if outcome == `o' & version == "main"
    if r(mean) == 1 {
        local ++nclr
        local clro`nclr' = `o'
        quietly summarize avg_after_pct if outcome == `o' & version == "main"
        local clr`nclr' = "`w`o'' (" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.0f") + "%)"
    }
}
local clrtxt ""
forvalues j = 1/`nclr' {
    local sep = cond(`j' == 1, "", cond(`j' == `nclr', " and ", ", "))
    local clrtxt "`clrtxt'`sep'`clr`j''"
}
* (a2) For a clear row: what moves behind it (electricity or fuel row: value
* added = the row + the helper, on the same rows; the energy part = the helper),
* and whether it stays clear against the average of the years before the start.
local whytxt ""
local vbtxt ""
if `nclr' == 1 {
    local oo = `clro1'
    local hh = `oo' + 3                                 // helper: 8 = bought electricity, 9 = fuels
    if inlist(`oo', 5, 6) & `N`oo'_1' == `N`hh'_1' {
        local vap = 100 * (exp(`a`oo'_1' + `a`hh'_1') - 1)
        local hp  = 100 * (exp(`a`hh'_1') - 1)
        local hcl = `al`hh'_1' > 0 | `ah`hh'_1' < 0
        local enm = cond(`oo' == 5, "bought electricity use", "fuel use")
        local vat = "value added " + cond(`vap' > 0, "grows", "falls") + " (" + cond(`vap' > 0, "+", "") + string(round(`vap'), "%9.0f") + "%)"
        local hmv = cond(`hcl', cond(`hp' > 0, "rises", "falls"), "does not clearly change")
        local het = "`enm' `hmv' (" + cond(`hp' > 0, "+", "") + string(round(`hp'), "%9.0f") + "%)"
        local whytxt ": `vat' while `het'"
    }
    local vbp = 100 * (exp(`vb`oo'_1') - 1)
    local vbc = cond(`vbl`oo'_1' > 0 | `vbh`oo'_1' < 0, "still clear", "not clear")
    local vbtxt = "Against the average of the `nbase' years before the start, instead of only the year just before, it is " ///
        + cond(`vbp' > 0, "+", "") + string(round(`vbp'), "%9.0f") + "%, `vbc'."
}
else if `nclr' > 1 {
    local kk 0
    forvalues j = 1/`nclr' {
        local oo = `clro`j''
        if `vbl`oo'_1' > 0 | `vbh`oo'_1' < 0 local ++kk
    }
    local vbtxt "Against the average of the `nbase' years before the start, instead of only the year just before, `kk' of these `nclr' stay clear."
}
if `nclr' == 0 local clrtxt "No measure is clearly different from 0."
else if `nclr' == 1 local clrtxt "Only `clrtxt' is clearly different from 0`whytxt'."
else local clrtxt "Clearly different from 0: `clrtxt'."
display "   clear rows: `clrtxt' `vbtxt'"
* (b) does any answer change (clear or not, and its direction) without doubtful
* records, or on the firm-years where all six measures exist?
foreach alt in nodoubt common {
    local chg`alt' ""
    local mv`alt' 0
    forvalues o = 1/`nmeas' {
        quietly summarize clear if outcome == `o' & version == "main"
        local c0 = r(mean)
        quietly summarize sgn if outcome == `o' & version == "main"
        local s0 = r(mean)
        quietly summarize avg_after_pct if outcome == `o' & version == "main"
        local p0 = r(mean)
        quietly summarize clear if outcome == `o' & version == "`alt'"
        local c1 = r(mean)
        quietly summarize sgn if outcome == `o' & version == "`alt'"
        local s1 = r(mean)
        quietly summarize avg_after_pct if outcome == `o' & version == "`alt'"
        local mv`alt' = max(`mv`alt'', abs(r(mean) - `p0'))
        if `c0' != `c1' | (`c0' == 1 & `s0' != `s1') local chg`alt' = strtrim("`chg`alt'' `o'")
    }
    local nch : word count `chg`alt''
    if `nch' == 0 local ans`alt' "no answer changes"
    else {
        local ans`alt' "the answer changes for "
        forvalues j = 1/`nch' {
            local oo : word `j' of `chg`alt''
            local sep = cond(`j' == 1, "", cond(`j' == `nch', " and ", ", "))
            local ans`alt' "`ans`alt''`sep'`w`oo''"
        }
    }
    local mv`alt' = string(round(`mv`alt''), "%9.0f")
    display "   version `alt' vs main: `ans`alt'' (largest move of an average: `mv`alt'' % points)"
}
* (c) the stricter group's before-start check (starters seen not exporting the year just before)
local nx 0
forvalues o = 1/`nmeas' {
    quietly summarize before_p if outcome == `o' & version == "exact"
    if r(mean) < 0.05 local ++nx
}
local xtxt ""
if `nx' > 0 local xtxt "; starters seen not exporting in the year just before were, in `nx' of `nmeas' rows (a warning sign)"
* (d) share of R2-03's rows with no bought electricity / no fuel recorded (main version; log and INDEX)
quietly summarize rows_no_value if outcome == 5 & version == "main"
local pe = string(100 * r(mean) / `nuse', "%9.0f")
quietly summarize rows_no_value if outcome == 6 & version == "main"
local pf = string(100 * r(mean) / `nuse', "%9.0f")
display "   rows left out of the electricity / fuel rows (none recorded): `pe'% / `pf'% of R2-03's rows"
* Plot rows: pairs (per GJ, per tonne of CO2, per energy type) with a gap between pairs.
gen double ypos = .
replace ypos = 9.0 if outcome == 1
replace ypos = 8.0 if outcome == 2
replace ypos = 6.6 if outcome == 3
replace ypos = 5.6 if outcome == 4
replace ypos = 4.2 if outcome == 5
replace ypos = 3.2 if outcome == 6
gen double yalt = ypos - 0.26                           // hollow gray: just under its row
* x-axis: a round step that grows with the numbers; 0 always inside.
quietly summarize avg_after_pct_lo if version == "main"
local xmin = min(r(min), 0)
quietly summarize avg_after_pct_hi if version == "main"
local xmax = max(r(max), 0)
quietly summarize avg_after_pct
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
* Layout left to right (in x-axis units): row names, the dots (xbot..xtop, the
* only part with an axis), then three columns: starters, never-exporters (both
* right-aligned) and the before-start check.
local xn  = `xbot' - 1.38 * `span'                      // row names start here (left-aligned)
local xc1 = `xtop' + 0.50 * `span'                      // column: starters
local xc2 = `xtop' + 1.10 * `span'                      // column: never-exporters
local xc3 = `xtop' + 1.18 * `span'                      // column: before-start check (left-aligned)
local xr  = `xtop' + 1.67 * `span'
gen double xnm = `xn'
gen double xc1 = `xc1'
gen double xc2 = `xc2'
gen double xc3 = `xc3'
gen double ysub = ypos - 0.42
local nb = uchar(160)                                   // no-break space: "< 0.001" stays together
gen str12 c1 = string(n_starters, "%9.0fc")   if version == "main"
gen str12 c2 = string(n_comparison, "%9.0fc") if version == "main"
gen str24 c3 = cond(before_p < 0.001, "<`nb'0.001", string(before_p, "%5.3f")) if version == "main"
replace c3 = c3 + ", differs" if version == "main" & before_p < 0.05
gen double pr = round(avg_after_pct)
gen str8 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") + "%" if version == "main"
gen str60 nm  = ""
gen str60 sub = ""
forvalues o = 1/`nmeas' {
    replace nm  = "`n`o''" if outcome == `o' & version == "main"
    replace sub = "`r`o''" if outcome == `o' & version == "main"
}
gen str8 hdr = "Measure" if _n == 1
local yh = 9.0 + 0.9                                    // column headers, above the first row
gen double yhdr = `yh'
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local txt "Notes: Each row repeats Figure R2-03 with one of the previous paper's six measures: firms that start exporting (first year"
local txt "`txt' seen exporting after a year seen not exporting) vs firms never seen exporting, change since the year before the start."
local txt "`txt' Output = value of everything produced; value added = output minus materials, energy and services bought (current"
local txt "`txt' prices); GJ = gigajoules; fuels = the nine fuels burned; bought electricity excludes own generation."
local txt "`txt' Bars = 95% intervals; crossing 0 = no clear difference. `clrtxt' `vbtxt' On firm-years with all six"
local txt "`txt' measures, `anscommon'. Hollow gray = without importers of unknown export status in years their energy"
local txt "`txt' records jump or drop: `ansnodoubt'. Before the start: p below 0.05 = starters were already changing"
local txt "`txt' differently`xtxt'. Timing, not proof of cause; firm links are fictional."
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
    (scatter ypos xc1 if version == "main", msymbol(none) mlabel(c1) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc2 if version == "main", msymbol(none) mlabel(c2) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc3 if version == "main", msymbol(none) mlabel(c3) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter yhdr xnm if hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    text(`yh' `xc1' "Starters", size(vsmall) placement(w)) ///
    text(`yh' `xc2' "Never-exporters", size(vsmall) placement(w)) ///
    text(`yh' `xc3' "Before the start, p", size(vsmall) placement(e)) ///
    yscale(range(2.6 10.1) off) ylabel(, nogrid) ytitle("") ///
    xscale(range(`xn' `xr') noline) ///
    xlabel(`xbot'(`step')`xtop', labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`xfmt')) ///
    xtitle("") ///
    legend(order(3 "Average of years 0 to +`whi' (each year counts equally)" 4 "Without doubtful energy records (hollow gray)" ///
                 2 "95% interval" 1 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Energy efficiency after firms start exporting, by measure", size(medium) position(11) justification(left) span) ///
    subtitle("% change after the start (years 0 to +`whi'), starters minus never-exporters", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    xsize(9) ysize(8) scale(`=7.5/8')                       // text as in R2-03 (9 x 7.5 in)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regression table"
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
* (1) Points table: the chart's rows top to bottom; per measure the main
* average (dot, bar, label), then the one without doubtful records (hollow gray).
use `ctsrc', clear
keep if reference & outcome <= `nmeas' & inlist(version, "main", "nodoubt")
gen byte vv = 1 + (version == "nodoubt")
sort outcome vv
local npts = _N
gen str90 t_m = ""
forvalues o = 1/`nmeas' {
    replace t_m = "`n`o''" if outcome == `o'
    if "`r`o''" != "" replace t_m = t_m + " (`r`o'')" if outcome == `o'
}
gen str60 t_ser = cond(vv == 1, "Average of years 0 to +`whi'", "Without doubtful energy records")
gen byte drawn = !missing(avg_after_pct)
* main: whole % as the chart labels; hollow gray (no label on the chart): one decimal
gen str12 t_v  = ""
gen str12 t_lo = ""
gen str12 t_hi = ""
foreach c in v lo hi {
    local s = cond("`c'" == "v", "avg_after_pct", "avg_after_pct_`c'")
    replace t_`c' = cond(round(`s') > 0, "+", "") + string(round(`s'), "%9.0f") if drawn & vv == 1
    replace t_`c' = cond(round(`s', 0.1) > 0, "+", "") + string(round(`s', 0.1), "%9.1f") if drawn & vv == 2
}
gen str12 t_st = string(n_starters, "%12.0fc")
gen str12 t_cf = string(n_comparison, "%12.0fc")
gen str12 t_r  = string(n_rows, "%12.0fc")
gen str24 t_p = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f")) if vv == 1
replace t_p = t_p + ", differs" if vv == 1 & before_p < 0.05
gen str60 t_status = cond(vv == 1, "drawn: dot, bar, label", "drawn: hollow gray circle (no bar)") if drawn
replace t_status = "not drawn: no estimate" if !drawn
quietly count if drawn
local ndrawn = r(N)
quietly count if strpos(t_status, "drawn:") == 1
assert r(N) == `ndrawn'
assert t_v != "" if drawn
assert _N == `npts'
local rl ""
forvalues j = 2(2)`=`npts' - 2' {
    local rl `rl' `j'
}
local txt_t = itrim(`"`txt'"')
local tnote "Table: every point of Figure `exhibit', top to bottom, with the Starters, Never-exporters and Before-the-start columns printed"
local tnote "`tnote' on the chart (hollow gray rows: its own counts; its before-start p is in the regression table). % difference ="
local tnote "`tnote' 100 × (exp(b) − 1), b = the regression table's average rows; main rounded as the chart labels, hollow gray (no label)"
local tnote "`tnote' to one decimal. Firm-years = the regression's rows. Full precision: tables/`fname'.csv."
ctable_pdf t_m t_ser t_v t_lo t_hi t_st t_cf t_r t_p t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. Energy efficiency after firms start exporting, by measure: every plotted point") ///
    subtitle("% change after the start (years 0 to +`whi'), starters minus never-exporters") ///
    header("Measure (chart row)" "Series" "%|difference" "95%|interval|low" "95%|interval|high" "Starters" "Never-|exporters" "Firm-|years" "Before the|start, p" "Status") ///
    right(3 4 5 6 7 8) norepeat(1) rules(`rl') fontsize(9) ///
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf"

* (2) Regression table (AER style): one column per measure (main version),
* coefficient on the first line, (standard error) on the second; the averages
* drawn (main and without doubtful records) below the year-by-year markers.
* show_pct = 1 adds a third line, [% difference], for every year: the table
* then runs to two pages, so it is off here (the drawn %s are in the points
* table; every version in the CSV).
local show_pct 0
use `ctsrc', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep outcome version event_time b avg_after_b
rename (b avg_after_b) (b_csv a_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 outcome version event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert abs(avg_after_b - a_csv) <= 0.00005 + 1e-9
drop b_csv a_csv
keep if outcome <= `nmeas'
tempname P
tempfile R
postfile `P' str60 t_lab str24(t1 t2 t3 t4 t5 t6) using `R'
levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k' & outcome == 1 & version == "main", meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k' & outcome == 1 & version == "main", meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    if `rf' {
        post `P' ("`lab' (reference, set to 0)") ("—") ("—") ("—") ("—") ("—") ("—")
        local ++nterm
        continue
    }
    forvalues o = 1/`nmeas' {
        quietly summarize b if event_time == `k' & outcome == `o' & version == "main", meanonly
        local b`o' = string(r(mean), "%9.3f")
        quietly summarize se if event_time == `k' & outcome == `o' & version == "main", meanonly
        local s`o' = "(" + string(r(mean), "%9.3f") + ")"
        quietly summarize pct if event_time == `k' & outcome == `o' & version == "main", meanonly
        local p`o' = "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'")
    if `show_pct' post `P' ("") ("`p1'") ("`p2'") ("`p3'") ("`p4'") ("`p5'") ("`p6'")
    local nterm = `nterm' + 2 + `show_pct'
}
* whole-model rows (the same number on every row of a measure x version: take the reference row)
keep if reference
foreach v in main nodoubt {
    forvalues o = 1/`nmeas' {
        quietly summarize avg_after_b if outcome == `o' & version == "`v'", meanonly
        local ab`o' = string(r(mean), "%9.3f")
        quietly summarize avg_after_se if outcome == `o' & version == "`v'", meanonly
        local as`o' = "(" + string(r(mean), "%9.3f") + ")"
        quietly summarize avg_after_pct if outcome == `o' & version == "`v'", meanonly
        local ap`o' = "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
        quietly summarize before_p if outcome == `o' & version == "`v'", meanonly
        local bp`o' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
    }
    local lab = cond("`v'" == "main", "Average, years 0 to +`whi' (drawn)", "Same, no doubtful records")
    post `P' ("`lab'") ("`ab1'") ("`ab2'") ("`ab3'") ("`ab4'") ("`ab5'") ("`ab6'")
    post `P' ("")      ("`as1'") ("`as2'") ("`as3'") ("`as4'") ("`as5'") ("`as6'")
    if "`v'" == "main" post `P' ("") ("`ap1'") ("`ap2'") ("`ap3'") ("`ap4'") ("`ap5'") ("`ap6'")
    forvalues o = 1/`nmeas' {
        local bp_`v'`o' "`bp`o''"
    }
}
forvalues o = 1/`nmeas' {
    foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped rows_no_value {
        quietly summarize `v' if outcome == `o' & version == "main", meanonly
        local `v'`o' = string(r(mean), "%12.0fc")
    }
    quietly summarize before_p_no_grouped if outcome == `o' & version == "main", meanonly
    local bq`o' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
}
local fe_f = cond(strpos(" `ab_09' ", " firm_id "), "Yes", "No")
local fe_y = cond(strpos(" `ab_09' ", " year "), "Yes", "No")
local clu  = cond("`cl_09'" == "firm_id", "Firm", "`cl_09'")
post `P' ("Observations (firm-years)")       ("`n_rows1'") ("`n_rows2'") ("`n_rows3'") ("`n_rows4'") ("`n_rows5'") ("`n_rows6'")
post `P' ("Firms (clusters)")                ("`n_firms1'") ("`n_firms2'") ("`n_firms3'") ("`n_firms4'") ("`n_firms5'") ("`n_firms6'")
post `P' ("Firms: starters")                 ("`n_starters1'") ("`n_starters2'") ("`n_starters3'") ("`n_starters4'") ("`n_starters5'") ("`n_starters6'")
post `P' ("Firms: never-exporters")          ("`n_comparison1'") ("`n_comparison2'") ("`n_comparison3'") ("`n_comparison4'") ("`n_comparison5'") ("`n_comparison6'")
post `P' ("One-year firms dropped") ("`n_one_year_dropped1'") ("`n_one_year_dropped2'") ("`n_one_year_dropped3'") ("`n_one_year_dropped4'") ("`n_one_year_dropped5'") ("`n_one_year_dropped6'")
post `P' ("Rows with no value (left out)")   ("`rows_no_value1'") ("`rows_no_value2'") ("`rows_no_value3'") ("`rows_no_value4'") ("`rows_no_value5'") ("`rows_no_value6'")
post `P' ("Firm fixed effects")              ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'")
post `P' ("Year fixed effects")              ("`fe_y'") ("`fe_y'") ("`fe_y'") ("`fe_y'") ("`fe_y'") ("`fe_y'")
post `P' ("Standard errors clustered by")    ("`clu'") ("`clu'") ("`clu'") ("`clu'") ("`clu'") ("`clu'")
post `P' ("Before-start test, joint p")      ("`bp_main1'") ("`bp_main2'") ("`bp_main3'") ("`bp_main4'") ("`bp_main5'") ("`bp_main6'")
post `P' ("Before-start p, no doubtful records") ("`bp_nodoubt1'") ("`bp_nodoubt2'") ("`bp_nodoubt3'") ("`bp_nodoubt4'") ("`bp_nodoubt5'") ("`bp_nodoubt6'")
postclose `P'
use `R', clear
local rsub "Outcome: log of each measure. Log points; standard errors in parentheses; [% = 100 × (exp(b) − 1)] for the drawn average."
local rnote "Notes: Each column: the log measure on one marker per year since the export start (-1 = reference, 0; `nout'+ years grouped),"
local rnote "`rnote' firm and year fixed effects; never-exporters 0 on every marker; no weights. (1) = Figure R2-03, (3) = Figure R2-04. Averages = mean of"
local rnote "`rnote' years 0 to +`whi'; the second leaves out importers of unknown export status in `doubt_yrs'. Before-start test: all years before = 0. No stars."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. Energy efficiency after firms start exporting, by measure: estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Years since the start" "(1)|Value-added|per GJ" "(2)|Output|per GJ" "(3)|Value-added|per tonne CO2" "(4)|Output per|tonne CO2" "(5)|Value-added|per GJ of|electricity" "(6)|Value-added|per GJ fuels") ///
    right(2 3 4 5 6 7) rules(`nterm' `=`nterm' + 5') fontsize(9) perpage(60) portrait ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------



timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
