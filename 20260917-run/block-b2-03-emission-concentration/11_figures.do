/*==========================================================================
  Line 11 (added; the row has no figures line): charts for B2-03
  Every other file writes its tables to output/b2_03_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_06_top_shares.png    % of CO2 held by the top 1/5/10/20%, by year
    fig07_other_shares.png     what the top 1% / 10% hold of CO2, output,
                               VA, workers (pooled)
    fig08_kbli5_spread.png     P10-P90 of CO2 per VA in the 15 largest KBLI5
    fig09_lorenz.png           Lorenz curve of CO2, 2010 / 2022 / pool
    fig09_gini.png             Gini of CO2 by year
    fig10_plants_needed.png    % of plants that hold 50/75/90% of CO2
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02_06: top emitter shares by year (lines 2-6) ----
import excel using "$B203_XLSX", sheet("t02_06_top_shares") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year share_top1 share_top5 share_top10 share_top20
order year
export excel using "$B203_XLSX", sheet("fig02_06_data", replace) firstrow(variables)
twoway (connected share_top1 year) (connected share_top5 year) ///
       (connected share_top10 year) (connected share_top20 year), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ylabel(0(20)100, angle(0)) ytitle("% of total CO2") ///
    legend(order(1 "Top 1%" 2 "Top 5%" 3 "Top 10%" 4 "Top 20%") rows(1)) ///
    title("Share of CO2 held by the largest emitters") ///
    note("Plants with CO2 > 0, ranked within each year. Dashed line: no 2016 survey.") ///
    graphregion(color(white))
graph export "$B203_OUT/fig02_06_top_shares.png", replace width(2000)

* ---- fig07: top emitters' share of other totals (line 7) ----
import excel using "$B203_XLSX", sheet("t07_other_shares") firstrow clear
keep if period == "pool" & inlist(variable, "co2_total", "output", "va", "workers")
generate m_order = 1
replace  m_order = 2 if variable == "output"
replace  m_order = 3 if variable == "va"
replace  m_order = 4 if variable == "workers"
sort m_order
keep m_order measure share_top1 share_top10
export excel using "$B203_XLSX", sheet("fig07_data", replace) firstrow(variables)
graph bar (asis) share_top1 share_top10, over(measure, sort(m_order)) ///
    bar(1, color(cranberry)) bar(2, color(navy)) blabel(bar, format(%4.1f)) ///
    ytitle("% of the total (pooled 2010-2022)") ylabel(0(20)100, angle(0)) ///
    legend(order(1 "Top 1% of emitters" 2 "Top 10% of emitters") rows(1)) ///
    title("What the largest emitters hold") ///
    note("Denominator: all clean plants of the year. Exports: see t07_other_shares (weak coverage).") ///
    graphregion(color(white))
graph export "$B203_OUT/fig07_other_shares.png", replace width(2000)

* ---- fig08: within-KBLI5 spread of carbon intensity (line 8) ----
import excel using "$B203_XLSX", sheet("t08_kbli5_pool") firstrow clear
keep if measure == "co2_per_va" & p10 > 0
gsort -n
keep in 1/15
keep kbli5 n p10 p25 p50 p75 p90 p95
export excel using "$B203_XLSX", sheet("fig08_data", replace) firstrow(variables)
* one row per sector, largest sector at the top; the KBLI5 code is the label
generate pos = 16 - _n
capture label drop pos
forvalues i = 1/15 {
    local code = kbli5[`i']
    label define pos `=16 - `i'' "`code'", add
}
label values pos pos
twoway (rcap p10 p90 pos, horizontal lcolor(gs8)) ///
       (rbar p25 p75 pos, horizontal barwidth(0.5) color(navy%40)) ///
       (scatter pos p50, mcolor(cranberry) msymbol(D)), ///
    xscale(log) xlabel(1e-7 1e-6 1e-5 1e-4 1e-3, format(%6.0e) labsize(small)) ///
    ylabel(1(1)15, valuelabel angle(0) labsize(small)) ytitle("KBLI 5-digit") ///
    xtitle("CO2 (t) per value added, log scale") ///
    legend(order(1 "P10 to P90" 2 "P25 to P75" 3 "Median") rows(1)) ///
    title("Carbon intensity within KBLI 5-digit sectors") ///
    subtitle("The 15 sectors with the most plant-years, pooled 2010-2022") ///
    note("Value added is nominal and masked. All percentiles are in t08_kbli5_pool.") ///
    graphregion(color(white))
graph export "$B203_OUT/fig08_kbli5_spread.png", replace width(2000)

* ---- fig09: Lorenz curve (line 9) ----
import excel using "$B203_XLSX", sheet("t09_lorenz") firstrow clear
keep if inlist(period, "2010", "2022", "pool")
replace period = "all" if period == "pool"
reshape wide cum_share_co2, i(pct_plants) j(period) string
rename cum_share_co2* lorenz_*
generate equality = pct_plants
order pct_plants lorenz_2010 lorenz_2022 lorenz_all equality
export excel using "$B203_XLSX", sheet("fig09_data", replace) firstrow(variables)
twoway (line lorenz_2010 pct_plants, lcolor(gs8)) ///
       (line lorenz_2022 pct_plants, lcolor(cranberry)) ///
       (line lorenz_all pct_plants, lcolor(navy) lpattern(dash)) ///
       (line equality pct_plants, lcolor(gs12) lpattern(shortdash)), ///
    xlabel(0(10)100) ylabel(0(20)100, angle(0)) aspectratio(1) ///
    xtitle("Cumulative % of plants (smallest emitter first)") ///
    ytitle("Cumulative % of CO2") ///
    legend(order(1 "2010" 2 "2022" 3 "Pooled 2010-2022" 4 "Equal shares") rows(2)) ///
    title("Lorenz curve of CO2 emissions") ///
    note("Plants with CO2 > 0, clean sample. Gini by year: t09_gini.") ///
    graphregion(color(white))
graph export "$B203_OUT/fig09_lorenz.png", replace width(2000)

* ---- fig09: Gini by year (line 9) ----
import excel using "$B203_XLSX", sheet("t09_gini") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year gini
order year
export excel using "$B203_XLSX", sheet("fig09_gini_data", replace) firstrow(variables)
twoway connected gini year, ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ylabel(0.80(0.05)1, format(%4.2f) angle(0)) ytitle("Gini of plant CO2") ///
    title("Gini of CO2 emissions across plants") ///
    note("0 = every plant emits the same, 1 = one plant emits everything. Dashed line: no 2016 survey.") ///
    graphregion(color(white))
graph export "$B203_OUT/fig09_gini.png", replace width(2000)

* ---- fig10: how many plants hold most of the CO2? (line 10) ----
import excel using "$B203_XLSX", sheet("t10_plants_needed") firstrow clear
generate year = real(period)
keep year n_emitters n_for_50 pct_for_50 n_for_75 pct_for_75 n_for_90 pct_for_90
order year
export excel using "$B203_XLSX", sheet("fig10_data", replace) firstrow(variables)
twoway (connected pct_for_50 year) (connected pct_for_75 year) (connected pct_for_90 year), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ylabel(, angle(0)) ytitle("% of plants with CO2 > 0") ///
    legend(order(1 "50% of CO2" 2 "75% of CO2" 3 "90% of CO2") rows(1)) ///
    title("Smallest share of plants that holds 50 / 75 / 90% of CO2") ///
    note("Number of plants: t10_plants_needed. Dashed line: no 2016 survey.") ///
    graphregion(color(white))
graph export "$B203_OUT/fig10_plants_needed.png", replace width(2000)
graph drop _all
