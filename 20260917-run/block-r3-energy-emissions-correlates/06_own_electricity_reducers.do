/*==========================================================================
  R3-06  Do the firms that cut energy make their own electricity?
         A: share of reducers and non-reducers (the R3-01 firm flag) that
            make some of their own electricity, each year.
         B: how often the one-year changes of firms that make (or start or
            stop making) their own electricity fell more than the typical
            firm's that year - energy and CO2, per unit of value added and
            in total.
         The pair of years that drives the pattern is found from the data
         and shown separately (A right panel, B triangles).
  Answers Deasy R3: "Siapa yang reduce energy use and emisi? ... determinan
         motivasi ..." - "Bukan kausal" (this shows who, not why).
  Output : figures/06_own_electricity_reducers.png (+ .pdf)
           tables/06_own_electricity_reducers_by_year.csv  (A: per year)
           tables/06_own_electricity_reducers_changes.csv  (B: per group)
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
log using "logs/06_own_electricity_reducers.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-06] STARTING: do the firms that cut energy make their own electricity? ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/8: load the variables we need"
*---------------------------------------------------------------------------
* own_gen_positive_reported = 1 if the firm made some of its own electricity
*   that year (kWh above zero), 0 if it made none, blank if not recorded
*   (blank is never counted as "none").
* total_gj_s1 = fuel (gj_fuel_s1) + BOUGHT electricity (gj_electricity).
*   Self-made electricity is NOT in it; fuel burnt to make it is, if reported.
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal gj_fuel_s1 gj_electricity ///
    elec_pln_kwh elec_nonpln_kwh elec_owngen_kwh own_gen_positive_reported using "$DATA", clear
isid firm_id year
gen byte own = own_gen_positive_reported
quietly count if !missing(own) & own != (elec_owngen_kwh > 0 & !missing(elec_owngen_kwh))
display "   rows where the own-electricity flag and the kWh disagree (expected 0): " r(N)
quietly count if missing(own)
display "   rows with own electricity not recorded: " r(N)
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/8: one-year changes and the R3 reducer flag (same code as R3-01)"
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
display "Step 3/8: own electricity at the start and end of each change"
*---------------------------------------------------------------------------
* beat = the change was below the typical (median) change that year: it fell more or rose less.
foreach v in energy_va co2_va energy co2 {
    gen byte beat_`v' = (rel_chg_`v' < 0) if cmp
}
gen int  start_year = year - 1 if cmp
gen byte own0 = L.own if cmp                    // start of the change
gen byte own1 = own   if cmp                    // end of the change
* g_start: 1 makes some, 2 makes none, 3 not recorded
gen byte g_start = cond(own0 == 1, 1, cond(own0 == 0, 2, 3)) if cmp
* g_path:  1 none in both years, 2 starts making some, 3 stops making it,
*          4 some in both years, 5 not recorded in one of the two years
gen byte g_path = cond(missing(own0) | missing(own1), 5, 1 + 2*own0 + own1) if cmp
* Checks: did bought electricity fall more than the typical firm's? how did value added move?
gen double chg_bought = ln(gj_electricity) - ln(L.gj_electricity) if cmp & gj_electricity > 0 & L.gj_electricity > 0
gen double chg_va     = ln(value_added_nominal) - ln(L.value_added_nominal) if cmp
gen double s_lnE      = ln(L.total_gj_s1) if cmp            // starting energy (log)
foreach v in bought va {
    bysort year: egen double med_chg_`v' = pctile(chg_`v'), p(50)
    gen double rel_chg_`v' = chg_`v' - med_chg_`v'
}
gen byte beat_bought = (rel_chg_bought < 0) if !missing(rel_chg_bought)
xtset firm_id year
quietly count if cmp
local n_cmp_num = r(N)
local n_cmp = strtrim(string(r(N), "%9.0fc"))
foreach d in start path {
    quietly count if cmp & !missing(g_`d')
    assert r(N) == `n_cmp_num'                  // every change sits in exactly one group
}

*---------------------------------------------------------------------------
display "Step 4/8: which start year drives the own-electricity gap? (leave one out)"
*---------------------------------------------------------------------------
* Gap = share beating the typical change (energy per unit of VA), firms making
* some own electricity at the start minus firms making none. The start year
* whose removal moves the gap most is shown separately in A and B.
quietly summarize beat_energy_va if g_start == 1
local a1 = r(mean)
quietly summarize beat_energy_va if g_start == 2
local gap_all = 100 * (`a1' - r(mean))
quietly levelsof start_year if cmp, local(sys)
local best = -1
local yx = .
foreach s of local sys {
    quietly summarize beat_energy_va if g_start == 1 & start_year != `s'
    local a1 = r(mean)
    quietly summarize beat_energy_va if g_start == 2 & start_year != `s'
    local d = abs(100 * (`a1' - r(mean)) - `gap_all')
    display "   without changes starting in `s': gap moves by " %5.2f `d' " points"
    if `d' > `best' {
        local best = `d'
        local yx = `s'
    }
}
display "   start year shown separately: `yx'"
* Fuel recorded by firms making own electricity, relative to firms making none,
* each year (ratio of typical fuel amounts, geometric means)
preserve
keep if gj_fuel_s1 > 0 & !missing(own)
gen double lnf = ln(gj_fuel_s1)
collapse (mean) lnf, by(year own)
reshape wide lnf, i(year) j(own)
gen double fuel_ratio_own_vs_none = exp(lnf1 - lnf0)
keep year fuel_ratio_own_vs_none
list, noobs sep(0) abbreviate(24)
quietly summarize fuel_ratio_own_vs_none if year == `yx'
local r_yx = r(mean)
quietly summarize fuel_ratio_own_vs_none if year != `yx'
local r_lo = r(min)
local r_hi = r(max)
tempfile fuel
save `fuel'
restore
* Starting energy of firms making own electricity vs none, same start year
* (used in the notes: changes that start high tend to fall back, which moves panels (c)-(d))
local e_ratio = .
capture regress s_lnE ib2.g_start i.start_year if g_start < 3
if _rc == 0 {
    local e_ratio = exp(_b[1.g_start])
    display "   starting energy, makes some vs none (same start year): " %4.1f `e_ratio' " times"
}

*---------------------------------------------------------------------------
display "Step 5/8: A - share making own electricity, reducers vs non-reducers, per year"
*---------------------------------------------------------------------------
* Flag rebuilt without the changes starting in `yx' (same rule otherwise).
gen double rel_x = rel_chg_energy_va if start_year != `yx'
bysort firm_id: egen int    n_x   = count(rel_x)
bysort firm_id: egen double avg_x = mean(rel_x)
gen byte reducer_x = (avg_x < 0) if n_x >= 2
gen byte reducer_m = reducer_adj_energy_va       // main R3 flag
xtset firm_id year
* classified firms per flag (firm level, for the panel titles)
egen byte tagf = tag(firm_id)
foreach f in m x {
    quietly count if tagf & reducer_`f' == 1
    local fr_`f' = strtrim(string(r(N), "%9.0fc"))
    quietly count if tagf & reducer_`f' == 0
    local fn_`f' = strtrim(string(r(N), "%9.0fc"))
}
* pooled over all years (firm-years; the interval allows for the same firm in many years)
foreach f in m x {
    quietly regress own ib0.reducer_`f', vce(cluster firm_id)
    quietly lincom 100 * 1.reducer_`f'
    local g_`f'   = r(estimate)
    local glo_`f' = r(lb)
    local ghi_`f' = r(ub)
    quietly summarize own if reducer_`f' == 1
    local p1_`f' = 100 * r(mean)
    local n1_`f' = r(N)
    local o1_`f' = r(sum)
    quietly summarize own if reducer_`f' == 0
    local p0_`f' = 100 * r(mean)
    local n0_`f' = r(N)
    local o0_`f' = r(sum)
}
display "   all years, share making own electricity: reducers " %4.1f `p1_m' "%, non-reducers " %4.1f `p0_m' "%"
display "   same, flag without changes starting in `yx': " %4.1f `p1_x' "% vs " %4.1f `p0_x' "%"
preserve
gen double selfmade_pct = 100 * elec_owngen_kwh / (elec_owngen_kwh + elec_pln_kwh + elec_nonpln_kwh) if own == 1
gen byte nr = missing(own)
foreach f in m x {
    gen byte own_red_`f' = own if reducer_`f' == 1
    gen byte own_non_`f' = own if reducer_`f' == 0
}
collapse (count) firms_status_recorded = own firms_reducer = own_red_m firms_nonreducer = own_non_m ///
                 firms_reducer_x = own_red_x firms_nonreducer_x = own_non_x ///
         (sum)   firms_status_not_recorded = nr n_own_all = own own_reducer = own_red_m own_nonreducer = own_non_m ///
                 own_reducer_x = own_red_x own_nonreducer_x = own_non_x ///
         (median) median_selfmade_pct_makers = selfmade_pct, by(year)
gen double pct_own_all_firms = 100 * n_own_all / firms_status_recorded if firms_status_recorded > 0
foreach s in "" "_x" {
    * a year's share is drawn only with at least 30 firms in the group
    gen double pct_own_reducer`s'    = 100 * own_reducer`s'    / firms_reducer`s'    if firms_reducer`s'    >= 30
    gen double pct_own_nonreducer`s' = 100 * own_nonreducer`s' / firms_nonreducer`s' if firms_nonreducer`s' >= 30
    gen double gap_pts`s' = pct_own_reducer`s' - pct_own_nonreducer`s'
    gen double gap_lo`s' = .
    gen double gap_hi`s' = .
}
merge 1:1 year using `fuel', nogen keep(master match)
* 2016: an explicit empty row (no annual file), never a zero
gen byte annual_file = 1
set obs `=_N + 1'
replace year = 2016 in L
replace annual_file = 0 in L
sort year
gen str10 period = string(year, "%4.0f")
gen str24 unit = "firms in the year"
* pooled row at the bottom (firm-years)
set obs `=_N + 1'
replace period = "All years" in L
replace unit   = "firm-years, all years" in L
foreach f in m x {
    local s = cond("`f'" == "m", "", "_x")
    replace firms_reducer`s'      = `n1_`f''  in L
    replace own_reducer`s'        = `o1_`f''  in L
    replace pct_own_reducer`s'    = `p1_`f''  in L
    replace firms_nonreducer`s'   = `n0_`f''  in L
    replace own_nonreducer`s'     = `o0_`f''  in L
    replace pct_own_nonreducer`s' = `p0_`f''  in L
    replace gap_pts`s'            = `g_`f''   in L
    replace gap_lo`s'             = `glo_`f'' in L
    replace gap_hi`s'             = `ghi_`f'' in L
}
gen int left_out_start_year = `yx'
order period year annual_file unit firms_status_recorded firms_status_not_recorded pct_own_all_firms ///
      median_selfmade_pct_makers fuel_ratio_own_vs_none ///
      firms_reducer own_reducer pct_own_reducer firms_nonreducer own_nonreducer pct_own_nonreducer gap_pts gap_lo gap_hi ///
      left_out_start_year firms_reducer_x own_reducer_x pct_own_reducer_x firms_nonreducer_x own_nonreducer_x ///
      pct_own_nonreducer_x gap_pts_x gap_lo_x gap_hi_x
keep period-gap_hi_x
format firms_* own_* %9.0f
format pct_* gap_* median_* %6.2f
format fuel_ratio_own_vs_none %7.2f
tempfile byyear
save `byyear'
restore

*---------------------------------------------------------------------------
display "Step 6/8: B - share of changes beating the typical firm, per group, with 95% intervals"
*---------------------------------------------------------------------------
* The interval allows for the same firm appearing in several years (clustered by firm).
tempname P
tempfile rows
postfile `P' int row_order byte recorded str48 block str32 group str32 reference_group ///
    long(changes firms changes_x) int left_out_start_year ///
    double(pct_energy_va lo_energy_va hi_energy_va gap_energy_va gap_lo_energy_va gap_hi_energy_va pct_energy_va_x lo_energy_va_x hi_energy_va_x ///
           pct_co2_va lo_co2_va hi_co2_va gap_co2_va gap_lo_co2_va gap_hi_co2_va pct_co2_va_x lo_co2_va_x hi_co2_va_x ///
           pct_energy lo_energy hi_energy gap_energy gap_lo_energy gap_hi_energy pct_energy_x lo_energy_x hi_energy_x ///
           pct_co2 lo_co2 hi_co2 gap_co2 gap_lo_co2 gap_hi_co2 pct_co2_x lo_co2_x hi_co2_x ///
           pct_energy_va_early) long changes_early double pct_energy_va_late long changes_late ///
    double pct_bought_fell_more long changes_bought double median_va_change_vs_typical_pct using `rows', replace
local r 0
foreach d in start path {
    if "`d'" == "start" local dn "Own electricity at the start of the change"
    if "`d'" == "path"  local dn "Own electricity from start to end of the change"
    if "`d'" == "start" local gl `""Makes some" "Makes none" "Not recorded""'
    if "`d'" == "path"  local gl `""None in both years" "Starts making some" "Stops making it" "Some in both years" "Not recorded in a year""'
    local ref = cond("`d'" == "start", 2, 1)
    local nrg = cond("`d'" == "start", 3, 5)           // the "not recorded" group
    local refname : word `ref' of `gl'
    quietly count if cmp & g_`d' == `ref'
    local refok = r(N) > 0
    forvalues k = 1/`nrg' {
        quietly count if cmp & g_`d' == `k'
        if r(N) == 0 continue
        local ++r
        local gname : word `k' of `gl'
        local vals ""
        foreach v in energy_va co2_va energy co2 {
            quietly mean beat_`v' if cmp & g_`d' == `k', vce(cluster firm_id)
            matrix T = r(table)
            local p  = 100 * T[1,1]
            local lo = 100 * T[5,1]
            local hi = 100 * T[6,1]
            local nn = e(N)
            local nf = e(N_clust)
            local g = .
            local glo = .
            local ghi = .
            if `k' != `ref' & `refok' {
                quietly regress beat_`v' ib`ref'.g_`d' if cmp, vce(cluster firm_id)
                quietly lincom 100 * `k'.g_`d'
                local g   = r(estimate)
                local glo = r(lb)
                local ghi = r(ub)
            }
            * the same, without the changes starting in `yx'
            local px = .
            local lox = .
            local hix = .
            local nx = 0
            quietly count if cmp & g_`d' == `k' & start_year != `yx'
            if r(N) > 1 {
                quietly mean beat_`v' if cmp & g_`d' == `k' & start_year != `yx', vce(cluster firm_id)
                matrix T = r(table)
                local px  = 100 * T[1,1]
                local lox = 100 * T[5,1]
                local hix = 100 * T[6,1]
                local nx  = e(N)
            }
            local vals `vals' (`p') (`lo') (`hi') (`g') (`glo') (`ghi') (`px') (`lox') (`hix')
        }
        * main measure before and after the missing 2016 file
        quietly summarize beat_energy_va if cmp & g_`d' == `k' & year < 2016
        local pe = 100 * r(mean)
        local ne = r(N)
        quietly summarize beat_energy_va if cmp & g_`d' == `k' & year > 2016
        local pl = 100 * r(mean)
        local nl = r(N)
        * checks: bought electricity fell more than the typical firm's; value added vs typical
        quietly summarize beat_bought if cmp & g_`d' == `k'
        local pb = 100 * r(mean)
        local nb = r(N)
        quietly summarize rel_chg_va if cmp & g_`d' == `k', detail
        local mva = 100 * (exp(r(p50)) - 1)
        post `P' (`r') ((`k' != `nrg')) ("`dn'") ("`gname'") ("`refname'") (`nn') (`nf') (`nx') (`yx') ///
            `vals' (`pe') (`ne') (`pl') (`nl') (`pb') (`nb') (`mva')
    }
}
postclose `P'

*---------------------------------------------------------------------------
display "Step 7/8: numbers -> two CSV files (written before drawing)"
*---------------------------------------------------------------------------
use `byyear', clear
export delimited using "tables/06_own_electricity_reducers_by_year.csv", datafmt replace
list period firms_reducer pct_own_reducer firms_nonreducer pct_own_nonreducer gap_pts gap_lo gap_hi, noobs sep(0) abbreviate(24)
list period firms_reducer_x pct_own_reducer_x firms_nonreducer_x pct_own_nonreducer_x gap_pts_x gap_lo_x gap_hi_x, ///
    noobs sep(0) abbreviate(24)
list period pct_own_all_firms median_selfmade_pct_makers fuel_ratio_own_vs_none, noobs sep(0) abbreviate(24)
use `rows', clear
format changes* firms %9.0f
format pct_* lo_* hi_* gap_* median_* %6.2f
export delimited using "tables/06_own_electricity_reducers_changes.csv", datafmt replace
list row_order group changes pct_energy_va lo_energy_va hi_energy_va pct_energy_va_x pct_energy pct_energy_x, ///
    noobs sep(0) abbreviate(24)
list row_order group pct_energy_va_early pct_energy_va_late pct_bought_fell_more median_va_change_vs_typical_pct, ///
    noobs sep(0) abbreviate(24)
assert lo_energy_va <= pct_energy_va & pct_energy_va <= hi_energy_va

* numbers for the notes (read from the data, never typed)
local p_some = .
local p_none = .
local p_st = .
local lo_st = .
quietly summarize pct_energy_va_x if row_order == 1 & group == "Makes some"
if r(N) local p_some = r(mean)
quietly summarize pct_energy_va_x if group == "Makes none"
if r(N) local p_none = r(mean)
quietly summarize pct_energy if group == "Starts making some"
if r(N) local p_st = r(mean)
quietly summarize lo_energy if group == "Starts making some"
if r(N) local lo_st = r(mean)
local s_some   = strtrim(string(`p_some', "%4.1f"))
local s_none   = strtrim(string(`p_none', "%4.1f"))
local s_st     = strtrim(string(`p_st', "%4.1f"))
local s_ryx = strtrim(string(`r_yx', "%4.0f"))
local s_rlo = strtrim(string(`r_lo', "%3.1f"))
local s_rhi = strtrim(string(`r_hi', "%3.1f"))
local yx1 = `yx' + 1
local recnote ""
if !missing(`r_yx') & `r_yx' > 2 * `r_hi' local recnote ": likely a recording change, so `yx' to `yx1' looks like big cuts"
local fuelnote "In `yx', own-electricity firms recorded `s_ryx' times the fuel of other firms (`s_rlo'–`s_rhi' in other years)`recnote'."
local loonote "Without changes starting in `yx' (A right, B triangles), the shares in (a) are `s_some'% (makes some) and `s_none'% (makes none)."
* start size: firms that start high tend to fall back, so gaps in totals are partly automatic
local fbnote ""
if !missing(`e_ratio') & abs(ln(`e_ratio')) > ln(1.5) {          // only when starting sizes clearly differ
    local s_er = strtrim(string(`e_ratio', "%4.1f"))
    local hl = cond(`e_ratio' >= 1, "high starts tend to fall back", "low starts tend to rise back")
    local fbnote "Own-electricity firms start with `s_er' times the energy of other firms in the same year; `hl', so gaps in (c)–(d) are partly automatic."
}
* self-made power is not in energy use: does starting to make it look like a cut in (c)?
local enote "Self-made power is not in energy use, so starting to make it could fake a cut."
if !missing(`p_st') & !(`lo_st' > 50) local enote "Self-made power is not in energy use, so starting to make it could fake a cut; but starters' energy use fell more than the typical firm's in only `s_st'% of changes."
else if !missing(`p_st') local enote "Self-made power is not in energy use, so starting to make it could fake a cut; starters' energy use fell more than the typical firm's in `s_st'% of changes: partly not real."

*---------------------------------------------------------------------------
display "Step 8/8: draw A (lines per year) and B (dot plot), then combine"
*---------------------------------------------------------------------------
* graph combine shrinks relative text sizes unevenly between parts, so text is
* set in points: 13pt = "small", 10pt = "vsmall" in the other R3 figures.
local sm "13pt"
local vs "10pt"
* ---- A: share making own electricity, reducers vs non-reducers ----
* Two panels side by side in one plain twoway (graph combine handles plain
* graphs better than by() graphs): the right panel's years are shifted by `sh'.
local sh = 15
use `byyear', clear
keep if !missing(year)
keep year pct_own_reducer pct_own_nonreducer pct_own_reducer_x pct_own_nonreducer_x
expand 2
bysort year: gen byte flag = _n
gen double red = cond(flag == 1, pct_own_reducer,    pct_own_reducer_x)
gen double non = cond(flag == 1, pct_own_nonreducer, pct_own_nonreducer_x)
gen double x = year + (flag == 2) * `sh'
* endpoint labels: first and last year with data, higher line labelled above
bysort flag: egen fy = min(cond(!missing(red), year, .))
bysort flag: egen ly = max(cond(!missing(red), year, .))
gen byte endpt = inlist(year, fy, ly)
gen str8 lab_red = string(red, "%4.1f") if endpt
gen str8 lab_non = string(non, "%4.1f") if endpt
gen byte pos_red = cond(year == fy, cond(red >= non, 10, 8), cond(red >= non, 2, 4)) if endpt
gen byte pos_non = cond(year == fy, cond(non >  red, 10, 8), cond(non >  red, 2, 4)) if endpt
egen double mx = rowmax(red non)
quietly summarize mx
local atop = 20 * ceil(1.1 * r(max) / 20)
gen double band = `atop' if year == 2016                       // "No annual file" band
sort flag year
* panel titles, firm counts, faint gridlines and x labels, drawn per panel
local ttl1 "Reducers found from all one-year changes"
local ttl2 "Reducers found without changes starting in `yx'"
local cnt1 "`fr_m' reducers, `fn_m' non-reducers"
local cnt2 "`fr_x' reducers, `fn_x' non-reducers"
local grid ""
local xl ""
local txt ""
forvalues f = 1/2 {
    local o = (`f' - 1) * `sh'
    forvalues g = 20(20)`atop' {
        local grid `grid' `g' `=2009.4 + `o'' `g' `=2022.6 + `o''
    }
    forvalues y = 2010(2)2022 {
        local xl `"`xl' `=`y' + `o'' "`y'""'
    }
    local txt `"`txt' text(`=1.25 * `atop'' `=2009.3 + `o'' "`ttl`f''", place(e) size(`sm'))"'
    local txt `"`txt' text(`=1.10 * `atop'' `=2009.3 + `o'' "`cnt`f''", place(e) size(`vs') color(gs6))"'
}
twoway (pci `grid', lcolor(gs15) lwidth(vthin)) ///
    (bar band x, barwidth(0.9) color(gs14) lwidth(none) base(0)) ///
    (connected red x if flag == 1, lcolor(black) lpattern(solid) lwidth(0.8pt) msymbol(O) mcolor(black) ///
        msize(5pt) cmissing(n) mlabel(lab_red) mlabvposition(pos_red) mlabsize(`vs') mlabcolor(black)) ///
    (connected non x if flag == 1, lcolor(gs5) lpattern(dash) lwidth(0.8pt) msymbol(Sh) mcolor(gs5) ///
        msize(5pt) cmissing(n) mlabel(lab_non) mlabvposition(pos_non) mlabsize(`vs') mlabcolor(gs5)) ///
    (connected red x if flag == 2, lcolor(black) lpattern(solid) lwidth(0.8pt) msymbol(O) mcolor(black) ///
        msize(5pt) cmissing(n) mlabel(lab_red) mlabvposition(pos_red) mlabsize(`vs') mlabcolor(black)) ///
    (connected non x if flag == 2, lcolor(gs5) lpattern(dash) lwidth(0.8pt) msymbol(Sh) mcolor(gs5) ///
        msize(5pt) cmissing(n) mlabel(lab_non) mlabvposition(pos_non) mlabsize(`vs') mlabcolor(gs5)), ///
    `txt' ///
    ytitle("% of the group's firms that year", size(`vs')) ///
    ylabel(0(20)`atop', angle(0) noticks tlength(0) nogrid labsize(`vs')) ///
    yscale(noline range(0 `=1.28 * `atop'')) ///
    xlabel(`xl', noticks tlength(0) labsize(`vs')) xscale(noline range(2009.2 `=2022.8 + `sh'')) xtitle("") ///
    legend(order(3 "Reducers" 4 "Non-reducers" 2 "No annual file") pos(6) ///
        rows(1) region(lcolor(none) margin(zero)) size(`vs') symxsize(7) symysize(2.5) keygap(1) colgap(4)) ///
    subtitle("A. Firms making some of their own electricity: reducers vs non-reducers", size(`sm') pos(11) nobox span) ///
    graphregion(color(white) lcolor(white)) plotregion(style(none)) fysize(40) name(pA, replace) nodraw

* ---- B: dot plot, four panels on one shared scale ----
use `rows', clear
sort row_order
gen double y = .
local pos 0
local ylab `"0 "Own electricity (number of changes)""'
local prevb ""
forvalues i = 1/`=_N' {
    local bnm = block[`i']
    if "`bnm'" != "`prevb'" {
        if "`prevb'" != "" local ++pos
        local ++pos
        local bshort = cond(strpos("`bnm'", "start to end"), "From start to end of the change:", "At the start of the change:")
        local ylab `"`ylab' `pos' "{bf:`bshort'}""'
        local prevb "`bnm'"
    }
    local ++pos
    replace y = `pos' in `i'
    local nstr = strtrim(string(changes[`i'], "%9.0fc"))
    local gnm = group[`i']
    local ylab `"`ylab' `pos' "`gnm' (`nstr')""'
}
local ymax = `pos' + 0.5
expand 4
bysort row_order: gen byte panel = _n
foreach s in "" "_x" {
    gen double pct`s' = cond(panel == 1, pct_energy_va`s', cond(panel == 2, pct_co2_va`s', cond(panel == 3, pct_energy`s', pct_co2`s')))
    gen double lo`s'  = cond(panel == 1, lo_energy_va`s',  cond(panel == 2, lo_co2_va`s',  cond(panel == 3, lo_energy`s',  lo_co2`s')))
    gen double hi`s'  = cond(panel == 1, hi_energy_va`s',  cond(panel == 2, hi_co2_va`s',  cond(panel == 3, hi_energy`s',  hi_co2`s')))
}
* recorded rows: all changes just above the row line, without `yx' just below;
* not-recorded rows (same with or without `yx'): one hollow gray dot on the line
gen double ya = cond(recorded, y - 0.17, y)
gen double yb = y + 0.17
* value label (all changes only) past the whisker end that points away from 50%
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
    replace refy = 0.5 in `=`n0' + 2*`p' - 1'
    replace refy = `ymax' in `=`n0' + 2*`p''
}
* symmetric x range around 50: whiskers plus room for the value labels, steps of 5
egen double xl = rowmin(lo lo_x)
egen double xh = rowmax(hi hi_x)
quietly summarize xl
local dlo = 50 - r(min)
quietly summarize xh
local dhi = r(max) - 50
local half = max(10, 5 * ceil((max(`dlo', `dhi') + 4) / 5))
local xlo = 50 - `half'
local xhi = 50 + `half'
local xstep = cond(`half' > 20, 20, 10)
local xs  = `xstep' * floor(`half' / `xstep')
display "   x range `xlo'-`xhi'"
sort panel refy y
twoway (rspike lo hi ya if recorded == 1, horizontal lcolor(black) lwidth(0.6pt)) ///
    (rspike lo_x hi_x yb if recorded == 1, horizontal lcolor(gs8) lwidth(0.6pt)) ///
    (rspike lo hi ya if recorded == 0, horizontal lcolor(gs10) lwidth(0.6pt)) ///
    (scatter ya pct if recorded == 1, msymbol(O) mcolor(black) msize(4.5pt)) ///
    (scatter yb pct_x if recorded == 1, msymbol(Th) mcolor(gs5) msize(5.5pt)) ///
    (scatter ya pct if recorded == 0, msymbol(Oh) mcolor(gs8) msize(4.5pt)) ///
    (scatter ya labx if recorded == 1, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(`vs') mlabcolor(black)) ///
    (scatter ya labx if recorded == 0, msymbol(none) mlabel(plab) mlabvposition(labp) mlabgap(0.6) mlabsize(`vs') mlabcolor(gs9)) ///
    (line refy refx, lpattern(dash) lcolor(gs8) lwidth(0.6pt)), ///
    by(panel, rows(1) note("") graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("B. Share of one-year changes that fell more (or rose less) than the typical firm's that year, by own electricity", ///
              size(`sm') pos(11) span)) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(`sm')) ///
    yscale(reverse noline range(-0.3 `ymax')) ylabel(`ylab', angle(0) noticks tlength(0) nogrid labsize(`vs')) ytitle("") ///
    xscale(range(`xlo' `xhi') lcolor(gs10)) ///
    xlabel(`=50 - `xs''(`xstep')`=50 + `xs'', noticks tlength(0) labsize(`vs') grid glcolor(gs15) glwidth(vthin)) ///
    xtitle("Changes that fell more or rose less than the typical firm's that year (% of the group's changes)", size(`vs')) ///
    legend(order(4 "All one-year changes" 5 "Without changes starting in `yx'" 1 "95% interval" ///
                 6 "Not recorded" 9 "50% = same as the typical firm") rows(1) region(lcolor(none)) ///
        size(`vs') symxsize(8) keygap(1) colgap(5)) ///
    plotregion(style(none)) fysize(60) name(pB, replace) nodraw

graph combine pA pB, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("Figure R3-06. Do the firms that cut energy and CO2 make their own electricity?", size(`sm') pos(11) span) ///
    note("Notes: Own electricity = the firm made some of its own power that year. Not recorded: left out of A; hollow gray in B, not a result. Shows who, not why." ///
         "A: reducer = firm with 2+ one-year changes whose energy per unit of VA fell on average more, or rose less, than the typical firm's in the same years." ///
         "B: dot = share of the group's one-year changes that fell more (or rose less) than the typical firm's that year; interval crossing 50% = no clear gap." ///
         "`fuelnote'" ///
         "`loonote'" ///
         "`fbnote'" ///
         "`enote'" ///
         "A gap in (a) but not in (c) comes from value added (VA = output minus materials, energy and services bought, current prices). GJ = gigajoules." ///
         "`srcnote'" "`devnote'", size(`vs') span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) xsize(10.5) ysize(12)

graph export "figures/06_own_electricity_reducers.png", width(3150) replace
graph export "figures/06_own_electricity_reducers.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/06_own_electricity_reducers.png (elapsed `elapsed' s)"
quietly log close
