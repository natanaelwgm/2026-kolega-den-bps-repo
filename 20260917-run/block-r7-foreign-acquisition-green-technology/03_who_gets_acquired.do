/*==========================================================================
  R7-03  Who gets a foreign owner? Before the acquisition, how do the firms
         that later get a foreign owner differ from similar firms (same year,
         same 2-digit industry) that are never foreign-owned: size, energy
         use, energy and CO2 per unit of value added, how these were already
         changing, exporting, importing and bought electricity? And do they
         also start exporting or importing in the acquisition year?
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" (which firms are acquired, and whether they were already
         changing before it: the check every before/after comparison needs).
  Output : figures/03_who_gets_acquired.png (+ .pdf)
           tables/03_who_gets_acquired.csv (7 versions x 13 characteristics)
           tables/03_who_gets_acquired_table.pdf (every plotted point)
           tables/03_who_gets_acquired_regression.pdf (the regressions behind
           the dots, AER style)
  Needs  : Stata add-ons from SSC, installed once (the file never installs or
         updates anything): ssc install reghdfe, ssc install ftools,
         ssc install require.
  Acquisition dates: the ACQUISITION REGISTRY block of 01_acquisition_registry.do,
         copied unchanged (R2-08's rule A, 10%+, every 2020 answer unknown).
  Sample : the R7 SAMPLE AND WINDOW block of 02_acquisition_support.do, copied
         unchanged (usable rows, energy records in doubt; its year window is
         computed but not needed in this file).
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
local exhibit "R7-03"
local fname   "03_who_gets_acquired"
cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: who gets a foreign owner (acquirers before the acquisition vs never foreign-owned firms) ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load ownership, trade status, size, energy, CO2 and industry; date each acquisition"
*---------------------------------------------------------------------------
* foreign_ownership_pct = share of the firm's capital held by foreign owners (0-100 %)
* fdi_10_flag           = 1 if that share is 10% or more
* export_flag, import_flag = exports / imports reported (1 yes, 0 no; export often unknown)
* workers               = persons employed
* value_added_nominal   = value added, current prices (masked money unit)
* gross_output_nominal  = output value, current prices (masked money unit)
* total_gj_s1           = energy used in GJ (nine fuels + bought electricity)
* gj_electricity        = bought electricity in GJ (part of total_gj_s1)
* co2_total_s1          = CO2 tonnes from the same fuels and electricity (standard factors)
* industry2_reported    = 2-digit industry code; province_code = province (one check only)
use firm_id year foreign_ownership_pct fdi_10_flag export_flag import_flag workers ///
    value_added_nominal gross_output_nominal total_gj_s1 gj_electricity co2_total_s1 ///
    industry2_reported province_code using "$DATA", clear
isid firm_id year
local N_rows = _N
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
display "Step 2/8: usable rows and energy records in doubt (R7 SAMPLE AND WINDOW block), export years with no 'no' answer"
*---------------------------------------------------------------------------
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
* A year whose export answers hold no "no" at all (in the development files: the
* last file asks about direct exports only) cannot compare exporters with others:
* its export answers are treated as unknown in this file (found, never typed).
gen double exp_use = export_flag
local exp_none ""
forvalues t = `yr0'/`yr1' {
    quietly count if year == `t' & export_flag == 0
    local n0 = r(N)
    quietly count if year == `t' & export_flag == 1
    if `n0' == 0 & r(N) > 0 {
        local exp_none `exp_none' `t'
        replace exp_use = . if year == `t'
    }
}
display "   export answers treated as unknown (no firm answered 'no'): `exp_none'"

*---------------------------------------------------------------------------
display "Step 3/8: each acquirer's reference year and the 13 characteristics"
*---------------------------------------------------------------------------
* Reference year = the last year the acquirer was seen below 10% foreign before
* its acquisition year: the year just before for exactly dated acquisitions
* (acq_exact = 1), an earlier year otherwise (no file or no usable answer the
* year before). Every acquirer has one by construction.
by firm_id: egen int ref_year = max(cond(acq_own < 10 & !missing(acq_own, acq_year) & year < acq_year, year, .))
assert !missing(ref_year) if !missing(acq_year)
gen byte A = year == ref_year & !missing(acq_year)          // acquirer, reference row
gen byte S = year == acq_year & !missing(acq_year)          // acquirer, acquisition-year row
gen byte C = acq_key == 9001                                // never seen 10%+ foreign-owned (comparison)
assert !(A & C) & !(S & C)
* Cells for "similar firms": same calendar year and same 2-digit industry.
egen long ind  = group(industry2_reported)
egen long cell = group(year ind)
egen long pcell = group(year province_code)                 // version 4 only
tsset firm_id year                                          // L. = the calendar year just before
* Rows 1-8 are logs (drawn as % difference); rows 9-13 are shares in % (drawn in points).
* Energy rows (4-8, 11): usable rows, records in doubt left out; the "k" copies keep them.
gen double t1  = ln(workers)              if workers > 0 & !missing(workers)
gen double t2  = ln(value_added_nominal)  if value_added_nominal > 0 & !missing(value_added_nominal)
gen double t3  = ln(gross_output_nominal) if gross_output_nominal > 0 & !missing(gross_output_nominal)
gen double t4k = ln(total_gj_s1)                       if acq_usable
gen double t5k = ln(total_gj_s1 / value_added_nominal)  if acq_usable
gen double t6k = ln(co2_total_s1 / value_added_nominal) if acq_usable
gen double t7k = t5k - L.t5k                            // change from the calendar year just before
gen double t8k = t6k - L.t6k
gen double t9  = 100 * exp_use                          // exporter (known answers only)
gen double t10 = 100 * import_flag                      // importer
gen double t11k = 100 * gj_electricity / total_gj_s1   if acq_usable   // bought electricity, % of GJ
foreach j in 4 5 6 11 {
    gen double t`j' = t`j'k if !acq_doubt
}
gen double t7 = t5 - L.t5                               // both years free of doubt
gen double t8 = t6 - L.t6
* Rows 12-13 (acquisition-year row for acquirers): starts exporting / importing
* = "yes" this year among firms whose last known answer before was "no".
foreach x in exp imp {
    local v = cond("`x'" == "exp", "exp_use", "import_flag")
    local j = cond("`x'" == "exp", 12, 13)
    gen double pv = .
    by firm_id: replace pv = cond(!missing(`v'[_n-1]), `v'[_n-1], pv[_n-1]) if _n > 1
    gen double t`j' = 100 * (`v' == 1) if pv == 0 & !missing(`v')
    drop pv
}
* Check: bought electricity cannot exceed all energy; logs identities hold.
assert inrange(t11k, 0, 100) if !missing(t11k)
assert reldif(t5k, t4k - t2) < 1e-9 if !missing(t5k)
* Names used in the chart, the tables and the CSV.
local n1  "Workers"
local n2  "Value added"
local n3  "Output"
local n4  "Energy used, GJ"
local n5  "Energy per unit of value added"
local n6  "CO2 per unit of value added"
local n7  "Change in energy per unit of value added"
local n8  "Change in CO2 per unit of value added"
local n9  "Exporter"
local n10 "Importer"
local n11 "Bought electricity, share of energy"
local n12 "Starts exporting"
local n13 "Starts importing"
local r1  "persons employed"
local r2  "current prices"
local r3  "current prices"
local r4  "fuels burned + bought electricity"
local r5  "GJ ÷ value added"
local r6  "tonnes of CO2 ÷ value added"
local r7  "last year below 10% vs the calendar year before it"
local r8  "last year below 10% vs the calendar year before it"
local r9  "% of firms with a known export answer"
local r10 "% of firms"
local r11 "% of GJ (mean over firms)"
local r12 "% of firms not exporting at their last answer"
local r13 "% of firms not importing at their last answer"
local erows "4 5 6 7 8 11"                               // rows that use energy records

*---------------------------------------------------------------------------
display "Step 4/8: one regression per characteristic and version (year x industry cells, clustered by firm)"
*---------------------------------------------------------------------------
* y = characteristic, on one marker (1 = acquirer's reference row, or its
* acquisition-year row for rows 12-13; 0 = a row of a never-foreign-owned firm),
* with one fixed effect per year x industry cell: b = acquirers minus
* never-foreign-owned firms of the same year and industry. Never-foreign-owned
* firms enter with every year they have; standard errors clustered by firm.
* Versions (1 drawn black, 2 drawn hollow gray, the rest in the tables):
*   1 main          reference year as above; energy rows without records in doubt
*   2 exact         only acquirers seen below 10% exactly the calendar year before
*   3 keep_doubt    energy rows keep the records in doubt (other rows = version 1)
*   4 province      adds year x province cells
*   5 before_paris  only acquirers acquired up to `acq_paris' (Paris adopted Dec 2015)
*   6 after_paris   only acquirers acquired after `acq_paris'
*   7 majority      only acquirers 50%+ foreign-owned in the acquisition year
tempfile rows est
save `rows'
tempname h
postfile `h' byte(version row) double(b se lo hi p) long(n_obs n_firms n_acq n_comp n_acq_all n_single) ///
    double(mean_acq mean_comp) str70 status using `est'
forvalues v = 1/7 {
    local keep ""
    if `v' == 2 local keep "& acq_exact == 1"
    if `v' == 5 local keep "& acq_after == 0"
    if `v' == 6 local keep "& acq_after == 1"
    if `v' == 7 local keep "& acq_major == 1"
    local abs = cond(`v' == 4, "cell pcell", "cell")
    forvalues j = 1/13 {
        local y "t`j'"
        local m = cond(`j' >= 12, "S", "A")
        quietly count if `m' `keep'
        local nall = r(N)                                   // acquirers in this version
        if `v' == 3 & !`: list j in erows' {
            post `h' (`v') (`j') (.) (.) (.) (.) (.) (.) (.) (.) (.) (`nall') (.) (.) (.) ///
                ("same as version 1: this row uses no energy record")
            continue
        }
        if `v' == 3 local y "t`j'k"
        capture quietly reghdfe `y' `m' if (`m' `keep') | C, absorb(`abs') vce(cluster firm_id)
        if _rc {
            post `h' (`v') (`j') (.) (.) (.) (.) (.) (.) (.) (.) (.) (`nall') (.) (.) (.) ("failed: reghdfe error r(`=_rc')")
            continue
        }
        capture drop es
        gen byte es = e(sample)
        quietly count if es & `m'
        local na = r(N)
        if `na' == 0 | _se[`m'] == 0 {
            post `h' (`v') (`j') (.) (.) (.) (.) (.) (.) (.) (0) (.) (`nall') (.) (.) (.) ("not estimated: no acquirer row")
            continue
        }
        local df = e(df_r)
        local b  = _b[`m']
        local se = _se[`m']
        egen byte ft = tag(firm_id) if es
        quietly count if ft == 1 & C
        local nc = r(N)
        quietly count if ft == 1
        local nf = r(N)
        drop ft
        quietly summarize `y' if es & `m'
        local ma = r(mean)
        quietly summarize `y' if es & C
        local mc = r(mean)
        post `h' (`v') (`j') (`b') (`se') (`b' - invttail(`df', 0.025) * `se') (`b' + invttail(`df', 0.025) * `se') ///
            (2 * ttail(`df', abs(`b' / `se'))) (e(N)) (`nf') (`na') (`nc') (`nall') (e(num_singletons)) (`ma') (`mc') ("ok")
    }
    display "   version `v': done"
}
postclose `h'
* Acquirers and firm groups (for the notes and the CSV).
egen byte ftag = tag(firm_id)
quietly count if ftag & !missing(acq_year)
local n_acq = r(N)
quietly count if ftag & acq_exact == 1
local n_exact = r(N)
quietly count if ftag & C
local n_never = r(N)
quietly count if A & !acq_usable
local n_ref_unusable = r(N)
quietly count if A & acq_usable & acq_doubt
local n_ref_doubt = r(N)
quietly count if A & !missing(exp_use)
local n_ref_expknown = r(N)
drop ftag

*---------------------------------------------------------------------------
display "Step 5/8: plotted values, labels and the CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `est', clear
gen str60 version_label = ""
replace version_label = "Main (drawn black)"                                    if version == 1
replace version_label = "Exactly dated acquirers only (drawn hollow gray)"      if version == 2
replace version_label = "Energy records in doubt kept"                          if version == 3
replace version_label = "Adds year x province cells"                            if version == 4
replace version_label = "Acquired up to `acq_paris' (before Paris)"             if version == 5
replace version_label = "Acquired after `acq_paris' (after Paris)"              if version == 6
replace version_label = "Majority (50%+) foreign-owned at acquisition only"      if version == 7
gen str60 row_label = ""
gen str60 row_detail = ""
forvalues j = 1/13 {
    replace row_label  = "`n`j''" if row == `j'
    replace row_detail = "`r`j''" if row == `j'
}
gen str1 panel = cond(row <= 8, "a", "b")
gen str30 acquirer_row = cond(row >= 12, "acquisition year", "reference year (last seen below 10%)")
gen str40 unit = cond(row <= 8, "log points (drawn as % difference)", "percentage points")
* Plotted value: % difference = 100 x (exp(b) - 1) for the log rows (interval ends
* converted the same way), the coefficient itself (points) for the share rows.
gen double plotted    = cond(row <= 8, 100 * (exp(b)  - 1), b)
gen double plotted_lo = cond(row <= 8, 100 * (exp(lo) - 1), lo)
gen double plotted_hi = cond(row <= 8, 100 * (exp(hi) - 1), hi)
* Raw averages in readable units: rows 1-6 geometric means (GJ and CO2 per
* million units of value added for rows 5-6), rows 7-8 the average change in %,
* rows 9-13 the share in %.
gen double avg_acq  = mean_acq
gen double avg_comp = mean_comp
replace avg_acq  = exp(mean_acq)  * cond(inlist(row, 5, 6), 1e6, 1)  if row <= 6
replace avg_comp = exp(mean_comp) * cond(inlist(row, 5, 6), 1e6, 1)  if row <= 6
replace avg_acq  = 100 * (exp(mean_acq)  - 1) if inlist(row, 7, 8)
replace avg_comp = 100 * (exp(mean_comp) - 1) if inlist(row, 7, 8)
gen str60 avg_unit = ""
replace avg_unit = "geometric mean, persons"                    if row == 1
replace avg_unit = "geometric mean, masked money unit"          if inlist(row, 2, 3)
replace avg_unit = "geometric mean, GJ"                         if row == 4
replace avg_unit = "geometric mean, GJ per million of value added"      if row == 5
replace avg_unit = "geometric mean, tonnes per million of value added"  if row == 6
replace avg_unit = "average change, %"                          if inlist(row, 7, 8)
replace avg_unit = "% of firms or % of GJ"                      if row >= 9
gen byte clear = lo > 0 | hi < 0 if !missing(b)
* File-level counts, repeated on every row.
gen long acquirers_all   = `n_acq'
gen long acquirers_exact = `n_exact'
gen long never_foreign   = `n_never'
gen long ref_rows_not_usable = `n_ref_unusable'
gen long ref_rows_in_doubt   = `n_ref_doubt'
gen long ref_rows_export_known = `n_ref_expknown'
gen str40 export_years_unknown = "`exp_none'"
sort version row
order version version_label row panel row_label row_detail acquirer_row unit status b se lo hi p clear ///
    plotted plotted_lo plotted_hi n_obs n_firms n_acq n_comp n_acq_all n_single mean_acq mean_comp ///
    avg_acq avg_comp avg_unit acquirers_all acquirers_exact never_foreign ref_rows_not_usable ///
    ref_rows_in_doubt ref_rows_export_known export_years_unknown
format b se lo hi mean_acq mean_comp %9.4f
format plotted plotted_lo plotted_hi avg_acq avg_comp %12.2f
format p %9.3f
format n_* acquirers_* never_foreign ref_rows_* %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
list version row row_label plotted plotted_lo plotted_hi n_acq n_comp status if version <= 2, ///
    noobs sepby(version) abbreviate(24) clean
list version row plotted clear n_acq if version >= 3 & status == "ok", noobs sepby(version) abbreviate(24) clean
tempfile res
save `res'

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
keep if inlist(version, 1, 2)
forvalues j = 1/13 {
    quietly summarize plotted if version == 1 & row == `j'
    local pv = r(mean)
    local u = cond(`j' <= 8, "%", " points")
    local p`j' = cond(round(`pv') > 0, "+", "") + string(round(`pv'), "%9.0f") + "`u'"
    quietly summarize clear if version == 1 & row == `j'
    local c`j' = cond(r(mean) == 1, "clear difference", "no clear difference")
}
* Doubtful years as text: runs of consecutive files joined by a dash (R2-08's code).
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
local n_acq_c   = strtrim(string(`n_acq', "%9.0fc"))
local n_exact_c = strtrim(string(`n_exact', "%9.0fc"))
local n_never_c = strtrim(string(`n_never', "%9.0fc"))
local n_expk_c  = strtrim(string(`n_ref_expknown', "%9.0fc"))
display "   workers `p1' (`c1'), energy used `p4' (`c4'), energy per VA `p5' (`c5'), CO2 per VA `p6' (`c6'), change `p7' (`c7')"

*---------------------------------------------------------------------------
display "Step 7/8: dot-and-whisker chart, two panels (% difference on a log scale; points)"
*---------------------------------------------------------------------------
* Row positions (top to bottom), a gap before the change rows and before the
* acquisition-year rows.
gen double ypos = .
local yy 10 9 8 7 6 5 3.6 2.6 6 5 4 2.1 1.1
forvalues j = 1/13 {
    local w : word `j' of `yy'
    replace ypos = `w' if row == `j'
}
gen double yalt = ypos - 0.26                           // hollow gray: just under its row
gen double ysub = ypos - 0.42                           // second line of the row name
gen str60 nm  = ""
gen str60 sub = ""
forvalues j = 1/13 {
    replace nm  = "`n`j''" if row == `j' & version == 1
    replace sub = "`r`j''" if row == `j' & version == 1
}
* Value label at the right end of the interval, whole % or whole points.
gen double pr = round(plotted)
gen str12 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") + cond(row <= 8, "%", "") if version == 1 & !missing(b)
* Firms compared: acquirers / comparison firms.
gen str24 cnt = string(n_acq, "%9.0fc") + " / " + string(n_comp, "%9.0fc") if version == 1 & !missing(b)
* Column headers, attached to the first row of each panel; sub-header for the
* acquisition-year rows.
gen double yhdr = ypos + 1 if version == 1 & inlist(row, 1, 9)
gen str60 hdr  = "Before the acquisition" if !missing(yhdr)
gen str60 hdr2 = "Acquirers / comparison" if !missing(yhdr)
gen double ysh = ypos + 0.75 if version == 1 & row == 12
gen str60 shd = "In the acquisition year" if !missing(ysh)
* Positions on the x-axis: log points (panel a) or points (panel b).
gen double xb  = cond(row <= 8, b, b)
gen double xlo = lo
gen double xhi = hi
local notes ""
foreach pn in a b {
    quietly summarize lo if panel == "`pn'" & version == 1
    local xmin = min(r(min), 0)
    quietly summarize hi if panel == "`pn'" & version == 1
    local xmax = max(r(max), 0)
    quietly summarize b if panel == "`pn'" & version == 2
    local xmin = min(`xmin', r(min))
    local xmax = max(`xmax', r(max))
    if "`pn'" == "a" {
        * log scale: one gridline per doubling (or halving), labelled in % difference
        local l2 = ln(2)
        local kb = floor(`xmin' / `l2')
        local kt = ceil(`xmax' / `l2')
        local xbot = `kb' * `l2'
        local xtop = `kt' * `l2'
        local xlab ""
        forvalues k = `kb'/`kt' {
            local pc = 100 * (2^`k' - 1)
            local s = cond(`pc' > 0, "+", "") + strtrim(string(`pc', "%9.0fc")) + "%"
            if `k' == 0 local s "0"
            local xlab `"`xlab' `=`k'*`l2'' "`s'""'
        }
        local xtt "% difference, log scale (each gridline = twice as large)"
    }
    else {
        local rng = `xmax' - `xmin'
        local step = 10^floor(log10(`rng'))
        if `rng'/`step' < 2       local step = `step'/5
        else if `rng'/`step' < 5  local step = `step'/2
        if `rng'/`step' > 6       local step = `step'*2
        local xbot = `step' * floor(`xmin'/`step')
        local xtop = `step' * ceil(`xmax'/`step')
        local xlab "`xbot'(`step')`xtop'"
        local xtt "Difference in percentage points"
    }
    local span = `xtop' - `xbot'
    local xn  = `xbot' - 1.45 * `span'                  // row names start here (left-aligned)
    local xc  = `xtop' + 0.35 * `span'                  // column: firms compared
    local xr  = `xtop' + 1.00 * `span'
    capture drop xnm xcc zy0 zy1 zx
    gen double xnm = `xn'
    gen double xcc = `xc'
    quietly summarize ypos if panel == "`pn'"
    gen double zy0 = r(min) - 0.6 if version == 1 & row == cond("`pn'" == "a", 1, 9)
    gen double zy1 = r(max) + 0.5 if !missing(zy0)
    gen double zx  = 0 if !missing(zy0)
    local ylo = r(min) - 0.7
    local yhi = r(max) + 1.3
    if "`pn'" == "a" {
        local ptl "(a) Size and energy: % difference, acquirers minus similar firms never seen 10%+ foreign-owned"
        local leg "legend(off)"
    }
    else {
        local ptl "(b) Trade and electricity: difference in percentage points"
        local leg `"legend(order(3 "Acquirers minus similar firms (all acquirers)" 4 "Only acquirers seen below 10% the year just before" 2 "95% interval" 1 "0 = no difference") cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3))"'
    }
    twoway (pcspike zy0 zx zy1 zx if panel == "`pn'", lcolor(gs8) lwidth(thin)) ///
        (rspike xlo xhi ypos if panel == "`pn'" & version == 1, horizontal lcolor(black) lwidth(thin)) ///
        (scatter ypos xb if panel == "`pn'" & version == 1, msymbol(O) msize(small) mcolor(black)) ///
        (scatter yalt xb if panel == "`pn'" & version == 2, msymbol(Th) msize(small) mcolor(gs8)) ///
        (scatter ypos xhi if panel == "`pn'" & lbl != "", msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(1) ///
            mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ypos xnm if panel == "`pn'" & nm != "", msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(black)) ///
        (scatter ysub xnm if panel == "`pn'" & sub != "", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs7)) ///
        (scatter ypos xcc if panel == "`pn'" & cnt != "", msymbol(none) mlabel(cnt) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter yhdr xnm if panel == "`pn'" & hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter yhdr xcc if panel == "`pn'" & hdr2 != "", msymbol(none) mlabel(hdr2) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        (scatter ysh xnm if panel == "`pn'" & shd != "", msymbol(none) mlabel(shd) mlabposition(3) mlabgap(0) ///
            mlabsize(vsmall) mlabcolor(gs4)) ///
        , xscale(range(`xn' `xr') noline) ///
        xlabel(`xlab', labsize(vsmall) noticks tlength(0) labgap(1) grid glcolor(gs14) glwidth(vthin)) ///
        xtitle("`xtt'", size(vsmall) margin(t+1)) ///
        yscale(range(`ylo' `yhi') off) ylabel(none) ytitle("") ///
        subtitle("`ptl'", size(small) position(11) justification(left) margin(b+1)) ///
        `leg' graphregion(color(white) lcolor(white) margin(r+2 l+1)) plotregion(style(none) margin(zero)) ///
        fysize(`=cond("`pn'" == "a", 100, 97)') name(p`pn', replace) nodraw
}
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: Reading: in their last year below 10% foreign, acquirers differ from similar firms by `p1' in workers and `p4' in"
local txt "`txt' energy used, but by `p5' in energy per unit of value added (`c5') and `p6' in CO2 per unit of value added (`c6')."
local txt "`txt' Acquirers = `n_acq_c' firms first seen with foreign owners holding 10%+ of their capital after an earlier year below 10%"
local txt "`txt' (Figure R7-01): a change in the reported share, not a verified purchase. Comparison = `n_never_c' firms never seen 10%+"
local txt "`txt' foreign-owned, all their years. Each dot = acquirers minus comparison firms of the same year and 2-digit industry, in"
local txt "`txt' the acquirer's last year below 10% (the year just before for `n_exact_c'; earlier for the rest); bars = 95% intervals, crossing"
local txt "`txt' 0 = no clear difference. Change rows: a clear difference would mean acquirers were already changing differently before"
local txt "`txt' it. Energy rows leave out records in doubt (importers of unknown export status in `dtxt')."
local txt "`txt' Value added = output value minus materials, energy and services bought (current prices); GJ = gigajoules;"
local txt "`txt' CO2 = energy used x standard factors, not measured. Shows which firms get a foreign owner, not what the owner"
local txt "`txt' changes. Firm links are fictional: a test of the method only."
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
    title("Figure `exhibit'. Firms later seen with 10%+ foreign ownership vs similar firms, before that year", ///
        size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) xsize(9) ysize(12) scale(`=7.5/9')      // text as in R2-08 (9 in, scale 7.5/9)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion tables: every plotted point, and the regressions behind the dots"
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
local ptab "tables/`fname'_table.pdf"
local rtab "tables/`fname'_regression.pdf"
local ftitle "Firms later seen with 10%+ foreign ownership vs similar firms, before that year"
* ---- (a) every plotted point, in chart order (row by row: black dot, then hollow gray) ----
use `res', clear
keep if inlist(version, 1, 2)
sort row version
assert _N == 2 * 13                                     // every drawn dot, once
gen str4  c_panel = cond(row <= 8, "(a)", "(b)")
gen str120 c_row = row_label + " (" + row_detail + ")"
replace c_row = row_label + " in the acquisition year (" + row_detail + ")" if row >= 12
gen str60 c_ser = cond(version == 1, "All acquirers (black dot)", ///
    "Below 10% the year just before (gray triangle)")
gen str6  u = cond(row <= 8, "%", " pts")
gen str14 c_val = cond(missing(plotted), "", cond(plotted > 0, "+", "") + string(plotted, "%9.1f") + u)
gen str10 c_lo  = cond(missing(plotted_lo), "", string(plotted_lo, "%9.1f"))
gen str10 c_hi  = cond(missing(plotted_hi), "", string(plotted_hi, "%9.1f"))
gen str10 c_na  = cond(missing(n_acq),  "", string(n_acq,  "%9.0fc"))
gen str10 c_nc  = cond(missing(n_comp), "", string(n_comp, "%9.0fc"))
gen str10 c_no  = cond(missing(n_obs),  "", string(n_obs,  "%9.0fc"))
gen str80 c_st  = cond(version == 1, "black dot, 95% bar, label", "hollow gray triangle")
replace c_st = "not drawn: " + status if missing(b)
local nnote = subinstr(`"`txt'"', "Notes: ", "Chart notes: ", 1)
ctable_pdf c_panel c_row c_ser c_val c_lo c_hi c_na c_nc c_no c_st using "`ptab'", ///
    title("Table `exhibit'. `ftitle': every plotted point") ///
    header("Panel" "Row on the chart" "Series (legend)" "Plotted value" "95% low" "95% high" ///
        "Acquirers" "Comparison|firms" "Rows|(firm-years)" "Status") ///
    right(4 5 6 7 8 9) norepeat(1 2) rules(16) fontsize(9) perpage(28) ///
    notes("Plotted value: panel (a) % difference = 100 x (exp(b) - 1), drawn on a log scale; panel (b) difference in percentage points. The chart labels round the black dots to whole numbers; interval ends are converted the same way. Acquirers and comparison firms = firms in the estimate (cells with one row are dropped); rows = all firm-years in it. The regressions behind each dot: `rtab'." ///
        `"`nnote'"' "`srcnote'" "`devnote'")
display "   table -> `ptab' (" _N " plotted points)"
* ---- (b) the regressions behind the dots: one column per version, one block of
* rows per characteristic (coefficient, standard error, % difference for logs);
* each cell is its own regression ----
use `res', clear
keep if version <= 6
local nv 6
tempfile rr
save `rr'
* one output row per line of the table, built as strings
clear
local nrow = 1 + 8 * 3 + 1 + 5 * 2 + 5
set obs `nrow'
forvalues c = 1/11 {
    gen strL c`c' = ""
}
local r 1
replace c1 = "Panel A. Logs: coefficient in log points (standard error) [% difference]" in `r'
forvalues j = 1/13 {
    if `j' == 9 {
        local ++r
        replace c1 = "Panel B. Shares in %: coefficient in percentage points (standard error)" in `r'
    }
    local ++r
    local r2 = `r' + 1
    local r3 = `r' + 2
    replace c1 = "`n`j''" + cond(`j' >= 12, " (acquisition year)", "") in `r'
    preserve
    use `rr', clear
    local fm = cond(inlist(`j', 1, 2, 3, 4), "%12.0fc", "%9.1f")
    local d  = cond(`j' <= 8, "%9.3f", "%9.2f")
    quietly summarize avg_acq if version == 1 & row == `j'
    local a2 = string(r(mean), "`fm'")
    quietly summarize avg_comp if version == 1 & row == `j'
    local a3 = string(r(mean), "`fm'")
    forvalues v = 1/`nv' {
        local b`v' ""
        local s`v' ""
        local p`v' ""
        quietly summarize b if version == `v' & row == `j'
        if r(N) > 0 & !missing(r(mean)) {
            local b`v' = string(r(mean), "`d'")
            quietly summarize se if version == `v' & row == `j'
            local s`v' = "(" + string(r(mean), "`d'") + ")"
            quietly summarize plotted if version == `v' & row == `j'
            local p`v' = "[" + cond(r(mean) > 0, "+", "") + string(r(mean), "%9.1f") + "%]"
        }
        else if `v' == 3 local b`v' "= (1)"
    }
    quietly summarize n_obs if version == 1 & row == `j'
    local o1 = string(r(mean), "%9.0fc")
    quietly summarize n_firms if version == 1 & row == `j'
    local f1 = string(r(mean), "%9.0fc")
    restore
    replace c2 = "`a2'" in `r'
    replace c3 = "`a3'" in `r'
    forvalues v = 1/`nv' {
        replace c`=3 + `v'' = "`b`v''" in `r'
        replace c`=3 + `v'' = "`s`v''" in `r2'
        if `j' <= 8 replace c`=3 + `v'' = "`p`v''" in `r3'
    }
    replace c10 = "`o1'" in `r'
    replace c11 = "`f1'" in `r'
    local r = cond(`j' <= 8, `r3', `r2')
    if `j' == 8 local ruleA = `r'
}
local ruleB = `r'
* footer rows: fixed effects, acquirers in each version, weights, standard errors
preserve
use `rr', clear
forvalues v = 1/`nv' {
    quietly summarize n_acq_all if version == `v' & row == 1
    local na`v' = string(r(mean), "%9.0fc")
}
restore
local f1 "Year x 2-digit industry cells"
local f2 "Year x province cells"
local f3 "Acquirers in the version"
local f4 "Weights"
local f5 "Standard errors"
forvalues k = 1/5 {
    local ++r
    replace c1 = "`f`k''" in `r'
    forvalues v = 1/`nv' {
        local cell ""
        if `k' == 1 local cell "Yes"
        if `k' == 2 local cell = cond(`v' == 4, "Yes", "No")
        if `k' == 3 local cell "`na`v''"
        if `k' == 4 local cell "None"
        if `k' == 5 local cell "By firm"
        replace c`=3 + `v'' = "`cell'" in `r'
    }
}
assert `r' == _N
ctable_pdf c1-c11 using "`rtab'", ///
    title("Table `exhibit' (regressions). `ftitle': the regressions behind each dot") ///
    header("Characteristic" "Acquirers'|average" "Comparison|firms' average" "(1)|Main" "(2) Exactly|dated only" ///
        "(3) Records|in doubt kept" "(4) Adds|year x province" "(5) Acquired|up to `acq_paris'" "(6) Acquired|after `acq_paris'" ///
        "Observations|(1)" "Firms|(1)") ///
    right(2 3 4 5 6 7 8 9 10 11) rules(`ruleA' `ruleB') fontsize(8.5) perpage(26) ///
    notes("Notes: Each cell is one regression: the characteristic on one marker (1 = an acquirer in its last year seen below 10% foreign, or in its acquisition year for the two 'starts' rows; 0 = every year of a firm never seen 10%+ foreign-owned), with one fixed effect per year x 2-digit industry cell (and per year x province cell in column 4); no weights; standard errors clustered by firm in parentheses; no significance stars. Columns (1) and (2) are the black dots and hollow gray triangles of Figure `exhibit'; (3) keeps the energy records in doubt (energy rows only; other rows equal (1)): their recorded energy jumps and falls from one year to the next, so the change rows in (3) mostly measure recording, not firms, which is why (1) leaves them out; (5)-(6) split acquirers by acquisition year around the Paris Agreement (adopted December 2015). Averages: raw, over the rows of column (1): rows 1-4 geometric means (persons; masked money unit; GJ), rows 5-6 per million units of value added, change rows average change in %, share rows %. Observations and firms: column (1), after cells with one row are dropped. A version with majority (50%+) foreign-owned acquirers only is in tables/`fname'.csv (version 7)." ///
        "`srcnote'" "`devnote'")
display "   table -> `rtab' (13 characteristics x `nv' versions)"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
