/*==========================================================================
  R2-07  The previous paper's methods on the new years: does the answer
         (value added per GJ after firms start exporting, starters minus
         never-exporters) change when start years are handled by the four
         methods the previous paper used, instead of Figure R2-03's single
         model?
  Answers Deasy R2: "Stagged did" - Notes "Mirip dengan paper kita
         sebelumnya hanya Ganti tahun" (its four estimators: Callaway-
         Sant'Anna = csdid, Sun-Abraham = eventstudyinteract, Borusyak-
         Jaravel-Spiess = did_imputation, de Chaisemartin-D'Haultfoeuille =
         did_multiplegt_dyn; and its stricter start rule, rule B).
  Output : figures/07_efficiency_by_method.png (+ .pdf)
           tables/07_efficiency_by_method.csv
  Needs  : Stata add-ons from SSC, installed once (the file never installs
           or updates anything):
             ssc install reghdfe    ssc install ftools    ssc install require
             ssc install csdid      ssc install drdid
             ssc install eventstudyinteract               ssc install avar
             ssc install did_imputation
             ssc install did_multiplegt_dyn               ssc install gtools
           reghdfe, ftools and require (reghdfe 6+) are needed for any output;
           a missing method package gives an "unavailable" row in the table
           and on the chart, and the file does not stop.
  Checks : R2-03's and R2-06's averages (re-estimated here) against their
           tables when those tables are present
  Development data - obscured values, fictional firm panel. Not BPS findings.
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
local exhibit "R2-07"
local fname   "07_efficiency_by_method"

cap log close
log using "logs/`fname'.log", replace text
timer clear 1
timer on 1
display _newline "=== [`exhibit'] STARTING: value added per GJ after the export start, five methods side by side ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load export status, energy, CO2 and value added; check the method packages"
*---------------------------------------------------------------------------
* export_flag         = any export activity (1 yes, 0 no, missing = unknown)
* total_gj_s1         = energy use in GJ (nine fuels + purchased electricity)
* co2_total_s1        = CO2 tonnes (only used to keep the same rows as R2-03)
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year export_flag total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
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
display "   calendar years with no file: `gapyr'"
* The four methods are user-written Stata commands (install once, e.g.
* -ssc install csdid-). Each needs its helper command(s). A missing one is
* recorded and its method is skipped with an "unavailable" row.
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
display "Step 2/8: date each firm's export start under two rules (same code in every R2 file)"
*---------------------------------------------------------------------------
* Missing status is unknown, never read as "not participating".
* Rule A, simple first entry (main): the first year the firm is seen
*   participating, if it was seen NOT participating in some earlier year.
*   Firms participating when first seen cannot be dated and are left out.
* Rule B, previous paper's sustained entry (variant): the first year t with
*   participation in t, none in t-1 AND t-2, and participation again in t+1
*   (exact calendar years; the missing 2016 file breaks the pattern).
* Comparison group for BOTH rules: firms never seen participating.
* Row keys: 9001 never seen participating · 9002 already participating when first
* seen (rule A, excluded) · 9003 status never observed · 9004 seen participating
* without the sustained pattern (rule B, excluded) · 8000 all entrants · 9999 all firms.
local x export_flag
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
    gen int gA = keyA if keyA < 9000                                        // entry year, rule A
    by firm_id: egen int last_no_before = max(cond(`x' == 0 & year < gA, year, .))
    gen byte exactA = !missing(gA) & last_no_before == gA - 1               // seen "no" the year just before
    by firm_id: egen int first_stop = min(cond(!missing(gA) & `x' == 0 & year > gA, year, .))
    gen byte stopA = !missing(first_stop)                                   // later seen not participating
    by firm_id: egen byte reenterA = max(!missing(first_stop) & `x' == 1 & year > first_stop)

    * --- Rule B ---
    gen byte cleanB = (`x' == 1 & L1.`x' == 0 & L2.`x' == 0 & F1.`x' == 1)
    by firm_id: egen int gB = min(cond(cleanB == 1, year, .))               // entry year, rule B
    by firm_id: egen byte earlier_yesB = max(`x' == 1 & year < gB & !missing(gB))
    gen int keyB = cond(!missing(gB), gB, cond(n_known == 0, 9003, cond(missing(first_yes), 9001, 9004)))

*---------------------------------------------------------------------------
display "Step 3/8: set the year window (R2-02's rule) and check it against R2-02's table if present"
*---------------------------------------------------------------------------
* Years since the start = calendar year minus start year (0 = start year,
* -1 = the year before). A firm's 2016 is simply missing (no file).
gen int kA = year - gA                                  // missing for non-starters
* Usable row = energy, CO2 and value added all above zero, so every log exists
* (the same rows in R2-03, R2-04 and R2-05). A zero is left out, not read as "none".
gen byte usable = total_gj_s1 > 0 & co2_total_s1 > 0 & value_added_nominal > 0 ///
    & !missing(total_gj_s1, co2_total_s1, value_added_nominal)
by firm_id: egen int first_seen = min(year)             // first year the firm is in the file
tempfile fy est
save `fy'
* Which years since the start get their own point: R2-02's rule, computed here so
* this file also runs on its own. A year passes when `minfirms'+ starters have a
* usable row in it, from starts both before and after 2016; take the widest
* window -K..+K in which every year passes (further out = grouped ends).
local minfirms 30
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
capture confirm file "tables/02_event_time_support.csv"
if !_rc {
    import delimited using "tables/02_event_time_support.csv", clear varnames(1)
    if window_first[1] != `wlo' | window_last[1] != `whi' | min_firms[1] != `minfirms' {
        display as error "tables/02_event_time_support.csv shows another year window: re-run 02_event_time_support.do."
        exit 459
    }
}
local nout = `whi' + 1                                  // first grouped year on each side
display "   window (R2-02's rule, computed here): each year from `wlo' to +`whi' on its own; `nout'+ years before or after grouped"

*---------------------------------------------------------------------------
display "Step 4/8: the firms compared (as R2-03) and one on/off marker per year since the start"
*---------------------------------------------------------------------------
use `fy', clear
* Keep the starters (rule A) and the firms never seen exporting (the comparison
* group, all their rows). Left out: firms already exporting when first seen
* (start year unknown) and firms whose export status is never recorded. So a
* firm that always exports is never a comparison firm (the previous paper's
* code let such firms act as comparisons).
keep if !missing(gA) | keyA == 9001
keep if usable
assert !inlist(keyA, 9002, 9003)
gen double y = ln(value_added_nominal / total_gj_s1)     // log value added per GJ (R2-03's outcome)
gen byte never = missing(gA)                             // 1 = comparison firm (never seen exporting)
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
local lc = subinstr("`post'", " ", " + ", .)             // years 0..+`whi', for the average
local np : word count `post'
keep firm_id year gA kA y never `terms'
sort firm_id year
tempfile smp est
save `smp'
* Counts behind each estimate: starters with a row from the start year on,
* comparison firms and rows, all inside the estimation sample (variable es).
capture program drop r207_used
program define r207_used, rclass
    quietly {
        egen byte r207_fs = tag(firm_id) if es & !never & year >= gA
        count if r207_fs == 1
        return scalar starters = r(N)
        egen byte r207_fc = tag(firm_id) if es & never
        count if r207_fc == 1
        return scalar comp = r(N)
        count if es
        return scalar rows = r(N)
        drop r207_fs r207_fc
    }
end
* One row per number: method, row type, years since the start, b, se, df
* (df missing = the package reports a normal-based interval), counts, status.
tempname h
postfile `h' byte morder str8 method str12 row_type int event_time double(b se df) ///
    long(starters comp_firms rows) str80 status str120 note double pin using `est'

*---------------------------------------------------------------------------
display "Step 5/8: the same starters and never-exporters under each method"
*---------------------------------------------------------------------------
* All five: log value added per GJ, firm and year effects, one change per
* starter measured from its year before the start, compared with firms never
* seen exporting, clustered by firm. What differs is how start years and years
* since the start are combined. Main number per method = average of years 0 to
* +`whi' with each year counting equally (as R2-03); the method's own single
* overall number (all years after the start, its own weights) is kept too.
timer clear 2
timer on 2
* ---- (1) Figure R2-03's model: all start years in one regression ----
display "   (1) Figure R2-03's model (two-way fixed effects, one marker per year since the start)"
use `smp', clear
quietly reghdfe y `terms', absorb(firm_id year) vce(cluster firm_id)
local df = e(df_r)
matrix tw = e(b)
capture drop es
gen byte es = e(sample)
r207_used
local st = r(starters)
local cf = r(comp)
local rw = r(rows)
foreach t of local terms {
    if "`t'" == "ev_lo"      local k = `wlo' - 1
    else if "`t'" == "ev_hi" local k = `whi' + 1
    else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
    local nt = cond(inlist("`t'", "ev_lo", "ev_hi"), "grouped end", "")
    post `h' (1) ("twfe") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
}
quietly lincom (`lc') / `np'
local tw_avg = r(estimate)
post `h' (1) ("twfe") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("reghdfe, R2-03's markers") (.)
quietly test `pre'
local p_tw = r(p)
post `h' (1) ("twfe") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (`p_tw')
* The previous paper's two-way model: one on/off marker from the start year on.
gen byte after = !never & year >= gA
quietly reghdfe y after, absorb(firm_id year) vce(cluster firm_id)
post `h' (1) ("twfe") ("own_overall") (.) (_b[after]) (_se[after]) (e(df_r)) (.) (.) (e(N)) ("ok") ("one on/off marker from the start year on (the previous paper's two-way model)") (.)
* If R2-03's table is present it must show the same average.
preserve
capture confirm file "tables/03_energy_efficiency_export_start.csv"
if !_rc {
    import delimited using "tables/03_energy_efficiency_export_start.csv", clear varnames(1)
    quietly summarize avg_after_b if version == "main"
    if abs(r(mean) - `tw_avg') > 0.00005 + 1e-9 {
        display as error "tables/03_energy_efficiency_export_start.csv shows another average: re-run 03_energy_efficiency_export_start.do."
        exit 459
    }
    display "   R2-03 table: average of years 0 to +`whi' reproduced (" %7.4f `tw_avg' ")"
}
else display "   tables/03_energy_efficiency_export_start.csv not found: cross-check skipped"
restore

* ---- (2) Callaway-Sant'Anna (csdid): each start year vs never-exporters ----
* csdid lays out calendar years one by one, so the year with no file is a real
* gap: a comparison that needs it is empty, and firms that started the year
* after it (their year before the start has no file) get no after-start
* estimate. Its own before-start check compares each year before the start
* with the year before that, inside the window.
display "   (2) Callaway-Sant'Anna (csdid, never-exporters as the only comparison)"
if !`ok_cs' {
    post `h' (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_cs'")')") ("ssc install csdid; ssc install drdid") (.)
}
else {
    use `smp', clear
    gen int gcs = cond(never, 0, gA)                   // csdid wants 0 = never started
    capture quietly csdid y, ivar(firm_id) time(year) gvar(gcs)
    if _rc {
        post `h' (2) ("cs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: csdid stopped with error r(`=_rc')") ("") (.)
    }
    else {
        capture drop es
        gen byte es = e(sample)
        r207_used
        local st = r(starters)
        local cf = r(comp)
        local rw = r(rows)
        quietly estat simple
        matrix bb = r(b)
        matrix vv = r(V)
        post `h' (2) ("cs") ("own_overall") (.) (bb[1,1]) (sqrt(vv[1,1])) (.) (.) (.) (.) ("ok") ("estat simple: all years after the start, weighted by start-year size") (.)
        quietly estat event, window(`wlo' `whi')
        matrix bb = r(b)
        matrix vv = r(V)
        local cn : colnames bb
        foreach c of local cn {
            local j = colnumb(bb, "`c'")
            if "`c'" == "Post_avg" {
                post `h' (2) ("cs") ("avg") (.) (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (`st') (`cf') (`rw') ("ok") ("estat event Post_avg: years 0 to +`whi', each counts equally") (.)
            }
            else if inlist(substr("`c'", 1, 2), "Tm", "Tp") {
                local k = cond(substr("`c'", 2, 1) == "m", -1, 1) * real(substr("`c'", 3, .))
                local nt = cond(`k' < 0, "change from the year before (csdid's own base for years before the start)", "vs the year before the start")
                post `h' (2) ("cs") ("event") (`k') (bb[1,`j']) (sqrt(vv[`j',`j'])) (.) (.) (.) (.) ("ok") ("`nt'") (.)
            }
        }
        capture quietly estat pretrend, window(`wlo' -1)
        local ptxt "estat pretrend inside the window"
        if _rc {
            quietly estat pretrend                        // older csdid: no window option
            local ptxt "estat pretrend, all years before the start"
        }
        local p_cs = r(pchi2)
        post `h' (2) ("cs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("`ptxt'; p in column p") (`p_cs')
        if "`ptxt'" == "estat pretrend inside the window" {
            quietly estat pretrend
            post `h' (2) ("cs") ("before_all") (.) (.) (.) (.) (.) (.) (.) ("ok") ("estat pretrend, all years before the start (table only); p in column p") (r(pchi2))
        }
    }
}

* ---- (3) Sun-Abraham (eventstudyinteract): R2-03's markers, start years kept apart ----
display "   (3) Sun-Abraham (eventstudyinteract, never-exporters as the only comparison)"
if !`ok_sa' {
    post `h' (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_sa'")')") ("ssc install eventstudyinteract; ssc install avar") (.)
}
else {
    use `smp', clear
    * A start year whose year before has no file (the year after the missing
    * file) has no reference year: the package would silently measure those
    * starters against one of their last years instead (here +5; it drops one of their
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
        post `h' (3) ("sa") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: eventstudyinteract stopped with error r(`=_rc')") ("") (.)
    }
    else {
        capture drop es
        gen byte es = e(sample)
        r207_used
        local st = r(starters)
        local cf = r(comp)
        local rw = r(rows)
        local df = e(df_r)
        matrix bsa = e(b_iw)
        matrix vsa = e(V_iw)
        * How far does keeping start years apart move each of R2-03's dots?
        local mxd 0
        foreach t of local terms {
            local d = abs(bsa[1, colnumb(bsa, "`t'")] - tw[1, colnumb(tw, "`t'")])
            if `d' > `mxd' local mxd = `d'
        }
        display "   largest move of a dot vs R2-03: " %6.4f `mxd' " log points"
        ereturn post bsa vsa, dof(`df')
        foreach t of local terms {
            if "`t'" == "ev_lo"      local k = `wlo' - 1
            else if "`t'" == "ev_hi" local k = `whi' + 1
            else local k = cond(substr("`t'", 4, 1) == "m", -1, 1) * real(substr("`t'", 5, .))
            local nt = cond(inlist("`t'", "ev_lo", "ev_hi"), "grouped end", "")
            post `h' (3) ("sa") ("event") (`k') (_b[`t']) (_se[`t']) (`df') (.) (.) (.) ("ok") ("`nt'") (.)
        }
        quietly lincom (`lc') / `np'
        post `h' (3) ("sa") ("avg") (.) (r(estimate)) (r(se)) (`df') (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally; `sa_out' starters with no file the year before the start left out") (.)
        quietly test `pre'
        local p_sa = r(p)
        post `h' (3) ("sa") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("F test, years before the start (grouped end included) = 0; p in column p") (`p_sa')
        post `h' (3) ("sa") ("max_move") (.) (`mxd') (.) (.) (.) (.) (.) ("ok") ("largest difference from R2-03's dots, log points (all markers; `sa_out' starters left out here, kept in R2-03)") (.)
    }
}

* ---- (4) Borusyak-Jaravel-Spiess (did_imputation) ----
* Fits firm and year effects on rows not yet (or never) exporting, predicts
* each starter's path without the start, and averages actual minus predicted.
* It also uses later starters' years before their start. Its before-start check
* asks whether the years just before the start already differ from the
* firm's earlier years (a different reference from R2-03's).
display "   (4) Borusyak-Jaravel-Spiess (did_imputation)"
if !`ok_bjs' {
    post `h' (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_bjs'")')") ("ssc install did_imputation") (.)
}
else {
    use `smp', clear
    gen int Ei = gA                                     // start year; missing = never started
    * minn(0): report every year; the window rule already needs 30+ starters per year.
    capture quietly did_imputation y firm_id year Ei, horizons(0/`whi') pretrends(`=-`wlo'') autosample minn(0)
    if _rc {
        post `h' (4) ("bjs") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_imputation stopped with error r(`=_rc')") ("") (.)
    }
    else {
        capture drop es
        gen byte es = e(sample)
        r207_used
        local st = r(starters)
        local cf = r(comp)
        local rw = r(rows)
        local p_bjs = e(pre_p)
        forvalues k = 0/`whi' {
            post `h' (4) ("bjs") ("event") (`k') (_b[tau`k']) (_se[tau`k']) (.) (.) (.) (.) ("ok") ("vs predicted path without the start") (.)
        }
        forvalues k = 1/`=-`wlo'' {
            post `h' (4) ("bjs") ("event") (-`k') (_b[pre`k']) (_se[pre`k']) (.) (.) (.) (.) ("ok") ("before-start check: vs the firm's earlier years") (.)
        }
        local lcb "tau0"
        forvalues k = 1/`whi' {
            local lcb "`lcb' + tau`k'"
        }
        quietly lincom (`lcb') / `=`whi' + 1'
        post `h' (4) ("bjs") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (`cf') (`rw') ("ok") ("years 0 to +`whi', each counts equally") (.)
        post `h' (4) ("bjs") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of the `=-`wlo'' years before the start; p in column p") (`p_bjs')
        capture quietly did_imputation y firm_id year Ei, autosample minn(0)
        if !_rc post `h' (4) ("bjs") ("own_overall") (.) (_b[tau]) (_se[tau]) (.) (.) (.) (e(N)) ("ok") ("one average over all starter rows from the start on") (.)
    }
}

* ---- (5) de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn) ----
* It numbers periods as they appear in the data, so without help it would
* treat the two years around a missing file as one year apart. And a firm
* whose export status is missing in the year it switches is read as never
* switching, i.e. as a comparison firm. So every calendar year missing inside
* a firm's span (the year with no file included) gets an empty row: no
* outcome, but the export-start status is known from the start year. Then it
* counts calendar years, dates every start, and only never-exporters are
* comparisons; starters whose year before the start has no row drop out.
* Its "Effect_1" is the start year itself (year 0), Effect_2 = year +1, ...;
* "Placebo_1" is year -2 (vs the year before the start), Placebo_2 = -3, ...
display "   (5) de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn, never-exporters as the only comparison)"
if !`ok_dcdh' {
    post `h' (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("unavailable: package not installed (`=strtrim("`miss_dcdh'")')") ("ssc install did_multiplegt_dyn; ssc install gtools") (.)
}
else {
    use `smp', clear
    * Starters with no usable row from their start year on would look like
    * firms that never start: leave them out (as the other methods do).
    bysort firm_id: egen byte has_after = max(!never & year >= gA)
    drop if !never & !has_after
    keep firm_id year y gA never
    tsset firm_id year
    tsfill                                              // empty rows for missing years inside each firm's span
    bysort firm_id (gA): replace gA = gA[1]
    bysort firm_id (never): replace never = never[1]
    gen byte D = !never & year >= gA                    // exporter-start status: on from the start year, stays on
    keep firm_id year y D
    local ne  = `whi' + 1                               // Effect_1..Effect_`ne' = years 0..+`whi'
    local npl = -`wlo' - 1                              // Placebo_1..Placebo_`npl' = years -2..`wlo'
    * The package updates itself from the internet in 1 run in 100 unless told
    * not to. This file never installs or updates anything: it passes the
    * switch-off option (_no_updates; older versions: no_updates) and does not
    * run a version that has neither.
    capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off _no_updates
    if _rc == 198 capture quietly did_multiplegt_dyn y firm_id year D, effects(`ne') placebo(`npl') only_never_switchers graph_off no_updates
    if _rc == 198 {
        post `h' (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: this did_multiplegt_dyn version cannot switch off its self-update") ("update it once: ssc install did_multiplegt_dyn, replace") (.)
    }
    else if _rc {
        post `h' (5) ("dcdh") ("avg") (.) (.) (.) (.) (.) (.) (.) ("failed: did_multiplegt_dyn stopped with error r(`=_rc')") ("") (.)
    }
    else {
        local st = e(N_switchers_effect_1)
        local rw = e(N_effect_1)
        local p_dcdh = e(p_jointplacebo)
        forvalues l = 1/`ne' {
            post `h' (5) ("dcdh") ("event") (`l' - 1) (e(Effect_`l')) (e(se_effect_`l')) (.) (e(N_switchers_effect_`l')) (.) (e(N_effect_`l')) ("ok") ("Effect_`l' (package name) = year `=`l'-1' since the start") (.)
        }
        forvalues l = 1/`npl' {
            post `h' (5) ("dcdh") ("event") (-1 - `l') (e(Placebo_`l')) (e(se_placebo_`l')) (.) (e(N_switchers_placebo_`l')) (.) (e(N_placebo_`l')) ("ok") ("Placebo_`l' (package name) = year `=-1-`l'' vs the year before the start") (.)
        }
        post `h' (5) ("dcdh") ("own_overall") (.) (e(Av_tot_effect)) (e(se_avg_total_effect)) (.) (.) (.) (e(N_avg_total_effect)) ("ok") ("average total effect: all its effects, weighted by starters behind each (`=e(N_switchers_effect_average)' starter-years)") (.)
        post `h' (5) ("dcdh") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of its placebos (years -2 to `wlo'); p in column p") (`p_dcdh')
        local lcd "Effect_1"
        forvalues l = 2/`ne' {
            local lcd "`lcd' + Effect_`l'"
        }
        capture quietly lincom (`lcd') / `ne'
        if !_rc post `h' (5) ("dcdh") ("avg") (.) (r(estimate)) (r(se)) (.) (`st') (.) (`rw') ("ok") ("years 0 to +`whi', each counts equally; starters and rows = those behind year 0") (.)
        else    post `h' (5) ("dcdh") ("avg") (.) (.) (.) (.) (`st') (.) (`rw') ("failed: no covariances in this package version") ("update: ssc install did_multiplegt_dyn, replace") (.)
    }
}

* ---- (6) Figure R2-06's average (one start year at a time), for comparison ----
* Same code idea as R2-06 (main version): for each start year g, its starters
* and all never-exporters in calendar years g`wlo' to g+`whi'; starters need a row
* before and from the start; 30+ of them; one stacked regression; average
* weighted by starters.
display "   (6) Figure R2-06's average, re-estimated for comparison"
use `smp', clear
quietly levelsof gA, local(cohorts)
tempfile stack
local first 1
local W 0
local used ""
foreach g of local cohorts {
    use `smp', clear
    keep if (gA == `g' | never) & inrange(year, `g' + `wlo', `g' + `whi')
    by firm_id: egen byte has_b = max(year <  `g')
    by firm_id: egen byte has_a = max(year >= `g')
    keep if never | (has_b & has_a)
    egen byte ft = tag(firm_id) if gA == `g'
    quietly count if ft == 1
    local w`g' = r(N)
    if `w`g'' < `minfirms' continue
    local W = `W' + `w`g''
    local used `used' `g'
    gen byte after = (gA == `g') & year >= `g'
    gen int cohort = `g'
    keep firm_id year cohort after y never
    if !`first' append using `stack'
    save `stack', replace
    local first 0
}
use `stack', clear
egen long fc = group(firm_id cohort)
egen long yc = group(year cohort)
local dterms ""
local lw ""
foreach g of local used {
    gen byte d`g' = after * (cohort == `g')
    local dterms `dterms' d`g'
    local lw "`lw' + `w`g''/`W' * d`g'"
}
quietly reghdfe y `dterms', absorb(fc yc) vce(cluster firm_id)
quietly lincom `lw'
local r6 = r(estimate)
post `h' (6) ("r2_06") ("avg") (.) (r(estimate)) (r(se)) (r(df)) (`W') (.) (.) ("ok") ("Figure R2-06: one start year at a time, average weighted by starters (never-exporters reused in each start year)") (.)
preserve
capture confirm file "tables/06_efficiency_by_start_year.csv"
if !_rc {
    import delimited using "tables/06_efficiency_by_start_year.csv", clear varnames(1)
    quietly summarize b if outcome == 1 & version == 1 & row_type == "all"
    if abs(r(mean) - `r6') > 0.00005 + 1e-9 {
        display as error "tables/06_efficiency_by_start_year.csv shows another average: re-run 06_efficiency_by_start_year.do."
        exit 459
    }
    display "   R2-06 table: weighted average reproduced (" %7.4f `r6' ")"
}
else display "   tables/06_efficiency_by_start_year.csv not found: cross-check skipped"
restore
timer off 2
quietly timer list 2
display "   methods done (" %5.1f r(t2) " s)"

*---------------------------------------------------------------------------
display "Step 6/8: the previous paper's stricter start rule (rule B) with Borusyak-Jaravel-Spiess"
*---------------------------------------------------------------------------
* Rule B = participating in t, not in t-1 and t-2, and again in t+1 (exact
* calendar years; Step 2). It dates few starters, split over several start
* years, so methods that estimate each start year on its own (Callaway-
* Sant'Anna, Sun-Abraham) rest on a handful of firms per start year.
* Borusyak-Jaravel-Spiess needs only the never-exporters and the starters'
* own earlier years to predict, so it gives one pooled average over all starter
* rows from year 0 to +`whi' (rows after +`whi' left out). Its interval leaves
* each firm's own row out ("leave-out"), with start years as groups; if a start
* year has a single firm, starts before and after the missing file are the groups.
use `fy', clear
keep if !missing(gB) | keyB == 9001
keep if usable
gen double y = ln(value_added_nominal / total_gj_s1)
gen byte never = missing(gB)
gen int kB = year - gB
keep if missing(kB) | kB <= `whi'
replace gA = gB                                          // from here on gA = the rule B start year
egen byte ftB = tag(firm_id) if !never
quietly count if ftB == 1
local nB = r(N)
if !`ok_bjs' {
    post `h' (7) ("bjs_B") ("avg") (.) (.) (.) (.) (`nB') (.) (.) ("unavailable: package not installed (`=strtrim("`miss_bjs'")')") ("ssc install did_imputation") (.)
}
else {
    local gap1 : word 1 of `gapyr'
    if "`gap1'" == "" local gap1 = 9999
    gen byte early = gA < `gap1' if !never
    gen int Ei = gA
    local senote "leave-out interval, start years as groups"
    capture quietly did_imputation y firm_id year Ei, autosample minn(0) leaveout avgeffectsby(Ei) pretrends(`=-`wlo'')
    if _rc {
        local senote "leave-out interval, starts before and after the missing file as groups"
        capture quietly did_imputation y firm_id year Ei, autosample minn(0) leaveout avgeffectsby(early) pretrends(`=-`wlo'')
    }
    if _rc {
        local senote "standard interval (leave-out not possible here; may be too narrow)"
        capture quietly did_imputation y firm_id year Ei, autosample minn(0) pretrends(`=-`wlo'')
    }
    if _rc {
        post `h' (7) ("bjs_B") ("avg") (.) (.) (.) (.) (`nB') (.) (.) ("failed: did_imputation stopped with error r(`=_rc')") ("") (.)
    }
    else {
        capture drop es
        gen byte es = e(sample)
        r207_used
        local stB = r(starters)
        local p_B = e(pre_p)
        post `h' (7) ("bjs_B") ("avg") (.) (_b[tau]) (_se[tau]) (.) (r(starters)) (r(comp)) (r(rows)) ("ok") ("rule B: one average over all starter rows, years 0 to +`whi'; `senote'") (.)
        post `h' (7) ("bjs_B") ("before_check") (.) (.) (.) (.) (.) (.) (.) ("ok") ("joint test of the `=-`wlo'' years before the start; p in column p") (`p_B')
    }
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 7/8: intervals, percentages and the CSV (numbers written before drawing)"
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
gen double pct    = 100 * (exp(b)  - 1) if row_type != "max_move"
gen double pct_lo = 100 * (exp(lo) - 1)
gen double pct_hi = 100 * (exp(hi) - 1)
gen str80 method_label = ""
replace method_label = "Figure R2-03's model: all start years in one regression (two-way fixed effects, reghdfe)" if method == "twfe"
replace method_label = "Callaway-Sant'Anna (csdid): each start year vs never-exporters"                       if method == "cs"
replace method_label = "Sun-Abraham (eventstudyinteract): R2-03's markers, start years kept apart"            if method == "sa"
replace method_label = "Borusyak-Jaravel-Spiess (did_imputation): predicted path without the start"           if method == "bjs"
replace method_label = "de Chaisemartin-D'Haultfoeuille (did_multiplegt_dyn): change from the year before"    if method == "dcdh"
replace method_label = "Figure R2-06: one start year at a time vs never-exporters (stacked, reghdfe)"        if method == "r2_06"
replace method_label = "Previous paper's stricter start rule B, Borusyak-Jaravel-Spiess (did_imputation)"     if method == "bjs_B"
gen str70 row_label = ""
replace row_label = "Average of years 0 to +`whi', each year counts equally"      if row_type == "avg"
replace row_label = "Average over start years, weighted by starters"             if row_type == "avg" & method == "r2_06"
replace row_label = "One average over all starter rows, years 0 to +`whi'"        if row_type == "avg" & method == "bjs_B"
replace row_label = "The method's own overall number (all years after the start)" if row_type == "own_overall"
replace row_label = "One year since the start"                                  if row_type == "event"
replace row_label = "Before-start check (p only)"                               if row_type == "before_check"
replace row_label = "Before-start check, all years before the start (p only)"   if row_type == "before_all"
replace row_label = "Largest move of an R2-03 dot (log points)"                  if row_type == "max_move"
gen int window_first = `wlo'
gen int window_last  = `whi'
gen byte rorder = 1*(row_type == "avg") + 2*(row_type == "own_overall") + 3*(row_type == "before_check") ///
    + 4*(row_type == "before_all") + 5*(row_type == "max_move") + 6*(row_type == "event")
sort morder rorder event_time
rename morder method_order
order method_order method method_label row_type row_label event_time b se lo hi p pct pct_lo pct_hi ci_basis ///
      starters comp_firms rows window_first window_last status note
drop rorder crit pin df
format b se lo hi %9.4f
format pct pct_lo pct_hi %9.1f
format p %9.3f
format starters comp_firms rows %9.0f
export delimited using "tables/`fname'.csv", datafmt replace
list method row_type b pct pct_lo pct_hi p starters comp_firms rows status if inlist(row_type, "avg", "own_overall", "before_check", "before_all", "max_move"), ///
    noobs sep(0) abbreviate(24) clean

*---------------------------------------------------------------------------
display "Step 8/8: dot-and-whisker chart, one row per method"
*---------------------------------------------------------------------------
* Numbers for the rows and notes, read from the table (never typed).
local nb = uchar(160)                                   // no-break space: "p = 0.123" stays on one line
foreach m in twfe cs sa bjs dcdh r2_06 bjs_B {
    quietly summarize p if method == "`m'" & row_type == "before_check"
    local bp_`m' = cond(r(N) > 0, r(mean), .)
}
* Callaway-Sant'Anna's check over all years before the start (not only the window).
quietly summarize p if method == "cs" & row_type == "before_all"
local bpall_cs = cond(r(N) > 0, r(mean), .)
keep if inlist(row_type, "avg", "own_overall")
gen double ypos = cond(method_order <= 5, 9 - method_order, cond(method_order == 6, 2.6, 1.2))
gen byte ok = status == "ok" & !missing(b)
* The range and the number of clear results among the first five rows.
quietly summarize pct if row_type == "avg" & method_order <= 5 & ok
local nav = r(N)
local rmin = r(min)
local rmax = r(max)
quietly count if row_type == "avg" & method_order <= 5 & ok & (pct_lo > 0 | pct_hi < 0)
local nclr = r(N)
local s_min = cond(round(`rmin') > 0, "+", "") + string(round(`rmin'), "%9.0f") + "%"
local s_max = cond(round(`rmax') > 0, "+", "") + string(round(`rmax'), "%9.0f") + "%"
local clr = cond(`nclr' == 0, "none is clearly different from 0", cond(`nclr' == 1, "one is clearly different from 0", "`nclr' are clearly different from 0"))
local nw : word `nav' of one two three four five
* x-axis: a round step that grows with the numbers; 0 always inside.
quietly summarize pct_lo if ok
local xmin = min(r(min), 0)
quietly summarize pct_hi if ok
local xmax = max(r(max), 0)
quietly summarize pct if ok
local xmin = min(`xmin', r(min))
local xmax = max(`xmax', r(max))
local rng = `xmax' - `xmin'
local step = 10^floor(log10(`rng'))
if `rng'/`step' < 2       local step = `step'/5
else if `rng'/`step' < 5  local step = `step'/2
local xbot = `step' * floor(`xmin'/`step')
local xtop = `step' * ceil(`xmax'/`step')
local xfmt = cond(`step' >= 1, "%9.0f", "%9.1f")
local span = `xtop' - `xbot'
* Layout left to right (in x-axis units): row names, the dots (xbot..xtop, the
* only part with an axis), then two columns: starters, and the before-start check.
local xn  = `xbot' - 1.2 * `span'                       // row names start here (left-aligned)
local xc1 = `xtop' + 0.27 * `span'                      // column: starters (right-aligned at this x)
local xc2 = `xtop' + 0.34 * `span'                      // column: before-start check (left-aligned)
local xr  = `xtop' + 0.75 * `span'
* Right-hand columns: starters behind each average, and the before-start check
* (p below 0.05 = starters were already changing differently: "differs").
gen str12 c1 = string(starters, "%9.0fc") if row_type == "avg" & ok
gen str40 c2 = ""
foreach m in twfe cs sa bjs dcdh r2_06 bjs_B {
    local q = `bp_`m''
    if !missing(`q') {
        local qs = cond(`q' < 0.001, "<`nb'0.001", string(`q', "%5.3f"))
        if `q' < 0.05 local qs "`qs', differs"
        replace c2 = "`qs'" if method == "`m'" & row_type == "avg" & ok
    }
}
replace c2 = "in Figure R2-06" if method == "r2_06" & row_type == "avg" & ok
* Second, gray line under Callaway-Sant'Anna's p: its check over all years before the start.
gen str40 c2b = ""
if !missing(`bpall_cs') {
    local qs = cond(`bpall_cs' < 0.001, "<`nb'0.001", string(`bpall_cs', "%5.3f"))
    if `bpall_cs' < 0.05 local qs "`qs', differs"
    replace c2b = "all years: `qs'" if method == "cs" & row_type == "avg" & ok
}
gen str90 nolbl = status if row_type == "avg" & !ok
gen double xc1 = `xc1'
gen double xc2 = `xc2'
gen double xnr = `xbot'
* Each average is written at the right end of its interval (whole %).
gen double pr = round(pct)
gen str8 lbl = cond(pr > 0, "+", "") + string(pr, "%9.0f") + "%" if row_type == "avg" & ok
* Row names, written as text on the left (left-aligned); the last two rows get a
* second, gray line that says how their average differs.
gen str60 nm  = ""
gen str60 sub = ""
replace nm  = "Figure R2-03's model (one regression)"      if method == "twfe"
replace nm  = "Callaway–Sant'Anna"                         if method == "cs"
replace nm  = "Sun–Abraham"                                if method == "sa"
replace nm  = "Borusyak–Jaravel–Spiess"                    if method == "bjs"
replace nm  = "de Chaisemartin–D'Haultfœuille"             if method == "dcdh"
replace nm  = "Figure R2-06 (one start year at a time)"    if method == "r2_06"
replace sub = "start years weighted by starters"            if method == "r2_06"
replace nm  = "Previous paper's stricter start rule"       if method == "bjs_B"
replace sub = "Borusyak–Jaravel–Spiess, years 0 to +`whi' at once" if method == "bjs_B"
gen double xnm  = `xn'
gen double ysub = ypos - 0.45
gen double yown = ypos - 0.26                           // own overall number: just under its row, never on top of the dot
gen double yhdr = 9.1                                   // column headers
gen str6 hdr = "Method" if _n == 1
* Notes as one text, wrapped by printed width (R2-05's rule; widths in em).
local gapnote ""
if "`gapyr'" != "" & (`ok_cs' | `ok_sa' | `ok_dcdh') {
    local g1 : word 1 of `gapyr'
    local gapnote "No `gapyr' file: Callaway–Sant'Anna, Sun–Abraham and de Chaisemartin–D'Haultfœuille leave out firms that started in `=`g1'+1'."
}
local txt "Notes: Every row compares firms that start exporting (first year seen exporting after a year seen not exporting) with firms never seen"
local txt "`txt' exporting: the change in value added per GJ since before the start."
local txt "`txt' Rows 2 to 5 are the previous paper's four methods, named after their authors; they differ only in how they combine"
local txt "`txt' firms that start in different years: Callaway–Sant'Anna, Sun–Abraham and de Chaisemartin–D'Haultfœuille compare each start"
local txt "`txt' year only with never-exporters; Borusyak–Jaravel–Spiess also uses later starters' years before their start."
local txt "`txt' Figure R2-03's single regression can mix start years."
local txt "`txt' The first `nw' averages run from `s_min' to `s_max'; `clr' (a bar crossing 0 = no clear difference)."
local txt "`txt' Before the start = the method's own check that starters were not already changing differently (p below 0.05 = they were)."
local txt "`txt' `gapnote' Value added = output value minus materials, energy and services bought (current prices); GJ = gigajoules."
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
twoway (pci 0.5 0 8.5 0, lcolor(gs8) lwidth(thin)) ///
    (rspike pct_hi pct_lo ypos if row_type == "avg" & ok, horizontal lcolor(black) lwidth(thin)) ///
    (scatter ypos pct if row_type == "avg" & ok & method_order <= 5, msymbol(O) msize(small) mcolor(black)) ///
    (scatter ypos pct if row_type == "avg" & ok & method_order > 5, msymbol(D) msize(small) mcolor(black)) ///
    (scatter ypos pct_hi if row_type == "avg" & ok, msymbol(none) mlabel(lbl) mlabposition(3) mlabgap(0.8) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter yown pct if row_type == "own_overall" & ok, msymbol(Dh) msize(small) mcolor(gs8)) ///
    (scatter ypos xnm if row_type == "avg", msymbol(none) mlabel(nm) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ysub xnm if row_type == "avg" & sub != "", msymbol(none) mlabel(sub) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ypos xc1 if row_type == "avg" & ok, msymbol(none) mlabel(c1) mlabposition(9) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xc2 if row_type == "avg" & ok, msymbol(none) mlabel(c2) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)) ///
    (scatter ypos xnr if row_type == "avg" & !ok, msymbol(none) mlabel(nolbl) mlabposition(3) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter ysub xc2 if c2b != "", msymbol(none) mlabel(c2b) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)) ///
    (scatter yhdr xnm if hdr != "", msymbol(none) mlabel(hdr) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(black)), ///
    text(9.1 `xc1' "Starters", size(vsmall) placement(w)) ///
    text(9.1 `xc2' "Before the start, p", size(vsmall) placement(e)) ///
    yscale(range(0.5 9.3) off) ylabel(, nogrid) ytitle("") ///
    xscale(range(`xn' `xr') noline) ///
    xlabel(`xbot'(`step')`xtop', labsize(vsmall) noticks tlength(0) grid glcolor(gs14) glwidth(vthin) format(`xfmt')) ///
    xtitle("") ///
    legend(order(3 "Average of years 0 to +`whi' (each year counts equally)" 4 "Other kind of average (gray text under the row name)" ///
                 6 "Previous paper's summary: all years after the start" 2 "95% interval" 1 "0 = no difference") ///
        cols(2) position(6) region(lstyle(none)) size(vsmall) symxsize(5) keygap(1) colgap(4) rowgap(0.3)) ///
    title("Figure `exhibit'. Energy efficiency after firms start exporting, by method", size(medium) position(11) justification(left) span) ///
    subtitle("Value added per GJ: % change after the start, starters minus never-exporters", size(small) position(11) justification(left) span) ///
    note(`notes' "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+3)) plotregion(style(none)) ///
    xsize(9) ysize(8.5) scale(`=7.5/8.5')                   // text as in R2-03 (9 x 7.5 in), more room for rows

graph export "figures/`fname'.png", width(2700) replace
graph export "figures/`fname'.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/`fname'.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
