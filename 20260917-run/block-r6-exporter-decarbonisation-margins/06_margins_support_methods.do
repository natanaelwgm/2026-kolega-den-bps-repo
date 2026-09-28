/*==========================================================================
  R6-06  Do the parts of the export-start change hold up? For each margin
         (value added, energy used, CO2 per GJ, bought electricity's share of
         energy, firms making their own electricity): the firms behind it,
         the before-start checks, and the answer under the previous paper's
         four methods for firms that start exporting in different years.
  Answers Bu Deasy R6: "How do exporters decarbonise? What adjustment margins
         explain the energy/carbon productivity gains?" - Strategy "Event
         study untuk melihat perubahan energy use".
  Output : figures/06_margins_support_methods.png (+ .pdf)
           tables/06_margins_support_methods.csv
           tables/06_margins_support_methods_table.pdf      (every plotted point)
           tables/06_margins_support_methods_regression.pdf (one page per margin,
                                                             one column per method)
  Needs  : Stata add-ons from SSC, installed once (the file never installs
           or updates anything):
             ssc install reghdfe    ssc install ftools    ssc install require
             ssc install csdid      ssc install drdid
             ssc install eventstudyinteract               ssc install avar
             ssc install did_imputation
             ssc install did_multiplegt_dyn               ssc install gtools
           reghdfe, ftools and require are needed for any output; a missing
           method package gives an "unavailable" row in the table and on the
           chart, and the file does not stop.
  Built from: the margins, rows and single regression of R6-01 (value added,
           energy used, CO2 per GJ; value added per tonne of CO2), R6-03
           (bought electricity's share of energy) and R6-04 (firms making own
           electricity), re-estimated here: when their tables are present in
           tables/, this file must reproduce them to 4 decimals or it stops.
           The four methods: R2-07 / R2-10's code, unchanged.
  Note   : Sun-Abraham leaves out start years whose year before has no row in
           the margin (the year after the missing file; for own electricity
           also the year after a thinly recorded year): with no reference
           year the package would silently measure those starters against
           their last years instead (R2-10's fix). The log and CSV name them.
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
* R2's block sits next to block-0; its table is used only for the window check
* (if the folder is not there, the check is skipped and the file still runs).
global R2DIR = subinstr("$DATA", "block-0-data-preparation/analysis_ready_data.dta", "block-r2-internationalisation-energy-efficiency", 1)
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}

* ---- THE MARGINS (rows of the chart; 6 = table only) ---------------------------
local exhibit "R6-06"
local fname   "06_margins_support_methods"
local ftitle  "Five changes after an export start, each under five methods"
local nall 6                                           // margins estimated
local nmeas 5                                          // margins drawn (6 = table only)
local n1 "(1) Value added"                             // chart block names
local n2 "(2) Energy used, GJ"
local n3 "(3) CO2 per GJ of energy"
local n4 "(4) Bought electricity, % of energy"
local n5 "(5) Firms making some own electricity"
local n6 "Value added per tonne of CO2 (table only)"
local u1 1                                             // 1 = log: drawn as % change
local u2 1                                             // 2 = share: drawn in percentage points
local u3 1
local u4 2
local u5 2
local u6 1
local src1 "R6-01 row (3)"                             // the reviewed file whose main row this is
local src2 "R6-01 row (4)"
local src3 "R6-01 row (5)"
local src4 "R6-03 row (a1)"
local src5 "R6-04 panel (a)"
local src6 "R6-01 row (1)"
local w1 "value added"                                 // words for the notes
local w2 "energy used"
local w3 "CO2 per GJ"
local w4 "bought electricity's share"
local w5 "firms making own electricity"
local w6 "value added per tonne of CO2"
local og_min 75        // R6-04's (R1-05/R1-07's) rule: own electricity is used in a year only
                       // if it is recorded for at least 75% of the rows of BOTH groups
* -------------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: each margin of the export-start change: support, before-start checks, five methods ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export and import status, energy, CO2, value added and electricity; check the add-ons"
*---------------------------------------------------------------------------
* The single regression needs reghdfe (with ftools and require): the file stops
* without them. Nothing is installed here.
foreach p in reghdfe ftools require {
    capture which `p'
    if _rc {
        display as error "This file needs the Stata add-on `p': type  ssc install `p'  once (see INDEX.md), then run it again."
        exit 199
    }
}
* The four methods are user-written Stata commands (install once, e.g.
* -ssc install csdid-). Each needs its helper command(s). A missing one is
* recorded and its method gets an "unavailable" row (R2-07's guard).
local need_cs   "csdid drdid"
local need_sa   "eventstudyinteract avar"
local need_bjs  "did_imputation"
local need_dcdh "did_multiplegt_dyn gtools"
foreach m in cs sa bjs dcdh {
    local ok_`m' 1
    local miss_`m' ""
    foreach c of local need_`m' {
        capture which `c'
        if _rc {
            local ok_`m' 0
            local miss_`m' "`miss_`m'' `c'"
        }
    }
    if !`ok_`m'' display "   NOTE: not installed:`miss_`m'' - that method gets an 'unavailable' row"
}
* export_flag          = any export activity (1 yes, 0 no, missing = unknown)
* import_flag          = imports raw materials (used for the doubtful energy records)
* total_gj_s1          = energy use in GJ (nine fuels + bought electricity); gj_fuel_s1, gj_electricity = its parts
* co2_total_s1         = CO2 tonnes from the same fuels and electricity (standard rates, not measured)
* value_added_nominal  = value added, current prices (masked money unit)
* elec_purchased_kwh   = electricity bought from PLN and other suppliers (kWh); never missing
* elec_owngen_kwh      = electricity the firm makes itself (kWh); missing = not recorded
* own_gen_unknown      = 1 when own electricity is not recorded
* own_generation_added = 1 if own electricity were inside the energy total (it must be 0)
use firm_id year export_flag import_flag total_gj_s1 co2_total_s1 value_added_nominal ///
    gj_fuel_s1 gj_electricity elec_purchased_kwh elec_owngen_kwh own_gen_unknown own_generation_added ///
    using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
* R6-04's checks: own electricity is never part of energy used (energy = fuels +
* BOUGHT electricity only), and "not recorded" means exactly "missing".
assert own_generation_added == 0
assert reldif(total_gj_s1, gj_fuel_s1 + gj_electricity) < 1e-9
assert reldif(gj_electricity, 0.0036 * elec_purchased_kwh) < 1e-9
assert own_gen_unknown == missing(elec_owngen_kwh)
assert elec_owngen_kwh >= 0 if !missing(elec_owngen_kwh)
assert !missing(elec_purchased_kwh) & elec_purchased_kwh >= 0
drop gj_fuel_s1 own_generation_added
* The calendar year with no annual file (found in the data, never typed; R2-07).
quietly summarize year
local gapyr ""
forvalues t = `r(min)'/`r(max)' {
    quietly count if year == `t'
    if r(N) == 0 local gapyr `gapyr' `t'
}
local gapyr = strtrim("`gapyr'")
display "   calendar years with no file: `gapyr'"

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
display "Step 3/8: the margins, the firm-years each one uses or leaves out, and the markers"
*---------------------------------------------------------------------------
* Every firm-year of the compared firms (starters and never-exporters), before
* any margin's own rule: how many the usable-row rule leaves out, and why.
use `fy', clear
keep if !missing(gA) | keyA == 9001
quietly count
local n_firmrows = r(N)
quietly count if !usable
local n_zero = r(N)
quietly count if !usable & !(total_gj_s1 > 0 & !missing(total_gj_s1))
local n_zero_gj = r(N)
display "   " %6.0fc `n_firmrows' " firm-years of starters and never-exporters; " %5.0fc `n_zero' ///
    " left out by the usable-row rule (" %5.0fc `n_zero_gj' " of them record no energy at all)"
* The margins, on the usable rows of the R6 export-start sample (Step 2).
use `smp', clear
gen double y1 = ln(value_added_nominal)                     // (1) = R6-01 row (3)
gen double y2 = ln(total_gj_s1)                             // (2) = R6-01 row (4)
gen double y3 = ln(co2_total_s1 / total_gj_s1)              // (3) = R6-01 row (5): moves only with the mix
gen double y4 = 100 * gj_electricity / total_gj_s1          // (4) = R6-03 row (a1), percentage points
* (5) = R6-04 panel (a): only rows where own electricity is recorded (yes or no);
* "not recorded" is never read as "makes none". 100 = makes some, 0 = none.
gen byte rec   = !missing(elec_owngen_kwh)
gen byte maker = rec & elec_owngen_kwh > 0
gen double y5 = 100 * maker if rec
gen double y6 = ln(value_added_nominal / co2_total_s1)      // table only: = R6-01 row (1) = (1) - (2) - (3)
assert reldif(y6, y1 - y2 - y3) < 1e-9
assert !missing(y1, y2, y3, y4, y6)
* R6-04's recording rule (R1-05, R1-07), copied: per calendar year, the % of each
* group's rows with own electricity recorded; a year is used only if both groups
* reach `og_min'%. In thinly recorded years the unrecorded firms are mostly firms
* that make none, so dividing by recorded firms would inflate the share.
preserve
collapse (mean) rec_pct = rec mk_pct = y5 (count) nrows = firm_id, by(year never)
replace rec_pct = 100 * rec_pct
reshape wide rec_pct mk_pct nrows, i(year) j(never)
gen byte yr_ok = rec_pct0 >= `og_min' & rec_pct1 >= `og_min'
display "   own electricity recorded, % of rows (starters | never-exporters), and % making some among recorded rows:"
list year nrows0 rec_pct0 mk_pct0 nrows1 rec_pct1 mk_pct1 yr_ok, noobs abbreviate(24) clean
quietly levelsof year if !yr_ok, local(badyrs)
keep year yr_ok
tempfile yrs
save `yrs'
restore
merge m:1 year using `yrs', assert(match) nogenerate
local badtxt = subinstr("`badyrs'", " ", " and ", .)
quietly count if !rec
local n_notrec = r(N)
quietly count if rec & !yr_ok
local n_thin = r(N)
replace y5 = . if !yr_ok
if "`badyrs'" != "" display "   own electricity: years left out (recorded for under `og_min'% of a group's rows): `badtxt'"
display "   own electricity: " %5.0fc `n_notrec' " usable firm-years not recorded, " %5.0fc `n_thin' " in the thinly recorded years (left out of (5) only)"
* R2-03's markers (R6-01 Step 5): one per year since the start inside the
* window, except -1 (the year before the start = the reference, 0 by
* definition), plus one for each grouped end. Never-exporters are 0 on all.
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
keep firm_id year gA kA exactA never doubt y1-y6 `cand'
sort firm_id year
tempfile mk
save `mk'

*---------------------------------------------------------------------------
display "Step 4/8: each margin under the single regression and the four methods (R2-07's code)"
*---------------------------------------------------------------------------
* All: the margin on markers of years since the start, firm and year effects,
* starters compared with firms never seen exporting, clustered by firm, no
* control variables. What differs is how start years and years since the start
* are combined (R2-07). Main number per method = average of years 0 to +`whi'
* with each year counting equally (as R6-01); each method's own single overall
* number is kept too (CSV and regression table).
* Counts behind each estimate: starters with a row from the start year on,
* comparison firms and rows, all inside the estimation sample (variable es).
capture program drop r606_used
program define r606_used, rclass
    quietly {
        egen byte r606_fs = tag(firm_id) if es & !never & year >= gA
        count if r606_fs == 1
        return scalar starters = r(N)
        egen byte r606_fc = tag(firm_id) if es & never
        count if r606_fc == 1
        return scalar comp = r(N)
        count if es
        return scalar rows = r(N)
        drop r606_fs r606_fc
    }
end
tempname h
postfile `h' byte outcome byte morder str8 method str12 row_type int event_time double(b se df) ///
    long(starters comp_firms rows) str80 status str160 note double pin using `est'
timer clear 2
timer on 2
forvalues o = 1/`nall' {
    use `mk', clear
    keep if !missing(y`o')                              // the margin's own firm-years
    gen double y = y`o'
    quietly count
    local nrow`o' = r(N)
    tempfile smpo
    save `smpo'
    display "   [`o'] `n`o'': " %6.0fc `nrow`o'' " firm-years"

    * ---- (1) one regression, all start years together (R6-01's model), and two
    * table-only versions of it: without doubtful energy records (R6-01's
    * "nodoubt") and only starters seen not exporting the year before ("exact").
    foreach s in 1 6 7 {
        use `smpo', clear
        if `s' == 6 keep if !doubt
        if `s' == 7 keep if missing(gA) | exactA == 1
        local mth = cond(`s' == 1, "twfe", cond(`s' == 6, "twfe_nd", "twfe_ex"))
        * A marker with no starter row in this version is left out (R6-01).
        local terms ""
        local pre ""
        local post ""
        foreach t of local cand {
            quietly count if `t'
            if r(N) == 0 continue
            local terms `terms' `t'
            if "`t'" == "ev_lo" | substr("`t'", 4, 1) == "m" local pre `pre' `t'
            else if "`t'" != "ev_hi" local post `post' `t'
        }
        local lc = subinstr("`post'", " ", " + ", .)     // years 0..+`whi', for the average
        local np : word count `post'
        quietly reghdfe y `terms', absorb(firm_id year) vce(cluster firm_id)
        local df = e(df_r)
        capture drop es
        gen byte es = e(sample)
        r606_used
        local st = r(starters)
        local cf = r(comp)
        local rw = r(rows)
        * R6-01 counts every starter in the regression (also those with rows only
        * before the start); the Starters column counts those with a row from the
        * start year on. Keep both so the notes can say which is which.
        if `o' == 1 & `s' == 1 {
            egen byte r606_fa = tag(firm_id) if es & !never
            quietly count if r606_fa == 1
            local nst_any = r(N)
            drop r606_fa
        }
        if `s' == 1 local terms`o' `terms'
        local sg`o'_`s' = e(num_singletons)             // firm-years of firms with one row (dropped)
        * The fewest starters behind any single year from `wlo' to +`whi' (-1 included).
        local fw`o'_`s' = .
        local fk`o'_`s' = .
        forvalues k = `wlo'/`whi' {
            egen byte ft = tag(firm_id) if es & kA == `k'
            quietly count if ft == 1
            if r(N) < `fw`o'_`s'' {
                local fw`o'_`s' = r(N)
                local fk`o'_`s' = `k'
            }
            drop ft
        }
        foreach t of local terms {
            if "`t'" == "ev_lo"      local k = `wlo' - 1
            else if "`t'" == "ev_hi" local k = `whi' + 1
            else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
            local nt = cond(inlist("`t'", "ev_lo", "ev_hi"), "grouped end", "")
            post `h' (`o') (`s') ("`mth'") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
        }
        quietly lincom (`lc') / `np'
        post `h' (`o') (`s') ("`mth'") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("reghdfe, R6-01's markers") (.)
        quietly test `pre'
        post `h' (`o') (`s') ("`mth'") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (r(p))
        * The previous paper's two-way model: one on/off marker from the start year on.
        gen byte after = !never & year >= gA
        quietly reghdfe y after, absorb(firm_id year) vce(cluster firm_id)
        post `h' (`o') (`s') ("`mth'") ("own_overall") (.) (_b[after]) (_se[after]) (e(df_r)) (.) (.) (e(N)) ("ok") ("one on/off marker from the start year on (the previous paper's two-way model)") (.)
    }
    * The four methods use the main version's markers.
    local terms `terms`o''
    local pre ""
    local post ""
    foreach t of local terms {
        if "`t'" == "ev_lo" | substr("`t'", 4, 1) == "m" local pre `pre' `t'
        else if "`t'" != "ev_hi" local post `post' `t'
    }
    local lc = subinstr("`post'", " ", " + ", .)
    local np : word count `post'

    * ---- (2) Callaway-Sant'Anna (csdid): each start year vs never-exporters ----
    * csdid lays out calendar years one by one, so the year with no file is a
    * real gap: starters whose year before the start has no file get no
    * after-start estimate. Its before-start check compares each year before
    * the start with the year before that, inside the window.
    if !`ok_cs' {
        post `h' (`o') (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_cs'")')") ("ssc install csdid; ssc install drdid") (.)
    }
    else {
        use `smpo', clear
        gen int gcs = cond(never, 0, gA)                   // csdid wants 0 = never started
        capture quietly csdid y, ivar(firm_id) time(year) gvar(gcs)
        if _rc {
            post `h' (`o') (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: csdid stopped with error r(`=_rc')") ("") (.)
        }
        else {
            capture drop es
            gen byte es = e(sample)
            r606_used
            local st = r(starters)
            local cf = r(comp)
            local rw = r(rows)
            quietly estat simple
            matrix bb = r(b)
            matrix vv = r(V)
            post `h' (`o') (2) ("cs") ("own_overall") (.) (bb[1,1]) (sqrt(vv[1,1])) (.) (.) (.) (.) ("ok") ("estat simple: all years after the start, weighted by start-year size") (.)
            quietly estat event, window(`wlo' `whi')
            matrix bb = r(b)
            matrix vv = r(V)
            local cn : colnames bb
            foreach c of local cn {
                local j = colnumb(bb, "`c'")
                if "`c'" == "Post_avg" {
                    post `h' (`o') (2) ("cs") ("avg") (.) (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (`st') (`cf') (`rw') ("ok") ("estat event Post_avg: years 0 to +`whi', each counts equally") (.)
                }
                else if inlist(substr("`c'", 1, 2), "Tm", "Tp") {
                    local k = cond(substr("`c'", 2, 1) == "m", -1, 1) * real(substr("`c'", 3, .))
                    local nt = cond(`k' < 0, "change from the year before (csdid's own base for years before the start)", "vs the year before the start")
                    post `h' (`o') (2) ("cs") ("event") (`k') (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (.) (.) (.) ("ok") ("`nt'") (.)
                }
            }
            capture quietly estat pretrend, window(`wlo' -1)
            local ptxt "estat pretrend inside the window"
            if _rc {
                quietly estat pretrend                    // older csdid: no window option
                local ptxt "estat pretrend, all years before the start"
            }
            post `h' (`o') (2) ("cs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("`ptxt'; p in column p") (r(pchi2))
            if "`ptxt'" == "estat pretrend inside the window" {
                quietly estat pretrend
                post `h' (`o') (2) ("cs") ("before_all") (.) (.) (.) (.) (.) (.) (.) ("ok") ("estat pretrend, all years before the start (table only); p in column p") (r(pchi2))
            }
        }
    }

    * ---- (3) Sun-Abraham (eventstudyinteract): R6-01's markers, start years kept apart ----
    local sa_yrs`o' ""
    local sa_out`o' 0
    if !`ok_sa' {
        post `h' (`o') (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_sa'")')") ("ssc install eventstudyinteract; ssc install avar") (.)
    }
    else {
        use `smpo', clear
        * A start year whose year before has no row in this margin (the year after
        * the missing file; for own electricity also the year after a thinly
        * recorded year) has no reference year: the package would silently measure
        * those starters against their last years instead (it drops one of their
        * markers). Leave such start years out, as Callaway-Sant'Anna and
        * de Chaisemartin-D'Haultfoeuille do by construction (R2-10's fix).
        bysort gA: egen byte has_ref = max(kA == -1)
        egen byte ft0 = tag(firm_id) if !never & !has_ref
        quietly count if ft0 == 1
        local sa_out`o' = r(N)
        quietly levelsof gA if !never & !has_ref, local(sa_yrs`o')
        drop if !never & !has_ref
        drop ft0 has_ref
        display "   Sun-Abraham: start years left out (no row the year before): `sa_yrs`o'' (`sa_out`o'' starters)"
        local sa_terms ""
        foreach t of local terms {
            quietly count if `t'
            if r(N) > 0 local sa_terms `sa_terms' `t'
        }
        assert "`sa_terms'" == "`terms'"                 // every marker still has starter rows
        capture quietly eventstudyinteract y `terms', cohort(gA) control_cohort(never) absorb(i.firm_id i.year) vce(cluster firm_id)
        if _rc {
            post `h' (`o') (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: eventstudyinteract stopped with error r(`=_rc')") ("") (.)
        }
        else {
            capture drop es
            gen byte es = e(sample)
            r606_used
            local st = r(starters)
            local cf = r(comp)
            local rw = r(rows)
            local df = e(df_r)
            matrix bsa = e(b_iw)
            matrix vsa = e(V_iw)
            ereturn post bsa vsa, dof(`df')
            foreach t of local terms {
                if "`t'" == "ev_lo"      local k = `wlo' - 1
                else if "`t'" == "ev_hi" local k = `whi' + 1
                else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
                local nt = cond(inlist("`t'", "ev_lo", "ev_hi"), "grouped end", "")
                post `h' (`o') (3) ("sa") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
            }
            quietly lincom (`lc') / `np'
            local syl = cond("`sa_yrs`o''" == "", "none", subinstr("`sa_yrs`o''", " ", ", ", .))
            post `h' (`o') (3) ("sa") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally; start years left out (no row the year before): `syl' (`sa_out`o'' starters)") (.)
            quietly test `pre'
            post `h' (`o') (3) ("sa") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (r(p))
        }
    }

    * ---- (4) Borusyak-Jaravel-Spiess (did_imputation) ----
    * Fits firm and year effects on rows not yet (or never) exporting, predicts
    * each starter's path without the start, and averages actual minus
    * predicted. Its before-start check asks whether the years just before the
    * start already differ from the firm's earlier years.
    if !`ok_bjs' {
        post `h' (`o') (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_bjs'")')") ("ssc install did_imputation") (.)
    }
    else {
        use `smpo', clear
        gen int Ei = gA                                  // start year; missing = never started
        * minn(0): report every year; the window rule already needs 30+ starters per year.
        capture quietly did_imputation y firm_id year Ei, horizons(0/`whi') pretrends(`=-`wlo'') autosample minn(0)
        if _rc {
            post `h' (`o') (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_imputation stopped with error r(`=_rc')") ("") (.)
        }
        else {
            capture drop es
            gen byte es = e(sample)
            r606_used
            local st = r(starters)
            local cf = r(comp)
            local rw = r(rows)
            local p_bjs = e(pre_p)
            forvalues k = 0/`whi' {
                post `h' (`o') (4) ("bjs") ("event") (`k') (_b[tau`k']) (_se[tau`k']) (.) (.) (.) (.) ("ok") ("vs predicted path without the start") (.)
            }
            forvalues k = 1/`=-`wlo'' {
                post `h' (`o') (4) ("bjs") ("event") (-`k') (_b[pre`k']) (_se[pre`k']) (.) (.) (.) (.) ("ok") ("before-start check: vs the firm's earlier years") (.)
            }
            local lcb "tau0"
            forvalues k = 1/`whi' {
                local lcb "`lcb' + tau`k'"
            }
            quietly lincom (`lcb') / `=`whi' + 1'
            post `h' (`o') (4) ("bjs") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally") (.)
            post `h' (`o') (4) ("bjs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of the `=-`wlo'' years before the start; p in column p") (`p_bjs')
            capture quietly did_imputation y firm_id year Ei, autosample minn(0)
            if !_rc post `h' (`o') (4) ("bjs") ("own_overall") (.) (_b[tau]) (_se[tau]) (.) (.) (.) (e(N)) ("ok") ("one average over all starter rows from the start on") (.)
        }
    }

    * ---- (5) de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn) ----
    * It numbers periods as they appear in the data, so every calendar year
    * missing inside a firm's span (the year with no file included) gets an
    * empty row with the start status filled in (R2-07's fix). Only
    * never-exporters are comparisons; starters whose year before the start has
    * no row drop out. "Effect_1" = the start year (year 0), Effect_2 = year +1,
    * ...; "Placebo_1" = year -2, Placebo_2 = -3, ...
    local dpl`o' = .
    if !`ok_dcdh' {
        post `h' (`o') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_dcdh'")')") ("ssc install did_multiplegt_dyn; ssc install gtools") (.)
    }
    else {
        use `smpo', clear
        * Starters with no row from their start year on would look like firms
        * that never start: leave them out (as the other methods do).
        bysort firm_id: egen byte has_after = max(!never & year >= gA)
        drop if !never & !has_after
        keep firm_id year y gA never
        tsset firm_id year
        tsfill                                          // empty rows for missing years inside each firm's span
        bysort firm_id (gA): replace gA = gA[1]
        bysort firm_id (never): replace never = never[1]
        gen byte D = !never & year >= gA                // start status: on from the start year, stays on
        keep firm_id year y D
        local ne  = `whi' + 1                           // Effect_1..Effect_`ne' = years 0..+`whi'
        local npl = -`wlo' - 1                          // Placebo_1..Placebo_`npl' = years -2..`wlo'
        * The package updates itself from the internet in 1 run in 100 unless
        * told not to. This file never installs or updates anything.
        * A placebo with no starter or no comparison firm behind it (e.g. year -4
        * for own electricity, whose 2014 and 2015 are not used) is left empty,
        * and the package then posts no covariances (or stops). Then ask for fewer
        * placebos (years -2, -3, ...) until every one asked for is estimated;
        * the number used is in the CSV note, the notes and the regression table.
        local npl0 = `npl'
        local upd "_no_updates"
        local redo 1
        while `redo' {
            local redo 0
            capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off `upd'
            local rc = _rc
            if `rc' == 198 & "`upd'" == "_no_updates" {
                local upd "no_updates"                  // older versions spell the switch-off this way
                local redo 1
                continue
            }
            if `rc' == 198 | `npl' == 0 continue
            if `rc' {                                   // stopped without results: one placebo fewer
                local --npl
                local redo 1
                continue
            }
            local first0 0                              // first placebo left empty
            forvalues l = 1/`npl' {
                if `first0' == 0 & missing(e(Placebo_`l')) local first0 `l'
            }
            if `first0' > 0 {
                local npl = `first0' - 1
                local redo 1
            }
        }
        local pltxt = cond(`npl' < `npl0', "; only years -2 to `=-1-`npl'' (year `=-2-`npl'' has no starter with the rows it needs)", "")
        local dpl`o' = `npl'                            // placebos used (for the notes and tables)
        if `rc' == 198 {
            post `h' (`o') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: this did_multiplegt_dyn version cannot switch off its self-update") ("update it once: ssc install did_multiplegt_dyn, replace") (.)
        }
        else if `rc' {
            post `h' (`o') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_multiplegt_dyn stopped with error r(`rc')") ("") (.)
        }
        else {
            local st = e(N_switchers_effect_1)
            local rw = e(N_effect_1)
            local p_dcdh = e(p_jointplacebo)
            forvalues l = 1/`ne' {
                post `h' (`o') (5) ("dcdh") ("event") (`l' - 1) (e(Effect_`l')) (e(se_effect_`l')) (.) (e(N_switchers_effect_`l')) (.) (e(N_effect_`l')) ("ok") ("Effect_`l' (package name) = year `=`l'-1' since the start") (.)
            }
            forvalues l = 1/`npl' {
                post `h' (`o') (5) ("dcdh") ("event") (-1 - `l') (e(Placebo_`l')) (e(se_placebo_`l')) (.) (e(N_switchers_placebo_`l')) (.) (e(N_placebo_`l')) ("ok") ("Placebo_`l' (package name) = year `=-1-`l'' vs the year before the start") (.)
            }
            post `h' (`o') (5) ("dcdh") ("own_overall") (.) (e(Av_tot_effect)) (e(se_avg_total_effect)) (.) (.) (.) (e(N_avg_total_effect)) ("ok") ("average total effect: all its effects, weighted by starters behind each") (.)
            post `h' (`o') (5) ("dcdh") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of its placebos (years -2 to `=-1-`npl''`pltxt'); p in column p") (`p_dcdh')
            local lcd "Effect_1"
            forvalues l = 2/`ne' {
                local lcd "`lcd' + Effect_`l'"
            }
            capture quietly lincom (`lcd') / `ne'
            if !_rc post `h' (`o') (5) ("dcdh") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (.) (`rw') ("ok") ("years 0 to +`whi', each counts equally; starters and rows = those behind year 0") (.)
            else    post `h' (`o') (5) ("dcdh") ("avg") (.) (.) (.) (.) (`st') (.) (`rw') ("failed: no covariances in this package version") ("update: ssc install did_multiplegt_dyn, replace") (.)
        }
    }
    timer off 2
    quietly timer list 2
    display "   [`o'] five methods done (" %5.1f r(t2) " s so far)"
    timer on 2
}
postclose `h'
timer off 2


*---------------------------------------------------------------------------
display "Step 5/8: intervals, the numbers as drawn, cross-checks with R6-01, R6-03 and R6-04, and the CSV"
*---------------------------------------------------------------------------
use `est', clear
* 95% interval and p: t with the model's degrees of freedom where the package
* gives them (reghdfe-based rows), otherwise normal, as the package reports.
gen double crit = cond(missing(df), invnormal(0.975), invttail(df, 0.025))
gen double lo = b - crit * se
gen double hi = b + crit * se
gen double p  = cond(missing(df), 2 * normal(-abs(b / se)), 2 * ttail(df, abs(b / se)))
replace p = pin if inlist(row_type, "before_check", "before_all")
gen str6 ci_basis = cond(missing(se), "", cond(missing(df), "normal", "t"))
* The number as drawn: % change = 100 x (exp(b) - 1) for the log margins, and
* percentage points (b itself) for the two shares; interval ends converted the same way.
gen byte unit = .
forvalues o = 1/`nall' {
    replace unit = `u`o'' if outcome == `o'
}
assert !missing(unit)
gen str18 unit_label = cond(unit == 1, "% change", "percentage points")
gen double shown    = cond(unit == 1, 100 * (exp(b)  - 1), b)
gen double shown_lo = cond(unit == 1, 100 * (exp(lo) - 1), lo)
gen double shown_hi = cond(unit == 1, 100 * (exp(hi) - 1), hi)
* Parts = whole under every method: value added per tonne of CO2 = value added -
* energy used - CO2 per GJ (logs), average by average. Every method is linear in
* the outcome and the four margins use the same firm-years, so this must hold.
preserve
keep if row_type == "avg" & inlist(outcome, 1, 2, 3, 6) & !missing(b)
keep outcome morder b
reshape wide b, i(morder) j(outcome)
assert reldif(b6, b1 - b2 - b3) < 1e-6 if !missing(b1, b2, b3, b6)
quietly count if !missing(b1, b2, b3, b6)
display "   value added per tonne of CO2 = (1) - (2) - (3) under all " r(N) " methods and versions (averages, logs)"
restore
gen str60 outcome_label = ""
gen str60 outcome_def   = ""
gen str20 source        = ""
forvalues o = 1/`nall' {
    replace outcome_label = "`n`o''"   if outcome == `o'
    replace source        = "`src`o''" if outcome == `o'
}
replace outcome_def = "ln(value_added_nominal)"                          if outcome == 1
replace outcome_def = "ln(total_gj_s1)"                                  if outcome == 2
replace outcome_def = "ln(co2_total_s1 / total_gj_s1)"                   if outcome == 3
replace outcome_def = "100 x gj_electricity / total_gj_s1"               if outcome == 4
replace outcome_def = "100 x (elec_owngen_kwh > 0), recorded rows, years passing the 75% rule" if outcome == 5
replace outcome_def = "ln(value_added_nominal / co2_total_s1) = (1) - (2) - (3)" if outcome == 6
gen str90 method_label = ""
replace method_label = "One regression, all start years together (R6-01's model, reghdfe)"            if method == "twfe"
replace method_label = "Callaway-Sant'Anna (csdid): each start year vs never-exporters"                 if method == "cs"
replace method_label = "Sun-Abraham (eventstudyinteract): R6-01's markers, start years kept apart"      if method == "sa"
replace method_label = "Borusyak-Jaravel-Spiess (did_imputation): predicted path without the start"     if method == "bjs"
replace method_label = "de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn): change from the year before" if method == "dcdh"
replace method_label = "One regression without doubtful energy records (table only)"                   if method == "twfe_nd"
replace method_label = "One regression, only starters seen not exporting the year before (table only)" if method == "twfe_ex"
gen str70 row_label = ""
replace row_label = "Average of years 0 to +`whi', each year counts equally"      if row_type == "avg"
replace row_label = "The method's own overall number (all years after the start)" if row_type == "own_overall"
replace row_label = "One year since the start"                                  if row_type == "event"
replace row_label = "Before-start check (p only)"                               if row_type == "before_check"
replace row_label = "Before-start check, all years before the start (p only)"   if row_type == "before_all"
* The margin's support, repeated on each of its rows: every firm-year of the
* compared firms, the firm-years each rule leaves out, the firms with one row
* (dropped by the single regression), the fewest starters behind a single year.
gen long firmrows_all = `n_firmrows'
gen long left_no_energy = `n_zero'
gen long left_notrec = cond(outcome == 5, `n_notrec', 0)
gen long left_thin   = cond(outcome == 5, `n_thin', 0)
gen long margin_rows = .
gen long left_one_row = .
gen long fewest_starters = .
gen int  fewest_at = .
gen str20 sa_left_years = ""
gen long sa_left_starters = .
gen byte dcdh_placebos = .
forvalues o = 1/`nall' {
    replace margin_rows = `nrow`o'' if outcome == `o'
    foreach s in 1 6 7 {
        replace left_one_row    = `sg`o'_`s'' if outcome == `o' & morder == `s'
        replace fewest_starters = `fw`o'_`s'' if outcome == `o' & morder == `s'
        replace fewest_at       = `fk`o'_`s'' if outcome == `o' & morder == `s'
    }
    replace sa_left_years    = "`sa_yrs`o''" if outcome == `o' & method == "sa"
    replace sa_left_starters = `sa_out`o''   if outcome == `o' & method == "sa"
    replace dcdh_placebos    = `dpl`o''      if outcome == `o' & method == "dcdh"
}
* Every firm-year is accounted for: all = used by the margin + left out by its rules;
* the single regression uses the margin's rows minus those of firms with one row.
assert firmrows_all == margin_rows + left_no_energy + left_notrec + left_thin
assert rows == margin_rows - left_one_row if method == "twfe" & row_type == "avg"
gen int window_first = `wlo'
gen int window_last  = `whi'
* ---- Cross-checks with the reviewed R6 tables (when present in tables/): each
* margin's single regression, main version and the two table-only versions,
* must equal its reviewed file's (year by year, average, before-start p, rows).
* R6-01's version names: main, nodoubt, exact. Stop on any mismatch. ----
gen str60 r6_check = ""
foreach spec in "01_margins_export_start|3|1" "01_margins_export_start|4|2" "01_margins_export_start|5|3" ///
                "01_margins_export_start|1|6" "03_energy_mix_shares|1|4" "04_own_electricity|1|5" {
    gettoken tf rest : spec, parse("|")
    gettoken bar rest : rest, parse("|")
    gettoken ro rest : rest, parse("|")
    gettoken bar mo : rest, parse("|")
    capture confirm file "tables/`tf'.csv"
    if _rc {
        display "   tables/`tf'.csv not found: cross-check of (`mo') skipped"
        continue
    }
    preserve
    import delimited using "tables/`tf'.csv", clear varnames(1)
    keep if outcome == `ro' & inlist(version, "main", "nodoubt", "exact")
    gen str8 method = cond(version == "main", "twfe", cond(version == "nodoubt", "twfe_nd", "twfe_ex"))
    keep if reference == 0 & !missing(b)
    keep method event_time b avg_after_b before_p n_rows
    rename (b avg_after_b before_p n_rows) (f_b f_avg f_bp f_n)
    tempfile fig
    save `fig'
    restore, preserve
    keep if outcome == `mo' & inlist(method, "twfe", "twfe_nd", "twfe_ex")
    bysort method: egen double m_avg = max(cond(row_type == "avg", b, .))
    bysort method: egen double m_bp  = max(cond(row_type == "before_check", p, .))
    bysort method: egen double m_n   = max(cond(row_type == "avg", rows, .))
    keep if row_type == "event"
    keep method event_time b m_avg m_bp m_n
    quietly merge 1:1 method event_time using `fig'
    quietly count if _merge != 3 | abs(b - f_b) > 0.00005 + 1e-9 | abs(m_avg - f_avg) > 0.00005 + 1e-9 ///
        | abs(m_bp - f_bp) > 0.0005 + 1e-9 | m_n != f_n
    if r(N) > 0 {
        display as error "tables/`tf'.csv (its outcome `ro') does not match this file's margin (`mo'): the margins no longer equal the reviewed files."
        exit 459
    }
    quietly count
    display "   tables/`tf'.csv, its outcome `ro' = margin (`mo'): all " r(N) " year coefficients, averages, before-start p and rows reproduced (3 versions)"
    restore
    replace r6_check = "`tf'.csv outcome `ro' (main, nodoubt, exact)" if outcome == `mo' & inlist(method, "twfe", "twfe_nd", "twfe_ex")
}
gen byte rorder = 1*(row_type == "avg") + 2*(row_type == "own_overall") + 3*(row_type == "before_check") ///
    + 4*(row_type == "before_all") + 6*(row_type == "event")
sort outcome morder rorder event_time
rename morder method_order
order outcome outcome_label outcome_def unit_label source method_order method method_label row_type row_label ///
      event_time b se lo hi p shown shown_lo shown_hi ci_basis starters comp_firms rows ///
      margin_rows firmrows_all left_no_energy left_notrec left_thin left_one_row fewest_starters fewest_at ///
      sa_left_years sa_left_starters dcdh_placebos window_first window_last r6_check status note
drop rorder crit pin df unit
format b se lo hi %9.4f
format shown shown_lo shown_hi %9.2f
format p %9.3f
format starters comp_firms rows margin_rows firmrows_all left_no_energy left_notrec left_thin left_one_row ///
    fewest_starters sa_left_starters %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile full                      // same numbers, full precision, for the chart and the companion tables
quietly save `full'
set linesize 200
list outcome method shown shown_lo shown_hi p starters comp_firms rows status if row_type == "avg", ///
    noobs sepby(outcome) abbreviate(24) clean
set linesize 120

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the rows and notes (read from the table, never typed)"
*---------------------------------------------------------------------------
local nb = uchar(160)                                   // no-break space: "p < 0.001" stays on one line
local mname1 "one regression"
local mname2 "Callaway–Sant'Anna"
local mname3 "Sun–Abraham"
local mname4 "Borusyak–Jaravel–Spiess"
local mname5 "de Chaisemartin–D'Haultfœuille"
gen byte ok = status == "ok" & !missing(b)
gen byte clear = ok & (lo > 0 | hi < 0)                 // interval does not cross 0
* Decimals as drawn: shares always 1; % changes whole, or 1 decimal for a margin
* whose averages are all small (so no "-0%").
forvalues o = 1/`nmeas' {
    quietly summarize shown if outcome == `o' & row_type == "avg" & method_order <= 5 & ok
    local dec`o' = cond(`u`o'' == 2 | max(abs(r(min)), abs(r(max))) < 5, 1, 0)
    local suf`o' = cond(`u`o'' == 1, "%", " points")
}
* a number as drawn, with its sign: program r606_fmt value decimals suffix
capture program drop r606_fmt
program define r606_fmt, rclass
    args v d suf
    local r = round(`v', 10^(-`d'))
    return local s = cond(`r' > 0, "+", "") + string(`r', "%9.`d'f") + "`suf'"
end
* (a) the single regression's answer per margin (= R6-01, R6-03, R6-04)
local headtxt ""
local nclr 0
local clrlist ""
forvalues o = 1/`nmeas' {
    quietly summarize shown if outcome == `o' & method == "twfe" & row_type == "avg"
    r606_fmt `r(mean)' `dec`o'' "`suf`o''"
    local tw`o' "`r(s)'"
    quietly summarize clear if outcome == `o' & method == "twfe" & row_type == "avg"
    local twc`o' = r(mean)
    if `twc`o'' {
        local ++nclr
        local clrlist = "`clrlist'" + cond(`nclr' > 1, " and ", "") + "`w`o''"
    }
    local sep = cond(`o' == 1, "", cond(`o' == `nmeas', " and ", ", "))
    local headtxt "`headtxt'`sep'`w`o'' `tw`o''"
}
local headtxt "One regression (as in R6-01, R6-03, R6-04): `headtxt'"
local headtxt = "`headtxt'; " + cond(`nclr' == 0, "none is clearly different from 0.", "clearly different from 0: `clrlist'.")
* (b) the five methods: each margin's range and in how many it is clear
local rngtxt ""
forvalues o = 1/`nmeas' {
    quietly summarize shown if outcome == `o' & row_type == "avg" & method_order <= 5 & ok
    local nav = r(N)
    r606_fmt `r(min)' `dec`o'' "`=cond(`u`o'' == 1, "%", "")'"
    local smin "`r(s)'"
    quietly summarize shown if outcome == `o' & row_type == "avg" & method_order <= 5 & ok
    r606_fmt `r(max)' `dec`o'' "`suf`o''"
    local smax "`r(s)'"
    quietly count if outcome == `o' & row_type == "avg" & method_order <= 5 & clear
    local nc = r(N)
    local ctx = cond(`nc' == 0, "never clear", cond(`nc' == `nav', "clear in all `nav'", "clear in `nc' of `nav'"))
    * clear in some methods only: name them, with their own before-start p
    if `nc' > 0 & `nc' < `nav' {
        local ctx ""
        forvalues m = 1/5 {
            quietly count if outcome == `o' & method_order == `m' & row_type == "avg" & clear
            if r(N) == 0 continue
            quietly summarize p if outcome == `o' & method_order == `m' & row_type == "before_check"
            local pq = cond(r(mean) < 0.001, "p`nb'<`nb'0.001", "p`nb'=`nb'" + string(r(mean), "%5.3f"))
            local ctx = "`ctx'" + cond("`ctx'" != "", ", ", "") + "`mname`m'' (before the start `pq')"
        }
        local ctx "clear only in `ctx'"
    }
    local sep = cond(`o' == 1, "", "; ")
    local rngtxt "`rngtxt'`sep'`w`o'' `smin' to `smax' (`ctx')"
}
local rngtxt "Across the five methods: `rngtxt'."
* (c) before-start checks: each method's own check, per margin (p below 0.05 = fails)
local bftxt ""
local nbf 0
forvalues o = 1/`nmeas' {
    local lst ""
    local nf 0
    forvalues m = 1/5 {
        quietly summarize p if outcome == `o' & method_order == `m' & row_type == "before_check"
        if r(N) > 0 & r(mean) < 0.05 {
            local ++nf
            local lst = "`lst'" + cond(`nf' > 1, ", ", "") + "`mname`m''"
        }
    }
    if `nf' > 0 {
        local ++nbf
        local bf`nbf' "`w`o'' (`lst')"
    }
}
local bftxt ""
forvalues j = 1/`nbf' {
    local sep = cond(`j' == 1, "", cond(`j' == `nbf', " and ", "; "))
    local bftxt "`bftxt'`sep'`bf`j''"
}
if `nbf' == 0 local bftxt "Before the start, no method's own check fails for any row (p below 0.05 would be a warning)."
else local bftxt "Before the start, the method's own check (p below 0.05 = starters already differed) fails for `bftxt'."
* Callaway-Sant'Anna over all years before the start, and exact starters (table)
local cslist ""
local ncs 0
local exlist ""
local nex 0
forvalues o = 1/`nmeas' {
    quietly summarize p if outcome == `o' & method == "cs" & row_type == "before_all"
    if r(N) > 0 & r(mean) < 0.05 {
        local ++ncs
        local cs`ncs' "`w`o''"
    }
    quietly summarize p if outcome == `o' & method == "twfe_ex" & row_type == "before_check"
    if r(N) > 0 & r(mean) < 0.05 {
        local ++nex
        local ex`nex' "`w`o''"
    }
}
foreach g in cs ex {
    local `g'list ""
    forvalues j = 1/`n`g'' {
        local sep = cond(`j' == 1, "", cond(`j' == `n`g'', " and ", ", "))
        local `g'list "``g'list'`sep'``g'`j''"
    }
}
local cstxt = cond(`ncs' == 0, "no margin", "`cslist'")
local extxt = cond(`nex' == 0, "no margin", "`exlist'")
local bf2txt "Over all years before the start (Callaway–Sant'Anna, gray line) it fails for `cstxt'; with only starters seen not exporting the year before (table) for `extxt'."
local bf2short "Callaway–Sant'Anna's check over all years before the start (gray) fails for `ncs' of `nmeas' blocks."
* (d) single years: those whose interval excludes 0 in the single regression, each
* with the number of the five methods in which the same year is clear.
local ndots 0
local nsyc 0
local nsyb 0                                            // of them: years before the start
local sytxt ""
forvalues o = 1/`nmeas' {
    quietly count if outcome == `o' & method == "twfe" & row_type == "event" & !missing(b)
    local ndots = `ndots' + r(N)
    quietly levelsof event_time if outcome == `o' & method == "twfe" & row_type == "event" & clear, local(ks)
    local part ""
    local nk 0
    foreach k of local ks {
        local ++nk
        if `k' < 0 local ++nsyb
        quietly summarize shown if outcome == `o' & method == "twfe" & row_type == "event" & event_time == `k'
        r606_fmt `r(mean)' `=cond(`u`o'' == 2, 1, 0)' "`suf`o''"
        local pv "`r(s)'"
        quietly count if outcome == `o' & method_order <= 5 & row_type == "event" & event_time == `k' & clear
        local nmc = r(N)
        local kl = cond(`k' > 0, "+", "") + string(`k')
        if `k' < `wlo' local kl "≤`nb'`kl'"
        if `k' > `whi' local kl "≥`nb'`kl'"
        local part = "`part'" + cond(`nk' > 1, ", ", "") + "`kl' (`pv', `nmc' of 5)"
    }
    if `nk' > 0 local sytxt = "`sytxt'" + cond("`sytxt'" != "", "; ", "") + "`w`o'' `part'"
    local nsyc = `nsyc' + `nk'
}
if "`sytxt'" == "" local sytxt "No single year's interval excludes 0 in the single regression."
else local sytxt "Single years clear in the one regression (table; in how many of the 5 methods that year is clear): `sytxt'. Negative years are before the start: a warning, not a result. Of `ndots' years about `=round(0.05*`ndots')' would be clear by chance, so read the averages."
local sy_short "Single years (not drawn; table notes): `nsyc' of `ndots' clear in the one regression (`nsyb' of them before the start), about `=round(0.05*`ndots')' expected by chance."
* (e) start years each method leaves out (Sun-Abraham: no row the year before)
local g1 : word 1 of `gapyr'
local sa_main = subinstr("`sa_yrs1'", " ", " and ", .)
local satxt ""
local extra5 : list sa_yrs5 - sa_yrs1
local extra5 = subinstr(strtrim("`extra5'"), " ", " and ", .)
if "`g1'" != "" {
    local satxt "Callaway–Sant'Anna, Sun–Abraham and de Chaisemartin–D'Haultfœuille leave out firms that started in `=`g1'+1' (no `gapyr' file)"
    if "`extra5'" != "" local satxt "`satxt' and, in (5), in `extra5' (the year before is not used there)"
    local satxt "`satxt'."
}
* the years dCDH's check covers in (5), in words ("-2 and -3", or "-2 to -4")
local dyr5 = cond(`dpl5' == 1, "-2", cond(`dpl5' == 2, "-2 and -3", "-2 to `=-1-`dpl5''"))
if `dpl5' < -`wlo' - 1 local satxt "`satxt' De Chaisemartin–D'Haultfœuille's check in (5) covers years `dyr5' only (gray line)."
* (f) the firm-years behind each margin (gray line under each name)
local n5r = string(`nrow5', "%9.0fc")
local rowtxt "Each block uses its own firm-years (gray line under its name); all use firm-years with energy, CO2 and value added"
local rowtxt "`rowtxt' above 0 (`=string(`n_zero', "%9.0fc")' of these firms' firm-years record no energy)."
quietly summarize starters if outcome == 1 & method == "twfe" & row_type == "avg"
local nst = string(r(mean), "%9.0fc")
quietly summarize comp_firms if outcome == 1 & method == "twfe" & row_type == "avg"
local ncf = string(r(mean), "%9.0fc")
display "   `headtxt'"
display "   `rngtxt'"
display "   `bftxt'"
display "   `bf2txt'"
display "   `sytxt'"
display "   `satxt'"
display "   `rowtxt'"
* Per margin: the gray line under its name.
forvalues o = 1/`nmeas' {
    quietly summarize rows if outcome == `o' & method == "twfe" & row_type == "avg"
    local rw = string(r(mean), "%9.0fc")
    local fk = `fk`o'_1'
    local fkl = cond(`fk' > 0, "+", "") + string(`fk')
    local gl`o' "`rw' firm-years in the one regression (= `src`o''); fewest starters in a single year: `fw`o'_1' (year `fkl')"
}

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart: one block per margin, one row per method"
*---------------------------------------------------------------------------
* Notes as one text, wrapped by printed width (R6-01's rule; widths in em).
local mtxt "Rows 2 to 5 are the previous paper's four methods, named after their authors; they differ only in how they combine firms"
local mtxt "`mtxt' that start in different years (the one regression can mix them)."
local mtxt_t "`mtxt' Callaway–Sant'Anna, Sun–Abraham and de Chaisemartin–D'Haultfœuille compare each start year only with never-exporters;"
local mtxt_t "`mtxt_t' Borusyak–Jaravel–Spiess also uses later starters' years before their start."
local nsta = string(`nst_any', "%9.0fc")
local tail "Starters: first seen exporting after a year seen not exporting (`nsta' in (1), as in R6-01; the Starters column counts those with"
local tail "`tail' a row from the start year on; still starters if they stop); never-exporters:"
local tail "`tail' never seen exporting (`ncf'). Dot = change since the year before the start, averaged over years 0 to +`whi'; bar = 95%"
local tail "`tail' interval (crossing 0 = not clear). (5) uses only firm-years with own electricity recorded, without `badtxt' (recorded"
local tail "`tail' for too few firms, as R6-04). Value added = output minus materials, energy and services bought (current prices);"
local tail "`tail' GJ = gigajoules; CO2 = energy x standard rates, not measured. Shows timing, not cause; firm links are fictional:"
local tail "`tail' this tests the method, not a finding."
* The chart: the answer across methods first, then how to read the rows, the
* checks, and the definitions. The points table's notes add the single-regression
* sentence, the exact-starter check and every clear single year.
local txt   "Notes: `rngtxt' `mtxt' `satxt' `bftxt' `bf2short' `sy_short' `tail'"
local txt_t "Notes: `headtxt' `rngtxt' `mtxt_t' `satxt' `bftxt' `bf2txt' `sytxt' `rowtxt' `tail'"
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
* The before-start column and Callaway-Sant'Anna's all-years line, per margin.
foreach o of numlist 1/`nmeas' {
    forvalues m = 1/5 {
        quietly summarize p if outcome == `o' & method_order == `m' & row_type == "before_check"
        local bp`o'_`m' = cond(r(N) > 0, r(mean), .)
    }
    quietly summarize p if outcome == `o' & method == "cs" & row_type == "before_all"
    local bpall`o' = cond(r(N) > 0, r(mean), .)
}
keep if row_type == "avg" & method_order <= 5 & outcome <= `nmeas'
gen byte pnl = cond(unit_label == "% change", 1, 2)
* Vertical layout (y units): block header at yh, its gray line 0.6 below, the five
* method rows (a little more room under row 2 for its gray second line), then the
* block's axis labels. A little more room between the % blocks and the points blocks.
gen double yh = 48 - 8.1 * (outcome - 1) - 0.8 * (pnl == 2)
gen double ypos = yh - 1.55 - 1.0 * (method_order - 1) - 0.55 * (method_order >= 3)
gen double ysub = ypos - 0.55                           // gray second line under a row
* x-axis per unit: a round step (1, 2 or 5 times a power of 10); 0 always inside;
* at most 5 steps (R2-10's rule, one fewer: the axis is narrow). The points blocks are drawn in the % blocks'
* horizontal units, with their own labels (R6-03's way), so the columns line up.
forvalues q = 1/2 {
    quietly summarize shown_lo if ok & pnl == `q'
    local xmin = min(r(min), 0)
    quietly summarize shown_hi if ok & pnl == `q'
    local xmax = max(r(max), 0)
    local rng = `xmax' - `xmin'
    local step = 10^floor(log10(`rng'))
    if `rng'/`step' < 2       local step = `step'/5
    else if `rng'/`step' < 5  local step = `step'/2
    local xbot = `step' * floor(`xmin'/`step')
    local xtop = `step' * ceil(`xmax'/`step')
    while (`xtop' - `xbot')/`step' > 5 {
        local mant = round(`step' / 10^floor(log10(`step')))    // 1, 2 or 5
        local step = cond(`mant' == 2, 2.5, 2) * `step'         // 1 -> 2 -> 5 -> 10 ...
        local xbot = `step' * floor(`xmin'/`step')
        local xtop = `step' * ceil(`xmax'/`step')
    }
    local xbot`q' = `xbot'
    local xtop`q' = `xtop'
    local step`q' = `step'
    local xfmt`q' = cond(`step' >= 1, "%9.0f", "%9.1f")
}
local span = `xtop1' - `xbot1'
local k2 = `span' / (`xtop2' - `xbot2')                 // points units -> % units
foreach v in shown shown_lo shown_hi {
    gen double px_`v' = cond(pnl == 1, `v', `xbot1' + (`v' - `xbot2') * `k2')
}
local x0_2 = `xbot1' + (0 - `xbot2') * `k2'             // the zero line of the points blocks
* Left to right (x-axis units): row names, the dots, then two columns: starters,
* and the before-start check (placed clear of the value labels).
local xn  = `xbot1' - 1.15 * `span'
quietly summarize px_shown_hi if ok
local xc1 = max(`xtop1' + 0.27 * `span', r(max) + 0.40 * `span')
local xc2 = `xc1' + 0.07 * `span'
local xr  = `xc1' + 0.55 * `span'
* Gridlines, zero lines and axis labels, drawn inside each block.
local grid ""
local zero ""
local tx ""
forvalues o = 1/`nmeas' {
    quietly summarize yh if outcome == `o', meanonly
    local yt = r(mean) - 1.3
    local yb = r(mean) - 6.55
    local yl = r(mean) - 7.0
    local q = cond(`u`o'' == 1, 1, 2)
    local nt = round((`xtop`q'' - `xbot`q'') / `step`q'')
    forvalues j = 0/`nt' {
        local v  = `xbot`q'' + `j' * `step`q''
        local xv = cond(`q' == 1, `v', `xbot1' + (`v' - `xbot2') * `k2')
        if abs(`v') > 1e-9 local grid `grid' `yt' `xv' `yb' `xv'
        local lab = cond(`v' > 1e-9, "+", "") + strtrim(string(`v', "`xfmt`q''")) + cond(`q' == 1 & abs(`v') > 1e-9, "%", "")
        local tx `tx' text(`yl' `xv' "`lab'", size(vsmall) placement(c) color(gs6))
    }
    local x0 = cond(`q' == 1, 0, `x0_2')
    local zero `zero' `yt' `x0' `yb' `x0'
}
* Columns: starters behind each average; before-start check (p below 0.05 =
* starters were already changing differently: "differs").
gen str12 c1 = string(starters, "%9.0fc") if ok
gen str40 c2 = ""
gen str40 c2b = ""
forvalues o = 1/`nmeas' {
    forvalues m = 1/5 {
        local q = `bp`o'_`m''
        if missing(`q') continue
        local qs = cond(`q' < 0.001, "<`nb'0.001", string(`q', "%5.3f"))
        if `q' < 0.05 local qs "`qs', differs"
        replace c2 = "`qs'" if outcome == `o' & method_order == `m' & ok
    }
    if !missing(`bpall`o'') {
        local qs = cond(`bpall`o'' < 0.001, "<`nb'0.001", string(`bpall`o'', "%5.3f"))
        if `bpall`o'' < 0.05 local qs "`qs', differs"
        replace c2b = "all years: `qs'" if outcome == `o' & method == "cs" & ok
    }
    * de Chaisemartin-D'Haultfoeuille's check on fewer years (own electricity): said beside its p
    if `dpl`o'' < -`wlo' - 1 {
        local dy = cond(`dpl`o'' == 1, "-2", cond(`dpl`o'' == 2, "-2 and -3", "-2 to `=-1-`dpl`o'''"))
        replace c2b = "years `dy' only" if outcome == `o' & method == "dcdh" & ok
    }
}
gen str90 nolbl = status if !ok
gen double xc1 = `xc1'
gen double xc2 = `xc2'
gen double xnm = `xn'
gen double xnr = cond(pnl == 1, `xbot1', `xbot1')
* Each average is written just right of its interval (or of the zero line when the
* interval ends left of it), with the margin's decimals.
gen double px_lbl = max(px_shown_hi, cond(pnl == 1, 0, `x0_2'))
gen str12 lbl = ""
forvalues o = 1/`nmeas' {
    replace lbl = cond(round(shown, 10^(-`dec`o'')) > 0, "+", "") + string(round(shown, 10^(-`dec`o'')), "%9.`dec`o''f") ///
        + cond(`u`o'' == 1, "%", "") if outcome == `o' & ok
}
* Row names and block headers (left-aligned text).
gen str60 nm = ""
forvalues m = 1/5 {
    replace nm = cond(`m' == 1, "One regression (R6-01's model)", "`mname`m''") if method_order == `m'
}
gen str120 ph = ""
gen str160 ps = ""
forvalues o = 1/`nmeas' {
    replace ph = "`n`o'', " + cond(`u`o'' == 1, "% change", "change in percentage points") if outcome == `o' & method_order == 1
    replace ps = "`gl`o''" if outcome == `o' & method_order == 1
}
gen double yph = yh
gen double yps = yh - 0.75
local yhd = 49.2                                        // column headers
twoway (pci `grid', lcolor(gs14) lwidth(vthin)) ///
    (pci `zero', lcolor(gs8) lwidth(thin)) ///
    (rspike px_shown_hi px_shown_lo ypos if ok, horizontal lcolor(black) lwidth(thin)) ///
    (scatter ypos px_shown if ok, msymbol(O) msize(small) mcolor(black)) ///
    (scatter ypos px_lbl if ok, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnm, msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc1 if ok, msymbol(none) mlabel(c1) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc2 if ok, msymbol(none) mlabel(c2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xc2 if c2b != "", msymbol(none) mlabel(c2b) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xnr if !ok, msymbol(none) mlabel(nolbl) mlabposition(3) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter yph xnm if ph != "", msymbol(none) mlabel(ph) mlabposition(3) mlabgap(0) mlabsize(small) mlabcolor(black)) ///
    (scatter yps xnm if ps != "", msymbol(none) mlabel(ps) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    text(`yhd' `xn' "Change and method", size(vsmall) placement(e)) ///
    text(`yhd' `xc1' "Starters", size(vsmall) placement(w)) ///
    text(`yhd' `xc2' "Before the start, p", size(vsmall) placement(e)) ///
    `tx' ///
    yscale(range(7.2 49.6) off) ylabel(none) ytitle("") ///
    xscale(range(`xn' `xr') off) xlabel(, nogrid) xtitle("") ///
    legend(order(4 "Average of years 0 to +`whi' (each year counts equally)" 3 "95% interval" 2 "0 = no difference") ///
        cols(3) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. `ftitle'", size(medium) position(11) justification(left) span) ///
    subtitle("Starters minus never-exporters, average of years 0 to +`whi' after the start, by method", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none) margin(zero)) ///
    xsize(9) ysize(15) scale(`=7.5/10')

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

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
* (1) Points table: the chart's rows top to bottom (each margin, then its five
* methods), then the table-only margin (not drawn). A method that did not run
* keeps its row.
local dec6 1                                            // table-only margin: one decimal
local suf6 "%"
use `full', clear
* the before-start p of every method and margin, before keeping the dot rows
forvalues o = 1/`nall' {
    forvalues m = 1/5 {
        quietly summarize p if outcome == `o' & method_order == `m' & row_type == "before_check"
        local q`o'_`m' = cond(r(N) > 0, r(mean), .)
        quietly summarize p if outcome == `o' & method_order == `m' & row_type == "before_all"
        local qa`o'_`m' = cond(r(N) > 0, r(mean), .)
    }
}
keep if row_type == "avg" & method_order <= 5
sort outcome method_order
local npts = _N
gen byte ok = status == "ok" & !missing(b)
gen str60 t_blk = outcome_label
gen str40 t_m = ""
forvalues m = 1/5 {
    replace t_m = cond(`m' == 1, "One regression (R6-01's model)", "`mname`m''") if method_order == `m'
}
* the average as the chart label (its decimals; "%" for the log margins) and its
* interval with the same decimals
gen str16 t_v  = ""
gen str16 t_lo = ""
gen str16 t_hi = ""
forvalues o = 1/`nall' {
    local d = `dec`o''
    foreach c in v lo hi {
        local s = cond("`c'" == "v", "shown", "shown_`c'")
        replace t_`c' = cond(round(`s', 10^(-`d')) > 0, "+", "") + string(round(`s', 10^(-`d')), "%9.`d'f") if outcome == `o' & ok
    }
    if `u`o'' == 1 replace t_v = t_v + "%" if outcome == `o' & ok
}
gen str12 t_u  = cond(unit_label == "% change", "%", "points")
gen str12 t_st = string(starters, "%12.0fc") if ok & !missing(starters)
gen str12 t_cf = string(comp_firms, "%12.0fc") if ok & !missing(comp_firms)
replace t_cf = "—" if ok & missing(comp_firms)                // the package does not report it (as in the regression table)
gen str12 t_r  = string(rows, "%12.0fc") if ok & !missing(rows)
* the chart's "Before the start, p" column as printed there (Callaway-Sant'Anna's
* gray second line, all years before the start: in the table notes)
gen str60 t_p = ""
local csall ""
forvalues o = 1/`nall' {
    forvalues m = 1/5 {
        local q = `q`o'_`m''
        local qa = `qa`o'_`m''
        if missing(`q') continue
        local qs = cond(`q' < 0.001, "< 0.001", string(`q', "%5.3f"))
        if `q' < 0.05 local qs "`qs', differs"
        if !missing(`qa') {
            local qas = cond(`qa' < 0.001, "< 0.001", string(`qa', "%5.3f"))
            if `qa' < 0.05 local qas "`qas', differs"
            local ol = cond(`o' <= `nmeas', "(`o')", "value added per tonne of CO2")
            local csall = "`csall'" + cond("`csall'" == "", "", "; ") + "`ol' `qas'"
        }
        replace t_p = "`qs'" if outcome == `o' & method_order == `m' & ok
    }
}
gen str60 t_status = ""
replace t_status = "drawn" if ok & outcome <= `nmeas'
replace t_status = "table only" if ok & outcome > `nmeas'
replace t_status = "not drawn: " + status if !ok
quietly count if ok & outcome <= `nmeas'
local ndrawn = r(N)
quietly count if t_status == "drawn"
assert r(N) == `ndrawn'
assert t_v != "" if ok
assert _N == `npts'
local rl ""
forvalues o = 1/`=`nall' - 1' {
    quietly count if outcome <= `o'
    local rl `rl' `r(N)'
}
local txt_t = itrim(`"`txt_t'"')                       // the chart notes + the single years, exact starters
local tnote "Table: every point of Figure `exhibit', top to bottom, then the table-only row (value added per tonne of CO2 = (1) − (2) − (3)"
local tnote "`tnote' in logs, exactly, in every method; not drawn)."
local tnote "`tnote' Change = the dot as labelled: % change = 100 × (exp(b) − 1) for the log changes, percentage points for (4) and (5)"
local tnote "`tnote' (interval in the same unit); b = the"
local tnote "`tnote' regression table's first row; rounded as the chart labels. Starters, never-exporters and firm-years = the method's"
local tnote "`tnote' estimation sample (de Chaisemartin–D'Haultfœuille: rows behind year 0). Callaway–Sant'Anna's gray second line on"
local tnote "`tnote' the chart (its check over all years before the start): `csall'. Full precision: tables/`fname'.csv."
order t_blk t_m t_v t_lo t_hi t_st t_cf t_r t_p t_status   // table column order (ctable_pdf needs it)
ctable_pdf t_blk t_m t_v t_lo t_hi t_st t_cf t_r t_p t_status using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Starters minus never-exporters, average of years 0 to +`whi' after the start, by method") ///
    header("Chart block" "Method (chart row)" "Change" "95%|interval|low" "95%|interval|high" "Starters" "Never-|exporters" "Firm-years" "Before the|start, p" "Status") ///
    right(3 4 5 6 7 8) norepeat(1) rules(`rl') fontsize(8.5) perpage(20) landscape /// two pages: (1)-(4), then (5), the table-only margin and the notes
    notes("`txt_t'" "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_table.pdf"

* (2) Regression table (AER style): one page per margin; columns = the chart's
* five method rows, then two table-only versions of the single regression.
* Rows: the average after the start (the dot), the method's own overall number,
* the before-start checks, the year-by-year path where the method gives one,
* then the sample and model rows. Coefficient on the first line, (standard
* error) on the second, from the full-precision numbers (never rounded twice).
use `full', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep outcome method row_type event_time b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 outcome method row_type event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
rename method_order col
tempname P
tempfile R
postfile `P' str70 t_lab str24(t1 t2 t3 t4 t5 t6 t7) using `R'
capture program drop r606_cell
program define r606_cell, rclass
    args o c cond dec
    quietly count if outcome == `o' & col == `c' & `cond' & !missing(b)
    if r(N) == 0 {
        return local b "—"
        return local s ""
        exit
    }
    quietly summarize b if outcome == `o' & col == `c' & `cond', meanonly
    return local b = string(r(mean), "%9.`dec'f")
    quietly summarize se if outcome == `o' & col == `c' & `cond', meanonly
    return local s = cond(missing(r(mean)), "", "(" + string(r(mean), "%9.`dec'f") + ")")
end
* short panel titles (the table's first column is kept narrow so seven columns fit)
local tn1 "(1) Value added"
local tn2 "(2) Energy used, GJ"
local tn3 "(3) CO2 per GJ of energy"
local tn4 "(4) Bought electricity share"
local tn5 "(5) Makes own electricity"
local tn6 "(6) Value added per tonne CO2"
local nr 0
local rl ""
local nb = uchar(160)
forvalues o = 1/`nall' {
    * 3 decimals for log points, 2 for percentage points
    local dd = cond(`u`o'' == 1, 3, 2)
    local ul = cond(`u`o'' == 1, "log points", "percentage points")
    post `P' ("`tn`o''") ("") ("") ("") ("") ("") ("") ("")
    local ++nr
    * the average after the start: b, (se), then as drawn and its 95% interval
    forvalues c = 1/7 {
        r606_cell `o' `c' `"row_type == "avg""' `dd'
        local b`c' "`r(b)'"
        local s`c' "`r(s)'"
        quietly count if outcome == `o' & col == `c' & row_type == "avg" & status != "ok"
        if r(N) > 0 local b`c' "not run"
        quietly summarize shown if outcome == `o' & col == `c' & row_type == "avg", meanonly
        local v`c' = cond(r(N) == 0, "—", cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f"))
        quietly summarize shown_lo if outcome == `o' & col == `c' & row_type == "avg", meanonly
        local l`c' = r(mean)
        quietly summarize shown_hi if outcome == `o' & col == `c' & row_type == "avg", meanonly
        local i`c' = cond(missing(`l`c''), "—", string(`l`c'', "%9.1f") + " to " + string(r(mean), "%9.1f"))
    }
    post `P' ("Average, years 0 to +`whi'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'")
    post `P' ("")                                  ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'")
    local wl = cond(`u`o'' == 1, "  as % change", "  as drawn (points)")
    post `P' ("`wl'")                              ("`v1'") ("`v2'") ("`v3'") ("`v4'") ("`v5'") ("`v6'") ("`v7'")
    post `P' ("  95% interval")                    ("`i1'") ("`i2'") ("`i3'") ("`i4'") ("`i5'") ("`i6'") ("`i7'")
    forvalues c = 1/7 {
        r606_cell `o' `c' `"row_type == "own_overall""' `dd'
        local b`c' "`r(b)'"
        local s`c' "`r(s)'"
    }
    post `P' ("Own overall number")                ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'")
    post `P' ("")                                  ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'")
    foreach rt in before_check before_all {
        forvalues c = 1/7 {
            quietly summarize p if outcome == `o' & col == `c' & row_type == "`rt'", meanonly
            local b`c' = cond(r(N) == 0, "—", cond(r(mean) < 0.001, "<`nb'0.001", string(r(mean), "%5.3f")))
        }
        local lab = cond("`rt'" == "before_check", "Before-start test, p", "  all years before, p")
        post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'")
    }
    local nr = `nr' + 8
    * year by year (not for the table-only margin: CSV; it is (1) - (2) - (3) there too)
    local klo = cond(`o' <= `nmeas', `wlo' - 1, 1)
    local khi = cond(`o' <= `nmeas', `whi' + 1, 0)
    forvalues k = `klo'/`khi' {
        local lab = cond(`k' > 0, "+", "") + string(`k')
        if `k' < `wlo' local lab "≤ `lab' (grouped)"
        if `k' > `whi' local lab "≥ `lab' (grouped)"
        forvalues c = 1/7 {
            r606_cell `o' `c' `"row_type == "event" & event_time == `k'"' `dd'
            local b`c' "`r(b)'"
            local s`c' "`r(s)'"
            if `k' == -1 & inlist(`c', 1, 3, 6, 7) local b`c' "0`nb'(reference)"
        }
        post `P' ("Year `lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'")
        local ++nr
        * standard errors under every estimate (at -1 too: Callaway-Sant'Anna and
        * Borusyak-Jaravel-Spiess estimate year -1; the others set it to 0)
        if "`s1'`s2'`s3'`s4'`s5'`s6'`s7'" != "" {
            post `P' ("") ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'")
            local ++nr
        }
    }
    * sample rows
    forvalues c = 1/7 {
        foreach v in starters comp_firms rows {
            quietly summarize `v' if outcome == `o' & col == `c' & row_type == "avg", meanonly
            local `v'`c' = cond(r(N) == 0, "—", string(r(mean), "%12.0fc"))
        }
        quietly summarize fewest_starters if outcome == `o' & col == `c' & row_type == "avg", meanonly
        local fw`c' = cond(r(N) == 0, "—", string(r(mean), "%12.0fc"))
        quietly summarize fewest_at if outcome == `o' & col == `c' & row_type == "avg", meanonly
        if r(N) > 0 local fw`c' = "`fw`c'' (" + cond(r(mean) > 0, "+", "") + string(r(mean)) + ")"
        quietly summarize left_one_row if outcome == `o' & col == `c' & row_type == "avg", meanonly
        local lo`c' = cond(r(N) == 0, "—", string(r(mean), "%12.0fc"))
        quietly levelsof ci_basis if outcome == `o' & col == `c' & row_type == "avg", local(cb) clean
        local ci`c' = cond("`cb'" == "t", "t", cond("`cb'" == "normal", "Normal", "—"))
    }
    quietly summarize margin_rows if outcome == `o', meanonly
    local mr = string(r(mean), "%12.0fc")
    quietly levelsof sa_left_years if outcome == `o' & col == 3 & row_type == "avg", local(say) clean
    quietly summarize sa_left_starters if outcome == `o' & col == 3 & row_type == "avg", meanonly
    local sa3 = cond(r(N) == 0, "—", cond("`say'" == "", "none", subinstr("`say'", " ", ", ", .) + " (" + string(r(mean), "%9.0fc") + ")"))
    post `P' ("Starters")                         ("`starters1'") ("`starters2'") ("`starters3'") ("`starters4'") ("`starters5'") ("`starters6'") ("`starters7'")
    post `P' ("Never-exporters")                  ("`comp_firms1'") ("`comp_firms2'") ("`comp_firms3'") ("`comp_firms4'") ("`comp_firms5'") ("`comp_firms6'") ("`comp_firms7'")
    post `P' ("Observations (firm-years)")        ("`rows1'") ("`rows2'") ("`rows3'") ("`rows4'") ("`rows5'") ("`rows6'") ("`rows7'")
    post `P' ("Fewest starters in a year") ("`fw1'") ("—") ("—") ("—") ("—") ("`fw6'") ("`fw7'")
    post `P' ("Block's firm-years") ("`mr'") ("") ("") ("") ("") ("") ("")
    post `P' ("  left out: no energy") ("`=string(`n_zero', "%12.0fc")'") ("") ("") ("") ("") ("") ("")
    local nr = `nr' + 6
    if `o' == 5 {
        post `P' ("  left out: not recorded") ("`=string(`n_notrec', "%12.0fc")'") ("") ("") ("") ("") ("") ("")
        post `P' ("  left out: `badtxt'") ("`=string(`n_thin', "%12.0fc")'") ("") ("") ("") ("") ("") ("")
        local nr = `nr' + 2
    }
    post `P' ("One-row firms' firm-years") ("`lo1'") ("—") ("—") ("—") ("—") ("`lo6'") ("`lo7'")
    post `P' ("Start years left out") ("—") ("—") ("`sa3'") ("—") ("—") ("—") ("—")
    post `P' ("Firm fixed effects")               ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes")
    post `P' ("Year fixed effects")               ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes") ("Yes")
    post `P' ("Industry × year effects")          ("No") ("No") ("No") ("No") ("No") ("No") ("No")
    post `P' ("Province × year effects")          ("No") ("No") ("No") ("No") ("No") ("No") ("No")
    post `P' ("Weights")                          ("None") ("None") ("None") ("None") ("None") ("None") ("None")
    post `P' ("Standard errors clustered by")     ("Firm") ("Firm") ("Firm") ("Firm") ("Firm") ("Firm") ("Firm")
    local nr = `nr' + 8
    local rl `rl' `nr'
}
postclose `P'
use `R', clear
local dpn ""
if `dpl5' < -`wlo' - 1 local dpn " In block (5), column 5's placebos cover years `dyr5' only (year `=-2-`dpl5'' has no starter with the rows it needs)."
local rnote "Notes: One page per block: the chart's blocks (1)-(5), then (6), value added per tonne of CO2 = (1) − (2) − (3), which"
local rnote "`rnote' holds exactly in every column (its year-by-year paths: CSV). Columns 1-5 = the chart's rows: the measure on markers of years"
local rnote "`rnote' since the export start (`wlo' to +`whi', ends grouped) with firm and year effects, starters (first year seen exporting after a year"
local rnote "`rnote' seen not exporting) against firms never seen exporting; columns 1, 4, 6, 7 also compare with later starters' years before"
local rnote "`rnote' their start. Column 6 = column 1 without doubtful energy records (importers of unknown export status in the years their"
local rnote "`rnote' energy records jump or drop); column 7 = column 1 with only starters seen not exporting the year just before. Every column"
local rnote "`rnote' starts from the block's firm-years (rows left out before: listed). Year-by-year paths use each package's own reference:"
local rnote "`rnote' columns 1, 3, 6, 7 vs the year before the start (-1 set to 0); column 2: years before the start = change from the year"
local rnote "`rnote' before, from 0 on vs the year before the start; column 4: years before = vs the firm's earlier years, from 0 on = vs its"
local rnote "`rnote' predicted path; column 5: Placebo_1.. and Effect_1.., renamed to years -2.. and 0.., vs the year before the start.`dpn'"
local rnote "`rnote' Before-start test: each method's own joint test. Callaway–Sant'Anna and de Chaisemartin–D'Haultfœuille leave out"
local rnote "`rnote' start years with no row the year before by construction; Sun–Abraham's are left out before the call (row above)."
local rnote "`rnote' 95% intervals: t in columns 1, 3, 6, 7; normal in 2, 4, 5, as each package reports. Log points to 3 decimals,"
local rnote "`rnote' percentage points to 2; standard errors in parentheses; — = the method does not give this number. No stars."
order t_lab t1 t2 t3 t4 t5 t6 t7
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 using "tables/`fname'_regression.pdf", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("Coefficient (standard error): log points in (1)-(3) and (6), percentage points in (4) and (5). Columns (1)-(5) = the chart's rows.") ///
    header("Estimate" "(1)|One|regression" "(2)|Callaway–|Sant'Anna" "(3)|Sun–|Abraham" "(4)|Borusyak–|Jaravel–|Spiess" "(5)|de Chaise-|martin–|D'Haultfœuille" "(6)|(1) without|doubtful|records" "(7)|(1), only|exact|starters") ///
    right(2 3 4 5 6 7 8) rules(`rl') fontsize(8) perpage(56) portrait /// one page per margin
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/`fname'_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
