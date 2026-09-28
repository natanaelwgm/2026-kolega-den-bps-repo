/*==========================================================================
  R7-07  Does the answer of Figure R7-04 (energy per unit of value added
         after a firm gets a foreign owner) hold up when we estimate it
         another way, date the acquisition another way, or keep the records
         we left out? One row per check, each measured against the year
         before the acquisition AND against the earlier years before it.
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" - Notes "... foreign acquisition menurunkan energy
         intensity ..." (we report our own numbers; the before/after-Paris
         split is Figure R7-06).
  Output : figures/07_robustness.png (+ .pdf)
           tables/07_robustness.csv (16 chart rows x every year since the
           acquisition, plus the two averages drawn)
           tables/07_robustness_table.pdf (every plotted point)
           tables/07_robustness_regression.pdf (the estimates behind the
           chart, AER style)
  Needs  : Stata add-ons from SSC, installed once (the file never installs or
           updates anything):
             ssc install reghdfe    ssc install ftools    ssc install require
             ssc install csdid      ssc install drdid
             ssc install eventstudyinteract               ssc install avar
             ssc install did_imputation
             ssc install did_multiplegt_dyn               ssc install gtools
           reghdfe, ftools and require are needed for any output; a missing
           method package gives an "unavailable" row in the table and on the
           chart, and the file does not stop.
  Model  : row 1 = the main version of 04_energy_per_va_acquisition.do (firm
           and year fixed effects, standard errors clustered by firm, one
           marker per year since the acquisition, grouped ends). Rows 2-5 =
           the four methods of R2-10 (10_methods_import_foreign_start.do in
           the R2 block), same code, on the R7 main sample. Rows 6-16 = the
           main model with one thing changed (fixed effects, acquisition rule,
           records, CO2). Drawn per row: the average of years 0..+K against
           the year before (as R7-04) and against the average of years -K..-2
           (as R7-04 and R7-05: part of a change can start before).
  Acquisition dates: the ACQUISITION REGISTRY block of 01_acquisition_registry.do,
           copied unchanged (R2-08's rule A, 10%+, every 2020 answer unknown;
           the same rule at 50%+ and above 0%, and as filed).
  Sample and window: the R7 SAMPLE AND WINDOW block of 02_acquisition_support.do,
           copied unchanged (usable rows, energy records in doubt, years -K..+K).
  Checks : in the log, rows 1, 3, 13, 14 and 15 must equal R7-04's versions
           (tables/04_energy_per_va_acquisition.csv) and rows 1-5 minus R2-10's
           foreign-owner averages (../block-r2-internationalisation-energy-
           efficiency/tables/10_methods_import_foreign_start.csv), when those
           tables are present (warns, never stops).
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
local exhibit "R7-07"
local fname   "07_robustness"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: energy per unit of value added after a foreign acquisition, sixteen checks ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load ownership, trade status, energy, CO2, value added, industry, province; check the method packages; date each acquisition"
*---------------------------------------------------------------------------
* foreign_ownership_pct   = share of the firm's capital held by foreign owners (0-100 %)
* fdi_10_flag             = 1 if that share is 10% or more
* export_flag, import_flag = exports / imports reported (1 yes, 0 no; export often
*                           unknown); used by the registry and to find doubtful records
* total_gj_s1             = energy used in GJ (nine fuels burned + bought electricity)
* co2_total_s1            = CO2 tonnes from the same fuels and electricity (standard
*                           factors; electricity at each year's grid factor)
* co2_variant_static_grid = the same CO2 with electricity at one constant grid factor
* value_added_nominal     = value added, current prices (masked money unit)
* industry2_reported      = two-digit industry; province_code = province
use firm_id year foreign_ownership_pct fdi_10_flag export_flag import_flag ///
    total_gj_s1 co2_total_s1 co2_variant_static_grid value_added_nominal ///
    industry2_reported province_code using "$DATA", clear
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
* The four methods are user-written Stata commands (install once, e.g.
* -ssc install csdid-). Each needs its helper command(s). A missing one is
* recorded and its row gets an "unavailable" status (R2-10's guard).
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
display "Step 3/8: the sixteen chart rows, what each one changes, and the counts behind them"
*---------------------------------------------------------------------------
* Industry and province as numbered groups, for row 6's fixed effects.
egen long ind  = group(industry2_reported)
egen long prov = group(province_code)
egen byte ftag = tag(firm_id)
* Acquirers back below 10% at their next answer (they stay acquirers in row 1).
quietly count if ftag & !missing(acq_stays)
local n_later = r(N)
quietly count if ftag & acq_stays == 0
local n_back = r(N)
quietly count if ftag & acq_stays == 1
local n_stay = r(N)
* Row 14's repair: acquisitions dated `acq_bad' as filed, and where the main rule puts them.
quietly count if ftag & acq_year_raw == `acq_bad'
local n_bad = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & acq_key == 9001
local n_bad_never = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & !missing(acq_year)
local n_bad_later = r(N)
* Rows 7-12: acquirers under each other rule, and how many keep the main date.
quietly count if ftag & !missing(acq_year)
local n_acq = r(N)
quietly count if ftag & !missing(acq_year_maj)
local n_maj = r(N)
quietly count if ftag & !missing(acq_year_maj) & acq_year_maj == acq_year
local n_maj_same = r(N)
quietly count if ftag & !missing(acq_year_any)
local n_any = r(N)
quietly count if ftag & !missing(acq_year_any) & acq_year_any == acq_year
local n_any_same = r(N)
quietly count if ftag & acq_from0 == 1
local n_from0 = r(N)
quietly count if ftag & acq_exact == 1
local n_exact = r(N)
quietly count if ftag & acq_exp_start == 0 & acq_imp_start == 0
local n_nocs = r(N)
drop ftag
* Why the thresholds pick nearly the same firms: most answers are exactly 0% or 100%.
quietly count if !missing(foreign_ownership_pct)
local n_own = r(N)
quietly count if inlist(foreign_ownership_pct, 0, 100)
local sh_0100 = 100 * r(N) / `n_own'
display "   acquirers: 10%+ `n_acq'; 50%+ `n_maj' (`n_maj_same' same year); above 0% `n_any' (`n_any_same' same year); " ///
    "from exactly 0% `n_from0'; still 10%+ next answer `n_stay' of `n_later'; exact date `n_exact'; no trade start `n_nocs'"
display "   ownership answers exactly 0% or 100%: " %4.1f `sh_0100' "%"
display "   acquisitions dated `acq_bad' as filed: `n_bad' (main rule: `n_bad_later' get a later year, `n_bad_never' count as never foreign-owned)"
* Energy records in doubt among acquirers' usable years inside the window, before
* the acquisition (-K..-1) and from it on (0..+K) (R7-04's count, all acquirers).
foreach sd in pre post {
    local kc = cond("`sd'" == "pre", "inrange(acq_k, `wlo', -1)", "inrange(acq_k, 0, `whi')")
    quietly count if acq_usable & !missing(acq_year) & `kc'
    local dn = r(N)
    quietly count if acq_usable & acq_doubt & !missing(acq_year) & `kc'
    local ds_`sd' = 100 * r(N) / `dn'
    display "   records in doubt, acquirers' usable years `sd': " %4.1f `ds_`sd'' "% of `dn'"
}
* The sixteen rows. For each: t = how it is estimated (twfe = one regression,
* reghdfe, as R7-04; cs, sa, bjs, dcdh = R2-10's four methods); keep = rows used;
* g = acquisition year; key = registry key (9001 = comparison firms); y = outcome;
* fe = fixed effects (one regression only). Everything not named is row 1's.
local nspec 16
local main_y "ln(total_gj_s1 / value_added_nominal)"
forvalues s = 1/`nspec' {
    local t`s'    "twfe"
    local keep`s' "acq_main"
    local g`s'    "acq_year"
    local key`s'  "acq_key"
    local y`s'    "`main_y'"
    local fe`s'   "firm_id year"
}
local t2 "cs"
local t3 "sa"
local t4 "bjs"
local t5 "dcdh"
* 6: one average per industry and year and per province and year, instead of one per year
local fe6 "firm_id ind#year prov#year"
* 7: majority: first year 50%+ foreign after a year below 10%; comparison = never 50%+
local keep7 "acq_usable & !acq_doubt & (!missing(acq_year_maj) | acq_key_maj == 9001)"
local g7    "acq_year_maj"
local key7  "acq_key_maj"
* 8: any foreign share: first year above 0% after a year at exactly 0%; comparison = never above 0%
local keep8 "acq_usable & !acq_doubt & (!missing(acq_year_any) | acq_key_any == 9001)"
local g8    "acq_year_any"
local key8  "acq_key_any"
* 9-12: main acquirers of one kind only (the others are left out, not made comparison firms)
local keep9  "acq_main & (acq_from0 == 1 | acq_key == 9001)"
local keep10 "acq_main & (acq_stays == 1 | acq_key == 9001)"
local keep11 "acq_main & (acq_exact == 1 | acq_key == 9001)"
local keep12 "acq_main & ((acq_exp_start == 0 & acq_imp_start == 0) | acq_key == 9001)"
* 13: main dates, energy records in doubt kept (R7-04 version 3)
local keep13 "acq_usable & (!missing(acq_year) | acq_key == 9001)"
* 14: everything as filed (R7-04 version 2): `acq_bad' answers kept, records in doubt kept
local keep14 "acq_usable & (!missing(acq_year_raw) | acq_key_raw == 9001)"
local g14    "acq_year_raw"
local key14  "acq_key_raw"
* 15: CO2 per unit of value added (R7-04 panel b); 16: the same with a constant grid factor
local y15 "ln(co2_total_s1 / value_added_nominal)"
local keep16 "acq_main & co2_variant_static_grid > 0 & !missing(co2_variant_static_grid)"
local y16 "ln(co2_variant_static_grid / value_added_nominal)"
* Section of each row (chart headers) and the names on the chart.
local sec1 1
forvalues s = 2/6 {
    local sec`s' 2
}
forvalues s = 7/12 {
    local sec`s' 3
}
local sec13 4
local sec14 4
local sec15 5
local sec16 5
local h1 "Main (Figure R7-04)"
local h2 "Other ways to estimate it (same firms)"
local h3 "Other ways to date an acquisition"
local h4 "Records left out in the main row"
local h5 "CO2 per unit of value added"
local n1  "One regression, firm and year effects"
local r1  "energy (GJ) per unit of value added"
local n2  "Callaway–Sant'Anna"
local r2  "each acquisition year on its own"
local n3  "Sun–Abraham"
local r3  "each acquisition year on its own"
local n4  "Borusyak–Jaravel–Spiess"
local r4  "vs all years before: one dot only"
local n5  "de Chaisemartin–D'Haultfœuille"
local r5  "consecutive years only"
local n6  "Industry × year, province × year effects"
local r6  "instead of one effect per year"
local n7  "Majority: 50%+ foreign-owned"
local r7  "`n_maj_same' of `n_maj' as main; vs never 50%+"
local n8  "Any foreign share (above 0%)"
local r8  "`n_any_same' of `n_any' as main; vs never above 0%"
local n9  "Last answer before exactly 0%"
local r9  "`n_from0' of `n_acq' acquirers"
local n10 "Still 10%+ at the next answer"
local r10 "`n_stay' of `n_later' acquirers with a later answer"
local n11 "Exact date only"
local r11 "below 10% the year before: `n_exact' of `n_acq'"
local n12 "No export or import start that year"
local r12 "`n_nocs' of `n_acq' acquirers"
local n13 "Energy records in doubt kept"
local r13 "main dates"
local n14 "Everything as filed"
local r14 "`acq_bad' answers and records in doubt kept"
local n15 "CO2 per unit of value added"
local r15 "each year's grid factor (Figure R7-04 b)"
local n16 "CO2, constant grid factor"
local r16 "electricity at one factor in every year"
* Short names for the reading sentence in the notes.
local sn1  "main"
local sn2  "Callaway–Sant'Anna"
local sn3  "Sun–Abraham"
local sn4  "Borusyak–Jaravel–Spiess"
local sn5  "de Chaisemartin–D'Haultfœuille"
local sn6  "industry and province effects"
local sn7  "majority"
local sn8  "any share"
local sn9  "from exactly 0%"
local sn10 "still 10%+"
local sn11 "exact date"
local sn12 "no trade start"
local sn13 "records in doubt kept"
local sn14 "as filed"
local sn15 "CO2"
local sn16 "CO2, constant grid"
tempfile fy est sums
save `fy'

*---------------------------------------------------------------------------
display "Step 4/8: estimate each row (firm and year effects, clustered by firm; rows 2-5 = R2-10's methods)"
*---------------------------------------------------------------------------
* Row 1 (and 6-16 with one change): log outcome on one marker per year since
* the acquisition (-1 = the year before = reference, 0 by definition; years
* beyond the window grouped at the two ends), with firm and year effects;
* firms never seen foreign-owned (at the row's rule) are 0 on every marker; a
* firm with one usable year is dropped by reghdfe. Rows 2-5 run R2-10's code
* for its four methods on row 1's sample (outcome flipped to energy per value
* added). Two averages per row, as R7-04 and R7-05:
*   black = years 0..+K minus the year before (-1);
*   gray  = years 0..+K minus the average of years -K..-2 (the earlier years
*           before): if the outcome was already moving before the acquisition,
*           the two differ, and that move cannot come from the new owner.
* Borusyak-Jaravel-Spiess compares each acquirer with its own predicted path
* from ALL its years before the acquisition, so it has one average (black).
capture program drop r707_n
program define r707_n, rclass
    * firms and rows in the estimation sample (variable es): acquirers, comparison
    * firms, and acquirers with a row after (0..+K), in the year before, and in -K..-2
    args whi wlo
    quietly {
        egen byte r7_f = tag(firm_id) if es
        count if r7_f == 1 & !never
        return scalar acq = r(N)
        count if r7_f == 1 & never
        return scalar comp = r(N)
        count if r7_f == 1
        return scalar firms = r(N)
        count if es
        return scalar rows = r(N)
        drop r7_f
        foreach w in post ref early {
            if "`w'" == "post"  local kc "inrange(kA, 0, `whi')"
            if "`w'" == "ref"   local kc "kA == -1"
            if "`w'" == "early" local kc "inrange(kA, `wlo', -2)"
            egen byte r7_f = tag(firm_id) if es & !never & `kc'
            count if r7_f == 1
            return scalar `w' = r(N)
            drop r7_f
        }
    }
end
tempname h hs
postfile `h' byte spec int event_time byte(grouped reference) double(b se lo hi p) long(firms rows) ///
    str70 tnote using `est'
postfile `hs' byte spec long(n_rows n_firms n_acquirers n_comparison n_one_year_dropped n_acq_post n_acq_ref ///
    n_acq_early sa_left_out) double(before_p avg_b avg_se avg_lo avg_hi avg_p pp_b pp_se pp_lo pp_hi pp_p) ///
    str6 ci_basis str90 before_test str90 status using `sums'
timer clear 2
timer on 2
forvalues s = 1/`nspec' {
    use `fy', clear
    keep if `keep`s''
    gen int gA = `g`s''
    gen byte never = `key`s'' == 9001
    assert never == missing(gA)                      // comparison = never foreign-owned at this rule only
    gen int kA = year - gA
    gen double y = `y`s''
    assert !missing(y)                               // every kept row has a log (usable rows only)
    sort firm_id year
    * Sun-Abraham: an acquisition year whose year before has no row (the year
    * after a missing file) has no reference year; the package would silently
    * measure those acquirers against another year. Left out (lesson 20).
    local sa_out = .
    local sa_yrs ""
    if "`t`s''" == "sa" & `ok_sa' {
        bysort gA: egen byte has_ref = max(kA == -1)
        egen byte ft0 = tag(firm_id) if !never & !has_ref
        quietly count if ft0 == 1
        local sa_out = r(N)
        quietly levelsof gA if ft0 == 1, local(sa_yrs)
        drop if !never & !has_ref
        drop ft0 has_ref
        sort firm_id year
    }
    * R7-04's markers; a marker with no acquirer row in this sample is left out.
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
    local lc = subinstr("`post'", " ", " + ", .)        // years 0..+K, for the black average
    local np : word count `post'
    local lcp = subinstr("`pre_in'", " ", " + ", .)     // years -K..-2, for the gray average
    local npi : word count `pre_in'
    * What every row posts (missing unless set below).
    foreach x in N G st cf sg npost nref nearly bp ab ase alo ahi ap qb qse qlo qhi qp {
        local `x' = .
    }
    local ci "t"
    local btest ""
    local stat "ok"
    local map ""                                         // "k:coefficient name" pairs for the table
    local df = .
    capture drop es
    gen byte es = 0

    * ---- one regression (reghdfe) and Sun-Abraham: R7-04's code ----
    if inlist("`t`s''", "twfe", "sa") {
        local run 1
        if "`t`s''" == "sa" & !`ok_sa' {
            local stat "unavailable: package not installed (`=strtrim("`miss_sa'")')"
            local run 0
        }
        if `run' & "`t`s''" == "sa" {
            capture quietly eventstudyinteract y `terms', cohort(gA) control_cohort(never) ///
                absorb(i.firm_id i.year) vce(cluster firm_id)
            if _rc {
                local stat "failed: eventstudyinteract stopped with error r(`=_rc')"
                local run 0
            }
            else {
                local df = e(df_r)
                local N  = e(N)
                replace es = e(sample)
                matrix bsa = e(b_iw)
                matrix vsa = e(V_iw)
                ereturn post bsa vsa, dof(`df')
            }
        }
        if `run' & "`t`s''" == "twfe" {
            quietly reghdfe y `terms', absorb(`fe`s'') vce(cluster firm_id)
            local df = e(df_r)
            local N  = e(N)
            local sg = e(num_singletons)
            replace es = e(sample)
        }
        if `run' {
            quietly test `pre'
            local bp = r(p)
            local btest "F test: every year before the acquisition (grouped end included) = 0"
            quietly lincom (`lc') / `np'
            local ab = r(estimate)
            local ase = r(se)
            quietly lincom (`lc') / `np' - (`lcp') / `npi'
            local qb = r(estimate)
            local qse = r(se)
            foreach t of local terms {
                if "`t'" == "ev_lo"      local k = `wlo' - 1
                else if "`t'" == "ev_hi" local k = `whi' + 1
                else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
                local map `map' `k':`t'
            }
        }
    }

    * ---- (2) Callaway-Sant'Anna (csdid): R2-10's code ----
    * csdid lays out calendar years one by one, so the year with no file is a
    * real gap. Black = its average of years 0..+K (estat event Post_avg); its
    * before check = estat pretrend (R2-10). Its default years before are
    * year-to-year changes, so a second run with long2 (every year against the
    * year before the acquisition, as row 1) gives the gray average; the years
    * after are the same in both runs (checked).
    if "`t`s''" == "cs" {
        local ci "normal"
        if !`ok_cs' local stat "unavailable: package not installed (`=strtrim("`miss_cs'")')"
        else {
            gen int gcs = cond(never, 0, gA)                 // csdid wants 0 = never acquired
            capture quietly csdid y, ivar(firm_id) time(year) gvar(gcs)
            if _rc local stat "failed: csdid stopped with error r(`=_rc')"
            else {
                replace es = e(sample)
                quietly estat event, window(`wlo' `whi')
                matrix bb = r(b)
                matrix vv = r(V)
                local j = colnumb(bb, "Post_avg")
                local ab = bb[1, `j']
                local ase = sqrt(vv[`j', `j'])
                capture quietly estat pretrend, window(`wlo' -1)
                local btest "estat pretrend inside the window (year-to-year changes before the acquisition)"
                if _rc {
                    quietly estat pretrend                    // older csdid: no window option
                    local btest "estat pretrend, all years before the acquisition"
                }
                local bp = r(pchi2)
                capture quietly csdid y, ivar(firm_id) time(year) gvar(gcs) long2
                if _rc local stat "ok; gray not run: csdid long2 stopped with error r(`=_rc')"
                else {
                    quietly estat event, window(`wlo' `whi')
                    matrix bb = r(b)
                    matrix vv = r(V)
                    ereturn post bb vv
                    local lcc ""
                    local lcq ""
                    local nq 0
                    forvalues k = 0/`whi' {
                        local lcc = cond("`lcc'" == "", "Tp`k'", "`lcc' + Tp`k'")
                        local map `map' `k':Tp`k'
                    }
                    forvalues k = 2/`=-`wlo'' {
                        if colnumb(e(b), "Tm`k'") < . {
                            local lcq = cond("`lcq'" == "", "Tm`k'", "`lcq' + Tm`k'")
                            local ++nq
                            local map `map' -`k':Tm`k'
                        }
                    }
                    quietly lincom (`lcc') / `=`whi' + 1'
                    if abs(r(estimate) - `ab') > 1e-7 display "   WARNING: csdid long2 years after differ from the default run - re-check"
                    if `nq' == -`wlo' - 1 {
                        quietly lincom (`lcc') / `=`whi' + 1' - (`lcq') / `nq'
                        local qb = r(estimate)
                        local qse = r(se)
                    }
                    else local stat "ok; gray not computed: long2 lacks some years -K..-2"
                }
            }
        }
    }

    * ---- (4) Borusyak-Jaravel-Spiess (did_imputation): R2-10's code ----
    * Fits firm and year effects on rows not yet (or never) acquired, predicts
    * each acquirer's path without the acquisition, and averages actual minus
    * predicted. Its before check asks whether the years just before the
    * acquisition differ from the firm's earlier years.
    if "`t`s''" == "bjs" {
        local ci "normal"
        if !`ok_bjs' local stat "unavailable: package not installed (`=strtrim("`miss_bjs'")')"
        else {
            gen int Ei = gA                                  // acquisition year; missing = never
            * minn(0): report every year; the window rule already needs 30+ acquirers per year.
            capture quietly did_imputation y firm_id year Ei, horizons(0/`whi') pretrends(`=-`wlo'') autosample minn(0)
            if _rc local stat "failed: did_imputation stopped with error r(`=_rc')"
            else {
                replace es = e(sample)
                local bp = e(pre_p)
                local btest "joint test of the `=-`wlo'' years before the acquisition (vs the firm's earlier years)"
                local lcb "tau0"
                forvalues k = 1/`whi' {
                    local lcb "`lcb' + tau`k'"
                }
                quietly lincom (`lcb') / `=`whi' + 1'
                local ab = r(estimate)
                local ase = r(se)
                forvalues k = 0/`whi' {
                    local map `map' `k':tau`k'
                }
                forvalues k = 1/`=-`wlo'' {
                    local map `map' -`k':pre`k'
                }
                local stat "ok; one average: vs all years before the acquisition"
            }
        }
    }

    * ---- (5) de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn): R2-10's code ----
    * It numbers periods as they appear in the data, so every calendar year
    * missing inside a firm's span (the year with no file included) gets an
    * empty row with the acquisition status filled in (R2-07's fix). Only
    * never-acquired firms are comparisons. Effect_1 = year 0, Effect_2 = +1, ...;
    * Placebo_1 = year -2, Placebo_2 = -3, ... (each against the year before).
    if "`t`s''" == "dcdh" {
        local ci "normal"
        if !`ok_dcdh' local stat "unavailable: package not installed (`=strtrim("`miss_dcdh'")')"
        else {
            preserve
            * Acquirers with no usable row from their acquisition year on would look
            * like firms never acquired: leave them out (as the other methods do).
            bysort firm_id: egen byte has_after = max(!never & year >= gA)
            drop if !never & !has_after
            keep firm_id year y gA never
            tsset firm_id year
            tsfill                                          // empty rows for missing years inside each firm's span
            bysort firm_id (gA): replace gA = gA[1]
            bysort firm_id (never): replace never = never[1]
            gen byte D = !never & year >= gA                // acquisition status: on from the acquisition year
            keep firm_id year y D
            local ne  = `whi' + 1                           // Effect_1..Effect_`ne' = years 0..+`whi'
            local npl = -`wlo' - 1                          // Placebo_1..Placebo_`npl' = years -2..`wlo'
            * The package updates itself from the internet in 1 run in 100 unless
            * told not to. This file never installs or updates anything.
            capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off _no_updates
            if _rc == 198 capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off no_updates
            local rc = _rc
            restore
            if `rc' == 198 local stat "failed: this did_multiplegt_dyn version cannot switch off its self-update"
            else if `rc' local stat "failed: did_multiplegt_dyn stopped with error r(`rc')"
            else {
                local st = e(N_switchers_effect_1)
                local N  = e(N_effect_1)
                local bp = e(p_jointplacebo)
                local btest "joint test of its placebos (years -2 to `wlo', each vs the year before)"
                forvalues l = 1/`ne' {
                    local dsw`=`l'-1+10' = e(N_switchers_effect_`l')
                    local drw`=`l'-1+10' = e(N_effect_`l')
                    local map `map' `=`l'-1':Effect_`l'
                }
                forvalues l = 1/`npl' {
                    local dsw`=-1-`l'+10' = e(N_switchers_placebo_`l')
                    local drw`=-1-`l'+10' = e(N_placebo_`l')
                    local map `map' `=-1-`l'':Placebo_`l'
                }
                local lcd "Effect_1"
                forvalues l = 2/`ne' {
                    local lcd "`lcd' + Effect_`l'"
                }
                local lcq "Placebo_1"
                forvalues l = 2/`npl' {
                    local lcq "`lcq' + Placebo_`l'"
                }
                capture quietly lincom (`lcd') / `ne'
                if !_rc {
                    local ab = r(estimate)
                    local ase = r(se)
                    quietly lincom (`lcd') / `ne' - (`lcq') / `npl'
                    local qb = r(estimate)
                    local qse = r(se)
                    local stat "ok; acquirers and firm-years = those behind year 0"
                }
                else local stat "failed: no covariances in this package version"
            }
        }
    }

    * ---- intervals, counts, and the post lines ----
    local crit = cond("`ci'" == "t", invttail(`df', 0.025), invnormal(0.975))
    if !missing(`ab') {
        local alo = `ab' - `crit' * `ase'
        local ahi = `ab' + `crit' * `ase'
        local ap = cond("`ci'" == "t", 2 * ttail(`df', abs(`ab' / `ase')), 2 * normal(-abs(`ab' / `ase')))
    }
    if !missing(`qb') {
        local qlo = `qb' - `crit' * `qse'
        local qhi = `qb' + `crit' * `qse'
        local qp = cond("`ci'" == "t", 2 * ttail(`df', abs(`qb' / `qse')), 2 * normal(-abs(`qb' / `qse')))
    }
    quietly count if es
    if r(N) > 0 {
        r707_n `whi' `wlo'
        local st = r(acq)
        local cf = r(comp)
        local G = r(firms)
        local npost = r(post)
        local nref = r(ref)
        local nearly = r(early)
        if missing(`N') local N = r(rows)
    }
    post `hs' (`s') (`N') (`G') (`st') (`cf') (`sg') (`npost') (`nref') (`nearly') (`sa_out') ///
        (`bp') (`ab') (`ase') (`alo') (`ahi') (`ap') (`qb') (`qse') (`qlo') (`qhi') (`qp') ///
        ("`ci'") ("`btest'") ("`stat'")
    * One line per year since the acquisition (-K-1 = grouped start, +K+1 = grouped end).
    forvalues k = `=`wlo' - 1'/`=`whi' + 1' {
        local grp = !inrange(`k', `wlo', `whi')
        local nm ""
        foreach pr of local map {
            gettoken kk nn : pr, parse(":")
            if `kk' == `k' local nm = substr("`nn'", 2, .)
        }
        local tn ""
        if "`t`s''" == "bjs" & `k' < 0 local tn "vs the firm's years before `wlo' (the method's own check)"
        if "`t`s''" == "cs" & `k' < -1 local tn "long2 run: against the year before the acquisition"
        if "`t`s''" == "dcdh" & `k' >= 0 local tn "Effect_`=`k'+1' (package name)"
        if "`t`s''" == "dcdh" & `k' < -1 local tn "Placebo_`=-1-`k'' (package name)"
        * rows behind the year (a firm counts once in a grouped end)
        local nf = .
        local nr = .
        if "`t`s''" == "dcdh" & "`nm'" != "" {
            local nf = `dsw`=`k'+10''                      // switchers behind the year (package count)
            local nr = `drw`=`k'+10''
        }
        else if "`t`s''" != "dcdh" {
            local kc = cond(`k' < `wlo', "kA < `wlo'", cond(`k' > `whi', "kA > `whi' & !missing(kA)", "kA == `k'"))
            egen byte ft = tag(firm_id) if es & !never & `kc'
            quietly count if ft == 1
            local nf = r(N)
            quietly count if es & !never & `kc'
            local nr = r(N)
            drop ft
        }
        if `k' == -1 & "`nm'" == "" & strpos("`stat'", "ok") == 1 {
            post `h' (`s') (`k') (0) (1) (0) (.) (0) (0) (.) (`nf') (`nr') ("reference year: 0 by definition")
        }
        else if "`nm'" == "" {
            local why = cond(strpos("`stat'", "ok") == 1, "not estimated by this method", "row not estimated")
            post `h' (`s') (`k') (`grp') (0) (.) (.) (.) (.) (.) (`nf') (`nr') ("`why'")
        }
        else {
            local b  = _b[`nm']
            local se = _se[`nm']
            post `h' (`s') (`k') (`grp') (0) (`b') (`se') (`b' - `crit' * `se') (`b' + `crit' * `se') ///
                (cond("`ci'" == "t", 2 * ttail(`df', abs(`b' / `se')), 2 * normal(-abs(`b' / `se')))) ///
                (`nf') (`nr') ("`tn'")
        }
    }
    if "`t`s''" == "sa" & !missing(`sa_out') {
        local sa_yrs_t = strtrim("`sa_yrs'")
        local r3 "`sa_yrs_t' acquirers left out (`sa_out'): no year before"
    }
    timer off 2
    quietly timer list 2
    display "   row `s' (`n`s''): `stat'; " %6.0fc `N' " rows, `st' acquirers, `cf' comparison firms (" %5.1f r(t2) " s so far)"
    timer on 2
}
postclose `h'
postclose `hs'
timer off 2

*---------------------------------------------------------------------------
display "Step 5/8: percentages, the cross-checks with R7-04 and R2-10, and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
merge m:1 spec using `sums', nogenerate assert(match)
gen str60 spec_label  = ""
gen str60 spec_detail = ""
gen byte  section = .
gen str60 section_label = ""
gen str6  method = ""
forvalues s = 1/`nspec' {
    replace spec_label  = "`n`s''" if spec == `s'
    replace spec_detail = "`r`s''" if spec == `s'
    replace section = `sec`s'' if spec == `s'
    replace section_label = "`h`sec`s'''" if spec == `s'
    replace method = "`t`s''" if spec == `s'
}
gen str40 outcome = cond(inlist(spec, 15, 16), "ln(CO2 / value added)", "ln(GJ / value added)")
gen str24 column = cond(event_time > 0, "+", "") + string(event_time)
replace column = "`=`wlo'-1' or earlier (grouped)" if event_time < `wlo'
replace column = "+`nout' or later (grouped)"      if event_time > `whi'
* % difference = 100 x (exp(b) - 1); interval ends the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
foreach m in avg pp {
    gen double `m'_pct    = 100 * (exp(`m'_b)  - 1)
    gen double `m'_pct_lo = 100 * (exp(`m'_lo) - 1)
    gen double `m'_pct_hi = 100 * (exp(`m'_hi) - 1)
}
* Cross-check with R7-04 (same block; warns, never stops): rows 1, 13, 14, 3 and
* 15 are its versions 1, 3, 2, 4 (energy) and 1 (CO2), same sample and window.
gen str40 r7_04_check = ""
local r4f "tables/04_energy_per_va_acquisition.csv"
capture confirm file "`r4f'"
if _rc display "   `r4f' not found: R7-04 cross-check skipped"
else {
    preserve
    import delimited using "`r4f'", clear varnames(1) bindquote(strict) maxquotedrows(unlimited)
    local r4w = window_first[1]
    gen byte spec = .
    replace spec = 1  if outcome == 1 & version == 1
    replace spec = 14 if outcome == 1 & version == 2
    replace spec = 13 if outcome == 1 & version == 3
    replace spec = 3  if outcome == 1 & version == 4
    replace spec = 15 if outcome == 2 & version == 1
    keep if !missing(spec, event_time)
    keep spec event_time b avg_b prepost_b
    rename (b avg_b prepost_b) (b_r4 avg_r4 pp_r4)
    tempfile r4
    save `r4'
    restore
    if `r4w' != `wlo' display "   WARNING: R7-04 used another window (`r4w'); no cross-check"
    else {
        merge 1:1 spec event_time using `r4', keep(master match)
        gen byte r4_same = abs(b - b_r4) <= 0.00005 + 1e-9 & abs(avg_b - avg_r4) <= 0.00005 + 1e-9 ///
            & abs(pp_b - pp_r4) <= 0.00005 + 1e-9 if _merge == 3 & !missing(b, b_r4)
        quietly count if r4_same == 1
        local r4ok = r(N)
        quietly count if r4_same == 0
        local r4bad = r(N)
        if `r4bad' > 0 display "   WARNING: `r4bad' coefficients differ from R7-04's (`r4ok' agree) - re-check the two files"
        else display "   cross-check: all `r4ok' compared coefficients (and both averages) equal R7-04's (4 decimals)"
        replace r7_04_check = cond(r4_same == 1, "equals R7-04", "DIFFERS from R7-04") if !missing(r4_same)
        drop _merge b_r4 avg_r4 pp_r4 r4_same
    }
}
* Cross-check with R2-10 (R2 block; warns, never stops): its foreign-owner panel,
* main version, uses the same acquisitions, sample and outcome turned upside down
* (value added per GJ), so its averages must be minus ours for rows 1-5.
gen str40 r2_10_check = ""
local r10f "../block-r2-internationalisation-energy-efficiency/tables/10_methods_import_foreign_start.csv"
capture confirm file "`r10f'"
if _rc display "   R2-10 table not found: cross-check skipped"
else {
    preserve
    import delimited using "`r10f'", clear varnames(1) bindquote(strict) maxquotedrows(unlimited)
    keep if event == "fdi" & version == 1 & row_type == "avg"
    local r10w = window_last[1]
    gen byte spec = cond(method == "twfe", 1, cond(method == "cs", 2, cond(method == "sa", 3, cond(method == "bjs", 4, cond(method == "dcdh", 5, .)))))
    keep if !missing(spec, b)
    keep spec b
    rename b avg_r10
    tempfile r10
    save `r10'
    restore
    if `r10w' != `whi' display "   WARNING: R2-10 used another window (`r10w'); no cross-check"
    else {
        merge m:1 spec using `r10', keep(master match)
        gen byte r10_same = abs(avg_b + avg_r10) <= 0.00005 + 1e-9 if _merge == 3 & !missing(avg_b)
        quietly count if r10_same == 1 & event_time == 0
        local r10ok = r(N)
        quietly count if r10_same == 0 & event_time == 0
        local r10bad = r(N)
        if `r10bad' > 0 display "   WARNING: `r10bad' averages differ from minus R2-10's (`r10ok' agree) - re-check the two files"
        else display "   cross-check: rows 1-5 averages = minus R2-10's foreign-owner averages (`r10ok' of 5, 4 decimals)"
        replace r2_10_check = cond(r10_same == 1, "equals minus R2-10", "DIFFERS from minus R2-10") if !missing(r10_same)
        drop _merge avg_r10 r10_same
    }
}
gen int window_first = `wlo'
gen int window_last  = `whi'
gen long acquirers_all = `n_acq'
gen long acquirers_with_later_answer = `n_later'
gen long acquirers_back_below_10 = `n_back'
gen long bad_year_starts_as_filed = `n_bad'
gen long bad_year_starts_redated  = `n_bad_later'
gen long bad_year_starts_to_never = `n_bad_never'
gen double own_answers_0_or_100_pct = `sh_0100'
gen double doubt_pct_before_acq = `ds_pre'
gen double doubt_pct_from_acq   = `ds_post'
rename (pp_b pp_se pp_lo pp_hi pp_p pp_pct pp_pct_lo pp_pct_hi) ///
    (prepost_b prepost_se prepost_lo prepost_hi prepost_p prepost_pct prepost_pct_lo prepost_pct_hi)
rename tnote note
sort spec event_time
order spec spec_label spec_detail section section_label method outcome column event_time grouped reference ///
      b se lo hi p pct pct_lo pct_hi firms rows ///
      n_rows n_firms n_acquirers n_comparison n_one_year_dropped sa_left_out ci_basis before_p before_test ///
      avg_b avg_se avg_lo avg_hi avg_p avg_pct avg_pct_lo avg_pct_hi n_acq_post n_acq_ref ///
      prepost_b prepost_se prepost_lo prepost_hi prepost_p prepost_pct prepost_pct_lo prepost_pct_hi n_acq_early ///
      window_first window_last acquirers_all acquirers_with_later_answer acquirers_back_below_10 ///
      bad_year_starts_as_filed bad_year_starts_redated bad_year_starts_to_never own_answers_0_or_100_pct ///
      doubt_pct_before_acq doubt_pct_from_acq status r7_04_check r2_10_check note
format b se lo hi avg_b avg_se avg_lo avg_hi prepost_b prepost_se prepost_lo prepost_hi %9.4f
format pct pct_lo pct_hi avg_pct avg_pct_lo avg_pct_hi prepost_pct prepost_pct_lo prepost_pct_hi ///
    own_answers_0_or_100_pct doubt_pct_* %9.2f
format p before_p avg_p prepost_p %9.3f
format firms rows n_rows n_firms n_acquirers n_comparison n_one_year_dropped sa_left_out n_acq_post n_acq_ref ///
    n_acq_early acquirers_* bad_year_* %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
tempfile res                       // same numbers, full precision, for the chart and tables
save `res'
list spec spec_label n_rows n_acquirers n_comparison before_p avg_pct avg_pct_lo avg_pct_hi ///
    prepost_pct prepost_pct_lo prepost_pct_hi if event_time == 0, noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
keep if event_time == 0                                 // one line per chart row
sort spec
local nA 0
local nAc 0
local nQ 0
local nQs 0
local nQsc 0
local clrA ""
local oppQ ""
quietly summarize prepost_b if spec == 1
local sgn1 = sign(r(mean))                              // direction of the main row's gray average
forvalues s = 1/`nspec' {
    foreach m in avg prepost {
        local k = cond("`m'" == "avg", "a", "q")
        quietly summarize `m'_pct if spec == `s'
        local v = r(mean)
        local `k'`s' ""
        local c`k'`s' ""
        if !missing(`v') {
            local `k'`s' = cond(round(`v') > 0, "+", "") + string(round(`v'), "%9.0f") + "%"
            quietly summarize `m'_pct_lo if spec == `s'
            local l = r(mean)
            quietly summarize `m'_pct_hi if spec == `s'
            local c`k'`s' = cond(`l' > 0 | r(mean) < 0, "clear", "not clear")
        }
    }
    quietly summarize before_p if spec == `s'
    local bp`s' = r(mean)
    quietly summarize prepost_b if spec == `s'
    local qsg`s' = sign(r(mean))
    if "`a`s''" != "" {
        local ++nA
        if "`ca`s''" == "clear" {
            local ++nAc
            local clrA "`clrA', `sn`s'' `a`s''"
        }
    }
    if "`q`s''" != "" {
        local ++nQ
        if `qsg`s'' == `sgn1' {
            local ++nQs
            if "`cq`s''" == "clear" local ++nQsc
        }
        else local oppQ "`oppQ', `sn`s'' `q`s'' (`cq`s'')"
    }
}
local clrA = cond("`clrA'" == "", "", " (" + substr("`clrA'", 3, .) + ")")
* The reading, built from the data.
local dir1 = cond(`sgn1' < 0, "fall", "rise")
local oppQ = cond("`oppQ'" == "", "", "; the other way: " + substr("`oppQ'", 3, .))
local rd1 "Reading: against the year before, `nAc' of `nA' rows `=cond(`nAc' == 1, "is", "are")' clear`clrA'. Against the earlier years before, `nQs' of `nQ' `dir1' as the main row (`q1'), `nQsc' of them clearly`oppQ'."
local rd2 ""
if "`cq14'" == "clear" & `bp14' < 0.05 & `qsg14' != `sgn1' {
    local pv = cond(`bp14' < 0.001, "p < 0.001", "p = " + string(`bp14', "%5.3f"))
    local rd2 " 'Everything as filed' already differs before the acquisition (`pv'): its `acq_bad' ownership answers are not usable."
}
* Only when Figure R7-05's table says so: the gray fall is value added growth that
* was already under way before the acquisition (not less energy used).
local vatxt ""
capture confirm file "tables/05_scale_vs_intensity.csv"
if !_rc & "`cq1'" == "clear" {
    preserve
    import delimited using "tables/05_scale_vs_intensity.csv", clear varnames(1) bindquote(strict) maxquotedrows(unlimited)
    keep if event_time == 0
    quietly summarize prepost_b if outcome == 3
    local va_q = r(mean)
    quietly summarize prepost_lo if outcome == 3
    local va_lo = r(mean)
    quietly summarize before_p if outcome == 3
    local va_p = r(mean)
    quietly summarize prepost_b if outcome == 1
    local en_q = r(mean)
    restore
    if `va_lo' > 0 & `va_p' < 0.05 & abs(`va_q') > abs(`en_q') ///
        local vatxt " Figure R7-05: that gray fall is mostly value added growth that began before the acquisition, not less energy used, so it is no sign that foreign owners made firms greener."
}
* Why keeping the energy records in doubt gives a clear black row: those records
* are more common from the acquisition on (said only when the data show it).
local dbtxt ""
if "`ca13'" == "clear" & `ds_post' > `ds_pre' local dbtxt ", so keeping them lowers the years after against the years before"
* A row whose years before already differ (p below 0.05) is marked on its name
* in the chart and the tables, so its number is never read on its own.
local tagbp " (years before differ)"
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
local sh0100_t  = string(round(`sh_0100'), "%9.0f")
local dspre_t   = string(round(`ds_pre'), "%9.0f")
local dspost_t  = string(round(`ds_post'), "%9.0f")
display "   `rd1'"
display "   `rd2'`vatxt'"

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart, one row per check, grouped in five sections"
*---------------------------------------------------------------------------
* Row positions, top to bottom; a section header above each group.
gen double ypos = .
local yy 0
local lastsec 0
forvalues s = 1/`nspec' {
    if `sec`s'' != `lastsec' {
        local yy = `yy' - 1.2                           // room for the section header
        local lastsec = `sec`s''
    }
    local yy = `yy' - 1.45
    replace ypos = `yy' if spec == `s'
}
gen double ygr  = ypos - 0.5                            // gray square: just under its row
gen double ysub = ypos - 0.5                            // second line of the row name
replace ypos = ypos + 0.12                              // black dot, row name: a little up
gen str60 nm  = spec_label
replace nm = nm + "`tagbp'" if before_p < 0.05          // years before already differ: marked on the row
gen str60 sub = spec_detail
* Value labels at the right end of each interval, whole %.
gen str12 lbl  = cond(round(avg_pct) > 0, "+", "") + string(round(avg_pct), "%9.0f") + "%" if !missing(avg_pct)
gen str12 lblg = cond(round(prepost_pct) > 0, "+", "") + string(round(prepost_pct), "%9.0f") + "%" if !missing(prepost_pct)
* A row that could not run says so where its dot would be.
gen str60 nrun = "not run: " + substr(status, 1, strpos(status + ":", ":") - 1) if missing(avg_pct)
* Right-hand columns: firms compared, and the method's test of the years before.
gen str24 cnt = string(n_acquirers, "%9.0fc") + " / " + cond(missing(n_comparison), "–", string(n_comparison, "%9.0fc")) ///
    if !missing(n_acquirers)
gen str12 bpt = cond(before_p < 0.001, "< 0.001", string(before_p, "%5.3f")) if !missing(before_p)
* Section headers and column headers.
gen double yhdr = .
gen str60 hdr = ""
forvalues s = 1/`nspec' {
    local p = `s' - 1
    if `s' == 1 | `sec`s'' != `sec`=max(`p', 1)'' {
        replace yhdr = ypos + 1.05 if spec == `s'
        replace hdr  = "`h`sec`s'''" if spec == `s'
    }
}
gen str40 hdr2 = "Acquirers / comparison" if spec == 1
gen str40 hdr3 = "Years before, p" if spec == 1
* x axis: one % scale for every row (step rule: at most ~6 steps).
quietly summarize avg_pct_lo
local xmin = min(r(min), 0)
quietly summarize avg_pct_hi
local xmax = max(r(max), 0)
quietly summarize prepost_pct_lo
local xmin = min(`xmin', r(min))
quietly summarize prepost_pct_hi
local xmax = max(`xmax', r(max))
local rng = `xmax' - `xmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
if `rng'/`step' > 6       local step = `step'*2
local xbot = `step' * floor(`xmin'/`step')
local xtop = `step' * ceil(`xmax'/`step')
* at most 7 axis labels, so they never touch in the narrow data area
if (`xtop' - `xbot') / `step' > 6 {
    local step = 2 * `step'
    local xbot = `step' * floor(`xmin'/`step')
    local xtop = `step' * ceil(`xmax'/`step')
}
local xfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local xlab ""
forvalues x = `xbot'(`step')`=`xtop' + `step'/2' {
    local sx = cond(round(`x', `step'/10) > 0, "+", "") + strtrim(string(round(`x', `step'/10), "`xfmt'")) + "%"
    if abs(`x') < `step'/10 local sx "0"
    local xlab `"`xlab' `x' "`sx'""'
}
local span = `xtop' - `xbot'
local xn  = `xbot' - 0.95 * `span'                      // row names start here (left-aligned)
local xc  = `xtop' + 0.08 * `span'                      // column: firms compared
local xp  = `xtop' + 0.66 * `span'                      // column: years before, p
local xr  = `xtop' + 0.95 * `span'
* A value label starts at the right end of its bar; a bar that ends just left
* of 0 would put its label across the 0 line, so that label starts at 0.
gen double lxa = cond(avg_pct_hi < 0 & avg_pct_hi > -0.15 * `span', 0, avg_pct_hi)
gen double lxg = cond(prepost_pct_hi < 0 & prepost_pct_hi > -0.15 * `span', 0, prepost_pct_hi)
gen double xnm = `xn'
gen double xcc = `xc'
gen double xpp = `xp'
gen double xnr = `xbot'
quietly summarize ypos
gen double zy0 = r(min) - 0.8 if spec == 1
gen double zy1 = r(max) + 0.4 if spec == 1
gen double zx  = 0 if spec == 1
local ylo = r(min) - 0.95
local yhi = r(max) + 1.3
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: `rd1'`rd2'`vatxt' Bars = 95% intervals (crossing 0 = not clear); 'Years before': p below 0.05 = already changing"
local txt "`txt' differently before (each method's own test). Acquisition = first year with 10%+ foreign-owned capital after a year below 10% (a"
local txt "`txt' reported share, not a verified purchase; `n_back_c' of `n_later_c' fall back below 10% at the next answer). The share rules pick nearly the"
local txt "`txt' same firms: `sh0100_t'% of answers are exactly 0% or 100%. Energy records in doubt (importers of unknown export status in `dtxt')"
local txt "`txt' are `dspre_t'% of acquirers' usable years before and `dspost_t'% after the acquisition`dbtxt'. Value added = output value minus materials, energy"
local txt "`txt' and services bought (current prices); CO2 = energy used x standard factors. This cannot show which equipment or process changed."
local txt "`txt' Firm links are fictional: a test of the method only."
local maxw 53.5                                         // widest note line that fits the 9-inch PDF
local notes ""
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
twoway (pcspike zy0 zx zy1 zx, lcolor(gs8) lwidth(thin)) ///
    (rspike avg_pct_lo avg_pct_hi ypos, horizontal lcolor(black) lwidth(thin)) ///
    (rspike prepost_pct_lo prepost_pct_hi ygr, horizontal lcolor(gs9) lwidth(thin)) ///
    (scatter ypos avg_pct, msymbol(O) msize(small) mcolor(black)) ///
    (scatter ygr prepost_pct, msymbol(Sh) msize(small) mcolor(gs7)) ///
    (scatter ypos lxa, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(1) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ygr lxg, msymbol(none) mlabel(lblg) mlabposition(3) mlabgap(1) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xnm, msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xnm, msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs7)) ///
    (scatter ypos xcc, msymbol(none) mlabel(cnt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter ypos xpp, msymbol(none) mlabel(bpt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yhdr xnm if hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yhdr xcc if hdr2 != "", msymbol(none) mlabel(hdr2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter yhdr xpp if hdr3 != "", msymbol(none) mlabel(hdr3) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs4)) ///
    (scatter ypos xnr if nrun != "", msymbol(none) mlabel(nrun) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    , xscale(range(`xn' `xr') noline) ///
    xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1) grid glcolor(gs14) glwidth(vthin)) ///
    xtitle("Average % change in years 0 to +`whi' since the acquisition, acquirers minus comparison firms", size(vsmall) margin(t+1)) ///
    yscale(range(`ylo' `yhi') off) ylabel(none) ytitle("") ///
    legend(order(4 "Against the year before (-1), as in Figure R7-04" 5 "Against the earlier years before (`wlo' to -2)" ///
        2 "95% interval" 1 "0 = no difference") cols(2) position(6) region(lstyle(none)) size(vsmall) ///
        symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Energy per unit of value added after a foreign acquisition: sixteen checks", ///
        size(small) position(11) justification(left) span) ///
    subtitle("Other methods, acquisition rules and record choices; black: against the year before, gray: against the earlier years before", ///
        size(vsmall) position(11) justification(left) span margin(b+2)) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3 l+1)) plotregion(style(none) margin(zero)) ///
    xsize(9) ysize(12) scale(`=7.5/9')                  // text as in R2-08 (9 in, scale 7.5/9)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the estimates behind the chart"
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
local ftitle "Energy per unit of value added after a foreign acquisition: sixteen checks"
* (1) Points table: every chart row top to bottom; in each row the black dot
* first, then the gray square (a point not drawn is listed with the reason).
use `res', clear
keep if event_time == 0                                 // one line per chart row holds both averages
sort spec
expand 2
bysort spec: gen byte mark = _n                         // 1 = black dot, 2 = gray square
sort spec mark
gen str70 c_row = "(" + string(spec) + ") " + spec_label
replace c_row = c_row + "`tagbp'" if before_p < 0.05     // as on the chart
gen str40 c_ser = cond(mark == 1, "Vs the year before (black)", "Vs years `wlo' to -2 (gray)")
gen double v  = cond(mark == 1, avg_pct,    prepost_pct)
gen double vl = cond(mark == 1, avg_pct_lo, prepost_pct_lo)
gen double vh = cond(mark == 1, avg_pct_hi, prepost_pct_hi)
* rounded as the chart labels (whole %); the interval ends the same, except an
* end that would round to 0% gets one decimal (so "clear" stays readable)
local nb = uchar(160)                                   // no-break space: "< 0.001" stays on one line
foreach x in v vl vh {
    gen str14 c_`x' = cond(round(`x') > 0, "+", "") + string(round(`x'), "%9.0f") + "%" if !missing(`x')
    if "`x'" != "v" replace c_`x' = cond(`x' > 0, "+", "") + string(`x', "%9.1f") + "%" if round(`x') == 0 & `x' != 0 & !missing(`x')
}
gen str24 c_cnt = string(n_acquirers, "%9.0fc") + " / " + cond(missing(n_comparison), "–", string(n_comparison, "%9.0fc")) ///
    if !missing(n_acquirers)
gen str10 c_npost = string(n_acq_post, "%9.0fc") if !missing(n_acq_post)
gen str10 c_nbase = string(cond(mark == 1, n_acq_ref, n_acq_early), "%9.0fc") if !missing(n_acq_ref)
gen str10 c_nrows = string(n_rows, "%9.0fc") if !missing(n_rows)
gen str10 c_bp    = cond(before_p < 0.001, "<0.001", string(before_p, "%5.3f")) if !missing(before_p)
gen str70 c_st = ""
replace c_st = cond(mark == 1, "black dot, bar, label", "gray square, bar, label") if !missing(v)
replace c_st = "not drawn: one average only" if missing(v) & mark == 2 & method == "bjs" & !missing(avg_pct)
replace c_st = "not drawn: " + status if missing(v) & c_st == ""
replace c_st = c_st + "; years before differ: not to be quoted alone" if before_p < 0.05 & !missing(v)
quietly count
local npts = r(N)
assert `npts' == 2 * `nspec'                            // every chart row, both marks, once
quietly count if !missing(v)
local ndrawn = r(N)
quietly count if strpos(c_st, "not drawn") == 0
assert r(N) == `ndrawn'
* thin rules under the last row of each section
local prules ""
forvalues s = 1/`=`nspec' - 1' {
    if `sec`s'' != `sec`=`s' + 1'' local prules `prules' `=2 * `s''
}
local nnote = subinstr(`"`txt'"', "Notes: ", "Chart notes: ", 1)
order c_row c_ser c_v c_vl c_vh c_cnt c_npost c_nbase c_nrows c_bp c_st
ctable_pdf c_row c_ser c_v c_vl c_vh c_cnt c_npost c_nbase c_nrows c_bp c_st using "`ptab'", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    subtitle("Average of years 0 to +`whi' since the acquisition, acquirers minus comparison firms (firm and year effects unless the row says otherwise)") ///
    header("Row on the chart" "Series (legend)" "Plotted|value" "95%|interval|low" "95%|interval|high" ///
        "Acquirers /|comparison|(as chart)" "Acquirers|in 0 to +`whi'" "Acquirers|in base|years" "Firm-|years" ///
        "Years|before, p" "Status") ///
    right(3 4 5 6 7 8 9 10) norepeat(1) rules(`prules') fontsize(8.5) perpage(26) ///
    notes("Plotted value: % difference = 100 x (exp(b) - 1) of the average in the regression table (years 0 to +`whi' against the year before, or against the average of years `wlo' to -2), rounded as the chart labels (an interval end that rounds to 0% shown with one decimal). Row details (the rule each row changes) as on the chart. Acquirers / comparison = firms in the estimate (de Chaisemartin–D'Haultfœuille: acquirers behind year 0; comparison not reported by the package). Base years = the year before (black) or years `wlo' to -2 (gray). Firm-years = all in the estimate (firms with one usable year dropped). Years before, p = each method's own joint test of the years before the acquisition. Year by year: tables/`fname'.csv." ///
        `"`nnote'"' "`srcnote'" "`devnote'")
display "table -> `ptab' (`npts' points listed, `ndrawn' drawn)"

* (2) Regression table (AER robustness layout): one line block per chart row
* (sixteen specifications do not fit as columns): the two drawn averages,
* coefficient on the first line, (standard error) on the second, [% difference]
* in its own column; then the model's size and fixed effects. The year-by-year
* coefficients of every row are in the CSV.
use `res', clear
* check: the averages are those in the CSV just written (4 decimals there)
preserve
import delimited using "tables/`fname'.csv", clear varnames(1)
keep spec event_time b avg_b prepost_b
rename (b avg_b prepost_b) (b_csv avg_csv pp_csv)
tempfile csvb
save `csvb'
restore
merge 1:1 spec event_time using `csvb', assert(match) nogenerate
assert abs(b - b_csv) <= 0.00005 + 1e-9 if !missing(b)
assert (abs(avg_b - avg_csv) <= 0.00005 + 1e-9 | missing(avg_b, avg_csv)) & (abs(prepost_b - pp_csv) <= 0.00005 + 1e-9 | missing(prepost_b, pp_csv))
drop b_csv avg_csv pp_csv
keep if event_time == 0
sort spec
tempname P
tempfile R
postfile `P' str70 t_lab str24(t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12) using `R'
local nr 0
local rl ""
forvalues s = 1/`nspec' {
    if `s' == 1 | `sec`s'' != `sec`=max(`s' - 1, 1)'' {
        if `s' > 1 local rl `rl' `nr'
        post `P' ("`h`sec`s'''") ("") ("") ("") ("") ("") ("") ("") ("") ("") ("") ("") ("")
        local ++nr
    }
    foreach m in avg prepost {
        local k = cond("`m'" == "avg", "1", "2")
        quietly summarize `m'_b if spec == `s', meanonly
        local b`k' = cond(r(N) == 0 | missing(r(mean)), "—", string(r(mean), "%9.3f"))
        quietly summarize `m'_se if spec == `s', meanonly
        local s`k' = cond(r(N) == 0 | missing(r(mean)), "", "(" + string(r(mean), "%9.3f") + ")")
        quietly summarize `m'_pct if spec == `s', meanonly
        local p`k' = cond(r(N) == 0 | missing(r(mean)), "", "[" + cond(round(r(mean), 0.1) > 0, "+", "") + string(r(mean), "%9.1f") + "%]")
    }
    quietly summarize before_p if spec == `s', meanonly
    local bp = cond(missing(r(mean)), "—", cond(r(mean) < 0.001, "<`nb'0.001", string(r(mean), "%5.3f")))
    foreach v in n_rows n_firms n_acquirers {
        quietly summarize `v' if spec == `s', meanonly
        local x_`v' = cond(missing(r(mean)), "—", strtrim(string(r(mean), "%12.0fc")))
    }
    * fixed effects: every row removes each firm's own level; row 6 replaces the
    * year effects by industry x year and province x year effects
    local fyr = cond(`s' == 6, "No", "Yes")
    local fip = cond(`s' == 6, "Yes", "No")
    quietly levelsof ci_basis if spec == `s', local(cb) clean
    local ci = cond("`cb'" == "t", "t", "Normal")
    quietly levelsof status if spec == `s', local(stx) clean
    if strpos(`"`stx'"', "ok") != 1 local b1 "not run"
    quietly summarize before_p if spec == `s', meanonly
    local tg = cond(r(mean) < 0.05, "`tagbp'", "")
    post `P' ("(`s') `n`s''`tg'") ("`b1'") ("`p1'") ("`b2'") ("`p2'") ("`bp'") ("`x_n_rows'") ("`x_n_firms'") ("`x_n_acquirers'") ("Yes") ("`fyr'") ("`fip'") ("`ci'")
    post `P' ("")             ("`s1'") ("")     ("`s2'") ("")     ("")     ("")            ("")             ("")                 ("")    ("")       ("")       ("")
    local nr = `nr' + 2
}
postclose `P'
use `R', clear
local rsub "Black = average of years 0 to +`whi' since the acquisition minus the year before (-1); gray = the same minus the average of years `wlo' to -2. Outcome: log of energy (GJ) per unit of value added; rows (15)-(16): log of CO2 per unit of value added. Log points; standard errors clustered by firm in parentheses; [% = 100 × (exp(b) − 1)]; no weights; — = not given by the method."
local rnote "Notes: Each row is one model of the outcome on markers for each year since the acquisition (`wlo' to +`whi'; -1 = reference; grouped ends"
local rnote "`rnote' for `nout'+ years before or after), acquirers against firms never seen foreign-owned at the row's rule; one-year firms dropped."
local rnote "`rnote' Fixed effects as listed ((2)-(5): each method's own way of removing firm and year levels). (1) = Figure R7-04's main"
local rnote "`rnote' version; (2)-(5) = R2-10's four methods on the same sample ((4) compares with all years before the acquisition, so it has no"
local rnote "`rnote' gray average; (2)'s before test uses year-to-year changes, as in R2-10); (6)-(16) change one thing each (chart row names). (3), (13), (14), (15) equal R7-04's regression table columns (4),"
local rnote "`rnote' (3), (2), (5). Firms (clusters) and observations for (5) are the acquirers and firm-years behind year 0. Year-by-year"
local rnote "`rnote' coefficients of every row: tables/`fname'.csv. (3): `r3'.`rd2' No significance stars."
order t_lab t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12
ctable_pdf t_lab t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 using "`rtab'", ///
    title("Table `exhibit', regression. `ftitle': estimates behind the chart") ///
    subtitle("`rsub'") ///
    header("Chart row" "Black|average" "Black|[%]" "Gray|average" "Gray|[%]" "Years|before:|joint p" "Observations|(firm-years)" ///
        "Firms|(clusters)" "Of which|acquirers" "Firm|effects" "Year|effects" "Industry × year,|province × year|effects" ///
        "95%|interval") ///
    right(2 3 4 5 6 7 8 9 10 11 12 13) rules(`rl') fontsize(8.5) perpage(30) landscape ///
    notes("`rnote'" "`srcnote' `devnote'")
display "table -> `rtab'"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
