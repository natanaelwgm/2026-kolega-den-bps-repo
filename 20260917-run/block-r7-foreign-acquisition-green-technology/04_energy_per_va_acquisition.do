/*==========================================================================
  R7-04  Before and after a firm gets a foreign owner, does it use less
         energy, and emit less CO2, per unit of value added than firms that
         never get one? (event study; energy per value added and CO2 per
         value added, % change since the year before the acquisition)
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" - Notes "... foreign acquisition menurunkan energy
         intensity ..." (we report our own numbers; the before/after-Paris
         split is Figure R7-06).
  Output : figures/04_energy_per_va_acquisition.png (+ .pdf)
           tables/04_energy_per_va_acquisition.csv (2 outcomes x 4 versions)
           tables/04_energy_per_va_acquisition_table.pdf (every plotted point)
           tables/04_energy_per_va_acquisition_regression.pdf (the regressions
           behind the chart, AER style)
  Needs  : Stata add-ons from SSC, installed once (the file never installs or
         updates anything): ssc install reghdfe, ssc install ftools,
         ssc install require; for the Sun-Abraham check only:
         ssc install eventstudyinteract, ssc install avar (if missing, that
         version gets an "unavailable" row and the file still finishes).
  Model  : R2-03 / R2-08's event study (firm and year fixed effects, standard
         errors clustered by firm, one marker per year since the start,
         grouped ends); the start is the R7 acquisition.
  Acquisition dates: the ACQUISITION REGISTRY block of 01_acquisition_registry.do,
         copied unchanged (R2-08's rule A, 10%+, every 2020 answer unknown).
  Sample and window: the R7 SAMPLE AND WINDOW block of 02_acquisition_support.do,
         copied unchanged (usable rows, energy records in doubt, years -K..+K).
  Also   : "years 0 to +K vs years -K to -2" (panel text, CSV prepost_*,
         regression table): the years after against the earlier years before,
         because the dots before the acquisition can drift (review R7-04).
  Checks : prints a cross-check against R2-08 (foreign-owner panel) when
         ../block-r2-internationalisation-energy-efficiency/tables/
         08_efficiency_import_foreign_start.csv is present (warns, never stops).
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
local exhibit "R7-04"
local fname   "04_energy_per_va_acquisition"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy and CO2 per unit of value added before and after a foreign acquisition ==="

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
local nout = `whi' + 1                                  // first grouped year on each side

*---------------------------------------------------------------------------
display "Step 3/8: the four versions, the repairs they differ by, and records in doubt by side of the acquisition"
*---------------------------------------------------------------------------
* Versions (the figure draws 1 in black and 2 in hollow gray; 3-4 are in the tables):
*   1 main        = registry dates (every `acq_bad' ownership answer unknown),
*                   usable rows, energy records in doubt left out (acq_main)
*   2 as_filed    = every acquisition and record as filed: dates from the same
*                   rule with the `acq_bad' answers kept (acq_year_raw), comparison
*                   = firms never seen 10%+ as filed, records in doubt kept
*   3 keep_doubt  = main dates, energy records in doubt kept
*   4 sun_abraham = version 1 with acquisition years kept apart (Sun-Abraham,
*                   eventstudyinteract); acquisition years with no row in the
*                   year before (lesson 20: after a year with no file) left out
* Every version uses the R7 window -K..+K (computed on the main sample above).
egen byte ftag = tag(firm_id)
* Repairs: acquisitions dated `acq_bad' as filed, and where they go in the main version.
quietly count if ftag & acq_year_raw == `acq_bad'
local n_bad = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & acq_key == 9001
local n_bad_never = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & !missing(acq_year)
local n_bad_later = r(N)
display "   acquisitions dated `acq_bad' as filed: `n_bad' (main version: `n_bad_later' get a later year, `n_bad_never' count as never foreign-owned)"
* Acquirers back below 10% at their next answer (they stay acquirers here).
quietly count if ftag & !missing(acq_stays)
local n_later = r(N)
quietly count if ftag & acq_stays == 0
local n_back = r(N)
drop ftag
* Energy records in doubt among acquirers' usable years inside the window, before
* the acquisition (years -K..-1) and from it on (0..+K), by Paris period:
* leaving them out removes more years after the acquisition than before it.
foreach p in all 0 1 {
    local pc = cond("`p'" == "all", "1", "acq_after == `p'")
    foreach sd in pre post {
        local kc = cond("`sd'" == "pre", "inrange(acq_k, `wlo', -1)", "inrange(acq_k, 0, `whi')")
        quietly count if acq_usable & !missing(acq_year) & `kc' & `pc'
        local dn = r(N)
        quietly count if acq_usable & acq_doubt & !missing(acq_year) & `kc' & `pc'
        local ds_`p'_`sd' = 100 * r(N) / `dn'
        local plab "(all)"
        if "`p'" == "0" local plab "up to `acq_paris'"
        if "`p'" == "1" local plab "after `acq_paris'"
        display "   records in doubt, acquirers `plab', `sd': " %4.1f `ds_`p'_`sd'' "% of " `dn' " usable years in the window"
    }
}
tempfile fy est sums
save `fy'

*---------------------------------------------------------------------------
display "Step 4/8: estimate each outcome and version (firm and year fixed effects, clustered by firm)"
*---------------------------------------------------------------------------
* Log outcome on one marker per year since the acquisition (-1 = the year before
* = reference, 0 by definition; years beyond the window grouped at the two ends),
* removing each firm's own average (firm fixed effects) and each calendar year's
* average (year fixed effects). Firms never seen 10%+ foreign-owned are 0 on every
* marker. A firm with one usable year cannot be compared with itself; reghdfe
* drops it. b = log difference from the acquirers' year before the acquisition,
* net of the comparison firms' change; drawn as 100 x (exp(b) - 1) = % difference.
* Outcomes: 1 ln(GJ / value added) = energy per unit of value added (panel a);
*           2 ln(CO2 / value added) = CO2 per unit of value added (panel b).
local ok_sa 1
foreach c in eventstudyinteract avar {
    capture which `c'
    if _rc local ok_sa 0
}
if !`ok_sa' display "   NOTE: eventstudyinteract/avar not installed - the Sun-Abraham version gets an 'unavailable' row"
tempname h s
postfile `h' byte(outcome version) str8 term int event_time byte(grouped reference) ///
    double(b se lo hi p) long(firms rows firms_before_paris firms_after_paris) using `est'
postfile `s' byte(outcome version) long(n_rows n_firms n_acquirers n_comparison n_one_year_dropped) ///
    double(before_F before_df before_p before_p_no_grouped avg_b avg_se avg_lo avg_hi) ///
    double(pp_b pp_se pp_lo pp_hi pp_p) long(sa_left_out) str40 sa_left_years str80 status using `sums'
forvalues v = 1/4 {
    use `fy', clear
    if `v' == 2 {
        keep if acq_usable & (!missing(acq_year_raw) | acq_key_raw == 9001)
        gen int gA = acq_year_raw
        gen byte never = acq_key_raw == 9001
    }
    else {
        if `v' == 3 keep if acq_usable & (!missing(acq_year) | acq_key == 9001)
        else        keep if acq_main
        gen int gA = acq_year
        gen byte never = acq_key == 9001
    }
    assert never == missing(gA)                         // comparison = never seen 10%+ only
    gen byte aft = gA > `acq_paris' if !missing(gA)
    gen int kA = year - gA
    * Sun-Abraham (version 4): an acquisition year whose year before has no row in
    * this sample (the year after a missing file) has no reference year: the
    * package would silently measure those acquirers against another year (it
    * drops one of their markers). Leave such acquisition years out (lesson 20).
    local sa_out = .
    local sa_yrs ""
    if `v' == 4 {
        bysort gA: egen byte has_ref = max(kA == -1)
        egen byte ft0 = tag(firm_id) if !never & !has_ref
        quietly count if ft0 == 1
        local sa_out = r(N)
        quietly levelsof gA if ft0 == 1, local(sa_yrs)
        drop if !never & !has_ref
        drop ft0 has_ref
        sort firm_id year
        display "   Sun-Abraham: `sa_out' acquirers left out (acquisition years with no row the year before: `sa_yrs')"
    }
    gen double y1 = ln(total_gj_s1 / value_added_nominal)
    gen double y2 = ln(co2_total_s1 / value_added_nominal)
    * markers; a marker with no acquirer row in this sample is left out
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
    local terms ""
    local pre ""
    local pre_in ""
    local post ""
    foreach t of local cand {
        quietly count if `t'
        if r(N) == 0 continue
        local terms `terms' `t'
        if "`t'" == "ev_lo" | substr("`t'", 4, 1) == "m" local pre `pre' `t'
        if substr("`t'", 4, 1) == "m" local pre_in `pre_in' `t'      // before, grouped end left out
        if "`t'" != "ev_hi" & "`t'" != "ev_lo" & substr("`t'", 4, 1) == "p" local post `post' `t'
    }
    local lc = subinstr("`post'", " ", " + ", .)        // years 0..+`whi', for the average
    local np : word count `post'
    local lcp = subinstr("`pre_in'", " ", " + ", .)     // years -K..-2, for the before/after contrast
    local npi : word count `pre_in'
    forvalues o = 1/2 {
        if `v' == 4 & !`ok_sa' {
            post `s' (`o') (`v') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) ("") ("unavailable: eventstudyinteract/avar not installed")
            continue
        }
        if `v' == 4 {
            capture quietly eventstudyinteract y`o' `terms', cohort(gA) control_cohort(never) ///
                absorb(i.firm_id i.year) vce(cluster firm_id)
            if _rc {
                post `s' (`o') (`v') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (`sa_out') ("`sa_yrs'") ("failed: eventstudyinteract error r(`=_rc')")
                continue
            }
            local df = e(df_r)
            local N  = e(N)
            capture drop es
            gen byte es = e(sample)
            matrix bsa = e(b_iw)
            matrix vsa = e(V_iw)
            ereturn post bsa vsa, dof(`df')
            local sg = .
        }
        else {
            quietly reghdfe y`o' `terms', absorb(firm_id year) vce(cluster firm_id)
            local df = e(df_r)
            local N  = e(N)
            local sg = e(num_singletons)
            capture drop es
            gen byte es = e(sample)
        }
        * Joint test: all years before the acquisition are 0 (with / without the grouped end).
        quietly test `pre'
        local bF = r(F)
        local bd = r(df)
        local bp = r(p)
        quietly test `pre_in'
        local bq = r(p)
        * Average over the acquisition year and the years after it inside the window.
        quietly lincom (`lc') / `np'
        local ab = r(estimate)
        local ase = r(se)
        local alo = r(estimate) - invttail(`df', 0.025) * r(se)
        local ahi = r(estimate) + invttail(`df', 0.025) * r(se)
        * Before/after contrast: the average of years 0..+K minus the average of the
        * earlier years before (-K..-2). The chart's dots compare every year with the
        * year just before (-1); if the years before drift, this says how much of
        * the difference between the two sides of the line was already there.
        quietly lincom (`lc') / `np' - (`lcp') / `npi'
        local qb = r(estimate)
        local qse = r(se)
        local qlo = r(estimate) - invttail(`df', 0.025) * r(se)
        local qhi = r(estimate) + invttail(`df', 0.025) * r(se)
        local qp = 2 * ttail(`df', abs(r(estimate) / r(se)))
        egen byte ftag = tag(firm_id) if es
        quietly count if ftag & !never
        local st = r(N)
        quietly count if ftag & never
        local cf = r(N)
        quietly count if ftag
        local G = r(N)
        drop ftag
        post `s' (`o') (`v') (`N') (`G') (`st') (`cf') (`sg') (`bF') (`bd') (`bp') (`bq') (`ab') (`ase') (`alo') (`ahi') ///
            (`qb') (`qse') (`qlo') (`qhi') (`qp') (`sa_out') ("`sa_yrs'") ("ok")
        foreach t in `cand' ev_ref {
            if "`t'" == "ev_lo"       local k = `wlo' - 1
            else if "`t'" == "ev_hi"  local k = `whi' + 1
            else if "`t'" == "ev_ref" local k = -1
            else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
            * acquirers behind each point (a firm counts once in a grouped end)
            egen byte ft = tag(firm_id) if es & `t'
            quietly count if ft == 1
            local nf = r(N)
            quietly count if es & `t'
            local nr = r(N)
            quietly count if ft == 1 & aft == 0
            local ne = r(N)
            quietly count if ft == 1 & aft == 1
            local nl = r(N)
            drop ft
            local grp = inlist("`t'", "ev_lo", "ev_hi")
            if "`t'" == "ev_ref" {
                post `h' (`o') (`v') ("`t'") (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') (`ne') (`nl')
            }
            else if !`: list t in terms' | `nr' == 0 {
                post `h' (`o') (`v') ("`t'") (`k') (`grp') (0) (.) (.) (.) (.) (.) (0) (0) (0) (0)
            }
            else {
                local b  = _b[`t']
                local se = _se[`t']
                post `h' (`o') (`v') ("`t'") (`k') (`grp') (0) (`b') (`se') ///
                    (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
                    (2 * ttail(`df', abs(`b' / `se'))) (`nf') (`nr') (`ne') (`nl')
            }
        }
    }
    display "   version `v': done (" %6.0fc `N' " rows, `st' acquirers, `cf' comparison firms)"
}
postclose `h'
postclose `s'

*---------------------------------------------------------------------------
display "Step 5/8: percentages, labels, the R2-08 cross-check and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
merge m:1 outcome version using `sums', nogenerate
gen str80 outcome_label = cond(outcome == 1, "Energy per unit of value added: ln(GJ / value added)", ///
    "CO2 per unit of value added: ln(tonnes of CO2 / value added)")
gen str90 version_label = ""
replace version_label = "Main: `acq_bad' ownership answers unknown, energy records in doubt left out (drawn black)" if version == 1
replace version_label = "Every acquisition and record as filed (drawn hollow gray)"                               if version == 2
replace version_label = "Main acquisitions, energy records in doubt kept"                                          if version == 3
replace version_label = "Main, acquisition years kept apart (Sun-Abraham, eventstudyinteract)"                    if version == 4
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if term == "ev_lo"
replace column = "+`nout' or later (grouped)"      if term == "ev_hi"
replace column = "" if missing(term)
* % difference = 100 x (exp(b) - 1); interval ends converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
gen double avg_pct    = 100 * (exp(avg_b)  - 1)
gen double avg_pct_lo = 100 * (exp(avg_lo) - 1)
gen double avg_pct_hi = 100 * (exp(avg_hi) - 1)
* After (0..+K) minus the earlier years before (-K..-2), as a % difference.
rename (pp_b pp_se pp_p) (prepost_b prepost_se prepost_p)
gen double prepost_pct    = 100 * (exp(prepost_b) - 1)
gen double prepost_pct_lo = 100 * (exp(pp_lo) - 1)
gen double prepost_pct_hi = 100 * (exp(pp_hi) - 1)
gen int window_first = `wlo'
gen int window_last  = `whi'
* The repair of the `acq_bad' answers, repeated on every row (as filed -> main).
gen long bad_year_starts_as_filed = `n_bad'
gen long bad_year_starts_redated  = `n_bad_later'
gen long bad_year_starts_to_never = `n_bad_never'
assert bad_year_starts_as_filed >= bad_year_starts_redated + bad_year_starts_to_never
gen long acquirers_with_later_answer = `n_later'
gen long acquirers_back_below_10     = `n_back'
* Share (%) of acquirers' usable years inside the window that are records in doubt.
gen double doubt_pct_before_acq_all  = `ds_all_pre'
gen double doubt_pct_from_acq_all    = `ds_all_post'
gen double doubt_pct_before_acq_upto = `ds_0_pre'
gen double doubt_pct_from_acq_upto   = `ds_0_post'
gen double doubt_pct_before_acq_after = `ds_1_pre'
gen double doubt_pct_from_acq_after   = `ds_1_post'
gen str90 note = ""
replace note = "Reference year: 0 by definition" if reference == 1
replace note = "Grouped end: all years before `wlo'; each firm counted once" if term == "ev_lo"
replace note = "Grouped end: all years after +`whi'; each firm counted once" if term == "ev_hi"
replace note = "No acquirer row in this version" if !reference & missing(b) & !missing(term) & status == "ok"
replace note = note + cond(note == "", "", "; ") + "Sun-Abraham: " + string(sa_left_out) + " acquirers of " + ///
    sa_left_years + " left out (no row the year before)" if version == 4 & status == "ok" & sa_left_out > 0
* Cross-check with R2-08 (foreign-owner panel), when its table is present: R2-08
* draws value added per GJ (and per CO2), the other way up, so its coefficients
* must be exactly minus ours (version 1 both outcomes; as filed and Sun-Abraham
* outcome 1), provided it used the same window. Warns, never stops.
gen str60 r2_08_check = "R2-08 table not found"
local r2f "../block-r2-internationalisation-energy-efficiency/tables/08_efficiency_import_foreign_start.csv"
capture confirm file "`r2f'"
if !_rc {
    preserve
    import delimited using "`r2f'", clear varnames(1) bindquote(strict) maxquotedrows(unlimited)
    keep if panel == "fdi" & inlist(version, 1, 2, 5) & !missing(event_time)
    keep if (version == 1 & inlist(outcome, 1, 2)) | (inlist(version, 2, 5) & outcome == 1)
    local r2w = window_first[1]
    replace version = 4 if version == 5
    keep outcome version event_time b
    rename b b_r2
    tempfile r2
    save `r2'
    restore
    if `r2w' != `wlo' {
        display "   WARNING: R2-08 used another window (`r2w'); no cross-check"
        replace r2_08_check = "R2-08 used another window"
    }
    else {
        merge 1:1 outcome version event_time using `r2', keep(master match)
        gen byte r2_same = abs(b + b_r2) <= 0.00005 + 1e-9 if _merge == 3 & !missing(b)
        quietly count if r2_same == 1
        local r2ok = r(N)
        quietly count if r2_same == 0
        local r2bad = r(N)
        if `r2bad' > 0 display "   WARNING: `r2bad' coefficients differ from minus R2-08's (`r2ok' agree) - re-check the two files"
        else display "   cross-check: all `r2ok' compared coefficients are exactly minus R2-08's (4 decimals)"
        replace r2_08_check = cond(r2_same == 1, "equals minus R2-08", "DIFFERS from minus R2-08") if !missing(r2_same)
        replace r2_08_check = "not in R2-08" if _merge == 1
        drop _merge b_r2 r2_same
    }
}
sort outcome version event_time
order outcome outcome_label version version_label status column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi firms rows firms_before_paris firms_after_paris ///
      n_rows n_firms n_acquirers n_comparison n_one_year_dropped before_F before_df before_p before_p_no_grouped ///
      avg_b avg_se avg_pct avg_pct_lo avg_pct_hi ///
      prepost_b prepost_se prepost_pct prepost_pct_lo prepost_pct_hi prepost_p window_first window_last sa_left_out sa_left_years ///
      bad_year_starts_as_filed bad_year_starts_redated bad_year_starts_to_never ///
      acquirers_with_later_answer acquirers_back_below_10 doubt_pct_* r2_08_check note
drop term avg_lo avg_hi pp_lo pp_hi
format b se lo hi avg_b avg_se prepost_b prepost_se before_F %9.4f
format pct pct_lo pct_hi avg_pct avg_pct_lo avg_pct_hi prepost_pct prepost_pct_lo prepost_pct_hi doubt_pct_* %9.1f
format p before_p before_p_no_grouped prepost_p %9.3f
format firms rows firms_before_paris firms_after_paris n_rows n_firms n_acquirers n_comparison n_one_year_dropped ///
    before_df sa_left_out bad_year_* acquirers_* %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile res                       // same numbers, full precision, for the companion tables (Step 8)
save `res'
list outcome version column pct pct_lo pct_hi firms r2_08_check if inlist(version, 1, 2), ///
    noobs sepby(outcome version) abbreviate(24) clean
list outcome version n_rows n_acquirers n_comparison before_p avg_pct avg_pct_lo avg_pct_hi prepost_pct prepost_p status ///
    if event_time == 0, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the panels and notes (read from the table, never typed)"
*---------------------------------------------------------------------------
keep if inlist(version, 1, 2)
forvalues o = 1/2 {
    quietly summarize avg_pct if outcome == `o' & version == 1
    local a = r(mean)
    quietly summarize avg_pct_lo if outcome == `o' & version == 1
    local al = r(mean)
    quietly summarize avg_pct_hi if outcome == `o' & version == 1
    local ah = r(mean)
    quietly summarize before_p if outcome == `o' & version == 1
    local bp = r(mean)
    local bps = cond(`bp' < 0.001, "p < 0.001", "p = " + string(`bp', "%5.3f"))
    local bpw = cond(`bp' < 0.05, "a clear difference, a warning sign", "no clear difference")
    * Do the single years before (-K..-2) all sit on one side of 0?
    quietly count if outcome == `o' & version == 1 & inrange(event_time, `wlo', -2) & !missing(pct)
    local nprey = r(N)
    quietly count if outcome == `o' & version == 1 & inrange(event_time, `wlo', -2) & pct > 0 & !missing(pct)
    local npos = r(N)
    quietly count if outcome == `o' & version == 1 & inrange(event_time, `wlo', -2) & pct < 0
    local nneg = r(N)
    local pside ""
    if `nprey' > 1 & `npos' == `nprey' local pside "above"
    if `nprey' > 1 & `nneg' == `nprey' local pside "below"
    if "`pside'" != "" & `bp' >= 0.05 local bpw "all `pside' 0, jointly not clear"
    local clr = cond(`al' > 0 | `ah' < 0, "clear", "not clear")
    * The same years 0..+K against the earlier years before (-K..-2).
    quietly summarize prepost_pct if outcome == `o' & version == 1
    local q = r(mean)
    quietly summarize prepost_pct_lo if outcome == `o' & version == 1
    local ql = r(mean)
    quietly summarize prepost_pct_hi if outcome == `o' & version == 1
    local qh = r(mean)
    local qclr = cond(`ql' > 0 | `qh' < 0, "clear", "not clear")
    local qwhy ""
    if "`pside'" == "above" & `q' < 0 local qwhy ": part of the fall came before the acquisition"
    if "`pside'" == "below" & `q' > 0 local qwhy ": part of the rise came before the acquisition"
    local pp_`o' = "Years 0 to +`whi' vs years `wlo' to -2: " + cond(round(`q') > 0, "+", "") + string(`q', "%9.0f") + "% (interval " ///
        + cond(round(`ql') > 0, "+", "") + string(`ql', "%9.0f") + "% to " + cond(round(`qh') > 0, "+", "") + string(`qh', "%9.0f") ///
        + "%, `qclr')`qwhy'."
    local avg_`o' = "Average of years 0 to +`whi': " + cond(round(`a') > 0, "+", "") + string(`a', "%9.0f") + "% (interval " ///
        + cond(round(`al') > 0, "+", "") + string(`al', "%9.0f") + "% to " + cond(round(`ah') > 0, "+", "") + string(`ah', "%9.0f") ///
        + "%, `clr'). Years before: `bpw' (`bps')."
    * The same two numbers for the gray triangles (every acquisition and record as filed).
    quietly summarize avg_pct if outcome == `o' & version == 2
    local g = r(mean)
    quietly summarize avg_pct_lo if outcome == `o' & version == 2
    local gl = r(mean)
    quietly summarize avg_pct_hi if outcome == `o' & version == 2
    local gh = r(mean)
    quietly summarize before_p if outcome == `o' & version == 2
    local gp = r(mean)
    local gps = cond(`gp' < 0.001, "p < 0.001", "p = " + string(`gp', "%5.3f"))
    local gpw = cond(`gp' < 0.05, "a clear difference, a warning sign", "no clear difference")
    local gclr = cond(`gl' > 0 | `gh' < 0, "clear", "not clear")
    local gry_`o' = "Gray triangles, as filed: average " + cond(round(`g') > 0, "+", "") + string(`g', "%9.0f") + "% (`gclr')." ///
        + " Years before: `gpw' (`gps')."
}
quietly summarize n_acquirers if version == 1 & outcome == 1
local ns = string(r(mean), "%9.0fc")
quietly summarize n_comparison if version == 1 & outcome == 1
local nc = string(r(mean), "%9.0fc")
local ptl_1 "(a) Energy (GJ) per unit of value added: `ns' acquirers vs `nc' comparison firms"
local ptl_2 "(b) CO2 (tonnes) per unit of value added: the same firms"
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
* Years with no file, as text ("2016" or "2016 and 2018").
local gaptxt = subinstr(strtrim("`gapyr'"), " ", " and ", .)
* Records in doubt by side of the acquisition, whole %.
foreach p in 0 1 {
    foreach sd in pre post {
        local d`p'`sd' = string(`ds_`p'_`sd'', "%9.0f")
    }
}
local n_back_c  = strtrim(string(`n_back', "%9.0fc"))
local n_later_c = strtrim(string(`n_later', "%9.0fc"))

*---------------------------------------------------------------------------
display "Step 7/8: two panels on one scale: main (black) and as filed (hollow gray)"
*---------------------------------------------------------------------------
gen double x = event_time
gen double xg = event_time - 0.26                        // as-filed marks sit just left of the black dot
gen double pr = round(pct)
gen str6 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") if !reference & version == 1 & !missing(pct)
gen str9 reflbl = "reference" if reference & version == 1 & outcome == 1
gen double refx = x - 0.2 if reference
* y-axis: one scale for both panels (black intervals and gray marks); 0 always inside.
quietly summarize pct_lo if version == 1
local ymin = min(r(min), 0)
quietly summarize pct_hi if version == 1
local ymax = max(r(max), 0)
quietly summarize pct if version == 2
local ymin = min(`ymin', r(min))
local ymax = max(`ymax', r(max))
local rng = `ymax' - `ymin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local ybot = `step' * floor(`ymin'/`step')
local ytop = `step' * ceil(`ymax'/`step')
if (`ytop' - `ybot')/`step' > 8 {                  // at most 8 steps: fewer, clearer labels
    local step = 2 * `step'
    local ybot = `step' * floor(`ymin'/`step')
    local ytop = `step' * ceil(`ymax'/`step')
}
local yfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local span = `ytop' - `ybot'
local ycnt = `ybot' - 0.13 * `span'                      // row of acquirer counts, under the lowest gridline
local yavg = `ytop' + 0.41 * `span'                      // the panel's average, above the highest gridline
local ypp  = `ytop' + 0.27 * `span'                      // after vs the earlier years before, one line lower
local ygry = `ytop' + 0.13 * `span'                      // the same for the gray triangles, one line lower
local xl = `wlo' - 2.6                                   // room for the "Acquirers" row name
local xr = `whi' + 1.6
* Acquirer counts behind each black dot, one row per panel inside the panel.
gen str8 nlbl = string(firms, "%9.0fc") if version == 1
gen double ycnt = `ycnt'
gen double yavg = `yavg'
gen double ygry = `ygry'
gen double ypp  = `ypp'
gen double xlft = `xl'
gen str12 cname = "Acquirers" if version == 1 & reference
gen str200 atxt = ""
gen str200 gtxt = ""
gen str200 ptxt = ""
forvalues o = 1/2 {
    replace atxt = "`avg_`o''" if version == 1 & reference & outcome == `o'
    replace ptxt = "`pp_`o''"  if version == 1 & reference & outcome == `o'
    replace gtxt = "`gry_`o''" if version == 1 & reference & outcome == `o'
}
* x labels: years since the acquisition (grouped ends as <= / >=).
local xlab ""
forvalues k = `=`wlo'-1'/`nout' {
    local s = cond(`k' > 0, "+", "") + string(`k')
    if `k' < `wlo' local s "≤ `k'"
    if `k' > `whi' local s "≥ +`k'"
    local xlab `"`xlab' `k' "`s'""'
}
* Reference lines as data, one row per panel: 0 line and acquisition line.
gen double zl_y = 0       if reference & version == 1
gen double zl_x0 = `wlo' - 1.6 if reference & version == 1
gen double zl_x1 = `xr'   if reference & version == 1
gen double sl_x = -0.5    if reference & version == 1
gen double sl_y0 = `ybot' if reference & version == 1
gen double sl_y1 = `ytop' if reference & version == 1
gen byte pnum = outcome
label define pnl 1 "`ptl_1'" 2 "`ptl_2'"
label values pnum pnl
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: Acquisition = the first year a firm reports foreign owners holding 10% or more of its capital, after an earlier year below"
local txt "`txt' 10% (a change in the reported share, not a verified purchase); it stays an acquirer if the share falls back later (`n_back_c' of"
local txt "`txt' the `n_later_c' with a later answer). Each black dot = acquirers' change since their year before the acquisition, minus the"
local txt "`txt' same years' change among firms never seen 10%+ foreign-owned. Bars = 95% intervals; crossing 0 = no clear difference."
local txt "`txt' 'Years before': p below 0.05 = acquirers were already changing differently before (a warning sign). 'Years 0 to +`whi' vs"
local txt "`txt' years `wlo' to -2' measures the years after against the earlier years before, not the year just before: a change that"
local txt "`txt' starts before the acquisition cannot come from the new owner. Black dots: none dated in `gaptxt' (no file) or `acq_bad'"
local txt "`txt' (ownership answers unusable); energy records in doubt left out (importers of unknown export status in `dtxt'), which"
local txt "`txt' removes more years after the acquisition than before it (acquired up to `acq_paris': `d0post'% vs `d0pre'%; later: `d1post'% vs"
local txt "`txt' `d1pre'%). Gray triangles keep everything as filed. Value added = output value minus materials, energy and services bought"
local txt "`txt' (current prices); GJ = gigajoules; CO2 = energy used x standard factors, not measured, so (b) differs from (a) only through"
local txt "`txt' the fuel mix. Timing, not proof of cause; cannot show which equipment or process changed. Firm links are fictional: a test"
local txt "`txt' of the method only."
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
twoway (pcspike zl_y zl_x0 zl_y zl_x1, lcolor(gs8) lwidth(thin)) ///
    (pcspike sl_y0 sl_x sl_y1 sl_x, lcolor(gs6) lpattern(dash) lwidth(thin)) ///
    (rspike pct_hi pct_lo x if version == 1 & !reference, lcolor(black) lwidth(thin)) ///
    (scatter pct x if version == 1 & !reference & !grouped, msymbol(O) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct x if version == 1 & grouped, msymbol(Oh) msize(small) mcolor(black) ///
        mlabel(lbl) mlabposition(3) mlabgap(0.5) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter pct xg if version == 2 & !reference, msymbol(Th) msize(small) mcolor(gs8)) ///
    (scatter pct x if version == 1 & reference, msymbol(D) msize(small) mcolor(gs8)) ///
    (scatter pct refx if reflbl != "", msymbol(none) mlabel(reflbl) mlabposition(6) mlabgap(1.5) ///
        mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ycnt x if version == 1, msymbol(none) mlabel(nlbl) mlabposition(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter ycnt xlft if cname != "", msymbol(none) mlabel(cname) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yavg xlft if atxt != "", msymbol(none) mlabel(atxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ygry xlft if gtxt != "", msymbol(none) mlabel(gtxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypp xlft if ptxt != "", msymbol(none) mlabel(ptxt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    by(pnum, cols(1) iscale(1) imargin(small) ixaxes scale(`=7.5/9') ///
        title("Figure `exhibit'. Energy and CO2 per unit of value added before and after a firm gets a foreign owner", ///
            size(small) position(11) justification(left) span) ///
        subtitle("% change since the year before the acquisition, acquirers minus comparison firms", ///
            size(small) position(11) justification(left) span) ///
        note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
        legend(position(6)) graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none))) ///
    subtitle(, size(small) position(11) justification(left) nobox fcolor(white) lcolor(white) margin(b+1)) ///
    xscale(range(`xl' `xr') noline) xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1)) ///
    xtitle("Years since the acquisition (0 = acquisition year; -1 = the year before)", size(vsmall) margin(t+1)) ///
    yscale(range(`ycnt' `yavg') noline) ///
    ylabel(`ybot'(`step')`ytop', angle(0) labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`yfmt')) ///
    ytitle("") ///
    legend(order(4 "Each single year (records in doubt left out)" 5 "Years `nout'+ before or after, combined" ///
                 7 "Year before the acquisition (reference = 0)" 3 "95% interval" ///
                 6 "Every acquisition and record as filed (nothing left out)" 1 "0 = no difference" ///
                 2 "Acquisition (first year 10%+ foreign-owned)") ///
        cols(2) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    plotregion(style(none)) xsize(9) ysize(12)

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
local ftitle "Energy and CO2 per unit of value added before and after a firm gets a foreign owner"
* (1) Points table: every drawn point, panel by panel, left to right; at each
* year the black point first, then the hollow gray triangle (none at the reference).
use `res', clear
keep if inlist(version, 1, 2) & !missing(event_time)
drop if version == 2 & reference                        // not drawn (0 by definition)
sort outcome event_time version
gen str60 c_panel = cond(outcome == 1, "(a) Energy per value added", "(b) CO2 per value added")
gen str60 c_ser = ""
replace c_ser = "Each single year (records in doubt left out)"     if version == 1 & !grouped & !reference
replace c_ser = "Years `nout'+ before or after, combined"          if version == 1 & grouped
replace c_ser = "Year before the acquisition (reference = 0)"      if version == 1 & reference
replace c_ser = "Every acquisition and record as filed"            if version == 2
gen str16 c_pos = cond(event_time > 0, "+", "") + string(event_time)
replace c_pos = "≤ " + c_pos if grouped & event_time < 0
replace c_pos = "≥ " + c_pos if grouped & event_time > 0
* black points: whole % as the chart labels; gray triangles carry no label: one decimal
gen str12 c_v  = cond(round(pct) > 0, "+", "") + string(round(pct), "%9.0f") if version == 1
replace c_v    = cond(round(pct, 0.1) > 0, "+", "") + string(pct, "%9.1f") if version == 2 & !missing(pct)
gen str12 c_lo = cond(round(pct_lo) > 0, "+", "") + string(round(pct_lo), "%9.0f") if version == 1 & !reference & !missing(pct_lo)
replace c_lo   = cond(round(pct_lo, 0.1) > 0, "+", "") + string(pct_lo, "%9.1f") if version == 2 & !missing(pct_lo)
gen str12 c_hi = cond(round(pct_hi) > 0, "+", "") + string(round(pct_hi), "%9.0f") if version == 1 & !reference & !missing(pct_hi)
replace c_hi   = cond(round(pct_hi, 0.1) > 0, "+", "") + string(pct_hi, "%9.1f") if version == 2 & !missing(pct_hi)
gen str12 c_n  = string(firms, "%12.0fc")
gen str12 c_r  = string(rows, "%12.0fc")
gen str90 c_st = ""
replace c_st = "black dot, 95% bar, label"                          if version == 1 & !grouped & !reference
replace c_st = "hollow black circle: grouped end"                  if version == 1 & grouped
replace c_st = "gray diamond: reference (0)"                       if version == 1 & reference
replace c_st = "hollow gray triangle"                              if version == 2
replace c_st = "not drawn: no acquirer row in this version"        if missing(pct)
replace c_v = "" if missing(pct)
* check: one table row per drawn point (black: every year incl. the reference;
* gray: every year except the reference), same numbers as the CSV
quietly count if version == 1
local n1 = r(N)
quietly count if version == 2
local n2 = r(N)
assert `n1' == 2 * (2 * `whi' + 3) & `n2' == 2 * (2 * `whi' + 2)
local npts = _N
local nnote = subinstr(`"`txt'"', "Notes: ", "Chart notes: ", 1)
local rule1 = `n1' / 2 + `n2' / 2                       // line under panel (a)
ctable_pdf c_panel c_ser c_pos c_v c_lo c_hi c_n c_r c_st using "`ptab'", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("% change since the year before the acquisition, acquirers minus firms never seen 10%+ foreign-owned") ///
    header("Panel" "Series (legend)" "Years since|acquisition" "%|difference" "95%|low" "95%|high" ///
        "Acquirer|firms" "Acquirer|firm-years" "Status") ///
    right(3 4 5 6 7 8) norepeat(1) rules(`rule1') fontsize(9) perpage(24) ///
    notes("Plotted value: % difference = 100 x (exp(b) - 1), b = the coefficient in the regression table (columns 1-2 for panel a, 5-6 for panel b). Black points are rounded as the chart labels (whole %); gray triangles carry no label on the chart and are shown to one decimal. Acquirer firms and firm-years behind each point (the chart's count row = black points); a firm counts once in a grouped end. Full precision: tables/`fname'.csv." ///
        `"`nnote'"' "`srcnote'" "`devnote'")
display "table -> `ptab' (`npts' plotted points)"

* (2) Regression table (AER style): one column per outcome and version,
* coefficient on the first line, (standard error) on the second; % difference
* for the average only (the drawn %s are in the points table; all in the CSV).
use `res', clear
drop if missing(event_time)                             // versions with no estimate have no term rows
* check: the coefficients are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep outcome version event_time b
rename b b_csv
tempfile csvb
save `csvb'
restore
merge 1:1 outcome version event_time using `csvb', assert(match using) keep(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
drop b_csv
gen byte col = 4 * (outcome - 1) + version              // (1)-(4) energy, (5)-(8) CO2
tempname P
tempfile R
postfile `P' str60 t_lab str24(t1 t2 t3 t4 t5 t6 t7 t8) using `R'
levelsof event_time, local(ks)
local nterm 0
foreach k of local ks {
    quietly summarize grouped if event_time == `k' & col == 1, meanonly
    local gr = r(max)
    quietly summarize reference if event_time == `k' & col == 1, meanonly
    local rf = r(max)
    local lab = cond(`k' > 0, "+", "") + string(`k')
    if `gr' & `k' < 0 local lab "≤ `lab' (grouped)"
    if `gr' & `k' > 0 local lab "≥ `lab' (grouped)"
    if `rf' {
        post `P' ("`lab' (reference, set to 0)") ("—") ("—") ("—") ("—") ("—") ("—") ("—") ("—")
        local ++nterm
        continue
    }
    forvalues c = 1/8 {
        local b`c' ""
        local s`c' ""
        quietly summarize b if event_time == `k' & col == `c', meanonly
        if r(N) > 0 & !missing(r(mean)) {
            local b`c' = string(r(mean), "%9.3f")
            quietly summarize se if event_time == `k' & col == `c', meanonly
            local s`c' = "(" + string(r(mean), "%9.3f") + ")"
        }
    }
    post `P' ("`lab'") ("`b1'") ("`b2'") ("`b3'") ("`b4'") ("`b5'") ("`b6'") ("`b7'") ("`b8'")
    post `P' ("")      ("`s1'") ("`s2'") ("`s3'") ("`s4'") ("`s5'") ("`s6'") ("`s7'") ("`s8'")
    local nterm = `nterm' + 2
}
* whole-model rows (the same number on every row of a column: take the first)
forvalues c = 1/8 {
    foreach m in ab as ap qb qs nr nf na nc bp bq fe wt sa {
        local `m'`c' ""
    }
    quietly summarize avg_b if col == `c', meanonly
    if r(N) == 0 | missing(r(mean)) continue
    local ab`c' = string(r(mean), "%9.3f")
    quietly summarize avg_se if col == `c', meanonly
    local as`c' = "(" + string(r(mean), "%9.3f") + ")"
    quietly summarize avg_pct if col == `c', meanonly
    local ap`c' = "[" + cond(round(r(mean), 0.1) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
    local as`c' "`as`c'' `ap`c''"                        // (se) [%] on one line
    quietly summarize prepost_b if col == `c', meanonly
    local qb`c' = string(r(mean), "%9.3f")
    quietly summarize prepost_se if col == `c', meanonly
    local qs`c' = "(" + string(r(mean), "%9.3f") + ")"
    quietly summarize prepost_pct if col == `c', meanonly
    local qs`c' = "`qs`c'' [" + cond(round(r(mean), 0.1) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
    foreach v in n_rows n_firms n_acquirers n_comparison {
        quietly summarize `v' if col == `c', meanonly
        local s = string(r(mean), "%12.0fc")
        if "`v'" == "n_rows"       local nr`c' "`s'"
        if "`v'" == "n_firms"      local nf`c' "`s'"
        if "`v'" == "n_acquirers"  local na`c' "`s'"
        if "`v'" == "n_comparison" local nc`c' "`s'"
    }
    quietly summarize before_p if col == `c', meanonly
    local bp`c' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
    quietly summarize before_p_no_grouped if col == `c', meanonly
    local bq`c' = cond(r(mean) < 0.001, "< 0.001", string(r(mean), "%5.3f"))
    local fe`c' "Yes"
    local wt`c' "None"
    quietly summarize sa_left_out if col == `c', meanonly
    local sa`c' = cond(mod(`c' - 1, 4) == 3, string(r(mean), "%9.0fc"), "0")
}
local L1 "Average of years 0 to +`whi'"
post `P' ("`L1'") ("`ab1'") ("`ab2'") ("`ab3'") ("`ab4'") ("`ab5'") ("`ab6'") ("`ab7'") ("`ab8'")
post `P' ("")     ("`as1'") ("`as2'") ("`as3'") ("`as4'") ("`as5'") ("`as6'") ("`as7'") ("`as8'")
local L2 "Years 0 to +`whi' minus years `wlo' to -2"
post `P' ("`L2'") ("`qb1'") ("`qb2'") ("`qb3'") ("`qb4'") ("`qb5'") ("`qb6'") ("`qb7'") ("`qb8'")
post `P' ("")     ("`qs1'") ("`qs2'") ("`qs3'") ("`qs4'") ("`qs5'") ("`qs6'") ("`qs7'") ("`qs8'")
post `P' ("Observations (firm-years)") ("`nr1'") ("`nr2'") ("`nr3'") ("`nr4'") ("`nr5'") ("`nr6'") ("`nr7'") ("`nr8'")
forvalues c = 1/8 {
    if "`nf`c''" != "" local nf`c' "`nf`c''; `na`c''"
}
post `P' ("Firms (clusters); of which acquirers") ("`nf1'") ("`nf2'") ("`nf3'") ("`nf4'") ("`nf5'") ("`nf6'") ("`nf7'") ("`nf8'")
post `P' ("Firm and year fixed effects") ("`fe1'") ("`fe2'") ("`fe3'") ("`fe4'") ("`fe5'") ("`fe6'") ("`fe7'") ("`fe8'")
* (weights: none; standard errors clustered by firm: said in the subtitle, so the
*  table and its notes fit on one page)
post `P' ("Years before all 0: joint test p") ("`bp1'") ("`bp2'") ("`bp3'") ("`bp4'") ("`bp5'") ("`bp6'") ("`bp7'") ("`bp8'")
postclose `P'
use `R', clear
* Sun-Abraham columns with no estimate (add-on missing) say so.
forvalues c = 4(4)8 {
    quietly count if t`c' != "" & t`c' != "—"
    if r(N) == 0 replace t`c' = "unavailable" in 1
}
* Years that left acquirers out of the Sun-Abraham columns (for the notes).
preserve
use `res', clear
quietly levelsof sa_left_years if version == 4 & status == "ok", local(say) clean
quietly summarize sa_left_out if version == 4 & status == "ok", meanonly
local san = cond(r(N) > 0, strtrim(string(r(max), "%9.0fc")), "0")
restore
local rsub "Log points; standard errors clustered by firm in parentheses; no weights; [% = 100 × (exp(b) − 1)] for the two summary rows. Columns 1-4: ln(GJ / value added); 5-8: ln(tonnes of CO2 / value added)."
local dall_pre  = string(`ds_all_pre', "%9.0f")
local dall_post = string(`ds_all_post', "%9.0f")
local rnote "Notes: Log outcome on one marker per year since the acquisition (`wlo' to +`whi'; -1 = reference) and one per grouped end (`nout'+ years"
local rnote "`rnote' before or after), firm and year fixed effects; firms never seen 10%+ foreign-owned are 0 on every marker; one-year firms dropped."
local rnote "`rnote' (1)/(5) main, drawn black; (2)/(6) every acquisition and record as filed, drawn gray; (3)/(7) energy records in doubt kept: they"
local rnote "`rnote' are `dall_pre'% of acquirers' usable years before the acquisition and `dall_post'% from it on, and record far less energy per value added"
local rnote "`rnote' than other rows, so (3)/(7) fall partly for that reason; (4)/(8) Sun-Abraham, the `san' acquirers of `say' left out (no row the year"
local rnote "`rnote' before). No significance stars."
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 t8 using "`rtab'", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Years since the acquisition" "(1) Energy|Main" "(2) Energy|As filed" "(3) Energy|Doubt kept" "(4) Energy|Sun-Abraham" ///
        "(5) CO2|Main" "(6) CO2|As filed" "(7) CO2|Doubt kept" "(8) CO2|Sun-Abraham") ///
    right(2 3 4 5 6 7 8 9) rules(`nterm' `=`nterm' + 3') fontsize(8.5) perpage(60) ///
    notes("`rnote'" "`srcnote' `devnote'")
display "table -> `rtab'"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
