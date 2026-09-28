/*==========================================================================
  R7-05  After a firm gets a foreign owner, does it grow (more value added,
         output, workers, energy used) or use energy differently (energy
         per unit of value added or output, fuel mix)? Totals and per-unit
         measures side by side, each measured against the year before the
         acquisition AND against the earlier years before it.
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" - Notes "... menurunkan energy intensity ..., meski
         total energy meningkat karena scale expansion" (we report our own
         numbers; the before/after-Paris split is Figure R7-06).
  Output : figures/05_scale_vs_intensity.png (+ .pdf)
           tables/05_scale_vs_intensity.csv (12 measures x every year since
           the acquisition, plus the two averages drawn)
           tables/05_scale_vs_intensity_table.pdf (every plotted point)
           tables/05_scale_vs_intensity_regression.pdf (the regressions
           behind the chart, AER style)
  Needs  : Stata add-ons from SSC, installed once (the file never installs or
         updates anything): ssc install reghdfe, ssc install ftools,
         ssc install require.
  Model  : the event study of 04_energy_per_va_acquisition.do, main version
         (firm and year fixed effects, standard errors clustered by firm, one
         marker per year since the acquisition, grouped ends), run once per
         measure. Drawn: the average of years 0..+K against the year before
         (as R7-04) and against the average of years -K..-2 (R7-04's check:
         part of a change can start before the acquisition).
  Acquisition dates: the ACQUISITION REGISTRY block of 01_acquisition_registry.do,
         copied unchanged (R2-08's rule A, 10%+, every 2020 answer unknown).
  Sample and window: the R7 SAMPLE AND WINDOW block of 02_acquisition_support.do,
         copied unchanged (usable rows, energy records in doubt, years -K..+K).
  Checks : in logs, energy per unit of value added = energy used minus value
         added (and the same for output and CO2): the coefficients must add up
         marker by marker (asserted to 1e-6 when the samples are the same).
         Energy and CO2 per unit of value added must equal R7-04's main
         version when tables/04_energy_per_va_acquisition.csv is present
         (warns, never stops).
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
local exhibit "R7-05"
local fname   "05_scale_vs_intensity"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: size, energy used and energy per unit of value added after a foreign acquisition ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load ownership, trade status, energy (fuels, electricity), CO2, value added, output, workers; date each acquisition"
*---------------------------------------------------------------------------
* foreign_ownership_pct = share of the firm's capital held by foreign owners (0-100 %)
* fdi_10_flag           = 1 if that share is 10% or more
* export_flag, import_flag = exports / imports reported (1 yes, 0 no; export often
*                         unknown); used by the registry and to find doubtful records
* total_gj_s1           = energy used in GJ = gj_fuel_s1 + gj_electricity
* gj_fuel_s1            = GJ of the nine fuels burned in the firm
* gj_electricity        = GJ of electricity bought (own generation is not in it)
* co2_total_s1          = CO2 tonnes from the same fuels and electricity (standard factors)
* value_added_nominal   = value added, current prices (masked money unit)
* gross_output_nominal  = output value, current prices (masked money unit)
* workers               = persons employed
use firm_id year foreign_ownership_pct fdi_10_flag export_flag import_flag ///
    total_gj_s1 gj_fuel_s1 gj_electricity co2_total_s1 ///
    value_added_nominal gross_output_nominal workers using "$DATA", clear
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
local nout = `whi' + 1                                  // first grouped year on each side

*---------------------------------------------------------------------------
display "Step 3/8: the twelve measures, and the rows each one has to leave out"
*---------------------------------------------------------------------------
* Acquirers back below 10% at their next answer (they stay acquirers here).
egen byte ftag = tag(firm_id)
quietly count if ftag & !missing(acq_stays)
local n_later = r(N)
quietly count if ftag & acq_stays == 0
local n_back = r(N)
drop ftag
* Main R7 sample (the block's acq_main): energy, CO2 and value added above zero,
* energy records in doubt left out, acquirers and firms never seen 10%+ foreign-owned.
keep if acq_main
quietly count
local nmain = r(N)
* Check: energy used = fuels burned + bought electricity (so rows 10-12 split row 1).
capture assert abs(total_gj_s1 - gj_fuel_s1 - gj_electricity) <= 1e-6 * total_gj_s1
if _rc display "   WARNING: energy used is not fuels + bought electricity on every row - re-check rows 10-12"
* The twelve measures (logs, except the share in row 12). A measure that needs a
* number above zero leaves that row out; a zero is never read as "none" in a log.
*  Totals (how big the firm is and how much it uses)
gen double y1  = ln(total_gj_s1)                                    // energy used, GJ
gen double y2  = ln(co2_total_s1)                                   // CO2, tonnes
gen double y3  = ln(value_added_nominal)                            // value added
gen double y4  = ln(gross_output_nominal) if gross_output_nominal > 0 & !missing(gross_output_nominal)
gen double y5  = ln(workers) if workers > 0 & !missing(workers)     // persons employed
*  Per unit of value added or output
gen double y6  = ln(total_gj_s1 / value_added_nominal)              // = y1 - y3
gen double y7  = ln(total_gj_s1 / gross_output_nominal) if gross_output_nominal > 0 & !missing(gross_output_nominal)
gen double y8  = ln(co2_total_s1 / value_added_nominal)             // = y2 - y3
*  Fuel mix
gen double y9  = ln(co2_total_s1 / total_gj_s1)                     // = y2 - y1: moves only with the fuel mix
gen double y10 = ln(gj_fuel_s1) if gj_fuel_s1 > 0 & !missing(gj_fuel_s1)            // fuels burned, GJ
gen double y11 = ln(gj_electricity) if gj_electricity > 0 & !missing(gj_electricity) // bought electricity, GJ
gen double y12 = 100 * gj_electricity / total_gj_s1                 // bought electricity, % of energy used
local nmeas 12
* Row names and detail lines (chart and tables); group 1 totals, 2 per unit, 3 fuel mix, 4 share.
local n1  "Energy used"
local r1  "GJ: fuels burned + bought electricity"
local n2  "CO2"
local r2  "tonnes: energy used x standard factors"
local n3  "Value added"
local r3  "current prices"
local n4  "Output"
local r4  "current prices"
local n5  "Workers"
local r5  "persons employed"
local n6  "Energy per unit of value added"
local r6  "GJ ÷ value added (as Figure R7-04)"
local n7  "Energy per unit of output"
local r7  "GJ ÷ output"
local n8  "CO2 per unit of value added"
local r8  "tonnes of CO2 ÷ value added"
local n9  "CO2 per GJ of energy used"
local r9  "moves only with the fuel mix"
local n10 "Fuels burned"
local r10 "GJ; firm-years with none left out"
local n11 "Bought electricity"
local r11 "GJ; firm-years with none left out"
local n12 "Bought electricity, share of energy used"
local r12 "% of GJ"
forvalues j = 1/`nmeas' {
    quietly count if missing(y`j')
    local left`j' = r(N)
    local g`j' = cond(`j' <= 5, 1, cond(`j' <= 8, 2, cond(`j' <= 11, 3, 4)))
    display "   row `j' (`n`j''): " %6.0fc `nmain' - `left`j'' " main rows, `left`j'' left out (not above zero)"
}
* Years since the acquisition and the markers (as R7-04): one per year -K..+K
* except -1 (the reference), and one per grouped end.
gen int kA = year - acq_year
gen byte never = acq_key == 9001
assert never == missing(acq_year)                   // comparison = never seen 10%+ only
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
gen byte ev_ref = (kA == -1)

*---------------------------------------------------------------------------
display "Step 4/8: one event study per measure (firm and year fixed effects, clustered by firm)"
*---------------------------------------------------------------------------
* Each measure on one marker per year since the acquisition (-1 = the year before
* = reference, 0 by definition; years beyond the window grouped at the two ends),
* removing each firm's own average (firm fixed effects) and each calendar year's
* average (year fixed effects). Firms never seen 10%+ foreign-owned are 0 on every
* marker. A firm with one usable year cannot be compared with itself; reghdfe
* drops it. b = log difference (points for row 12) from the acquirers' year
* before the acquisition, net of the comparison firms' change.
* Two averages are drawn for every measure:
*   black = years 0..+K minus the year before (-1), as in R7-04;
*   gray  = years 0..+K minus the average of years -K..-2 (the earlier years
*           before): if the measure was already moving before the acquisition,
*           the two differ, and the move cannot come from the new owner.
tempfile est sums
tempname h s
postfile `h' byte outcome str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows) using `est'
postfile `s' byte outcome long(n_rows n_firms n_acquirers n_comparison n_one_year_dropped n_main_left_out ///
    n_acq_post n_acq_ref n_acq_early) double(before_F before_df before_p before_p_no_grouped ///
    avg_b avg_se avg_lo avg_hi avg_p pp_b pp_se pp_lo pp_hi pp_p) using `sums'
forvalues o = 1/`nmeas' {
    * markers with at least one acquirer row for this measure
    local terms ""
    local pre ""
    local pre_in ""
    local post ""
    foreach t of local cand {
        quietly count if `t' & !missing(y`o')
        if r(N) == 0 continue
        local terms `terms' `t'
        if "`t'" == "ev_lo" | substr("`t'", 4, 1) == "m" local pre `pre' `t'
        if substr("`t'", 4, 1) == "m" local pre_in `pre_in' `t'      // before, grouped end left out
        if "`t'" != "ev_hi" & "`t'" != "ev_lo" & substr("`t'", 4, 1) == "p" local post `post' `t'
    }
    local lc = subinstr("`post'", " ", " + ", .)        // years 0..+K, for the average
    local np : word count `post'
    local lcp = subinstr("`pre_in'", " ", " + ", .)     // years -K..-2, for the gray average
    local npi : word count `pre_in'
    quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
    local df = e(df_r)
    local N  = e(N)
    local sg = e(num_singletons)
    capture drop es
    gen byte es = e(sample)
    * Joint test: all years before the acquisition are 0 (with / without the grouped end).
    quietly test `pre'
    local bF = r(F)
    local bd = r(df)
    local bp = r(p)
    quietly test `pre_in'
    local bq = r(p)
    * Black: average of years 0..+K (against the year before, the reference).
    quietly lincom (`lc') / `np'
    local ab = r(estimate)
    local ase = r(se)
    local alo = r(estimate) - invttail(`df', 0.025) * r(se)
    local ahi = r(estimate) + invttail(`df', 0.025) * r(se)
    local ap = 2 * ttail(`df', abs(r(estimate) / r(se)))
    * Gray: the same average minus the average of the earlier years before (-K..-2).
    quietly lincom (`lc') / `np' - (`lcp') / `npi'
    local qb = r(estimate)
    local qse = r(se)
    local qlo = r(estimate) - invttail(`df', 0.025) * r(se)
    local qhi = r(estimate) + invttail(`df', 0.025) * r(se)
    local qp = 2 * ttail(`df', abs(r(estimate) / r(se)))
    * Firms in the estimate, and acquirers behind each average.
    egen byte ftag = tag(firm_id) if es
    quietly count if ftag & !never
    local st = r(N)
    quietly count if ftag & never
    local cf = r(N)
    quietly count if ftag
    local G = r(N)
    drop ftag
    foreach w in post ref early {
        if "`w'" == "post"  local kc "inrange(kA, 0, `whi')"
        if "`w'" == "ref"   local kc "kA == -1"
        if "`w'" == "early" local kc "inrange(kA, `wlo', -2)"
        egen byte ftag = tag(firm_id) if es & !never & `kc'
        quietly count if ftag == 1
        local na_`w' = r(N)
        drop ftag
    }
    post `s' (`o') (`N') (`G') (`st') (`cf') (`sg') (`left`o'') (`na_post') (`na_ref') (`na_early') ///
        (`bF') (`bd') (`bp') (`bq') (`ab') (`ase') (`alo') (`ahi') (`ap') (`qb') (`qse') (`qlo') (`qhi') (`qp')
    foreach t in `cand' ev_ref {
        if "`t'" == "ev_lo"       local k = `wlo' - 1
        else if "`t'" == "ev_hi"  local k = `whi' + 1
        else if "`t'" == "ev_ref" local k = -1
        else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
        * acquirers behind each marker (a firm counts once in a grouped end)
        egen byte ft = tag(firm_id) if es & `t'
        quietly count if ft == 1
        local nf = r(N)
        quietly count if es & `t'
        local nr = r(N)
        drop ft
        local grp = inlist("`t'", "ev_lo", "ev_hi")
        if "`t'" == "ev_ref" {
            post `h' (`o') ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr')
        }
        else if !`: list t in terms' | `nr' == 0 {
            post `h' (`o') ("`t'") (`k') (`grp') (0) (.) (.) (.) (.) (.) (0) (0)
        }
        else {
            local b  = _b[`t']
            local se = _se[`t']
            post `h' (`o') ("`t'") (`k') (`grp') (0) (`b') (`se') ///
                (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr')
        }
    }
    display "   row `o' (`n`o''): " %6.0fc `N' " rows, `st' acquirers, `cf' comparison firms"
}
postclose `h'
postclose `s'

*---------------------------------------------------------------------------
display "Step 5/8: plotted values, the add-up check, the R7-04 cross-check and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
merge m:1 outcome using `sums', nogenerate assert(match)
gen str50 outcome_label = ""
gen str50 outcome_detail = ""
gen byte group = .
forvalues j = 1/`nmeas' {
    replace outcome_label  = "`n`j''" if outcome == `j'
    replace outcome_detail = "`r`j''" if outcome == `j'
    replace group = `g`j'' if outcome == `j'
}
label define grp 1 "Totals" 2 "Per unit of value added or output" 3 "Fuel mix" 4 "Share of energy used"
label values group grp
gen str40 model_unit = cond(outcome == 12, "percentage points of energy used", "log points")
gen str24 plot_unit  = cond(outcome == 12, "percentage points", "% difference")
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if term == "ev_lo"
replace column = "+`nout' or later (grouped)"      if term == "ev_hi"
* Plotted value: logs as % difference = 100 x (exp(b) - 1) (interval ends the same
* way); the share (row 12) in percentage points as estimated.
foreach v in "" _lo _hi {
    local src = cond("`v'" == "", "b", substr("`v'", 2, .))
    gen double plotted`v' = cond(outcome == 12, `src', 100 * (exp(`src') - 1))
}
foreach m in avg pp {
    gen double `m'_plotted    = cond(outcome == 12, `m'_b,  100 * (exp(`m'_b)  - 1))
    gen double `m'_plotted_lo = cond(outcome == 12, `m'_lo, 100 * (exp(`m'_lo) - 1))
    gen double `m'_plotted_hi = cond(outcome == 12, `m'_hi, 100 * (exp(`m'_hi) - 1))
}
* Add-up check: in logs, per-unit measure = total minus total, so on the same rows
* the coefficients must add up exactly (both averages too): 6 = 1 - 3, 7 = 1 - 4,
* 8 = 2 - 3, 9 = 2 - 1. Checked only when the three measures use the same rows.
gen str40 addup_check = ""
preserve
keep outcome event_time b avg_b pp_b n_rows n_firms
reshape wide b avg_b pp_b n_rows n_firms, i(event_time) j(outcome)
local addup ""
foreach c in "6 1 3" "7 1 4" "8 2 3" "9 2 1" {
    tokenize `c'
    capture assert n_rows`1' == n_rows`2' & n_rows`2' == n_rows`3' & n_firms`1' == n_firms`2' & n_firms`2' == n_firms`3'
    if _rc {
        display "   add-up check `1' = `2' - `3': skipped (the measures use different rows)"
        local addup `addup' `1':skipped
        continue
    }
    foreach v in b avg_b pp_b {
        assert abs(`v'`1' - (`v'`2' - `v'`3')) <= 1e-6 if !missing(`v'`1')
    }
    display "   add-up check: row `1' = row `2' minus row `3' at every marker and in both averages (to 1e-6)"
    local addup `addup' `1':ok
}
restore
foreach a of local addup {
    gettoken j rest : a, parse(":")
    local res = substr("`rest'", 2, .)
    local pr = cond(`j' == 6, "1 - 3", cond(`j' == 7, "1 - 4", cond(`j' == 8, "2 - 3", "2 - 1")))
    replace addup_check = cond("`res'" == "ok", "equals row `pr' (1e-6)", "not checked: rows differ") if outcome == `j'
}
* Cross-check with R7-04 (when its table is present): rows 6 and 8 are R7-04's
* main version (outcomes 1 and 2), same sample and window. Warns, never stops.
gen str40 r7_04_check = "R7-04 table not found"
local r4f "tables/04_energy_per_va_acquisition.csv"
capture confirm file "`r4f'"
if !_rc {
    preserve
    import delimited using "`r4f'", clear varnames(1) bindquote(strict) maxquotedrows(unlimited)
    keep if version == 1 & inlist(outcome, 1, 2) & !missing(event_time)
    local r4w = window_first[1]
    replace outcome = cond(outcome == 1, 6, 8)
    keep outcome event_time b avg_b
    rename (b avg_b) (b_r4 avg_b_r4)
    tempfile r4
    save `r4'
    restore
    if `r4w' != `wlo' {
        display "   WARNING: R7-04 used another window (`r4w'); no cross-check"
        replace r7_04_check = "R7-04 used another window" if inlist(outcome, 6, 8)
    }
    else {
        merge 1:1 outcome event_time using `r4', keep(master match)
        gen byte r4_same = abs(b - b_r4) <= 0.00005 + 1e-9 & abs(avg_b - avg_b_r4) <= 0.00005 + 1e-9 ///
            if _merge == 3 & !missing(b)
        quietly count if r4_same == 1
        local r4ok = r(N)
        quietly count if r4_same == 0
        local r4bad = r(N)
        if `r4bad' > 0 display "   WARNING: `r4bad' coefficients differ from R7-04's (`r4ok' agree) - re-check the two files"
        else display "   cross-check: all `r4ok' compared coefficients (and averages) equal R7-04's main version (4 decimals)"
        replace r7_04_check = cond(r4_same == 1, "equals R7-04 main", "DIFFERS from R7-04 main") if !missing(r4_same)
        drop _merge b_r4 avg_b_r4 r4_same
    }
}
replace r7_04_check = "" if !inlist(outcome, 6, 8)
gen int window_first = `wlo'
gen int window_last  = `whi'
gen long main_rows = `nmain'
gen long acquirers_with_later_answer = `n_later'
gen long acquirers_back_below_10     = `n_back'
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference == 1
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "No acquirer row for this measure" if !reference & missing(b)
rename (pp_b pp_se pp_lo pp_hi pp_p) (prepost_b prepost_se prepost_lo prepost_hi prepost_p)
rename (pp_plotted pp_plotted_lo pp_plotted_hi) (prepost_plotted prepost_plotted_lo prepost_plotted_hi)
sort outcome event_time
order outcome outcome_label outcome_detail group model_unit plot_unit column event_time grouped reference ///
      b se lo hi p plotted plotted_lo plotted_hi firms rows ///
      n_rows n_firms n_acquirers n_comparison n_one_year_dropped main_rows n_main_left_out ///
      before_F before_df before_p before_p_no_grouped ///
      avg_b avg_se avg_lo avg_hi avg_p avg_plotted avg_plotted_lo avg_plotted_hi n_acq_post n_acq_ref ///
      prepost_b prepost_se prepost_lo prepost_hi prepost_p prepost_plotted prepost_plotted_lo prepost_plotted_hi n_acq_early ///
      window_first window_last acquirers_with_later_answer acquirers_back_below_10 addup_check r7_04_check note
drop term
format b se lo hi avg_b avg_se avg_lo avg_hi prepost_b prepost_se prepost_lo prepost_hi before_F %9.4f
format plotted plotted_lo plotted_hi avg_plotted avg_plotted_lo avg_plotted_hi ///
    prepost_plotted prepost_plotted_lo prepost_plotted_hi %9.2f
format p before_p before_p_no_grouped avg_p prepost_p %9.3f
format firms rows n_rows n_firms n_acquirers n_comparison n_one_year_dropped main_rows n_main_left_out ///
    n_acq_post n_acq_ref n_acq_early before_df acquirers_* %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile res                       // same numbers, full precision, for the chart and tables
save `res'
list outcome outcome_label n_rows n_acquirers before_p avg_plotted avg_plotted_lo avg_plotted_hi ///
    prepost_plotted prepost_plotted_lo prepost_plotted_hi if event_time == 0, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
keep if event_time == 0                                 // one row per measure
sort outcome
forvalues j = 1/`nmeas' {
    local u = cond(`j' == 12, " points", "%")
    foreach m in avg prepost {
        local k = cond("`m'" == "avg", "a", "q")
        quietly summarize `m'_plotted if outcome == `j'
        local v = r(mean)
        local `k'`j' = cond(round(`v') > 0, "+", "") + string(round(`v'), "%9.0f") + "`u'"
        quietly summarize `m'_plotted_lo if outcome == `j'
        local l = r(mean)
        quietly summarize `m'_plotted_hi if outcome == `j'
        local c`k'`j' = cond(`l' > 0 | r(mean) < 0, "clear", "not clear")
    }
    quietly summarize before_p if outcome == `j'
    local bp`j' = r(mean)
    quietly summarize prepost_b if outcome == `j'
    local qs`j' = sign(r(mean))
    local qb`j' = r(mean)
}
* The reading, built from the data. (1) Against the year before.
local rd1 "Reading: against the year before, acquirers' energy used changes by `a1' (`ca1'), value added by `a3' (`ca3') and energy per unit of value added by `a6' (`ca6')."
if "`ca1'" == "not clear" & "`ca3'" == "not clear" & "`ca6'" == "not clear" ///
    local rd1 "Reading: against the year before, nothing is clear: energy used `a1', value added `a3', energy per unit of value added `a6'."
* (2) Against the earlier years before. In logs energy per unit of value added =
* energy used minus value added exactly, so say which of the two moves it more.
local vadrv = abs(`qb3') > abs(`qb1')
if `vadrv' local rd2 "Against the earlier years before, energy per unit of value added is `q6' (`cq6'), mostly because value added is `q3' (`cq3') while energy used is `q1' (`cq1')."
else local rd2 "Against the earlier years before, energy per unit of value added is `q6' (`cq6'), mostly because energy used is `q1' (`cq1') while value added is `q3' (`cq3')."
* (3) Only when the data say so: value added was already moving before the
* acquisition (joint test clear) in the direction of the gray average.
local vamove ""
if `bp3' < 0.05 & "`cq3'" == "clear" {
    local dir = cond(`qs3' > 0, "rising", "falling")
    local pv = cond(`bp3' < 0.001, "p < 0.001", "p = " + string(`bp3', "%5.3f"))
    if `vadrv' & `qs3' > 0 & `qs6' < 0 local vamove " Value added was already rising before the acquisition (years before: `pv'), so this lower energy per unit of value added is not a sign that the new owner made the firm greener."
    else local vamove " Value added was already `dir' before the acquisition (years before: `pv'), so that change cannot come from the new owner."
}
* The doubtful years as text: runs of consecutive files joined by a dash (R2-08's code).
local runs ""
local r0 ""
local rp ""
foreach yy of local acq_doubt_yrs {
    local nxt = `rp' + 1
    if "`r0'" != "" & `yy' == `nxt' local rp `yy'
    else {
        if "`r0'" != "" local runs `"`runs' "`=cond(`rp' > `r0', "`r0'–`rp'", "`r0'")'""'
        local r0 `yy'
        local rp `yy'
    }
}
local runs `"`runs' "`=cond(`rp' > `r0', "`r0'–`rp'", "`r0'")'""'
local nr : word count `runs'
local dtxt ""
forvalues j = 1/`nr' {
    local rj : word `j' of `runs'
    local sep = cond(`j' == 1, "", cond(`j' == `nr', " and ", ", "))
    local dtxt "`dtxt'`sep'`rj'"
}
local n_back_c  = strtrim(string(`n_back', "%9.0fc"))
local n_later_c = strtrim(string(`n_later', "%9.0fc"))
local nmain_c   = strtrim(string(`nmain', "%9.0fc"))
local left10_c  = strtrim(string(`left10', "%9.0fc"))
local left11_c  = strtrim(string(`left11', "%9.0fc"))
display "   energy used `a1' (`ca1') / `q1' (`cq1'); value added `a3' (`ca3') / `q3' (`cq3'); energy per VA `a6' (`ca6') / `q6' (`cq6')"

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart: (a) % change of eleven measures, (b) electricity share in points"
*---------------------------------------------------------------------------
* Row positions (top to bottom), a section header above each group.
gen double ypos = .
local yy 19.3 17.85 16.4 14.95 13.5 11.1 9.65 8.2 5.8 4.35 2.9 1
forvalues j = 1/`nmeas' {
    local w : word `j' of `yy'
    replace ypos = `w' if outcome == `j'
}
gen str8 panel = cond(outcome == 12, "b", "a")
gen double ygr = ypos - 0.5                             // gray square: just under its row
gen double ysub = ypos - 0.5                            // second line of the row name
replace ypos = ypos + 0.12                              // black dot, row name: a little up, so the two lines never touch
gen str60 nm  = outcome_label
gen str60 sub = outcome_detail
* Value labels at the right end of each interval: whole % (panel a), one decimal (b).
gen str12 lbl  = cond(round(avg_plotted) > 0, "+", "") + string(round(avg_plotted), "%9.0f") + "%" if panel == "a"
gen str12 lblg = cond(round(prepost_plotted) > 0, "+", "") + string(round(prepost_plotted), "%9.0f") + "%" if panel == "a"
replace lbl  = cond(round(avg_plotted, 0.1) > 0, "+", "") + string(avg_plotted, "%9.1f") if panel == "b"
replace lblg = cond(round(prepost_plotted, 0.1) > 0, "+", "") + string(prepost_plotted, "%9.1f") if panel == "b"
* Right-hand columns: firms compared, and the joint test of the years before.
gen str24 cnt = string(n_acquirers, "%9.0fc") + " / " + string(n_comparison, "%9.0fc")
gen str12 bpt = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f"))
* Section headers and column headers.
gen double yhdr = .
gen str60 hdr = ""
replace yhdr = ypos + 0.9  if outcome == 1
replace hdr  = "Totals: size and energy used" if outcome == 1
replace yhdr = ypos + 0.9  if outcome == 6
replace hdr  = "Per unit of value added or output" if outcome == 6
replace yhdr = ypos + 0.9  if outcome == 9
replace hdr  = "Fuel mix" if outcome == 9
replace yhdr = ypos + 0.9  if outcome == 12
gen str40 hdr2 = "Acquirers / comparison" if inlist(outcome, 1, 12)
gen str40 hdr3 = "Years before, p" if inlist(outcome, 1, 12)
local notes ""
foreach pn in a b {
    quietly summarize avg_plotted_lo if panel == "`pn'"
    local xmin = min(r(min), 0)
    quietly summarize avg_plotted_hi if panel == "`pn'"
    local xmax = max(r(max), 0)
    quietly summarize prepost_plotted_lo if panel == "`pn'"
    local xmin = min(`xmin', r(min))
    quietly summarize prepost_plotted_hi if panel == "`pn'"
    local xmax = max(`xmax', r(max))
    local rng = `xmax' - `xmin'
    local step = 10^floor(log10(`rng'))
    if `rng'/`step' < 2       local step = `step'/5
    else if `rng'/`step' < 5  local step = `step'/2
    if `rng'/`step' > 6       local step = `step'*2
    local xbot = `step' * floor(`xmin'/`step')
    local xtop = `step' * ceil(`xmax'/`step')
    local xfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
    local xlab ""
    forvalues x = `xbot'(`step')`=`xtop' + `step'/2' {
        local s = cond(round(`x', `step'/10) > 0, "+", "") + strtrim(string(round(`x', `step'/10), "`xfmt'")) + cond("`pn'" == "a", "%", "")
        if abs(`x') < `step'/10 local s "0"
        local xlab `"`xlab' `x' "`s'""'
    }
    local xtt = cond("`pn'" == "a", "% change, acquirers minus comparison firms", "Change in percentage points, acquirers minus comparison firms")
    local span = `xtop' - `xbot'
    local xn  = `xbot' - 1.25 * `span'                  // row names start here (left-aligned)
    local xc  = `xtop' + 0.26 * `span'                  // column: firms compared
    local xp  = `xtop' + 0.93 * `span'                  // column: years before, p
    local xr  = `xtop' + 1.24 * `span'
    capture drop xnm xcc xpp zy0 zy1 zx
    gen double xnm = `xn'
    gen double xcc = `xc'
    gen double xpp = `xp'
    quietly summarize ypos if panel == "`pn'"
    gen double zy0 = r(min) - 0.8 if outcome == cond("`pn'" == "a", 1, 12)
    gen double zy1 = r(max) + 0.4 if !missing(zy0)
    gen double zx  = 0 if !missing(zy0)
    local ylo = r(min) - 0.95
    local yhi = r(max) + 1.3
    if "`pn'" == "a" {
        local ptl "(a) Eleven measures: average % change in years 0 to +`whi' since the acquisition"
        local leg "legend(off)"
    }
    else {
        local ptl "(b) Bought electricity as a share of energy used: average change in percentage points"
        local leg `"legend(order(4 "Against the year before (-1), as in Figure R7-04" 5 "Against the earlier years before (`wlo' to -2)" 2 "95% interval" 1 "0 = no difference") cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3))"'
    }
    twoway (pcspike zy0 zx zy1 zx if panel == "`pn'", lcolor(gs8) lwidth(thin)) ///
        (rspike avg_plotted_lo avg_plotted_hi ypos if panel == "`pn'", horizontal lcolor(black) lwidth(thin)) ///
        (rspike prepost_plotted_lo prepost_plotted_hi ygr if panel == "`pn'", horizontal lcolor(gs9) lwidth(thin)) ///
        (scatter ypos avg_plotted if panel == "`pn'", msymbol(O) msize(small) mcolor(black)) ///
        (scatter ygr prepost_plotted if panel == "`pn'", msymbol(Sh) msize(small) mcolor(gs7)) ///
        (scatter ypos avg_plotted_hi if panel == "`pn'", msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(1) ///
            mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ygr prepost_plotted_hi if panel == "`pn'", msymbol(none) mlabel(lblg) mlabposition(3) mlabgap(1) ///
            mlabsize(vsmall) mlabcolor(gs6)) ///
        (scatter ypos xnm if panel == "`pn'", msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ysub xnm if panel == "`pn'", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs7)) ///
        (scatter ypos xcc if panel == "`pn'", msymbol(none) mlabel(cnt) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter ypos xpp if panel == "`pn'", msymbol(none) mlabel(bpt) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter yhdr xnm if panel == "`pn'" & hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter yhdr xcc if panel == "`pn'" & hdr2 != "", msymbol(none) mlabel(hdr2) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter yhdr xpp if panel == "`pn'" & hdr3 != "", msymbol(none) mlabel(hdr3) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        , xscale(range(`xn' `xr') noline) ///
        xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1) grid glcolor(gs14) glwidth(vthin)) ///
        xtitle("`xtt'", size(vsmall) margin(t+1)) ///
        yscale(range(`ylo' `yhi') off) ylabel(none) ytitle("") ///
        subtitle("`ptl'", size(small) position(11) justification(left) margin(b+1)) ///
        `leg' graphregion(color(white) lcolor(white) margin(r+2 l+1)) plotregion(style(none) margin(zero)) ///
        fysize(`=cond("`pn'" == "a", 100, 40)') name(p`pn', replace) nodraw
}
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: `rd1' `rd2'`vamove' Black dots = average of years 0 to +`whi' minus the year before (-1); gray squares = the same years"
local txt "`txt' minus the average of years `wlo' to -2. Firm and year effects; bars = 95% intervals (crossing 0 = not clear); 'Years before': p"
local txt "`txt' below 0.05 = already changing differently before (a warning sign). Acquisition = first year with 10%+ foreign-owned capital"
local txt "`txt' after a year below 10% (a reported share, not a verified purchase; it stays an acquirer if the share falls back: `n_back_c' of"
local txt "`txt' `n_later_c'). Energy records in doubt left out (importers of unknown export status in `dtxt'). Value added = output value minus"
local txt "`txt' materials, energy and services bought (current prices); GJ = gigajoules; CO2 = energy used x standard factors, not measured."
local txt "`txt' This cannot show which equipment or process changed. Firm links are fictional: a test of the method only."
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
forvalues j = 1/`nl' {
    display "   note line `j': " udstrlen(`"`L`j''"') " characters, width " %4.1f `W`j'' " of `maxw' em"
    local notes `"`notes' "`L`j''""'
}
graph combine pa pb, cols(1) iscale(1) imargin(zero) ///
    title("Figure `exhibit'. Size, energy used and energy per unit of value added after a firm gets a foreign owner", ///
        size(small) position(11) justification(left) span) ///
    subtitle("Acquirers minus firms never seen 10%+ foreign-owned; black: against the year before, gray: against the earlier years before", ///
        size(vsmall) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) xsize(9) ysize(12) scale(`=7.5/9')      // text as in R2-08 (9 in, scale 7.5/9)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the chart"
*---------------------------------------------------------------------------
* Both tables are built from the numbers saved in Step 5 (the CSV's numbers),
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
local ftitle "Size, energy used and energy per unit of value added after a firm gets a foreign owner"
* (1) Points table: every drawn point, row by row from the top of the chart; in
* each row the black dot first, then the gray square.
use `res', clear
keep if event_time == 0                                 // one line per measure holds both averages
sort outcome
expand 2
bysort outcome: gen byte mark = _n                      // 1 = black dot, 2 = gray square
sort outcome mark
gen str4  c_panel = cond(outcome == 12, "(b)", "(a)")
gen str60 c_row = cond(outcome == 12, "Bought electricity share (points)", outcome_label)
gen str40 c_ser = cond(mark == 1, "Vs the year before (black)", "Vs years `wlo' to -2 (gray)")
gen double v  = cond(mark == 1, avg_plotted,    prepost_plotted)
gen double vl = cond(mark == 1, avg_plotted_lo, prepost_plotted_lo)
gen double vh = cond(mark == 1, avg_plotted_hi, prepost_plotted_hi)
* rounded as the chart labels: whole % in panel (a), one decimal (points) in (b);
* the interval ends are not labelled on the chart and get the same rounding
foreach x in v vl vh {
    gen str14 c_`x' = cond(round(`x') > 0, "+", "") + string(round(`x'), "%9.0f") + "%" if outcome != 12
    replace c_`x'   = cond(round(`x', 0.1) > 0, "+", "") + string(`x', "%9.1f") if outcome == 12
}
gen str10 c_npost = string(n_acq_post, "%9.0fc")
gen str10 c_nbase = string(cond(mark == 1, n_acq_ref, n_acq_early), "%9.0fc")
gen str10 c_ncomp = string(n_comparison, "%9.0fc")
gen str10 c_nrows = string(n_rows, "%9.0fc")
gen str10 c_bp    = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f"))
gen str40 c_st = cond(mark == 1, "black dot, bar, label", "gray square, bar, label")
quietly count
local npts = r(N)
assert `npts' == 2 * `nmeas'                            // every drawn point, once
local rule1 = 2 * (`nmeas' - 1)                          // line under panel (a)
local nnote = subinstr(`"`txt'"', "Notes: ", "Chart notes: ", 1)
order c_panel c_row c_ser c_v c_vl c_vh c_npost c_nbase c_ncomp c_nrows c_bp c_st
ctable_pdf c_panel c_row c_ser c_v c_vl c_vh c_npost c_nbase c_ncomp c_nrows c_bp c_st using "`ptab'", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Average of years 0 to +`whi' since the acquisition, acquirers minus firms never seen 10%+ foreign-owned (firm and year effects)") ///
    header("Panel" "Row on the chart" "Series (legend)" "Plotted|value" "95% interval|low" "95% interval|high" ///
        "Acquirers|in 0 to +`whi'" "Acquirers|in base|years" "Never|foreign|firms" "Firm-|years" ///
        "Years|before p" "Status") ///
    right(4 5 6 7 8 9 10 11) norepeat(1 2) rules(`rule1') fontsize(8.5) perpage(20) ///
    notes("Plotted value: panel (a) % difference = 100 x (exp(b) - 1) of the average coefficient in the regression table (the average of years 0 to +`whi' against the year before, or that average minus the average of years `wlo' to -2); panel (b) percentage points as estimated. Rounded as the chart labels. Row details (units) as on the chart; firm-years with no fuels burned or no bought electricity left out of those rows: `left10_c' and `left11_c' of the `nmain_c' main firm-years. Acquirers in 0 to +`whi' = acquirers with a row in those years; base years = acquirers with a row in the year before (black) or in years `wlo' to -2 (gray). Never foreign firms = comparison firms (never seen 10%+ foreign-owned) in the model; firm-years = all in the model (firms with one usable year dropped). Years before, p = joint test that every year before the acquisition is 0. Year by year: tables/`fname'.csv." ///
        `"`nnote'"' "`srcnote'" "`devnote'")
display "table -> `ptab' (`npts' plotted points)"

* (2) Regression table (AER style): one column per measure, coefficient on the
* first line, (standard error) on the second; the two averages drawn on the
* chart add a third line [% difference] for the log measures.
use `res', clear
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep outcome event_time b avg_b prepost_b
rename (b avg_b prepost_b) (b_csv avg_csv pp_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 outcome event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert abs(avg_b - avg_csv) <= 0.00005 + 1e-9 & abs(prepost_b - pp_csv) <= 0.00005 + 1e-9
drop b_csv avg_csv pp_csv
tempname P
tempfile R
postfile `P' str60 t_lab str24(t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12) using `R'
levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k' & outcome == 1, meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k' & outcome == 1, meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    if `rf' {
        post `P' ("`lab' (reference, set to 0)") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—")
        local ++nterm
        continue
    }
    forvalues c = 1/`nmeas' {
        local b`c' ""
        local s`c' ""
        local d = cond(`c' == 12, "%9.2f", "%9.3f")
        quietly summarize b if event_time == `k' & outcome == `c', meanonly
        if r(N) > 0 & !missing(r(mean)) {
            local b`c' = string(r(mean), "`d'")
            quietly summarize se if event_time == `k' & outcome == `c', meanonly
            local s`c' = "(" + string(r(mean), "`d'") + ")"
        }
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'") ("`b8'") ("`b9'") ("`b10'") ("`b11'") ("`b12'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'") ("`s8'") ("`s9'") ("`s10'") ("`s11'") ("`s12'")
    local nterm = `nterm' + 2
}
* the two drawn averages, then whole-model rows (one value per measure)
foreach m in avg prepost {
    forvalues c = 1/`nmeas' {
        local d = cond(`c' == 12, "%9.2f", "%9.3f")
        quietly summarize `m'_b if outcome == `c' & event_time == 0, meanonly
        local b`c' = string(r(mean), "`d'")
        quietly summarize `m'_se if outcome == `c' & event_time == 0, meanonly
        local s`c' = "(" + string(r(mean), "`d'") + ")"
        quietly summarize `m'_plotted if outcome == `c' & event_time == 0, meanonly
        local p`c' = cond(`c' == 12, "", "[" + cond(round(r(mean), 0.1) > 0, "+", "") + string(r(mean), "%9.1f") + "%]")
    }
    local L = cond("`m'" == "avg", "Average of years 0 to +`whi' (black)", "Years 0 to +`whi' minus years `wlo' to -2 (gray)")
    post `P' ("`L'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'") ("`b8'") ("`b9'") ("`b10'") ("`b11'") ("`b12'")
    post `P' ("")    ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'") ("`s8'") ("`s9'") ("`s10'") ("`s11'") ("`s12'")
    post `P' ("")    ("`p1'") ("`p2'") ("`p3'") ("`p4'") ("`p5'") ("`p6'") ("`p7'") ("`p8'") ("`p9'") ("`p10'") ("`p11'") ("`p12'")
}
foreach v in n_rows n_firms before_p {
    forvalues c = 1/`nmeas' {
        quietly summarize `v' if outcome == `c' & event_time == 0, meanonly
        if "`v'" == "before_p" local x`c' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
        else local x`c' = strtrim(string(r(mean), "%12.0fc"))
        if "`v'" == "n_firms" {
            quietly summarize n_acquirers if outcome == `c' & event_time == 0, meanonly
            local x`c' = "`x`c''; " + strtrim(string(r(mean), "%12.0fc"))
        }
    }
    if "`v'" == "n_rows"      local L "Observations (firm-years)"
    if "`v'" == "n_firms"     local L "Firms (clusters); of which acquirers"
    if "`v'" == "before_p"    local L "Years before all 0: joint test p"
    post `P' ("`L'") ("`x1'") ("`x2'") ("`x3'") ("`x4'") ("`x5'") ("`x6'") ("`x7'") ("`x8'") ("`x9'") ("`x10'") ("`x11'") ("`x12'")
}
postclose `P'
use `R', clear
local rsub "Columns (1)-(11): log points, [% = 100 × (exp(b) − 1)] for the two averages; (12): percentage points. Firm and year fixed effects in every column; standard errors clustered by firm in parentheses; no weights."
local rnote "Notes: Each column is one regression of the measure on one marker per year since the acquisition (`wlo' to +`whi'; -1 = reference) and one per"
local rnote "`rnote' grouped end (`nout'+ years before or after), with firm and year fixed effects; firms never seen 10%+ foreign-owned are 0 on every marker;"
local rnote "`rnote' one-year firms dropped. Black / gray = the chart's two averages. (4), (5), (7), (10), (11) also need output, workers, fuels or"
local rnote "`rnote' bought electricity above zero. (6) = (1) − (3), (7) = (1) − (4), (8) = (2) − (3), (9) = (2) − (1) exactly (checked in the file);"
local rnote "`rnote' (6) and (8) = columns (1) and (5) of the R7-04 regression table. No significance stars."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 using "`rtab'", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Years since the acquisition" "(1) Energy|used" "(2) CO2" "(3) Value|added" "(4) Output" "(5) Workers" ///
        "(6) Energy|per value|added" "(7) Energy|per output" "(8) CO2 per|value added" "(9) CO2|per GJ" "(10) Fuels|burned" ///
        "(11) Bought|electricity" "(12) Electricity|share, points") ///
    right(2 3 4 5 6 7 8 9 10 11 12 13) rules(`nterm' `=`nterm' + 6') fontsize(8) perpage(48) ///
    notes("`rnote'" "`srcnote' `devnote'")
display "table -> `rtab'"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
