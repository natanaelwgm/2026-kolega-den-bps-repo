/*==========================================================================
  R3-07  Are the firms that cut energy and CO2 more productive?
         A: productivity of reducers vs non-reducers (the R3-01 firm flag),
            each firm averaged over its years with a productivity figure.
         B: how often the one-year changes of more and less productive
            firms (productivity at the START of the change) fell more than
            the typical firm's that year - energy and CO2, per unit of value
            added and in total.
         Productivity = the development productivity residual in current
         prices (dev_nominal_tfp_lp, Levinsohn-Petrin), compared with firms
         of the same sector and year.
  Answers Deasy R3: "Siapa yang reduce energy use and emisi? ... determinan
         motivasi ..." - "Bukan kausal" (this shows who, not why).
  Output : figures/07_productivity_reducers.png (+ .pdf)
           tables/07_productivity_reducers_firms.csv    (A: firm level)
           tables/07_productivity_reducers_changes.csv  (B: per quarter)
           tables/07_productivity_reducers_table.pdf (every plotted point)
           tables/07_productivity_reducers_regression.pdf (the regressions behind A)
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
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r3-energy-emissions-correlates"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/07_productivity_reducers.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-07] STARTING: are the firms that cut energy and CO2 more productive? ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/9: load the variables; how many firm-years have a productivity figure?"
*---------------------------------------------------------------------------
* dev_nominal_tfp_lp = productivity residual: log value added minus what the
*   firm's workers and last year's capital stock predict (Levinsohn-Petrin,
*   estimated per sector). Current prices, no deflation: a DEVELOPMENT
*   figure, not real productivity. Blank = no estimate (never zero).
* dev_nominal_common_tfp_lp = same method on the much smaller sample where all
*   four methods can be estimated (needs reported investment); robustness only.
* dev_nominal_tfp_acf / _wrdg = two other methods on the same rows; robustness only.
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal workers industry2_reported ///
    dev_nominal_tfp_lp dev_nominal_tfp_acf dev_nominal_tfp_wrdg dev_nominal_common_tfp_lp using "$DATA", clear
isid firm_id year
xtset firm_id year
gen byte has_prod = !missing(dev_nominal_tfp_lp)
quietly count if has_prod
local n_prod_rows = r(N)
quietly count if !missing(dev_nominal_common_tfp_lp)
display "   firm-years with a productivity figure: `n_prod_rows' (common-sample version: " r(N) ")"
quietly count if has_prod & missing(L.year)
display "   ... of which without a record the year before (expected 0): " r(N)
* sectors with at least one productivity figure, out of all sectors in the file
egen byte tags = tag(industry2_reported)
bysort industry2_reported: egen byte sec_has = max(has_prod)
quietly count if tags & !missing(industry2_reported)
local n_sec_all = r(N)
quietly count if tags & sec_has == 1 & !missing(industry2_reported)
local n_sec_prod = r(N)
display "   sectors with productivity figures: `n_sec_prod' of `n_sec_all'"
tab year has_prod
quietly summarize workers if has_prod, detail
local w_prod = r(p50)
quietly summarize workers if !has_prod, detail
local w_noprod = r(p50)
display "   median workers: with productivity `w_prod', without `w_noprod'"
drop tags sec_has
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/9: one-year changes and the R3 reducer flag (same code as R3-01)"
*---------------------------------------------------------------------------
gen double energy    = total_gj_s1
gen double co2       = co2_total_s1
gen double energy_va = total_gj_s1  / value_added_nominal
gen double co2_va    = co2_total_s1 / value_added_nominal
gen byte pair1 = !missing(L.total_gj_s1)                        // firm is in last year's file
gen byte cmp = pair1 & total_gj_s1>0 & L.total_gj_s1>0 & co2_total_s1>0 & L.co2_total_s1>0 ///
               & value_added_nominal>0 & L.value_added_nominal>0
assert pair1 == 0 if year == 2017                               // no 2016 file
foreach v in energy co2 energy_va co2_va {
    gen double chg_`v' = ln(`v') - ln(L.`v') if cmp
}
foreach v in energy co2 energy_va co2_va {
    * Year-adjusted: this firm's change minus the typical (median) change of all
    * compared firms in the same year, so the years a firm happens to be
    * observed in do not decide whether it is a reducer.
    bysort year: egen double med_chg_`v' = pctile(chg_`v'), p(50)   // median; egen median() would ignore "double"
    gen double rel_chg_`v' = chg_`v' - med_chg_`v'
    bysort firm_id: egen int    n_chg_`v'   = count(chg_`v')
    bysort firm_id: egen double avg_chg_`v' = mean(chg_`v')
    bysort firm_id: egen double avg_rel_`v' = mean(rel_chg_`v')
    gen byte reducer_`v'     = (avg_chg_`v' < 0) if n_chg_`v' >= 2
    gen byte reducer_adj_`v' = (avg_rel_`v' < 0) if n_chg_`v' >= 2
}
xtset firm_id year                // the bysort calls above changed the sort order

*---------------------------------------------------------------------------
display "Step 3/9: productivity compared with firms of the same sector and year"
*---------------------------------------------------------------------------
* The residual is in logs and in current prices, so its level drifts with
* prices from year to year and differs by sector: each figure is taken
* relative to the average figure of the same sector and year.
local meths tfp_lp tfp_acf tfp_wrdg common_tfp_lp
foreach m of local meths {
    bysort industry2_reported year: egen double mn_`m' = mean(dev_nominal_`m')
    gen double rel_`m' = dev_nominal_`m' - mn_`m'
    bysort firm_id: egen double avg_`m' = mean(rel_`m')     // firm average over its years with a figure
}
bysort firm_id: egen int n_prod_yrs = count(rel_tfp_lp)
xtset firm_id year
* one-year changes: did they beat the typical change? (as R3-02; value added added as a check)
gen double chg_va = ln(value_added_nominal) - ln(L.value_added_nominal) if cmp
bysort year: egen double med_chg_va = pctile(chg_va), p(50)
gen double rel_chg_va = chg_va - med_chg_va
xtset firm_id year
foreach v in energy_va co2_va energy co2 va {
    gen byte beat_`v' = (rel_chg_`v' < 0) if cmp
}
gen int    start_year = year - 1 if cmp
gen double s_prod = L.rel_tfp_lp if cmp            // productivity at the START of the change
gen double s_lnE  = ln(L.total_gj_s1) if cmp       // starting energy (log)
gen double s_workers = L.workers if cmp
* quarters of starting productivity within each start year; 5 = no figure at the start
gen byte g_q = .
quietly levelsof start_year if !missing(s_prod), local(qys)
foreach y of local qys {
    xtile tmp = s_prod if start_year == `y', nq(4)
    replace g_q = tmp if start_year == `y'
    drop tmp
}
replace g_q = 5 if cmp & missing(s_prod)
* fifths of starting energy within start year (used for a check in the CSV)
gen byte e5 = .
quietly levelsof start_year if cmp, local(ays)
foreach y of local ays {
    xtile tmp = s_lnE if start_year == `y', nq(5)
    replace e5 = tmp if start_year == `y'
    drop tmp
}
quietly count if cmp
local n_cmp_num = r(N)
local n_cmp = strtrim(string(r(N), "%9.0fc"))
quietly count if cmp & !missing(g_q)
assert r(N) == `n_cmp_num'                         // every change sits in exactly one group
quietly count if cmp & g_q < 5
local n_bq_num = r(N)
local n_bq = strtrim(string(r(N), "%9.0fc"))
display "   one-year changes: `n_cmp'; with productivity at the start: `n_bq'"
tab start_year if cmp & g_q < 5

*---------------------------------------------------------------------------
display "Step 4/9: which start year drives the productivity gap? (leave one out)"
*---------------------------------------------------------------------------
* Gap = firm-average productivity, reducers minus non-reducers (main flag).
* The start year whose removal moves the gap most is shown separately in A.
egen byte tagf = tag(firm_id)
quietly regress avg_tfp_lp i.reducer_adj_energy_va if tagf, vce(robust)
local gap_all = _b[1.reducer_adj_energy_va]
quietly levelsof start_year if cmp, local(sys)
local best = -1
local second = -1
local yx = .
foreach s of local sys {
    capture drop lx_rel lx_n lx_avg lx_flag
    gen double lx_rel = rel_chg_energy_va if start_year != `s'
    bysort firm_id: egen int    lx_n   = count(lx_rel)
    bysort firm_id: egen double lx_avg = mean(lx_rel)
    gen byte lx_flag = (lx_avg < 0) if lx_n >= 2
    quietly regress avg_tfp_lp i.lx_flag if tagf, vce(robust)
    local d = abs(_b[1.lx_flag] - `gap_all')
    display "   without changes starting in `s': gap moves by " %5.3f `d' " log points"
    if `d' > `best' {
        local second = `best'
        local best = `d'
        local yx = `s'
    }
    else if `d' > `second' local second = `d'
}
drop lx_rel lx_n lx_avg lx_flag
* how unusual are the energy changes that start in the chosen year? Bottom tenth
* of the change (used in the notes only when far larger than in any other year)
quietly summarize chg_energy if start_year == `yx', detail
local q_yx = r(p10)
local q_oth = .
foreach s of local sys {
    if `s' == `yx' continue
    quietly summarize chg_energy if start_year == `s', detail
    local q_oth = min(`q_oth', r(p10))
}
display "   bottom tenth of energy changes starting in `yx': " %6.3f `q_yx' " (other years at most " %6.3f `q_oth' ")"
display "   start year shown separately: `yx' (moves the gap by " %5.3f `best' "; next largest " %5.3f `second' ")"
xtset firm_id year
* flags rebuilt without the changes starting in `yx' (same rule otherwise)
foreach v in energy_va co2_va energy co2 {
    gen double x_rel_`v' = rel_chg_`v' if start_year != `yx'
    bysort firm_id: egen int    x_n_`v'   = count(x_rel_`v')
    bysort firm_id: egen double x_avg_`v' = mean(x_rel_`v')
    gen byte reducer_x_`v' = (x_avg_`v' < 0) if x_n_`v' >= 2
}
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 5/9: A - productivity gap, reducers vs non-reducers (one row per firm)"
*---------------------------------------------------------------------------
* The gap is in log points; 100*(exp(gap)-1) turns it into a % difference.
* One row per firm, so a plain robust interval is right.
tempname P
tempfile arows
postfile `P' int row_order byte in_figure str24 measure str40 measure_label str16 productivity ///
    str40 flag_version int left_out_start_year double(gap_move_left_out gap_move_next) ///
    long(firms_classified firms_with_productivity reducers nonreducers) ///
    double(gap_log gap_log_lo gap_log_hi gap_pct gap_pct_lo gap_pct_hi ///
           mean_rel_reducers mean_rel_nonreducers median_rel_reducers median_rel_nonreducers) ///
    int(sectors_with_productivity sectors_total) using `arows', replace
local r 0
foreach spec in "tfp_lp energy_va m" "tfp_lp energy_va x" "tfp_lp co2_va m" "tfp_lp co2_va x" ///
                "tfp_lp energy m" "tfp_lp energy x" "tfp_lp co2 m" "tfp_lp co2 x" ///
                "tfp_acf energy_va m" "tfp_wrdg energy_va m" "common_tfp_lp energy_va m" {
    local m : word 1 of `spec'
    local v : word 2 of `spec'
    local f : word 3 of `spec'
    local flag = cond("`f'" == "m", "reducer_adj_`v'", "reducer_x_`v'")
    local ver  = cond("`f'" == "m", "all one-year changes", "without changes starting in `yx'")
    if "`v'" == "energy_va" local vl "Energy per unit of VA"
    if "`v'" == "co2_va"    local vl "CO2 per unit of VA"
    if "`v'" == "energy"    local vl "Energy use, GJ"
    if "`v'" == "co2"       local vl "CO2 emitted, tonnes"
    local ++r
    quietly count if tagf & !missing(`flag')
    local ncl = r(N)
    quietly count if tagf & !missing(`flag') & !missing(avg_`m')
    local nwp = r(N)
    quietly count if tagf & `flag' == 1 & !missing(avg_`m')
    local n1 = r(N)
    quietly count if tagf & `flag' == 0 & !missing(avg_`m')
    local n0 = r(N)
    local g = .
    local glo = .
    local ghi = .
    foreach k in rb rse rcb rcs rn {                         // for the regression table (Step 9)
        local `k'_`r' = .
    }
    if `n1' > 1 & `n0' > 1 {
        quietly regress avg_`m' i.`flag' if tagf, vce(robust)
        local rb_`r'  = _b[1.`flag']                         // for the regression table (Step 9)
        local rse_`r' = _se[1.`flag']
        local rcb_`r' = _b[_cons]
        local rcs_`r' = _se[_cons]
        local rn_`r'  = e(N)
        local g   = _b[1.`flag']
        local glo = _b[1.`flag'] - invttail(e(df_r), 0.025) * _se[1.`flag']
        local ghi = _b[1.`flag'] + invttail(e(df_r), 0.025) * _se[1.`flag']
    }
    quietly summarize avg_`m' if tagf & `flag' == 1, detail
    local m1 = r(mean)
    local p1 = r(p50)
    quietly summarize avg_`m' if tagf & `flag' == 0, detail
    local m0 = r(mean)
    local p0 = r(p50)
    local infig = ("`m'" == "tfp_lp")
    local lo_out = cond("`f'" == "x", `yx', .)
    post `P' (`r') (`infig') ("`v'") ("`vl'") ("`m'") ("`ver'") (`lo_out') (`best') (`second') ///
        (`ncl') (`nwp') (`n1') (`n0') (`g') (`glo') (`ghi') ///
        (100 * (exp(`g') - 1)) (100 * (exp(`glo') - 1)) (100 * (exp(`ghi') - 1)) ///
        (`m1') (`m0') (`p1') (`p0') (`n_sec_prod') (`n_sec_all')
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 6/9: B - share of changes beating the typical firm, by productivity quarter at the start"
*---------------------------------------------------------------------------
* The interval allows for the same firm appearing in several years (clustered by firm).
* Gap = this quarter minus the least productive quarter.
tempname Q
tempfile brows
postfile `Q' int row_order byte in_figure str32 group long(changes firms) ///
    double(prod_rel_min prod_rel_median prod_rel_max start_workers_median start_energy_vs_least) ///
    double(pct_energy_va lo_energy_va hi_energy_va gap_energy_va gap_lo_energy_va gap_hi_energy_va ///
           pct_co2_va lo_co2_va hi_co2_va gap_co2_va gap_lo_co2_va gap_hi_co2_va ///
           pct_energy lo_energy hi_energy gap_energy gap_lo_energy gap_hi_energy ///
           pct_co2 lo_co2 hi_co2 gap_co2 gap_lo_co2 gap_hi_co2 ///
           pct_va_fell_more gap_energy_same_start_energy gap_lo_energy_same_start_energy ///
           gap_hi_energy_same_start_energy pct_energy_va_early) long changes_early ///
    double pct_energy_va_late long changes_late using `brows', replace
* starting energy relative to the least productive quarter, same start year
local er1 = 1                   // the least productive quarter is the reference
forvalues k = 2/5 {
    local er`k' = .
}
capture regress s_lnE ib1.g_q i.start_year if g_q < 5
if _rc == 0 {
    forvalues k = 2/4 {
        local er`k' = exp(_b[`k'.g_q])
    }
}
* energy-use gap vs the least productive quarter when starting energy is held
* fixed (same fifth of starting energy, same start year) - CSV check only
forvalues k = 1/5 {
    local ss`k' = .
    local ssl`k' = .
    local ssh`k' = .
}
capture regress beat_energy ib1.g_q i.start_year#i.e5 if g_q < 5, vce(cluster firm_id)
if _rc == 0 {
    forvalues k = 2/4 {
        quietly lincom 100 * `k'.g_q
        local ss`k'  = r(estimate)
        local ssl`k' = r(lb)
        local ssh`k' = r(ub)
    }
}
local gl `""Lowest 25%" "25–50%" "50–75%" "Highest 25%" "No productivity figure at start""'
forvalues k = 1/5 {
    quietly count if cmp & g_q == `k'
    if r(N) == 0 continue
    local gname : word `k' of `gl'
    local vals ""
    foreach v in energy_va co2_va energy co2 {
        quietly mean beat_`v' if cmp & g_q == `k', vce(cluster firm_id)
        matrix T = r(table)
        local p  = 100 * T[1,1]
        local lo = 100 * T[5,1]
        local hi = 100 * T[6,1]
        local nn = e(N)
        local nf = e(N_clust)
        local g = .
        local glo = .
        local ghi = .
        if inrange(`k', 2, 4) {
            quietly regress beat_`v' ib1.g_q if cmp & g_q < 5, vce(cluster firm_id)
            quietly lincom 100 * `k'.g_q
            local g   = r(estimate)
            local glo = r(lb)
            local ghi = r(ub)
        }
        local vals `vals' (`p') (`lo') (`hi') (`g') (`glo') (`ghi')
    }
    quietly summarize beat_va if cmp & g_q == `k'
    local pva = 100 * r(mean)
    local pmin = .
    local pmed = .
    local pmax = .
    if `k' < 5 {
        quietly summarize s_prod if cmp & g_q == `k', detail
        local pmin = r(min)
        local pmed = r(p50)
        local pmax = r(max)
    }
    quietly summarize s_workers if cmp & g_q == `k', detail
    local wmed = r(p50)
    quietly summarize beat_energy_va if cmp & g_q == `k' & year < 2016
    local pe = 100 * r(mean)
    local ne = r(N)
    quietly summarize beat_energy_va if cmp & g_q == `k' & year > 2016
    local pl = 100 * r(mean)
    local nl = r(N)
    post `Q' (`k') ((`k' < 5)) ("`gname'") (`nn') (`nf') (`pmin') (`pmed') (`pmax') (`wmed') (`er`k'') ///
        `vals' (`pva') (`ss`k'') (`ssl`k'') (`ssh`k'') (`pe') (`ne') (`pl') (`nl')
}
postclose `Q'
quietly count if start_year == `yx' & g_q < 5
local n_yx_b = r(N)
display "   changes in B that start in `yx': `n_yx_b'"

*---------------------------------------------------------------------------
display "Step 7/9: numbers -> two CSV files (written before drawing)"
*---------------------------------------------------------------------------
use `arows', clear
format firms_* reducers nonreducers %9.0f
format gap_* mean_* median_* %7.3f
format gap_pct* %7.2f
export delimited using "tables/07_productivity_reducers_firms.csv", datafmt replace
list row_order productivity measure flag_version firms_with_productivity reducers nonreducers gap_pct gap_pct_lo gap_pct_hi, ///
    noobs sep(0) abbreviate(24)
assert gap_log_lo <= gap_log & gap_log <= gap_log_hi if !missing(gap_log)
* numbers for the notes (read from the data, never typed)
quietly summarize gap_pct if productivity == "tfp_lp" & measure == "energy_va" & left_out_start_year == .
local s_gm = strtrim(string(r(mean), "%5.0f"))
quietly summarize gap_pct if productivity == "tfp_lp" & measure == "energy_va" & left_out_start_year == `yx'
local s_gx = strtrim(string(r(mean), "%5.0f"))
quietly summarize firms_with_productivity if productivity == "tfp_lp" & measure == "energy_va" & left_out_start_year == .
local s_fwp = strtrim(string(r(mean), "%9.0fc"))
quietly summarize firms_classified if productivity == "tfp_lp" & measure == "energy_va" & left_out_start_year == .
local s_fcl = strtrim(string(r(mean), "%9.0fc"))
use `brows', clear
format changes firms start_workers_median changes_* %9.0f
format prod_rel_* start_energy_vs_least %7.3f
format pct_* lo_* hi_* gap_* %6.2f
export delimited using "tables/07_productivity_reducers_changes.csv", datafmt replace
list row_order group changes pct_energy_va lo_energy_va hi_energy_va pct_energy pct_va_fell_more start_energy_vs_least, ///
    noobs sep(0) abbreviate(24)
list row_order group gap_energy gap_energy_same_start_energy pct_energy_va_early pct_energy_va_late, noobs sep(0) abbreviate(24)
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va
* sentences (conditional, so they never misstate the actual data)
quietly summarize pct_va_fell_more if row_order == 4
local p_va4 = r(mean)
quietly summarize pct_va_fell_more if row_order == 1
local p_va1 = r(mean)
quietly summarize start_energy_vs_least if row_order == 4
local e_ratio = r(mean)
quietly summarize changes if row_order < 5
local s_nbq = strtrim(string(r(sum), "%9.0fc"))
local bnote ""
if `n_yx_b' == 0 local bnote " B has no `yx' starts (no productivity that year)."
* why the chosen start year matters (only when its energy cuts are far larger than in other years)
local yx1 = `yx' + 1
local recnote ""
if !missing(`q_oth') & `q_oth' < 0 & `q_yx' < 2 * `q_oth' {
    local s_q1 = strtrim(string(100 * (1 - exp(`q_yx')), "%4.1f"))
    local s_q0 = strtrim(string(100 * (1 - exp(`q_oth')), "%4.1f"))
    local recnote "From `yx' to `yx1', one firm in ten cut its recorded energy by `s_q1'% or more, far beyond other years (at most `s_q0'%): likely a recording change."
}
local yxnote "Without changes starting in `yx' (triangles), the gap in (a) is `s_gx'%, not `s_gm'%.`bnote'"
if "`recnote'" == "" local yxnote "Without changes starting in `yx' (the start year that moves A most; triangles), the gap in (a) is `s_gx'%, not `s_gm'%.`bnote'"
local vanote "VA is in productivity and in energy per VA: a high-VA year raises the first and lowers the second at once (A)."
if !missing(`p_va4') & `p_va4' > `p_va1' + 5 local vanote "VA is in productivity and in energy per VA: a high-VA year raises the first and lowers the second at once (A); high VA then tends to fall back, raising energy per VA (B)."
* who has a productivity figure (coverage, from the data)
local smaller = cond(`w_prod' <= `w_noprod', "smaller", "larger")
local covnote "Productivity exists for `s_fwp' of `s_fcl' firms in A and `n_bq' of `n_cmp' changes in B: `n_sec_prod' of `n_sec_all' sectors, needs last year's capital; `smaller' firms (median `w_prod' vs `w_noprod' workers)."
* start size: firms that start high tend to fall back, so gaps in totals are partly automatic
local fbnote ""
if !missing(`e_ratio') & abs(ln(`e_ratio')) > ln(1.5) {          // only when starting sizes clearly differ
    local s_er = strtrim(string(`e_ratio', "%4.0f"))
    if `e_ratio' < 10 local s_er = strtrim(string(`e_ratio', "%4.1f"))
    local big = cond(`e_ratio' >= 1, "bigger", "smaller")
    local hl = cond(`e_ratio' >= 1, "big starts tend to fall back, lifting their (c)–(d) shares", "small starts tend to rise back, lowering their (c)–(d) shares")
    local fbnote "The most productive 25% are `big' firms: `s_er' times the energy of the least productive at the start (same year); `hl'."
}

*---------------------------------------------------------------------------
display "Step 8/9: draw A (gap per reducer measure) and B (dot plot per quarter), then combine"
*---------------------------------------------------------------------------
* graph combine shrinks relative text sizes unevenly between parts, so text is
* set in points: 13pt = "small", 10pt = "vsmall" in the other R3 figures.
local sm "13pt"
local vs "10pt"
* ---- A: productivity gap, reducers vs non-reducers, one row per reducer measure ----
use `arows', clear
keep if in_figure
gen byte ver = cond(missing(left_out_start_year), 1, 2)
gen byte y = cond(measure == "energy_va", 1, cond(measure == "co2_va", 2, cond(measure == "energy", 3, 4)))
keep y ver measure_label reducers nonreducers gap_pct gap_pct_lo gap_pct_hi
reshape wide reducers nonreducers gap_pct gap_pct_lo gap_pct_hi, i(y) j(ver)
sort y
local ylabA `"0 "Measure (firms: reducers / non-reducers)""'
local lets "a b c d"
forvalues i = 1/`=_N' {
    local let : word `i' of `lets'
    local ml = measure_label[`i']
    local n1 = strtrim(string(reducers1[`i'], "%9.0fc"))
    local n0 = strtrim(string(nonreducers1[`i'], "%9.0fc"))
    local ylabA `"`ylabA' `i' "(`let') `ml' (`n1' / `n0')""'
}
gen double ya = y - 0.17
gen double yb = y + 0.17
* value labels past the whisker end that points away from 0
gen str8   la = string(gap_pct1, "%4.0f") + "%"
gen str8   lb = string(gap_pct2, "%4.0f") + "%"
gen double xa = cond(gap_pct1 >= 0, gap_pct_hi1, gap_pct_lo1)
gen double xb = cond(gap_pct2 >= 0, gap_pct_hi2, gap_pct_lo2)
gen byte   pa = cond(gap_pct1 >= 0, 3, 9)
gen byte   pb = cond(gap_pct2 >= 0, 3, 9)
* x range: whiskers plus room for labels, steps of 20, always including 0
egen double xmin = rowmin(gap_pct_lo1 gap_pct_lo2)
egen double xmax = rowmax(gap_pct_hi1 gap_pct_hi2)
quietly summarize xmin
local axlo = min(0, 20 * floor(r(min) / 20))
local arlo = min(0, r(min) - 12)
quietly summarize xmax
local axhi = max(0, 20 * floor(r(max) / 20))
local arhi = max(0, r(max) + 16)
local nA = _N
gen double zx = 0 in 1/2
gen double zy = cond(_n == 1, 0.5, `nA' + 0.5) in 1/2
twoway (rspike gap_pct_lo1 gap_pct_hi1 ya, horizontal lcolor(black) lwidth(0.6pt)) ///
    (rspike gap_pct_lo2 gap_pct_hi2 yb, horizontal lcolor(gs8) lwidth(0.6pt)) ///
    (scatter ya gap_pct1, msymbol(O) mcolor(black) msize(4.5pt)) ///
    (scatter yb gap_pct2, msymbol(Th) mcolor(gs5) msize(5.5pt)) ///
    (scatter ya xa, msymbol(none) mlabel(la) mlabvposition(pa) mlabgap(0.6) mlabsize(`vs') mlabcolor(black)) ///
    (scatter yb xb, msymbol(none) mlabel(lb) mlabvposition(pb) mlabgap(0.6) mlabsize(`vs') mlabcolor(gs5)) ///
    (line zy zx, lpattern(dash) lcolor(gs8) lwidth(0.6pt)), ///
    yscale(reverse noline range(-0.3 `=`nA' + 0.5')) ylabel(`ylabA', angle(0) noticks tlength(0) nogrid labsize(`vs')) ytitle("") ///
    xscale(range(`arlo' `arhi') lcolor(gs10)) ///
    xlabel(`axlo'(20)`axhi', noticks tlength(0) labsize(`vs') grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Reducers' average productivity compared with non-reducers' (% difference)", size(`vs')) ///
    legend(order(3 "Reducers found from all one-year changes" 4 "Reducers found without changes starting in `yx'" 1 "95% interval" 7 "0 = no difference") ///
        pos(6) cols(2) region(lcolor(none)) size(`vs') symxsize(8) keygap(1) colgap(5)) ///
    subtitle("A. Productivity of reducers compared with non-reducers (each firm averaged over its years with a productivity number)", ///
        size(`sm') pos(11) nobox span) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none)) fysize(44) name(pA, replace) nodraw

* ---- B: dot plot, four panels on one shared scale ----
use `brows', clear
keep if in_figure
sort row_order
gen double y = row_order + 1
local ylab `"0 "Group (number of one-year changes)" 1 "{bf:Productivity at the start, within each year:}""'
forvalues i = 1/`=_N' {
    local nstr = strtrim(string(changes[`i'], "%9.0fc"))
    local gnm = group[`i']
    local ylab `"`ylab' `=y[`i']' "`gnm' (`nstr')""'
}
local ymax = _N + 1.5
expand 4
bysort row_order: gen byte panel = _n
gen double pct = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo  = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi  = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
gen str8   plab = string(pct, "%4.1f")
gen double labx = cond(pct < 50, lo, hi)
gen byte   labp = cond(pct < 50, 9, 3)
label define panel 1 "(a) Energy per unit of VA" 2 "(b) CO2 per unit of VA" 3 "(c) Energy use (GJ)" 4 "(d) CO2 emitted (tonnes)"
label values panel panel
* dashed reference line at 50% in each panel
local n0 = _N
set obs `=_N + 8'
gen double refx = 50 if _n > `n0'
gen double refy = .
forvalues p = 1/4 {
    replace panel = `p' in `=`n0' + 2*`p' - 1'
    replace panel = `p' in `=`n0' + 2*`p''
    replace refy = 1.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
}
* symmetric x range around 50: whiskers plus room for the value labels, steps of 5
quietly summarize lo
local dlo = 50 - r(min)
quietly summarize hi
local dhi = r(max) - 50
local half = max(10, 5 * ceil((max(`dlo', `dhi') + 4) / 5))
local xlo = 50 - `half'
local xhi = 50 + `half'
local xs  = 10 * floor(`half' / 10)
sort panel refy y
twoway (rspike lo hi y, horizontal lcolor(black) lwidth(0.6pt)) ///
    (scatter y pct, msymbol(O) mcolor(black) msize(4.5pt)) ///
    (scatter y labx, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(`vs') mlabcolor(black)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(0.6pt)), ///
    by(panel, rows(1) note("") graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("B. Share of one-year changes that fell more (or rose less) than the typical firm's that year, by productivity at the start", ///
              size(`sm') pos(11) span)) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(`sm')) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(`vs')) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(10)`=50 + `xs'', noticks tlength(0) labsize(`vs') grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical firm's that year (% of the group's changes)", size(`vs')) ///
    legend(order(2 "Share (%)" 1 "95% interval" 4 "50% = same as the typical firm") rows(1) region(lcolor(none)) ///
        size(`vs') symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) fysize(48) name(pB, replace) nodraw

graph combine pA pB, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("Figure R3-07. Are the firms that cut energy and CO2 more productive?", size(`sm') pos(11) span) ///
    note("Notes: Productivity = value added (VA) beyond what the firm's workers and capital (buildings, machines) predict, compared with firms of the same sector and year." ///
         "A: reducer = firm with 2+ one-year changes in the row's measure that fell on average more, or rose less, than the typical firm's. Shows who, not why." ///
         "B: dot = share of the group's one-year changes that fell more (or rose less) than the typical firm's that year; interval crossing the line = no clear gap." ///
         "`recnote'" ///
         "`yxnote'" ///
         "`vanote'" ///
         "`fbnote'" ///
         "`covnote'" ///
         "VA = output minus materials, energy and services bought, current prices. GJ = gigajoules." ///
         "`srcnote'" "`devnote'", size(`vs') span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(l+3 r+2)) xsize(10.5) ysize(11.5)

graph export "figures/07_productivity_reducers.png", width(3150) replace
graph export "figures/07_productivity_reducers.pdf", replace

*---------------------------------------------------------------------------
display "Step 9/9: companion tables: every plotted point, and the regression table"
*---------------------------------------------------------------------------
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
* Source: the two tables saved in memory before the CSV export (`arows' for A,
* `brows' for B: full precision, same estimation run as the chart).
* (1) Points table: one row per point, in chart order: A rows (a)-(d), each the
* dot (all changes) then the triangle (without `yx'); then B panels (a)-(d),
* each productivity quarter top to bottom, and the table-only group (not drawn).
use `arows', clear
keep if in_figure
gen byte ver = cond(missing(left_out_start_year), 1, 2)
gen byte y = cond(measure == "energy_va", 1, cond(measure == "co2_va", 2, cond(measure == "energy", 3, 4)))
sort y ver
local lets "a b c d"
gen str40 t_panel  = "A"
gen str40 t_series = cond(ver == 1, "All changes", "Without `yx'")
gen str60 t_pos = ""
forvalues i = 1/4 {
    local let : word `i' of `lets'
    quietly replace t_pos = "(`let') " + measure_label if y == `i'
}
* rounding as the chart labels: whole-number %
gen str12 t_v  = string(gap_pct,    "%9.0f")
gen str12 t_lo = string(gap_pct_lo, "%9.0f")
gen str12 t_hi = string(gap_pct_hi, "%9.0f")
gen str24 t_n  = string(reducers, "%12.0fc") + " / " + string(nonreducers, "%12.0fc")
gen str12 t_c  = ""
gen str90 t_status = cond(ver == 1, "drawn: dot", "drawn: triangle")
local nA = _N
assert `nA' == 8
assert !missing(gap_pct, gap_pct_lo, gap_pct_hi)
gen int ord = _n
keep ord t_*
tempfile ctA
quietly save `ctA'
use `brows', clear
sort row_order
quietly count if in_figure
local nqB = r(N)
expand 4
bysort row_order: gen byte panel = _n
gen double v  = cond(panel == 1, pct_energy_va, cond(panel == 2, pct_co2_va, cond(panel == 3, pct_energy, pct_co2)))
gen double lo = cond(panel == 1, lo_energy_va,  cond(panel == 2, lo_co2_va,  cond(panel == 3, lo_energy,  lo_co2)))
gen double hi = cond(panel == 1, hi_energy_va,  cond(panel == 2, hi_co2_va,  cond(panel == 3, hi_energy,  hi_co2)))
gen str40 t_panel = ""
replace t_panel = "B (a) Energy per VA" if panel == 1
replace t_panel = "B (b) CO2 per VA"    if panel == 2
replace t_panel = "B (c) Energy use"    if panel == 3
replace t_panel = "B (d) CO2 emitted"   if panel == 4
gen str40 t_series = "Share (%)"
gen str60 t_pos = group
* rounding as the chart labels: one decimal
gen str12 t_v  = string(v,  "%9.1f")
gen str12 t_lo = string(lo, "%9.1f")
gen str12 t_hi = string(hi, "%9.1f")
gen str24 t_n  = string(firms, "%12.0fc")
gen str12 t_c  = string(changes, "%12.0fc")
gen str90 t_status = cond(in_figure, "drawn: dot", "not drawn: table only (no figure at start)")
sort panel row_order
local nperB = _N / 4
gen int ord = 100 + _n
keep ord t_*
append using `ctA'
sort ord
* check: every drawn point of the chart is one row with a number
quietly count if !strpos(t_status, "not drawn")
assert r(N) == `nA' + 4 * `nqB'
assert t_v != "" & t_lo != "" & t_hi != ""
local tnote "Table: every point of Figure R3-07 in chart order. Values rounded as the chart labels. A: % difference = 100 × (exp(b) − 1),"
local tnote "`tnote' b = the regression table's coefficient; All changes = dot, Without `yx' = triangle (reducers found without changes"
local tnote "`tnote' starting in `yx'); Firms = reducers / non-reducers with a productivity figure. B: 95% interval clustered by firm; Firms"
local tnote "`tnote' and One-year changes = those behind the point; the last group is in the CSV only. Full precision:"
local tnote "`tnote' tables/07_productivity_reducers_firms.csv and _changes.csv."
local cnotes `""Notes: Productivity = value added (VA) beyond what the firm's workers and capital (buildings, machines) predict, compared with firms of the same sector and year.""'
local cnotes `"`cnotes' "A: reducer = firm with 2+ one-year changes in the row's measure that fell on average more, or rose less, than the typical firm's. Shows who, not why.""'
local cnotes `"`cnotes' "B: dot = share of the group's one-year changes that fell more (or rose less) than the typical firm's that year; interval crossing the line = no clear gap.""'
foreach n in recnote yxnote vanote fbnote covnote {
    if `"``n''"' != "" local cnotes `"`cnotes' "``n''""'
}
local cnotes `"`cnotes' "VA = output minus materials, energy and services bought, current prices. GJ = gigajoules.""'
ctable_pdf t_panel t_series t_pos t_v t_lo t_hi t_n t_c t_status using "tables/07_productivity_reducers_table.pdf", ///
    title("Table R3-07. Are the firms that cut energy and CO2 more productive? Every plotted point") ///
    header("Panel" "Series" "Row" "Plotted|value (%)" "95%|low" "95%|high" "Firms" "One-year|changes" "Status") ///
    right(4 5 6 7 8) norepeat(1) fontsize(9) ///
    rules(`nA' `=`nA' + `nperB'' `=`nA' + 2*`nperB'' `=`nA' + 3*`nperB'') perpage(`=`nA' + 2*`nperB'') /// A + B (a)-(b), then B (c)-(d) with the notes
    notes(`cnotes' "`tnote'" "`srcnote'" "`devnote'")
display "table -> tables/07_productivity_reducers_table.pdf"

* (2) Regression table (AER style) for A, whose points are regression
* coefficients: one column per regression (the 8 drawn, then the 3 other
* productivity methods, table only); coefficient, (standard error), [% difference].
use `arows', clear
sort row_order
* check: the coefficients are those in the CSV just written (3 decimals there)
preserve
import delimited using "tables/07_productivity_reducers_firms.csv", clear varnames(1)
keep row_order gap_log
rename gap_log b_csv
tempfile csvb
quietly save `csvb'
restore
merge 1:1 row_order using `csvb', assert(match) nogenerate
assert abs(gap_log - b_csv) <= 0.0005 + 1e-9
local nm = _N
local lets "a b c d"
foreach k in b s p c cs n r nr meth flg drw {
    local L_`k' ""
}
forvalues j = 1/`nm' {
    local r = row_order[`j']
    assert `rn_`r'' == reducers[`j'] + nonreducers[`j']        // firms in the regression
    assert abs(gap_log[`j'] - `rb_`r'') < 1e-12                  // same estimate as drawn
    local L_b  `"`L_b' ("`=string(gap_log[`j'], "%9.3f")'")"'
    local L_s  `"`L_s' ("(`=strtrim(string(`rse_`r'', "%9.3f"))')")"'
    local pp = gap_pct[`j']
    local L_p  `"`L_p' ("[`=cond(`pp' > 0, "+", "")'`=strtrim(string(`pp', "%9.1f"))'%]")"'
    local L_c  `"`L_c' ("`=string(`rcb_`r'', "%9.3f")'")"'
    local L_cs `"`L_cs' ("(`=strtrim(string(`rcs_`r'', "%9.3f"))')")"'
    local L_n  `"`L_n' ("`=strtrim(string(`rn_`r'', "%12.0fc"))'")"'
    local L_r  `"`L_r' ("`=strtrim(string(reducers[`j'], "%12.0fc"))'")"'
    local L_nr `"`L_nr' ("`=strtrim(string(nonreducers[`j'], "%12.0fc"))'")"'
    local pm = productivity[`j']
    local mt = cond("`pm'" == "tfp_lp", "LP", cond("`pm'" == "tfp_acf", "ACF", cond("`pm'" == "tfp_wrdg", "Wooldridge", "LP, common sample")))
    local L_meth `"`L_meth' ("`mt'")"'
    local fv = cond(missing(left_out_start_year[`j']), "All changes", "Without `yx'")
    local L_flg `"`L_flg' ("`fv'")"'
    local ms = measure[`j']
    local yi = cond("`ms'" == "energy_va", 1, cond("`ms'" == "co2_va", 2, cond("`ms'" == "energy", 3, 4)))
    local let : word `yi' of `lets'
    local dw = cond(in_figure[`j'], "A (`let') " + cond(missing(left_out_start_year[`j']), "dot", "triangle"), "No")
    local L_drw `"`L_drw' ("`dw'")"'
}
tempname P
tempfile R
local tv ""
forvalues j = 1/`nm' {
    local tv `tv' t`j'
}
postfile `P' str60 t_lab str24(`tv') using `R'
post `P' ("Reducer (1 = yes)") `L_b'
post `P' ("") `L_s'
post `P' ("") `L_p'
post `P' ("Constant") `L_c'
post `P' ("") `L_cs'
post `P' ("Observations (firms)") `L_n'
post `P' ("Reducers") `L_r'
post `P' ("Non-reducers") `L_nr'
local nY ""
local nN ""
local nR ""
local nU ""
forvalues j = 1/`nm' {
    local nY `"`nY' ("Yes")"'
    local nN `"`nN' ("No")"'
    local nR `"`nR' ("Robust")"'
    local nU `"`nU' ("None")"'
}
post `P' ("Productivity method") `L_meth'
post `P' ("Reducer flag from") `L_flg'
post `P' ("Firm fixed effects") `nN'
post `P' ("Year fixed effects") `nN'
post `P' ("Weights") `nU'
post `P' ("Standard errors") `nR'
post `P' ("Drawn in the figure") `L_drw'
postclose `P'
use `R', clear
local hdr ""
forvalues j = 1/`nm' {
    local ms : word `j' of "Energy per VA" "Energy per VA" "CO2 per VA" "CO2 per VA" "Energy use" "Energy use" "CO2 emitted" "CO2 emitted" "Energy per VA" "Energy per VA" "Energy per VA"
    local hdr `"`hdr' "(`j')|`ms'""'
}
local rnote "Notes: Each column is one regression across firms (one row per firm) of the firm's average productivity, in logs and relative"
local rnote "`rnote' to the average of its sector and year, on a reducer marker (1 = reducer by the column's measure, 0 = non-reducer)."
local rnote "`rnote' Reducer = firm with 2+ one-year changes in the measure that fell on average more, or rose less, than the typical firm's;"
local rnote "`rnote' Without `yx' = the same flag with the changes starting in `yx' left out. Productivity = development residual in current"
local rnote "`rnote' prices: LP = Levinsohn-Petrin (drawn), ACF = Ackerberg-Caves-Frazer, Wooldridge, and LP on the smaller sample where all"
local rnote "`rnote' methods exist (table only). Log points; standard errors in parentheses (robust); [% = 100 × (exp(b) − 1)], as drawn."
local rnote "`rnote' Constant = non-reducers' average. Standard errors robust (one row per firm, so no clustering needed). 95% interval in"
local rnote "`rnote' the chart = b ± t(0.975, firms − 2) × SE. No stars."
ctable_pdf t_lab `tv' using "tables/07_productivity_reducers_regression.pdf", ///
    title("Table R3-07, regression. Are the firms that cut energy and CO2 more productive? Estimates behind panel A") ///
    subtitle("Outcome: firm-average productivity (log, relative to the sector-year average). Columns = reducer measure") ///
    header("Reducer measure:" `hdr') right(2/`=`nm' + 1') rules(3 5 8) fontsize(9) perpage(60) ///
    notes("`rnote'" "`srcnote'" "`devnote'")
display "table -> tables/07_productivity_reducers_regression.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/07_productivity_reducers.png (elapsed `elapsed' s)"
quietly log close
