/*==========================================================================
  R2-03  Before and after a firm starts exporting, does it get more value
         added out of each unit of energy, compared with firms that never
         export? (value added per GJ; its mirror, energy per unit of value
         added, is in the table)
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya" (same
         outcome as the previous paper's ln_va_per_gj; firm and year fixed
         effects; standard errors clustered by firm).
  Output : figures/03_energy_efficiency_export_start.png (+ .pdf)
           tables/03_energy_efficiency_export_start.csv
           tables/03_energy_efficiency_export_start_table.pdf (every plotted point)
           tables/03_energy_efficiency_export_start_regression.pdf (all four versions)
  Checks : the year window (R2-02's rule, computed here) against
           tables/02_event_time_support.csv when that table is present
  Template: R2-04 (CO2) and R2-05 (components) are this file with only the
         OUTCOME block changed.
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

* ---- THE OUTCOME: the only block R2-04 (CO2) and R2-05 (components) change ----
local exhibit "R2-03"
local fname   "03_energy_efficiency_export_start"
local yexpr   "ln(value_added_nominal / total_gj_s1)"    // drawn: log of value added per GJ
local mexpr   "ln(total_gj_s1 / value_added_nominal)"    // mirror (table only; "" if none)
local yshort  "value added per GJ of energy"                   // words for the log
local yaxis   "Value added per GJ of energy"                   // what the y-axis measures (subtitle)
local mshort  "energy (GJ) per unit of value added"             // mirror, named in the notes
local defs    "GJ = gigajoules"                                // unit defined in the notes
local ftitle  "Energy efficiency before and after firms start exporting"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: `yshort' before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export status, energy, CO2 and value added"
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
display "Step 4/8: the firms compared, and one on/off marker per year since the start"
*---------------------------------------------------------------------------
use `fy', clear
* Keep the starters (rule A) and the firms never seen exporting (the comparison
* group, all their rows). Left out: firms already exporting when first seen
* (start year unknown) and firms whose export status is never recorded.
keep if !missing(gA) | keyA == 9001
keep if usable
gen double y = `yexpr'
if `"`mexpr'"' != "" gen double ym = `mexpr'
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
display "Step 5/8: estimate with firm and year fixed effects (clustered by firm), four versions"
*---------------------------------------------------------------------------
* Log outcome on the markers, removing each firm's own average level (firm fixed
* effects) and each year's average (year fixed effects, set mostly by the
* comparison firms). A firm with one usable year cannot be compared with itself;
* reghdfe drops it and reports the number. Coefficient b = log difference from
* the firm's year before the start, net of the comparison firms' change; drawn
* as 100 x (exp(b) - 1) = % difference.
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
postfile `h' str8 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues s = 1/4 {
    quietly reghdfe y `terms' `c`s'' `if`s'', absorb(firm_id year) vce(cluster firm_id)
    local df = e(df_r)
    local N`s'  = e(N)
    local G`s'  = e(N_clust)
    local sg`s' = e(num_singletons)
    local ab`s' "`e(absvars)'"                            // for the regression table (Step 8)
    local cl`s' "`e(clustvar)'"
    local wt`s' "`e(wtype)'"
    capture drop es
    gen byte es = e(sample)
    * Joint test: all years before the start (with and without the grouped end) are 0.
    quietly test `pre'
    local F`s'  = r(F)
    local Fd`s' = r(df)
    local Fp`s' = r(p)
    quietly test `pre_in'
    local Fq`s' = r(p)
    * Average over the start year and the years after it inside the window.
    quietly lincom (`lc') / `np'
    local a`s'  = r(estimate)
    local as`s' = r(se)                                   // for the regression table (Step 8)
    local al`s' = r(estimate) - invttail(`df', 0.025) * r(se)
    local ah`s' = r(estimate) + invttail(`df', 0.025) * r(se)
    egen byte ftag = tag(firm_id) if es
    quietly count if ftag == 1 & !missing(gA)
    local st`s' = r(N)
    quietly count if ftag == 1 & keyA == 9001
    local cf`s' = r(N)
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
            post `h' ("`v`s''") ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl') (`ny')
        }
        else {
            local b  = _b[`t']
            local se = _se[`t']
            post `h' ("`v`s''") ("`t'") (`k') (inlist("`t'", "ev_lo", "ev_hi")) (0) (`b') (`se') ///
                (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl') (`ny')
        }
    }
    display "   `v`s'': " %6.0fc `N`s'' " rows, " %5.0fc `G`s'' " firms (" `st`s'' " starters), " ///
        %5.0fc `sg`s'' " one-year firms dropped; before-start test p = " %5.3f `Fp`s''
    if `s' == 1 & `"`mexpr'"' != "" {
        * The mirror outcome is minus the drawn one, so every coefficient flips sign exactly.
        matrix bmain = e(b)
        quietly reghdfe ym `terms', absorb(firm_id year) vce(cluster firm_id)
        foreach t of local terms {
            assert reldif(_b[`t'], -bmain[1, "`t'"]) < 1e-6
        }
    }
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 6/8: percentages, the mirror, and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 1*(version == "main") + 2*(version == "age2") + 3*(version == "no2017") + 4*(version == "exact")
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
* Mirror outcome: log coefficient -b, so its % = 100 x (exp(-b) - 1).
gen double mirror_b      = -b
gen double mirror_pct    = 100 * (exp(-b)  - 1)
gen double mirror_pct_lo = 100 * (exp(-hi) - 1)
gen double mirror_pct_hi = 100 * (exp(-lo) - 1)
if `"`mexpr'"' == "" {
    foreach v in mirror_b mirror_pct mirror_pct_lo mirror_pct_hi {
        replace `v' = .
    }
}
* Numbers for the whole version (repeated on each of its rows).
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_pct avg_after_pct_lo avg_after_pct_hi {
    gen double `v' = .
}
forvalues s = 1/4 {
    replace n_rows              = `N`s''  if vorder == `s'
    replace n_firms             = `G`s''  if vorder == `s'
    replace n_starters          = `st`s'' if vorder == `s'
    replace n_comparison        = `cf`s'' if vorder == `s'
    replace n_one_year_dropped  = `sg`s'' if vorder == `s'
    replace before_F            = `F`s''  if vorder == `s'
    replace before_df           = `Fd`s'' if vorder == `s'
    replace before_p            = `Fp`s'' if vorder == `s'
    replace before_p_no_grouped = `Fq`s'' if vorder == `s'
    replace avg_after_b         = `a`s''  if vorder == `s'
    replace avg_after_pct       = 100 * (exp(`a`s'')  - 1) if vorder == `s'
    replace avg_after_pct_lo    = 100 * (exp(`al`s'') - 1) if vorder == `s'
    replace avg_after_pct_hi    = 100 * (exp(`ah`s'') - 1) if vorder == `s'
}
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str60 outcome        = "`yexpr'"
gen str60 mirror_outcome = "`mexpr'"
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
sort vorder event_time
order version version_label column event_time grouped reference b se lo hi p pct pct_lo pct_hi ///
      mirror_b mirror_pct mirror_pct_lo mirror_pct_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
      window_first window_last outcome mirror_outcome note
drop term vorder
format b se lo hi mirror_b avg_after_b before_F %9.4f
format pct pct_lo pct_hi mirror_pct mirror_pct_lo mirror_pct_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi %9.1f
format p before_p before_p_no_grouped %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile ctsrc                     // same numbers, full precision, for the companion tables (Step 8)
quietly save `ctsrc'
list version column pct pct_lo pct_hi p firms firms_early firms_late if version == "main", noobs sep(0) abbreviate(24) clean
list version before_p before_p_no_grouped avg_after_pct avg_after_pct_lo avg_after_pct_hi n_rows n_starters ///
    if column == "0", noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart of the main version"
*---------------------------------------------------------------------------
* Numbers for the notes, read from the table (never typed). The stricter version's
* before-start test is read first, because only the main version is drawn.
quietly summarize before_p if version == "exact"
local pex = r(mean)
keep if version == "main"
local pp = cond(before_p[1] < 0.001, "p < 0.001", "p = " + string(before_p[1], "%5.3f"))
local px = cond(`pex' < 0.001, "p < 0.001", "p = " + string(`pex', "%5.3f"))
local t1 = cond(before_p[1] >= 0.05, "no clear difference", "a clear difference, a warning sign")
local t2 = cond(`pex' >= 0.05, "no clear difference", "a clear difference, a warning sign")
local a  = avg_after_pct[1]
local al = avg_after_pct_lo[1]
local ah = avg_after_pct_hi[1]
local avgtxt = cond(`a' > 0, "+", "") + string(`a', "%9.0f") + "% (95% interval " + cond(`al' > 0, "+", "") + string(`al', "%9.0f") ///
    + "% to " + cond(`ah' > 0, "+", "") + string(`ah', "%9.0f") + "%)"
gen double x = event_time
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !reference
gen str9 reflbl = "reference" if reference
gen double refx = x - 0.2 if reference                  // label sits just left of the start line
* x-axis: two lines per year: years since the start, then the number of starters.
local xlab ""
forvalues i = 1/`=_N' {
    local p = x[`i']
    local s = cond(`p' > 0, "+", "") + string(`p')
    if grouped[`i'] & `p' < 0 local s "≤ `p'"
    if grouped[`i'] & `p' > 0 local s "≥ +`p'"
    local n = string(firms[`i'], "%9.0fc")
    local xlab `"`xlab' `p' `""`s'" "`n'""'"'
}
* y-axis: a round step that grows with the numbers; 0 always inside.
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
* Notes as one text, wrapped below at 135 characters (the PDF runs wider than the PNG).
local mtxt ""
if `"`mexpr'"' != "" local mtxt "The table also has `mshort' (same result, other way up)."
local txt "Notes: Start = first year a firm is seen exporting after a year seen not exporting (it stays a starter if it stops later)."
local txt "`txt' Each dot is the starters' change since their year before the start, minus the same years' change among never-exporters"
local txt "`txt' (firms never seen exporting). Bars = 95% intervals; a bar crossing 0 = no clear difference. Average of years 0 to +`whi':"
local txt "`txt' `avgtxt'. Before the start, all years taken together show `t1' (`pp'; below 0.05 would be clear); starters"
local txt "`txt' seen not exporting in the year just before show `t2' (`px'). Shows timing, not proof of cause. Value added ="
local txt "`txt' output value minus materials, energy and services bought (current prices); `defs'. `mtxt'"
local txt "`txt' Firm links are fictional: this tests the method, not a finding."
local nl 0
local line ""
foreach w of local txt {
    if udstrlen(`"`line' `w'"') > 135 & `"`line'"' != "" {
        local ++nl
        local L`nl' `"`line'"'
        local line `"`w'"'
    }
    else local line = strtrim(`"`line' `w'"')
}
local ++nl
local L`nl' `"`line'"'
local notes ""
forvalues j = 1/`nl' {
    display "   note line `j': " udstrlen(`"`L`j''"') " characters"
    local notes `"`notes' "`L`j''""'
}
twoway (pci 0 `xl' 0 `xr', lcolor(gs8) lwidth(thin)) ///
    (pci `ybot' -0.5 `ytop' -0.5, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if !reference, lcolor(black) lwidth(thin)) ///
    (scatter pct x if !reference & !grouped, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if grouped, msymbol(Oh) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if reference, msymbol(D) msize(small) mcolor(gs8)) ///
    (scatter pct refx if reference, msymbol(none) mlabel(reflbl) mlabposition(6) mlabgap(1.5) ///
        mlabsize(vsmall) mlabcolor(gs6)), ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(small) noticks tlength(0) labgap(1)) ///
    xtitle("Years since the start (0 = start year); second row = number of starter firms", size(small) margin(t+1)) ///
    yscale(range(`ybot' `ytop') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(small) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") subtitle("`yaxis': % change since the year before the start, starters minus never-exporters", size(small) position(11) justification(left) span) ///
    legend(order(4 "Each single year before or after the start" 5 "Years `nout'+ before or after, combined" ///
                 6 "Year before the start (reference = 0)" 3 "95% interval" ///
                 1 "0 = no difference" 2 "Start of exporting") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
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
* (1) Points table: one row per point of the chart, left to right.
use `ctsrc', clear
keep if version == "main"
sort event_time
local npts = _N
* position exactly as on the x-axis
gen str16 t_pos = cond(event_time > 0, "+", "") + string(event_time)
replace t_pos = "≤ " + t_pos if grouped & event_time < 0
replace t_pos = "≥ " + t_pos if grouped & event_time > 0
* value and interval as the chart labels: whole-number % with a sign
gen str12 t_v  = cond(round(pct) > 0, "+", "") + string(round(pct), "%9.0f")
gen str12 t_lo = cond(round(pct_lo) > 0, "+", "") + string(round(pct_lo), "%9.0f") if !reference
gen str12 t_hi = cond(round(pct_hi) > 0, "+", "") + string(round(pct_hi), "%9.0f") if !reference
gen str12 t_n  = string(firms, "%12.0fc")
gen str12 t_r  = string(rows, "%12.0fc")
gen str90 t_status = "drawn: solid dot"
replace t_status = "drawn hollow: all years before `wlo' combined (each firm once)" if grouped & event_time < 0
replace t_status = "drawn hollow: all years after +`whi' combined (each firm once)" if grouped & event_time > 0
replace t_status = "gray diamond: reference year (0 by definition)" if reference
assert t_v != "" & t_n != ""
assert _N == `npts'
local txt_t = itrim(`"`txt'"')
local tnote "Table: every point of Figure `exhibit', left to right. % difference = 100 × (exp(b) − 1), b = column (1) of the"
local tnote "`tnote' regression table; rounded as the chart labels. Starter firms and their firm-years behind each point (the x-axis"
local tnote "`tnote' numbers). Full precision: tables/`fname'.csv."
ctable_pdf t_pos t_v t_lo t_hi t_n t_r t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("`yaxis': % change since the year before the start, starters minus never-exporters") ///
    header("Years since|the start" "%|difference" "95%|low" "95%|high" "Starter|firms" "Starter|firm-years" "Status") ///
    right(1 2 3 4 5 6) ///
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf"

* (2) Regression table (AER style): one column per version, coefficient on the
* first line, (standard error) on the second. show_pct = 1 adds a third line,
* [% difference], for every year: the table then runs to two pages, so it is
* off here (the drawn %s are in the points table; all versions in the CSV).
local show_pct 0
use `ctsrc', clear
gen byte m = 1*(version == "`v1'") + 2*(version == "`v2'") + 3*(version == "`v3'") + 4*(version == "`v4'")
assert m > 0
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1) stringcols(1 2)
keep version event_time b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 version event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9
drop b_csv
sort m event_time
tempname P
tempfile R
postfile `P' str60 t_lab str24(t1 t2 t3 t4) using `R'
levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k' & m == 1, meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k' & m == 1, meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    if `rf' {
        post `P' ("`lab' (reference, set to 0)") ("—") ("—") ("—") ("—")
        local ++nterm
        continue
    }
    forvalues s = 1/4 {
        quietly summarize b if event_time == `k' & m == `s', meanonly
        local b`s' = string(r(mean), "%9.3f")
        quietly summarize se if event_time == `k' & m == `s', meanonly
        local s`s' = "(" + string(r(mean), "%9.3f") + ")"
        quietly summarize pct if event_time == `k' & m == `s', meanonly
        local p`s' = "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'")
    if `show_pct' post `P' ("") ("`p1'") ("`p2'") ("`p3'") ("`p4'")
    local nterm = `nterm' + 2 + `show_pct'
}
* whole-model rows (the same number on every row of a version: take the first)
forvalues s = 1/4 {
    quietly summarize avg_after_b if m == `s', meanonly
    local ab`s'x = string(r(mean), "%9.3f")
    local as`s'x = "(" + string(`as`s'', "%9.3f") + ")"
    quietly summarize avg_after_pct if m == `s', meanonly
    local ap`s'x = "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
    foreach v in n_rows n_firms n_starters n_comparison {
        quietly summarize `v' if m == `s', meanonly
        local `v'`s' = string(r(mean), "%12.0fc")
    }
    foreach v in before_p before_p_no_grouped {
        quietly summarize `v' if m == `s', meanonly
        local `v'`s' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
    }
    local fe_f`s' = cond(strpos(" `ab`s'' ", " firm_id "), "Yes", "No")
    local fe_y`s' = cond(strpos(" `ab`s'' ", " year "), "Yes", "No")
    local age`s'  = cond("`c`s''" != "", "Yes", "No")
    local wgt`s'  = cond("`wt`s''" == "", "None", "`wt`s''")
    local clu`s'  = cond("`cl`s''" == "firm_id", "Firm", "`cl`s''")
}
post `P' ("Average of years 0 to +`whi'") ("`ab1x'") ("`ab2x'") ("`ab3x'") ("`ab4x'")
post `P' ("")                            ("`as1x'") ("`as2x'") ("`as3x'") ("`as4x'")
post `P' ("")                            ("`ap1x'") ("`ap2x'") ("`ap3x'") ("`ap4x'")
post `P' ("Observations (firm-years)")   ("`n_rows1'") ("`n_rows2'") ("`n_rows3'") ("`n_rows4'")
post `P' ("Firms (clusters)")            ("`n_firms1'") ("`n_firms2'") ("`n_firms3'") ("`n_firms4'")
post `P' ("Firms: starters")             ("`n_starters1'") ("`n_starters2'") ("`n_starters3'") ("`n_starters4'")
post `P' ("Firms: never-exporters")      ("`n_comparison1'") ("`n_comparison2'") ("`n_comparison3'") ("`n_comparison4'")
post `P' ("Firm fixed effects")          ("`fe_f1'") ("`fe_f2'") ("`fe_f3'") ("`fe_f4'")
post `P' ("Year fixed effects")          ("`fe_y1'") ("`fe_y2'") ("`fe_y3'") ("`fe_y4'")
post `P' ("Age squared (years in the file)") ("`age1'") ("`age2'") ("`age3'") ("`age4'")
post `P' ("Weights")                     ("`wgt1'") ("`wgt2'") ("`wgt3'") ("`wgt4'")
post `P' ("Standard errors clustered by") ("`clu1'") ("`clu2'") ("`clu3'") ("`clu4'")
post `P' ("Before-start test, joint p")  ("`before_p1'") ("`before_p2'") ("`before_p3'") ("`before_p4'")
post `P' ("Same, grouped end left out") ("`before_p_no_grouped1'") ("`before_p_no_grouped2'") ("`before_p_no_grouped3'") ("`before_p_no_grouped4'")
postclose `P'
use `R', clear
local rsub "Outcome: log of `yshort'. Log points; standard errors in parentheses; [% = 100 × (exp(b) − 1)]"
local rsub = cond(`show_pct', "`rsub'.", "`rsub' for the average.")
local rnote "Notes: Each column is one regression of the log outcome on one marker per year since the export start, `wlo' to +`whi',"
local rnote "`rnote' except -1 (the year before the start: the reference, set to 0), and one marker for each grouped end (`nout'+ years"
local rnote "`rnote' before or after), with firm and year fixed effects; firms never seen exporting are 0 on every marker. Column (1)"
local rnote "`rnote' is drawn in Figure `exhibit'. Sample: starters (first year seen exporting after a year seen not exporting) and"
local rnote "`rnote' firms never seen exporting; rows with energy, CO2 and value added above zero; firms with one usable year dropped."
local rnote "`rnote' Before-start test: all years before the start are 0 together. Average = mean of years 0 to +`whi'. No stars."
ctable_pdf t_lab t1 t2 t3 t4 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Years since the start" "(1)|Main" "(2)|Adds age|squared" "(3)|Without the|2017 starters" "(4)|Seen not exporting|the year before") ///
    right(2 3 4 5) rules(`nterm' `=`nterm' + 3') fontsize(9) perpage(60) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------


timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
