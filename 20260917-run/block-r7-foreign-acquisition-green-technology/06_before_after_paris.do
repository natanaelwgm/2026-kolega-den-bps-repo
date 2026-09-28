/*==========================================================================
  R7-06  Did firms that got a foreign owner after the Paris Agreement cut
         their energy use per unit of value added more than firms that got
         one before it? One acquisition year at a time, each against firms
         never foreign-owned over the same calendar years; then the average
         of the acquisition years up to 2015 against the average of the
         later ones.
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" (we report our own numbers, not a comparison with the
         note's cited study).
  Output : figures/06_before_after_paris.png (+ .pdf)
           tables/06_before_after_paris.csv (energy per value added, CO2 per
           value added, energy used, value added; four versions; the years
           after against all years before AND against the earlier years before)
           tables/06_before_after_paris_table.pdf (every plotted point)
           tables/06_before_after_paris_regression.pdf (the regressions behind
           the chart, AER style)
  Needs  : Stata add-ons from SSC, installed once (the file never installs or
         updates anything): ssc install reghdfe, ssc install ftools,
         ssc install require.
  Model  : R2-06's design (06_efficiency_by_start_year.do in the R2 block): for
         each acquisition year, its acquirers and the firms never seen 10%+
         foreign-owned in the calendar years -K..+K around it, firm and year
         fixed effects, one "from the acquisition on" marker, standard errors
         clustered by firm; all acquisition years stacked (each with its own
         fixed effects) for averages weighted by acquirers used.
  Also   : the years from the acquisition on against the earlier years before
         only (-K..-2), because part of the fall in Figure R7-04 comes before
         the acquisition (review R7-04); drawn for the averages (gray squares).
         The same regression gives the year just before vs the earlier years
         (CSV row "pre_step"): value added already rising there is why the
         notes read the fall as value added rising (as R7-05).
  Acquisition dates: the ACQUISITION REGISTRY block of 01_acquisition_registry.do,
         copied unchanged (R2-08's rule A, 10%+, every 2020 answer unknown).
  Sample and window: the R7 SAMPLE AND WINDOW block of 02_acquisition_support.do,
         copied unchanged (usable rows, energy records in doubt, years -K..+K).
  Checks : each acquisition year's coefficient in the stacked regression equals
         its own regression (asserted); energy per value added = energy used
         minus value added, coefficient by coefficient (asserted).
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r7-foreign-acquisition-green-technology"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
local exhibit "R7-06"
local fname   "06_before_after_paris"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy per unit of value added after a foreign acquisition, acquired before vs after Paris ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load ownership, export and import status, energy, CO2 and value added; date each acquisition"
*---------------------------------------------------------------------------
* foreign_ownership_pct = share of the firm's capital held by foreign owners (0-100 %)
* fdi_10_flag           = 1 if that share is 10% or more
* export_flag, import_flag = exports / imports reported (1 yes, 0 no; export often
*                         unknown); used by the registry and to find doubtful records
* total_gj_s1           = energy used in GJ (nine fuels + bought electricity)
* co2_total_s1          = CO2 tonnes from the same fuels and electricity (standard factors)
* value_added_nominal   = value added, current prices (masked money unit)
use firm_id year foreign_ownership_pct fdi_10_flag export_flag import_flag ///
    total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
sort firm_id year
* The calendar years with no annual file (found in the data, never typed).
quietly summarize year
local yr0 = r(min)
local yr1 = r(max)
local gapyr ""
forvalues t = `yr0'/`yr1' {
    quietly count if year == `t'
    if r(N) == 0 local gapyr `gapyr' `t'
}
display "   files from `yr0' to `yr1'; calendar years with no file: `gapyr'"

*===========================================================================
* ACQUISITION REGISTRY (copy exactly into later R7 files)
*---------------------------------------------------------------------------
* Needs in memory: firm_id year foreign_ownership_pct fdi_10_flag export_flag
*   import_flag, one row per firm and year (other variables may be there too).
* Missing ownership is unknown, never read as "domestic".
* Main rule (rule A of R2-08, same dates): acquisition year = the first year a
*   firm is seen with 10%+ foreign ownership, if it was seen below 10% in some
*   earlier year. Every answer of the year in acq_bad is treated as unknown.
*   A firm foreign-owned when first seen can never be dated (left out).
* Makes, one value per firm repeated on all its rows:
*   acq_key       9001 never seen 10%+ foreign-owned (the comparison firms)
*                 9002 10%+ foreign-owned when first seen (start unknown: left out)
*                 9003 no usable ownership answer (left out)
*                 otherwise the acquisition year
*   acq_year      acquisition year (missing = not an acquirer)
*   acq_exact     1 = seen below 10% in the calendar year just before (exact date);
*                 0 = the last "below 10%" answer is 2+ years earlier (approximate)
*   acq_after     0 = acquired up to the Paris year (acq_paris), 1 = acquired later
*   acq_share     foreign share (%) in the acquisition year
*   acq_major     1 = 50%+ foreign in the acquisition year (majority), 0 = 10-49%
*   acq_from0     1 = the last answer before the acquisition was exactly 0%
*   acq_next      foreign share (%) at the next usable answer (missing = none)
*   acq_stays     1 = still 10%+ at the next answer, 0 = back below 10%, . = no later answer
*   acq_blip      1 = back below 10% in the calendar year right after (one-year blip),
*                 0 = still 10%+ that year, . = no usable answer that year
*   acq_rev       1 = seen back below 10% in any later year, 0 = never, . = no later answer
*   acq_exp_start 1 = starts exporting in the acquisition year (last known answer
*                 before it "no", this year "yes"); acq_imp_start the same for importing
* The same rule with other ownership lines (key, year, exact for each):
*   _raw  10%+, every answer as filed (acq_bad year kept)
*   _maj  below 10% -> 50%+ (majority); comparison = never 50%+
*   _any  exactly 0% -> above 0%; comparison = never above 0%
*---------------------------------------------------------------------------
local acq_bad   "2020"          // ownership answers of this year are treated as unknown
local acq_paris "2015"          // Paris Agreement adopted December 2015
isid firm_id year                // the registry needs one row per firm and year
* Check: the 10% flag is the foreign share cut at 10%.
assert fdi_10_flag == (foreign_ownership_pct >= 10) if !missing(foreign_ownership_pct)
assert missing(fdi_10_flag) if missing(foreign_ownership_pct)
* Check: in acq_bad far more firms are marked foreign-owned than in the other years.
preserve
collapse (mean) acq_sh = fdi_10_flag, by(year)
quietly summarize acq_sh if year != `acq_bad', detail
local acq_sh_other = r(p50)
quietly summarize acq_sh if year == `acq_bad'
local acq_sh_bad = r(mean)
restore
if `acq_sh_bad' < 2 * `acq_sh_other' display "   WARNING: 10%+ foreign share in `acq_bad' looks normal (" %4.2f `acq_sh_bad' " vs " %4.2f `acq_sh_other' ") - re-check acq_bad"
else display "   10%+ foreign share: `acq_bad' " %4.2f `acq_sh_bad' " vs middle of other years " %4.2f `acq_sh_other' " (`acq_bad' answers treated as unknown)"
gen double acq_own = foreign_ownership_pct
replace acq_own = . if year == `acq_bad'
sort firm_id year
foreach r in main raw maj any {
    local s   = cond("`r'" == "main", "", "_`r'")
    local own = cond("`r'" == "raw", "foreign_ownership_pct", "acq_own")
    local yes "`own' >= 10"                       // foreign-owned
    local no  "`own' < 10"                        // domestic
    if "`r'" == "maj" local yes "`own' >= 50"
    if "`r'" == "any" local yes "`own' > 0"
    if "`r'" == "any" local no  "`own' == 0"
    by firm_id: egen int acq_fy = min(cond(`yes' & !missing(`own'), year, .))   // first "yes"
    by firm_id: egen int acq_fn = min(cond(`no'  & !missing(`own'), year, .))   // first "no"
    by firm_id: egen int acq_nk = total(!missing(`own'))                       // usable answers
    gen int acq_key`s' = .
    replace acq_key`s' = 9003 if acq_nk == 0
    replace acq_key`s' = 9001 if acq_nk > 0 & missing(acq_fy)
    replace acq_key`s' = 9002 if acq_nk > 0 & !missing(acq_fy) & (missing(acq_fn) | acq_fn > acq_fy)
    replace acq_key`s' = acq_fy if acq_nk > 0 & !missing(acq_fy, acq_fn) & acq_fn < acq_fy
    assert !missing(acq_key`s')
    gen int acq_year`s' = acq_key`s' if acq_key`s' < 9000
    by firm_id: egen int acq_ln = max(cond(`no' & !missing(`own', acq_year`s') & year < acq_year`s', year, .))
    gen byte acq_exact`s' = acq_ln == acq_year`s' - 1 if !missing(acq_year`s')
    drop acq_fy acq_fn acq_nk acq_ln
}
assert acq_year != `acq_bad'
gen byte acq_after = acq_year > `acq_paris' if !missing(acq_year)
* Details of the main acquisition (every earlier answer is below 10% by construction).
by firm_id: egen double acq_share = max(cond(year == acq_year, acq_own, .))
gen byte acq_major = acq_share >= 50 if !missing(acq_year)
by firm_id: egen int acq_py = max(cond(!missing(acq_own, acq_year) & year < acq_year, year, .))
by firm_id: egen double acq_prev = max(cond(year == acq_py, acq_own, .))
gen byte acq_from0 = acq_prev == 0 if !missing(acq_year)
by firm_id: egen int acq_ny = min(cond(!missing(acq_own, acq_year) & year > acq_year, year, .))
by firm_id: egen double acq_next = max(cond(year == acq_ny, acq_own, .))
gen byte acq_stays = acq_next >= 10 if !missing(acq_year, acq_next)
* Unknown stays unknown: no answer in the next calendar year -> blip missing;
* no later answer at all -> "ever back below" missing (never read as 0).
gen byte acq_blip = acq_next < 10 if !missing(acq_year, acq_next) & acq_ny == acq_year + 1
by firm_id: egen byte acq_rev = max(!missing(acq_own, acq_year) & year > acq_year & acq_own < 10)
replace acq_rev = . if missing(acq_year, acq_ny)
* Starting to export or import in the acquisition year: this year "yes" and the
* last known answer before it "no" (any gap in between).
foreach x in exp imp {
    local v = cond("`x'" == "exp", "export_flag", "import_flag")
    gen byte acq_pv = .
    by firm_id: replace acq_pv = cond(!missing(`v'[_n-1]), `v'[_n-1], acq_pv[_n-1]) if _n > 1
    by firm_id: egen byte acq_`x'_start = max(year == acq_year & `v' == 1 & acq_pv == 0)
    replace acq_`x'_start = . if missing(acq_year)
    drop acq_pv
}
drop acq_py acq_prev acq_ny
assert inlist(acq_major, 0, 1) & inlist(acq_exact, 0, 1) if !missing(acq_year)
assert acq_share >= 10 & !missing(acq_share) if !missing(acq_year)
* ---- end of ACQUISITION REGISTRY ----
*===========================================================================

*---------------------------------------------------------------------------
display "Step 2/8: usable rows, energy records in doubt, years since acquisition, the R7 window (R7 SAMPLE AND WINDOW block)"
*---------------------------------------------------------------------------
*===========================================================================
* R7 SAMPLE AND WINDOW (copy exactly into later R7 files)
*---------------------------------------------------------------------------
* Needs in memory: the ACQUISITION REGISTRY variables (run that block first)
*   and total_gj_s1 co2_total_s1 value_added_nominal export_flag import_flag.
* Run it on ALL rows of the file, right after the registry and before any other
*   filter (e.g. dropping zero-fuel rows), so every R7 file gets the same window.
* Makes:
*   acq_usable  1 = energy (GJ), CO2 and value added all above zero, so every
*               log exists; a zero is left out, never read as "none"
*   acq_doubt   1 = energy record in doubt (R2-06, R2-08): an importer whose
*               export status is unknown, in a year of acq_doubt_yrs (recorded
*               energy jumps up, then falls to about a fifth, while value added
*               per worker stays flat)
*   acq_main    1 = row of the main R7 sample: usable, not in doubt, and the
*               firm is an acquirer or never seen 10%+ foreign-owned (9001)
*   acq_k       years since acquisition = calendar year - acquisition year
*               (0 = acquisition year, -1 = the year before; missing if none).
*               Counted in calendar years: a year with no file is simply absent.
*   locals acq_K, acq_wlo (= -K), acq_whi (= +K): the R7 window. A year since
*               acquisition gets its own estimate only if acq_minfirms+ firms
*               acquired up to the Paris year AND acq_minfirms+ acquired later
*               have a main row in it, so both are compared over the same years;
*               the widest -K..+K in which every year passes. Years further out
*               are grouped at the two ends. Every later R7 file uses this window.
*---------------------------------------------------------------------------
local acq_doubt_yrs "2017 2019 2020 2021 2022"  // years with energy records in doubt (see above)
local acq_minfirms  30                          // R2-02's rule: 30+ firms for a year of its own
gen byte acq_usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
local acq_dl = subinstr(strtrim(itrim("`acq_doubt_yrs'")), " ", ",", .)
gen byte acq_doubt = missing(export_flag) & import_flag == 1 & inlist(year, `acq_dl')
* Check (R2-08's guard): in each listed year the doubtful rows' middle energy per
* unit of value added should be far from the other rows' (above double or below half).
gen double acq_gjva = total_gj_s1 / value_added_nominal if acq_usable
foreach acq_y of local acq_doubt_yrs {
    quietly summarize acq_gjva if acq_doubt & year == `acq_y', detail
    local acq_md = r(p50)
    local acq_nd = r(N)
    quietly summarize acq_gjva if !acq_doubt & year == `acq_y', detail
    local acq_ratio = `acq_md' / r(p50)
    if `acq_nd' == 0 display "   WARNING: no energy records in doubt in `acq_y' - re-check acq_doubt_yrs"
    else if inrange(`acq_ratio', 0.5, 2) display "   WARNING: in `acq_y' the records in doubt look normal (median ratio " %4.2f `acq_ratio' ") - re-check acq_doubt_yrs"
    else display "   `acq_y': " %5.0fc `acq_nd' " energy records in doubt; their median energy per unit of value added = " %5.2f `acq_ratio' " x the other rows'"
}
drop acq_gjva
gen byte acq_main = acq_usable & !acq_doubt & (!missing(acq_year) | acq_key == 9001)
gen int acq_k = year - acq_year
* Acquirers with a main row in each year since acquisition, by Paris period.
bysort acq_k: egen int acq_nb = total(acq_main & acq_after == 0)
by acq_k: egen int acq_na = total(acq_main & acq_after == 1)
capture assert acq_nb >= `acq_minfirms' & acq_na >= `acq_minfirms' if inlist(acq_k, -1, 0)
if _rc {
    display as error "R7 window: fewer than `acq_minfirms' acquirers before or after Paris in the year before or the acquisition year - no window"
    exit 9
}
local acq_K 0
local acq_go 1
while `acq_go' {
    local acq_kk = `acq_K' + 1
    quietly count if acq_k == -`acq_kk' & acq_nb >= `acq_minfirms' & acq_na >= `acq_minfirms'
    local acq_c1 = r(N)
    quietly count if acq_k == `acq_kk' & acq_nb >= `acq_minfirms' & acq_na >= `acq_minfirms'
    if `acq_c1' > 0 & r(N) > 0 local acq_K = `acq_kk'
    else local acq_go 0
}
drop acq_nb acq_na
sort firm_id year
local acq_wlo = -`acq_K'
local acq_whi = `acq_K'
display "   R7 window: each year from `acq_wlo' to +`acq_whi' on its own; years further out grouped at the two ends"
* ---- end of R7 SAMPLE AND WINDOW ----
*===========================================================================
local wlo = `acq_wlo'
local whi = `acq_whi'
local minfirms = `acq_minfirms'                          // 30+ acquirers for a dot (R2-02's rule, as R2-06)

*---------------------------------------------------------------------------
display "Step 3/8: outcomes, acquisition years, approximate dates, and records in doubt by Paris period"
*---------------------------------------------------------------------------
* Outcomes (logs; a usable row has all four, so every outcome uses the same rows):
*   y1 ln(GJ / value added)            energy per unit of value added (drawn)
*   y2 ln(tonnes of CO2 / value added) CO2 per unit of value added
*   y3 ln(GJ)                          energy used
*   y4 ln(value added)                 value added (so y1 = y3 - y4, checked in Step 4)
gen double y1 = ln(total_gj_s1 / value_added_nominal)  if acq_usable
gen double y2 = ln(co2_total_s1 / value_added_nominal) if acq_usable
gen double y3 = ln(total_gj_s1)                        if acq_usable
gen double y4 = ln(value_added_nominal)                if acq_usable
egen byte ftag = tag(firm_id)
* Acquirers back below 10% at their next answer (they stay acquirers here).
quietly count if ftag & !missing(acq_stays)
local n_later = r(N)
quietly count if ftag & acq_stays == 0
local n_back = r(N)
* Acquisition years in the data (never typed). A year is dated approximately when
* none of its acquirers was seen below 10% in the calendar year just before (that
* year has no file, or its ownership answers are treated as unknown).
quietly levelsof acq_year if ftag, local(cohorts)
local ncoh : word count `cohorts'
local lastg : word `ncoh' of `cohorts'
local approx ""
foreach g of local cohorts {
    quietly count if ftag & acq_year == `g'
    local nall = r(N)
    quietly count if ftag & acq_year == `g' & acq_exact == 1
    local ex_`g' = 100 * r(N) / `nall'
    if r(N) == 0 local approx `approx' `g'
    display "   acquired in `g': " %4.0f `nall' " firms, " %3.0f `ex_`g'' "% seen below 10% in the year just before"
}
display "   acquisition years dated approximately: `approx'"
drop ftag
* Energy records in doubt among acquirers' usable years inside the window
* (years -K..+K), by Paris period: they are left out of the main version, and
* far more of them sit in the later calendar years.
foreach p in 0 1 {
    quietly count if acq_usable & acq_after == `p' & inrange(acq_k, `wlo', `whi')
    local dn = r(N)
    quietly count if acq_usable & acq_doubt & acq_after == `p' & inrange(acq_k, `wlo', `whi')
    local dsh_`p' = 100 * r(N) / `dn'
    display "   records in doubt, acquirers " cond(`p' == 0, "up to", "after") " `acq_paris': " %4.1f `dsh_`p'' "% of " `dn' " usable years in the window"
}
keep firm_id year acq_year acq_key acq_exact acq_main acq_usable y1 y2 y3 y4
sort firm_id year
tempfile fy est stack avg res
save `fy'

*---------------------------------------------------------------------------
display "Step 4/8: one before/after comparison per acquisition year (firm and year fixed effects, clustered by firm)"
*---------------------------------------------------------------------------
* R2-06's design with the R7 acquisition. For acquisition year g: the firms
* acquired in g and all firms never seen 10%+ foreign-owned, only in calendar
* years g`wlo' to g+`whi' (the R7 window; a year with no file is simply absent).
* "after" = 1 for an acquirer's rows from g on. With firm and year fixed
* effects its coefficient compares each firm with itself: the acquirers' change
* from their years before g to their years from g on, minus the same change
* among never-foreign firms over the same calendar years. Earlier or later
* acquirers are never the comparison, so acquisition years are not mixed.
* An acquirer counts only with a usable row both before g and from g on; an
* acquisition year gets an estimate only with `minfirms'+ such acquirers.
* Two comparisons (spec):
*   1 from g on vs ALL years before (g`wlo'..g-1)                   (the dots)
*   2 from g on vs the EARLIER years before only (g`wlo'..g-2): the year just
*     before gets its own marker (m1), because in Figure R7-04 part of the fall
*     happens before the acquisition. Needs `minfirms'+ acquirers with a row in
*     g`wlo'..g-2. Where the year just before has no row (after a year with no
*     file), spec 2 = spec 1. The same regression also gives "from g on vs the
*     year just before" (after - m1; CSV only).
* Versions:
*   1 main      = R7 main sample (usable rows, energy records in doubt left out)
*   2 doubt     = energy records in doubt kept
*   3 paris_cut = main, but acquisitions up to `acq_paris' seen only up to
*                 `acq_paris' (every row of their comparison), so "before Paris"
*                 acquirers are measured before Paris only; later years = main
*   4 exact     = main, only acquirers seen below 10% in the year just before
tempname h
postfile `h' byte(version outcome spec) int start_year long(acq_dated acquirers acq_rows_before acq_rows_after ///
    comp_firms comp_rows rows) int(first_year last_year) double(b se df yb_b yb_se) using `est'
local first 1
forvalues v = 1/4 {
    foreach g of local cohorts {
        use `fy', clear
        if `v' == 2 keep if acq_usable & (!missing(acq_year) | acq_key == 9001)
        else        keep if acq_main
        if `v' == 4 keep if missing(acq_year) | acq_exact == 1
        keep if (acq_year == `g' | acq_key == 9001) & inrange(year, `g' + `wlo', `g' + `whi')
        if `v' == 3 & `g' <= `acq_paris' drop if year > `acq_paris'
        sort firm_id year
        gen byte acq = acq_year == `g'                       // acquirer of year g (0 = never foreign)
        egen byte ft = tag(firm_id) if acq
        quietly count if ft == 1
        local nd = r(N)                                  // acquirers of g with a usable row in the window
        by firm_id: egen byte has_b = max(year <  `g')
        by firm_id: egen byte has_a = max(year >= `g')
        by firm_id: egen byte has_e = max(year <= `g' - 2)   // a row in the earlier years before
        keep if !acq | (has_b & has_a)
        quietly count if ft == 1
        local ns = r(N)                                  // acquirers used (weight, spec 1)
        quietly count if ft == 1 & has_e
        local ne = r(N)                                  // of which with a row in g`wlo'..g-2 (weight, spec 2)
        local wA`v'_`g' = `ns'
        local wB`v'_`g' = cond(`ns' >= `minfirms', `ne', 0)
        gen byte after = acq & year >= `g'
        gen byte m1 = acq & year == `g' - 1              // the year just before (none after a year with no file)
        quietly count if m1
        local nm1 = r(N)
        forvalues s = 1/2 {
            local nn = cond(`s' == 1, `ns', `ne')
            if `ns' < `minfirms' | `nn' < `minfirms' {
                forvalues o = 1/4 {
                    post `h' (`v') (`o') (`s') (`g') (`nd') (`nn') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.)
                }
                continue
            }
            local rhs = cond(`s' == 2 & `nm1' > 0, "after m1", "after")
            forvalues o = 1/4 {
                quietly reghdfe y`o' `rhs', absorb(firm_id year) vce(cluster firm_id)
                local b  = _b[after]
                local se = _se[after]
                local df = e(df_r)
                local ab_st "`e(absvars)'"                 // for the regression table (Step 8)
                local cl_st "`e(clustvar)'"
                local b`s'_`v'_`g'_`o' = `b'
                local ybb = .
                local ybs = .
                if "`rhs'" == "after m1" {
                    quietly lincom after - m1
                    local ybb = r(estimate)
                    local ybs = r(se)
                }
                capture drop es
                gen byte es = e(sample)
                quietly count if es & acq & year <  `g'
                local rb = r(N)
                quietly count if es & acq & year >= `g'
                local ra = r(N)
                egen byte ct = tag(firm_id) if es & !acq
                quietly count if ct == 1
                local cf = r(N)
                drop ct
                quietly count if es & !acq
                local cr = r(N)
                quietly summarize year if es
                local fy0 = r(min)
                local fy1 = r(max)
                post `h' (`v') (`o') (`s') (`g') (`nd') (`nn') (`rb') (`ra') (`cf') (`cr') (e(N)) ///
                    (`fy0') (`fy1') (`b') (`se') (`df') (`ybb') (`ybs')
            }
            * Check: energy per value added = energy used minus value added, so the
            * coefficients must add up exactly (same rows, same model).
            assert abs(`b`s'_`v'_`g'_1' - (`b`s'_`v'_`g'_3' - `b`s'_`v'_`g'_4')) < 1e-7
        }
        if `ns' >= `minfirms' display "   version `v', acquired in `g': " %4.0f `ns' " acquirers (" %4.0f `ne' ///
            " with an earlier year before); energy per value added b = " %7.4f `b1_`v'_`g'_1'
        else display "   version `v', acquired in `g': " %4.0f `ns' " acquirers - fewer than `minfirms', no estimate"
        if `ns' >= `minfirms' {
            gen int cohort = `g'
            gen byte version = `v'
            gen int e = year - `g' if acq
            keep firm_id year cohort version acq after m1 e y1 y2 y3 y4
            if !`first' append using `stack'
            save `stack', replace
            local first 0
        }
    }
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 5/8: averages over acquisition years (weighted by acquirers used), up to vs after Paris"
*---------------------------------------------------------------------------
* All acquisition years in one stacked regression: each keeps its own firm and
* year fixed effects and its own markers, so each coefficient equals Step 4's
* (checked); clustering by firm accounts for never-foreign firms that serve in
* several acquisition years. Average = weights x coefficients (lincom), weight =
* acquirers used. "Up to Paris" = acquired up to `acq_paris'; "after" = later.
tempname a
postfile `a' byte(version outcome spec) str16 row_type long(acquirers comp_firms rows) double(b se df p) using `avg'
forvalues v = 1/4 {
    use `stack', clear
    keep if version == `v'
    egen long fc = group(firm_id cohort)
    egen long yc = group(year cohort)
    quietly levelsof cohort, local(used1)
    forvalues s = 1/2 {
        local dterms ""
        local used ""
        foreach L in all early late notlast {
            local t`L' 0
            local l`L' ""
        }
        local tpre 0                                     // spec 2: the year just before vs the earlier years
        local mused ""
        local lpre ""
        foreach g of local used1 {
            local w = cond(`s' == 1, `wA`v'_`g'', `wB`v'_`g'')
            if `w' < `minfirms' continue
            local used `used' `g'
            capture drop d`g'
            gen byte d`g' = after * (cohort == `g')
            local dterms `dterms' d`g'
            if `s' == 2 {
                quietly count if m1 & cohort == `g'
                if r(N) > 0 {
                    capture drop m1_`g'
                    gen byte m1_`g' = m1 * (cohort == `g')
                    local dterms `dterms' m1_`g'
                    local mused `mused' `g'
                    local tpre = `tpre' + `w'
                }
            }
            local tall = `tall' + `w'
            if `g' <= `acq_paris' local tearly = `tearly' + `w'
            else local tlate = `tlate' + `w'
            if `g' != `lastg' local tnotlast = `tnotlast' + `w'
        }
        foreach g of local used {
            local w = cond(`s' == 1, `wA`v'_`g'', `wB`v'_`g'')
            local lall "`lall' + `w'/`tall' * d`g'"
            if `g' <= `acq_paris' local learly "`learly' + `w'/`tearly' * d`g'"
            else local llate "`llate' + `w'/`tlate' * d`g'"
            if `g' != `lastg' local lnotlast "`lnotlast' + `w'/`tnotlast' * d`g'"
        }
        * The year just before vs the earlier years before (-K..-2), averaged the same
        * way: shows whether a change was already under way before the acquisition.
        foreach g of local mused {
            local lpre "`lpre' + `wB`v'_`g''/`tpre' * m1_`g'"
        }
        capture drop inS
        gen byte inS = 0
        foreach g of local used {
            quietly replace inS = 1 if cohort == `g'
        }
        * Before-acquisition check (R2-06's), spec 1 only: one marker per acquisition
        * year and year before it, against the last year before it that has a row
        * (the year just before; for 2017 acquirers 2015, as 2016 has no file).
        * Markers for the same year before are averaged over acquisition years
        * (weight = acquirers seen that year) and all these averages tested together.
        local lterms ""
        local ltest ""
        if `s' == 1 {
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
        }
        forvalues o = 1/4 {
            if "`ltest'" != "" {
                quietly reghdfe y`o' `dterms' `lterms' if inS, absorb(fc yc) vce(cluster firm_id)
                quietly test `ltest'
                post `a' (`v') (`o') (`s') ("before_check") (.) (.) (.) (.) (.) (.) (r(p))
            }
            quietly reghdfe y`o' `dterms' if inS, absorb(fc yc) vce(cluster firm_id)
            foreach g of local used {
                assert reldif(_b[d`g'], `b`s'_`v'_`g'_`o'') < 1e-6
            }
            local nobs = e(N)
            capture drop es
            gen byte es = e(sample)
            egen byte ct = tag(firm_id) if es & !acq
            quietly count if ct == 1
            local cf = r(N)
            drop ct
            foreach L in all early late notlast {
                if `t`L'' == 0 continue
                quietly lincom `l`L''
                post `a' (`v') (`o') (`s') ("`L'") (`t`L'') (`cf') (`nobs') (r(estimate)) (r(se)) (r(df)) (r(p))
            }
            if `tearly' > 0 & `tlate' > 0 {
                quietly lincom (`llate') - (`learly')
                post `a' (`v') (`o') (`s') ("late_minus_early") (.) (`cf') (`nobs') (r(estimate)) (r(se)) (r(df)) (r(p))
            }
            if `tpre' > 0 {
                quietly lincom `lpre'
                post `a' (`v') (`o') (`s') ("pre_step") (`tpre') (`cf') (`nobs') (r(estimate)) (r(se)) (r(df)) (r(p))
            }
        }
        if "`lterms'" != "" drop `lterms'
    }
    display "   version `v': stacked coefficients equal each acquisition year's own regression"
}
postclose `a'

*---------------------------------------------------------------------------
display "Step 6/8: percentages, labels and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `avg', clear
append using `est'
replace row_type = "start_year" if row_type == ""
gen double lo = b - invttail(df, 0.025) * se
gen double hi = b + invttail(df, 0.025) * se
replace p = 2 * ttail(df, abs(b / se)) if row_type == "start_year"
* % difference = 100 x (exp(b) - 1); the interval ends converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
foreach c in pct pct_lo pct_hi {
    replace `c' = . if row_type == "late_minus_early"   // a difference of two averages is read in logs (b) and p
}
* From the acquisition on vs the year just before (spec 2 regression; CSV only).
gen double yb_pct = 100 * (exp(yb_b) - 1)
gen str60 outcome_label = ""
replace outcome_label = "Energy per unit of value added: ln(GJ / value added)"       if outcome == 1
replace outcome_label = "CO2 per unit of value added: ln(tonnes of CO2 / value added)" if outcome == 2
replace outcome_label = "Energy used: ln(GJ)"                                         if outcome == 3
replace outcome_label = "Value added: ln(value added, current prices)"               if outcome == 4
gen str90 version_label = ""
replace version_label = "Main: `acq_bad' ownership answers unknown, energy records in doubt left out (drawn)" if version == 1
replace version_label = "Main acquisitions, energy records in doubt kept"                                       if version == 2
replace version_label = "Main, acquisitions up to `acq_paris' seen only up to `acq_paris'"                     if version == 3
replace version_label = "Main, only acquirers seen below 10% in the year just before (exact date)"             if version == 4
gen str70 spec_label = cond(spec == 1, "From the acquisition on vs all years before (`wlo' to -1)", ///
    "From the acquisition on vs the earlier years before (`wlo' to -2)")
gen str90 row_label = ""
replace row_label = "Acquired in " + string(start_year)                                     if row_type == "start_year"
replace row_label = "Acquired up to `acq_paris' (before the Paris Agreement)"               if row_type == "early"
replace row_label = "Acquired after `acq_paris' (after the Paris Agreement)"                if row_type == "late"
replace row_label = "After-Paris average minus up-to-`acq_paris' average (log points)"      if row_type == "late_minus_early"
replace row_label = "All acquisition years (weighted by acquirers)"                         if row_type == "all"
replace row_label = "All acquisition years except `lastg' (only the acquisition year)"      if row_type == "notlast"
replace row_label = "Before-acquisition check: years before vs the last one (p only)"      if row_type == "before_check"
replace row_label = "Already under way: the year just before vs the earlier years before (`wlo' to -2)" if row_type == "pre_step"
* Acquisition-year details repeated on its rows.
gen double exact_pct = .
gen byte approx_date = .
foreach g of local cohorts {
    quietly replace exact_pct = `ex_`g'' if start_year == `g'
    quietly replace approx_date = `: list g in approx' if start_year == `g'
}
gen double doubt_pct_upto  = `dsh_0'                    // records in doubt, % of acquirers' usable window years
gen double doubt_pct_after = `dsh_1'
gen long acquirers_with_later_answer = `n_later'
gen long acquirers_back_below_10     = `n_back'
gen int min_firms    = `minfirms'
gen int window_first = `wlo'
gen int window_last  = `whi'
gen str100 note = ""
replace note = "Fewer than `minfirms' acquirers seen before and from the acquisition: no estimate" if row_type == "start_year" & missing(b) & spec == 1
replace note = "Fewer than `minfirms' acquirers with an earlier year before (`wlo' to -2): no estimate" if row_type == "start_year" & missing(b) & spec == 2
foreach g of local approx {
    replace note = note + cond(note == "", "", "; ") + "Dated approximately: no usable ownership answer in `=`g'-1'" if start_year == `g'
}
replace note = note + cond(note == "", "", "; ") + "No row in the year just before: equals the comparison with all years before" ///
    if row_type == "start_year" & spec == 2 & !missing(b) & missing(yb_b)
replace note = note + cond(note == "", "", "; ") + "Only years 0 to +" + string(last_year - start_year) + " after the acquisition" ///
    if row_type == "start_year" & !missing(b) & last_year - start_year < `whi' & version != 3
replace note = "Each year before vs the last one before it, averaged over acquisition years, tested together" if row_type == "before_check"
replace note = "Acquisition years with a row in the year just before; weights = acquirers with an earlier year before" if row_type == "pre_step"
gen byte rorder = 1*(row_type == "start_year") + 2*(row_type == "early") + 3*(row_type == "late") ///
    + 4*(row_type == "late_minus_early") + 5*(row_type == "all") + 6*(row_type == "notlast") + 7*(row_type == "before_check") ///
    + 8*(row_type == "pre_step")
sort outcome version spec rorder start_year
order outcome outcome_label version version_label spec spec_label row_type row_label start_year b se lo hi p ///
      pct pct_lo pct_hi acq_dated acquirers acq_rows_before acq_rows_after comp_firms comp_rows rows ///
      first_year last_year df yb_b yb_se yb_pct exact_pct approx_date doubt_pct_upto doubt_pct_after ///
      acquirers_with_later_answer acquirers_back_below_10 min_firms window_first window_last note
drop rorder
format b se lo hi yb_b yb_se %9.4f
format pct pct_lo pct_hi yb_pct exact_pct doubt_pct_* %9.1f
format p %9.3f
format df acq_dated acquirers acq_rows_before acq_rows_after comp_firms comp_rows rows acquirers_* %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
quietly save `res'                 // same numbers, full precision, for the companion tables (Step 8)
list version spec row_label pct pct_lo pct_hi p acquirers if outcome == 1 & inlist(version, 1, 3), ///
    noobs sepby(version spec) abbreviate(24) clean
list outcome version spec row_label b se p if row_type == "late_minus_early" | row_type == "before_check", ///
    noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart, energy per unit of value added, one dot per acquisition year"
*---------------------------------------------------------------------------
* The after-Paris average with the energy records in doubt kept (version 2), for the notes.
quietly summarize pct if outcome == 1 & version == 2 & spec == 1 & row_type == "late"
local dk = r(mean)
local dktxt = cond(round(`dk') > 0, "+", "") + string(`dk', "%9.0f") + "%"
* The reading (as Figures R7-04 and R7-05): energy per value added = energy used
* minus value added (logs), so say which of the two moves, and whether value added
* was already rising in the year just before (pre_step, main version).
foreach o in 1 3 4 {
    quietly summarize b if outcome == `o' & version == 1 & spec == 1 & row_type == "all"
    local ab`o' = r(mean)
    quietly summarize pct if outcome == `o' & version == 1 & spec == 1 & row_type == "all"
    local ap`o' = cond(round(r(mean)) > 0, "+", "") + string(r(mean), "%9.0f") + "%"
    quietly summarize p if outcome == `o' & version == 1 & spec == 1 & row_type == "all"
    local aq`o' = r(mean)
    local ac`o' = cond(`aq`o'' < 0.05, "clear", "not clear")
}
quietly summarize pct if outcome == 4 & version == 1 & spec == 2 & row_type == "pre_step"
local vpre = r(mean)
local vpretx = cond(round(`vpre') > 0, "+", "") + string(`vpre', "%9.0f") + "%"
quietly summarize p if outcome == 4 & version == 1 & spec == 2 & row_type == "pre_step"
local vpreq = r(mean)
local vpreps = cond(`vpreq' < 0.001, "p`=uchar(160)'<`=uchar(160)'0.001", "p`=uchar(160)'=`=uchar(160)'" + string(`vpreq', "%5.3f"))
quietly summarize b if outcome == 1 & version == 1 & spec == 2 & row_type == "pre_step"
local r4txt "Figure R7-04 uses the year just before as base, so its average differs."
if r(mean) < 0 local r4txt "Figure R7-04's smaller average uses the year just before as base, when energy per unit of value added was already lower."
local rdtxt "All acquirers: energy used `ap3' (`ac3'), value added `ap4' (`ac4')"
if abs(`ab4') > abs(`ab3') & `aq4' < 0.05 & `ab1' < 0 {
    local rdtxt "`rdtxt', so the fall comes from value added rising, not from less energy"
    if `vpre' > 0 {
        local rdtxt "`rdtxt'; value added was already `vpretx' in the year just before vs the earlier years (`vpreps'; see Figure R7-05)"
        if `vpreq' < 0.05 local rdtxt "`rdtxt', a rise the new owner cannot have caused"
    }
}
local rdtxt "`rdtxt'."
keep if outcome == 1 & version == 1
keep if (spec == 1 & inlist(row_type, "start_year", "early", "late", "all", "late_minus_early", "before_check")) ///
    | (spec == 2 & inlist(row_type, "early", "late", "all", "late_minus_early"))
* Numbers for the text and notes, read from the table (never typed).
local nb = uchar(160)                                   // no-break space: keeps "p = 0.123" on one note line
foreach s in 1 2 {
    quietly summarize p if row_type == "late_minus_early" & spec == `s'
    local gp`s' = r(mean)
    local gps`s' = cond(`gp`s'' < 0.001, "p`nb'<`nb'0.001", "p`nb'=`nb'" + string(`gp`s'', "%5.3f"))
    local gpw`s' = cond(`gp`s'' < 0.05, "a clear difference", "no clear difference")
}
quietly summarize p if row_type == "before_check" & spec == 1
local bp = r(mean)
local bps = cond(`bp' < 0.001, "p`nb'<`nb'0.001", "p`nb'=`nb'" + string(`bp', "%5.3f"))
local btxt = cond(`bp' < 0.05, "the years before already differ (`bps'), a warning sign", "no clear difference among the years before (`bps')")
* Acquisition years named in the notes, as text.
local gaptxt = subinstr(strtrim("`gapyr'"), " ", " and ", .)
local apptxt = subinstr(strtrim("`approx'"), " ", " and ", .)
local d0 = string(`dsh_0', "%9.0f")
local d1 = string(`dsh_1', "%9.0f")
local n_back_c  = strtrim(string(`n_back', "%9.0fc"))
local n_later_c = strtrim(string(`n_later', "%9.0fc"))
quietly summarize last_year if row_type == "start_year" & start_year == `lastg' & spec == 1
local lastk = r(mean) - `lastg'
local lasttxt = cond(`lastk' == 0, "`lastg' has only the acquisition year itself", "`lastg' has only years 0 to +`lastk'")
* Acquisition years followed for fewer than +K years because the files end (not
* because of a year with no file inside the window): named in the notes.
local shorttxt ""
foreach g of local cohorts {
    quietly summarize last_year if row_type == "start_year" & start_year == `g' & spec == 1 & !missing(b)
    if r(N) == 0 continue
    local lk = r(mean) - `g'
    if `lk' >= `whi' | `g' + `whi' <= `yr1' continue
    local piece = cond(`lk' == 0, "`g' only the acquisition year", "`g' to +`lk'")
    local shorttxt = cond("`shorttxt'" == "", "`piece'", "`shorttxt', `piece'")
}
drop if inlist(row_type, "late_minus_early", "before_check")
* x positions: acquisition years at their calendar year; the three averages to the
* right, black diamond (vs all years before) left of the gray square (vs the earlier years).
gen double x = start_year if row_type == "start_year"
local xa1 = `lastg' + 2
replace x = `xa1'       if row_type == "early"
replace x = `xa1' + 2.8 if row_type == "late"
replace x = `xa1' + 5.6 if row_type == "all"
replace x = x - 0.2 if spec == 1 & row_type != "start_year"
replace x = x + 0.2 if spec == 2
gen byte avg = row_type != "start_year"
gen byte appr = 0
foreach g of local approx {
    replace appr = 1 if start_year == `g'
}
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !missing(pct)
* x-axis: every calendar year from the first file to the last acquisition year
* (no dot where no acquisition can be dated), then the three averages; two
* lines each: the year (or group), then the acquirers used.
local e0 : word 1 of `cohorts'
local e1 0
local f1 0
foreach g of local cohorts {
    if `g' <= `acq_paris' local e1 = `g'
    if `g' >  `acq_paris' & `f1' == 0 local f1 = `g'
}
local xlab ""
forvalues yy = `yr0'/`lastg' {
    quietly summarize acquirers if start_year == `yy' & spec == 1
    local ncnt = cond(r(N) > 0, string(r(mean), "%9.0fc"), " ")
    local xlab `"`xlab' `yy' `""`yy'" "`ncnt'""'"'
}
foreach r in early late all {
    quietly summarize acquirers if row_type == "`r'" & spec == 1
    local n_`r' = string(r(mean), "%9.0fc")
}
local l1 = "`e0'–" + substr("`e1'", 3, 2)
local lt = "`f1'–" + substr("`lastg'", 3, 2)
local xlab `"`xlab' `xa1' `""`l1'" "`n_early'""' `=`xa1'+2.8' `""`lt'" "`n_late'""' `=`xa1'+5.6' `""All" "`n_all'""'"'
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
if (`ytop' - `ybot')/`step' > 8 {                      // at most 8 steps: fewer, clearer labels
    local step = 2 * `step'
    local ybot = `step' * floor(`ymin'/`step')
    local ytop = `step' * ceil(`ymax'/`step')
}
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local span = `ytop' - `ybot'
local ytx = `ytop' + 0.26 * `span'                      // the three text lines, above the highest gridline
local ytg = `ytop' + 0.17 * `span'
local ytb = `ytop' + 0.08 * `span'
local xl = `yr0' - 0.6
local xr = `xa1' + 6.3
local xp = `acq_paris' + 0.5                            // Paris line: end of the Paris year
* The before/after-Paris comparison in one line at the top of the plot.
gen str200 ttxt = ""
gen str200 gtxt = ""
replace ttxt = "Black diamonds, acquired after `acq_paris' vs up to `acq_paris': `gpw1' (`gps1')." in 1
replace gtxt = "Gray squares, the same comparison: `gpw2' (`gps2')." in 1
gen str200 btxt = ""
replace btxt = "Before the acquisition: `btxt'." in 1
gen double ytx = `ytx'
gen double ytg = `ytg'
gen double ytb = `ytb'
gen double xtx = `xl'
* No annual file (gray band) and the year whose ownership answers are unusable
* (dashed box, as in Figure R7-01): no acquisition is dated in either.
local xg : word 1 of `gapyr'
if "`xg'" != "" local band "(function y = `ytop', range(`=`xg'-0.4' `=`xg'+0.4') recast(area) base(`ybot') fcolor(gs14) lcolor(gs14) lwidth(none))"
else local band "(scatteri `ybot' `xl', msymbol(none))"
gen double bx = `acq_bad' in 1
gen double bhi = `ytop' in 1
gen double blo = `ybot' in 1
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: Acquisition = the first year a firm reports foreign owners holding 10% or more of its capital, after an earlier year below"
local txt "`txt' 10% (a change in the reported share, not a verified purchase); it stays one if the share falls back (`n_back_c' of"
local txt "`txt' `n_later_c' with a later answer). Each dot = one acquisition year: its acquirers' change from the years before (`wlo' to -1)"
local txt "`txt' to the acquisition year and after (0 to +`whi'), minus the same change among firms never seen 10%+ foreign-owned over the"
local txt "`txt' same years; bars = 95% intervals, crossing 0 = no clear difference. Gray squares: base = only the"
local txt "`txt' earlier years before (`wlo' to -2). `r4txt' `rdtxt'"
if "`shorttxt'" != "" local txt "`txt' Fewer years after: `shorttxt'."
local txt "`txt' Energy records in doubt left out: `d1'% of after-Paris acquirers' years, `d0'% up to `acq_paris'; kept, after Paris"
local txt "`txt' = `dktxt', but those records show far less energy than others (a recording problem)."
local txt "`txt' A gap would not prove that Paris caused it. Value added = output value minus materials, energy"
local txt "`txt' and services bought (current prices); GJ = gigajoules. No equipment or process data. Firm links are fictional: a test of the method only."
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
twoway `band' ///
    (rbar bhi blo bx, barwidth(0.8) fcolor(none) lcolor(gs9) lpattern(dash) lwidth(thin)) ///
    (pci 0 `xl' 0 `xr', lcolor(gs8) lwidth(thin)) ///
    (pci `ybot' `xp' `ytop' `xp', lcolor(gs4) lpattern(shortdash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if spec == 1 & !avg, lcolor(black) lwidth(thin)) ///
    (scatter pct x if spec == 1 & !avg & !appr, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(9) mlabgap(0.6) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if spec == 1 & !avg & appr, msymbol(Oh) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(9) mlabgap(0.6) mlabsize(vsmall) mlabcolor(black)) ///
    (rspike pct_hi pct_lo x if spec == 1 & avg, lcolor(black) lwidth(medthick)) ///
    (scatter pct x if spec == 1 & avg, msymbol(D) msize(medsmall) mcolor(black) ///
        mlabel(lbl) mlabposition(9) mlabgap(1.2) mlabsize(vsmall) mlabcolor(black)) ///
    (rspike pct_hi pct_lo x if spec == 2, lcolor(gs9) lwidth(medthick)) ///
    (scatter pct x if spec == 2, msymbol(Sh) msize(medsmall) mcolor(gs6) ///
        mlabel(lbl) mlabposition(3) mlabgap(1.2) mlabsize(vsmall) mlabcolor(gs5)) ///
    (scatter ytx xtx if ttxt != "", msymbol(none) mlabel(ttxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ytg xtx if gtxt != "", msymbol(none) mlabel(gtxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs5)) ///
    (scatter ytb xtx if btxt != "", msymbol(none) mlabel(btxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1)) ///
    xtitle("Acquisition year, then the averages; second row = acquirers seen before and from the acquisition (`minfirms'+ for a dot)", size(vsmall) margin(t+1)) ///
    yscale(range(`ybot' `ytx') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") subtitle("Energy (GJ) per unit of value added, % change after vs before the acquisition:" "acquirers minus firms never seen 10%+ foreign-owned", ///
        size(small) position(11) justification(left) span) ///
    legend(order(6 "One acquisition year" 7 "The same, date approximate (no usable answer the year before)" ///
                 9 "Average of acquisition years, weighted by acquirers" 11 "The same average vs the earlier years before (`wlo' to -2)" ///
                 5 "95% interval" 3 "0 = no difference" ///
                 4 "Paris Agreement adopted (December `acq_paris')" 1 "No annual file: no acquisition dated" ///
                 2 "`acq_bad' ownership answers unusable: no acquisition dated") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Energy per unit of value added after a foreign acquisition: acquired before vs after Paris", ///
        size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    scale(`=7.5/9') xsize(9) ysize(9)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the chart"
*---------------------------------------------------------------------------
* Both tables are built from the numbers saved in Step 6 (the CSV's numbers),
* after the chart is saved, so the chart and the CSV are not touched here.
* Written with putpdf (built into Stata; no add-on) by the shared writer below.
* ==== COMPANION TABLE writer (pilot pattern, SP TABLE-pilot/ctable_block.do) ====
* ctable_pdf strvars using "file.pdf", title() header("Col 1" "Col|2" ...) [right()
*   norepeat() rules() notes() subtitle() fontsize() perpage() landscape portrait]:
*   one string variable per column, one row per table line; "|" in a header = new
*   line; landscape when more than 6 columns; long tables continue on a new page.
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
local ptab "tables/`fname'_table.pdf"
local rtab "tables/`fname'_regression.pdf"
local ftitle "Energy per unit of value added after a foreign acquisition: acquired before vs after Paris"
* (1) Points table: every drawn point, left to right: each calendar year on the
* axis (years with no dot included, with the reason), then the three averages,
* black diamond first, then the gray square.
use `res', clear
keep if outcome == 1 & version == 1
keep if (spec == 1 & inlist(row_type, "start_year", "early", "late", "all")) | (spec == 2 & inlist(row_type, "early", "late", "all"))
gen double pos = start_year if row_type == "start_year"
replace pos = `xa1'       if row_type == "early"
replace pos = `xa1' + 2.8 if row_type == "late"
replace pos = `xa1' + 5.6 if row_type == "all"
quietly count if !missing(pct)
local ndrawn = r(N)
* axis years with no acquisition year in the data (first file, no file, unusable answers)
forvalues yy = `yr0'/`lastg' {
    quietly count if start_year == `yy'
    if r(N) == 0 {
        set obs `=_N + 1'
        replace pos = `yy' in l
        replace start_year = `yy' in l
        replace row_type = "axis_only" in l
        replace spec = 0 in l
    }
}
sort pos spec
local nrows = _N
gen str16 c_pos = string(start_year) if inlist(row_type, "start_year", "axis_only")
replace c_pos = "`l1'" if row_type == "early"
replace c_pos = "`lt'" if row_type == "late"
replace c_pos = "All"  if row_type == "all"
gen str70 c_ser = "—"
replace c_ser = "One acquisition year"                                  if row_type == "start_year"
replace c_ser = "The same, date approximate"                            if row_type == "start_year" & approx_date == 1
replace c_ser = "Average, weighted by acquirers"   if spec == 1 & inlist(row_type, "early", "late", "all")
replace c_ser = "Same average vs years `wlo' to -2" if spec == 2
* whole % as the chart labels
gen str12 c_v  = ""
gen str12 c_lo = ""
gen str12 c_hi = ""
foreach c in v lo hi {
    local s = cond("`c'" == "v", "pct", "pct_`c'")
    replace c_`c' = cond(round(`s') > 0, "+", "") + string(round(`s'), "%9.0f") if !missing(`s')
}
gen str12 c_n  = string(acquirers, "%12.0fc") if !missing(acquirers)
gen str12 c_cf = string(comp_firms, "%12.0fc") if !missing(comp_firms)
gen str12 c_r  = string(rows, "%12.0fc") if !missing(rows)
gen str100 c_st = ""
replace c_st = "drawn: black dot, 95% bar, label" if row_type == "start_year" & approx_date == 0
replace c_st = "drawn: hollow circle, 95% bar, label" if row_type == "start_year" & approx_date == 1
replace c_st = "drawn: black diamond, thick bar, label" if spec == 1 & inlist(row_type, "early", "late", "all")
replace c_st = "drawn: gray square, thick gray bar, label" if spec == 2
replace c_st = c_st + "; years 0 to +" + string(last_year - start_year) + " only" if row_type == "start_year" & inrange(last_year - start_year, 1, `whi' - 1) & !missing(pct)
replace c_st = c_st + "; acquisition year only" if row_type == "start_year" & last_year == start_year & !missing(pct)
replace c_st = "not drawn: fewer than `minfirms' acquirers seen before and from the acquisition" if row_type == "start_year" & missing(pct)
replace c_st = "not drawn: no acquisition dated this year" if row_type == "axis_only"
replace c_st = "not drawn: first file, nothing to date" if row_type == "axis_only" & start_year == `yr0'
replace c_st = "not drawn: `acq_bad' ownership answers unusable" if row_type == "axis_only" & start_year == `acq_bad'
foreach g of local gapyr {
    replace c_st = "not drawn: no annual file" if row_type == "axis_only" & start_year == `g'
}
* check: one table row per drawn point, same numbers as the CSV
quietly count if strpos(c_st, "drawn:") == 1
assert r(N) == `ndrawn'
assert c_v != "" if strpos(c_st, "drawn:") == 1
assert _N == `nrows'
quietly count if pos <= `lastg'
local rl = r(N)                        // rule under the last acquisition year, before the averages
local nnote = subinstr(`"`txt'"', "Notes: ", "Chart notes: ", 1)
ctable_pdf c_pos c_ser c_v c_lo c_hi c_n c_cf c_r c_st using "`ptab'", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Energy (GJ) per unit of value added: % change after the acquisition vs before it, acquirers minus firms never seen 10%+ foreign-owned") ///
    header("Acquisition|year or average" "Series (legend)" "%|difference" "95%|low" "95%|high" ///
        "Acquirers|used" "Never-foreign|firms" "Firm-|years" "Status") ///
    right(3 4 5 6 7 8) norepeat(1) rules(`rl') fontsize(8.5) perpage(24) ///
    notes("Plotted value: % difference = 100 x (exp(b) - 1), b = the regression table's column (1) (dots and black diamonds) or (2) (gray squares), rounded as the chart labels. Acquirers used = acquirers with a usable year both before and from the acquisition (gray squares: with a year in `wlo' to -2); never-foreign firms and firm-years = the regression sample (averages: all acquisition years stacked). Full precision: tables/`fname'.csv." ///
        `"`nnote'"' "`srcnote'" "`devnote'")
display "table -> `ptab' (`ndrawn' plotted points)"

* (2) Regression table (AER style): energy per unit of value added; one column
* per comparison and version, coefficient on the first line, (standard error) on
* the second; % difference for the averages only (drawn %s: points table).
use `res', clear
keep if outcome == 1
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep if outcome == 1
keep version spec row_type start_year b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 version spec row_type start_year using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert missing(b_csv) if missing(b)
drop b_csv
* acquisition years whose column (2) equals column (1): no row in the year just before
local same2 ""
foreach g of local cohorts {
    quietly count if version == 1 & spec == 2 & row_type == "start_year" & start_year == `g' & !missing(b) & missing(yb_b)
    if r(N) > 0 local same2 `same2' `g'
}
local same2 = subinstr(strtrim("`same2'"), " ", " and ", .)
gen byte col = .
replace col = 1 if version == 1 & spec == 1
replace col = 2 if version == 1 & spec == 2
replace col = 3 if version == 2 & spec == 1
replace col = 4 if version == 3 & spec == 1
replace col = 5 if version == 4 & spec == 1
keep if !missing(col)
tempname P
tempfile R
postfile `P' str60 t_lab str24(t1 t2 t3 t4 t5) using `R'
local nterm 0
foreach g of local cohorts {
    forvalues c = 1/5 {
        quietly summarize b if row_type == "start_year" & start_year == `g' & col == `c', meanonly
        local b`c' = cond(r(N) > 0, string(r(mean), "%9.3f"), "no estimate")
        quietly summarize se if row_type == "start_year" & start_year == `g' & col == `c', meanonly
        local s`c' = cond(r(N) > 0, "(" + string(r(mean), "%9.3f") + ")", "")
    }
    local lab "Acquired in `g'"
    if `: list g in approx' local lab "`lab' (date approximate)"
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'")
    local nterm = `nterm' + 2
}
local navg 0
foreach r in early late late_minus_early all notlast {
    local lab = cond("`r'" == "early", "Average, acquired up to `acq_paris'", ///
        cond("`r'" == "late", "Average, acquired after `acq_paris'", ///
        cond("`r'" == "late_minus_early", "After-Paris minus up-to-`acq_paris' average", ///
        cond("`r'" == "all", "Average, all acquisition years", "Average, all except `lastg'"))))
    forvalues c = 1/5 {
        quietly summarize b if row_type == "`r'" & col == `c', meanonly
        local b`c' = cond(r(N) > 0, string(r(mean), "%9.3f"), "—")
        quietly summarize se if row_type == "`r'" & col == `c', meanonly
        local s`c' = cond(r(N) > 0, "(" + string(r(mean), "%9.3f") + ")", "")
        quietly summarize pct if row_type == "`r'" & col == `c', meanonly
        if r(N) > 0 local s`c' = "`s`c'' [" + cond(round(r(mean), 0.1) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
        quietly summarize p if row_type == "`r'" & col == `c', meanonly
        local q`c' = cond(r(N) == 0, "", cond(r(mean) < 0.001, "p < 0.001", "p = " + string(r(mean), "%5.3f")))
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'")
    local navg = `navg' + 2
    if "`r'" == "late_minus_early" {
        post `P' ("") ("`q1'") ("`q2'") ("`q3'") ("`q4'") ("`q5'")
        local ++navg
    }
}
forvalues c = 1/5 {
    quietly summarize p if row_type == "before_check" & col == `c', meanonly
    local bp`c' = cond(r(N) == 0, "—", cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f")))
    quietly summarize acquirers if row_type == "all" & col == `c', meanonly
    local ns`c' = string(r(mean), "%12.0fc")
    quietly summarize comp_firms if row_type == "all" & col == `c', meanonly
    local nc`c' = string(r(mean), "%12.0fc")
    quietly summarize rows if row_type == "all" & col == `c', meanonly
    local nr`c' = string(r(mean), "%12.0fc")
    quietly count if row_type == "start_year" & col == `c' & !missing(b)
    local ng`c' = string(r(N))
}
local fe_f = cond(strpos(" `ab_st' ", " firm_id "), "Yes", "No")
local fe_y = cond(strpos(" `ab_st' ", " year "), "Yes", "No")
local clu  = cond("`cl_st'" == "firm_id", "Firm", "`cl_st'")
post `P' ("Before-acquisition test, joint p")                  ("`bp1'") ("`bp2'") ("`bp3'") ("`bp4'") ("`bp5'")
post `P' ("Acquisition years with an estimate")                ("`ng1'") ("`ng2'") ("`ng3'") ("`ng4'") ("`ng5'")
post `P' ("Acquirers used") ("`ns1'") ("`ns2'") ("`ns3'") ("`ns4'") ("`ns5'")
post `P' ("Never-foreign firms") ("`nc1'") ("`nc2'") ("`nc3'") ("`nc4'") ("`nc5'")
post `P' ("Observations (firm-years, stacked)") ("`nr1'") ("`nr2'") ("`nr3'") ("`nr4'") ("`nr5'")
post `P' ("Firm and year fixed effects") ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'") ("`fe_f'")
post `P' ("Own marker for the year just before")               ("No") ("Yes") ("No") ("No") ("No")
post `P' ("Weights of the averages")                           ("Acquirers") ("Acquirers") ("Acquirers") ("Acquirers") ("Acquirers")
post `P' ("Standard errors clustered by")                      ("`clu'") ("`clu'") ("`clu'") ("`clu'") ("`clu'")
postclose `P'
use `R', clear
local rsub "Outcome: ln(GJ / value added). Log points; standard errors in parentheses; [% = 100 × (exp(b) − 1)] for the averages."
local rnote "Notes: Each acquisition-year cell = one regression of the log outcome on a from-the-acquisition-on marker with firm and year fixed"
local rnote "`rnote' effects (fixed effects per acquisition year): that year's acquirers seen before and from it (`minfirms'+ needed) and all firms never"
local rnote "`rnote' seen 10%+ foreign-owned, calendar years `=-`wlo'' before to `whi' after. (1) vs all years before (dots, black diamonds); (2) the year"
local rnote "`rnote' just before gets its own marker, so the base is years `wlo' to -2 (gray squares; `minfirms'+ acquirers with such a year); (3) energy"
local rnote "`rnote' records in doubt kept; (4) acquisitions up to `acq_paris' seen only up to `acq_paris'; (5) only acquirers seen below 10% the year"
local rnote "`rnote' just before. Averages: the regressions stacked, weighted by acquirers used. Before-acquisition test: each year before vs the"
local rnote "`rnote' last one before it, averaged over acquisition years, all zero. Standard errors clustered by firm. No stars."
if "`same2'" != "" local rnote "`rnote' In (2), `same2' equals (1): no row in the year just before (no annual file)."
ctable_pdf t_lab t1 t2 t3 t4 t5 using "`rtab'", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Acquisition year or average" "(1)|Main, vs all|years before" "(2)|Main, vs|years `wlo' to -2" ///
        "(3)|Records in|doubt kept" "(4)|Up to `acq_paris'|seen to `acq_paris'" "(5)|Exact|dates only") ///
    right(2 3 4 5 6) rules(`nterm' `=`nterm' + `navg'') fontsize(8.5) perpage(48) ///
    notes("`rnote'" "`srcnote' `devnote'")
display "table -> `rtab'"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
