/*==========================================================================
  R6-05  Does the CO2 answer depend on the emission rates we assumed? The
         CO2 in this file is not measured: it is the GJ of each fuel times a
         standard rate per fuel, plus bought electricity times a national
         grid rate. This file repeats the CO2 rows of R6-01 to R6-03 under
         three sets of rates: the main rates, the grid rate held fixed at one
         number in every year, and the file's second set of rates ("scenario
         2": other fuel rates and the fixed grid rate).
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use". The check that the carbon
         answers do not rest on one set of assumed emission rates.
  Output : figures/05_emission_factor_checks.png (+ .pdf)
           tables/05_emission_factor_checks.csv
           tables/05_emission_factor_checks_table.pdf       (every plotted point)
           tables/05_emission_factor_checks_regression.pdf  (the regressions)
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Checks : the start years, comparison group, usable rows, doubtful records,
           year window and model are R6-01's (block "R6 EXPORT-START SAMPLE",
           copied unchanged). Under every set of rates, value added per tonne
           of CO2 = value added - CO2 and CO2 per GJ = CO2 - energy used, at
           every point (asserted); CO2 from bought electricity is identical
           under all three sets and CO2 from fuels under the first two
           (asserted). When R6-01's, R6-02's and R6-03's tables are present,
           the main-rate rows must reproduce theirs to 4 decimals or the file
           stops (R6-01 rows 1, 3-5; R6-02 row 9; R6-03 row a2, found by name).
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

* ---- THE THREE SETS OF EMISSION RATES (all CO2 variables are in the file) ----
* CO2 of a set = CO2 from fuels burned (scope 1) + CO2 from bought electricity (scope 2)
*   set 1 "main"      : fuels at the main rates, electricity at a grid rate by year
*   set 2 "gridfixed" : fuels at the main rates, electricity at one grid rate in every year
*   set 3 "scen2"     : fuels at the file's second rates, electricity at that one grid rate
local nr 3
local rs1 "main"
local rs2 "gridfixed"
local rs3 "scen2"
local ct1 "co2_total_s1"                // all CO2
local ct2 "co2_variant_static_grid"
local ct3 "co2_total_s2"
local cf1 "co2_scope1_s1"               // CO2 from fuels burned (scope 1)
local cf2 "co2_scope1_s1"
local cf3 "co2_scope1_s2"
local ce1 "co2_scope2_s1"               // CO2 from bought electricity (scope 2)
local ce2 "co2_scope2_s2"
local ce3 "co2_scope2_s2"
local rl1 "Main rates"                  // legend and table words
local rl2 "Grid rate fixed"
local rl3 "Scenario 2 rates"

* ---- THE ROWS: six measures under each set, and two that no rate changes ----
* Outcome number o = 6 x (set - 1) + measure (1-18); 19 = value added, 20 = energy
* used (the same under every set; used for the exact checks). u: 1 log (shown
* as %), 2 share (percentage points). smp = firm-years used (Step 3).
local exhibit "R6-05"
local fname   "05_emission_factor_checks"
local ftitle  "CO2 after an export start under three sets of emission rates"
local nmeas 6                    // measures drawn (each under all three sets)
local nall 20                    // outcomes estimated
local n1 "(1) Value added per tonne of CO2"          // row names on the chart
local n2 "(2) CO2 emitted, tonnes"
local n3 "(3) CO2 per GJ of energy"
local n4 "(4) CO2 from fuels burned (scope 1)"
local n5 "(5) CO2 from bought electricity (scope 2)"
local n6 "(6) Bought electricity's share of CO2, %"
local n7 "(7) Value added (current prices)"
local n8 "(8) Energy used, GJ"
local r1 "(1) of Figure R6-01 under the main rates"     // gray second line under the name
local r2 "energy used + CO2 per GJ"
local r3 "(5) of Figure R6-01 under the main rates"
local r4 "firm-years burning some fuel"
local r5 "firm-years buying some; same under all three"
local r6 "scope 2 as % of all CO2"
local w1 "value added per tonne of CO2"                 // words for the notes
local w2 "CO2 emitted"
local w3 "CO2 per GJ"
local w4 "CO2 from fuels"
local w5 "CO2 from bought electricity"
local w6 "electricity's share of CO2"
forvalues m = 1/6 {
    local u`m' = cond(`m' == 6, 2, 1)
}
local u7 1
local u8 1
local rw1 "Usable (energy, CO2 and value added above 0)"   // firm-years used, in words
local rw4 "Usable, fuels above 0"
local rw5 "Usable, bought electricity above 0"
* Names of the nine fuels (for the rates in the notes).
local fuels9 "diesel petrol kerosene coal coalbriq lpg citygas othergas coke"
local fn_diesel   "diesel"
local fn_petrol   "petrol"
local fn_kerosene "kerosene"
local fn_coal     "coal"
local fn_coalbriq "coal briquettes"
local fn_lpg      "LPG"
local fn_citygas  "city gas"
local fn_othergas "other gas"
local fn_coke     "coke"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: CO2 answers under three sets of emission rates ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy, CO2 under each set of rates and value added; check the add-ons"
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
* import_flag             = imports raw materials (used for the doubtful energy records)
* total_gj_s1             = energy use in GJ = gj_fuel_s1 (nine fuels) + gj_electricity (bought)
* co2_total_s1            = CO2 tonnes, main rates = co2_scope1_s1 + co2_scope2_s1
* co2_variant_static_grid = CO2 tonnes, fuels at the main rates + electricity at one grid rate
* co2_total_s2            = CO2 tonnes, scenario 2 = co2_scope1_s2 + co2_scope2_s2
* co2_scope1_s1 / _s2     = CO2 from fuels burned (one rate per fuel; set 1 / set 2)
* co2_scope2_s1 / _s2     = CO2 from bought electricity (grid rate by year / one grid rate)
* grid_factor_s1 / _s2    = the two grid rates, tonnes of CO2 per kWh
* grid_factor_is_carried  = 1 in years whose grid rate is carried from an earlier year
* elec_purchased_kwh      = bought electricity, kWh (PLN and other suppliers)
* gj_<fuel>, co2_<fuel>_s1/_s2 = GJ and CO2 of each fuel (only for the rates in the notes)
* value_added_nominal     = value added, current prices (masked money unit)
local fv ""
foreach f of local fuels9 {
    local fv `fv' gj_`f' co2_`f'_s1 co2_`f'_s2
}
use firm_id year export_flag import_flag total_gj_s1 gj_fuel_s1 gj_electricity co2_total_s1 co2_scope1_s1 ///
    co2_scope2_s1 co2_variant_static_grid co2_total_s2 co2_scope1_s2 co2_scope2_s2 grid_factor_s1 ///
    grid_factor_s2 grid_factor_is_carried elec_purchased_kwh value_added_nominal `fv' using "$DATA", clear
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
display "Step 3/8: the three sets of emission rates, checks on them, and the rows"
*---------------------------------------------------------------------------
* (a) What each set of rates is, read from the file (all rows, not only the sample).
use `fy', clear
* CO2 of each set = CO2 from fuels + CO2 from bought electricity (Step 0 list at the top)
forvalues r = 1/`nr' {
    assert reldif(`ct`r'', `cf`r'' + `ce`r'') < 1e-9
}
* CO2 from bought electricity = kWh x the set's grid rate; kWh x 0.0036 = GJ
assert reldif(co2_scope2_s1, grid_factor_s1 * elec_purchased_kwh) < 1e-9
assert reldif(co2_scope2_s2, grid_factor_s2 * elec_purchased_kwh) < 1e-9
assert reldif(gj_electricity, 0.0036 * elec_purchased_kwh) < 1e-9
* Each grid rate is one number per year, the same for every firm (so the year
* fixed effects remove it from log CO2 from bought electricity); the fixed rate
* is one number in every year.
foreach g in grid_factor_s1 grid_factor_s2 {
    bysort year: egen double sd_g = sd(`g')
    assert sd_g < 1e-12 | missing(sd_g)
    drop sd_g
}
quietly summarize grid_factor_s2
assert r(sd) < 1e-12
local gfix = r(mean)
* CO2 from fuels of scenario 2 = the sum of its fuels; every set is above 0 on the
* same rows, so the usable rows are the same under all three sets.
local s2v ""
foreach f of local fuels9 {
    local s2v `s2v' co2_`f'_s2
}
egen double s2sum = rowtotal(`s2v')                                // missing = fuel not asked = 0 here
assert reldif(co2_scope1_s2, s2sum) < 1e-9
drop s2sum
forvalues r = 1/`nr' {
    assert (`ct`r'' > 0) == (co2_total_s1 > 0)
    assert (`cf`r'' > 0) == (gj_fuel_s1 > 0)
    assert (`ce`r'' > 0) == (gj_electricity > 0)
}
* Grid rate by year (main set): the years with their own rate and the years that
* carry an earlier one; for the notes.
preserve
collapse (mean) g1 = grid_factor_s1 (max) carried = grid_factor_is_carried, by(year)
list year g1 carried, noobs clean
quietly summarize year if carried == 0
local gy0 = r(min)
local gy1 = r(max)
quietly summarize year if carried == 1
local cy0 = r(min)
local cy1 = r(max)
quietly summarize g1 if year == `gy0'
local g_first = r(mean)
quietly summarize g1 if year == `gy1'
local g_last = r(mean)
assert abs(g1 - `g_last') < 1e-12 if carried == 1        // carried = the last own rate
* grid rate by year in kg per kWh, for the regression-table notes ("2010 0.60, ...")
local gyrtxt ""
forvalues i = 1/`=_N' {
    if carried[`i'] == 1 continue
    local gyrtxt = "`gyrtxt'" + cond("`gyrtxt'" != "", ", ", "") + string(year[`i']) + " " + string(1000 * g1[`i'], "%4.2f")
}
restore
local gtxt_first = string(`g_first', "%9.6f")
local gtxt_last  = string(`g_last', "%9.6f")
local gtxt_fix   = string(`gfix', "%9.6f")
* the same rates in kg of CO2 per kWh, for the notes (easier to read than tonnes)
local gkg_first = string(1000 * `g_first', "%4.2f")
local gkg_last  = string(1000 * `g_last', "%4.2f")
local gkg_fix   = string(1000 * `gfix', "%4.2f")
display "   grid rate, main set: " `gtxt_first' " t CO2 per kWh (`gy0') to " `gtxt_last' " (`gy1'); `gy1''s rate carried to `cy0'-`cy1'"
display "   grid rate, fixed: " `gtxt_fix' " t CO2 per kWh in every year"
* Fuel rates: one rate per fuel in each set (checked); scenario 2 vs main in %.
local ftxt ""
local frtxt ""                                             // "diesel 0.0743 / 0.0832, ..." for the regression notes
local dlo 0                                                // smallest and largest scenario-2 change, for the chart
local dhi 0
local lastn ""
local ds_prev ""
foreach f of local fuels9 {
    quietly count if gj_`f' > 0 & !missing(gj_`f')
    if r(N) == 0 continue                                  // fuel never burned in the file
    gen double e1 = co2_`f'_s1 / gj_`f' if gj_`f' > 0 & !missing(gj_`f')
    gen double e2 = co2_`f'_s2 / gj_`f' if gj_`f' > 0 & !missing(gj_`f')
    quietly summarize e1
    assert r(sd) < 1e-9 * r(mean)
    local m1 = r(mean)
    quietly summarize e2
    assert r(sd) < 1e-9 * r(mean)
    local m2 = r(mean)
    local d = round(100 * (`m2' / `m1' - 1))
    local dlo = min(`dlo', `d')
    local dhi = max(`dhi', `d')
    local ds = cond(`d' > 0, "+", "") + string(`d', "%9.0f") + "%"
    * fuels next to each other with the same change are named together ("city gas and other gas -19%")
    if "`ds'" == "`ds_prev'" local lastn "`lastn' and `fn_`f''"
    else {
        if "`lastn'" != "" local ftxt = "`ftxt'" + cond("`ftxt'" != "", ", ", "") + "`lastn' `ds_prev'"
        local lastn "`fn_`f''"
    }
    local ds_prev "`ds'"
    local frtxt = "`frtxt'" + cond("`frtxt'" != "", ", ", "") + "`fn_`f'' " + string(`m1', "%6.4f") + " / " + string(`m2', "%6.4f")
    display "   `fn_`f'': " %7.5f `m1' " t CO2 per GJ (main), " %7.5f `m2' " (scenario 2): `ds'"
    drop e1 e2
}
local ftxt = "`ftxt'" + cond("`ftxt'" != "", ", ", "") + "`lastn' `ds_prev'"

* (b) The rows, on the R6 sample (usable firm-years of starters and never-exporters).
use `smp', clear
* Firm-years used: usable (all rows except (4) and (5)); (4) needs fuels burned
* above 0, (5) bought electricity above 0 (the log of 0 does not exist).
gen byte s_use  = 1
gen byte s_fuel = gj_fuel_s1 > 0 & !missing(gj_fuel_s1)
gen byte s_elec = gj_electricity > 0 & !missing(gj_electricity)
forvalues r = 1/`nr' {
    local b = 6 * (`r' - 1)
    gen double y`=`b' + 1' = ln(value_added_nominal / `ct`r'')     // (1) value added per tonne of CO2
    gen double y`=`b' + 2' = ln(`ct`r'')                            // (2) CO2 emitted
    gen double y`=`b' + 3' = ln(`ct`r'' / total_gj_s1)              // (3) CO2 per GJ of energy
    gen double y`=`b' + 4' = ln(`cf`r'') if s_fuel                  // (4) CO2 from fuels burned
    gen double y`=`b' + 5' = ln(`ce`r'') if s_elec                  // (5) CO2 from bought electricity
    gen double y`=`b' + 6' = 100 * `ce`r'' / `ct`r''                // (6) electricity's share of CO2, %
    forvalues m = 1/6 {
        local smp`=`b' + `m'' = cond(`m' == 4, "s_fuel", cond(`m' == 5, "s_elec", "s_use"))
        local u`=`b' + `m'' = `u`m''
        local ms`=`b' + `m'' = `m'                                  // measure of each outcome
        local rr`=`b' + `m'' = `r'                                  // set of rates of each outcome
    }
}
gen double y19 = ln(value_added_nominal)                           // (7) value added
gen double y20 = ln(total_gj_s1)                                   // (8) energy used
local smp19 "s_use"
local smp20 "s_use"
local ms19 7
local ms20 8
local rr19 0
local rr20 0
local u19 1
local u20 1
quietly count
local nus = r(N)
quietly count if s_fuel
local nfu = r(N)
quietly count if s_elec
local nel = r(N)
display "   " %6.0fc `nus' " usable firm-years: " %6.0fc `nfu' " burn some fuel, " %6.0fc `nel' " buy some electricity"
display "   Bought electricity's share of CO2 (%), average over firm-years, by set of rates and year:"
tabstat y6 y12 y18, by(year) stat(mean) format(%6.1f) nototal
save `smp', replace

*---------------------------------------------------------------------------
display "Step 4/8: estimate every row under every set of rates with firm and year fixed effects (clustered by firm), five versions"
*---------------------------------------------------------------------------
* R6-01's model (R2-03's): the outcome on one marker per year since the start,
* removing each firm's own average (firm fixed effects) and each year's average
* (year fixed effects, set mostly by the comparison firms). A firm with one row
* used cannot be compared with itself; reghdfe drops it and reports the number.
* Log rows: b = log difference from the firm's year before the start, net of the
* never-exporters' change; % = 100 x (exp(b) - 1). Share rows: b in percentage points.
* Versions (the chart shows "main"; all are in the CSV):
*   main       = the R6 sample
*   nodoubt    = without doubtful energy records (Step 2)
*   no2017     = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact      = keeps only starters seen not exporting the year just before
*   no2017rows = without the 2017 rows (that year far more firms burn coal: a
*                recording change is likely, and coal's rate differs between sets)
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
    use `smp', clear
    keep if `e`s''
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
        * rows on the same firm-years must use the same number of them
        if "`smp`o''" == "s_use" & `o' > 1 assert e(N) == `N1_`s''
        if `o' > 6 & inlist(`ms`o'', 4, 5) assert e(N) == `N`ms`o''_`s''
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
            local nrw = r(N)
            quietly count if ft == 1 & gA < 2016
            local ne = r(N)
            quietly count if ft == 1 & gA > 2016
            local nl = r(N)
            quietly levelsof gA if es & `t'
            local ny : word count `r(levels)'
            drop ft
            local grp = inlist("`t'", "ev_lo", "ev_hi")
            if "`t'" == "ev_ref" {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nrw') (`ne') (`nl') (`ny')
            }
            else if !`: list t in terms' {
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (.) (.) (.) (.) (.) (0) (0) (0) (0) (0)
            }
            else {
                local b  = _b[`t']
                local se = _se[`t']
                post `h' (`o') ("`v`s''") ("`t'") (`k') (`grp') (0) (`b') (`se') ///
                    (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                    (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nrw') (`ne') (`nl') (`ny')
            }
        }
    }
    * Exact links, marker by marker and in the average, under every set of rates:
    *   (1) value added per tonne of CO2 = value added (19) - CO2 emitted (2)
    *   (3) CO2 per GJ                   = CO2 emitted (2) - energy used (20)
    *   (5) CO2 from bought electricity: identical under all three sets (the grid
    *       rate is one number a year: the year fixed effects remove it)
    *   (4) CO2 from fuels: identical under sets 1 and 2 (the same fuel rates)
    forvalues r = 1/`nr' {
        local b = 6 * (`r' - 1)
        assert "`terms`=`b'+1'_`s''" == "`terms19_`s''" & "`terms`=`b'+3'_`s''" == "`terms19_`s''"
        foreach t of local terms19_`s' {
            assert reldif(B`=`b'+1'_`s'[1, "`t'"], B19_`s'[1, "`t'"] - B`=`b'+2'_`s'[1, "`t'"]) < 1e-6
            assert reldif(B`=`b'+3'_`s'[1, "`t'"], B`=`b'+2'_`s'[1, "`t'"] - B20_`s'[1, "`t'"]) < 1e-6
        }
        assert reldif(`a`=`b'+1'_`s'', `a19_`s'' - `a`=`b'+2'_`s'') < 1e-6
        assert reldif(`a`=`b'+3'_`s'', `a`=`b'+2'_`s'' - `a20_`s'') < 1e-6
    }
    assert "`terms11_`s''" == "`terms5_`s''" & "`terms17_`s''" == "`terms5_`s''" & "`terms10_`s''" == "`terms4_`s''"
    foreach t of local terms5_`s' {
        assert reldif(B11_`s'[1, "`t'"], B5_`s'[1, "`t'"]) < 1e-6
        assert reldif(B17_`s'[1, "`t'"], B5_`s'[1, "`t'"]) < 1e-6
    }
    foreach t of local terms4_`s' {
        assert reldif(B10_`s'[1, "`t'"], B4_`s'[1, "`t'"]) < 1e-6
    }
    assert reldif(`a11_`s'', `a5_`s'') < 1e-6 & reldif(`a17_`s'', `a5_`s'') < 1e-6 & reldif(`a10_`s'', `a4_`s'') < 1e-6
    assert reldif(`as11_`s'', `as5_`s'') < 1e-6 & reldif(`as17_`s'', `as5_`s'') < 1e-6 & reldif(`as10_`s'', `as4_`s'') < 1e-6
    display "   `v`s'': " %6.0fc `N1_`s'' " rows (" `st1_`s'' " starters); value added per tonne of CO2 " ///
        %5.1f 100 * (exp(`a1_`s'') - 1) "% / " %5.1f 100 * (exp(`a7_`s'') - 1) "% / " %5.1f 100 * (exp(`a13_`s'') - 1) ///
        "%; CO2 per GJ " %5.1f 100 * (exp(`a3_`s'') - 1) "% / " %5.1f 100 * (exp(`a9_`s'') - 1) "% / " ///
        %5.1f 100 * (exp(`a15_`s'') - 1) "% (main / grid fixed / scenario 2); links checked"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 5/8: the CSV (numbers written before drawing) and the cross-checks with R6-01, R6-02 and R6-03"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen byte measure = .
gen str10 rates = ""
gen str45 outcome_label = ""
gen str50 outcome_parts = ""
gen str50 rows_used = ""
gen str24 unit = ""
forvalues o = 1/`nall' {
    local m = `ms`o''
    quietly replace measure = `m' if outcome == `o'
    quietly replace rates = cond(`rr`o'' == 0, "any", "`rs`rr`o'''") if outcome == `o'
    quietly replace outcome_label = "`n`m''" if outcome == `o'
    quietly replace unit = cond(`u`o'' == 1, "log points; shown as %", "percentage points") if outcome == `o'
    quietly replace rows_used = cond("`smp`o''" == "s_fuel", "`rw4'", cond("`smp`o''" == "s_elec", "`rw5'", "`rw1'")) if outcome == `o'
}
forvalues m = 1/`nmeas' {
    replace outcome_parts = "`r`m''" if measure == `m'
}
replace outcome_parts = "the same under every set of rates" if measure >= 7
gen str70 rates_label = ""
replace rates_label = "Main: fuels at the main rates; grid rate by year (`gy0'-`gy1', then carried)" if rates == "main"
replace rates_label = "Grid rate fixed: fuels at the main rates; grid rate `gtxt_fix' t/kWh every year" if rates == "gridfixed"
replace rates_label = "Scenario 2: the file's second fuel rates; grid rate `gtxt_fix' t/kWh every year" if rates == "scen2"
replace rates_label = "No emission rate involved" if rates == "any"
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
* Shown on the chart: logs as 100 x (exp(b) - 1) %; shares as b in percentage points.
gen byte islog = unit != "percentage points"
gen double shown    = cond(islog, 100 * (exp(b)  - 1), b)
gen double shown_lo = cond(islog, 100 * (exp(lo) - 1), lo)
gen double shown_hi = cond(islog, 100 * (exp(hi) - 1), hi)
foreach v in n_rows n_firms n_starters n_comparison n_one_year_dropped before_df {
    gen long `v' = .
}
foreach v in before_F before_p before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p {
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
        }
    }
}
gen double avg_after_shown    = cond(islog, 100 * (exp(avg_after_b)  - 1), avg_after_b)
gen double avg_after_shown_lo = cond(islog, 100 * (exp(avg_after_lo) - 1), avg_after_lo)
gen double avg_after_shown_hi = cond(islog, 100 * (exp(avg_after_hi) - 1), avg_after_hi)
assert n_starters + n_comparison == n_firms
assert firms_early + firms_late == firms
* ---- Cross-checks (when the tables are in this block): stop on any mismatch ----
* Same sample block and model, so under the main rates:
*   R6-01 row (1) = (1) here, (5) = (3), (3) = value added (19), (4) = energy used (20)
*   R6-02 row 9 (bought electricity, every row buying it) = (5) here: CO2 from
*   bought electricity moves exactly with its GJ (one rate a year)
*   R6-03 row "(a2) Electricity's share of CO2, %" = (6) here
gen str45 cross_check = ""
local xf1 "01_margins_export_start"
local xf2 "02_fuels_vs_electricity"
local xf3 "03_energy_mix_shares"
local xp1 "1:1 5:3 3:19 4:20"                            // their outcome : this file's outcome
local xp2 "9:5"
local xp3 "a2:6"
local xv1 `""main", "nodoubt", "no2017", "exact""'
local xv2 `""main", "nodoubt", "no2017", "exact", "no2017rows""'
local xv3 `""main", "nodoubt", "no2017", "exact", "no2017rows""'
forvalues x = 1/3 {
    capture confirm file "$R6DIR/tables/`xf`x''.csv"
    if _rc {
        display "   $R6DIR/tables/`xf`x''.csv not found: cross-check skipped"
        continue
    }
    local nmatch 0
    foreach pr of local xp`x' {
        gettoken theirs mine : pr, parse(":")
        local mine = substr("`mine'", 2, .)
        preserve
        quietly import delimited using "$R6DIR/tables/`xf`x''.csv", clear varnames(1)
        * R6-03's rows are found by their name (its row numbers may change under review)
        if "`theirs'" == "a2" quietly keep if strpos(outcome_label, "(a2) Electricity's share of CO2") == 1
        else quietly keep if outcome == `theirs'
        if _N == 0 {
            restore
            display "   `xf`x''.csv: row `theirs' not found: cross-check skipped"
            continue
        }
        quietly keep if inlist(version, `xv`x'')
        keep version event_time b avg_after_b
        rename (b avg_after_b) (x_b x_avg)
        tempfile xt
        quietly save `xt'
        restore, preserve
        quietly keep if outcome == `mine' & inlist(version, `xv`x'')
        quietly merge 1:1 version event_time using `xt'
        quietly count if _merge != 3 | abs(b - x_b) > 0.00005 + 1e-9 | abs(avg_after_b - x_avg) > 0.00005 + 1e-9
        if r(N) > 0 {
            display as error "`xf`x''.csv row `theirs' does not match row `mine' here: the R6 sample or model differs between the files."
            exit 459
        }
        quietly count
        local nmatch = `nmatch' + r(N)
        restore
        quietly replace cross_check = "= `xf`x'' row `theirs'" if outcome == `mine' & inlist(version, `xv`x'')
    }
    display "   `xf`x''.csv: all `nmatch' coefficients and averages reproduced to 4 decimals"
}
quietly replace cross_check = cross_check + cond(cross_check != "", "; ", "") + "= main rates at every point (checked)" ///
    if inlist(outcome, 10, 11, 17)
quietly replace cross_check = cross_check + cond(cross_check != "", "; ", "") + "= value added - CO2 emitted (checked)" ///
    if inlist(measure, 1)
quietly replace cross_check = cross_check + cond(cross_check != "", "; ", "") + "= CO2 emitted - energy used (checked)" ///
    if inlist(measure, 3)
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "No starter row in this version: marker left out" if missing(b) & !reference
gen byte rorder = cond(rates == "any", 4, 1 * (rates == "main") + 2 * (rates == "gridfixed") + 3 * (rates == "scen2"))
sort measure rorder vorder event_time
order outcome measure outcome_label outcome_parts rates rates_label unit rows_used version version_label column ///
      event_time grouped reference b se lo hi p shown shown_lo shown_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p ///
      avg_after_shown avg_after_shown_lo avg_after_shown_hi window_first window_last cross_check note
drop term vorder islog rorder
format b se lo hi avg_after_b avg_after_se avg_after_lo avg_after_hi before_F %9.4f
format shown shown_lo shown_hi avg_after_shown avg_after_shown_lo avg_after_shown_hi %9.2f
format p before_p before_p_no_grouped avg_after_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
tempfile full                                         // full precision, for the companion tables (Step 8)
save `full'
export delimited using "tables/`fname'.csv", datafmt replace
set linesize 220                                      // one line per row in the log listing
list measure rates version avg_after_shown avg_after_shown_lo avg_after_shown_hi avg_after_p before_p ///
    n_rows n_starters n_comparison if column == "0", noobs sepby(measure) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 6/8: the notes' numbers, read from the table (never typed)"
*---------------------------------------------------------------------------
* Per measure m, set of rates r and version v: the shown average ("+10.2%" or
* "-1.9 points"), whether its 95% interval excludes 0 ("clear"), and before-start p.
gen byte clear = avg_after_shown_lo > 0 | avg_after_shown_hi < 0
gen double shr = round(avg_after_shown, 0.1)                      // round first: no "-0.0"
gen str20 ptxt = cond(shr > 0, "+", "") + string(shr, "%9.1f") + cond(unit == "percentage points", " points", "%")
gen byte rnum = 1 * (rates == "main") + 2 * (rates == "gridfixed") + 3 * (rates == "scen2")
forvalues m = 1/`nmeas' {
    forvalues r = 1/`nr' {
        forvalues s = 1/`nv' {
            local v "`v`s''"
            quietly levelsof ptxt if measure == `m' & rnum == `r' & version == "`v'" & reference, local(tt) clean
            local pt`m'_`r'`v' "`tt'"
            quietly summarize clear if measure == `m' & rnum == `r' & version == "`v'" & reference, meanonly
            local cl`m'_`r'`v' = r(mean)
            quietly summarize avg_after_shown if measure == `m' & rnum == `r' & version == "`v'" & reference, meanonly
            local av`m'_`r'`v' = r(mean)
            quietly summarize before_p if measure == `m' & rnum == `r' & version == "`v'" & reference, meanonly
            local bp`m'_`r'`v' = r(mean)
        }
    }
}
* (a) The answer first: how far the other rates move each drawn average (main
* version), in the chart's own units, and whether any row changes between clear
* and not clear.
local dmax 0
forvalues m = 1/`nmeas' {
    if `u`m'' != 1 continue                                          // the % rows
    local lo = min(`av`m'_1main', `av`m'_2main', `av`m'_3main')
    local hi = max(`av`m'_1main', `av`m'_2main', `av`m'_3main')
    if `hi' - `lo' > `dmax' {
        local dmax = `hi' - `lo'
        local dm `m'
    }
}
local dsh = max(`av6_1main', `av6_2main', `av6_3main') - min(`av6_1main', `av6_2main', `av6_3main')
local dmaxt = string(`dmax', "%9.1f")
local dsht  = string(`dsh', "%9.1f")
local headtxt "Other rates move each % change by at most `dmaxt' percentage points (`w`dm'') and the share in (b) by at most `dsht' points."
* rows clear under all three sets, under some only, under none (main version)
local call ""
local csome ""
forvalues m = 1/`nmeas' {
    local k = `cl`m'_1main' + `cl`m'_2main' + `cl`m'_3main'
    if `k' == 3 local call = "`call'" + cond("`call'" != "", ", ", "") + "`w`m''"
    if inrange(`k', 1, 2) local csome = "`csome'" + cond("`csome'" != "", ", ", "") + "`w`m''"
}
if "`call'" == "" & "`csome'" == "" local cltxt "No row is clearly different from 0 under any set."
else if "`csome'" == "" local cltxt "Clearly different from 0 under all three sets: `call'; the other rows under none."
else local cltxt "Clear under some sets only: `csome'" + cond("`call'" != "", "; under all three: `call'", "") + "."
* (b) Why the rates matter so little here.
* Plain words for the year fixed effects: "the comparison removes whatever all firms share in a year".
local whytxt "Row (5) cannot change: its grid rate is the same for all firms in a year, and the comparison removes what all firms share"
local whytxt "`whytxt' in a year (checked); other rows move only through each firm's fuel and electricity mix."
* (c) The three sets, from the file.
local dlot = cond(`dlo' > 0, "+", "") + string(`dlo', "%9.0f") + "%"
local dhit = cond(`dhi' > 0, "+", "") + string(`dhi', "%9.0f") + "%"
local ratetxt "CO2 is not measured: GJ of each fuel × a rate per fuel, plus bought kWh × a national grid rate; the file stores all three"
local ratetxt "`ratetxt' sets but not their outside source. Main: grid rate `gkg_first' kg CO2 per kWh (`gy0') rising to `gkg_last' (`gy1'), then kept"
local ratetxt "`ratetxt' (no later rate in the file). Grid rate fixed: `gkg_fix' in every year. Scenario 2: `gkg_fix', and each fuel's rate `dlot'"
local ratetxt "`ratetxt' to `dhit' of main (all rates: Table `exhibit')."
local nb = uchar(160)                                   // no-break space: "p = 0.022" stays on one line
* (d) Before-start check for the drawn rows (main rates, main version).
local nfail 0
local failtxt ""
forvalues m = 1/`nmeas' {
    if `bp`m'_1main' < 0.05 {
        local ++nfail
        local failtxt = "`failtxt'" + cond(`nfail' > 1, ", ", "") + "`w`m'' (p`nb'=`nb'" + string(`bp`m'_1main', "%5.3f") + ")"
    }
}
if `nfail' == 0 local btxt "Before the start no row differed clearly (right column; p below 0.05 would be a warning)."
else local btxt "Warning: `failtxt' already differed before the start."
* (e) Single years whose interval excludes 0 (main rates, main version), each
* with the number of versions in which that year is clear; the chance rate; and
* how many single years the other rates move between clear and not clear.
local ndots 0
local nsy 0
local nflip 0
local sytxt ""
forvalues m = 1/`nmeas' {
    quietly count if measure == `m' & rnum == 1 & version == "main" & !reference & !missing(b)
    local ndots = `ndots' + r(N)
    quietly levelsof event_time if measure == `m' & rnum == 1 & version == "main" & !reference & !missing(b), local(ka)
    foreach k of local ka {
        quietly count if measure == `m' & version == "main" & event_time == `k' & (lo > 0 | hi < 0)
        if !inlist(r(N), 0, 3) local ++nflip                            // clear under some sets only
    }
    quietly levelsof event_time if measure == `m' & rnum == 1 & version == "main" & !reference & (lo > 0 | hi < 0), local(ks)
    local part ""
    local nk 0
    foreach k of local ks {
        local ++nk
        local ++nsy
        quietly count if measure == `m' & rnum == 1 & event_time == `k' & (lo > 0 | hi < 0)
        local nvc = r(N)
        local kl = cond(`k' > 0, "+", "") + string(`k')
        quietly summarize grouped if measure == `m' & rnum == 1 & event_time == `k' & version == "main", meanonly
        if r(max) == 1 local kl = cond(`k' < 0, "≤ ", "≥ ") + "`kl'"
        local part = "`part'" + cond(`nk' > 1, ", ", "") + "`kl' (`nvc')"
    }
    if `nk' > 0 local sytxt = "`sytxt'" + cond("`sytxt'" != "", "; ", "") + "(`m') `part'"
}
local fliptxt = cond(`nflip' == 0, "none", "`nflip'")
* The full list goes under the regression table (Panel A shows every single year);
* the chart, which draws only averages, gives the count and points there.
if "`sytxt'" == "" {
    local sytxt "No single year in Panel A has a 95% interval that excludes 0."
    local sychart "No single year's interval excludes 0 (Table `exhibit', regression)."
}
else {
    local sytxt "Single years in Panel A whose 95% interval excludes 0, with the number of the `nv' versions in which they do: `sytxt'; `nsy' of `ndots', about `=round(0.05*`ndots')' by chance. Other rates move `fliptxt' of the `ndots' between clear and not clear."
    local sychart "Single years: `nsy' of `ndots' clear, about `=round(0.05*`ndots')' by chance (listed under Table `exhibit', regression)."
}
* (f) The five versions (CSV): each drawn average's range under the main rates,
* with the versions in which it is clear; and every case in which the three sets
* disagree on clear / not clear.
local vs_main       "all"
local vs_nodoubt    "no doubtful records"
local vs_no2017     "no 2017 starters"
local vs_exact      "exact starters"
local vs_no2017rows "no 2017 rows"
* the same versions in words for the chart (no undefined short names there)
local vc_nodoubt    "without doubtful energy records"
local vc_no2017     "without 2017 starters"
local vc_exact      "starters seen not exporting the year before"
local vc_no2017rows "without the 2017 rows"
local rngtxt ""
forvalues m = 1/`nmeas' {
    quietly summarize avg_after_shown if measure == `m' & rnum == 1 & reference
    local dec = cond(`u`m'' == 1, 1, 0.1)
    local fmt = cond(`u`m'' == 1, "%9.0f", "%9.1f")
    local rlo = round(r(min), `dec')
    local rhi = round(r(max), `dec')
    local un = cond(`u`m'' == 1, "%", " points")
    local rlo = cond(`rlo' > 0, "+", "") + string(`rlo', "`fmt'") + cond(`u`m'' == 1, "%", "")
    local rhi = cond(`rhi' > 0, "+", "") + string(`rhi', "`fmt'") + "`un'"
    local nclr 0
    local clist ""
    foreach v in main nodoubt no2017 no2017rows exact {
        if `cl`m'_1`v'' {
            local ++nclr
            local clist = "`clist'" + cond(`nclr' > 1, ", ", "") + "`vs_`v''"
        }
    }
    local ctx = cond(`nclr' == 0, "never clear", cond(`nclr' == `nv', "clear in all", "clear only: `clist'"))
    local rngtxt = "`rngtxt'" + cond(`m' > 1, "; ", "") + "(`m') `rlo' to `rhi' (`ctx')"
}
local dis ""
local ndis 0
local ndisf 0                                           // ... of which already differ before the start
forvalues s = 1/`nv' {
    local v "`v`s''"
    forvalues m = 1/`nmeas' {
        forvalues r = 2/`nr' {
            if `cl`m'_`r'`v'' != `cl`m'_1`v'' {
                local ++ndis
                local st = cond(`cl`m'_`r'`v'', "clear", "not clear")
                local dis = "`dis'" + cond(`ndis' > 1, "; ", "") + "`vc_`v'', `w`m'': `pt`m'_`r'`v'' `st' with the " ///
                    + lower("`rl`r''") + " (main `pt`m'_1`v''; before the start p = " + string(`bp`m'_`r'`v'', "%5.3f") + ")"
                if `bp`m'_`r'`v'' < 0.05 local ++ndisf
            }
        }
    }
}
local vtxt "Versions (CSV): all; no doubtful energy records; no 2017 starters; no 2017 rows; exact starters (seen not exporting the"
local vtxt "`vtxt' year before). Main-rate averages run: `rngtxt'."
if `ndis' == 0 local distxt "In every version the three sets agree on which rows are clear."
else {
    local distxt "The sets disagree on clear or not only in: `dis'"
    local distxt = "`distxt'" + cond(`ndisf' == `ndis', "; there starters already differed before the start, so these are not answers.", ".")
}
* Chart: one sentence for the other versions (their ranges and the full list are
* under the regression table): every row whose answer (clear or not) differs from
* the main version's under any set of rates, named per version, with the sets in
* which it does and its before-start p.
local vdtxt ""
local nvd 0
foreach v in nodoubt no2017 no2017rows exact {
    local items ""
    local ni 0
    forvalues m = 1/`nmeas' {
        local c0 = `cl`m'_1main'
        local kc = `cl`m'_1`v'' + `cl`m'_2`v'' + `cl`m'_3`v''
        if (`c0' == 0 & `kc' == 0) | (`c0' == 1 & `kc' == `nr') continue
        local ++ni
        if `kc' == `nr' local it "`w`m'' `pt`m'_1`v'', clear under all three sets"
        else if `kc' == 0 local it "`w`m'' not clear under any set (`pt`m'_1`v'')"
        else {
            local sl ""
            local rc 0
            forvalues r = 1/`nr' {
                if `cl`m'_`r'`v'' == 1 - `c0' {
                    local rc `r'
                    local sl = "`sl'" + cond("`sl'" != "", " and ", "") + lower("`rl`r''")
                }
            }
            local it = "`w`m'' `pt`m'_`rc'`v'' " + cond(`c0', "not clear", "clear") + " only with the `sl' (main `pt`m'_1`v''"
            local it = "`it'" + cond(`bp`m'_`rc'`v'' < 0.05, "; differed before the start, p`nb'=`nb'" + string(`bp`m'_`rc'`v'', "%5.3f"), "") + ")"
        }
        local items = "`items'" + cond(`ni' > 1, "; ", "") + "`it'"
    }
    if `ni' > 0 {
        local ++nvd
        local vdtxt = "`vdtxt'" + cond(`nvd' > 1, "; and for ", "") + "`vc_`v'': `items'"
    }
}
if `nvd' == 0 local vchart "Other sample versions (CSV; Table `exhibit', regression) change no row between clear and not clear under any set."
else local vchart "Other sample versions (CSV; Table `exhibit', regression) differ only for `vdtxt'."
* (g) The rates themselves (read from the file in Step 3), and where they come from (points-table footer).
local ratenote "Grid rate, kg CO2 per kWh (main): `gyrtxt', carried to `cy1'; fixed: `gkg_fix' every year."
local ratenote "`ratenote' Fuels, tonnes CO2 per GJ, main / scenario 2: `frtxt'. Stored in the data file (outside source not named)."
foreach t in headtxt cltxt ratetxt whytxt btxt vchart sychart sytxt vtxt distxt ratenote {
    display "   ``t''"
}
quietly summarize n_starters if measure == 1 & rnum == 1 & version == "main" & reference, meanonly
local nst = string(r(mean), "%9.0fc")
quietly summarize n_comparison if measure == 1 & rnum == 1 & version == "main" & reference, meanonly
local ncf = string(r(mean), "%9.0fc")

*---------------------------------------------------------------------------
display "Step 7/8: the chart: one row per measure, three markers per row (one per set of rates)"
*---------------------------------------------------------------------------
* Notes as one text, wrapped by printed width (R6-01's rule; widths in em).
* (Single years and the versions' ranges are listed under the regression table: the chart draws averages only.)
local txt "Notes: `headtxt' `cltxt' `ratetxt' `whytxt' `btxt' `vchart' `sychart'"
local txt "`txt' Starters (`nst') and never-exporters (`ncf') as in Figure R6-01; changes from the year before the start; GJ = gigajoules."
local txt "`txt' Shows timing, not cause; firm links are fictional: this tests the method, not a finding."
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
local nb = uchar(160)                                   // no-break space: "< 0.001" stays together
* One plot, two panels stacked (R6-03's layout): (a) the five % rows, (b) the share
* row in percentage points. Panel (b) is drawn in panel (a)'s horizontal units and
* its axis labels are written at its own values, so the columns line up.
keep if reference & version == "main" & measure <= `nmeas'
gen byte pan = cond(measure <= 5, 1, 2)
gen double ypos = .
replace ypos = 10.6 if measure == 1
replace ypos =  9.6 if measure == 2
replace ypos =  8.6 if measure == 3
replace ypos =  7.3 if measure == 4
replace ypos =  6.3 if measure == 5
replace ypos =  2.9 if measure == 6
gen double yalt = ypos - cond(rnum == 2, 0.25, 0.50)            // hollow markers under their row
local ya_lo 5.75                                        // panel (a): gridlines from ... to ...
local ya_hi 11.05
local ya_lab 5.4                                        // its axis labels
local yb_lo 2.35
local yb_hi 3.35
local yb_lab 2.0
local ya_tit 12.25                                      // panel titles
local yb_tit 4.1
local yhd1 11.75                                        // column headers (two lines)
local yhd2 11.4
* x-axis per panel: a round step that grows with the numbers; 0 always inside (R6-01's rule).
forvalues p = 1/2 {
    quietly summarize avg_after_shown_lo if rnum == 1 & pan == `p'
    local xmin = min(r(min), 0)
    quietly summarize avg_after_shown_hi if rnum == 1 & pan == `p'
    local xmax = max(r(max), 0)
    quietly summarize avg_after_shown if pan == `p'
    local xmin = min(`xmin', r(min))
    local xmax = max(`xmax', r(max))
    local rng = `xmax' - `xmin'
    local step = 10^floor(log10(`rng'))
    if `rng'/`step' < 2       local step = `step'/5
    else if `rng'/`step' < 5  local step = `step'/2
    if `rng'/`step' > 6       local step = `step'*2
    local xbot`p' = `step' * floor(`xmin'/`step')
    local xtop`p' = `step' * ceil(`xmax'/`step')
    local step`p' = `step'
    local xfmt`p' = cond(`step' >= 1, "%9.0f", "%9.1f")
}
local span = `xtop1' - `xbot1'
local k2 = `span' / (`xtop2' - `xbot2')                 // panel (b) units -> panel (a) units
foreach v in avg_after_shown avg_after_shown_lo avg_after_shown_hi {
    gen double px_`v' = cond(pan == 1, `v', `xbot1' + (`v' - `xbot2') * `k2')
}
* Layout left to right (panel (a) units): row names, the dots, the three values, before-start p.
local xn  = `xbot1' - 1.75 * `span'
local xc1 = `xtop1' + 0.12 * `span'
local xc2 = `xtop1' + 0.48 * `span'
local xc3 = `xtop1' + 0.84 * `span'
local xc4 = `xtop1' + 1.20 * `span'
local xr  = `xtop1' + 1.70 * `span'
* Gridlines, zero lines and axis labels, written for each panel.
local grid ""
local zero ""
local tx ""
forvalues p = 1/2 {
    local nt = round((`xtop`p'' - `xbot`p'') / `step`p'')
    local ylo = cond(`p' == 1, `ya_lo', `yb_lo')
    local yhi = cond(`p' == 1, `ya_hi', `yb_hi')
    local ylb = cond(`p' == 1, `ya_lab', `yb_lab')
    forvalues j = 0/`nt' {
        local v  = `xbot`p'' + `j' * `step`p''
        local xv = cond(`p' == 1, `v', `xbot1' + (`v' - `xbot2') * `k2')
        local grid `grid' `ylo' `xv' `yhi' `xv'
        local lab = string(`v', "`xfmt`p''") + cond(`p' == 1, "%", "")
        local tx `tx' text(`ylb' `xv' "`lab'", size(vsmall) placement(c))
    }
    local x0 = cond(`p' == 1, 0, `xbot1' + (0 - `xbot2') * `k2')
    local zero `zero' `ylo' `x0' `yhi' `x0'
}
* The three values of each row (one column per set) and before-start p (main rates).
gen double xcol = cond(rnum == 1, `xc1', cond(rnum == 2, `xc2', `xc3'))
gen str12 lbl = cond(shr > 0, "+", "") + string(shr, "%9.1f") + cond(pan == 1, "%", "")
gen double xnm = `xn'
gen double xc4 = `xc4'
gen double ysub = ypos - 0.42
gen str24 c4 = cond(before_p < 0.001, "<`nb'0.001", string(before_p, "%5.3f")) if rnum == 1
replace c4 = c4 + ", differs" if rnum == 1 & before_p < 0.05
gen str60 nm  = ""
gen str70 sub = ""
forvalues m = 1/`nmeas' {
    replace nm  = "`n`m''" if measure == `m' & rnum == 1
    replace sub = "`r`m''" if measure == `m' & rnum == 1
}
local nplot = _N                                        // markers drawn: 3 per row
assert `nplot' == 3 * `nmeas'
twoway (pci `grid', lcolor(gs14) lwidth(vthin)) ///
    (pci `zero', lcolor(gs8) lwidth(thin)) ///
    (rspike px_avg_after_shown_hi px_avg_after_shown_lo ypos if rnum == 1, horizontal lcolor(black) lwidth(thin)) ///
    (scatter ypos px_avg_after_shown if rnum == 1, msymbol(O) msize(small) mcolor(black)) ///
    (scatter yalt px_avg_after_shown if rnum == 2, msymbol(Sh) msize(small) mcolor(gs6)) ///
    (scatter yalt px_avg_after_shown if rnum == 3, msymbol(Th) msize(small) mcolor(gs6)) ///
    (scatter ypos xcol, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnm if rnum == 1, msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xnm if rnum == 1 & sub != "", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) ///
        mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc4 if rnum == 1, msymbol(none) mlabel(c4) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    text(`ya_tit' `xn' "(a) % change after the start", size(small) placement(e)) ///
    text(`yb_tit' `xn' "(b) Share: change after the start in percentage points", size(small) placement(e)) ///
    text(`yhd2' `xn' "Measure", size(vsmall) placement(e)) ///
    text(`yhd1' `xc1' "Main", size(vsmall) placement(e)) text(`yhd2' `xc1' "rates", size(vsmall) placement(e)) ///
    text(`yhd1' `xc2' "Grid rate", size(vsmall) placement(e)) text(`yhd2' `xc2' "fixed", size(vsmall) placement(e)) ///
    text(`yhd1' `xc3' "Scenario", size(vsmall) placement(e)) text(`yhd2' `xc3' "2", size(vsmall) placement(e)) ///
    text(`yhd1' `xc4' "Before the", size(vsmall) placement(e)) text(`yhd2' `xc4' "start, p", size(vsmall) placement(e)) ///
    `tx' ///
    yscale(range(1.7 12.5) off) ylabel(, nogrid) ytitle("") ///
    xscale(range(`xn' `xr') off) xlabel(, nogrid) xtitle("") ///
    legend(order(4 "Main rates: average of years 0 to +`whi'" 5 "Grid rate fixed in every year" ///
                 6 "Scenario 2 rates (other fuel rates, grid rate fixed)" 3 "95% interval (main rates)" 2 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
    subtitle("Average of years 0 to +`whi' after the start, starters minus never-exporters", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none) margin(zero)) ///
    xsize(9) ysize(10) scale(`=7.5/10')                     // text as in R6-03 (0.75)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the dots"
*---------------------------------------------------------------------------
* Both tables use the numbers saved in Step 5 just before the CSV (full precision,
* so a 4-decimal CSV value is never rounded twice), after the chart is saved.
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
* (1) Points table: every plotted marker, in chart order (row by row: black dot,
* hollow square, hollow triangle).
use `full', clear
gen byte rnum = 1 * (rates == "main") + 2 * (rates == "gridfixed") + 3 * (rates == "scen2")
keep if reference == 1 & version == "main" & measure <= `nmeas'
sort measure rnum
local npts = _N
assert `npts' == `nplot'                                 // every drawn marker, once
gen str34 t_pan = cond(measure <= 5, "(a) % change", "(b) Share, points")
gen str45 t_row = ""
forvalues m = 1/`nmeas' {
    replace t_row = "`n`m''" if measure == `m'
}
gen str40 t_ser = cond(rnum == 1, "Dot: main rates", cond(rnum == 2, "Square: grid rate fixed", "Triangle: scenario 2 rates"))
* value and interval as the chart's value columns: one decimal with a sign
gen double shr = round(avg_after_shown, 0.1)
gen str12 t_v  = cond(shr > 0, "+", "") + string(shr, "%9.1f")
gen str12 t_lo = string(avg_after_shown_lo, "%9.1f")
gen str12 t_hi = string(avg_after_shown_hi, "%9.1f")
gen str12 t_st = string(n_starters, "%12.0fc")
gen str12 t_cf = string(n_comparison, "%12.0fc")
gen str12 t_n  = string(n_rows, "%12.0fc")
gen str12 t_p  = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f"))
gen str40 t_status = cond(rnum == 1, "dot, 95% bar", cond(rnum == 2, "hollow square", "hollow triangle"))
replace t_status = t_status + " (= main)" if (measure == 5 & rnum > 1) | (measure == 4 & rnum == 2)
assert t_v != "" & t_st != ""
local rl ""
forvalues j = 3(3)`=`npts' - 3' {
    local rl `rl' `j'
}
local txt_t = itrim(`"`txt'"')
local tnote "Table: every marker of Figure `exhibit', row by row. % change = 100 × (exp(b) − 1) of the average b of years 0 to +`whi';"
local tnote "`tnote' the share row in percentage points (= b). Rounded as the chart's value columns. Firms and firm-years in the estimate"
local tnote "`tnote' (firms with one usable year dropped). All five versions, every year since the start, full precision: tables/`fname'.csv."
ctable_pdf t_pan t_row t_ser t_v t_lo t_hi t_st t_cf t_n t_p t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Average of years 0 to +`whi' after the start, starters minus never-exporters, under three sets of emission rates") ///
    header("Panel" "Row on the chart" "Series (legend)" "Change|(marker)" "95%|low" "95%|high" "Starters" ///
           "Never-|exporters" "Firm-|years" "Before|start, p" "Marker") ///
    right(4 5 6 7 8 9 10) norepeat(1 2) rules(`rl') fontsize(8) perpage(30) ///
    notes("`txt_t'" "`tnote' (= main): identical to the main rates, checked." "`ratenote'" "`srcnote' `devnote'")
display "table -> tables/`fname'_table.pdf (`npts' plotted points)"

* (2) Regression table (AER style): one column per measure, one panel per set of
* rates; coefficient on the first line, (standard error) on the second. Columns
* (7) and (8) need no emission rate: they are the same in every panel.
use `full', clear
gen byte rnum = 1 * (rates == "main") + 2 * (rates == "gridfixed") + 3 * (rates == "scen2")
keep if version == "main"
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep if version == "main"
keep outcome event_time b avg_after_b
rename (b avg_after_b) (b_csv a_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 outcome event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert abs(avg_after_b - a_csv) <= 0.00005 + 1e-9
drop b_csv a_csv
* column c (1-8) of panel p (1-3) = outcome number
forvalues p = 1/`nr' {
    forvalues c = 1/8 {
        local oc`p'_`c' = cond(`c' <= 6, 6 * (`p' - 1) + `c', 12 + `c')     // (7) = 19, (8) = 20
    }
}
quietly levelsof event_time, local(evs)
tempname P
tempfile R
postfile `P' str70 t_lab str24(t1 t2 t3 t4 t5 t6 t7 t8) using `R'
local nrow 0
local rl ""
forvalues p = 1/`nr' {
    if `p' == 1 local ptl "Panel A. Main rates (black dots)"
    if `p' == 2 local ptl "Panel B. Grid rate fixed (squares)"
    if `p' == 3 local ptl "Panel C. Scenario 2 rates (triangles)"
    post `P' ("`ptl'") ("") ("") ("") ("") ("") ("") ("") ("")
    local ++nrow
    * year-by-year markers: Panel A only (Panels B and C: tables/`fname'.csv)
    if `p' == 1 {
        foreach e of local evs {
            local lab = cond(`e' > 0, "+", "") + string(`e')
            if `e' == `wlo' - 1 local lab "≤ `e' (grouped)"
            if `e' == `whi' + 1 local lab "≥ +`e' (grouped)"
            if `e' == -1 {
                post `P' ("-1 (reference)") ("0`nb'(reference)") ("0`nb'(reference)") ("0`nb'(reference)") ("0`nb'(reference)") ///
                    ("0`nb'(reference)") ("0`nb'(reference)") ("0`nb'(reference)") ("0`nb'(reference)")
                local ++nrow
                continue
            }
            forvalues c = 1/8 {
                quietly summarize b if outcome == `oc1_`c'' & event_time == `e', meanonly
                local b`c' = cond(r(N) == 0, "—", string(r(mean), "%9.3f"))
                quietly summarize se if outcome == `oc1_`c'' & event_time == `e', meanonly
                local s`c' = cond(r(N) == 0, "", "(" + string(r(mean), "%9.3f") + ")")
            }
            post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'") ("`b8'")
            post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'") ("`s8'")
            local nrow = `nrow' + 2
        }
    }
    * whole-model rows (the same number on every row of a regression: take the mean)
    forvalues c = 1/8 {
        local o = `oc`p'_`c''
        foreach x in avg_after_b avg_after_se avg_after_shown avg_after_shown_lo avg_after_shown_hi before_p ///
            n_rows n_firms n_starters n_comparison {
            quietly summarize `x' if outcome == `o', meanonly
            local `x' = r(mean)
        }
        local uu = cond(`c' == 6, "", "%")
        foreach q in avg_after_shown avg_after_shown_lo avg_after_shown_hi {
            local `q' = round(``q'', 0.1)                    // round first: no "-0.0"
        }
        local m1`c' = string(`avg_after_b', "%9.3f")
        local m2`c' = "(" + string(`avg_after_se', "%9.3f") + ")"
        local m3`c' = cond(`avg_after_shown' > 0, "+", "") + string(`avg_after_shown', "%9.1f") + "`uu'"
        local m4`c' = "[" + string(`avg_after_shown_lo', "%9.1f") + ", " + string(`avg_after_shown_hi', "%9.1f") + "]"
        local m5`c' = cond(`before_p' < 0.001, "<`nb'0.001", string(`before_p', "%5.3f"))
        local m6`c' = string(`n_rows', "%12.0fc")
        local m7`c' = string(`n_firms', "%12.0fc")
        local m8`c' = string(`n_starters', "%12.0fc") + " + " + string(`n_comparison', "%12.0fc")
    }
    local l1 "Average of years 0 to +`whi', b"
    local l2 ""
    local l3 "`nb'`nb'as drawn (% or points)"
    local l4 "`nb'`nb'95% interval"
    local l5 "Before-start test, joint p"
    local l6 "Observations (firm-years)"
    local l7 "Firms (clusters)"
    local l8 "`nb'`nb'starters + never-exporters"
    forvalues k = 1/8 {
        post `P' ("`l`k''") ("`m`k'1'") ("`m`k'2'") ("`m`k'3'") ("`m`k'4'") ("`m`k'5'") ("`m`k'6'") ("`m`k'7'") ("`m`k'8'")
    }
    local nrow = `nrow' + 8
    local rl `rl' `nrow'
    if `p' == `nr' {
        post `P' ("All panels") ("") ("") ("") ("") ("") ("") ("") ("")
        local ++nrow
        foreach r in "Firm fixed effects|Yes" "Year fixed effects|Yes" "Industry × year fixed effects|No" ///
            "Province × year fixed effects|No" "Weights|None" "Standard errors clustered by|Firm" {
            gettoken lab cell : r, parse("|")
            local cell = substr("`cell'", 2, .)
            post `P' ("`lab'") ("`cell'") ("`cell'") ("`cell'") ("`cell'") ("`cell'") ("`cell'") ("`cell'") ("`cell'")
            local ++nrow
        }
    }
}
postclose `P'
use `R', clear
local rnote "Notes: Each column is one regression, with firm and year fixed effects, of its measure on one marker per year since the export"
local rnote "`rnote' start, `wlo' to +`whi' except −1 (the year before the start, the reference), plus one marker per grouped end (`nout'+ years before or"
local rnote "`rnote' after); never-exporters are 0 on every marker. Columns (1)-(5), (7), (8): logs, b in log points (drawn as 100 × (exp(b) − 1) %);"
local rnote "`rnote' (6): scope 2 as % of all CO2, b in percentage points. In every panel (1) = (7) − (2) and (3) = (2) − (8) exactly; (5) is identical in"
local rnote "`rnote' all panels and (4) in Panels A and B (checked). Sample: R6-01's; (4) firm-years burning fuel, (5) buying electricity. Before-start"
local rnote "`rnote' test: all years before the start are 0 together. No stars. Panels B and C year by year: tables/`fname'.csv."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 t8 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("Coefficient (standard error). Main version: all starters and never-exporters.") ///
    header("Years since the export start" "(1)|Value added|per t CO2" "(2)|CO2|emitted" "(3)|CO2 per GJ|of energy" ///
           "(4)|CO2 from|fuels" "(5)|CO2 from bought|electricity" "(6)|Electricity's|share of CO2" ///
           "(7)|Value|added" "(8)|Energy|used") ///
    right(2 3 4 5 6 7 8 9) rules(`rl') fontsize(8) perpage(35) landscape ///
    notes("`rnote'" "`sytxt' `vtxt'" "`srcnote' `devnote'")
display "table -> tables/`fname'_regression.pdf (3 panels x 8 regressions)"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
