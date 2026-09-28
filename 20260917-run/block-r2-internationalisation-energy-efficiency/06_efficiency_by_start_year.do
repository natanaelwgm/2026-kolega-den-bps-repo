/*==========================================================================
  R2-06  One start year at a time: does each group of firms that started
         exporting in the same year get more value added out of each unit
         of energy afterwards, compared with firms that never export over
         the same calendar years? Do firms that started before and after
         the Paris Agreement differ?
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya" (a
         staggered design is trusted only if each start year is compared
         with firms that never start, not with earlier starters).
  Output : figures/06_efficiency_by_start_year.png (+ .pdf)
           tables/06_efficiency_by_start_year.csv (value added per GJ and
           per tonne of CO2; three versions)
           tables/06_efficiency_by_start_year_table.pdf (every plotted point)
           tables/06_efficiency_by_start_year_regression.pdf (four versions, value added per GJ)
  Checks : R2-03's and R2-04's averages (re-estimated here for the notes)
           against their tables when those tables are present
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
local exhibit "R2-06"
local fname   "06_efficiency_by_start_year"
* Paris Agreement adopted December 2015: starts up to this year count as
* "before Paris", later starts as "after Paris".
local paris_year 2015
* Years whose energy records are in doubt for importers with unknown export
* status (their recorded energy jumps far up, then falls to about a fifth,
* while value added per worker stays flat; see the R1-03/R1-04 reviews).
* Chosen on the development files: Step 4 re-checks them on any data.
local doubt_yrs "2017 2019 2020 2021 2022"

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: value added per GJ after the export start, one start year at a time ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy, CO2 and value added"
*---------------------------------------------------------------------------
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* import_flag         = imports raw materials (used only to find doubtful energy records)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag import_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
tsset firm_id year                 // L. and F. below mean exact calendar years

*---------------------------------------------------------------------------
display "Step 2/8: date each firm's export start under two rules (same code in every R2 file)"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry (main): the first year the firm is seen
*   participating, if it was seen NOT participating in some earlier year.
*   Firms participating when first seen cannot be dated and are left out.
* Rule B, previous paper's sustained entry (variant): the first year t with
*   participation in t, none in t-1 AND t-2, and participation again in t+1
*   (exact calendar years; the missing 2016 file breaks the pattern).
* Comparison group for BOTH rules: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (rule A, excluded) · 9003 status never observed · 9004 seen participating
* without the sustained pattern (rule B, excluded) · 8000 all entrants · 9999 all firms.
local x export_flag
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
    gen int gA = keyA if keyA < 9000                                        // entry year, rule A
    by firm_id: egen int last_no_before = max(cond(`x' == 0 & year < gA, year, .))
    gen byte exactA = !missing(gA) & last_no_before == gA - 1               // seen "no" the year just before
    by firm_id: egen int first_stop = min(cond(!missing(gA) & `x' == 0 & year > gA, year, .))
    gen byte stopA = !missing(first_stop)                                   // later seen not participating
    by firm_id: egen byte reenterA = max(!missing(first_stop) & `x' == 1 & year > first_stop)

    * --- Rule B ---
    gen byte cleanB = (`x' == 1 & L1.`x' == 0 & L2.`x' == 0 & F1.`x' == 1)
    by firm_id: egen int gB = min(cond(cleanB == 1, year, .))               // entry year, rule B
    by firm_id: egen byte earlier_yesB = max(`x' == 1 & year < gB & !missing(gB))
    gen int keyB = cond(!missing(gB), gB, cond(n_known == 0, 9003, cond(missing(first_yes), 9001, 9004)))

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
display "Step 4/8: the firms compared, doubtful energy records, and R2-03's average for the notes"
*---------------------------------------------------------------------------
use `fy', clear
* Keep the starters (rule A) and the firms never seen exporting (the comparison
* group). Left out: firms already exporting when first seen (start year
* unknown) and firms whose export status is never recorded.
keep if !missing(gA) | keyA == 9001
keep if usable
gen double y1 = ln(value_added_nominal / total_gj_s1)     // log value added per GJ (R2-03)
gen double y2 = ln(value_added_nominal / co2_total_s1)    // log value added per tonne of CO2 (R2-04)
* Doubtful energy records: importers whose export status is unknown, in the
* years listed at the top. Kept in the main version; left out in version 2.
local dlist = subinstr(strtrim(itrim("`doubt_yrs'")), " ", ",", .)
gen byte doubt = missing(export_flag) & import_flag == 1 & inlist(year, `dlist')
* Re-check on these data: in each listed year the doubtful rows' middle
* (median) energy per unit of value added should be far from the other rows'
* (above double or below half). If not, the year list needs a new look.
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
* R2-03's and R2-04's average of years 0..+`whi' (same sample, markers and
* model as those files), re-estimated so the notes can compare without them.
gen byte ev_lo = !missing(kA) & kA < `wlo'
local terms "ev_lo"
local post  ""
forvalues k = `wlo'/`whi' {
    if `k' == -1 continue
    local nm = cond(`k' < 0, "ev_m" + string(-`k'), "ev_p" + string(`k'))
    gen byte `nm' = (kA == `k')
    local terms `terms' `nm'
    if `k' >= 0 local post `post' `nm'
}
gen byte ev_hi = !missing(kA) & kA > `whi'
local terms `terms' ev_hi
local lc = subinstr("`post'", " ", " + ", .)
local np : word count `post'
forvalues o = 1/2 {
    quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
    quietly lincom (`lc') / `np'
    local r0b`o'  = r(estimate)
    local r0se`o' = r(se)
    local r0df`o' = r(df)
    local r0p`o'  = r(p)
    local r0N`o'  = e(N)
}
* If R2-03's / R2-04's tables are present they must show the same average.
local qf1 "03_energy_efficiency_export_start"
local qf2 "04_co2_efficiency_export_start"
preserve
forvalues o = 1/2 {
    capture confirm file "tables/`qf`o''.csv"
    if _rc {
        display "   tables/`qf`o''.csv not found: cross-check skipped (average re-estimated here)"
        continue
    }
    import delimited using "tables/`qf`o''.csv", clear varnames(1)
    quietly summarize avg_after_b if version == "main"
    if abs(r(mean) - `r0b`o'') > 0.00005 + 1e-9 {
        display as error "tables/`qf`o''.csv shows another average (window or data differ): re-run `qf`o''.do."
        exit 459
    }
    display "   `qf`o'': average of years 0 to +`whi' reproduced (" %7.4f `r0b`o'' ")"
}
restore
keep firm_id year gA exactA doubt y1 y2
tempfile smp
save `smp'

*---------------------------------------------------------------------------
display "Step 5/8: one before/after comparison per start year (firm and year fixed effects, clustered by firm)"
*---------------------------------------------------------------------------
* For start year g: the starters of year g and all never-exporters, only in
* calendar years g`wlo' to g+`whi' (the same -`=-`wlo''..+`whi' window as R2-03; the missing
* 2016 file is simply absent). "after" = 1 for a starter's rows from g on.
* With firm and year fixed effects its coefficient compares each firm with
* itself: the starters' change from before g to g on, minus the same change
* among never-exporters in the same calendar years (firms are seen in
* different years, so this is not a plain difference of group means).
* Earlier starters are never used as comparisons, so start years are not mixed.
* A starter counts only with a usable row both before g and from g on (a
* firm seen on one side only cannot be compared with itself). A start year
* gets an estimate only with `minfirms'+ such starters (R2-02's threshold).
* Versions: 1 main; 2 without doubtful energy records (Step 4); 3 only
* starters seen not exporting the year just before (start year exact);
* 4 = 3 without doubtful energy records.
quietly levelsof gA, local(cohorts)                    // start years in the data, never typed
local ncoh : word count `cohorts'
local lastg : word `ncoh' of `cohorts'
tempfile est stack
tempname h
postfile `h' byte(vorder outcome) int start_year long(starters_dated starters st_rows_before st_rows_after ///
    comp_firms comp_rows rows doubt_rows) int(first_year last_year files_before files_after) ///
    double(b se df) using `est'
local first 1
forvalues v = 1/4 {
    foreach g of local cohorts {
        use `smp', clear
        keep if (gA == `g' | missing(gA)) & inrange(year, `g' + `wlo', `g' + `whi')
        if inlist(`v', 2, 4) drop if doubt
        if inlist(`v', 3, 4) keep if missing(gA) | exactA == 1
        egen byte ft = tag(firm_id) if gA == `g'
        quietly count if ft == 1
        local nd = r(N)                                  // starters dated to g with a usable row
        by firm_id: egen byte has_b = max(year <  `g')
        by firm_id: egen byte has_a = max(year >= `g')
        keep if missing(gA) | (has_b & has_a)
        quietly count if ft == 1
        local ns = r(N)
        local w`v'_`g' = `ns'                            // weight of this start year
        if `ns' < `minfirms' {
            forvalues o = 1/2 {
                post `h' (`v') (`o') (`g') (`nd') (`ns') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.)
            }
            continue
        }
        gen byte after = (gA == `g') & year >= `g'
        forvalues o = 1/2 {
            quietly reghdfe y`o' after, absorb(firm_id year) vce(cluster firm_id)
            local b  = _b[after]
            local se = _se[after]
            local df = e(df_r)
            local ab_st "`e(absvars)'"                     // for the regression table (Step 8)
            local cl_st "`e(clustvar)'"
            local b`v'_`g'_`o' = `b'
            capture drop es
            gen byte es = e(sample)
            quietly count if es & gA == `g' & year <  `g'
            local rb = r(N)
            quietly count if es & gA == `g' & year >= `g'
            local ra = r(N)
            egen byte ct = tag(firm_id) if es & missing(gA)
            quietly count if ct == 1
            local cf = r(N)
            drop ct
            quietly count if es & missing(gA)
            local cr = r(N)
            quietly count if es & doubt
            local dr = r(N)
            quietly summarize year if es
            local fy0 = r(min)
            local fy1 = r(max)
            quietly levelsof year if es & year <  `g'
            local nb : word count `r(levels)'
            quietly levelsof year if es & year >= `g'
            local na : word count `r(levels)'
            post `h' (`v') (`o') (`g') (`nd') (`ns') (`rb') (`ra') (`cf') (`cr') (e(N)) (`dr') ///
                (`fy0') (`fy1') (`nb') (`na') (`b') (`se') (`df')
        }
        display "   version `v', start year `g': " %4.0f `ns' " starters, value added per GJ b = " %7.4f `b`v'_`g'_1'
        gen int cohort = `g'
        gen byte vorder = `v'
        keep firm_id year cohort vorder gA after y1 y2
        if !`first' append using `stack'
        save `stack', replace
        local first 0
    }
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 6/8: averages over start years (weighted by starters) and the CSV"
*---------------------------------------------------------------------------
* All start years in one stacked regression: each start year keeps its own
* firm and year fixed effects and its own "after" marker, so each coefficient
* equals Step 5's (checked); clustering by firm accounts for never-exporters
* that serve in several start years. Averages = weights x coefficients
* (lincom), weight = number of starters used.
tempfile avg
tempname a
postfile `a' byte(vorder outcome) str16 row_type long starters double(b se df p) using `avg'
forvalues v = 1/4 {
    use `stack', clear
    keep if vorder == `v'
    egen long fc = group(firm_id cohort)
    egen long yc = group(year cohort)
    local dterms ""
    foreach L in all early late notlast {
        local t`L' 0
        local l`L' ""
    }
    quietly levelsof cohort, local(used)
    foreach g of local used {
        gen byte d`g' = after * (cohort == `g')
        local dterms `dterms' d`g'
        local tall = `tall' + `w`v'_`g''
        if `g' <= `paris_year' local tearly = `tearly' + `w`v'_`g''
        else local tlate = `tlate' + `w`v'_`g''
        if `g' != `lastg' local tnotlast = `tnotlast' + `w`v'_`g''
    }
    foreach g of local used {
        local lall "`lall' + `w`v'_`g''/`tall' * d`g'"
        if `g' <= `paris_year' local learly "`learly' + `w`v'_`g''/`tearly' * d`g'"
        else local llate "`llate' + `w`v'_`g''/`tlate' * d`g'"
        if `g' != `lastg' local lnotlast "`lnotlast' + `w`v'_`g''/`tnotlast' * d`g'"
    }
    * Before-start check, same comparisons: one marker per start year and year
    * before the start, against the last year before the start that has a file
    * (the year before; for 2017 starts 2015, as 2016 has no file). Markers for
    * the same year before the start are averaged over start years (weight =
    * starters seen that year) and all these averages are tested together.
    gen int e = year - cohort if gA == cohort
    local lterms ""
    local ltest ""
    forvalues k = `wlo'/-2 {
        local K = -`k'
        local lk`K' ""
        local nk`K' 0
        foreach g of local used {
            quietly summarize e if cohort == `g' & e < 0, meanonly
            if `k' >= r(max) continue                       // reference year or later
            egen byte tq = tag(firm_id) if cohort == `g' & e == `k'
            quietly count if tq == 1
            local m = r(N)
            drop tq
            if `m' == 0 continue
            gen byte q`g'_`K' = cohort == `g' & e == `k'
            local lterms `lterms' q`g'_`K'
            local lk`K' "`lk`K'' + `m' * q`g'_`K'"
            local nk`K' = `nk`K'' + `m'
        }
        if `nk`K'' > 0 local ltest "`ltest' ((`lk`K'') / `nk`K'' = 0)"
    }
    forvalues o = 1/2 {
        if "`ltest'" != "" {
            quietly reghdfe y`o' `dterms' `lterms', absorb(fc yc) vce(cluster firm_id)
            quietly test `ltest'
            post `a' (`v') (`o') ("before_check") (.) (.) (.) (.) (r(p))
        }
        quietly reghdfe y`o' `dterms', absorb(fc yc) vce(cluster firm_id)
        foreach g of local used {
            assert reldif(_b[d`g'], `b`v'_`g'_`o'') < 1e-6
        }
        foreach L in all early late notlast {
            if `t`L'' == 0 continue
            quietly lincom `l`L''
            post `a' (`v') (`o') ("`L'") (`t`L'') (r(estimate)) (r(se)) (r(df)) (r(p))
        }
        if `tearly' > 0 & `tlate' > 0 {
            quietly lincom (`llate') - (`learly')
            post `a' (`v') (`o') ("late_minus_early") (.) (r(estimate)) (r(se)) (r(df)) (r(p))
        }
    }
}
postclose `a'
* R2-03 / R2-04 averages (main version only), for the comparison line.
use `avg', clear
forvalues o = 1/2 {
    set obs `=_N + 1'
    replace vorder = 1 in l
    replace outcome = `o' in l
    replace row_type = "r2_0`=`o'+2'" in l
    replace b  = `r0b`o''  in l
    replace se = `r0se`o'' in l
    replace df = `r0df`o'' in l
    replace p  = `r0p`o''  in l
}
append using `est'
replace row_type = "start_year" if row_type == ""
gen double lo = b - invttail(df, 0.025) * se
gen double hi = b + invttail(df, 0.025) * se
replace p = 2 * ttail(df, abs(b / se)) if row_type == "start_year"
* % difference = 100 x (exp(b) - 1); the interval ends are converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
replace pct = . if row_type == "late_minus_early"        // a difference of two % is read in logs (b)
replace pct_lo = . if row_type == "late_minus_early"
replace pct_hi = . if row_type == "late_minus_early"
gen str40 outcome_label = cond(outcome == 1, "Value added per GJ of energy", "Value added per tonne of CO2")
gen str60 version_label = ""
replace version_label = "Main: all starters vs never-exporters"                        if vorder == 1
replace version_label = "Without doubtful energy records (importers, status unknown)"  if vorder == 2
replace version_label = "Only starters seen not exporting the year just before"       if vorder == 3
replace version_label = "Only those starters, without doubtful energy records"         if vorder == 4
quietly summarize start_year if row_type == "start_year"
local g0 = r(min)
local e1 = 0
foreach g of local cohorts {
    if `g' <= `paris_year' local e1 = `g'
}
gen str60 row_label = ""
replace row_label = "Started in " + string(start_year)                                    if row_type == "start_year"
replace row_label = "All start years (weighted by starters)"                             if row_type == "all"
replace row_label = "Started up to `paris_year' (before the Paris Agreement)"             if row_type == "early"
replace row_label = "Started after `paris_year' (after the Paris Agreement)"             if row_type == "late"
replace row_label = "All start years except `lastg' (last file: direct exports only)"    if row_type == "notlast"
replace row_label = "After-Paris average minus before-Paris average (log points)"        if row_type == "late_minus_early"
replace row_label = "Before-start check: years before vs the last one (p only)"         if row_type == "before_check"
replace row_label = "Figure R2-03 average of years 0 to +`whi' (for comparison)"         if row_type == "r2_03"
replace row_label = "Figure R2-04 average of years 0 to +`whi' (for comparison)"         if row_type == "r2_04"
gen str90 note = ""
replace note = "Fewer than `minfirms' starters seen before and after the start: no estimate" if row_type == "start_year" & missing(b)
replace note = "Includes firms that started in 2016 (no 2016 file)" if start_year == 2017 & note == ""
replace note = "Only one year after the start; the last file records direct exports only" if start_year == `lastg' & note == ""
replace note = "Each year before the start vs the last one before it, averaged over start years, tested together" if row_type == "before_check"
gen int min_firms = `minfirms'
gen int window_first = `wlo'
gen int window_last  = `whi'
gen byte rorder = 1*(row_type == "start_year") + 2*(row_type == "early") + 3*(row_type == "late") ///
    + 4*(row_type == "late_minus_early") + 5*(row_type == "all") + 6*(row_type == "notlast") + 7*(row_type == "before_check") ///
    + 8*inlist(row_type, "r2_03", "r2_04")
sort outcome vorder rorder start_year
order outcome outcome_label vorder version_label row_type row_label start_year b se lo hi p pct pct_lo pct_hi ///
      starters starters_dated st_rows_before st_rows_after comp_firms comp_rows rows doubt_rows ///
      first_year last_year files_before files_after df min_firms window_first window_last note
drop rorder
rename vorder version
format b se lo hi %9.4f
format pct pct_lo pct_hi %9.1f
format p %9.3f
format df starters starters_dated st_rows_before st_rows_after comp_firms comp_rows rows doubt_rows %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion tables (Step 8)
quietly save `ctsrc'
list outcome version row_label pct pct_lo pct_hi p starters if outcome == 1 & version <= 2, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart, value added per GJ, one dot per start year"
*---------------------------------------------------------------------------
quietly summarize p if row_type == "before_check" & outcome == 1 & version == 3
local px = cond(r(N) > 0, r(mean), 1)                   // stricter group's before-start check
local pxtxt = cond(`px' < 0.001, "p" + uchar(160) + "<" + uchar(160) + "0.001", "p" + uchar(160) + "=" + uchar(160) + string(`px', "%5.3f"))
keep if outcome == 1 & version <= 2                     // rows without a position are dropped below
* Numbers for the notes, read from the table (never typed).
local fm "%9.0f"
foreach r in all early late notlast {
    quietly summarize pct if row_type == "`r'" & version == 1
    local p_`r' = r(mean)
    quietly summarize pct_lo if row_type == "`r'" & version == 1
    local l_`r' = r(mean)
    quietly summarize pct_hi if row_type == "`r'" & version == 1
    local h_`r' = r(mean)
    local s_`r' = cond(`p_`r'' > 0, "+", "") + string(`p_`r'', "`fm'") + "%"
    local i_`r' = cond(`l_`r'' > 0, "+", "") + string(`l_`r'', "`fm'") + "% to " + cond(`h_`r'' > 0, "+", "") + string(`h_`r'', "`fm'") + "%"
}
quietly summarize pct if row_type == "all" & version == 2
local p_d = r(mean)
quietly summarize pct_lo if row_type == "all" & version == 2
local l_d = r(mean)
quietly summarize pct_hi if row_type == "all" & version == 2
local h_d = r(mean)
local s_d = cond(`p_d' > 0, "+", "") + string(`p_d', "`fm'") + "% (" + cond(`l_d' > 0, "+", "") + string(`l_d', "`fm'") ///
    + "% to " + cond(`h_d' > 0, "+", "") + string(`h_d', "`fm'") + "%)"
quietly summarize p if row_type == "late_minus_early" & version == 1
local pd = r(mean)
* p-values keep "p = 0.123" on one note line: the spaces inside are no-break
* spaces (uchar(160)), which the wrap loop below does not split on.
local nb = uchar(160)
local ptxt = cond(`pd' < 0.001, "p`nb'<`nb'0.001", "p`nb'=`nb'" + string(`pd', "%5.3f"))
local dtxt = cond(`pd' >= 0.05, "no clear difference", "a clear difference")
* Before-start check in plain words (R2-03/R2-05 wording): main version, and
* the stricter group (starters seen not exporting the year just before),
* which is in the table (version 3) but not drawn.
local btxt ""
quietly summarize p if row_type == "before_check" & version == 1
if r(N) > 0 {
    local pb = r(mean)
    local pbtxt = cond(`pb' < 0.001, "p`nb'<`nb'0.001", "p`nb'=`nb'" + string(`pb', "%5.3f"))
    if `pb' >= 0.05 {
        local btxt "Before the start: no clear difference (`pbtxt')"
        if `px' < 0.05 local btxt "`btxt', but a clear one for starters seen not exporting the year just before (`pxtxt'), a warning sign"
    }
    else local btxt "Warning: before the start, starters already changed differently from never-exporters (`pbtxt'), so the dots may partly continue that"
    local btxt "`btxt'."
}
* x positions: start years at their calendar year; the three averages to the right.
gen double x = start_year if row_type == "start_year"
local xa1 = `lastg' + 2
replace x = `xa1'     if row_type == "early"
replace x = `xa1' + 1.5 if row_type == "late"
replace x = `xa1' + 3 if row_type == "all"
drop if missing(x)                                      // rows for the notes only (not drawn)
replace x = x - 0.13 if version == 1                    // main and "without doubtful" side by side
replace x = x + 0.13 if version == 2
gen byte avg = row_type != "start_year"
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if version == 1 & !missing(pct)
* x-axis: every calendar year of the files (2016 = gap) and the three averages,
* two lines each: the year (or group), then the number of starters used.
quietly summarize starters if row_type == "early" & version == 1
local ne = r(mean)
quietly summarize starters if row_type == "late" & version == 1
local nl2 = r(mean)
quietly summarize starters if row_type == "all" & version == 1
local nall_s = r(mean)
local e0 : word 1 of `cohorts'
local xlab ""
forvalues yy = `=`e0' - 1'/`lastg' {
    quietly summarize starters if start_year == `yy' & version == 1
    local ncnt = cond(r(N) > 0, string(r(mean), "%9.0fc"), " ")
    local xlab `"`xlab' `yy' `""`yy'" "`ncnt'""'"'
}
local l1 = "`e0'–" + substr("`e1'", 3, 2)
local lt = "`=`e1'+2'–" + substr("`lastg'", 3, 2)
local xlab `"`xlab' `xa1' `""`l1'" "`=string(`ne', "%9.0fc")'""' `=`xa1'+1.5' `""`lt'" "`=string(`nl2', "%9.0fc")'""' `=`xa1'+3' `""All" "`=string(`nall_s', "%9.0fc")'""'"'
* y-axis: a round step that grows with the numbers; 0 always inside.
quietly summarize pct_lo if version == 1
local ymin = min(r(min), 0)
quietly summarize pct_hi if version == 1
local ymax = max(r(max), 0)
quietly summarize pct
local ymin = min(`ymin', r(min))
local ymax = max(`ymax', r(max))
local rng = `ymax' - `ymin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local xl = `e0' - 1.6
local xr = `xa1' + 3.6
local xp = `paris_year' + 0.5                           // Paris line: end of the Paris year
local xg = `paris_year' + 1                             // the year with no annual file
* Notes as one text, wrapped by printed width (R2-05's rule: digits, capitals
* and % run wider than most letters in Times New Roman). Widths in em.
local txt "Notes: Start = first year seen exporting after a year seen not exporting (2016 starts count as 2017). Each dot = one start"
local txt "`txt' year, from up to `=-`wlo'' years before the start to up to +`whi' from it; never-exporters = firms never seen exporting (earlier"
local txt "`txt' starters are never the comparison). Bars = 95% intervals; crossing 0 = no clear difference. Averages weighted by starters:"
local txt "`txt' all `s_all' (95% interval `i_all'); started before Paris `s_early' (`i_early'), after `s_late' (`i_late'): `dtxt'"
local txt "`txt' (`ptxt'). The last start year (`lastg') has one year after the start and its file asks only about direct exports; without it:"
local txt "`txt' `s_notlast' (`i_notlast'). `btxt' Hollow gray = without importers of unknown export status in years their energy records"
local txt "`txt' jump or drop: all `s_d'. Value added = output minus materials, energy and services bought (current prices); GJ = gigajoules."
local txt "`txt' Timing, not proof of cause; firm links are fictional."
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
twoway (function y = `ytop', range(`=`xg'-0.4' `=`xg'+0.4') recast(area) base(`ybot') fcolor(gs14) lcolor(gs14) lwidth(none)) ///
    (pci 0 `xl' 0 `xr', lcolor(gs8) lwidth(thin)) ///
    (pci `ybot' `xp' `ytop' `xp', lcolor(gs4) lpattern(shortdash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if version == 1 & !avg, lcolor(black) lwidth(thin)) ///
    (scatter pct x if version == 1 & !avg, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(9) mlabgap(0.6) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if version == 1 & avg, msymbol(D) msize(medsmall) mcolor(black) ///
        mlabel(lbl) mlabposition(9) mlabgap(1.2) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if version == 2 & !avg, msymbol(Oh) msize(small) mcolor(gs8)) ///
    (scatter pct x if version == 2 & avg, msymbol(Dh) msize(medsmall) mcolor(gs8)) ///
    (rspike pct_hi pct_lo x if version == 1 & avg, lcolor(black) lwidth(medthick)), ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1)) ///
    xtitle("Start year, then the averages; second row = starters seen before and after the start (`minfirms'+ for a dot)", size(vsmall) margin(t+1)) ///
    yscale(range(`ybot' `ytop') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(small) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") subtitle("Value added per GJ: % change after the start vs before it, starters minus never-exporters", size(small) position(11) justification(left) span) ///
    legend(order(5 "One start year" 6 "Average of start years, weighted by starters" 4 "95% interval" ///
                 7 "Without doubtful energy records (hollow gray)" 2 "0 = no difference" ///
                 3 "Paris Agreement adopted (December `paris_year')" 1 "No annual file") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Energy efficiency after firms start exporting, by start year", size(medium) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    xsize(9) ysize(7.5)

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
* (1) Points table: one row per point of the chart, left to right: each start
* year on the axis (main, then without doubtful records), then the three
* averages; axis years without a dot are included with the reason.
use `ctsrc', clear
keep if outcome == 1 & version <= 2 & inlist(row_type, "start_year", "early", "late", "all")
gen double pos = start_year if row_type == "start_year"
replace pos = `xa1'       if row_type == "early"
replace pos = `xa1' + 1.5 if row_type == "late"
replace pos = `xa1' + 3   if row_type == "all"
quietly count if !missing(pct)
local ndrawn = r(N)
* axis years with no start year in the data (first file year, 2016 = no file)
forvalues yy = `=`e0' - 1'/`lastg' {
    quietly count if start_year == `yy'
    if r(N) == 0 {
        set obs `=_N + 1'
        replace pos = `yy' in l
        replace start_year = `yy' in l
        replace row_type = "axis_only" in l
        replace version = 0 in l
    }
}
sort pos version
local nrows = _N
gen str16 t_pos = string(start_year) if inlist(row_type, "start_year", "axis_only")
replace t_pos = "`l1'" if row_type == "early"
replace t_pos = "`lt'" if row_type == "late"
replace t_pos = "All"  if row_type == "all"
gen str60 t_ser = "One start year" if version == 1 & row_type == "start_year"
replace t_ser = "Average of start years, weighted by starters" if version == 1 & row_type != "start_year"
replace t_ser = "Without doubtful energy records (hollow gray)" if version == 2
replace t_ser = "—" if version == 0
* main: whole % as the chart labels; hollow gray (no label on the chart): one decimal
gen double pv = cond(version == 1, round(pct), round(pct, 0.1))
gen double pl = cond(version == 1, round(pct_lo), round(pct_lo, 0.1))
gen double ph = cond(version == 1, round(pct_hi), round(pct_hi, 0.1))
gen str12 t_v  = ""
gen str12 t_lo = ""
gen str12 t_hi = ""
foreach c in v lo hi {
    local s = cond("`c'" == "v", "pv", cond("`c'" == "lo", "pl", "ph"))
    replace t_`c' = cond(`s' > 0, "+", "") + string(`s', "%9.0f") if version == 1 & !missing(`s')
    replace t_`c' = cond(`s' > 0, "+", "") + string(`s', "%9.1f") if version == 2 & !missing(`s')
}
gen str12 t_st = string(starters, "%12.0fc") if !missing(starters)
gen str12 t_cf = string(comp_firms, "%12.0fc") if !missing(comp_firms)
gen str12 t_r  = string(rows, "%12.0fc") if !missing(rows)
gen str90 t_status = ""
replace t_status = "drawn: solid dot and bar" if version == 1 & row_type == "start_year"
replace t_status = "drawn: solid diamond and thick bar" if version == 1 & row_type != "start_year"
replace t_status = "drawn: hollow gray circle (no bar)" if version == 2 & row_type == "start_year"
replace t_status = "drawn: hollow gray diamond (no bar)" if version == 2 & row_type != "start_year"
replace t_status = "not drawn: fewer than `minfirms' starters seen before and after the start" if version > 0 & missing(pct)
replace t_status = t_status + "; includes 2016 starts" if start_year == 2017 & version > 0
replace t_status = t_status + "; last file, one year after" if start_year == `lastg' & version > 0
replace t_status = "not drawn: no firm dated to start this year" if row_type == "axis_only"
replace t_status = "not drawn: no annual file (2016 starts count as 2017)" if row_type == "axis_only" & start_year == 2016
quietly count if strpos(t_status, "drawn:") == 1
assert r(N) == `ndrawn'
assert t_v != "" if strpos(t_status, "drawn:") == 1
assert _N == `nrows'
quietly count if pos <= `lastg'
local rl = r(N)                        // rule under the last start year, before the averages
local txt_t = itrim(`"`txt'"')
local tnote "Table: every point of Figure `exhibit', left to right, with the axis years that have no dot and why. % difference ="
local tnote "`tnote' 100 × (exp(b) − 1), b = the regression table's column (1) or (2); main rounded as the chart labels, hollow gray (no"
local tnote "`tnote' label on the chart) to one decimal. Starters = starters seen before and after the start (the axis numbers);"
local tnote "`tnote' Never-exporters and Firm-years = the start year's regression sample. Full precision: tables/`fname'.csv."
ctable_pdf t_pos t_ser t_v t_lo t_hi t_st t_cf t_r t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. Energy efficiency after firms start exporting, by start year: every plotted point") ///
    subtitle("Value added per GJ: % change after the start vs before it, starters minus never-exporters") ///
    header("Start year|or average" "Series" "%|difference" "95%|low" "95%|high" "Starters|used" "Never-|exporters" "Firm-|years" "Status") ///
    right(3 4 5 6 7 8) norepeat(1) rules(`rl') fontsize(9) perpage(24) ///
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf"

* (2) Regression table (AER style): one column per version for value added per
* GJ (1-2 drawn, 3-4 table-only), coefficient on the first line, (standard
* error) on the second. show_pct = 1 adds a third line, [% difference], for
* every start year and average: the table then runs to two pages, so it is off
* here (the drawn %s are in the points table; all versions in the CSV).
local show_pct 0
use `ctsrc', clear
keep if outcome == 1
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep if outcome == 1
keep version row_type start_year b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 version row_type start_year using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
tempname P
tempfile R
postfile `P' str70 t_lab str24(t1 t2 t3 t4) using `R'
local nterm 0
foreach g of local cohorts {
    forvalues s = 1/4 {
        quietly summarize b if row_type == "start_year" & start_year == `g' & version == `s', meanonly
        local b`s' = cond(r(N) > 0, string(r(mean), "%9.3f"), "no estimate")
        quietly summarize se if row_type == "start_year" & start_year == `g' & version == `s', meanonly
        local s`s' = cond(r(N) > 0, "(" + string(r(mean), "%9.3f") + ")", "")
        quietly summarize pct if row_type == "start_year" & start_year == `g' & version == `s', meanonly
        local p`s' = cond(r(N) > 0, "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]", "")
    }
    post `P' ("Started in `g'") ("`b1'") ("`b2'") ("`b3'") ("`b4'")
    post `P' ("")               ("`s1'") ("`s2'") ("`s3'") ("`s4'")
    if `show_pct' post `P' ("") ("`p1'") ("`p2'") ("`p3'") ("`p4'")
    local nterm = `nterm' + 2 + `show_pct'
}
local navg 0
foreach r in early late late_minus_early all notlast {
    local lab = cond("`r'" == "early", "Average, started up to `paris_year' (before Paris)", ///
        cond("`r'" == "late", "Average, started after `paris_year' (after Paris)", ///
        cond("`r'" == "late_minus_early", "After-Paris minus before-Paris average", ///
        cond("`r'" == "all", "Average, all start years", "Average, all start years except `lastg'"))))
    forvalues s = 1/4 {
        quietly summarize b if row_type == "`r'" & version == `s', meanonly
        local b`s' = cond(r(N) > 0, string(r(mean), "%9.3f"), "—")
        quietly summarize se if row_type == "`r'" & version == `s', meanonly
        local s`s' = cond(r(N) > 0, "(" + string(r(mean), "%9.3f") + ")", "")
        quietly summarize pct if row_type == "`r'" & version == `s', meanonly
        local p`s' = cond(r(N) > 0, "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]", "")
        quietly summarize p if row_type == "`r'" & version == `s', meanonly
        local q`s' = cond(r(N) == 0, "", cond(r(mean) < 0.001, "p < 0.001", "p = " + string(r(mean), "%5.3f")))
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'")
    local navg = `navg' + 2
    if "`r'" == "late_minus_early" {
        post `P' ("") ("`q1'") ("`q2'") ("`q3'") ("`q4'")
        local ++navg
    }
    else if `show_pct' {
        post `P' ("") ("`p1'") ("`p2'") ("`p3'") ("`p4'")
        local ++navg
    }
}
forvalues s = 1/4 {
    quietly summarize p if row_type == "before_check" & version == `s', meanonly
    local bp`s' = cond(r(N) == 0, "—", cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f")))
    quietly summarize starters if row_type == "all" & version == `s', meanonly
    local ns`s' = string(r(mean), "%12.0fc")
    quietly summarize rows if row_type == "start_year" & version == `s', meanonly
    local nr`s' = string(r(sum), "%12.0fc")
    quietly count if row_type == "start_year" & version == `s' & !missing(b)
    local ng`s' = string(r(N))
}
local fe_f = cond(strpos(" `ab_st' ", " firm_id "), "Yes", "No")
local fe_y = cond(strpos(" `ab_st' ", " year "), "Yes", "No")
local clu  = cond("`cl_st'" == "firm_id", "Firm", "`cl_st'")
post `P' ("Before-start test, joint p")             ("`bp1'") ("`bp2'") ("`bp3'") ("`bp4'")
post `P' ("Start years with an estimate")           ("`ng1'") ("`ng2'") ("`ng3'") ("`ng4'")
post `P' ("Starters used (all start years)")        ("`ns1'") ("`ns2'") ("`ns3'") ("`ns4'")
post `P' ("Observations (firm-years, summed over start years)") ("`nr1'") ("`nr2'") ("`nr3'") ("`nr4'")
post `P' ("Firm fixed effects (within each start year)") ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'")
post `P' ("Year fixed effects (within each start year)") ("`fe_y'") ("`fe_y'") ("`fe_y'") ("`fe_y'")
post `P' ("Weights of the averages")                ("Starters") ("Starters") ("Starters") ("Starters")
post `P' ("Standard errors clustered by")           ("`clu'") ("`clu'") ("`clu'") ("`clu'")
postclose `P'
use `R', clear
local rsub = "Outcome: log of value added per GJ. Log points; standard errors in parentheses" + cond(`show_pct', "; [% = 100 × (exp(b) − 1)]", "") + "."
local rnote "Notes: Each start-year cell is one regression of the log outcome on an after-the-start marker, with firm and year fixed"
local rnote "`rnote' effects: that year's starters (seen before and after the start; `minfirms'+ needed) and all firms never seen exporting,"
local rnote "`rnote' calendar years `=-`wlo'' before to `whi' after the start year. Averages: the start-year regressions stacked, weighted by"
local rnote "`rnote' starters. Before-start test: each year before the start vs the last one before it, averaged over start years, all zero. Columns (1) and (2) are drawn in Figure `exhibit'; (3) keeps only"
local rnote "`rnote' starters seen not exporting the year just before; (2) and (4) leave out doubtful energy records (importers of unknown"
local rnote "`rnote' export status in `doubt_yrs'). No stars."
ctable_pdf t_lab t1 t2 t3 t4 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. Energy efficiency after firms start exporting, by start year: estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Start year or average" "(1)|Main|(solid)" "(2)|No doubtful|records|(hollow gray)" "(3)|Seen not|exporting the|year before" "(4)|(3), no|doubtful|records") ///
    right(2 3 4 5) rules(`nterm' `=`nterm' + `navg'') fontsize(9) perpage(60) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------



timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
