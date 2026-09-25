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
display "Step 1/7: load export and import status, energy, CO2 and value added"
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
display "Step 2/7: date each firm's export start under two rules (same code in every R2 file)"
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
display "Step 3/7: set the year window (R2-02's rule) and check it against R2-02's table if present"
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
display "Step 4/7: the firms compared, doubtful energy records, and R2-03's average for the notes"
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
display "Step 5/7: one before/after comparison per start year (firm and year fixed effects, clustered by firm)"
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
display "Step 6/7: averages over start years (weighted by starters) and the CSV"
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
list outcome version row_label pct pct_lo pct_hi p starters if outcome == 1 & version <= 2, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 7/7: dot-and-whisker chart, value added per GJ, one dot per start year"
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

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
