/*==========================================================================
  R7-01  Which firms get a foreign owner, and in which year? The acquisition
         registry that every later R7 file uses: one acquisition year per
         firm, how many acquirers are majority-owned, how many are back below
         10% at their next answer, and which firms cannot be dated.
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" (this file defines the acquisition event).
  Output : figures/01_acquisition_registry.png (+ .pdf)
           tables/01_acquisition_registry.csv (by acquisition year and by firm
           group; four dating rules side by side; year-to-year ownership
           changes and one-year blips)
           tables/01_acquisition_registry_table.pdf (every plotted point;
           counts only, no regression, so no regression table)
  Needs  : nothing beyond official Stata 17.
  Start rule: R2-08's rule A for foreign ownership of 10%+ (same dates as
         R2-08's panel b), with every 2020 ownership answer treated as unknown.
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
local exhibit "R7-01"
local fname   "01_acquisition_registry"

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: foreign acquisitions by year (the R7 acquisition registry) ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load ownership, export and import status"
*---------------------------------------------------------------------------
* foreign_ownership_pct = share of the firm's capital held by foreign owners (0-100 %)
* fdi_10_flag           = 1 if that share is 10% or more (checked against the share below)
* export_flag, import_flag = used only to count firms that also start exporting or
*                         importing in their acquisition year
use firm_id year foreign_ownership_pct fdi_10_flag export_flag import_flag using "$DATA", clear
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
local gapcs = subinstr(strtrim(itrim("`gapyr' 0")), " ", ",", .)   // comma list for inlist() (0 = none)

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
display "Step 2/7: counts by acquisition year and by firm group (one row per firm)"
*---------------------------------------------------------------------------
tempfile rows firmfile yearly
save `rows'
* Where the as-filed acq_bad starts go once that year's answers are unknown.
egen byte ftag = tag(firm_id)
quietly count if ftag & acq_year_raw == `acq_bad'
local n_bad = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & acq_key == 9001
local n_bad_never = r(N)
quietly count if ftag & acq_year_raw == `acq_bad' & !missing(acq_year)
local n_bad_later = r(N)
assert `n_bad' == `n_bad_never' + `n_bad_later'
display "   starts dated `acq_bad' as filed: `n_bad'; with `acq_bad' unknown `n_bad_later' get a later year and `n_bad_never' count as never foreign-owned"
keep if ftag
keep firm_id acq_*
save `firmfile'
local N_firms = _N
* The row skeleton: every calendar year from the first to the last file, the
* two Paris periods, all acquirers, the three other firm groups, all firms.
clear
local ny = `yr1' - `yr0' + 1
set obs `=`ny' + 7'
gen int row_order = _n
gen int row_key = `yr0' - 1 + _n if _n <= `ny'
replace row_key = 8001 if _n == `ny' + 1       // acquired up to the Paris year
replace row_key = 8002 if _n == `ny' + 2       // acquired after it
replace row_key = 8000 if _n == `ny' + 3       // all acquirers
replace row_key = 9001 if _n == `ny' + 4
replace row_key = 9002 if _n == `ny' + 5
replace row_key = 9003 if _n == `ny' + 6
replace row_key = 9999 if _n == `ny' + 7
tempfile skel
save `skel'
* Main-rule counts per acquisition year (and per firm group).
use `firmfile', clear
gen byte one = 1
gen byte minor   = acq_major == 0
gen byte approx  = acq_exact == 0
gen byte later   = !missing(acq_stays)
gen byte back    = acq_stays == 0
gen byte samemaj = acq_year_maj == acq_year & !missing(acq_year)
gen byte sameany = acq_year_any == acq_year & !missing(acq_year)
collapse (sum) acq_firms = one acq_majority = acq_major acq_minority = minor acq_exact_date = acq_exact ///
    acq_approx_date = approx acq_from_zero = acq_from0 acq_with_later_answer = later ///
    acq_still_10plus_next = acq_stays acq_back_below_next = back acq_blip_next_year = acq_blip ///
    acq_back_below_ever = acq_rev acq_export_start_same_year = acq_exp_start ///
    acq_import_start_same_year = acq_imp_start, by(acq_key)
rename acq_key row_key
tempfile cm
save `cm'
* The other three rules: firms per start year / group, and how many keep the main date.
foreach r in raw maj any {
    use `firmfile', clear
    gen byte same = acq_year_`r' == acq_year & !missing(acq_year_`r')
    collapse (count) firms_`r' = firm_id (sum) same_date_`r' = same, by(acq_key_`r')
    rename acq_key_`r' row_key
    tempfile c`r'
    save `c`r''
}
use `skel', clear
foreach f in cm craw cmaj cany {
    merge 1:1 row_key using ``f'', nogenerate
}
assert !missing(row_order)
* Paris periods and totals from the year rows.
local cnt acq_firms acq_majority acq_minority acq_exact_date acq_approx_date acq_from_zero ///
    acq_with_later_answer acq_still_10plus_next acq_back_below_next acq_blip_next_year ///
    acq_back_below_ever acq_export_start_same_year acq_import_start_same_year
local oth firms_raw same_date_raw firms_maj same_date_maj firms_any same_date_any
foreach v of local cnt {
    replace `v' = 0 if missing(`v') & row_key < 8000 & !inlist(row_key, `yr0', `gapcs')
    quietly summarize `v' if row_key < 8000 & row_key <= `acq_paris'
    replace `v' = r(sum) if row_key == 8001
    quietly summarize `v' if row_key < 8000 & row_key > `acq_paris'
    replace `v' = r(sum) if row_key == 8002
    quietly summarize `v' if row_key < 8000
    replace `v' = r(sum) if row_key == 8000
}
foreach v of local oth {
    replace `v' = 0 if missing(`v') & row_key < 8000 & !inlist(row_key, `yr0', `gapcs')
    quietly summarize `v' if row_key < 8000
    replace `v' = r(sum) if row_key == 8000
}
foreach v in firms_raw firms_maj firms_any {
    quietly summarize `v' if row_key < 8000 | inrange(row_key, 9001, 9003)
    replace `v' = r(sum) if row_key == 9999
}
quietly summarize acq_firms if inlist(row_key, 8000, 9001, 9002, 9003)
replace acq_firms = r(sum) if row_key == 9999
* The main rule gives no start in acq_bad (answers unknown): keep that cell empty, not 0.
foreach v of local cnt {
    replace `v' = . if row_key == `acq_bad'
}
* The majority and above-0% rules also treat acq_bad answers as unknown: empty too.
foreach v in firms_maj same_date_maj firms_any same_date_any {
    replace `v' = . if row_key == `acq_bad'
}
* No acquirer of the year has a later answer (last file): what happens next is unknown.
foreach v in acq_still_10plus_next acq_back_below_next acq_back_below_ever {
    replace `v' = . if row_key < 8000 & acq_with_later_answer == 0
}
* A one-year blip cannot be seen when the next calendar year has no file, no
* usable answer, or is after the last file: leave that cell empty, not 0.
foreach g in `gapyr' `acq_bad' `=`yr1'+1' {
    replace acq_blip_next_year = . if row_key == `g' - 1
}
foreach v in same_date_raw same_date_maj same_date_any {
    replace `v' = . if row_key > 9000
}
* Firm-group rows carry only the firm count (the details are about acquirers).
foreach v of local cnt {
    if "`v'" != "acq_firms" replace `v' = . if inrange(row_key, 9001, 9999)
}
* Structural checks (hold on any data).
assert acq_firms == `N_firms' & firms_raw == `N_firms' & firms_maj == `N_firms' & firms_any == `N_firms' if row_key == 9999
assert acq_majority + acq_minority == acq_firms if row_key < 9000
assert acq_exact_date + acq_approx_date == acq_firms if row_key < 9000
assert acq_still_10plus_next + acq_back_below_next == acq_with_later_answer if row_key < 9000 & acq_with_later_answer > 0
assert (acq_blip_next_year <= acq_back_below_next | missing(acq_blip_next_year)) & acq_back_below_next <= acq_back_below_ever if row_key < 9000
quietly summarize acq_firms if inlist(row_key, 8001, 8002)
local chk = r(sum)
quietly summarize acq_firms if row_key == 8000
assert `chk' == r(sum)
assert firms_raw == `n_bad' if row_key == `acq_bad'
save `yearly'

*---------------------------------------------------------------------------
display "Step 3/7: year-to-year ownership changes (all firms, every crossing, not only the first)"
*---------------------------------------------------------------------------
* Compared with the firm's previous usable answer (any gap). Main = acq_bad unknown.
use `rows', clear
foreach r in main raw {
    local own = cond("`r'" == "raw", "foreign_ownership_pct", "acq_own")
    gen double pv = .
    by firm_id: replace pv = cond(!missing(`own'[_n-1]), `own'[_n-1], pv[_n-1]) if _n > 1
    gen byte tr_known_`r'   = !missing(pv, `own')
    gen byte tr_up10_`r'    = tr_known_`r' & pv < 10 & `own' >= 10
    gen byte tr_down10_`r'  = tr_known_`r' & pv >= 10 & `own' < 10
    if "`r'" == "main" {
        gen byte tr_up_any_main   = tr_known_`r' & pv == 0 & `own' > 0
        gen byte tr_up_minor_main = tr_up10_main & `own' < 50
        gen byte tr_up_major_main = tr_up10_main & `own' >= 50
    }
    drop pv
}
* One-year blips (as filed, neighbouring calendar years only): firms below 10%
* in both the year before and the year after; how many are 10%+ in between.
tsset firm_id year
gen byte below_both_sides = L.foreign_ownership_pct < 10 & F.foreign_ownership_pct < 10 ///
    & !missing(L.foreign_ownership_pct, F.foreign_ownership_pct, foreign_ownership_pct)
gen byte blip_10plus_between = below_both_sides & foreign_ownership_pct >= 10
gen byte one = 1
collapse (sum) file_rows = one tr_* below_both_sides blip_10plus_between ///
    (mean) share_10plus_as_filed = fdi_10_flag, by(year)
rename year row_key
merge 1:1 row_key using `yearly', nogenerate
foreach v of varlist tr_* below_both_sides blip_10plus_between {
    replace `v' = . if row_key == `yr0'                  // nothing earlier to compare with
    replace `v' = . if inlist(row_key, `acq_bad') & strpos("`v'", "_main")
}
replace below_both_sides = . if below_both_sides == 0 & row_key < 8000   // no neighbouring files
replace blip_10plus_between = . if missing(below_both_sides)
gen double blip_share = blip_10plus_between / below_both_sides

*---------------------------------------------------------------------------
display "Step 4/7: labels and notes -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
gen int acquisition_year = row_key if row_key < 8000
gen str70 group = ""
replace group = "Acquired in " + string(row_key) if row_key < 8000
replace group = "Acquired up to `acq_paris' (before Paris)" if row_key == 8001
replace group = "Acquired after `acq_paris' (after Paris)"  if row_key == 8002
replace group = "All acquirers"                                        if row_key == 8000
replace group = "Never seen 10%+ foreign-owned (comparison firms)"     if row_key == 9001
replace group = "10%+ foreign-owned when first seen (left out)"        if row_key == 9002
replace group = "No usable ownership answer (left out)"                if row_key == 9003
replace group = "All firms"                                            if row_key == 9999
gen str100 note = ""
replace note = "First file: no acquisition can be seen" if row_key == `yr0'
foreach g of local gapyr {
    replace note = "No annual file" if row_key == `g'
}
replace note = "Ownership answers treated as unknown; as filed `n_bad' starts (`n_bad_later' re-dated later, `n_bad_never' never foreign-owned)" if row_key == `acq_bad'
replace note = "Other rules' columns: firms in the matching group of that rule" if inrange(row_key, 9001, 9003)
format acq_* firms_* same_date_* file_rows tr_* below_both_sides blip_10plus_between %9.0f
format share_10plus_as_filed blip_share %9.3f
sort row_order
order row_order row_key group acquisition_year acq_firms acq_majority acq_minority acq_exact_date acq_approx_date ///
    acq_from_zero acq_with_later_answer acq_still_10plus_next acq_back_below_next acq_blip_next_year acq_back_below_ever ///
    acq_export_start_same_year acq_import_start_same_year firms_raw same_date_raw firms_maj same_date_maj ///
    firms_any same_date_any file_rows share_10plus_as_filed tr_known_main tr_up_any_main tr_up10_main ///
    tr_up_minor_main tr_up_major_main tr_down10_main tr_known_raw tr_up10_raw tr_down10_raw ///
    below_both_sides blip_10plus_between blip_share note
drop row_key
export delimited using "tables/`fname'.csv", datafmt replace
list group acq_firms acq_majority acq_exact_date acq_with_later_answer acq_back_below_next firms_raw ///
    firms_maj firms_any, noobs sep(0) abbreviate(24) clean
list group tr_up10_main tr_down10_main tr_up10_raw below_both_sides blip_share if !missing(acquisition_year), ///
    noobs sep(0) abbreviate(24) clean
* Cross-check with R2-01 (same as-filed rule A): warn only, never stop.
local r2csv "../block-r2-internationalisation-energy-efficiency/tables/01_export_entry_cohorts.csv"
capture confirm file "`r2csv'"
if !_rc {
    preserve
    import delimited using "`r2csv'", clear varnames(1)
    keep if margin == "fdi10" & !missing(cohort_year)
    keep cohort_year simple_firms
    rename (cohort_year simple_firms) (acquisition_year r2_firms)
    tempfile r2
    save `r2'
    restore
    preserve
    keep if !missing(acquisition_year)
    merge 1:1 acquisition_year using `r2', nogenerate keep(master match)
    quietly count if !missing(r2_firms) & r2_firms != firms_raw
    if r(N) display "   WARNING: as-filed starts differ from R2-01's foreign-ownership rows in " r(N) " years"
    else display "   cross-check: as-filed starts match R2-01's foreign-ownership rows year by year"
    restore
}
else display "   (R2-01 table not found: cross-check skipped)"

*---------------------------------------------------------------------------
display "Step 5/7: numbers for the figure notes (read from the table, never typed)"
*---------------------------------------------------------------------------
foreach v in acq_firms acq_with_later_answer acq_back_below_next acq_majority {
    quietly summarize `v' if group == "All acquirers"
    local t_`v' = strtrim(string(r(sum), "%9.0fc"))
}
foreach k in 9001 9002 9003 {
    local lbl = cond(`k' == 9001, "Never seen", cond(`k' == 9002, "10%+ foreign-owned when", "No usable"))
    quietly summarize acq_firms if strpos(group, "`lbl'") == 1
    local g`k' = strtrim(string(r(sum), "%9.0fc"))
}
* Years whose starts are all approximate (no usable answer the year before).
local apx ""
quietly levelsof acquisition_year if acq_firms > 0 & acq_exact_date == 0 & !missing(acq_firms), local(apx)
local napx : word count `apx'
local apxtxt ""
forvalues j = 1/`napx' {
    local w : word `j' of `apx'
    local sep = cond(`j' == 1, "", cond(`j' == `napx', " and ", ", "))
    local apxtxt "`apxtxt'`sep'`w'"
}
local s_bad = string(100 * `acq_sh_bad', "%9.0f")
local s_oth = string(100 * `acq_sh_other', "%9.0f")
local n_bad_c       = strtrim(string(`n_bad', "%9.0fc"))
local n_bad_never_c = strtrim(string(`n_bad_never', "%9.0fc"))
local n_bad_later_c = strtrim(string(`n_bad_later', "%9.0fc"))

*---------------------------------------------------------------------------
display "Step 6/7: bars by acquisition year: majority / minority, and how many are back below 10% next time"
*---------------------------------------------------------------------------
keep if !missing(acquisition_year)
gen double x   = acquisition_year
gen double xa  = x - 0.2                    // acquisitions (left bar)
gen double xb  = x + 0.2                    // back below 10% at the next answer (right bar)
gen double zero = 0
gen double maj  = acq_majority
gen double tot  = acq_firms
gen double back = acq_back_below_next if acq_with_later_answer > 0
quietly summarize tot
local step = 10^floor(log10(r(max)))                        // axis step that grows with the counts
if r(max)/`step' < 2       local step = `step'/5
else if r(max)/`step' < 5  local step = `step'/2
local ytop = `step' * ceil(1.1*r(max)/`step')               // headroom for the count labels
* Bands: the year with no annual file, and the year whose ownership answers are not used.
gen double band_lo = 0 if strpos(" `gapyr' ", " " + string(x) + " ")
gen double band_hi = `ytop' if !missing(band_lo)
gen double bad_lo = 0 if x == `acq_bad'
gen double bad_hi = `ytop' if x == `acq_bad'
gen str8 tot_lbl  = string(tot, "%9.0fc") if tot > 0 & !missing(tot)
gen str8 back_lbl = string(back, "%9.0fc") if !missing(back)
* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local txt "Notes: Acquisition here = the first year a firm reports foreign owners holding 10% or more of its capital, after an earlier year below 10%."
local txt "`txt' It is a change in the reported share, not a verified purchase: the chart cannot show who bought the firm or why. Each firm is counted"
local txt "`txt' once, in that year. Majority = 50% or more foreign in that year. Right bars: of these firms, those back below 10% at their next answer"
local txt "`txt' (`t_acq_back_below_next' of the `t_acq_with_later_answer' with a later answer; none is possible after the last file)."
if "`apxtxt'" != "" local txt "`txt' Starts in `apxtxt' are dated approximately: the year before has no file or no usable answer."
local txt "`txt' All `acq_bad' ownership answers are treated as unknown (`s_bad'% of firms marked 10%+ foreign-owned, about `s_oth'% in other years);"
local txt "`txt' as filed, `n_bad_c' firms would start in `acq_bad' (here `n_bad_later_c' get a later year, `n_bad_never_c' count as never foreign-owned)."
local txt "`txt' Not shown: `g9001' firms never seen 10%+ foreign-owned (the comparison firms in later R7 figures), `g9002' foreign-owned when"
local txt "`txt' first seen (start unknown), `g9003' with no usable answer. Firm links are fictional, so most starts and reversals here come from the"
local txt "`txt' fake panel: a test of the method only."
local maxw 54                                           // widest note line that fits the 8-inch PDF
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
twoway (rbar band_lo band_hi x, barwidth(0.9) fcolor(gs15) lcolor(gs15) lwidth(none)) ///
    (rbar bad_lo bad_hi x, barwidth(0.9) fcolor(white) lcolor(gs8) lpattern(dash) lwidth(thin)) ///
    (rbar zero maj xa if tot > 0, barwidth(0.36) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
    (rbar maj tot xa if tot > 0, barwidth(0.36) fcolor(white) lcolor(gs4) lwidth(thin)) ///
    (rbar zero back xb if !missing(back), barwidth(0.36) fcolor(gs11) lcolor(gs11) lwidth(vthin)) ///
    (scatter tot xa if tot_lbl != "", msymbol(none) mlabel(tot_lbl) mlabposition(12) mlabgap(0.4) ///
        mlabcolor(black) mlabsize(vsmall)) ///
    (scatter back xb if back_lbl != "", msymbol(none) mlabel(back_lbl) mlabposition(12) mlabgap(0.4) ///
        mlabcolor(gs6) mlabsize(vsmall)) ///
    , xlabel(`yr0'(1)`yr1', labsize(vsmall) noticks) xscale(range(`=`yr0'-0.5' `=`yr1'+0.5') lcolor(gs10)) ///
    ylabel(0(`step')`ytop', angle(0) labsize(vsmall) grid glcolor(gs14) glwidth(vthin) noticks tlength(0) labgap(1.5)) ///
    yscale(range(0 `ytop') noline) ///
    xtitle("Acquisition year (first year seen with 10%+ foreign ownership)", size(vsmall) margin(t+1)) ///
    ytitle("Number of firms", size(vsmall) margin(r+2)) ///
    text(`=0.08*`ytop'' `yr0' "First" "file", size(vsmall) color(gs7)) ///
    text(`=0.90*`ytop'' `acq_bad' "As" "filed:" "`n_bad_c'" "starts", size(vsmall) color(gs6) placement(s)) ///
    legend(order(3 "Acquired, majority foreign-owned (50%+)" 4 "Acquired, minority foreign-owned (10–49%)" ///
                 5 "Of these, back below 10% at the next answer" 1 "No annual file" ///
                 2 "Ownership answers treated as unknown") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symysize(2.5) symxsize(4) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Firms first seen with a foreign owner holding 10% or more, by year", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none) margin(t+2 b=0)) ///
    xsize(8) ysize(6.5)

graph export "figures/`fname'.png", width(2400) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 7/7: companion table: every plotted point (putpdf)"
*---------------------------------------------------------------------------
* One row per plotted bar or bar label, in chart order (year, then left bar
* segments, its total label, then the right bar). Years or bars not drawn are
* listed with the reason. Chart and CSV are already written and stay unchanged.
keep acquisition_year acq_firms acq_majority acq_minority acq_with_later_answer acq_back_below_next firms_raw
expand 4
bysort acquisition_year: gen byte s = _n
gen str60 series = ""
replace series = "Acquired, majority foreign-owned (50%+)"     if s == 1
replace series = "Acquired, minority foreign-owned (10–49%)"   if s == 2
replace series = "Acquired, all (count on top of the bar)"      if s == 3
replace series = "Of these, back below 10% at the next answer"  if s == 4
gen double v  = cond(s == 1, acq_majority, cond(s == 2, acq_minority, cond(s == 3, acq_firms, acq_back_below_next)))
gen double of = cond(s == 4, acq_with_later_answer, acq_firms)
gen str80 status = "drawn"
replace status = "drawn (top label)" if s == 3
replace status = "not drawn: no acquirer has a later answer (last file)" if s == 4 & acq_with_later_answer == 0
replace v  = . if s == 4 & acq_with_later_answer == 0
replace of = . if s == 4 & acq_with_later_answer == 0
* Years with no bars: one row each, with the reason.
gen byte nobar = missing(acq_firms)
drop if nobar & s > 1
replace series = "All series" if nobar
replace status = "not drawn: first file, no earlier year to compare with" if nobar & acquisition_year == `yr0'
foreach g of local gapyr {
    replace status = "not drawn: no annual file" if nobar & acquisition_year == `g'
}
replace series = "As filed (text in the dashed box)" if nobar & acquisition_year == `acq_bad'
replace v = firms_raw if nobar & acquisition_year == `acq_bad'
replace status = "text only: ownership answers treated as unknown" if nobar & acquisition_year == `acq_bad'
replace v  = . if nobar & acquisition_year != `acq_bad'
replace of = . if nobar
sort acquisition_year s
gen str6  c_year = string(acquisition_year, "%4.0f")
gen str10 c_v    = cond(missing(v), "", string(v, "%9.0fc"))
gen str10 c_of   = cond(missing(of), "", string(of, "%9.0fc"))
quietly count
local nrow = r(N)
quietly count if strpos(status, "drawn") == 1
display "   points table: `nrow' rows, " r(N) " drawn points or labels"
putpdf clear
putpdf begin, pagesize(letter) font("Times New Roman", 9) margin(left, 0.8in) margin(right, 0.8in)
putpdf paragraph, spacing(after, 4pt)
putpdf text ("Table `exhibit'. Firms first seen with a foreign owner holding 10% or more, by year: every plotted point"), bold font("Times New Roman", 11)
matrix colw = (7, 37, 10, 10, 36)                 // column widths, % of the text width
putpdf table T = data(c_year series c_v c_of status), varnames border(all, nil) width(colw) halign(center)
putpdf table T(1,1) = ("Year")
putpdf table T(1,2) = ("Series (as in the legend)")
putpdf table T(1,3) = ("Firms plotted")
putpdf table T(1,4) = ("Out of (firms)")
putpdf table T(1,5) = ("Status")
putpdf table T(1,.), border(top, single, black) border(bottom, single, black) bold
putpdf table T(`=`nrow'+1',.), border(bottom, single, black)
putpdf table T(.,1), halign(left)
putpdf table T(.,3/4), halign(right)
putpdf table T(1,3/4), halign(right)
putpdf table T(.,5), margin(left, 12pt)
putpdf paragraph, spacing(before, 6pt) font("Times New Roman", 8)
local tnote "Out of = all acquirers of that year (left bar) or those with a later ownership answer (right bar)."
forvalues j = 1/`nl' {
    local tnote `"`tnote' `L`j''"'
}
local tnote = subinstr(`"`tnote'"', "Notes: ", "Chart notes: ", 1)
putpdf text (`"`tnote'"')
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`srcnote'")
putpdf paragraph, font("Times New Roman", 8)
putpdf text ("`devnote'")
putpdf save "tables/`fname'_table.pdf", replace
display "   table -> tables/`fname'_table.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
