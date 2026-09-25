/*==========================================================================
  R2-10  The previous paper's four methods for the other start events: after
         a firm starts importing, gets a foreign owner (10% or more of its
         capital), or starts trading at all (exporting or importing), does it
         get more value added out of each unit of energy than firms that
         never do - and does the answer depend on the method?
  Answers Deasy R2: "Intertionalized and energy efficiency" - Strategy
         "Stagged did" - Notes "Mirip dengan paper kita sebelumnya hanya
         Ganti tahun" (its four estimators: Callaway-Sant'Anna = csdid,
         Sun-Abraham = eventstudyinteract, Borusyak-Jaravel-Spiess =
         did_imputation, de Chaisemartin-D'Haultfoeuille = did_multiplegt_dyn;
         its import-start, foreign-owner-start and "any trade" start events;
         its outcome ln value added per GJ).
  Output : figures/10_methods_import_foreign_start.png (+ .pdf)
           tables/10_methods_import_foreign_start.csv
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
  Built from: R2-07 (the four methods, same code) and R2-08 (start events,
           repairs of known recording problems, year window).
  Checks : R2-08's averages (re-estimated here) against its table when present
  Note   : Sun-Abraham leaves out start years whose year before has no file
           (the year after the missing file): with no reference year, the
           package would silently measure those starters against their last
           years instead (see Step 4).
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r2-internationalisation-energy-efficiency"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
local exhibit "R2-10"
local fname   "10_methods_import_foreign_start"
* ---- KNOWN RECORDING PROBLEMS (as R2-08; Step 1 re-checks each one on any
* data and prints a WARNING if it no longer looks like a problem) ----------
* Import starts dated in this year are left out: from this file on, far more
* firms count as importers than in the file before (likely a change in how
* imports were recorded), so a "start" here may be a recording change. For
* "any trade" this applies to starts dated in this year that come with importing.
local imp_bad "2017"
* Foreign-ownership answers of this year are treated as unknown: in this file
* far more firms are marked foreign-owned than in any other year.
local fdi_bad "2020"
* Years whose energy records are in doubt for importers with unknown export
* status (their recorded energy jumps far up, then falls to about a fifth,
* while value added per worker stays flat; R1-03/R1-04 reviews, R2-06, R2-08).
local doubt_yrs "2017 2019 2020 2021 2022"
local minfirms 30               // R2-02's rule: 30+ starters for a year of its own
* ---------------------------------------------------------------------------

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: value added per GJ after import, foreign-owner and any-trade starts, five methods ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/7: load trade and ownership status, energy, CO2 and value added; re-check the known problems; check the method packages"
*---------------------------------------------------------------------------
* import_flag         = imports reported above zero (1 yes, 0 no; never missing)
* fdi_10_flag         = foreign ownership of 10% or more (the previous paper's rule)
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes (only used to keep the same rows as R2-03 to R2-08)
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year import_flag fdi_10_flag export_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
sort firm_id year
tsset firm_id year                 // L. and F. below mean exact calendar years
* The calendar year with no annual file (found in the data, never typed).
quietly summarize year
local gapyr ""
forvalues t = `r(min)'/`r(max)' {
    quietly count if year == `t'
    if r(N) == 0 local gapyr `gapyr' `t'
}
local gapyr = strtrim("`gapyr'")
local gap1 : word 1 of `gapyr'
if "`gap1'" == "" local gap1 = 9999
display "   calendar years with no file: `gapyr'"
* Guards (R2-08's, unchanged): the problems at the top must still show in the data.
preserve
collapse (mean) sh_imp = import_flag sh_fdi = fdi_10_flag, by(year)
quietly summarize year if year < `imp_bad'
local imp_prev = r(max)
quietly summarize sh_imp if year == `imp_prev'
local shi0 = r(mean)
quietly summarize sh_imp if year == `imp_bad'
local shi1 = r(mean)
if `shi1' < 1.5 * `shi0' display "   WARNING: import share `imp_prev' -> `imp_bad' does not jump (" %4.2f `shi0' " -> " %4.2f `shi1' ") - re-check imp_bad at the top"
else display "   import share `imp_prev' -> `imp_bad': " %4.2f `shi0' " -> " %4.2f `shi1' " (import starts dated `imp_bad' left out)"
quietly summarize sh_fdi if year != `fdi_bad', detail
local shf0 = r(p50)
quietly summarize sh_fdi if year == `fdi_bad'
local shf1 = r(mean)
if `shf1' < 2 * `shf0' display "   WARNING: foreign-owned share in `fdi_bad' looks normal (" %4.2f `shf1' " vs " %4.2f `shf0' ") - re-check fdi_bad at the top"
else display "   foreign-owned share: `fdi_bad' " %4.2f `shf1' " vs middle of other years " %4.2f `shf0' " (`fdi_bad' answers treated as unknown)"
restore
* Usable row = energy, CO2 and value added all above zero, so every log exists
* (as in R2-03 to R2-08). A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
* Doubtful energy records (R2-06's definition): importers whose export status is
* unknown, in the years listed at the top. Left out of the main version.
local dlist = subinstr(strtrim(itrim("`doubt_yrs'")), " ", ",", .)
gen byte doubt = missing(export_flag) & import_flag == 1 & inlist(year, `dlist')
gen double gjva = total_gj_s1 / value_added_nominal if usable
foreach yy of local doubt_yrs {
    quietly summarize gjva if doubt & year == `yy', detail
    local md = r(p50)
    local nd = r(N)
    quietly summarize gjva if !doubt & year == `yy', detail
    local ratio = `md' / r(p50)
    if `nd' == 0 display "   WARNING: no doubtful rows in `yy' - re-check doubt_yrs at the top"
    else if inrange(`ratio', 0.5, 2) display "   WARNING: in `yy' doubtful rows look normal (median ratio " %4.2f `ratio' ") - re-check doubt_yrs"
    else display "   `yy': " %5.0fc `nd' " doubtful rows; their middle energy per unit of value added = " %5.2f `ratio' " x the other rows'"
}
drop gjva
* Foreign ownership with the `fdi_bad' answers treated as unknown (main version).
gen byte fdi_fixed = fdi_10_flag
replace fdi_fixed = . if year == `fdi_bad'
* Any trade (the previous paper's "any trade" start): 1 = exports or imports;
* 0 = seen doing neither (both answers known and "no"); otherwise unknown.
* (The previous paper also counted "no import, export unknown" as 0.)
gen byte any_trade = .
replace any_trade = 1 if export_flag == 1 | import_flag == 1
replace any_trade = 0 if export_flag == 0 & import_flag == 0
* The four methods are user-written Stata commands (install once, e.g.
* -ssc install csdid-). Each needs its helper command(s). A missing one is
* recorded and its method gets an "unavailable" row.
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

*---------------------------------------------------------------------------
display "Step 2/7: date each firm's start (rule A, same code as every R2 file) for the three events"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry: the first year the firm is seen participating,
*   if it was seen NOT participating in some earlier year. Firms participating
*   when first seen cannot be dated and are left out. A starter stays a
*   starter if it stops later.
* Comparison group: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (excluded) · 9003 status never observed (excluded).
* Events: imp = importing; fdi = foreign owner 10%+ with the `fdi_bad' answers
* unknown (main); fdiraw = the same, answers as filed (as-filed version);
* any = exporting or importing.
foreach m in imp fdi fdiraw any {
    if "`m'" == "imp"    local x import_flag
    if "`m'" == "fdi"    local x fdi_fixed
    if "`m'" == "fdiraw" local x fdi_10_flag
    if "`m'" == "any"    local x any_trade
    * --- Rule A ---
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
    rename (keyA gA) (key_`m' g_`m')
    drop first_yes first_no n_known
}
* Does an any-trade start come with importing (= it is also the firm's import start)?
by firm_id: egen byte any_imp0 = max(year == g_any & import_flag == 1)
by firm_id: egen byte any_exp0 = max(year == g_any & export_flag == 1)
assert g_any == g_imp if any_imp0                                           // importing at the start = import start
* Starts moved by the repairs (CSV and log), counted per firm.
egen byte ftag = tag(firm_id)
quietly count if ftag & g_imp == `imp_bad'
local n_impbad = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad'
local n_fdibad = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad' & key_fdi == 9001
local n_fdibad_never = r(N)
quietly count if ftag & g_fdiraw == `fdi_bad' & !missing(g_fdi)
local n_fdibad_redated = r(N)
quietly count if ftag & g_any == `imp_bad'
local n_anybad = r(N)
quietly count if ftag & g_any == `imp_bad' & any_imp0
local n_anybad_out = r(N)
display "   import starts dated `imp_bad' (left out): `n_impbad'"
display "   foreign-owner starts dated `fdi_bad' as filed: `n_fdibad' (`n_fdibad_never' become never foreign-owned, `n_fdibad_redated' get a later start year)"
display "   any-trade starts dated `imp_bad': `n_anybad' (`n_anybad_out' come with importing and are left out; `=`n_anybad'-`n_anybad_out'' start by exporting only and stay)"
drop ftag

*---------------------------------------------------------------------------
display "Step 3/7: the year window (R2-02's rule) for each main sample; all panels use the narrowest"
*---------------------------------------------------------------------------
* Main samples (black dots): starters (repaired as above) plus firms never seen
* participating; usable rows; doubtful energy records left out.
* As-filed samples (gray triangles): every start and every usable record as filed.
gen byte main_imp  = usable & !doubt & ((!missing(g_imp) & g_imp != `imp_bad') | key_imp == 9001)
gen byte main_fdi  = usable & !doubt & (!missing(g_fdi) | key_fdi == 9001)
gen byte main_any  = usable & !doubt & ((!missing(g_any) & !(g_any == `imp_bad' & any_imp0)) | key_any == 9001)
gen byte filed_imp = usable & (!missing(g_imp) | key_imp == 9001)
gen byte filed_fdi = usable & (!missing(g_fdiraw) | key_fdiraw == 9001)
gen byte filed_any = usable & (!missing(g_any) | key_any == 9001)
tempfile fy est
save `fy'
local K 99
foreach m in imp fdi any {
    use `fy', clear
    keep if main_`m' & !missing(g_`m')
    gen int k = year - g_`m'
    gen byte early = g_`m' < `gap1'
    gen byte late  = g_`m' > `gap1'
    collapse (count) n = firm_id (max) early late, by(k)
    gen byte passes = n >= `minfirms' & early & late
    assert passes if inlist(k, -1, 0)
    local K_`m' 0
    local go 1
    while `go' {
        local kk = `K_`m'' + 1
        quietly count if passes & inlist(k, -`kk', `kk')
        if r(N) == 2 local K_`m' = `kk'
        else local go 0
    }
    local K = min(`K', `K_`m'')
    display "   `m': R2-02's rule allows -`K_`m'' to +`K_`m''"
}
local wlo = -`K'
local whi = `K'
local nout = `whi' + 1
display "   window used in every panel: each year from `wlo' to +`whi' on its own; `nout'+ years before or after grouped"

*---------------------------------------------------------------------------
display "Step 4/7: each start event and version under each method"
*---------------------------------------------------------------------------
* All five: log value added per GJ, firm and year effects, starters compared
* with firms never seen participating, clustered by firm, no control variables.
* What differs is how start years and years since the start are combined
* (R2-07). Main number per method = average of years 0 to +`whi' with each year
* counting equally; each method's own single overall number is kept too.
* Counts behind each estimate: starters with a row from the start year on,
* comparison firms and rows, all inside the estimation sample (variable es).
capture program drop r210_used
program define r210_used, rclass
    quietly {
        egen byte r210_fs = tag(firm_id) if es & !never & year >= gA
        count if r210_fs == 1
        return scalar starters = r(N)
        egen byte r210_fc = tag(firm_id) if es & never
        count if r210_fc == 1
        return scalar comp = r(N)
        count if es
        return scalar rows = r(N)
        drop r210_fs r210_fc
    }
end
tempname h
postfile `h' str3 event byte version byte morder str8 method str12 row_type int event_time double(b se df) ///
    long(starters comp_firms rows) str80 status str120 note double pin using `est'
timer clear 2
timer on 2
local enum 0
foreach e in imp fdi any {
    local ++enum
    forvalues v = 1/2 {
        * ---- the sample of this event and version ----
        use `fy', clear
        local gv "g_`e'"
        local kv "key_`e'"
        if `v' == 2 & "`e'" == "fdi" {
            local gv "g_fdiraw"
            local kv "key_fdiraw"
        }
        if `v' == 1 keep if main_`e'
        else        keep if filed_`e'
        gen int gA = `gv'
        gen byte never = missing(gA)
        assert `kv' == 9001 if never                        // comparison = never seen participating only
        gen int kA = year - gA
        gen double y = ln(value_added_nominal / total_gj_s1) // log value added per GJ (R2-03's outcome)
        * R2-03's markers: one per year since the start inside the window, except -1
        * (the year before the start = the reference), plus one for each grouped end.
        gen byte ev_lo = !missing(kA) & kA < `wlo'
        local terms "ev_lo"
        local pre   "ev_lo"
        local post  ""
        forvalues k = `wlo'/`whi' {
            if `k' == -1 continue
            local nm = cond(`k' < 0, "ev_m" + string(-`k'), "ev_p" + string(`k'))
            gen byte `nm' = (kA == `k')
            local terms `terms' `nm'
            if `k' < -1 local pre `pre' `nm'
            if `k' >= 0 local post `post' `nm'
        }
        gen byte ev_hi = !missing(kA) & kA > `whi'
        local terms `terms' ev_hi
        foreach t of local terms {
            quietly count if `t'
            assert r(N) > 0                                 // every marker has starter rows (window rule)
        }
        local lc = subinstr("`post'", " ", " + ", .)         // years 0..+`whi', for the average
        local np : word count `post'
        keep firm_id year gA kA y never any_imp0 `terms'
        sort firm_id year
        tempfile smp
        save `smp'
        display "   [`e' version `v'] sample ready"

        * ---- (1) one regression, all start years together (R2-03/R2-08's model) ----
        quietly reghdfe y `terms', absorb(firm_id year) vce(cluster firm_id)
        local df = e(df_r)
        capture drop es
        gen byte es = e(sample)
        r210_used
        local st = r(starters)
        local cf = r(comp)
        local rw = r(rows)
        * (c) only: how many of these starters start by importing (the rest by exporting only).
        if "`e'" == "any" & `v' == 1 {
            egen byte fti = tag(firm_id) if es & !never & year >= gA & any_imp0
            quietly count if fti == 1
            local any_imp_n = r(N)
            local any_imp_sh = r(N) / `st'
            drop fti
        }
        foreach t of local terms {
            if "`t'" == "ev_lo"      local k = `wlo' - 1
            else if "`t'" == "ev_hi" local k = `whi' + 1
            else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
            local nt = cond(inlist("`t'", "ev_lo", "ev_hi"), "grouped end", "")
            post `h' ("`e'") (`v') (1) ("twfe") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
        }
        quietly lincom (`lc') / `np'
        local tw_`e'`v' = r(estimate)
        post `h' ("`e'") (`v') (1) ("twfe") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("reghdfe, R2-03's markers") (.)
        quietly test `pre'
        local twp_`e'`v' = r(p)
        post `h' ("`e'") (`v') (1) ("twfe") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (r(p))
        gen byte after = !never & year >= gA
        quietly reghdfe y after, absorb(firm_id year) vce(cluster firm_id)
        post `h' ("`e'") (`v') (1) ("twfe") ("own_overall") (.) (_b[after]) (_se[after]) (e(df_r)) (.) (.) (e(N)) ("ok") ("one on/off marker from the start year on (the previous paper's two-way model)") (.)
        * As filed: the one regression only (R2-08's gray triangles), to keep the
        * run time short; the four methods run on the main version.
        if `v' == 2 {
            display "   [`e' as filed] one regression done"
            continue
        }

        * ---- (2) Callaway-Sant'Anna (csdid): each start year vs never-starters ----
        * csdid lays out calendar years one by one, so the year with no file is a
        * real gap: starters whose year before the start has no file get no
        * after-start estimate. Its before-start check compares each year before
        * the start with the year before that, inside the window.
        if !`ok_cs' {
            post `h' ("`e'") (`v') (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_cs'")')") ("ssc install csdid; ssc install drdid") (.)
        }
        else {
            use `smp', clear
            gen int gcs = cond(never, 0, gA)                 // csdid wants 0 = never started
            capture quietly csdid y, ivar(firm_id) time(year) gvar(gcs)
            if _rc {
                post `h' ("`e'") (`v') (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: csdid stopped with error r(`=_rc')") ("") (.)
            }
            else {
                capture drop es
                gen byte es = e(sample)
                r210_used
                local st = r(starters)
                local cf = r(comp)
                local rw = r(rows)
                quietly estat simple
                matrix bb = r(b)
                matrix vv = r(V)
                post `h' ("`e'") (`v') (2) ("cs") ("own_overall") (.) (bb[1,1]) (sqrt(vv[1,1])) (.) (.) (.) (.) ("ok") ("estat simple: all years after the start, weighted by start-year size") (.)
                quietly estat event, window(`wlo' `whi')
                matrix bb = r(b)
                matrix vv = r(V)
                local cn : colnames bb
                foreach c of local cn {
                    local j = colnumb(bb, "`c'")
                    if "`c'" == "Post_avg" {
                        post `h' ("`e'") (`v') (2) ("cs") ("avg") (.) (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (`st') (`cf') (`rw') ("ok") ("estat event Post_avg: years 0 to +`whi', each counts equally") (.)
                    }
                    else if inlist(substr("`c'", 1, 2), "Tm", "Tp") {
                        local k = cond(substr("`c'", 2, 1) == "m", -1, 1) * real(substr("`c'", 3, .))
                        local nt = cond(`k' < 0, "change from the year before (csdid's own base for years before the start)", "vs the year before the start")
                        post `h' ("`e'") (`v') (2) ("cs") ("event") (`k') (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (.) (.) (.) ("ok") ("`nt'") (.)
                    }
                }
                capture quietly estat pretrend, window(`wlo' -1)
                local ptxt "estat pretrend inside the window"
                if _rc {
                    quietly estat pretrend                    // older csdid: no window option
                    local ptxt "estat pretrend, all years before the start"
                }
                post `h' ("`e'") (`v') (2) ("cs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("`ptxt'; p in column p") (r(pchi2))
                if "`ptxt'" == "estat pretrend inside the window" {
                    quietly estat pretrend
                    post `h' ("`e'") (`v') (2) ("cs") ("before_all") (.) (.) (.) (.) (.) (.) (.) ("ok") ("estat pretrend, all years before the start (table only); p in column p") (r(pchi2))
                }
            }
        }

        * ---- (3) Sun-Abraham (eventstudyinteract): R2-03's markers, start years kept apart ----
        if !`ok_sa' {
            post `h' ("`e'") (`v') (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_sa'")')") ("ssc install eventstudyinteract; ssc install avar") (.)
        }
        else {
            use `smp', clear
            * A start year whose year before has no file (the year after the missing
            * file) has no reference year: the package would silently measure those
            * starters against their grouped last years instead (it drops one of their
            * markers). Leave such start years out, as Callaway-Sant'Anna and
            * de Chaisemartin-D'Haultfoeuille do by construction.
            bysort gA: egen byte has_ref = max(kA == -1)
            egen byte ft0 = tag(firm_id) if !never & !has_ref
            quietly count if ft0 == 1
            local sa_out = r(N)
            drop if !never & !has_ref
            drop ft0 has_ref
            local sa_terms ""
            foreach t of local terms {
                quietly count if `t'
                if r(N) > 0 local sa_terms `sa_terms' `t'
            }
            assert "`sa_terms'" == "`terms'"                 // every marker still has starter rows
            capture quietly eventstudyinteract y `terms', cohort(gA) control_cohort(never) absorb(i.firm_id i.year) vce(cluster firm_id)
            if _rc {
                post `h' ("`e'") (`v') (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: eventstudyinteract stopped with error r(`=_rc')") ("") (.)
            }
            else {
                capture drop es
                gen byte es = e(sample)
                r210_used
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
                    post `h' ("`e'") (`v') (3) ("sa") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
                }
                quietly lincom (`lc') / `np'
                local sa_`e'`v' = r(estimate)
                local sa_out_`e' = `sa_out'
                post `h' ("`e'") (`v') (3) ("sa") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally; `sa_out' starters with no file the year before the start left out") (.)
                quietly test `pre'
                post `h' ("`e'") (`v') (3) ("sa") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (r(p))
            }
        }

        * ---- (4) Borusyak-Jaravel-Spiess (did_imputation) ----
        * Fits firm and year effects on rows not yet (or never) participating,
        * predicts each starter's path without the start, and averages actual
        * minus predicted. Its before-start check asks whether the years just
        * before the start already differ from the firm's earlier years.
        if !`ok_bjs' {
            post `h' ("`e'") (`v') (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_bjs'")')") ("ssc install did_imputation") (.)
        }
        else {
            use `smp', clear
            gen int Ei = gA                                  // start year; missing = never started
            * minn(0): report every year; the window rule already needs 30+ starters per year.
            capture quietly did_imputation y firm_id year Ei, horizons(0/`whi') pretrends(`=-`wlo'') autosample minn(0)
            if _rc {
                post `h' ("`e'") (`v') (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_imputation stopped with error r(`=_rc')") ("") (.)
            }
            else {
                capture drop es
                gen byte es = e(sample)
                r210_used
                local st = r(starters)
                local cf = r(comp)
                local rw = r(rows)
                local p_bjs = e(pre_p)
                forvalues k = 0/`whi' {
                    post `h' ("`e'") (`v') (4) ("bjs") ("event") (`k') (_b[tau`k']) (_se[tau`k']) (.) (.) (.) (.) ("ok") ("vs predicted path without the start") (.)
                }
                forvalues k = 1/`=-`wlo'' {
                    post `h' ("`e'") (`v') (4) ("bjs") ("event") (-`k') (_b[pre`k']) (_se[pre`k']) (.) (.) (.) (.) ("ok") ("before-start check: vs the firm's earlier years") (.)
                }
                local lcb "tau0"
                forvalues k = 1/`whi' {
                    local lcb "`lcb' + tau`k'"
                }
                quietly lincom (`lcb') / `=`whi' + 1'
                post `h' ("`e'") (`v') (4) ("bjs") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally") (.)
                post `h' ("`e'") (`v') (4) ("bjs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of the `=-`wlo'' years before the start; p in column p") (`p_bjs')
                capture quietly did_imputation y firm_id year Ei, autosample minn(0)
                if !_rc post `h' ("`e'") (`v') (4) ("bjs") ("own_overall") (.) (_b[tau]) (_se[tau]) (.) (.) (.) (e(N)) ("ok") ("one average over all starter rows from the start on") (.)
            }
        }

        * ---- (5) de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn) ----
        * It numbers periods as they appear in the data, so every calendar year
        * missing inside a firm's span (the year with no file included) gets an
        * empty row with the start status filled in (R2-07's fix). Only
        * never-starters are comparisons; starters whose year before the start
        * has no row drop out. "Effect_1" = the start year (year 0), Effect_2 =
        * year +1, ...; "Placebo_1" = year -2, Placebo_2 = -3, ...
        if !`ok_dcdh' {
            post `h' ("`e'") (`v') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_dcdh'")')") ("ssc install did_multiplegt_dyn; ssc install gtools") (.)
        }
        else {
            use `smp', clear
            * Starters with no usable row from their start year on would look like
            * firms that never start: leave them out (as the other methods do).
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
            capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off _no_updates
            if _rc == 198 capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off no_updates
            if _rc == 198 {
                post `h' ("`e'") (`v') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: this did_multiplegt_dyn version cannot switch off its self-update") ("update it once: ssc install did_multiplegt_dyn, replace") (.)
            }
            else if _rc {
                post `h' ("`e'") (`v') (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_multiplegt_dyn stopped with error r(`=_rc')") ("") (.)
            }
            else {
                local st = e(N_switchers_effect_1)
                local rw = e(N_effect_1)
                local p_dcdh = e(p_jointplacebo)
                forvalues l = 1/`ne' {
                    post `h' ("`e'") (`v') (5) ("dcdh") ("event") (`l' - 1) (e(Effect_`l')) (e(se_effect_`l')) (.) (e(N_switchers_effect_`l')) (.) (e(N_effect_`l')) ("ok") ("Effect_`l' (package name) = year `=`l'-1' since the start") (.)
                }
                forvalues l = 1/`npl' {
                    post `h' ("`e'") (`v') (5) ("dcdh") ("event") (-1 - `l') (e(Placebo_`l')) (e(se_placebo_`l')) (.) (e(N_switchers_placebo_`l')) (.) (e(N_placebo_`l')) ("ok") ("Placebo_`l' (package name) = year `=-1-`l'' vs the year before the start") (.)
                }
                post `h' ("`e'") (`v') (5) ("dcdh") ("own_overall") (.) (e(Av_tot_effect)) (e(se_avg_total_effect)) (.) (.) (.) (e(N_avg_total_effect)) ("ok") ("average total effect: all its effects, weighted by starters behind each") (.)
                post `h' ("`e'") (`v') (5) ("dcdh") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of its placebos (years -2 to `wlo'); p in column p") (`p_dcdh')
                local lcd "Effect_1"
                forvalues l = 2/`ne' {
                    local lcd "`lcd' + Effect_`l'"
                }
                capture quietly lincom (`lcd') / `ne'
                if !_rc post `h' ("`e'") (`v') (5) ("dcdh") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (.) (`rw') ("ok") ("years 0 to +`whi', each counts equally; starters and rows = those behind year 0") (.)
                else    post `h' ("`e'") (`v') (5) ("dcdh") ("avg") (.) (.) (.) (.) (`st') (.) (`rw') ("failed: no covariances in this package version") ("update: ssc install did_multiplegt_dyn, replace") (.)
            }
        }
        timer off 2
        quietly timer list 2
        display "   [`e'] five methods done (" %5.1f r(t2) " s so far)"
        timer on 2
    }
}
postclose `h'
timer off 2
* If R2-08's table is present (same window), its averages must be reproduced here:
* one regression, main and as filed, and Sun-Abraham (main). An R2-08 table made
* before R2-08 also left out start years with no year-before file can differ in
* its Sun-Abraham row only where such start years exist: then a line says so.
preserve
capture confirm file "tables/08_efficiency_import_foreign_start.csv"
if !_rc {
    import delimited using "tables/08_efficiency_import_foreign_start.csv", clear varnames(1)
    quietly summarize window_last if panel == "imp"
    if r(mean) != `whi' display "   R2-08 table uses another year window: cross-check skipped"
    else {
        local nold 0
        foreach e in imp fdi {
            foreach vv in 1 2 5 {
                quietly summarize avg_b if panel == "`e'" & version == `vv' & outcome == 1
                local r8 = r(mean)
                local mine = cond(`vv' == 5, "`sa_`e'1'", cond(`vv' == 1, "`tw_`e'1'", "`tw_`e'2'"))
                if "`mine'" == "" | missing(`r8') continue  // method not run here or there
                if abs(`r8' - `mine') <= 0.00005 + 1e-9 continue
                if `vv' == 5 & "`sa_out_`e''" != "0" {
                    display "   `e': Sun-Abraham " %7.4f `mine' " here vs " %7.4f `r8' " in R2-08's table, which still keeps the `sa_out_`e'' starters with no file the year before the start: re-run the updated 08_efficiency_import_foreign_start.do"
                    local ++nold
                    continue
                }
                display as error "tables/08_efficiency_import_foreign_start.csv shows another average (`e', version `vv'): re-run 08_efficiency_import_foreign_start.do."
                exit 459
            }
        }
        if `nold' == 0 display "   R2-08 table: its averages reproduced (one regression, main and as filed; Sun-Abraham)"
        else display "   R2-08 table: its averages reproduced (one regression, main and as filed; Sun-Abraham where the samples match)"
    }
}
else display "   tables/08_efficiency_import_foreign_start.csv not found: cross-check skipped"
restore

*---------------------------------------------------------------------------
display "Step 5/7: intervals, percentages and the CSV (numbers written before drawing)"
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
* % difference = 100 x (exp(b) - 1); the interval ends are converted the same way.
gen double pct    = 100 * (exp(b)  - 1)
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
gen str60 event_label = ""
replace event_label = "Starting to import"                          if event == "imp"
replace event_label = "Getting a foreign owner (10%+ of capital)"   if event == "fdi"
replace event_label = "Starting to trade (exporting or importing)"  if event == "any"
gen str70 version_label = cond(version == 1, "Main: repaired starts, doubtful energy records left out (black)", ///
    "Every start and record as filed (gray triangles)")
gen str80 method_label = ""
replace method_label = "One regression, all start years together (R2-03/R2-08's model, reghdfe)"         if method == "twfe"
replace method_label = "Callaway-Sant'Anna (csdid): each start year vs never-starters"                  if method == "cs"
replace method_label = "Sun-Abraham (eventstudyinteract): R2-03's markers, start years kept apart"      if method == "sa"
replace method_label = "Borusyak-Jaravel-Spiess (did_imputation): predicted path without the start"     if method == "bjs"
replace method_label = "de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn): change from the year before" if method == "dcdh"
gen str70 row_label = ""
replace row_label = "Average of years 0 to +`whi', each year counts equally"      if row_type == "avg"
replace row_label = "Previous paper's summary: one average of all years after the start" if row_type == "own_overall"
replace row_label = "One year since the start"                                  if row_type == "event"
replace row_label = "Before-start check (p only)"                               if row_type == "before_check"
replace row_label = "Before-start check, all years before the start (p only)"   if row_type == "before_all"
gen int window_first = `wlo'
gen int window_last  = `whi'
* The repairs, repeated on every main-version row of their event: starts dated in
* the problem year as filed, and where they went (left out / later start / never / kept).
gen long problem_year_starts = cond(event == "imp", `n_impbad', cond(event == "fdi", `n_fdibad', `n_anybad'))  if version == 1
gen long starts_left_out     = cond(event == "imp", `n_impbad', cond(event == "fdi", 0, `n_anybad_out'))      if version == 1
gen long starts_redated      = cond(event == "fdi", `n_fdibad_redated', 0)                                     if version == 1
gen long moved_to_never      = cond(event == "fdi", `n_fdibad_never', 0)                                       if version == 1
gen long starts_kept         = cond(event == "any", `n_anybad' - `n_anybad_out', 0)                            if version == 1
assert problem_year_starts == starts_left_out + starts_redated + moved_to_never + starts_kept if version == 1
* (c) only: starters that start by importing (the rest start by exporting only).
gen long starters_importing = `any_imp_n' if event == "any" & version == 1 & method == "twfe" & row_type == "avg"
gen byte eorder = cond(event == "imp", 1, cond(event == "fdi", 2, 3))
gen byte rorder = 1*(row_type == "avg") + 2*(row_type == "own_overall") + 3*(row_type == "before_check") ///
    + 4*(row_type == "before_all") + 6*(row_type == "event")
sort eorder version morder rorder event_time
rename morder method_order
order event event_label version version_label method_order method method_label row_type row_label event_time ///
      b se lo hi p pct pct_lo pct_hi ci_basis starters comp_firms rows window_first window_last ///
      problem_year_starts starts_left_out starts_redated moved_to_never starts_kept starters_importing status note
drop rorder eorder crit pin df
format b se lo hi %9.4f
format pct pct_lo pct_hi %9.1f
format p %9.3f
format starters comp_firms rows problem_year_starts starts_left_out starts_redated moved_to_never starts_kept starters_importing %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
list event version method row_type b pct pct_lo pct_hi p starters comp_firms rows status if inlist(row_type, "avg", "own_overall", "before_check", "before_all"), ///
    noobs sepby(event version) abbreviate(24) clean


*---------------------------------------------------------------------------
display "Step 6/7: numbers for the rows, panels and notes (read from the table, never typed)"
*---------------------------------------------------------------------------
local nb = uchar(160)                                   // no-break space: "p < 0.001" stays on one line
foreach e in imp fdi any {
    foreach m in twfe cs sa bjs dcdh {
        quietly summarize p if event == "`e'" & version == 1 & method == "`m'" & row_type == "before_check"
        local bp_`e'_`m' = cond(r(N) > 0, r(mean), .)
    }
    quietly summarize p if event == "`e'" & version == 1 & method == "cs" & row_type == "before_all"
    local bpall_`e' = cond(r(N) > 0, r(mean), .)
    quietly summarize p if event == "`e'" & version == 2 & method == "twfe" & row_type == "before_check"
    local bp_`e'_filed = cond(r(N) > 0, r(mean), .)
    quietly summarize comp_firms if event == "`e'" & version == 1 & method == "twfe" & row_type == "avg"
    local cf_`e' = string(r(mean), "%9.0fc")
}
keep if row_type == "avg"
* Rows per panel: 1-5 = the five methods (main version); 6 = as filed (one regression).
gen byte row = cond(version == 1, method_order, 6)
gen byte pnl = cond(event == "imp", 1, cond(event == "fdi", 2, 3))
gen byte ok = status == "ok" & !missing(b)
* Per panel: the range of the five averages and how many are clearly different from 0.
local words "none one two three four five"
foreach e in imp fdi any {
    quietly summarize pct if event == "`e'" & row <= 5 & ok
    local nav = r(N)
    local s_min = cond(round(r(min)) > 0, "+", "") + string(round(r(min)), "%9.0f") + "%"
    local s_max = cond(round(r(max)) > 0, "+", "") + string(round(r(max)), "%9.0f") + "%"
    quietly count if event == "`e'" & row <= 5 & ok & (pct_lo > 0 | pct_hi < 0)
    local nclr = r(N)
    local wc : word `=`nclr' + 1' of `words'
    local clr = cond(`nclr' == `nav', "all clear", cond(`nclr' == 0, "none clear", "`wc' of `nav' clear"))
    local rng_`e' = cond(`nav' == 0, "not estimated", "`s_min' to `s_max', `clr'")
}
* Shares quoted in the panel lines (whole %), from Step 1 and Step 4.
local s_i0 = string(100 * `shi0', "%9.0f")
local s_i1 = string(100 * `shi1', "%9.0f")
local s_f1 = string(100 * `shf1', "%9.0f")
local s_f0 = string(100 * `shf0', "%9.0f")
local s_ai = string(100 * `any_imp_sh', "%9.0f")
* The doubtful years as text: runs of consecutive files joined by a dash
* (the missing file counts as a break), e.g. "2017 and 2019–2022" (R2-08's code).
local runs ""
local r0 ""
local rp ""
foreach yy of local doubt_yrs {
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

*---------------------------------------------------------------------------
display "Step 7/7: dot-and-whisker chart, one row per method, one block per start event, one scale"
*---------------------------------------------------------------------------
* Vertical layout (y units): panel header at yh, its gray line 0.75 below, the
* five method rows 1 unit apart (a little more room under row 2 for its gray
* second line), the as-filed row a little further down.
gen double yh   = 25.5 - 8.5 * (pnl - 1)
gen double ypos = yh - 1.7 - (row - 1) - 0.3 * (row >= 3) - 0.2 * (row == 6)
gen double ysub = ypos - 0.6                            // gray second line under a row
* x-axis: a round step (1, 2 or 5 times a power of 10) that grows with the
* numbers; 0 always inside; at most 6 steps, so the tick labels never touch.
quietly summarize pct_lo if ok
local xmin = min(r(min), 0)
quietly summarize pct_hi if ok
local xmax = max(r(max), 0)
local rng = `xmax' - `xmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local xbot = `step' * floor(`xmin'/`step')
local xtop = `step' * ceil(`xmax'/`step')
while (`xtop' - `xbot')/`step' > 6 {
    local mant = round(`step' / 10^floor(log10(`step')))    // 1, 2 or 5
    local step = cond(`mant' == 2, 2.5, 2) * `step'         // 1 -> 2 -> 5 -> 10 ...
    local xbot = `step' * floor(`xmin'/`step')
    local xtop = `step' * ceil(`xmax'/`step')
}
local xfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
* Tick labels with a % sign and a + for rises (0 = no difference).
local xlab ""
forvalues xx = `xbot'(`step')`xtop' {
    local s = cond(`xx' > 0, "+", "") + strtrim(string(`xx', "`xfmt'")) + "%"
    local xlab `"`xlab' `xx' "`s'""'
}
local span = `xtop' - `xbot'
* Left to right (x-axis units): row names, the dots (xbot..xtop, the only part
* with an axis), then two columns: starters, and the before-start check.
local xn  = `xbot' - 1.2 * `span'                       // row names start here (left-aligned)
quietly summarize pct_hi if ok
local xc1 = max(`xtop' + 0.27 * `span', r(max) + 0.45 * `span')  // column: starters (right-aligned; clear of the % labels)
local xc2 = `xc1' + 0.07 * `span'                       // column: before-start check (left-aligned)
local xr  = `xc1' + 0.51 * `span'
* Faint vertical gridlines and the 0 line, drawn inside each panel only.
local grid ""
local zero ""
forvalues p = 1/3 {
    local yt = 25.5 - 8.5 * (`p' - 1) - 1.2
    local yb = 25.5 - 8.5 * (`p' - 1) - 7.6
    forvalues xx = `xbot'(`step')`xtop' {
        if abs(`xx') > 1e-9 local grid `grid' `yt' `xx' `yb' `xx'
    }
    local zero `zero' `yt' 0 `yb' 0
}
* Columns: starters behind each average; before-start check (p below 0.05 =
* starters were already changing differently: "differs").
gen str12 c1 = string(starters, "%9.0fc") if ok
gen str40 c2 = ""
gen str40 c2b = ""
foreach e in imp fdi any {
    foreach m in twfe cs sa bjs dcdh filed {
        local q = cond("`m'" == "filed", `bp_`e'_filed', `bp_`e'_`m'')
        if missing(`q') continue
        local qs = cond(`q' < 0.001, "<`nb'0.001", string(`q', "%5.3f"))
        if `q' < 0.05 local qs "`qs', differs"
        if "`m'" == "filed" replace c2 = "`qs'" if event == "`e'" & row == 6 & ok
        else                replace c2 = "`qs'" if event == "`e'" & method == "`m'" & row <= 5 & ok
    }
    * Callaway-Sant'Anna's check over all years before the start, as a gray second line.
    if !missing(`bpall_`e'') {
        local qs = cond(`bpall_`e'' < 0.001, "<`nb'0.001", string(`bpall_`e'', "%5.3f"))
        if `bpall_`e'' < 0.05 local qs "`qs', differs"
        replace c2b = "all years: `qs'" if event == "`e'" & method == "cs" & row == 2 & ok
    }
}
gen str90 nolbl = status if !ok
gen double xc1 = `xc1'
gen double xc2 = `xc2'
gen double xnr = `xbot'
gen double xnm = `xn'
* Each average is written at the right end of its interval (whole %).
gen double pr = round(pct)
gen str8 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") + "%" if ok
* Row names (left-aligned text; the as-filed row in gray).
gen str60 nm  = ""
replace nm  = "One regression (Figure R2-08's model)"      if row == 1
replace nm  = "Callaway–Sant'Anna"                         if row == 2
replace nm  = "Sun–Abraham"                                if row == 3
replace nm  = "Borusyak–Jaravel–Spiess"                    if row == 4
replace nm  = "de Chaisemartin–D'Haultfœuille"             if row == 5
replace nm  = "As filed, nothing left out (one regression)" if row == 6
* Panel titles (on each panel's first row) and one gray line on what was repaired.
gen str120 ph = ""
gen str160 ps = ""
replace ph = "(a) Starting to import, vs `cf_imp' firms never seen importing"                      if row == 1 & pnl == 1
replace ph = "(b) Getting a foreign owner (10%+ of capital), vs `cf_fdi' firms never foreign-owned"  if row == 1 & pnl == 2
replace ph = "(c) Starting to trade (export or import), vs `cf_any' firms never seen trading"       if row == 1 & pnl == 3
replace ps = "Import starts dated `imp_bad' left out: importers rise from `s_i0'% of firms in `imp_prev' to `s_i1'% in `imp_bad' (likely a recording change)." if row == 1 & pnl == 1
replace ps = "All `fdi_bad' answers treated as unknown: `s_f1'% of firms are marked foreign-owned in `fdi_bad', about `s_f0'% in other years." if row == 1 & pnl == 2
replace ps = "`s_ai'% of these starters start by importing; starts dated `imp_bad' that come with importing are left out, as in (a)." if row == 1 & pnl == 3
gen double yph = yh
gen double yps = yh - 0.75
gen double yhdr = 26.7                                  // column headers
gen str6 hdr = "Method" if _n == 1
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local g1 : word 1 of `gapyr'
local txt "Notes: Each row: starters' change in value added per GJ from the year before the start (average of years 0 to +`whi'),"
local txt "`txt' minus the same change among firms never seen doing the same. Start = first year seen importing (a), with a foreign"
local txt "`txt' owner holding 10%+ of the capital (b), or exporting or importing (c), after a year seen without (a starter stays one"
local txt "`txt' if it stops later). Rows 2 to 5 are the previous paper's four methods, named after their authors; they differ only in"
local txt "`txt' how they combine firms that start in different years (row 1 can mix start years)."
local txt "`txt' Black dots also leave out energy records of importers with unknown"
local txt "`txt' export status in `dtxt' (they jump or drop far from other years); the gray triangle keeps every start and record."
local txt "`txt' Five methods: (a) `rng_imp'; (b) `rng_fdi'; (c) `rng_any' (a bar crossing 0 = no clear difference)."
local txt "`txt' Before the start = the method's check that starters were not already changing differently (p below 0.05 = they were;"
local txt "`txt' 'all years' = every year before the start, not only the last `: word `=-`wlo'' of one two three four five six seven eight nine')."
* Callaway-Sant'Anna's all-years check failing anywhere gets one plain sentence.
local nall 0
foreach e in imp fdi any {
    if `bpall_`e'' < 0.05 local ++nall
}
if `nall' > 0 local txt "`txt' Where 'all years' differs, part of the change after the start may continue an earlier difference."
if "`g1'" != "" local txt "`txt' No `gapyr' file: Callaway–Sant'Anna, Sun–Abraham and de Chaisemartin–D'Haultfœuille leave out firms that started in `=`g1'+1'."
local txt "`txt' Value added = output value minus materials, energy and services bought (current prices); GJ = gigajoules."
local txt "`txt' Timing, not proof of cause; firm links are fictional."
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
twoway (pci `grid', lcolor(gs14) lwidth(vthin)) ///
    (pci `zero', lcolor(gs8) lwidth(thin)) ///
    (rspike pct_hi pct_lo ypos if row <= 5 & ok, horizontal lcolor(black) lwidth(thin)) ///
    (rspike pct_hi pct_lo ypos if row == 6 & ok, horizontal lcolor(gs8) lwidth(thin)) ///
    (scatter ypos pct if row <= 5 & ok, msymbol(O) msize(small) mcolor(black)) ///
    (scatter ypos pct if row == 6 & ok, msymbol(Th) msize(small) mcolor(gs8)) ///
    (scatter ypos pct_hi if row <= 5 & ok, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos pct_hi if row == 6 & ok, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xnm if row <= 5, msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnm if row == 6, msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc1 if row <= 5 & ok, msymbol(none) mlabel(c1) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc1 if row == 6 & ok, msymbol(none) mlabel(c1) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc2 if row <= 5 & ok, msymbol(none) mlabel(c2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc2 if row == 6 & ok, msymbol(none) mlabel(c2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ysub xc2 if c2b != "", msymbol(none) mlabel(c2b) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xnr if !ok, msymbol(none) mlabel(nolbl) mlabposition(3) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter yph xnm if ph != "", msymbol(none) mlabel(ph) mlabposition(3) mlabgap(0) mlabsize(small) mlabcolor(black)) ///
    (scatter yps xnm if ps != "", msymbol(none) mlabel(ps) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter yhdr xnm if hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    text(26.7 `xc1' "Starters", size(vsmall) placement(w)) ///
    text(26.7 `xc2' "Before the start, p", size(vsmall) placement(e)) ///
    yscale(range(0.8 27.0) off) ylabel(none) ytitle("") ///
    xscale(range(`xn' `xr') noline) ///
    xlabel(`xlab', labsize(vsmall) noticks tlength(0) nogrid) ///
    xtitle("") ///
    legend(order(5 "Average of years 0 to +`whi' (each year counts equally)" ///
                 6 "As filed: every start and record kept (one regression)" 3 "95% interval" 2 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Importing, foreign owners and energy efficiency, by method", size(medsmall) position(11) justification(left) span) ///
    subtitle("Value added per GJ: % change after the start, starters minus firms that never start", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    xsize(9) ysize(12.5) scale(`=7.5/9')

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
