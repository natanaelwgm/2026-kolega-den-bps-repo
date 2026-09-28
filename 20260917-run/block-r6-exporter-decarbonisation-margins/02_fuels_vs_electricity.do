/*==========================================================================
  R6-02  When a firm starts exporting, does it burn more fuel, buy more
         electricity, or both? Fuels burned on site (the source of "scope 1"
         CO2) and electricity bought from PLN and other suppliers (the source
         of "scope 2" CO2), before and after the export start, on the same
         firm-years (rows where the firm uses both), plus the firms that use
         none of one (share burning no fuel / buying no electricity).
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use".
  Output : figures/02_fuels_vs_electricity.png (+ .pdf)
           tables/02_fuels_vs_electricity.csv
           tables/02_fuels_vs_electricity_table.pdf       (every plotted point)
           tables/02_fuels_vs_electricity_regression.pdf  (the regressions)
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Checks : the start years, comparison group, usable rows, doubtful records,
           year window and model are R6-01's (block "R6 EXPORT-START SAMPLE",
           copied unchanged). CO2 from bought electricity must move exactly
           with bought electricity, and CO2 from fuels exactly with fuels plus
           CO2 per GJ of fuels, at every point (asserted). When R6-01's table
           is present, energy used on all usable rows must reproduce its row
           (4) to 4 decimals or the file stops.
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
* R2's and R6's blocks sit next to block-0; their tables are used only for the
* cross-checks (if a folder is not there, its check is skipped and the file runs).
global R2DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r2-internationalisation-energy-efficiency", 1)
global R6DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r6-exporter-decarbonisation-margins", 1)
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE ROWS: what is estimated, on which firm-years, in which unit ----
* y = outcome; smp = firm-years used (Step 3); u = 1 log (drawn as %), 2 share (points)
local exhibit "R6-02"
local fname   "02_fuels_vs_electricity"
local ftitle  "Fuels burned and bought electricity after an export start"
local y1  "ln(gj_fuel_s1)"                       // (a) drawn: fuels burned, GJ
local y2  "ln(gj_electricity)"                   // (b) drawn: bought electricity, GJ
local y3  "ln(total_gj_s1)"                      // energy used = fuels + bought electricity
local y4  "ln(co2_scope1_s1)"                    // CO2 from fuels burned (scope 1) = (1) + (6)
local y5  "ln(co2_scope2_s1)"                    // CO2 from bought electricity (scope 2) = (2) exactly
local y6  "ln(co2_scope1_s1 / gj_fuel_s1)"       // CO2 per GJ of fuels: moves only with the fuel mix
local y7  "ln(value_added_nominal)"              // value added on the same rows (for scale)
local y8  "ln(gj_fuel_s1)"                       // fuels, on every usable row that burns fuel
local y9  "ln(gj_electricity)"                   // bought electricity, on every usable row that buys it
local y10 "ln(total_gj_s1)"                      // energy used, all usable rows (= R6-01 row 4)
local y11 "100 * (gj_fuel_s1 == 0)"              // burns no fuel (0 or 100)
local y12 "100 * (gj_electricity == 0)"          // buys no electricity (0 or 100)
local nall 12
forvalues o = 1/7 {
    local smp`o' "s_both"                         // rows with both fuels and bought electricity > 0
    local u`o' 1
}
local smp8  "s_fuel"
local smp9  "s_elec"
local smp10 "usable"
local smp11 "s_all"
local smp12 "s_all"
forvalues o = 8/10 {
    local u`o' 1
}
local u11 2
local u12 2
local n1  "(a) Fuels burned (GJ): diesel, petrol, coal, gas and other fuels"   // panel titles
local n2  "(b) Bought electricity (GJ): from PLN and other suppliers"
local n3  "Energy used, GJ (fuels + bought electricity)"
local n4  "CO2 from fuels burned (scope 1), tonnes"
local n5  "CO2 from bought electricity (scope 2), tonnes"
local n6  "CO2 per GJ of fuels (the fuel mix)"
local n7  "Value added (current prices)"
local n8  "Fuels burned, GJ: every row that burns fuel"
local n9  "Bought electricity, GJ: every row that buys it"
local n10 "Energy used, GJ: all usable rows (= R6-01 row 4)"
local n11 "Burns no fuel (% of firm-years)"
local n12 "Buys no electricity (% of firm-years)"
local w1  "fuels burned"                           // words for the notes
local w2  "bought electricity"
local w3  "energy used"
local w4  "CO2 from fuels"
local w6  "CO2 per GJ of fuels"
local w7  "value added"
local w8  "fuels burned"
local w9  "bought electricity"
local w11 "share burning no fuel"
local w12 "share buying no electricity"
local rw1 "Both fuels and bought electricity above 0"   // firm-years used, in words
local rw8 "Fuels above 0"
local rw9 "Bought electricity above 0"
local rw10 "Usable (energy, CO2 and value added above 0)"
local rw11 "All rows of the firms compared"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: fuels burned and bought electricity before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, fuels, bought electricity, CO2 and value added; check the add-ons"
*---------------------------------------------------------------------------
* The regressions need reghdfe (with ftools and require). Nothing is installed here.
foreach p in reghdfe ftools require {
    capture which `p'
    if _rc {
        display as error "This file needs the Stata add-on `p': type  ssc install `p'  once (see INDEX.md), then run it again."
        exit 199
    }
}
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* import_flag         = imports raw materials (used for the doubtful energy records)
* total_gj_s1         = energy use in GJ = gj_fuel_s1 + gj_electricity
* gj_fuel_s1          = fuels burned on site, GJ (diesel, petrol, kerosene, coal,
*                       coal briquettes, LPG, city gas, other gas, coke)
* gj_electricity      = electricity bought from PLN and other suppliers, GJ
*                       (kWh x 0.0036); electricity the firm makes itself is NOT
*                       in it (the fuel for its generators is in gj_fuel_s1)
* co2_total_s1        = CO2 tonnes = co2_scope1_s1 + co2_scope2_s1
* co2_scope1_s1       = CO2 from fuels burned (fixed rate per GJ of each fuel)
* co2_scope2_s1       = CO2 from bought electricity (one national rate per kWh a year)
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag import_flag total_gj_s1 gj_fuel_s1 gj_electricity co2_total_s1 ///
    co2_scope1_s1 co2_scope2_s1 value_added_nominal using "$DATA", clear
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
display "Step 3/8: the firm-years behind each row, checks on the data, and the rows with no fuel or no bought electricity"
*---------------------------------------------------------------------------
* The same firms as the sample above (starters and never-exporters), with ALL
* their rows, so that rows with no fuel or no bought electricity can be counted
* and studied too. The usable rows among them are exactly the R6 sample.
tempfile all
use `fy', clear
keep if !missing(gA) | keyA == 9001
keep if value_added_nominal > 0 & !missing(value_added_nominal)
gen byte never = missing(gA)
quietly count if usable
local nus = r(N)
preserve
use `smp', clear
assert _N == `nus'                                      // usable rows here = the R6 sample
restore
* Firm-years used by each row (see the top of the file):
*   s_both = both fuels and bought electricity above 0 (the drawn panels), so
*            (a) and (b) compare the same firms in the same years
*   s_fuel = fuels above 0; s_elec = bought electricity above 0 (each on its own rows)
*   s_all  = every row of these firms (for "burns no fuel" / "buys no electricity")
gen byte s_all  = 1
gen byte s_fuel = usable & gj_fuel_s1 > 0 & !missing(gj_fuel_s1)
gen byte s_elec = usable & gj_electricity > 0 & !missing(gj_electricity)
gen byte s_both = s_fuel & s_elec
* Checks on the data (the rows below rely on them):
* energy used = fuels + bought electricity; CO2 = CO2 from fuels + from electricity;
* CO2 from fuels is above 0 exactly when fuels are (same for electricity).
assert reldif(total_gj_s1, gj_fuel_s1 + gj_electricity) < 1e-9
assert reldif(co2_total_s1, co2_scope1_s1 + co2_scope2_s1) < 1e-9
assert (co2_scope1_s1 > 0) == (gj_fuel_s1 > 0)
assert (co2_scope2_s1 > 0) == (gj_electricity > 0)
* CO2 from bought electricity = GJ x one national rate for the year, the same for
* every firm: its log differs from log GJ only by a year number, which the year
* fixed effects remove. So its results must equal panel (b)'s exactly (Step 4).
gen double r_s2 = ln(co2_scope2_s1 / gj_electricity) if gj_electricity > 0
bysort year: egen double sd_s2 = sd(r_s2)
assert sd_s2 < 1e-9 | missing(sd_s2)
drop r_s2 sd_s2
sort firm_id year
* Rows with none of one (reported, not hidden):
quietly count if s_both
local n_both = r(N)
quietly count if usable & gj_fuel_s1 == 0
local z_fuel = r(N)
quietly count if usable & gj_electricity == 0
local z_elec = r(N)
quietly count if !usable
local z_none = r(N)
quietly count if !usable & total_gj_s1 > 0
assert r(N) == 0                                        // value added is above 0: not usable = no energy at all
display "   " %6.0fc _N " rows of starters and never-exporters: " %6.0fc `nus' " usable (the R6 sample), of which " ///
    %6.0fc `n_both' " use both fuels and bought electricity, " %5.0fc `z_fuel' " burn no fuel, " %5.0fc `z_elec' " buy no electricity;"
display "   " %5.0fc `z_none' " more rows record no energy at all (not usable; counted in the no-fuel / no-electricity rows only)"
gen double nofuel = 100 * (gj_fuel_s1 == 0)
gen double noelec = 100 * (gj_electricity == 0)
display "   % of rows with no fuel / no bought electricity, by year (all rows of these firms):"
tabstat nofuel noelec, by(year) stat(mean n) format(%6.1f) nototal
drop nofuel noelec
save `all'

*---------------------------------------------------------------------------
display "Step 4/8: estimate every row with firm and year fixed effects (clustered by firm), five versions"
*---------------------------------------------------------------------------
* R6-01's model (R2-03's): the outcome on one marker per year since the start,
* removing each firm's own average (firm fixed effects) and each year's average
* (year fixed effects, set mostly by the comparison firms). A firm with one row
* used cannot be compared with itself; reghdfe drops it and reports the number.
* Log rows: b = log difference from the firm's year before the start, net of the
* never-exporters' change; % = 100 x (exp(b) - 1). Share rows (0 or 100): b =
* difference in percentage points.
* Versions (the chart shows "main"; all are in the CSV):
*   main       = the R6 sample
*   nodoubt    = without doubtful energy records (Step 2)
*   no2017     = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact      = keeps only starters seen not exporting the year just before
*   no2017rows = without the 2017 rows (that year far more firms burn coal: a
*                recording change is likely)
local nv 5
local v1 "main"
local v2 "nodoubt"
local v3 "no2017"
local v4 "exact"
local v5 "no2017rows"
local e1 "1"
local e2 "!doubt"
local e3 "gA != 2017"                                   // comparison firms (gA missing) stay
local e4 "missing(gA) | exactA == 1"
local e5 "year != 2017"
tempname h
postfile `h' byte outcome str10 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues s = 1/`nv' {
    use `all', clear
    keep if `e`s''
    forvalues o = 1/`nall' {
        gen double y`o' = `y`o'' if `smp`o''
    }
    * One marker per year since the start inside the window, except -1 (the year
    * before the start = the reference, 0 by definition), plus one marker for each
    * grouped end. Comparison firms are 0 on every marker. A marker with no starter
    * row among a row's firm-years is left out (R2-08).
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
    gen byte ev_ref = (kA == -1)                        // for the counts only
    forvalues o = 1/`nall' {
        local terms ""
        local pre ""
        local pre_in ""
        local post ""
        foreach t of local cand {
            quietly count if `t' & !missing(y`o')
            if r(N) == 0 continue
            local terms `terms' `t'
            if "`t'" == "ev_lo" local pre `pre' `t'
            else if substr("`t'", 4, 1) == "m" {
                local pre `pre' `t'
                local pre_in `pre_in' `t'               // years before the start, grouped end left out
            }
            else if "`t'" != "ev_hi" local post `post' `t'
        }
        local terms`o'_`s' `terms'
        local lc = subinstr("`post'", " ", " + ", .)    // years 0..+`whi', for the average
        local np : word count `post'
        quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
        matrix B`o'_`s' = e(b)
        local df = e(df_r)
        local N`o'_`s'  = e(N)
        local G`o'_`s'  = e(N_clust)
        local sg`o'_`s' = e(num_singletons)
        if `o' <= 7 assert e(N) == `N1_`s''             // rows 1-7: the same firm-years
        capture drop es
        gen byte es = e(sample)
        foreach t of local terms {
            assert _se[`t'] > 0 & !missing(_se[`t'])     // no marker silently dropped
        }
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
    * Exact links, marker by marker (rows 1-7 share their firm-years):
    *   CO2 from bought electricity (5) = bought electricity (2)
    *   CO2 from fuels (4) = fuels burned (1) + CO2 per GJ of fuels (6)
    assert "`terms5_`s''" == "`terms2_`s''" & "`terms4_`s''" == "`terms1_`s''" & "`terms6_`s''" == "`terms1_`s''"
    foreach t of local terms1_`s' {
        assert reldif(B5_`s'[1, "`t'"], B2_`s'[1, "`t'"]) < 1e-6
        assert reldif(B4_`s'[1, "`t'"], B1_`s'[1, "`t'"] + B6_`s'[1, "`t'"]) < 1e-6
    }
    assert reldif(`a5_`s'', `a2_`s'') < 1e-6
    assert reldif(`a4_`s'', `a1_`s'' + `a6_`s'') < 1e-6
    display "   `v`s'': " %6.0fc `N1_`s'' " rows with both (" `st1_`s'' " starters): fuels " %5.1f 100 * (exp(`a1_`s'') - 1) ///
        "%, bought electricity " %5.1f 100 * (exp(`a2_`s'') - 1) "%; no fuel " %5.1f `a11_`s'' " points, no electricity " ///
        %5.1f `a12_`s'' " points; CO2 links checked"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 5/8: percentages, and the cross-check with R6-01's table"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen str70 outcome_label = ""
gen str40 outcome_log   = ""
gen str50 rows_used     = ""
gen str30 unit          = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''" if outcome == `o'
    replace outcome_log   = "`y`o''" if outcome == `o'
    replace unit = cond(`u`o'' == 1, "log points (shown as %)", "percentage points") if outcome == `o'
}
replace rows_used = "`rw1'"  if outcome <= 7
replace rows_used = "`rw8'"  if outcome == 8
replace rows_used = "`rw9'"  if outcome == 9
replace rows_used = "`rw10'" if outcome == 10
replace rows_used = "`rw11'" if outcome >= 11
gen byte scale = cond(unit == "percentage points", 2, 1)
gen str130 version_label = ""
replace version_label = "Main: all export starters vs never-exporters (R6-01's sample and model)"   if vorder == 1
replace version_label = "Without doubtful energy records (importers, export status unknown)"      if vorder == 2
replace version_label = "Without the 2017 starters (they may have started in 2016)"               if vorder == 3
replace version_label = "Only starters seen not exporting the year just before"                   if vorder == 4
replace version_label = "Without the 2017 rows (far more firms burn coal that year)"              if vorder == 5
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = string(`wlo' - 1) + " or earlier (grouped)" if term == "ev_lo"
replace column = "+" + string(`whi' + 1) + " or later (grouped)" if term == "ev_hi"
* % difference = 100 x (exp(b) - 1) for the log rows; the share rows stay in points.
gen double pct    = 100 * (exp(b)  - 1) if scale == 1
gen double pct_lo = 100 * (exp(lo) - 1) if scale == 1
gen double pct_hi = 100 * (exp(hi) - 1) if scale == 1
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p ///
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
            replace avg_after_lo        = `al`o'_`s'' if `c'
            replace avg_after_hi        = `ah`o'_`s'' if `c'
            replace avg_after_p         = `ap`o'_`s'' if `c'
            if `u`o'' == 1 {
                replace avg_after_pct    = 100 * (exp(`a`o'_`s'')  - 1) if `c'
                replace avg_after_pct_lo = 100 * (exp(`al`o'_`s'') - 1) if `c'
                replace avg_after_pct_hi = 100 * (exp(`ah`o'_`s'') - 1) if `c'
            }
        }
    }
}
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
* R6-01's energy row (4) uses all usable rows: this file's row 10 must reproduce it
* in the four versions both files have (same sample block, same model).
gen str40 r6_check = ""
capture confirm file "$R6DIR/tables/01_margins_export_start.csv"
if _rc display "   $R6DIR/tables/01_margins_export_start.csv not found: cross-check skipped"
else {
    preserve
    import delimited using "$R6DIR/tables/01_margins_export_start.csv", clear varnames(1)
    keep if outcome == 4 & inlist(version, "main", "nodoubt", "no2017", "exact")
    keep version event_time b avg_after_b
    rename (b avg_after_b) (fig_b fig_avg)
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == 10 & inlist(version, "main", "nodoubt", "no2017", "exact")
    quietly merge 1:1 version event_time using `fig'
    quietly count if _merge != 3 | abs(b - fig_b) > 0.00005 + 1e-9 | abs(avg_after_b - fig_avg) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "R6-01's energy row does not match this file's row 10: the R6 sample differs between the two files."
        exit 459
    }
    quietly count
    display "   01_margins_export_start.csv row (4): all " r(N) " coefficients and averages reproduced to 4 decimals"
    restore
    replace r6_check = "= 01_margins_export_start row (4)" if outcome == 10 & inlist(version, "main", "nodoubt", "no2017", "exact")
}
replace r6_check = "= row 2 at every point (checked)" if outcome == 5
replace r6_check = "= row 1 + row 6 at every point (checked)" if outcome == 4
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "No starter row in this version: marker left out" if missing(b) & !reference

*---------------------------------------------------------------------------
display "Step 6/8: the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
sort outcome vorder event_time
order outcome outcome_label outcome_log rows_used unit version version_label column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p ///
      avg_after_pct avg_after_pct_lo avg_after_pct_hi window_first window_last r6_check note
drop term vorder scale
format b se lo hi avg_after_b avg_after_se avg_after_lo avg_after_hi before_F %9.4f
format pct pct_lo pct_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi %9.1f
format p before_p before_p_no_grouped avg_after_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
tempfile full                                         // full precision, for the companion tables (Step 8)
save `full'
export delimited using "tables/`fname'.csv", datafmt replace
set linesize 220                                      // one line per row in the log listing
list outcome version avg_after_b avg_after_se avg_after_pct avg_after_pct_lo avg_after_pct_hi avg_after_p before_p ///
    n_rows n_starters n_comparison if column == "0", noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 7/8: two panels on one scale (main version): fuels burned, bought electricity"
*---------------------------------------------------------------------------
* Numbers for the notes, read from the table (never typed). Per row and version:
* "+17% (95% interval -4% to +42%)" for log rows, "+1.2 points (...)" for shares.
gen byte clear = avg_after_lo > 0 | avg_after_hi < 0              // interval does not cross 0
gen byte sgn   = cond(avg_after_b > 0, 1, -1)
gen str40 ptxt = cond(round(avg_after_pct) > 0, "+", "") + string(round(avg_after_pct), "%9.0f") + "%" if !missing(avg_after_pct)
gen str80 itxt = ptxt + " (95% interval " + cond(round(avg_after_pct_lo) > 0, "+", "") + string(round(avg_after_pct_lo), "%9.0f") ///
    + "% to " + cond(round(avg_after_pct_hi) > 0, "+", "") + string(round(avg_after_pct_hi), "%9.0f") + "%)" if !missing(avg_after_pct)
replace ptxt = cond(avg_after_b > 0, "+", "") + string(avg_after_b, "%9.1f") + " points" if missing(avg_after_pct)
replace itxt = ptxt + " (95% interval " + cond(avg_after_lo > 0, "+", "") + string(avg_after_lo, "%9.1f") ///
    + " to " + cond(avg_after_hi > 0, "+", "") + string(avg_after_hi, "%9.1f") + ")" if missing(avg_after_pct)
foreach o in 1 2 3 4 6 7 8 9 11 12 {
    forvalues s = 1/`nv' {
        local v "`v`s''"
        quietly levelsof itxt if outcome == `o' & version == "`v'" & reference, local(tt) clean
        local it`o'`v' "`tt'"
        quietly levelsof ptxt if outcome == `o' & version == "`v'" & reference, local(tt) clean
        local pt`o'`v' "`tt'"
        quietly summarize clear if outcome == `o' & version == "`v'"
        local cl`o'`v' = r(mean)
        quietly summarize sgn if outcome == `o' & version == "`v'"
        local sg`o'`v' = r(mean)
        quietly summarize before_p if outcome == `o' & version == "`v'"
        local bp`o'`v' = r(mean)
    }
}
local ct1 = cond(`cl1main', "clear", "not clear")
local ct2 = cond(`cl2main', "clear", "not clear")
* (a) the finding first: the two drawn rows
if !`cl1main' & !`cl2main' local both "neither is clearly different from 0"
else if `cl1main' & `cl2main' local both "both are clearly different from 0"
else if `cl1main' local both "only fuels burned is clearly different from 0"
else local both "only bought electricity is clearly different from 0"
* the second interval without its "95% interval" words (already said once)
local it2s = subinstr("`it2main'", "95% interval ", "", 1)
local headtxt "Average of years 0 to +`whi': fuels burned `it1main', bought electricity `it2s'; `both'."
* (b) the rows behind the dots, and each one on its own rows
local n_both_t = string(`N1_1', "%9.0fc")
local rowtxt "Dots use firm-years with both above 0 (`n_both_t'), so both panels follow the same firms."
* (c) the firms with none of one
local zf = string(`z_fuel', "%9.0fc")
local ze = string(`z_elec', "%9.0fc")
local zn = string(`z_none', "%9.0fc")
local zc = cond(`cl11main' & `cl12main', "both clear", cond(!`cl11main' & !`cl12main', "neither clear", ///
    cond(`cl11main', "only the first clear", "only the second clear")))
local zerotxt "Rows with no fuel (`zf') or no bought electricity (`ze') are not in the dots; after the start, the share"
local zerotxt "`zerotxt' of rows burning no fuel moves `pt11main', buying none `pt12main' (`zc')."
* (d) CO2: what the two panels already say
* CO2 per GJ of fuels moves little: one decimal, so it never shows as "-0%"
quietly summarize avg_after_pct if outcome == 6 & version == "main"
local pt6d = cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%"
local co2txt "CO2 is not drawn: CO2 from bought electricity moves exactly with (b) (one national rate a year); CO2 from"
local co2txt "`co2txt' fuels = (a) plus the fuel-mix change in CO2 per GJ (`pt6d'): `pt4main'."
* (e) before-start check for the two drawn rows
local nfail 0
foreach o in 1 2 {
    if `bp`o'main' < 0.05 {
        local ++nfail
        local fail`nfail' "`w`o'' (p = `=string(`bp`o'main', "%5.3f")')"
    }
}
if `nfail' == 0 local btxt "Before the start, neither differed clearly (p = `=string(`bp1main', "%5.3f")', `=string(`bp2main', "%5.3f")'; below 0.05 = warning)."
else if `nfail' == 1 local btxt "Warning: `fail1' already differed before the start, so later dots may partly continue that."
else local btxt "Warning: `fail1' and `fail2' already differed before the start, so later dots may partly continue that."
* (f) all five versions (table): the range of each drawn average and the versions
* in which it is clear, so no single version can be quoted on its own.
local vs_main       "all"
local vs_nodoubt    "without doubtful records"
local vs_no2017     "without 2017 starters"
local vs_exact      "starters seen not exporting the year before"
local vs_no2017rows "without 2017 rows"
local rngtxt ""
foreach o in 1 2 {
    quietly summarize avg_after_pct if outcome == `o' & reference
    local rlo = round(r(min))
    local rhi = round(r(max))
    local rlo = cond(`rlo' > 0, "+", "") + string(`rlo', "%9.0f") + "%"
    local rhi = cond(`rhi' > 0, "+", "") + string(`rhi', "%9.0f") + "%"
    local nclr 0
    local clist ""
    foreach v in main nodoubt no2017 no2017rows exact {
        if `cl`o'`v'' {
            local ++nclr
            local clist = "`clist'" + cond(`nclr' > 1, ", ", "") + "`vs_`v''"
        }
    }
    local ctx = cond(`nclr' == 0, "never clear", cond(`nclr' == `nv', "clear in all", "clear only in: `clist'"))
    local rngtxt = "`rngtxt'" + cond(`o' == 2, "; ", "") + "`w`o'' `rlo' to `rhi' (`ctx')"
}
local vtxt "Five versions (in the CSV): all; without doubtful records (importers of unknown export status, years of odd energy"
local vtxt "`vtxt' records); without 2017 starters; without 2017 rows (far more firms burn coal that year); only starters seen"
local vtxt "`vtxt' not exporting the year before. The average runs: `rngtxt'."
* (g) single years whose interval does not cross 0, each with the number of
* versions in which that year is clear (the rest are in the table).
local ndots 0
local sytxt ""
foreach o in 1 2 {
    quietly count if outcome == `o' & version == "main" & !reference & !missing(b)
    local ndots = `ndots' + r(N)
    quietly levelsof event_time if outcome == `o' & version == "main" & !reference & (lo > 0 | hi < 0), local(ks)
    local part ""
    local nk 0
    foreach k of local ks {
        local ++nk
        quietly summarize pct if outcome == `o' & version == "main" & event_time == `k'
        local pv = round(r(mean))
        local pv = cond(`pv' > 0, "+", "") + string(`pv', "%9.0f") + "%"
        quietly count if outcome == `o' & event_time == `k' & (lo > 0 | hi < 0)
        local nvc = r(N)
        local kl = cond(`k' > 0, "+", "") + string(`k')
        quietly summarize grouped if outcome == `o' & event_time == `k' & version == "main", meanonly
        if r(max) == 1 local kl = cond(`k' < 0, "≤ ", "≥ ") + "`kl'"
        local part = "`part'" + cond(`nk' > 1, ", ", "") + "`kl' (`pv', clear in `nvc' of `nv' versions)"
    }
    if `nk' > 0 local sytxt = "`sytxt'" + cond("`sytxt'" != "", "; ", "") + "`w`o'' in year" + cond(`nk' > 1, "s ", " ") + "`part'"
}
if "`sytxt'" == "" local sytxt "No single year's interval excludes 0."
else local sytxt "Single years whose interval excludes 0: `sytxt'. Of `ndots' dots about `=round(0.05*`ndots')' would be clear by chance, so read the averages."
display "   `headtxt'"
display "   `rowtxt'"
display "   `zerotxt'"
display "   `co2txt'"
display "   `btxt'"
display "   `vtxt'"
display "   `sytxt'"
keep if version == "main" & inlist(outcome, 1, 2)
quietly summarize n_starters if outcome == 1
local nst = string(r(mean), "%9.0fc")
quietly summarize n_comparison if outcome == 1
local ncf = string(r(mean), "%9.0fc")
* Both panels use the same firm-years: the starters behind each point are the same.
preserve
keep outcome event_time firms
reshape wide firms, i(event_time) j(outcome)
assert firms1 == firms2
restore
gen double x = event_time
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !reference
gen str9 reflbl = "reference" if reference & outcome == 1   // written once, in the top panel
gen double refx = x - 0.2 if reference                  // label sits just left of the start line
local nplot = _N                                        // points drawn (incl. the reference diamonds)
* x-axis (under the bottom panel): years since the start, then the number of starters.
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
* y-axis: one scale for both panels; a round step that grows with the numbers; 0 always inside.
quietly summarize pct_lo
local ymin = min(r(min), 0)
quietly summarize pct_hi
local ymax = max(r(max), 0)
local rng = `ymax' - `ymin'
* step = the smallest of 1, 2, 5 x a power of 10 giving at most 5 steps (the panels are short)
local p10 = 10^floor(log10(`rng'))
local step ""
foreach m in 0.1 0.2 0.5 1 2 5 10 {
    if "`step'" == "" & `rng' / (`m' * `p10') <= 5 local step = `m' * `p10'
}
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local xl = `wlo' - 1.6
local xr = `whi' + 1.6
* Reference lines as data (one row per panel), so every panel draws them: 0 line and start line.
gen double zl_y = 0          if reference
gen double zl_x0 = `xl'      if reference
gen double zl_x1 = `xr'      if reference
gen double sl_x = -0.5       if reference
gen double sl_y0 = `ybot'    if reference
gen double sl_y1 = `ytop'    if reference
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local txt "Notes: `headtxt' `sytxt' `rowtxt' `zerotxt' `co2txt' `btxt' `vtxt'"
local txt "`txt' Starters = firms first seen exporting after a year seen not exporting (`nst'; they stay starters if they stop);"
local txt "`txt' never-exporters = firms never seen exporting (`ncf'). Bought electricity excludes power firms make themselves"
local txt "`txt' (its fuel is in fuels burned). GJ = gigajoules. Shows timing, not cause; firm links are fictional: this tests the method, not a finding."
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
label define outc 1 "`n1'" 2 "`n2'"
label values outcome outc                               // panel titles = row names with units
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
    by(outcome, cols(1) iscale(1) imargin(tiny) scale(`=7.5/9') /// text as in R2-05 (9 in wide)
        title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
        subtitle("% change since the year before the start, starters minus never-exporters (same scale in both panels)", ///
            size(small) position(11) justification(left) span) ///
        note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
        legend(position(6)) graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none))) ///
    subtitle(, size(small) position(11) justification(left) nobox fcolor(white) lcolor(white) margin(b+1)) ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(small) noticks tlength(0) labgap(1)) ///
    xtitle("Years since the start (0 = start year); second row = number of starter firms", size(small) margin(t+1)) ///
    yscale(range(`ybot' `ytop') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(small) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") ///
    legend(order(4 "Each single year before or after the start" 5 "Years `=`whi'+1'+ before or after, combined" ///
                 6 "Year before the start (reference = 0)" 3 "95% interval" ///
                 1 "0 = no difference" 2 "Start of exporting") ///
        cols(2) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(9) ysize(11)

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
local nb = uchar(160)                                   // no-break space
* (1) Points table: every point of the chart, panel (a) then (b), left to right.
use `full', clear
keep if version == "main" & inlist(outcome, 1, 2)
sort outcome event_time
assert _N == `nplot'                                    // every drawn point, once
gen str40 t_pan = cond(outcome == 1, "(a) Fuels burned, GJ", "(b) Bought electricity, GJ")
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
gen str60 t_status = "solid dot"
replace t_status = "hollow: years before `wlo' combined" if grouped & event_time < 0
replace t_status = "hollow: years after +`whi' combined" if grouped & event_time > 0
replace t_status = "gray diamond: reference (0)" if reference
assert t_v != "" & t_n != ""
local txt_t = itrim(`"`txt'"')
local tnote "Table: every point of Figure `exhibit', panel (a) then (b), left to right. % difference = 100 × (exp(b) − 1), b ="
local tnote "`tnote' columns (1) and (2) of the regression table; rounded as the chart labels. Starter firms and their firm-years"
local tnote "`tnote' behind each point (the x-axis numbers; the same in both panels; a firm counts once in a grouped end). Besides the rows with no fuel or no bought electricity,"
local tnote "`tnote' `zn' rows of these firms record no energy at all. Full precision and all versions: tables/`fname'.csv."
ctable_pdf t_pan t_pos t_v t_lo t_hi t_n t_r t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("% change since the year before the start, starters minus never-exporters; firm-years using both fuels and bought electricity") ///
    header("Panel" "Years|since|start" "%|difference" "Lower|95%" "Upper|95%" "Starter|firms" "Starter|firm-years" "Status") ///
    right(2 3 4 5 6 7) norepeat(1) rules(`=`nplot' / 2') perpage(30) portrait ///
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf"

* (2) Regression table (AER style): one column per row of the model, main version;
* coefficient on the first line, (standard error) on the second.
local rcols "1 2 3 4 6 7 8 9 11 12"                    // outcomes shown, in column order
local ncol : word count `rcols'
use `full', clear
keep if version == "main"
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1) stringcols(2 3 4 5 6 7 8)
keep if version == "main"
keep outcome event_time b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 outcome event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
drop b_csv
tempname P
tempfile R
local tv ""
forvalues c = 1/`ncol' {
    local tv `tv' t`c'
}
postfile `P' str60 t_lab str24(`tv') using `R'
quietly levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k' & outcome == 1, meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k' & outcome == 1, meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    local l1 ""
    local l2 ""
    forvalues c = 1/`ncol' {
        local o : word `c' of `rcols'
        local dec = cond(`u`o'' == 1, "%9.3f", "%9.2f")
        quietly summarize b if event_time == `k' & outcome == `o', meanonly
        local bb = r(mean)
        quietly summarize se if event_time == `k' & outcome == `o', meanonly
        local ss = r(mean)
        if `rf'                local c1 "0`nb'(reference)"
        else if missing(`bb')  local c1 "—"
        else                   local c1 = string(`bb', "`dec'")
        local c2 = cond(`rf' | missing(`bb'), "", "(" + string(`ss', "`dec'") + ")")
        local l1 `"`l1' ("`c1'")"'
        local l2 `"`l2' ("`c2'")"'
    }
    post `P' ("`lab'") `l1'
    local ++nterm
    if !`rf' {
        post `P' ("") `l2'
        local ++nterm
    }
}
* whole-model rows (the same number on every row of a row: take the first)
local lab1  "Average of years 0 to +`whi'"
local lab2  ""
local lab3  "  as % change (points in 9-10)"
local lab4  "  95% interval"
local lab5  "Before-start test, joint p"
local lab6  "Observations (firm-years)"
local lab7  "Firms (clusters)"
local lab8  "  starters / never-exporters"
local lab9  "Firm-years used"
local lab10 "Firm fixed effects"
local lab11 "Year fixed effects"
local lab12 "Industry × year, province × year"
local lab13 "Weights"
local lab14 "Standard errors clustered by"
local nsum 14
forvalues r = 1/`nsum' {
    local l ""
    forvalues c = 1/`ncol' {
        local o : word `c' of `rcols'
        local dec = cond(`u`o'' == 1, "%9.3f", "%9.2f")
        foreach v in avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_pct avg_after_pct_lo avg_after_pct_hi ///
            before_p before_p_no_grouped n_rows n_firms n_starters n_comparison {
            quietly summarize `v' if outcome == `o', meanonly
            local `v' = r(mean)
        }
        * the shown change: % for log columns, points for share columns
        local sh  = cond(`u`o'' == 1, `avg_after_pct', `avg_after_b')
        local shl = cond(`u`o'' == 1, `avg_after_pct_lo', `avg_after_lo')
        local shh = cond(`u`o'' == 1, `avg_after_pct_hi', `avg_after_hi')
        if `r' == 1  local cell = string(`avg_after_b', "`dec'")
        if `r' == 2  local cell = "(" + string(`avg_after_se', "`dec'") + ")"
        if `r' == 3  local cell = cond(`sh' > 0, "+", "") + string(`sh', "%9.1f")
        if `r' == 4  local cell = "[" + string(`shl', "%9.1f") + ", " + string(`shh', "%9.1f") + "]"
        if `r' == 5  local cell = cond(`before_p' < 0.001, "<`nb'0.001", string(`before_p', "%5.3f"))
        if `r' == 6  local cell = string(`n_rows', "%12.0fc")
        if `r' == 7  local cell = string(`n_firms', "%12.0fc")
        if `r' == 8  local cell = string(`n_starters', "%12.0fc") + " / " + string(`n_comparison', "%12.0fc")
        if `r' == 9 {
            if `o' <= 7       local cell "both > 0"
            else if `o' == 8  local cell "fuel > 0"
            else if `o' == 9  local cell "electricity > 0"
            else              local cell "all"
        }
        if inlist(`r', 10, 11) local cell "Yes"
        if `r' == 12 local cell "No"
        if `r' == 13 local cell "None"
        if `r' == 14 local cell "Firm"
        local l `"`l' ("`cell'")"'
    }
    post `P' ("`lab`r''") `l'
}
postclose `P'
use `R', clear
local rnote "Notes: Each column is one regression of the column's outcome on one marker per year since the export start,"
local rnote "`rnote' `wlo' to +`whi', except −1 (the year before the start: the reference, set to 0), and one marker for each grouped"
local rnote "`rnote' end, with firm and year fixed effects; firms never seen exporting are 0 on every marker. Columns (1)-(8): log of the"
local rnote "`rnote' outcome, coefficients in log points; columns (9)-(10): 100 if the firm-year burns no fuel (buys no electricity),"
local rnote "`rnote' else 0, coefficients in percentage points. Columns (1) and (2) are Figure `exhibit' panels (a) and (b); (1)-(6) use"
local rnote "`rnote' the same firm-years, so (4) = (1) + (5) exactly. CO2 from bought electricity (scope 2) gives exactly column (2)"
local rnote "`rnote' at every point (one national rate per kWh a year, removed by the year effects; checked), so it is not shown."
local rnote "`rnote' Sample: starters (first year seen exporting after a year seen not exporting) and firms never seen exporting;"
local rnote "`rnote' firms with one row used are dropped. Before-start test: all years before the start are 0 together (without"
local rnote "`rnote' the grouped end: CSV). No stars."
local rnote "`rnote' Other versions (without doubtful energy records, 2017 starters or 2017 rows; exact starters): tables/`fname'.csv."
ctable_pdf t_lab `tv' using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("Coefficient (standard error). Main version: all starters and never-exporters.") ///
    header("Years since the export start" "(1)|Fuels burned|(panel a)" "(2)|Bought|electricity|(panel b)" ///
           "(3)|Energy used|(both > 0)" "(4)|CO2 from fuels|(scope 1)" "(5)|CO2 per GJ|of fuels" "(6)|Value added|(both > 0)" ///
           "(7)|Fuels, rows|with fuel" "(8)|Electricity,|rows buying it" "(9)|Burns no fuel|(points)" ///
           "(10)|Buys no|electricity|(points)") ///
    right(2 3 4 5 6 7 8 9 10 11) rules(`nterm' `=`nterm' + 5' `=`nterm' + 9') fontsize(8.5) perpage(`=`nterm' + 1') landscape /// page 1 = the years, page 2 = the model rows
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
