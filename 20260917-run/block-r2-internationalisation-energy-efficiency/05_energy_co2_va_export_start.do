/*==========================================================================
  R2-05  When a firm starts exporting, what moves: its energy use, its CO2,
         or its value added? The same before/after comparison as R2-03 and
         R2-04, run on each of the three separately, so a change in value
         added per GJ (or per tonne of CO2) can be traced to its parts.
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya" (firm and
         year fixed effects; standard errors clustered by firm).
  Output : figures/05_energy_co2_va_export_start.png (+ .pdf)
           tables/05_energy_co2_va_export_start.csv
  Checks : the year window (R2-02's rule, computed here) against
           tables/02_event_time_support.csv when that table is present;
           value added minus energy = Figure R2-03, value added minus CO2 =
           Figure R2-04 (exact in this file; against their tables if present)
  Template: R2-03 with the OUTCOME block, Step 4 (outcomes), Step 5 (a loop
         over the three outcomes + the identity check), Step 6 (CSV) and
         Step 7 (three panels) changed; Steps 1-3 unchanged.
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

* ---- THE OUTCOMES: three drawn (one panel each), two efficiency ratios checked ----
local exhibit "R2-05"
local fname   "05_energy_co2_va_export_start"
local ftitle  "Energy, CO2 and value added when firms start exporting"
local y1 "ln(total_gj_s1)"                   // panel 1: log of energy use (GJ)
local y2 "ln(co2_total_s1)"                  // panel 2: log of CO2 (tonnes)
local y3 "ln(value_added_nominal)"           // panel 3: log of value added
local n1 "Energy use (GJ)"                   // panel titles, with units
local n2 "CO2 (tonnes; calculated from energy use at standard rates, not measured)"
local n3 "Value added (current prices)"
local w1 "energy use"                        // words for the notes
local w2 "CO2"
local w3 "value added"
* Efficiency ratios of Figures R2-03 and R2-04 (not drawn): ratio r = outcome 3 minus outcome r.
local q1 "ln(value_added_nominal / total_gj_s1)"     // Figure R2-03 = value added minus energy use
local q2 "ln(value_added_nominal / co2_total_s1)"    // Figure R2-04 = value added minus CO2
local qf1 "03_energy_efficiency_export_start"
local qf2 "04_co2_efficiency_export_start"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy use, CO2 and value added before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load export status, energy, CO2 and value added"
*---------------------------------------------------------------------------
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
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
display "Step 4/7: the firms compared, the three outcomes, and one on/off marker per year since the start"
*---------------------------------------------------------------------------
use `fy', clear
* Keep the starters (rule A) and the firms never seen exporting (the comparison
* group, all their rows). Left out: firms already exporting when first seen
* (start year unknown) and firms whose export status is never recorded.
keep if !missing(gA) | keyA == 9001
keep if usable
* The three drawn outcomes (logs) and the two efficiency ratios, on the same rows.
forvalues o = 1/3 {
    gen double y`o' = `y`o''
}
forvalues r = 1/2 {
    gen double q`r' = `q`r''
    assert reldif(q`r', y3 - y`r') < 1e-9               // ratio = value added minus the other, in logs
}
* The previous paper's control, used in one variant only: firm "age" squared,
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
display "Step 5/7: estimate each outcome with firm and year fixed effects (clustered by firm), four versions"
*---------------------------------------------------------------------------
* Log outcome on the markers, removing each firm's own average level (firm fixed
* effects) and each year's average (year fixed effects, set mostly by the
* comparison firms). A firm with one usable year cannot be compared with itself;
* reghdfe drops it and reports the number. Coefficient b = log difference from
* the firm's year before the start, net of the comparison firms' change; drawn
* as 100 x (exp(b) - 1) = % difference. Same rows and markers for all outcomes.
* Versions (the figure shows "main"; the others are in the table):
*   age2   = adds the previous paper's control (age squared, see Step 4)
*   no2017 = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact  = keeps only starters seen not exporting the year just before
local v1 "main"
local v2 "age2"
local v3 "no2017"
local v4 "exact"
local c2 "age2"
local if3 "if gA != 2017"                               // comparison firms (gA missing) stay
local if4 "if missing(gA) | exactA == 1"
local lc = subinstr("`post'", " ", " + ", .)            // years 0..+`whi', for the average
local np : word count `post'
tempname h
postfile `h' byte outcome str8 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues o = 1/3 {
  forvalues s = 1/4 {
    quietly reghdfe y`o' `terms' `c`s'' `if`s'', absorb(firm_id year) vce(cluster firm_id)
    matrix B`o'_`s' = e(b)
    local df = e(df_r)
    local N`o'_`s'  = e(N)
    local G`o'_`s'  = e(N_clust)
    local sg`o'_`s' = e(num_singletons)
    assert e(N) == `N1_`s''                             // same rows for every outcome
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
    local al`o'_`s' = r(estimate) - invttail(`df', 0.025) * r(se)
    local ah`o'_`s' = r(estimate) + invttail(`df', 0.025) * r(se)
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
    local pshow = cond(`Fp`o'_`s'' < 0.001, "< 0.001", "= " + string(`Fp`o'_`s'', "%5.3f"))
    display "   `w`o'', `v`s'': " %6.0fc `N`o'_`s'' " rows, " %5.0fc `G`o'_`s'' " firms (" `st`o'_`s'' " starters), " ///
        %5.0fc `sg`o'_`s'' " one-year firms dropped; before-start test p `pshow'"
  }
}
postclose `h'
* The identity: value added per GJ (R2-03) = value added minus energy use, and
* value added per tonne of CO2 (R2-04) = value added minus CO2, in logs. Same rows
* and markers, so every coefficient must match exactly; checked for all versions.
forvalues r = 1/2 {
    forvalues s = 1/4 {
        quietly reghdfe q`r' `terms' `c`s'' `if`s'', absorb(firm_id year) vce(cluster firm_id)
        assert e(N) == `N1_`s''
        matrix Q`r'_`s' = e(b)
        foreach t of local terms {
            assert reldif(_b[`t'], B3_`s'[1, "`t'"] - B`r'_`s'[1, "`t'"]) < 1e-6
        }
    }
}
display "   identity holds at every point: value added minus energy use = R2-03; value added minus CO2 = R2-04"

*---------------------------------------------------------------------------
display "Step 6/7: percentages, the link to R2-03 and R2-04, and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 1*(version == "main") + 2*(version == "age2") + 3*(version == "no2017") + 4*(version == "exact")
label define outc 1 "`n1'" 2 "`n2'" 3 "`n3'"
label values outcome outc
decode outcome, gen(outcome_label)
gen str40 outcome_log = ""
forvalues o = 1/3 {
    replace outcome_log = "`y`o''" if outcome == `o'
}
gen str70 version_label = ""
replace version_label = "Main: all starters vs never exporters; firm and year fixed effects" if vorder == 1
replace version_label = "Adds the previous paper's control: age squared (years in the file)" if vorder == 2
replace version_label = "Without the 2017 starters (they may have started in 2016)"         if vorder == 3
replace version_label = "Only starters seen not exporting the year just before"             if vorder == 4
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if term == "ev_lo"
replace column = "+`nout' or later (grouped)"      if term == "ev_hi"
* % difference = 100 x (exp(b) - 1); the interval ends are converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
* Link to the efficiency figures (energy and CO2 rows only): value added's b minus
* this row's b = the matching R2-03 (energy) or R2-04 (CO2) coefficient; ratio_b is
* that coefficient estimated directly (identical, asserted in Step 5).
gen double va_minus_this_b = .
gen double ratio_b = .
gen str40 ratio_outcome = ""
gen str6 ratio_figure = ""
forvalues s = 1/4 {
    forvalues i = 1/`=_N' {
        if vorder[`i'] != `s' | outcome[`i'] == 3 continue
        local r = outcome[`i']
        local t = term[`i']
        if "`t'" == "ev_ref" {
            quietly replace va_minus_this_b = 0 in `i'
            quietly replace ratio_b = 0 in `i'
        }
        else {
            quietly replace va_minus_this_b = B3_`s'[1, "`t'"] - B`r'_`s'[1, "`t'"] in `i'
            quietly replace ratio_b = Q`r'_`s'[1, "`t'"] in `i'
        }
    }
}
forvalues r = 1/2 {
    replace ratio_outcome = "`q`r''" if outcome == `r'
    replace ratio_figure  = "R2-0`=`r'+2'" if outcome == `r'
}
* Numbers for the whole outcome x version (repeated on each of its rows).
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_pct avg_after_pct_lo avg_after_pct_hi {
    gen double `v' = .
}
forvalues o = 1/3 {
    forvalues s = 1/4 {
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
            replace avg_after_pct       = 100 * (exp(`a`o'_`s'')  - 1) if `c'
            replace avg_after_pct_lo    = 100 * (exp(`al`o'_`s'') - 1) if `c'
            replace avg_after_pct_hi    = 100 * (exp(`ah`o'_`s'') - 1) if `c'
        }
    }
}
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
* If R2-03's / R2-04's tables are present, value added minus energy use (or CO2)
* must reproduce their coefficients to the 4 decimals they are written with.
forvalues r = 1/2 {
    capture confirm file "tables/`qf`r''.csv"
    if _rc {
        display "   tables/`qf`r''.csv not found: table cross-check skipped (the exact check in Step 5 still ran)"
        continue
    }
    preserve
    import delimited using "tables/`qf`r''.csv", clear varnames(1)
    keep version event_time b
    rename b fig_b
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == `r'
    merge 1:1 version event_time using `fig', keep(master match using)
    quietly count if _merge != 3 | abs(va_minus_this_b - fig_b) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "tables/`qf`r''.csv does not match (window or data differ): re-run `qf`r''.do."
        exit 459
    }
    quietly summarize fig_b
    display "   R2-0`=`r'+2' table: all " r(N) " coefficients reproduced to 4 decimals"
    restore
}
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
sort outcome vorder event_time
order outcome outcome_label outcome_log version version_label column event_time grouped reference b se lo hi p ///
      pct pct_lo pct_hi va_minus_this_b ratio_b ratio_outcome ratio_figure firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
      window_first window_last note
drop term vorder
label values outcome                                    // CSV keeps the number; outcome_label has the words
format b se lo hi va_minus_this_b ratio_b avg_after_b before_F %9.4f
format pct pct_lo pct_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi %9.1f
format p before_p before_p_no_grouped %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
list outcome column pct pct_lo pct_hi p firms if version == "main", noobs sepby(outcome) abbreviate(24) clean
list outcome version before_p before_p_no_grouped avg_after_pct avg_after_pct_lo avg_after_pct_hi n_rows n_starters ///
    if column == "0", noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 7/7: three panels on one scale, main version"
*---------------------------------------------------------------------------
* Numbers for the notes, read from the table (never typed).
forvalues o = 1/3 {
    quietly summarize before_p if version == "exact" & outcome == `o'
    local pex`o' = r(mean)
}
keep if version == "main"
* Average of years 0..+5 per outcome, and the before-start check sorted into
* outcomes with a clear difference (p below 0.05, a warning sign) and without.
local avgtxt ""
foreach L in fail pass xfail {
    local n`L' 0
}
forvalues o = 1/3 {
    quietly summarize avg_after_pct if outcome == `o'
    local a = r(mean)
    quietly summarize avg_after_pct_lo if outcome == `o'
    local al = r(mean)
    quietly summarize avg_after_pct_hi if outcome == `o'
    local ah = r(mean)
    local sep = cond(`o' == 3, " and ", cond(`o' == 1, "", ", "))
    local iv  = cond(`o' == 1, "95% interval ", "")
    local avgtxt = "`avgtxt'`sep'`w`o'' " + cond(`a' > 0, "+", "") + string(`a', "%9.0f") + "% (`iv'" ///
        + cond(`al' > 0, "+", "") + string(`al', "%9.0f") + "% to " + cond(`ah' > 0, "+", "") + string(`ah', "%9.0f") + "%)"
    quietly summarize before_p if outcome == `o'
    local pv = r(mean)
    local pt = "`w`o'' (" + cond(`pv' < 0.001, "p < 0.001", "p = " + string(`pv', "%5.3f")) + ")"
    if `pv' < 0.05 {
        local ++nfail
        local fail`nfail' "`pt'"
    }
    else {
        local ++npass
        local pass`npass' "`pt'"
    }
    * The stricter group (starters seen not exporting the year just before) is
    * named only where it shows a clear difference and all starters do not.
    if `pex`o'' < 0.05 & `pv' >= 0.05 {
        local ++nxfail
        local xfail`nxfail' = "`w`o'' (" + cond(`pex`o'' < 0.001, "p < 0.001", "p = " + string(`pex`o'', "%5.3f")) + ")"
    }
}
foreach L in fail pass xfail {                           // "a", "a and b", "a, b and c"
    local `L'txt ""
    forvalues j = 1/`n`L'' {
        local sep = cond(`j' == 1, "", cond(`j' == `n`L'', " and ", ", "))
        local `L'txt "``L'txt'`sep'``L'`j''"
    }
}
* Before-start check in plain words: starters already changing differently from
* never-exporters before the start means the later dots may partly continue that.
if `nfail' == 0 local btxt "Before the start, starters did not clearly change differently from never-exporters (p below 0.05 would be clear): `passtxt'."
else {
    local btxt "Warning: before the start, starters' `failtxt' already changed differently from never-exporters' (p below 0.05 = clear),"
    local btxt "`btxt' so later dots may partly continue that"
    if `npass' > 0 local btxt "`btxt'; `passtxt' did not"
    local btxt "`btxt'."
}
if `nxfail' > 0 local btxt "`btxt' Among starters seen not exporting the year just before, `xfailtxt' did too."
gen double x = event_time
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !reference
gen str9 reflbl = "reference" if reference & outcome == 1   // written once, in the top panel
gen double refx = x - 0.2 if reference                  // label sits just left of the start line
* x-axis (shown under the bottom panel): years since the start, then the number of
* starters (the same firms in all three panels).
local xlab ""
forvalues i = 1/`=_N' {
    if outcome[`i'] != 1 continue
    local p = x[`i']
    local s = cond(`p' > 0, "+", "") + string(`p')
    if grouped[`i'] & `p' < 0 local s "≤ `p'"
    if grouped[`i'] & `p' > 0 local s "≥ +`p'"
    local n = string(firms[`i'], "%9.0fc")
    local xlab `"`xlab' `p' `""`s'" "`n'""'"'
}
* y-axis: one scale for all three panels; a round step that grows with the numbers; 0 always inside.
quietly summarize pct_lo
local ymin = min(r(min), 0)
quietly summarize pct_hi
local ymax = max(r(max), 0)
local rng = `ymax' - `ymin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")           // no repeated labels if the step is below 1
local xl = `wlo' - 1.6
local xr = `whi' + 1.6
* Reference lines as data (one row per panel), so every panel draws them: 0 line and start line.
gen double zl_y = 0          if reference
gen double zl_x0 = `xl'      if reference
gen double zl_x1 = `xr'      if reference
gen double sl_x = -0.5       if reference
gen double sl_y0 = `ybot'    if reference
gen double sl_y1 = `ytop'    if reference
* Notes as one text, wrapped below by printed width, not by letter count: in Times
* New Roman digits, capitals and % are wider than most letters, so a line full of
* numbers would run past the PDF edge. Widths are in em (about one letter "m").
local txt "Notes: Start = first year a firm is seen exporting after a year seen not exporting; never-exporters = firms never seen exporting."
local txt "`txt' Bars = 95% intervals; a bar crossing 0 = no clear difference. Average of years 0 to +`whi': `avgtxt'."
local txt "`txt' Value added per GJ (Figure R2-03) rises where the value added dot is above the energy use dot; if energy use is not"
local txt "`txt' below 0, that rise is more value added, not less energy (CO2: Figure R2-04). `btxt' Value added = output value"
local txt "`txt' minus materials, energy and services bought (current prices); GJ = gigajoules. Timing, not proof of cause; firm links"
local txt "`txt' are fictional: a test of the method only."
local maxw 53.5                                         // widest note line that fits the 9-inch PDF
local nl 0
local line ""
local lw 0
foreach w of local txt {
    * printed width of this word: narrow, wide, %, digits, other letters
    local n  = ustrlen(`"`w'"')
    local na = `n' - ustrlen(ustrregexra(`"`w'"', "[ijltfr.,;:'()\-]", ""))
    local wi = `n' - ustrlen(ustrregexra(`"`w'"', "[A-Zmw]", ""))
    local pc = `n' - ustrlen(ustrregexra(`"`w'"', "%", ""))
    local dg = `n' - ustrlen(ustrregexra(`"`w'"', "[0-9+=]", ""))
    local ww = 0.29*`na' + 0.7*`wi' + 0.83*`pc' + 0.52*`dg' + 0.47*(`n' - `na' - `wi' - `pc' - `dg')
    local try = `lw' + 0.25*(`"`line'"' != "") + `ww'  // 0.25 = one space
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
label values outcome outc                               // panel titles = outcome names with units
twoway (pcspike zl_y zl_x0 zl_y zl_x1, lcolor(gs8) lwidth(thin)) ///
    (pcspike sl_y0 sl_x sl_y1 sl_x, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if !reference, lcolor(black) lwidth(thin)) ///
    (scatter pct x if !reference & !grouped, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if grouped, msymbol(Oh) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if reference, msymbol(D) msize(small) mcolor(gs8)) ///
    (scatter pct refx if reference, msymbol(none) mlabel(reflbl) mlabposition(6) mlabgap(1.5) ///
        mlabsize(vsmall) mlabcolor(gs6)), ///
    by(outcome, cols(1) iscale(1) imargin(tiny) scale(`=7.5/9') /// text as in R2-03 (9 x 7.5 in)
        title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
        subtitle("% change since the year before the start, starters minus never-exporters (same scale in every panel)", ///
            size(small) position(11) justification(left) span) ///
        note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
        legend(position(6)) graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none))) ///
    subtitle(, size(small) position(11) justification(left) nobox fcolor(white) lcolor(white) margin(b+1)) ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(small) noticks tlength(0) labgap(1)) ///
    xtitle("Years since the start (0 = start year); second row = number of starter firms", size(small) margin(t+1)) ///
    yscale(range(`ybot' `ytop') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(small) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") ///
    legend(order(4 "Each single year before or after the start" 5 "Years `nout'+ before or after, combined" ///
                 6 "Year before the start (reference = 0)" 3 "95% interval" ///
                 1 "0 = no difference" 2 "Start of exporting") ///
        cols(2) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(9) ysize(12)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
