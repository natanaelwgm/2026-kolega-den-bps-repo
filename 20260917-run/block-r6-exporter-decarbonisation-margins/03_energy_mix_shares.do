/*==========================================================================
  R6-03  When a firm starts exporting, does its energy mix change? Does it
         lean more on bought electricity, burn less oil and more coal or gas,
         and does the CO2 in each GJ of its energy (carbon content) change?
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use". The fuel-mix and
         carbon-content parts; the carbon-content row (b1) is row (5) of
         Figure R6-01.
  Output : figures/03_energy_mix_shares.png (+ .pdf)
           tables/03_energy_mix_shares.csv
           tables/03_energy_mix_shares_table.pdf      (every plotted point)
           tables/03_energy_mix_shares_regression.pdf (the regressions)
  Needs  : Stata add-ons reghdfe, ftools, require (ssc install, once; this
           file installs nothing)
  Checks : the start years, comparison group, usable rows, year window and
           model are R6-01's (block "R6 EXPORT-START SAMPLE", copied exactly).
           When R6-01's table is present in this block, the carbon-content row
           must reproduce R6-01's row (5) to 4 decimals or the file stops.
           Oil + coal + gas shares = 100 on every row, so their coefficients
           must add to 0 at every point (asserted).
  Traps  : the fuel questions change between files (some fuels asked only in
           some years: version "every4" keeps the four fuels asked every year);
           in 2017 far more firms report burning coal (version "no2017rows"
           leaves out every 2017 row). Shares of the file's summed fuel are not
           used: a few firms carry almost all of it.
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
* R2's block sits next to block-0; the sample block below uses it only for its window
* cross-check (if the folder is not there, the check is skipped and the file still runs).
global R2DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r2-internationalisation-energy-efficiency", 1)
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE ROWS (Step 3 builds them) ------------------------------------------
local exhibit "R6-03"
local fname   "03_energy_mix_shares"
local ftitle  "Energy mix and CO2 per GJ after an export start"
local nall 8                    // outcomes estimated
local nmeas 7                   // outcomes drawn (8 = table only)
* (a) shares, in percentage points (each firm's own share, every firm counts equally)
local n1 "(a1) Bought electricity, % of energy"
local n2 "(a2) Electricity's share of CO2, %"
local n3 "(a3) Oil products, % of fuel energy"
local n4 "(a4) Coal, % of fuel energy"
local n5 "(a5) Gas, % of fuel energy"
* (b) carbon content, in % (logs)
local n6 "(b1) CO2 per GJ of all energy"
local n7 "(b2) CO2 per GJ of fuels burned"
local n8 "Burns some coal, % of firms (table only)"
local r1 "GJ; own generation not counted"                 // gray second line under the name
local r2 "CO2 from bought electricity (scope 2), % of all CO2"
local r3 "diesel, petrol, kerosene"
local r4 "coal, coal briquettes, coke"
local r5 "LPG, city gas, other gas"
local r6 "same as row (5) of Figure R6-01"
local r7 "moves only when the fuel mix changes"
local w1 "electricity's share of energy"                  // words for the notes
local w2 "electricity's share of CO2"
local w3 "oil products' share"
local w4 "coal's share"
local w5 "gas's share"
local w6 "CO2 per GJ of all energy"
local w7 "CO2 per GJ of fuels"
local w8 "burning some coal"
local unit1 "pts"
local unit2 "pts"
local unit3 "pts"
local unit4 "pts"
local unit5 "pts"
local unit6 "log"
local unit7 "log"
local unit8 "pts"
* The nine fuels in the energy total, and the four asked in every annual file.
local fuels9 "diesel petrol kerosene coal coalbriq coke lpg citygas othergas"
local fuels4 "diesel petrol coal lpg"
* Fuels recorded only from some year on and NOT in the energy total (said in notes).
* The year far more firms report burning coal (version "no2017rows" leaves it out).
local coal_yr 2017
local outside "fuel_natgas_mmbtu fuel_biomass_kg fuel_fueloil_ltr fuel_dieseloil_ltr fuel_biodiesel_ltr"
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy mix and CO2 per GJ before and after the export start ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy by fuel, CO2 and value added; check the add-ons"
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
* gj_<fuel>               = GJ of each fuel (missing = the question was not asked that year)
* co2_<fuel>_s1           = CO2 tonnes of each fuel (GJ x one standard rate per fuel)
* co2_scope1_s1 / _scope2 = CO2 from fuels burned / from bought electricity (national grid rate)
* value_added_nominal     = value added, current prices (only for the usable-row rule)
* energy_unit_gap_2018_19 = 1 on the years the file flags for an energy-unit gap (one version leaves them out)
* fuel_natgas_mmbtu etc.  = fuels recorded in late files only and NOT in the energy total (said in the notes)
local gjv ""
local cov ""
foreach f of local fuels9 {
    local gjv `gjv' gj_`f'
    local cov `cov' co2_`f'_s1
}
use firm_id year export_flag import_flag total_gj_s1 gj_fuel_s1 gj_electricity co2_total_s1 co2_scope1_s1 ///
    co2_scope2_s1 value_added_nominal energy_unit_gap_2018_19 `gjv' `cov' `outside' using "$DATA", clear
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
display "Step 3/8: the rows (each firm's own shares, CO2 per GJ) and what each annual file asked"
*---------------------------------------------------------------------------
* (In this file the markers and the model of the sample block are in Step 4.)
* A fuel not asked in a year is missing; inside a firm's fuel total it counts as 0
* (the file's fuel total gj_fuel_s1 adds only the fuels asked that year).
capture program drop r6_yranges
program define r6_yranges, rclass
    * Turns a list of years into ranges, e.g. "2012–2014 and 2017–2019".
    * Years next to each other in the list of annual files count as a run
    * (there is no 2016 file, so 2015 and 2017 are next to each other).
    args years fileyears
    local txt ""
    local start ""
    local prev ""
    foreach y of local years {
        if "`start'" == "" {
            local start `y'
            local prev `y'
            continue
        }
        local nxt ""
        local found 0
        foreach z of local fileyears {
            if `found' & "`nxt'" == "" local nxt `z'
            if `z' == `prev' local found 1
        }
        if "`y'" == "`nxt'" local prev `y'
        else {
            local txt = "`txt'" + cond("`txt'" == "", "", " and ") + cond(`start' == `prev', "`start'", "`start'–`prev'")
            local start `y'
            local prev `y'
        }
    }
    if "`start'" != "" local txt = "`txt'" + cond("`txt'" == "", "", " and ") + cond(`start' == `prev', "`start'", "`start'–`prev'")
    return local txt "`txt'"
end
use `fy', clear
local qlist ""
local clist ""
foreach f of local fuels9 {
    gen double q_`f' = cond(missing(gj_`f'), 0, gj_`f')          // GJ, 0 when not asked
    gen double c_`f' = cond(missing(co2_`f'_s1), 0, co2_`f'_s1)  // CO2 tonnes, 0 when not asked
    local qlist `qlist' q_`f'
    local clist `clist' c_`f'
}
* Checks on every row of the file: the parts add up to the file's own totals.
egen double sumq = rowtotal(`qlist')
egen double sumc = rowtotal(`clist')
assert reldif(gj_fuel_s1, sumq) < 1e-9
assert reldif(co2_scope1_s1, sumc) < 1e-9
assert reldif(total_gj_s1, gj_fuel_s1 + gj_electricity) < 1e-9
assert reldif(co2_total_s1, co2_scope1_s1 + co2_scope2_s1) < 1e-9
* The four fuels of version "every4" must be asked in every annual file.
foreach f of local fuels4 {
    assert !missing(gj_`f')
}
quietly levelsof year, local(fyears)
local nfy : word count `fyears'
* Fuels asked in some files only (and ever above 0): the years they were asked.
local qtxt ""
local nq 0                                  // names only, for the chart notes
foreach f in kerosene citygas othergas coalbriq coke {
    quietly levelsof year if !missing(gj_`f'), local(ay)
    quietly summarize q_`f', meanonly
    if r(max) == 0 | `: word count `ay'' == `nfy' continue     // never used, or asked every year
    r6_yranges "`ay'" "`fyears'"
    local nmf = cond("`f'" == "citygas", "city gas", cond("`f'" == "othergas", "other gas", ///
        cond("`f'" == "coalbriq", "coal briquettes", "`f'")))
    local qtxt = "`qtxt'" + cond("`qtxt'" == "", "", ", ") + "`nmf' in `r(txt)'"
    local ++nq
    local qn`nq' "`nmf'"
    display "   `nmf' asked in `r(txt)' only"
}
* Fuels recorded in some files but NOT in the energy total (natural gas, biomass, fuel oils).
gen byte outrec = 0
foreach v of local outside {
    replace outrec = 1 if !missing(`v') & `v' > 0
}
quietly levelsof year if outrec, local(oy)
r6_yranges "`oy'" "`fyears'"
local otxt "`r(txt)'"
quietly count if outrec
display "   rows with natural gas, biomass or fuel oils outside the energy total: " r(N) " (years `otxt')"
* The coal jump year (from the data): share of firms burning coal among rows with
* some fuel, their average coal share of fuel, and coal's share of the file's
* summed fuel (a few big coal users dominate it: never used for the chart).
preserve
keep if gj_fuel_s1 > 0
gen double anycoal = 100 * (q_coal + q_coalbriq + q_coke > 0)
gen double coalsh  = 100 * (q_coal + q_coalbriq + q_coke) / gj_fuel_s1
gen double coalgj  = q_coal + q_coalbriq + q_coke
collapse (mean) anycoal coalsh (sum) coalgj gj_fuel_s1, by(year)
gen double aggsh = 100 * coalgj / gj_fuel_s1
list year anycoal coalsh aggsh, noobs clean
quietly count if year == `coal_yr'
assert r(N) == 1
quietly summarize anycoal if year == `coal_yr'
local c_yes = string(r(mean), "%9.0f")
quietly summarize coalsh if year == `coal_yr'
local c_sh = string(r(mean), "%9.0f")
quietly summarize anycoal if year < `coal_yr'
local c_lo = string(r(min), "%9.0f")
local c_hi = string(r(max), "%9.0f")
quietly summarize coalsh if year < `coal_yr'
local s_lo = string(r(min), "%9.0f")
local s_hi = string(r(max), "%9.0f")
* after the jump year the average coal share falls back, but not to the earlier level
quietly summarize coalsh if year > `coal_yr'
local s_lo2 = string(r(min), "%9.0f")
local s_hi2 = string(r(max), "%9.0f")
quietly summarize aggsh
local aggmax = string(r(max), "%9.1f")
restore
display "   `coal_yr': `c_yes'% of firms with fuel burn coal (`c_lo'-`c_hi'% in earlier files); average coal share `c_sh'% (`s_lo'-`s_hi'% before, `s_lo2'-`s_hi2'% after)"
display "   coal's share of the file's summed fuel reaches `aggmax'% in a year: file totals are not used"

* The rows on the R6 export-start sample.
use `smp', clear
foreach f of local fuels9 {
    gen double q_`f' = cond(missing(gj_`f'), 0, gj_`f')
    gen double c_`f' = cond(missing(co2_`f'_s1), 0, co2_`f'_s1)
}
gen byte fuel = gj_fuel_s1 > 0                                  // some fuel burned
gen double f4 = q_diesel + q_petrol + q_coal + q_lpg              // GJ, fuels asked every year
gen double c4 = c_diesel + c_petrol + c_coal + c_lpg              // their CO2
* Main rows: all fuels in the file. Shares in % (so changes are in percentage points).
gen double y1 = 100 * gj_electricity / total_gj_s1
gen double y2 = 100 * co2_scope2_s1 / co2_total_s1
gen double y3 = 100 * (q_diesel + q_petrol + q_kerosene) / gj_fuel_s1 if fuel
gen double y4 = 100 * (q_coal + q_coalbriq + q_coke) / gj_fuel_s1 if fuel
gen double y5 = 100 * (q_lpg + q_citygas + q_othergas) / gj_fuel_s1 if fuel
gen double y6 = ln(co2_total_s1 / total_gj_s1)                   // = R6-01 row (5)
gen double y7 = ln(co2_scope1_s1 / gj_fuel_s1) if fuel & co2_scope1_s1 > 0
gen double y8 = 100 * (q_coal + q_coalbriq + q_coke > 0) if fuel
* Version "every4": the same rows rebuilt from the four fuels asked every year
* (energy = those four + bought electricity), so a question added or dropped
* between files cannot move a firm's shares.
gen double z1 = 100 * gj_electricity / (f4 + gj_electricity) if f4 + gj_electricity > 0
gen double z2 = 100 * co2_scope2_s1 / (c4 + co2_scope2_s1) if c4 + co2_scope2_s1 > 0
gen double z3 = 100 * (q_diesel + q_petrol) / f4 if f4 > 0
gen double z4 = 100 * q_coal / f4 if f4 > 0
gen double z5 = 100 * q_lpg / f4 if f4 > 0
gen double z6 = ln((c4 + co2_scope2_s1) / (f4 + gj_electricity)) if f4 + gj_electricity > 0 & c4 + co2_scope2_s1 > 0
gen double z7 = ln(c4 / f4) if f4 > 0 & c4 > 0
gen double z8 = 100 * (q_coal > 0) if f4 > 0
* Checks: the three fuel shares make 100 on every row; the rows of each group match.
assert reldif(y3 + y4 + y5, 100) < 1e-9 if fuel
assert reldif(z3 + z4 + z5, 100) < 1e-9 if f4 > 0
assert !missing(y1, y2, y6)
assert !missing(y7) if fuel
assert missing(z1) == missing(z2) & missing(z1) == missing(z6)
assert missing(z3) == missing(z7)
assert reldif(y6, ln(co2_total_s1) - ln(total_gj_s1)) < 1e-9
quietly count
local nrows_all = r(N)
quietly count if !fuel
local nnofuel = r(N)
quietly count if fuel & f4 == 0
local nno4 = r(N)
display "   " %6.0fc `nrows_all' " usable rows; " %5.0fc `nnofuel' " burn no fuel (left out of the fuel rows); " ///
    %4.0fc `nno4' " burn only fuels not asked every year (left out of version every4's fuel rows)"
quietly levelsof year if energy_unit_gap_2018_19 == 1, local(gapyrs)
local gapyrs_txt = subinstr("`gapyrs'", " ", " and ", .)
tempfile smp2
save `smp2'

*---------------------------------------------------------------------------
display "Step 4/8: estimate every row with firm and year fixed effects (clustered by firm), seven versions"
*---------------------------------------------------------------------------
* R6-01's model (R2-03's): the row's measure on one marker per year since the
* start, removing each firm's own average (firm fixed effects) and each year's
* average (year fixed effects, set mostly by the comparison firms). A firm with one
* usable year cannot be compared with itself; reghdfe drops it and reports it.
* b = difference from the firm's year before the start, net of the comparison
* firms' change: in percentage points for shares; for CO2 per GJ (logs),
* % = 100 x (exp(b) - 1).
* Versions (the chart draws the first three; all are in the CSV):
*   main       = R6-01's sample and model, all fuels in the file
*   every4     = only the four fuels asked in every file (Step 3)
*   no2017rows = without every row of the coal jump year (both groups)
*   nodoubt    = without doubtful energy records (sample block)
*   no2017     = drops the 2017 starters (no 2016 file: they may have started in 2016)
*   exact      = keeps only starters seen not exporting the year just before
*   no1819     = without the years flagged for an energy-unit gap
local nv 7
local v1 "main"
local v2 "every4"
local v3 "no2017rows"
local v4 "nodoubt"
local v5 "no2017"
local v6 "exact"
local v7 "no1819"
local e1 "1"
local e2 "1"
local e3 "year != `coal_yr'"
local e4 "!doubt"
local e5 "gA != 2017"                                   // comparison firms (gA missing) stay
local e6 "missing(gA) | exactA == 1"
local e7 "energy_unit_gap_2018_19 != 1"
tempname h
postfile `h' byte outcome str12 version str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_early firms_late start_years) using `est'
forvalues s = 1/`nv' {
    use `smp2', clear
    keep if `e`s''
    if "`v`s''" == "every4" {
        forvalues o = 1/`nall' {
            quietly replace y`o' = z`o'
        }
    }
    local lo_s = `wlo'
    local hi_s = `whi'
    * One marker per year since the start inside the window, except -1 (the year
    * before the start = the reference, 0 by definition), plus one marker for each
    * grouped end. Comparison firms are 0 on every marker. A marker with no starter
    * row in this version is left out (R2-08). (R6-01 Step 5, unchanged.)
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
        quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
        foreach t of local terms {
            if _se[`t'] == 0 {
                display as error "`v`s'', row `o': marker `t' has no starter row left; the version cannot be estimated as set up."
                exit 459
            }
        }
        matrix B`o'_`s' = e(b)
        local df = e(df_r)
        local N`o'_`s'  = e(N)
        local G`o'_`s'  = e(N_clust)
        local sg`o'_`s' = e(num_singletons)
        * rows (a1), (a2), (b1) use the same firm-years; so do (a3)-(a5), (b2) and row 8
        if inlist(`o', 2, 6) assert e(N) == `N1_`s''
        if inlist(`o', 4, 5, 7, 8) assert e(N) == `N3_`s''
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
    * Oil + coal + gas = 100 on every row, so their coefficients add to 0 at every
    * marker and in the average (same firm-years).
    foreach t of local terms {
        assert abs(B3_`s'[1, "`t'"] + B4_`s'[1, "`t'"] + B5_`s'[1, "`t'"]) < 1e-6
    }
    assert abs(`a3_`s'' + `a4_`s'' + `a5_`s'') < 1e-6
    local pshow = cond(`Fp3_`s'' < 0.001, "< 0.001", "= " + string(`Fp3_`s'', "%5.3f"))
    display "   `v`s'': " %6.0fc `N1_`s'' " rows (" %6.0fc `N3_`s'' " with fuel), " %5.0fc `G1_`s'' " firms (" `st1_`s'' " starters); electricity " ///
        %5.1f `a1_`s'' " pts, oil " %5.1f `a3_`s'' ", coal " %5.1f `a4_`s'' ", gas " %5.1f `a5_`s'' " pts; CO2 per GJ " ///
        %5.1f 100 * (exp(`a6_`s'') - 1) "%, of fuels " %5.1f 100 * (exp(`a7_`s'') - 1) "%; shares add to 100 checked"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 5/8: the CSV (numbers written before drawing) and the cross-check with R6-01"
*---------------------------------------------------------------------------
use `est', clear
gen byte vorder = 0
forvalues s = 1/`nv' {
    replace vorder = `s' if version == "`v`s''"
}
assert vorder > 0
gen str45 outcome_label = ""
gen str40 outcome_parts = ""
gen str24 unit = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''" if outcome == `o'
    replace unit = cond("`unit`o''" == "log", "log points; shown as %", "percentage points") if outcome == `o'
}
forvalues o = 1/`nmeas' {
    replace outcome_parts = "`r`o''" if outcome == `o'
}
replace outcome_parts = "coal, coal briquettes or coke above 0" if outcome == 8
gen str160 version_label = ""
replace version_label = "Main: all fuels in the file; export starters vs never-exporters (R6-01's sample and model)"      if vorder == 1
replace version_label = "Only the four fuels asked in every file (diesel, petrol, coal, LPG); energy, fuel and CO2 rebuilt from them" if vorder == 2
replace version_label = "Without every `coal_yr' row (the year far more firms report burning coal)"                     if vorder == 3
replace version_label = "Without doubtful energy records (importers, export status unknown)"                             if vorder == 4
replace version_label = "Without the 2017 starters (they may have started in 2016)"                                      if vorder == 5
replace version_label = "Only starters seen not exporting the year just before"                                          if vorder == 6
replace version_label = "Without the years flagged for an energy-unit gap (`gapyrs_txt')"                                if vorder == 7
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = string(window_first - 1) + " or earlier (grouped)" if term == "ev_lo"
replace column = "+" + string(window_last + 1) + " or later (grouped)" if term == "ev_hi"
* Shown on the chart: shares = b in percentage points; logs = 100 x (exp(b) - 1) %.
gen byte islog = inlist(outcome, 6, 7)
gen double shown    = cond(islog, 100 * (exp(b)  - 1), b)
gen double shown_lo = cond(islog, 100 * (exp(lo) - 1), lo)
gen double shown_hi = cond(islog, 100 * (exp(hi) - 1), hi)
* Numbers for the whole outcome x version (repeated on each of its rows).
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
* ---- Cross-check with R6-01 (when its table is in this block): stop on mismatch ----
* Row (b1) CO2 per GJ of all energy = R6-01's row (5) on the same sample and model.
gen str40 r6_check = ""
capture confirm file "tables/01_margins_export_start.csv"
if !_rc {
    preserve
    import delimited using "tables/01_margins_export_start.csv", clear varnames(1)
    keep if outcome == 5 & inlist(version, "main", "nodoubt", "no2017", "exact", "no1819")
    keep version event_time b avg_after_b
    rename (b avg_after_b) (fig_b fig_avg)
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == 6 & inlist(version, "main", "nodoubt", "no2017", "exact", "no1819")
    quietly merge 1:1 version event_time using `fig'
    quietly count if _merge != 3 | abs(b - fig_b) > 0.00005 + 1e-9 | abs(avg_after_b - fig_avg) > 0.00005 + 1e-9
    if r(N) > 0 {
        display as error "R6-01's row (5) does not match row (b1) here: the R6 sample or model differs between the files."
        exit 459
    }
    quietly count
    display "   01_margins_export_start.csv row (5): all " r(N) " coefficients and the averages reproduced to 4 decimals"
    restore
    replace r6_check = "= 01_margins_export_start row (5)" if outcome == 6 & inlist(version, "main", "nodoubt", "no2017", "exact", "no1819")
}
else display "   tables/01_margins_export_start.csv not found: cross-check with R6-01 skipped"
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference
replace note = "Grouped end: all years before " + string(window_first) + "; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +" + string(window_last) + "; each firm counted once" if term == "ev_hi"
replace note = "No starter row in this version: marker left out" if missing(b) & !reference
sort outcome vorder event_time
order outcome outcome_label outcome_parts unit version version_label column event_time grouped reference ///
      b se lo hi p shown shown_lo shown_hi firms rows firms_early firms_late start_years ///
      n_rows n_firms n_starters n_comparison n_one_year_dropped before_F before_df before_p ///
      before_p_no_grouped avg_after_b avg_after_se avg_after_lo avg_after_hi avg_after_p ///
      avg_after_shown avg_after_shown_lo avg_after_shown_hi window_first window_last r6_check note
drop term vorder islog
format b se lo hi avg_after_b avg_after_se avg_after_lo avg_after_hi before_F %9.4f
format shown shown_lo shown_hi avg_after_shown avg_after_shown_lo avg_after_shown_hi %9.2f
format p before_p before_p_no_grouped avg_after_p %9.3f
format firms rows firms_early firms_late start_years n_rows n_firms n_starters n_comparison n_one_year_dropped before_df %9.0f
tempfile full                                         // full precision, for the companion tables (Step 8)
save `full'
export delimited using "tables/`fname'.csv", datafmt replace
set linesize 220                                      // one line per row in the log listing
list outcome version avg_after_shown avg_after_shown_lo avg_after_shown_hi avg_after_p before_p ///
    n_rows n_starters n_comparison if column == "0", noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 6/8: the notes' numbers, read from the table (never typed)"
*---------------------------------------------------------------------------
keep if reference
keep outcome version avg_after_shown avg_after_shown_lo avg_after_shown_hi avg_after_p before_p ///
     n_rows n_starters n_comparison
gen byte clear = avg_after_shown_lo > 0 | avg_after_shown_hi < 0      // interval does not cross 0
gen byte sgn   = cond(avg_after_shown > 0, 1, -1)
gen str30 ptxt = cond(avg_after_shown > 0, "+", "") + string(avg_after_shown, "%9.1f") ///
    + cond(inlist(outcome, 6, 7), "%", " points")
forvalues o = 1/`nall' {
    foreach v in main every4 no2017rows nodoubt no2017 exact no1819 {
        quietly levelsof ptxt if outcome == `o' & version == "`v'", local(tt) clean
        local pt`o'`v' "`tt'"
        quietly summarize clear if outcome == `o' & version == "`v'"
        local cl`o'`v' = r(mean)
        quietly summarize sgn if outcome == `o' & version == "`v'"
        local sg`o'`v' = r(mean)
        quietly summarize before_p if outcome == `o' & version == "`v'"
        local bp`o'`v' = r(mean)
    }
}
* (a) the answer first: which drawn rows are clearly different from 0 (main)
local nclr 0
local nunc 0
forvalues o = 1/`nmeas' {
    if `cl`o'main' {
        local ++nclr
        local clr`nclr' "`w`o'' (`pt`o'main')"
    }
    else {
        local ++nunc
        local unc`nunc' "`w`o''"
    }
}
local clrtxt ""
forvalues j = 1/`nclr' {
    local sep = cond(`j' == 1, "", cond(`j' == `nclr', " and ", ", "))
    local clrtxt "`clrtxt'`sep'`clr`j''"
}
local unctxt ""
forvalues j = 1/`nunc' {
    local sep = cond(`j' == 1, "", cond(`j' == `nunc', " and ", ", "))
    local unctxt "`unctxt'`sep'`unc`j''"
}
if `nclr' == 0 local headtxt "After the start, no row is clearly different from 0."
else local headtxt "After the start, clearly different from 0: `clrtxt'."
local othtxt ""
if `nunc' > 0 & `nclr' > 0 local othtxt "The other rows are not clear."
* (b) before-start check (main)
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
if `nfail' == 0 local btxt "Before the start, no row differed clearly (a before-start p below 0.05 would be a warning)."
else local btxt "Warning: `failtxt' already differed before the start (before-start p < 0.05)."
* (c) the four-fuels version (hollow squares, their numbers in their own column):
* do the clear answers survive when only fuels asked in every file count? This
* sentence follows the answer directly, so no reader sees the answer without it.
local e4txt ""
local nlost4 0
local k 0
forvalues o = 1/`nmeas' {
    if !`cl`o'main' continue
    local ++k
    local sep = cond(`k' == 1, "", cond(`k' == `nclr', " and ", ", "))
    local e4txt = "`e4txt'`sep'`w`o'' `pt`o'every4' (" + cond(`cl`o'every4' & `sg`o'every4' == `sg`o'main', "clear", "not clear") + ")"
    if !(`cl`o'every4' & `sg`o'every4' == `sg`o'main') local ++nlost4
}
if `nclr' == 0 local e4txt ""
else {
    local e4txt "Counting only the four fuels asked in every file (squares): `e4txt'"
    if `nlost4' > 0 local e4txt "`e4txt'. So part of this shift reflects fuels added to or dropped from the questions, not firms changing fuel."
    else local e4txt "`e4txt'."
}
* (d) the five other versions (hollow triangles = the first; the rest in the table):
* for each clear row, in how many it stays clear in the same direction; and
* unclear rows that become clear.
local vs_no2017rows "without `coal_yr' rows"
local vs_nodoubt    "without doubtful records"
local vs_no2017     "without the 2017 starters"
local vs_exact      "starters seen not exporting the year before"
local vs_no1819     "without `gapyrs_txt'"
local nov 5
local stay ""
local k 0
forvalues o = 1/`nmeas' {
    if !`cl`o'main' continue
    local ++k
    local ns 0
    foreach v in no2017rows nodoubt no2017 exact no1819 {
        if `cl`o'`v'' & `sg`o'`v'' == `sg`o'main' local ++ns
    }
    local sep = cond(`k' == 1, "", cond(`k' == `nclr', " and ", ", "))
    local stay "`stay'`sep'`w`o'' in `ns' of `nov'"
}
* An unclear row that turns clear in one version is named, with a warning when that
* version fails the before-start check for the row.
local gaintxt ""
local ngain 0
forvalues o = 1/`nmeas' {
    if `cl`o'main' continue
    foreach v in no2017rows nodoubt no2017 exact no1819 {
        if `cl`o'`v'' {
            local gaintxt = "`gaintxt'" + cond(`ngain' > 0, "; ", "") + "`w`o'' (`vs_`v''" ///
                + cond(`bp`o'`v'' < 0.05, ", already different before the start there", "") + ")"
            local ++ngain
        }
    }
}
local vtxt "Without `coal_yr' rows (triangles) and in 4 more versions (table):"
if `nclr' > 0 local vtxt "`vtxt' `stay' stay clear"
else local vtxt "`vtxt' no answer is clear in main"
local vtxt = "`vtxt'" + cond(`ngain' == 0, "; no unclear answer becomes clear.", "; clear in one version only: `gaintxt'.")
* (e) the questionnaire, the coal jump and what is outside the energy total (Step 3)
local qsent "Some fuels are asked only in some files: `qtxt'."     // table notes (with years)
local qnames ""
forvalues j = 1/`nq' {
    local sep = cond(`j' == 1, "", cond(`j' == `nq', " and ", ", "))
    local qnames "`qnames'`sep'`qn`j''"
}
local qshort = upper(substr("`qnames'", 1, 1)) + substr("`qnames'", 2, .) + " are asked in some files only (years: table)."
* The average firm's coal share jumps in this one year (the share of firms burning
* some coal stays high for longer; the year effects take out what all firms share).
local csent "In `coal_yr' coal is `c_sh'% of the average firm's fuel (`s_lo'% to `s_hi'% before, `s_lo2'% to `s_hi2'% after); triangles leave `coal_yr' out."
local osent "Natural gas, biomass and fuel oils (recorded in `otxt' only) are not in the energy total: gas is under-counted then."
local asent "Each firm's own shares count equally (a few firms make coal up to `aggmax'% of all fuel in the file)."
display "   `headtxt'"
display "   `e4txt'"
display "   `othtxt'"
display "   `btxt'"
display "   `vtxt'"
display "   `qsent'"
display "   `csent'"
display "   `osent'"
display "   `asent'"
quietly summarize n_starters if version == "main" & outcome == 1
local nst = string(r(mean), "%9.0fc")
quietly summarize n_comparison if version == "main" & outcome == 1
local ncf = string(r(mean), "%9.0fc")
quietly summarize n_rows if version == "main" & outcome == 3
local nfr = string(r(mean), "%9.0fc")
quietly summarize n_rows if version == "main" & outcome == 1
local nar = string(r(mean), "%9.0fc")
tempfile avg
save `avg'

*---------------------------------------------------------------------------
display "Step 7/8: the chart: (a) shares in percentage points, (b) CO2 per GJ in %"
*---------------------------------------------------------------------------
* Notes as one text, wrapped by printed width (R6-01's rule; widths in em).
* The answer, then at once the four-fuels check (squares), so the main dots are never
* read without it; then the before-start warning, the questionnaire and coal facts.
* The other versions (vtxt), "other rows not clear" (the bars show it) and the
* questionnaire years go to the points table's notes.
local tail "Starters: first seen exporting after a year seen not exporting (`nst'; still starters if they stop);"
local tail "`tail' never-exporters: never seen exporting (`ncf'). Markers: change since the year before the start;"
local tail "`tail' bars = 95% intervals (crossing 0 = not clear). `asent' Fuel shares: the `nfr' of `nar' firm-years with some"
local tail "`tail' fuel; (a3) + (a4) + (a5) = 0. `osent' CO2 = GJ x standard rates, not measured; GJ = gigajoules."
local tail "`tail' Shows timing, not cause; firm links are fictional: this tests the method, not a finding."
local txt   "Notes: `headtxt' `e4txt' `btxt' `qshort' `csent' `tail'"
* the points table's notes: the same, plus the other versions and the questionnaire years
local txt_t "Notes: `headtxt' `e4txt' `othtxt' `btxt' `qsent' `csent' `vtxt' `tail'"
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
* One plot, two panels stacked: (a) shares in percentage points on top, (b) CO2 per
* GJ in % below. Each panel has its own round axis; panel (b) is drawn in panel
* (a)'s horizontal units and its axis labels are written at its own values, so
* both panels use the same horizontal space and the columns line up.
use `avg', clear
keep if inlist(version, "main", "every4", "no2017rows") & outcome <= `nmeas'
gen byte pan = cond(outcome <= 5, 1, 2)
gen double ypos = .
replace ypos = 9.6 if outcome == 1
replace ypos = 8.6 if outcome == 2
replace ypos = 7.2 if outcome == 3
replace ypos = 6.2 if outcome == 4
replace ypos = 5.2 if outcome == 5
replace ypos = 2.6 if outcome == 6
replace ypos = 1.6 if outcome == 7
gen double yalt = ypos - cond(version == "every4", 0.24, 0.44)   // hollow markers under their row
local ya_lo 4.65                                        // panel (a): gridlines from ... to ...
local ya_hi 10.05
local ya_lab 4.3                                        // its axis labels
local yb_lo 1.05
local yb_hi 3.05
local yb_lab 0.7
local ya_tit 11.05                                      // panel titles
local yb_tit 3.55
local yhd 10.35                                         // column headers
* x-axis per panel: a round step that grows with the numbers; 0 always inside (R6-01's rule).
forvalues p = 1/2 {
    quietly summarize avg_after_shown_lo if version == "main" & pan == `p'
    local xmin = min(r(min), 0)
    quietly summarize avg_after_shown_hi if version == "main" & pan == `p'
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
* Layout left to right (panel (a) units): row names, the dots, the squares' numbers
* (four every-year fuels), the before-start check.
local xn  = `xbot1' - 1.45 * `span'
local xc2 = `xtop1' + 0.22 * `span'
local xc3 = `xtop1' + 0.80 * `span'
local xr  = `xtop1' + 1.28 * `span'
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
        local lab = string(`v', "`xfmt`p''") + cond(`p' == 2, "%", "")
        local tx `tx' text(`ylb' `xv' "`lab'", size(vsmall) placement(c))
    }
    local x0 = cond(`p' == 1, 0, `xbot1' + (0 - `xbot2') * `k2')
    local zero `zero' `ylo' `x0' `yhi' `x0'
}
* value labels start right of the bar, or right of the zero line when the bar ends left of it
gen double px_lbl = max(px_avg_after_shown_hi, cond(pan == 1, 0, `xbot1' + (0 - `xbot2') * `k2'))
gen double xnm = `xn'
gen double xc2 = `xc2'
gen double xc3 = `xc3'
gen double ysub = ypos - 0.42
* The squares' numbers (four every-year fuels) on each main row, with "clear" or
* "not clear", so the check sits next to every black dot.
gen str30 c2 = ""
forvalues o = 1/`nmeas' {
    quietly summarize avg_after_shown if version == "every4" & outcome == `o', meanonly
    local sv = r(mean)
    quietly summarize clear if version == "every4" & outcome == `o', meanonly
    local sc = r(mean)
    replace c2 = cond(`sv' > 0, "+", "") + string(`sv', "%9.1f") + cond(`o' > 5, "%", "") ///
        + cond(`sc', ", clear", ", not clear") if outcome == `o' & version == "main"
}
gen str24 c3 = cond(before_p < 0.001, "<`nb'0.001", string(before_p, "%5.3f")) if version == "main"
replace c3 = c3 + ", differs" if version == "main" & before_p < 0.05
gen str12 lbl = cond(avg_after_shown > 0, "+", "") + string(avg_after_shown, "%9.1f") ///
    + cond(pan == 2, "%", "") if version == "main"
gen str60 nm  = ""
gen str70 sub = ""
forvalues o = 1/`nmeas' {
    replace nm  = "`n`o''" if outcome == `o' & version == "main"
    replace sub = "`r`o''" if outcome == `o' & version == "main"
}
twoway (pci `grid', lcolor(gs14) lwidth(vthin)) ///
    (pci `zero', lcolor(gs8) lwidth(thin)) ///
    (rspike px_avg_after_shown_hi px_avg_after_shown_lo ypos if version == "main", horizontal lcolor(black) lwidth(thin)) ///
    (scatter ypos px_avg_after_shown if version == "main", msymbol(O) msize(small) mcolor(black)) ///
    (scatter yalt px_avg_after_shown if version == "every4", msymbol(Sh) msize(small) mcolor(gs7)) ///
    (scatter yalt px_avg_after_shown if version == "no2017rows", msymbol(Th) msize(small) mcolor(gs7)) ///
    (scatter ypos px_lbl if version == "main", msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) ///
        mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnm if version == "main", msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xnm if version == "main" & sub != "", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) ///
        mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc3 if version == "main", msymbol(none) mlabel(c3) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc2 if version == "main", msymbol(none) mlabel(c2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs5)), ///
    text(`ya_tit' `xn' "(a) Shares: change after the start in percentage points", size(small) placement(e)) ///
    text(`yb_tit' `xn' "(b) CO2 per GJ: % change after the start", size(small) placement(e)) ///
    text(`yhd' `xn' "Measure", size(vsmall) placement(e)) ///
    text(`yhd' `xc2' "Square: four fuels", size(vsmall) placement(e) color(gs5)) ///
    text(`yhd' `xc3' "Before the start, p", size(vsmall) placement(e)) ///
    `tx' ///
    yscale(range(0.5 11.3) off) ylabel(, nogrid) ytitle("") ///
    xscale(range(`xn' `xr') off) xlabel(, nogrid) xtitle("") ///
    legend(order(4 "Average of years 0 to +`whi', all fuels in the file" 5 "Only the four fuels asked in every file" ///
                 6 "Without the `coal_yr' rows" 3 "95% interval" 2 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
    subtitle("Average of years 0 to +`whi' after the start, starters minus never-exporters", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none) margin(zero)) ///
    xsize(9) ysize(10) scale(`=7.5/10')                     // text as in R6-01 (9 x 7.5 in)

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
* (1) Points table: every plotted point, in chart order (row by row: black dot,
* hollow square, hollow triangle).
use `full', clear
keep if reference == 1 & outcome <= `nmeas' & inlist(version, "main", "every4", "no2017rows")
gen byte vo = 1*(version == "main") + 2*(version == "every4") + 3*(version == "no2017rows")
sort outcome vo
local npts = _N
assert `npts' == 3 * `nmeas'                             // every drawn marker, once
gen str30 t_pan = cond(outcome <= 5, "(a) Shares, points", "(b) CO2 per GJ, %")
gen str45 t_row = ""
forvalues o = 1/`nmeas' {
    replace t_row = "`n`o''" if outcome == `o'
}
gen str60 t_ser = cond(vo == 1, "Dot: all fuels in the file", ///
    cond(vo == 2, "Square: four every-year fuels", "Triangle: without `coal_yr' rows"))
* value and interval as the chart label: one decimal with a sign
gen str12 t_v  = cond(avg_after_shown > 0, "+", "") + string(avg_after_shown, "%9.1f")
gen str12 t_lo = string(avg_after_shown_lo, "%9.1f")
gen str12 t_hi = string(avg_after_shown_hi, "%9.1f")
gen str12 t_st = string(n_starters, "%12.0fc")
gen str12 t_cf = string(n_comparison, "%12.0fc")
gen str12 t_n  = string(n_rows, "%12.0fc")
gen str12 t_p  = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f"))
gen str40 t_status = cond(vo == 1, "dot, 95% bar, label", cond(vo == 2, "hollow marker; value in its column", "hollow marker only"))
assert t_v != "" & t_st != ""
local rl ""
forvalues j = 3(3)`=`npts' - 3' {
    local rl `rl' `j'
}
local txt_t = itrim(`"`txt_t'"')
local tnote "Table: every marker of Figure `exhibit', row by row. Shares: change in percentage points (= b); CO2 per GJ: % change"
local tnote "`tnote' = 100 × (exp(b) − 1). Average of years 0 to +`whi' after the start; rounded as the chart labels. Firms and firm-years in"
local tnote "`tnote' the estimate (firms with one usable year dropped). All seven versions, every year since the start, full precision: tables/`fname'.csv."
ctable_pdf t_pan t_row t_ser t_v t_lo t_hi t_st t_cf t_n t_p t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Average of years 0 to +`whi' after the start, starters minus never-exporters") ///
    header("Panel" "Row on the chart" "Series (legend)" "Change|(marker)" "95%|low" "95%|high" "Starters" ///
           "Never-|exporters" "Firm-|years" "Before the|start, p" "Status") ///
    right(4 5 6 7 8 9 10) norepeat(1 2) rules(`rl') fontsize(8) perpage(30) ///
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf (`npts' plotted points)"

* (2) Regression table (AER style): one column per drawn row, one panel per drawn
* series; coefficient on the first line, (standard error) on the second.
use `full', clear
keep if outcome <= `nmeas' & inlist(version, "main", "every4", "no2017rows")
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep if outcome <= `nmeas' & inlist(version, "main", "every4", "no2017rows")
keep outcome version event_time b avg_after_b
rename (b avg_after_b) (b_csv a_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 outcome version event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert abs(avg_after_b - a_csv) <= 0.00005 + 1e-9
drop b_csv a_csv
quietly levelsof event_time, local(evs)
tempname P
tempfile R
postfile `P' str100 t_lab str24(t1 t2 t3 t4 t5 t6 t7) using `R'
local nrow 0
local rl ""
foreach v in main every4 no2017rows {
    if "`v'" == "main"       local ptl "Panel A. Black dots: all fuels"
    if "`v'" == "every4"     local ptl "Panel B. Hollow squares: four every-year fuels (model as in A; year by year: CSV)"
    if "`v'" == "no2017rows" local ptl "Panel C. Hollow triangles: without `coal_yr' rows (model as in A; year by year: CSV)"
    post `P' ("`ptl'") ("") ("") ("") ("") ("") ("") ("")
    local ++nrow
    * year-by-year markers: Panel A only (Panels B and C: tables/`fname'.csv)
    if "`v'" == "main" {
        foreach e of local evs {
            local lab = cond(`e' > 0, "+", "") + string(`e')
            if `e' == `wlo' - 1 local lab "≤ `e' (grouped)"
            if `e' == `whi' + 1 local lab "≥ +`e' (grouped)"
            if `e' == -1 {
                post `P' ("-1 (reference)") ("0 (reference)") ("0 (reference)") ("0 (reference)") ("0 (reference)") ///
                    ("0 (reference)") ("0 (reference)") ("0 (reference)")
                local ++nrow
                continue
            }
            forvalues o = 1/`nmeas' {
                quietly summarize b if version == "`v'" & outcome == `o' & event_time == `e', meanonly
                local b`o' = cond(r(N) == 0, "", string(r(mean), "%9.3f"))
                quietly summarize se if version == "`v'" & outcome == `o' & event_time == `e', meanonly
                local s`o' = cond(r(N) == 0, "", "(" + string(r(mean), "%9.3f") + ")")
            }
            post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'")
            post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'")
            local nrow = `nrow' + 2
        }
    }
    * whole-model rows (the same number on every row of a version: take the mean)
    forvalues o = 1/`nmeas' {
        local c `"version == "`v'" & outcome == `o'"'
        foreach x in avg_after_b avg_after_se avg_after_shown avg_after_shown_lo avg_after_shown_hi before_p ///
            before_p_no_grouped n_rows n_firms n_starters n_comparison {
            quietly summarize `x' if `c', meanonly
            local `x' = r(mean)
        }
        local u = cond(inlist(`o', 6, 7), "%", "")
        local m1`o' = string(`avg_after_b', "%9.3f")
        local m2`o' = "(" + string(`avg_after_se', "%9.3f") + ")"
        local m3`o' = cond(`avg_after_shown' > 0, "+", "") + string(`avg_after_shown', "%9.1f") + "`u' [" ///
            + string(`avg_after_shown_lo', "%9.1f") + ", " + string(`avg_after_shown_hi', "%9.1f") + "]"
        local m4`o' = cond(`before_p' < 0.001, "< 0.001", string(`before_p', "%5.3f"))
        local m5`o' = cond(`before_p_no_grouped' < 0.001, "< 0.001", string(`before_p_no_grouped', "%5.3f"))
        local m6`o' = string(`n_rows', "%12.0fc")
        local m7`o' = string(`n_firms', "%12.0fc") + " (" + string(`n_starters', "%12.0fc") + " + " + string(`n_comparison', "%12.0fc") + ")"
    }
    local l1 "Average of years 0 to +`whi', b"
    local l2 ""
    local l3 "Marker on the chart [95% interval]"
    local l4 "Before-start test, joint p"
    local l6 "Observations (firm-years)"
    local l7 "Firms: starters + never-exporters"
    foreach k in 1 2 3 4 6 7 {                          // 5 (grouped end left out): in the CSV
        post `P' ("`l`k''") ("`m`k'1'") ("`m`k'2'") ("`m`k'3'") ("`m`k'4'") ("`m`k'5'") ("`m`k'6'") ("`m`k'7'")
    }
    local nrow = `nrow' + 6
    if "`v'" == "main" {
        post `P' ("Firm and year fixed effects") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes")
        post `P' ("Weights; standard errors clustered by") ("None; firm") ("None; firm") ("None; firm") ("None; firm") ///
            ("None; firm") ("None; firm") ("None; firm")
        local nrow = `nrow' + 2
    }
    local rl `rl' `nrow'
}
postclose `P'
use `R', clear
local rnote "Notes: Each column is one regression of the row's measure (shares in % of the firm's own energy, fuel or CO2; CO2 per GJ in"
local rnote "`rnote' logs) on one marker per year since the export start, `wlo' to +`whi', except −1 (the year before the start: the reference,"
local rnote "`rnote' 0), and one marker for each grouped end (`nout'+ years before or after), with firm and year fixed effects; firms never seen"
local rnote "`rnote' exporting are 0 on every marker. Columns (1)-(5): percentage points; (6)-(7): log points (% = 100 × (exp(b) − 1)). (3) + (4) +"
local rnote "`rnote' (5) = 0 exactly (the three shares make 100). Sample: R6-01's starters and never-exporters, rows with energy, CO2 and value"
local rnote "`rnote' added above 0; columns (3)-(5) and (7) only rows with some fuel burned. Before-start test: all years before the start are 0"
local rnote "`rnote' together. No stars. Panels B and C year by year, four more versions and the table-only row (burns some coal): tables/`fname'.csv."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    header("Years since the export start" "(1)|Electricity|% of energy" "(2)|Electricity|% of CO2" "(3)|Oil|% of fuel" ///
           "(4)|Coal|% of fuel" "(5)|Gas|% of fuel" "(6)|ln CO2 per GJ|all energy" "(7)|ln CO2 per GJ|fuels") ///
    right(2 3 4 5 6 7 8) rules(`rl') fontsize(8.5) perpage(38) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf (3 panels x `nmeas' regressions)"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
