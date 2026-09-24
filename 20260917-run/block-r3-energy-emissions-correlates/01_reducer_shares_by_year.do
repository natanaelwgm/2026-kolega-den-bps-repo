/*==========================================================================
  R3-01  In each year, what share of firms used less energy / emitted less
         CO2 than in the year before - as amounts and per unit of value added?
         Also defines the firm-level "reducer" flag used in R3-02 to R3-07
         (main flag: year-adjusted, energy per unit of value added).
  Answers Deasy R3: "Siapa yang reduce energy use and emisi?"
  Output : figures/01_reducer_shares_by_year.png (+ .pdf)
           tables/01_reducer_shares_by_year.csv  (per year)
           tables/01_reducer_firms.csv           (firm-level reducer counts)
  Development data - obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
args data_arg outdir_arg        // optional: 00_run.do passes the two paths
clear all
set more off
set varabbrev off
set linesize 120

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
log using "logs/01_reducer_shares_by_year.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-01] STARTING: share of firms whose energy use and CO2 fell from the previous year ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/6: load the variables we need"
*---------------------------------------------------------------------------
* total_gj_s1  = energy use in GJ (nine fuels + purchased electricity; partial scope)
* co2_total_s1 = CO2 in tonnes from the same fuels and electricity
* value_added_nominal = value added, current prices (masked money unit)
use firm_id year total_gj_s1 co2_total_s1 value_added_nominal using "$DATA", clear
isid firm_id year
xtset firm_id year

*---------------------------------------------------------------------------
display "Step 2/6: pair each firm-year with the same firm exactly one year earlier"
*---------------------------------------------------------------------------
* L. means "the same firm, previous calendar year". There is no 2016 file, so
* every 2017 row has no previous year: the 2015->2017 change covers two years
* and is left out on purpose.
gen double energy    = total_gj_s1
gen double co2       = co2_total_s1
gen double energy_va = total_gj_s1  / value_added_nominal
gen double co2_va    = co2_total_s1 / value_added_nominal

gen byte pair1 = !missing(L.total_gj_s1)                        // firm is in last year's file
gen byte link2 = (year == 2017) & !missing(L2.total_gj_s1)      // firm seen in 2015 and 2017 (not used)

* Compared pair: energy, CO2 and value added above zero in BOTH years.
* A zero is dropped, not read as "no energy": these fields cover only the
* fuels asked about, and a zero may be an unanswered question.
gen byte cmp = pair1 & total_gj_s1>0 & L.total_gj_s1>0 & co2_total_s1>0 & L.co2_total_s1>0 ///
               & value_added_nominal>0 & L.value_added_nominal>0

*---------------------------------------------------------------------------
display "Step 3/6: mark reductions (value lower than the year before)"
*---------------------------------------------------------------------------
foreach v in energy co2 energy_va co2_va {
    gen byte down_`v'  = (`v' < L.`v') if cmp                        // main rule: any fall
    gen byte down5_`v' = (ln(`v') - ln(L.`v') < ln(0.95)) if cmp     // check: fell by more than 5%
    quietly count if cmp & `v' == L.`v'
    display "   exact ties (unchanged) for `v': " r(N)
}
assert pair1 == 0 if year == 2017         // no 2016 file, so no one-year pair ends in 2017

*---------------------------------------------------------------------------
display "Step 4/6: firm-level reducer flag (used by R3-02 to R3-07)"
*---------------------------------------------------------------------------
* A firm is a "reducer" when the average of its year-on-year log changes is
* below zero. Needs at least 2 compared changes; firms with 0 or 1 change stay
* unclassified (missing), never counted as non-reducers.
* MAIN flag for R3-02 to R3-07 = reducer_adj_energy_va (year-adjusted, energy
* per unit of value added). The raw flag (reducer_*) is kept for comparison:
* it mostly records WHICH years a firm is observed, because the masked data
* jump and fall back between years.
preserve
foreach v in energy co2 energy_va co2_va {
    gen double chg_`v' = ln(`v') - ln(L.`v') if cmp
}
foreach v in energy co2 energy_va co2_va {
    * Year-adjusted: this firm's change minus the typical (median) change of all
    * compared firms in the same year, so the years a firm happens to be
    * observed in do not decide whether it is a reducer.
    bysort year: egen double med_chg_`v' = median(chg_`v')
    gen double rel_chg_`v' = chg_`v' - med_chg_`v'
    bysort firm_id: egen int    n_chg_`v'   = count(chg_`v')
    bysort firm_id: egen double avg_chg_`v' = mean(chg_`v')
    bysort firm_id: egen double avg_rel_`v' = mean(rel_chg_`v')
    gen byte reducer_`v'     = (avg_chg_`v' < 0) if n_chg_`v' >= 2
    gen byte reducer_adj_`v' = (avg_rel_`v' < 0) if n_chg_`v' >= 2
}
bysort firm_id: keep if _n == 1
tempfile firmfile
tempname firmtab
postfile `firmtab' str10 outcome byte main_flag long(firms_total firms_0_changes firms_1_change ///
    firms_classified reducer_firms nonreducer_firms) double pct_reducer_firms ///
    long reducer_adj_firms double pct_reducer_adj_firms using `firmfile', replace
foreach v in energy co2 energy_va co2_va {
    quietly count
    local nt = r(N)
    quietly count if n_chg_`v' == 0
    local n0 = r(N)
    quietly count if n_chg_`v' == 1
    local n1 = r(N)
    quietly count if !missing(reducer_`v')
    local nc = r(N)
    quietly count if reducer_`v' == 1
    local nr = r(N)
    quietly count if reducer_adj_`v' == 1
    local na = r(N)
    post `firmtab' ("`v'") (("`v'" == "energy_va")) (`nt') (`n0') (`n1') (`nc') (`nr') (`nc' - `nr') (100 * `nr' / `nc') ///
        (`na') (100 * `na' / `nc')
}
postclose `firmtab'
restore

*---------------------------------------------------------------------------
display "Step 5/6: yearly shares -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
* Pooled shares over all years, for the firm table.
foreach v in energy co2 energy_va co2_va {
    quietly summarize down_`v'
    local pool_n_`v'   = r(N)
    local pool_pct_`v' = 100 * r(mean)
}
collapse (count) firms_in_year = firm_id ///
         (sum) one_year_pairs = pair1 two_year_links = link2 pairs_compared = cmp ///
               n_down_energy = down_energy n_down_co2 = down_co2 ///
               n_down_energy_va = down_energy_va n_down_co2_va = down_co2_va ///
         (mean) pct_down5_energy = down5_energy pct_down5_co2 = down5_co2 ///
                pct_down5_energy_va = down5_energy_va pct_down5_co2_va = down5_co2_va, by(year)
gen long pairs_dropped_zero = one_year_pairs - pairs_compared
foreach v in energy co2 energy_va co2_va {
    gen double pct_down_`v' = 100 * n_down_`v' / pairs_compared if pairs_compared > 0
    replace n_down_`v' = . if pairs_compared == 0      // no pairs: blank, not "0 reductions"
    replace pct_down5_`v'   = 100 * pct_down5_`v'
}
assert one_year_pairs == 0 if inlist(year, 2010, 2017)
* Numbers quoted in the figure notes are read from the data, never typed.
quietly summarize pairs_compared
local n_cmp : display %9.0fc r(sum)
quietly summarize two_year_links
local n_link2 : display %9.0fc r(sum)
gen double gap5 = max(pct_down_energy - pct_down5_energy, pct_down_co2 - pct_down5_co2, ///
                      pct_down_energy_va - pct_down5_energy_va, pct_down_co2_va - pct_down5_co2_va)
quietly summarize gap5
local gap5 : display %3.1f r(max)
drop gap5
local n_cmp   = strtrim("`n_cmp'")
local n_link2 = strtrim("`n_link2'")

* 2016: an explicit empty row (no annual file), never a zero.
gen byte annual_file = 1
set obs `=_N + 1'
replace year = 2016 in L
replace annual_file = 0 in L
sort year
order year annual_file firms_in_year one_year_pairs two_year_links pairs_dropped_zero pairs_compared ///
      n_down_energy pct_down_energy n_down_co2 pct_down_co2 n_down_energy_va pct_down_energy_va ///
      n_down_co2_va pct_down_co2_va pct_down5_energy pct_down5_co2 pct_down5_energy_va pct_down5_co2_va
format firms_in_year one_year_pairs two_year_links pairs_dropped_zero pairs_compared n_down_* %9.0f
format pct_* %6.2f
export delimited using "tables/01_reducer_shares_by_year.csv", datafmt replace
list year pairs_compared pct_down_energy pct_down_co2 pct_down_energy_va pct_down_co2_va, noobs sep(0) abbreviate(20)

* Firm-level table (with pooled pair shares) -> CSV
preserve
use `firmfile', clear
gen long   pairs_pooled = .
gen double pct_pairs_down_pooled = .
foreach v in energy co2 energy_va co2_va {
    replace pairs_pooled          = `pool_n_`v''   if outcome == "`v'"
    replace pct_pairs_down_pooled = `pool_pct_`v'' if outcome == "`v'"
}
format pct_* %6.2f
export delimited using "tables/01_reducer_firms.csv", datafmt replace
list, noobs sep(0) abbreviate(24)
restore

*---------------------------------------------------------------------------
display "Step 6/6: draw two small multiples (energy, CO2) on one shared 0-100 scale"
*---------------------------------------------------------------------------
keep year pairs_compared pct_down_energy pct_down_co2 pct_down_energy_va pct_down_co2_va
expand 2
bysort year: gen byte panel = _n
gen double amt = cond(panel == 1, pct_down_energy,    pct_down_co2)      // amount
gen double pva = cond(panel == 1, pct_down_energy_va, pct_down_co2_va)   // per unit of value added
label define panel 1 "(a) Energy use (gigajoules)" 2 "(b) CO2 emissions (tonnes)"
label values panel panel

* Endpoint labels: first and last year with data, higher line labelled above.
bysort panel: egen fy = min(cond(!missing(amt), year, .))
bysort panel: egen ly = max(cond(!missing(amt), year, .))
gen byte endpt = inlist(year, fy, ly)
gen str20 lab_amt = "Total " + string(amt, "%4.1f") if endpt
gen str20 lab_pva = "Per VA " + string(pva, "%4.1f") if endpt
gen byte pos_amt = cond(year == fy, cond(amt >= pva, 10, 8), cond(amt >= pva, 2, 4)) if endpt
gen byte pos_pva = cond(year == fy, cond(pva >  amt, 10, 8), cond(pva >  amt, 2, 4)) if endpt

gen double band = 100 if year == 2016                                    // "No annual file" band
gen double ytxt = 92      if year == 2016 & panel == 1
gen double xtxt = 2016.55 if year == 2016 & panel == 1
gen str45 txt = "2017: no one-year change (no 2016 file)" if year == 2016 & panel == 1

* x-axis labels: year, and under it the number of firm pairs compared.
local xl ""
forvalues y = 2010/2022 {
    quietly summarize pairs_compared if year == `y' & panel == 1
    if `y' == 2016 {
        local xl `"`xl' 2016 `""2016" " ""'"'
    }
    else {
        local nstr : display %9.0fc r(mean)
        local nstr = strtrim("`nstr'")
        local xl `"`xl' `y' `""`y'" "`nstr'""'"'
    }
}
sort panel year

twoway (bar band year, barwidth(0.9) color(gs14) lwidth(none) base(0)) ///
    (connected amt year, lcolor(black) lpattern(solid) lwidth(medthin) msymbol(O) mcolor(black) ///
        msize(small) cmissing(n) mlabel(lab_amt) mlabvposition(pos_amt) mlabsize(vsmall) mlabcolor(black)) ///
    (connected pva year, lcolor(gs5) lpattern(dash) lwidth(medthin) msymbol(Sh) mcolor(gs5) ///
        msize(small) cmissing(n) mlabel(lab_pva) mlabvposition(pos_pva) mlabsize(vsmall) mlabcolor(gs5)) ///
    (scatter ytxt xtxt, msymbol(none) mlabel(txt) mlabposition(3) mlabgap(0) mlabsize(vsmall) mlabcolor(gs6)), ///
    by(panel, cols(1) graphregion(color(white) lcolor(white) ilcolor(white)) legend(pos(6)) ///
        title("Figure R3-01. Share of firms whose energy use and CO2 fell from the previous year", ///
              size(small) pos(11) span) ///
        note("Notes: Each point = share of firms below their own level one year earlier; at 50%, as many fell as rose." ///
             "Only firms present in both years, with energy and CO2 above zero in both, are compared: the same `n_cmp'" ///
             "firm pairs in all four lines. Value added = output value minus materials, energy and services bought, in" ///
             "current prices; price rises alone push the per-value-added share up. Fictional firm links and masked" ///
             "values: levels and year-to-year jumps are not findings." ///
             "`srcnote'" "`devnote'", size(vsmall) span)) ///
    subtitle(, pos(11) nobox fcolor(white) lcolor(white) size(small)) ///
    ytitle("Firms lower than the year before (%)", size(vsmall)) ///
    ylabel(0(25)100, angle(0) noticks tlength(0) grid glcolor(gs15) glwidth(vthin) labsize(vsmall)) ///
    yscale(noline range(0 100)) ///
    xlabel(`xl', noticks tlength(0) labsize(vsmall)) xscale(range(2008.6 2023.8) lcolor(gs10)) ///
    xtitle("Year (number underneath: firm pairs compared)", size(vsmall)) ///
    legend(order(2 "Total" 3 "Per unit of value added (VA)" 1 "No annual file") ///
        rows(1) region(lcolor(none)) size(vsmall) symxsize(8) keygap(1) colgap(6)) ///
    plotregion(style(none)) xsize(6.5) ysize(7.5)

graph export "figures/01_reducer_shares_by_year.png", width(1950) replace
graph export "figures/01_reducer_shares_by_year.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_reducer_shares_by_year.png (elapsed `elapsed' s)"
quietly log close
