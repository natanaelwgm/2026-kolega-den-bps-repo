/*==========================================================================
  R7-02  For the firms that got a foreign owner, how many are seen in each
         year before and after their acquisition, separately for firms
         acquired before and after the Paris Agreement? Which years since
         acquisition have enough firms on both sides for the later R7 charts
         (the R7 window), and how many comparison firms are there each year?
  Answers Bu Deasy R7: "Does FDI transmit greener technologies, and did this
         become stronger after Paris?" - Strategy "Event study around foreign
         acquisition" (the firm counts that event study stands on, and the
         common years that make before-Paris and after-Paris acquirers
         comparable).
  Output : figures/02_acquisition_support.png (+ .pdf)
           tables/02_acquisition_support.csv (also holds the R7 window, the
           window under other versions, and comparison firms by calendar year)
           tables/02_acquisition_support_table.pdf (every plotted number;
           counts only, no regression, so no regression table)
  Needs  : nothing beyond official Stata 17.
  Built from: R7-01 (the ACQUISITION REGISTRY block, copied exactly) and R2-02
         (year-window rule, grid of counts); usable rows and energy records in
         doubt as in R2-08. The R7 SAMPLE AND WINDOW block below is new here
         and is copied exactly into R7-03 to R7-07.
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
local exhibit "R7-02"
local fname   "02_acquisition_support"

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: firms seen before and after a foreign acquisition, acquired before vs after Paris ==="

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
* fdi_10_flag           = 1 if that share is 10% or more (checked against the share below)
* export_flag, import_flag = export / import status (find energy records in doubt;
*                         the registry also counts export / import starts)
* total_gj_s1           = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1          = CO2 tonnes from the same fuels and electricity
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
local fileyrs ""
forvalues t = `yr0'/`yr1' {
    quietly count if year == `t'
    if r(N) == 0 local gapyr `gapyr' `t'
    else local fileyrs `fileyrs' `t'
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
display "Step 2/8: usable rows, energy records in doubt, years since acquisition, the R7 window"
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
local blo = `wlo' - 1                  // column code of the lower grouped end
local bhi = `whi' + 1                  // column code of the upper grouped end
local minfirms = `acq_minfirms'
tempfile rows firmacq et cells comp summ vers all
save `rows'

*---------------------------------------------------------------------------
display "Step 3/8: the same window rule under the other versions later R7 files show (CSV only)"
*---------------------------------------------------------------------------
* Later R7 files keep the main window for every version; these rows only show
* how far each version alone would reach. Versions: records in doubt kept;
* exactly dated acquisitions only; 2020 ownership answers as filed; majority
* (50%+) acquisitions.
clear
set obs 5
gen int vorder = _n
gen str70 version = ""
replace version = "Main: records in doubt left out" in 1
replace version = "Records in doubt kept" in 2
replace version = "Exactly dated acquisitions only" in 3
replace version = "Ownership answers of `acq_bad' as filed" in 4
replace version = "Majority (50%+) acquisitions" in 5
gen int window_k = .
replace window_k = `acq_K' in 1
save `vers'
forvalues v = 2/5 {
    use `rows', clear
    if `v' == 2 {
        gen int gv = acq_year
        gen byte rowok = acq_usable
    }
    if `v' == 3 {
        gen int gv = acq_year if acq_exact == 1
        gen byte rowok = acq_usable & !acq_doubt
    }
    if `v' == 4 {
        gen int gv = acq_year_raw
        gen byte rowok = acq_usable & !acq_doubt
    }
    if `v' == 5 {
        gen int gv = acq_year_maj
        gen byte rowok = acq_usable & !acq_doubt
    }
    keep if rowok & !missing(gv)
    gen int k = year - gv
    gen byte bef = gv <= `acq_paris'
    gen byte aft = gv >  `acq_paris'
    collapse (sum) nb = bef na = aft, by(k)
    gen byte pass = nb >= `minfirms' & na >= `minfirms'
    local Kv 0
    local go 1
    while `go' {
        local kk = `Kv' + 1
        quietly count if pass & inlist(k, -`kk', `kk')
        if r(N) == 2 local Kv = `kk'
        else local go 0
    }
    use `vers', clear
    replace window_k = `Kv' in `v'
    save `vers', replace
}
use `vers', clear
list version window_k, noobs sep(0) abbreviate(24) clean
quietly summarize window_k if vorder == 2
local K_doubt = r(mean)

*---------------------------------------------------------------------------
display "Step 4/8: acquirers seen in each year since acquisition, by Paris period (panels A and B)"
*---------------------------------------------------------------------------
* Which years since acquisition can exist at all in each Paris period: an
* acquisition year of that period plus k must be a year with a file. Cells that
* cannot exist stay empty (not 0); cells that can exist but hold no firm are 0.
use `rows', clear
keep if !missing(acq_year)
keep firm_id acq_year acq_after
duplicates drop acq_year acq_after, force
keep acq_year acq_after
tempfile gy
save `gy'
clear
local nf : word count `fileyrs'
set obs `nf'
gen int fyear = .
forvalues j = 1/`nf' {
    local w : word `j' of `fileyrs'
    replace fyear = `w' in `j'
}
cross using `gy'
gen int acq_k = fyear - acq_year
gen byte possible = 1
collapse (max) possible, by(acq_after acq_k)
quietly summarize acq_k
local kmin = r(min)
local kmax = r(max)
tempfile poss
save `poss'
* Counts: every row of an acquirer is one firm in one year since acquisition.
use `rows', clear
keep if !missing(acq_year)
gen byte one        = 1
gen byte usable_all = acq_usable
gen byte doubt_u    = acq_usable & acq_doubt
gen byte main_ex    = acq_main & acq_exact == 1
collapse (sum) firms_seen = one usable_firms = usable_all doubt_firms = doubt_u ///
    main_firms = acq_main main_exact_firms = main_ex, by(acq_after acq_k)
merge 1:1 acq_after acq_k using `poss', nogenerate
fillin acq_after acq_k
replace possible = 0 if missing(possible)
foreach v in firms_seen usable_firms doubt_firms main_firms main_exact_firms {
    assert `v' == 0 | missing(`v') if !possible     // no firm where none can be
    replace `v' = 0 if missing(`v') & possible
    replace `v' = . if !possible
}
drop _fillin
* A year passes when both periods reach the minimum; it gets its own estimate in the window.
bysort acq_k (acq_after): egen byte both_pass = min(main_firms >= `minfirms' & !missing(main_firms))
gen byte own_estimate = inrange(acq_k, `wlo', `whi')
assert both_pass if own_estimate
quietly count if both_pass & inlist(acq_k, `blo', `bhi')
assert r(N) < 4                                      // the window stops where a year fails
sort acq_after acq_k
save `et'

*---------------------------------------------------------------------------
display "Step 5/8: grid by acquisition year x years since acquisition (panel C), comparison firms, CSV"
*---------------------------------------------------------------------------
* Columns: each year of the window on its own, plus the two grouped ends. In a
* grouped end a firm is counted once, however many years it has there.
use `rows', clear
keep if !missing(acq_year)
gen int col = cond(acq_k < `wlo', `blo', cond(acq_k > `whi', `bhi', acq_k))
egen byte m_tag = tag(firm_id col) if acq_main
replace m_tag = 0 if missing(m_tag)
preserve
collapse (sum) main_firms = m_tag, by(acq_after col)      // all acquirers of each period
gen int acquisition_year = .
tempfile tots
save `tots'
restore
collapse (sum) main_firms = m_tag, by(acq_year acq_after col)
rename acq_year acquisition_year
* Every acquisition year x column, with the reason when a cell cannot hold firms.
fillin acquisition_year col
bysort acquisition_year (acq_after): replace acq_after = acq_after[1]
gen int calendar_year = acquisition_year + col if inrange(col, `wlo', `whi')
gen byte possible = 0
foreach f of local fileyrs {
    replace possible = 1 if inrange(col, `wlo', `whi') & calendar_year == `f'
    replace possible = 1 if col == `blo' & `f' < acquisition_year + `wlo'
    replace possible = 1 if col == `bhi' & `f' > acquisition_year + `whi'
}
gen byte nofile = 0
foreach g of local gapyr {
    replace nofile = 1 if calendar_year == `g'
}
replace main_firms = 0 if missing(main_firms) & possible
replace main_firms = . if !possible
drop if !possible & !nofile                                 // outside the files: no cell
drop _fillin
append using `tots'
* Check: the all-acquirers rows equal panels A and B inside the window.
preserve
keep if missing(acquisition_year) & inrange(col, `wlo', `whi')
rename (col main_firms) (acq_k tot_firms)
merge 1:1 acq_after acq_k using `et', keep(match) nogenerate
assert tot_firms == main_firms
restore
gen byte grouped = inlist(col, `blo', `bhi')
save `cells'

* Comparison firms (never seen 10%+ foreign-owned), by calendar year.
use `rows', clear
keep if acq_key == 9001
by firm_id: egen int n_main = total(acq_main)
gen byte one = 1
gen byte main2 = acq_main & n_main >= 2
gen byte seen_below = !missing(acq_own) & acq_own < 10
collapse (sum) comparison_rows = one comparison_seen_below10 = seen_below ///
    comparison_main_rows = acq_main comparison_main_rows_2plus = main2, by(year)
foreach g of local gapyr {
    set obs `=_N + 1'
    replace year = `g' in L                                 // empty row for the missing file
}
sort year
rename year calendar_year
save `comp'

* Firm-level summary counts.
use `rows', clear
by firm_id: egen int n_main = total(acq_main)
by firm_id: egen byte pre_m  = max(acq_main & inrange(acq_k, `wlo', -1))
by firm_id: egen byte post_m = max(acq_main & inrange(acq_k, 0, `whi'))
by firm_id: egen byte has_m1 = max(acq_main & acq_k == -1)
egen byte ftag = tag(firm_id)
local labs `" "Acquirers (all)" "Acquirers with 1+ usable year (main sample)" "Acquirers with 2+ usable years (can be compared with themselves)" "Acquirers with a usable year inside the window before AND from the acquisition year" "Acquirers with a usable row in the year just before the acquisition" "Firms never seen 10%+ foreign-owned (comparison firms)" "Comparison firms with 2+ usable years" "'
local conds `" "!missing(acq_year)" "!missing(acq_year) & n_main >= 1" "!missing(acq_year) & n_main >= 2" "!missing(acq_year) & pre_m & post_m" "!missing(acq_year) & has_m1" "acq_key == 9001" "acq_key == 9001 & n_main >= 2" "'
local nl : word count `labs'
forvalues j = 1/`nl' {
    local c : word `j' of `conds'
    quietly count if ftag & `c'
    local s_`j'_all = r(N)
    foreach p in 0 1 {
        quietly count if ftag & `c' & acq_after == `p'
        local s_`j'_`p' = r(N)
    }
}
clear
set obs `=3 * `nl''
gen int row_order = _n
gen str90 row_label = ""
gen str30 paris_group = ""
gen double firms = .
local r 0
forvalues j = 1/`nl' {
    local l : word `j' of `labs'
    foreach p in all 0 1 {
        local ++r
        replace row_label = "`l'" in `r'
        replace paris_group = cond("`p'" == "all", "All", cond("`p'" == "0", "Acquired up to `acq_paris'", "Acquired after `acq_paris'")) in `r'
        replace firms = `s_`j'_`p'' in `r'
    }
}
drop if strpos(row_label, "omparison") > 0 & paris_group != "All"   // comparison firms have no acquisition
* Structural checks (hold on any data).
assert `s_1_0' + `s_1_1' == `s_1_all'
assert `s_2_all' <= `s_1_all' & `s_3_all' <= `s_2_all' & `s_4_all' <= `s_3_all' & `s_7_all' <= `s_6_all'
gen str12 section = "summary"
save `summ'

* Stack the sections into one long CSV (one row per number set).
use `vers', clear
rename version row_label
gen str12 section = "window"
append using `summ'
append using `et'
replace section = "event_time" if missing(section)
append using `cells'
replace section = "cell" if missing(section)
append using `comp'
replace section = "comparison" if missing(section)
replace paris_group = cond(acq_after == 0, "Acquired up to `acq_paris'", "Acquired after `acq_paris'") ///
    if inlist(section, "event_time", "cell")
gen int years_since = acq_k if section == "event_time"
replace years_since = col if section == "cell"
gen str40 column = ""
replace column = cond(years_since > 0, "+", "") + string(years_since) if !missing(years_since)
replace column = "`blo' or earlier (grouped)" if section == "cell" & col == `blo'
replace column = "+`bhi' or later (grouped)"  if section == "cell" & col == `bhi'
replace row_label = "All acquired up to `acq_paris'" if section == "cell" & missing(acquisition_year) & acq_after == 0
replace row_label = "All acquired after `acq_paris'" if section == "cell" & missing(acquisition_year) & acq_after == 1
replace row_label = "Acquired in " + string(acquisition_year) if section == "cell" & !missing(acquisition_year)
replace row_label = "By years since acquisition" if section == "event_time"
replace row_label = "Never seen 10%+ foreign-owned" if section == "comparison"
gen str100 note = ""
replace note = "Cannot exist: no file that many years from any acquisition year of this period" if section == "event_time" & !possible
replace note = "Grouped end: each firm counted once" if section == "cell" & grouped == 1
replace note = "No annual file" if inlist(section, "cell", "comparison") & strpos(" `gapyr' ", " " + string(calendar_year) + " ")
replace note = "Ownership answers treated as unknown this year (none seen below 10%)" if section == "comparison" & calendar_year == `acq_bad'
replace note = "Main window; every later R7 file uses it" if section == "window" & vorder == 1
gen int window_first = `wlo'
gen int window_last  = `whi'
gen int min_firms    = `minfirms'
gen byte sorder = 1*(section=="window") + 2*(section=="summary") + 3*(section=="event_time") + 4*(section=="cell") + 5*(section=="comparison")
gen byte arow = missing(acquisition_year) & section == "cell"
sort sorder vorder row_order acq_after arow acquisition_year years_since calendar_year
order section row_label paris_group acquisition_year column years_since calendar_year firms window_k ///
      firms_seen usable_firms doubt_firms main_firms main_exact_firms possible both_pass own_estimate ///
      comparison_rows comparison_seen_below10 comparison_main_rows comparison_main_rows_2plus ///
      window_first window_last min_firms note
keep section-note acq_after col grouped nofile sorder arow
format firms-min_firms %9.0f
save `all'
drop acq_after col grouped nofile sorder arow
export delimited using "tables/`fname'.csv", datafmt replace
use `all', clear
list row_label paris_group firms window_k if inlist(section, "window", "summary"), noobs sep(0) abbreviate(24) clean
list paris_group column firms_seen usable_firms doubt_firms main_firms both_pass if section == "event_time" & inrange(years_since, `blo', `bhi'), ///
    noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 6/8: numbers quoted in the notes (read from the table, never typed)"
*---------------------------------------------------------------------------
foreach j in 1 6 7 {
    local n`j' = strtrim(string(`s_`j'_all', "%9.0fc"))
}
local n4b = strtrim(string(`s_4_0', "%9.0fc"))
local n4a = strtrim(string(`s_4_1', "%9.0fc"))
* Share of usable rows inside the window left out as energy records in doubt, by period.
use `et', clear
foreach p in 0 1 {
    quietly summarize doubt_firms if acq_after == `p' & own_estimate
    local dd = r(sum)
    quietly summarize usable_firms if acq_after == `p' & own_estimate
    local dsh`p' = string(100 * `dd' / r(sum), "%9.0f")
}
use `all', clear
* The first acquisition year after Paris that has a file (the panel B heading).
quietly summarize acquisition_year if section == "cell" & acq_after == 1
local firstafter = r(min)
quietly summarize acquisition_year if section == "cell" & acq_after == 0
local firstbefore = r(min)

*---------------------------------------------------------------------------
display "Step 7/8: panels A and B = acquirers seen per year since acquisition; panel C = the grid"
*---------------------------------------------------------------------------
* ---- panels A and B: one bar per year since acquisition, same scale ----
use `all', clear
keep if section == "event_time"
gen double x = years_since
gen double zero = 0
gen double own = main_firms if own_estimate
gen double out = main_firms if !own_estimate
gen str8 lbl = string(main_firms, "%9.0fc") if !missing(main_firms)
quietly summarize main_firms
local step = 10^floor(log10(r(max)))                        // axis step that grows with the counts
if r(max)/`step' < 2       local step = `step'/5
else if r(max)/`step' < 5  local step = `step'/2
local ytop = `step' * ceil(1.15*r(max)/`step')              // headroom for the count labels
if `ytop'/`step' > 5 local step = 2*`step'                   // short panels: at most about 5 gridlines
local xlab ""
forvalues k = `kmin'/`kmax' {
    local s = cond(`k' > 0, "+`k'", "`k'")
    local xlab `"`xlab' `k' "`s'""'
}
local x0 = `kmin' - 0.6
local x1 = `kmax' + 0.6
foreach p in 0 1 {
    local ptitle = cond(`p' == 0, "A. Acquired `firstbefore'–`acq_paris' (up to the Paris Agreement): firms with usable data in each year", ///
                                 "B. Acquired `firstafter'–`yr1' (after the Paris Agreement): firms with usable data in each year")
    if `p' == 0 {
        local legopt "legend(off)"
        local xt `"xtitle("")"'
    }
    else {
        local legopt `"legend(order(1 "Shown on its own later (`minfirms'+ firms in A and B)" 2 "Outer year, grouped at the ends" 3 "`minfirms' firms") rows(1) position(6) region(lstyle(none)) size(vsmall) symysize(2) symxsize(4) keygap(1) colgap(3))"'
        local xt `"xtitle("Years since acquisition (0 = acquisition year; -1 = the year before)", size(vsmall) margin(t+1))"'
    }
    twoway (rbar zero own x if acq_after == `p', barwidth(0.72) fcolor(gs4) lcolor(gs4) lwidth(vthin)) ///
        (rbar zero out x if acq_after == `p', barwidth(0.72) fcolor(gs12) lcolor(gs12) lwidth(vthin)) ///
        (pci `minfirms' `x0' `minfirms' `x1', lpattern(dash) lcolor(gs5) lwidth(thin)) ///
        (scatter main_firms x if acq_after == `p' & lbl != "", msymbol(none) mlabel(lbl) mlabposition(12) ///
            mlabgap(0.3) mlabcolor(black) mlabsize(vsmall)), ///
        xlabel(`xlab', labsize(vsmall) noticks) xscale(range(`x0' `x1') lcolor(gs10)) ///
        ylabel(0(`step')`ytop', angle(0) labsize(vsmall) grid glcolor(gs14) glwidth(vthin) noticks tlength(0) labgap(1.5)) ///
        yscale(range(0 `ytop') noline) ytitle("Number of firms", size(vsmall) margin(r+1)) ///
        `xt' `legopt' ///
        subtitle("`ptitle'", size(small) position(11) justification(left) nobox span margin(b+1)) ///
        graphregion(color(white) lcolor(white)) plotregion(style(none) margin(t+1 b=0)) ///
        fysize(`=cond(`p' == 1, 33, 26)') name(p`p', replace) nodraw
}

* ---- panel C: the counts by acquisition year drawn as a table ----
use `all', clear
keep if section == "cell"
gen double row = .
local ylab ""
local r 0
quietly levelsof acquisition_year if acq_after == 0, local(gb)
quietly levelsof acquisition_year if acq_after == 1, local(ga)
foreach g of local gb {
    local ++r
    replace row = `r' if acquisition_year == `g'
    local ylab `"`ylab' `r' "`g'""'
}
local ysep1 = `r' + 0.65
local r = `r' + 0.3
foreach g of local ga {
    local ++r
    replace row = `r' if acquisition_year == `g'
    local ylab `"`ylab' `r' "`g'""'
}
local ysep2 = `r' + 0.65
local rA = `r' + 1.3
local rB = `r' + 2.3
replace row = `rA' if arow & acq_after == 0
replace row = `rB' if arow & acq_after == 1
local ylab `"`ylab' `rA' "All up to `acq_paris'" `rB' "All after `acq_paris'""'
gen double xc = years_since
gen str8 clbl = string(main_firms, "%9.0fc") if !missing(main_firms)
gen double lo = row - 0.42 if nofile == 1
gen double hi = row + 0.42 if nofile == 1
local cxlab `"`blo' "≤ `blo'""'
forvalues k = `wlo'/`whi' {
    local s = cond(`k' > 0, "+`k'", "`k'")
    local cxlab `"`cxlab' `k' "`s'""'
}
local cxlab `"`cxlab' `bhi' "≥ +`bhi'""'
local xl = `wlo' - 0.5                                 // dashed edges of the year-by-year columns
local xr = `whi' + 0.5
local ytp = 0.55
local ybot = `rB' + 0.5
twoway (rbar lo hi xc, barwidth(0.92) fcolor(gs14) lcolor(gs14) lwidth(none)) ///
    (pci `ytp' `xl' `ybot' `xl' `ytp' `xr' `ybot' `xr', lpattern(dash) lcolor(gs7) lwidth(thin)) ///
    (pci `ysep1' `=`blo'-0.5' `ysep1' `=`bhi'+0.5' `ysep2' `=`blo'-0.5' `ysep2' `=`bhi'+0.5', lcolor(gs11) lwidth(vthin)) ///
    (scatter row xc if !arow, msymbol(none) mlabel(clbl) mlabposition(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter row xc if arow, msymbol(none) mlabel(clbl) mlabposition(0) mlabsize(vsmall) mlabcolor(black)), ///
    yscale(reverse range(-0.4 `ybot') noline) ///
    ylabel(`ylab', angle(0) labsize(vsmall) noticks nogrid tlength(0) labgap(1)) ///
    ytitle("Acquisition year", size(vsmall)) ///
    xscale(range(`=`blo'-0.5' `=`bhi'+0.5') noline) xlabel(`cxlab', labsize(vsmall) noticks tlength(0) labgap(0.5)) ///
    xtitle("Years since acquisition (0 = acquisition year; -1 = the year before)", size(vsmall)) ///
    text(-0.05 `blo' "Grouped", size(vsmall) color(gs5)) ///
    text(-0.05 0 "Shown year by year in later R7 charts", size(vsmall) color(gs5)) ///
    text(-0.05 `bhi' "Grouped", size(vsmall) color(gs5)) ///
    legend(order(1 "No annual file" 2 "Edge of the year-by-year columns") rows(1) position(6) ///
        region(lstyle(none)) size(vsmall) symysize(2) symxsize(4) keygap(1) colgap(4)) ///
    subtitle("C. The same firms by acquisition year (rows) and years since acquisition (columns)", ///
        size(small) position(11) justification(left) nobox span margin(b+1)) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none) margin(zero)) ///
    fysize(46) name(pC, replace) nodraw

* Notes as one text, wrapped by printed width (R2-08's rule; widths in em).
local gaptxt = strtrim("`gapyr'")
local txt "Notes: Acquisition here = the first year a firm reports foreign owners holding 10% or more of its capital, after an earlier year"
local txt "`txt' below 10% (a change in the reported share, not a verified purchase); none can be dated in `gaptxt' (no file) or `acq_bad'"
local txt "`txt' (ownership answers unusable). A firm counts in a year when its energy use (GJ), CO2 and value added are all above zero."
local txt "`txt' Energy records in doubt (importers with unknown export status in some later files) are left out: `dsh1'% of B's usable"
local txt "`txt' years in the window, `dsh0'% of A's. A year since acquisition is shown on its own in later charts only when A and B both"
local txt "`txt' have `minfirms'+ firms in it, so firms acquired before and after Paris (adopted December `acq_paris') are compared over the same years."
local txt "`txt' `n4b' (A) and `n4a' (B) acquirers have usable years both before and from the acquisition inside the window; the `n6' firms never"
local txt "`txt' seen 10%+ foreign-owned (`n7' with 2+ usable years) are the comparison firms. This shows how many firms can be compared,"
local txt "`txt' not how they changed. Firm links are fictional: a test of the method only."
local maxw 43                                           // widest note line that fits the 9-inch PDF
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
graph combine p0 p1 pC, cols(1) iscale(0.8) imargin(0 0 1 1) ///
    title("Figure `exhibit'. Firms seen before and after they got a foreign owner", size(small) ///
        position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) xsize(9) ysize(11.5)

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion table: every plotted number (putpdf)"
*---------------------------------------------------------------------------
* One row per bar of panels A and B (every year since acquisition on the axis,
* including years no firm of that period can reach) and per number of panel C,
* in chart order. Chart and CSV are already written and stay unchanged.
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
* ---- the table rows: panels A and B ----
use `all', clear
keep if section == "event_time"
gen str60 c_panel = cond(acq_after == 0, "A. Acquired `firstbefore'–`acq_paris'", "B. Acquired `firstafter'–`yr1'")
gen str40 c_row   = "All acquirers"
gen str10 c_k     = column
gen str6  c_cal   = ""
gen str10 c_v     = cond(missing(main_firms), "", string(main_firms, "%9.0fc"))
gen str90 c_st    = ""
replace c_st = "dark bar: shown year by year in later charts" if own_estimate & !missing(main_firms)
replace c_st = "light bar: outer year, grouped" if !own_estimate & !missing(main_firms)
replace c_st = "not drawn: no file this far away" if missing(main_firms)
gen int t1 = acq_after
gen int t2 = 0
gen int t3 = years_since
gen int t4 = 0
tempfile tab
save `tab'
* ---- panel C: every cell of the grid, including blank ones ----
use `all', clear
keep if section == "cell"
preserve
keep if arow
tempfile trows
save `trows'
restore
drop if arow
fillin acquisition_year col                              // blank cells come back here
bysort acquisition_year (acq_after): replace acq_after = acq_after[1]
replace arow = 0 if _fillin
append using `trows'
replace _fillin = 0 if missing(_fillin)
gen str60 c_panel = "C. By acquisition year"
gen str40 c_row   = cond(arow, cond(acq_after == 0, "All up to `acq_paris'", "All after `acq_paris'"), string(acquisition_year))
gen str10 c_k     = cond(col == `blo', "≤ `blo'", cond(col == `bhi', "≥ +`bhi'", cond(col > 0, "+", "") + string(col)))
replace calendar_year = acquisition_year + col if _fillin & inrange(col, `wlo', `whi')
gen str6  c_cal   = cond(missing(calendar_year), "", string(calendar_year))
gen str10 c_v     = cond(missing(main_firms), "", string(main_firms, "%9.0fc"))
gen str90 c_st    = "shown"
replace c_st = "shown: grouped end, firm once" if inlist(col, `blo', `bhi') & !missing(main_firms)
replace c_st = "gray, no number: no annual file" if nofile == 1
replace c_st = "blank: outside the files" if _fillin
gen int t1 = 2
gen int t2 = cond(arow, 2 + acq_after, 0)
gen int t3 = cond(arow, 0, acquisition_year)
gen int t4 = col
keep c_* t1-t4
append using `tab'
keep c_* t1-t4
sort t1 t2 t3 t4
* thin rules between panels and between acquisition years of panel C
gen long rn = _n
local rl ""
quietly count
local N = r(N)
forvalues i = 1/`=`N' - 1' {
    if t1[`i'] != t1[`i' + 1] | (t1[`i'] == 2 & (t3[`i'] != t3[`i' + 1] | t2[`i'] != t2[`i' + 1])) local rl `rl' `i'
}
quietly count if c_v != ""
display "   points table: `N' rows, " r(N) " plotted numbers"
local tnotes ""
forvalues j = 1/`nl' {
    local tnotes `"`tnotes' `L`j''"'
}
local tnotes = subinstr(`"`tnotes'"', "Notes: ", "Chart notes: ", 1)
local tnotes = strtrim(`"`tnotes'"')
local lead "Firms plotted = acquirers with a usable year (energy, CO2 and value added above zero; energy records in doubt left out) at that many years from their acquisition; each firm-year counted once, and in panel C's grouped ends each firm once."
ctable_pdf c_panel c_row c_k c_cal c_v c_st using "tables/`fname'_table.pdf", ///
    title("Table `exhibit'. Firms seen before and after they got a foreign owner: every plotted point") ///
    header("Panel" "Row" "Years since|acquisition" "Calendar|year" "Firms" "Status") ///
    right(3 4 5) norepeat(1 2) rules(`rl') ///
    notes("`lead'" `"`tnotes'"' "`srcnote'" "`devnote'")
display "   table -> tables/`fname'_table.pdf"

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
