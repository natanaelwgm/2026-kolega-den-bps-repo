/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk table
            atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_17_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01_emissions_by_year.png    total CO2 scope 1, scope 2, total, by year
    fig02_main_energy_source.png   % of firms per main energy source
    fig03_sector_share.png         share of all CO2 per KBLI 2-digit
    fig04_tfp_quintiles.png        CO2 by TFP quintile, 4 methods
    fig05_scale_quintiles.png      CO2 by quintile of VA/worker, VA, output, ...
    fig06_11_group_medians.png     median CO2 by size, FDI, export, import,
                                   Java, R&D (lines 6, 7, 8, 10, 11)
    fig09_co2_per_gj.png           CO2 per GJ by year
  "CO2 per VA" is shown x 1,000,000 (tonnes per million units of nominal VA).
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig01: emissions by year (line 1) ----
import excel using "$B17_XLSX", sheet("t01_totals") firstrow clear
drop if period == "pool"
generate year = real(period)
generate co2_s1_mt    = co2_s1 / 1e6
generate co2_s2_mt    = co2_s2 / 1e6
generate co2_total_mt = co2_total / 1e6
keep year co2_s1_mt co2_s2_mt co2_total_mt
order year
export excel using "$B17_XLSX", sheet("fig01_data", replace) firstrow(variables)
twoway (connected co2_total_mt year) ///
       (connected co2_s1_mt year, lpattern(dash)) ///
       (connected co2_s2_mt year, lpattern(shortdash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Million tonnes CO2 (sum over firms)") ylabel(, angle(0)) ///
    legend(order(1 "Total" 2 "Scope 1 (4 fuels)" 3 "Scope 2 (electricity)") rows(1)) ///
    title("CO2 emissions of manufacturing firms") ///
    note("Dashed line at 2016: no survey year and a reporting change. Masked development data.") ///
    graphregion(color(white))
graph export "$B17_OUT/fig01_emissions_by_year.png", replace width(2000)

* ---- fig02: main energy source (line 2) ----
import excel using "$B17_XLSX", sheet("t02_main_src_share") firstrow clear
keep if period == "pool"
keep main_src n_firms pct_firms
export excel using "$B17_XLSX", sheet("fig02_data", replace) firstrow(variables)
graph hbar (asis) pct_firms, over(main_src, sort(1) descending label(labsize(small))) ///
    ytitle("% of firm-years") ///
    title("Main energy source of firms (pooled 2010-2022)") ///
    note("Main source = largest energy use (GJ)." "Sources marked 2020+ exist only on the 2020-2022 form.", size(small)) ///
    graphregion(color(white))
graph export "$B17_OUT/fig02_main_energy_source.png", replace width(2000)

* ---- fig03: sector share of CO2 (line 3) ----
import excel using "$B17_XLSX", sheet("t03_kbli2_share") firstrow clear
keep if period == "pool"
generate sector = "KBLI " + string(kbli2)
keep sector n_firms co2_total share_of_co2_pct
export excel using "$B17_XLSX", sheet("fig03_data", replace) firstrow(variables)
graph hbar (asis) share_of_co2_pct, over(sector, sort(1) descending label(labsize(small))) ///
    ytitle("% of all CO2 (scope 1 + 2)") ///
    title("Which sectors emit? (pooled 2010-2022)") ///
    graphregion(color(white)) ysize(6)
graph export "$B17_OUT/fig03_sector_share.png", replace width(2000)

* ---- fig04: TFP quintiles (line 4) ----
* left: mean ln CO2 total; right: median CO2 per VA. One line per TFP method.
tempfile stack
clear
save `stack', emptyok
foreach t in tfp_op tfp_lp tfp_acf tfp_wrdg {
    import excel using "$B17_XLSX", sheet("t04_by_`t'_q") firstrow clear
    keep if period == "pool" & inlist(variable, "ln_co2_total", "co2_per_va")
    generate quintile = real(substr(group, 2, 1))
    generate measure = "`t'"
    keep quintile measure variable mean p50
    append using `stack'
    save `stack', replace
}
generate value  = cond(variable == "ln_co2_total", mean, p50 * 1e6)
generate column = cond(variable == "ln_co2_total", "mean_lnco2_", "med_co2va_") + measure
keep quintile column value
reshape wide value, i(quintile) j(column) string
rename value* *
export excel using "$B17_XLSX", sheet("fig04_data", replace) firstrow(variables)
twoway (connected mean_lnco2_tfp_op quintile) (connected mean_lnco2_tfp_lp quintile) ///
       (connected mean_lnco2_tfp_acf quintile) (connected mean_lnco2_tfp_wrdg quintile), ///
    xlabel(1 "Q1 low" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 high") xtitle("TFP quintile (within year)") ///
    ytitle("Mean ln CO2 total") title("CO2 level") ///
    legend(order(1 "OP" 2 "LP" 3 "ACF" 4 "WRDG") rows(1)) graphregion(color(white)) name(g1, replace)
twoway (connected med_co2va_tfp_op quintile) (connected med_co2va_tfp_lp quintile) ///
       (connected med_co2va_tfp_acf quintile) (connected med_co2va_tfp_wrdg quintile), ///
    xlabel(1 "Q1 low" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 high") xtitle("TFP quintile (within year)") ///
    ytitle("Median CO2 per VA (x 1,000,000)") title("CO2 intensity") ///
    legend(order(1 "OP" 2 "LP" 3 "ACF" 4 "WRDG") rows(1)) graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Emissions by TFP quintile (pooled)") ///
    note("OP has only 672 firm-years. TFP = nominal development residuals.") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B17_OUT/fig04_tfp_quintiles.png", replace width(2400)
graph drop _all

* ---- fig05: productivity and scale quintiles (line 5) ----
clear
save `stack', emptyok replace
foreach v in va_pw va output out_pw capital cap_pw {
    import excel using "$B17_XLSX", sheet("t05_by_`v'_q") firstrow clear
    keep if period == "pool" & inlist(variable, "ln_co2_total", "co2_per_va")
    generate quintile = real(substr(group, 2, 1))
    drop if missing(quintile)                 // the "Zero or negative" group
    generate measure = "`v'"
    keep quintile measure variable mean p50
    append using `stack'
    save `stack', replace
}
generate value  = cond(variable == "ln_co2_total", mean, p50 * 1e6)
generate column = cond(variable == "ln_co2_total", "mean_lnco2_", "med_co2va_") + measure
keep quintile column value
reshape wide value, i(quintile) j(column) string
rename value* *
export excel using "$B17_XLSX", sheet("fig05_data", replace) firstrow(variables)
twoway (connected mean_lnco2_va_pw quintile) (connected mean_lnco2_va quintile) ///
       (connected mean_lnco2_output quintile) (connected mean_lnco2_out_pw quintile) ///
       (connected mean_lnco2_capital quintile) (connected mean_lnco2_cap_pw quintile), ///
    xlabel(1 "Q1 low" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 high") xtitle("Quintile (within year)") ///
    ytitle("Mean ln CO2 total") title("CO2 level") ///
    legend(order(1 "VA/worker" 2 "VA" 3 "Output" 4 "Output/worker" 5 "Capital" 6 "Capital/worker") rows(2)) ///
    graphregion(color(white)) name(g1, replace)
twoway (connected med_co2va_va_pw quintile) (connected med_co2va_va quintile) ///
       (connected med_co2va_output quintile) (connected med_co2va_out_pw quintile) ///
       (connected med_co2va_capital quintile) (connected med_co2va_cap_pw quintile), ///
    xlabel(1 "Q1 low" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 high") xtitle("Quintile (within year)") ///
    ytitle("Median CO2 per VA (x 1,000,000)") title("CO2 intensity") ///
    legend(order(1 "VA/worker" 2 "VA" 3 "Output" 4 "Output/worker" 5 "Capital" 6 "Capital/worker") rows(2)) ///
    graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Emissions by productivity and scale quintile (pooled)") ///
    note("Quintiles among firms with a positive value. Nominal, masked values.") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B17_OUT/fig05_scale_quintiles.png", replace width(2400)
graph drop _all

* ---- fig06_11: median CO2 by group (lines 6, 7, 8, 10, 11) ----
clear
save `stack', emptyok replace
local k 0
foreach s in t06_by_large t07_by_fdi t08_by_exporter t08_by_importer t10_by_java t11_by_rnd {
    local ++k
    import excel using "$B17_XLSX", sheet("`s'") firstrow clear
    keep if period == "pool" & inlist(variable, "co2_total", "co2_per_va")
    generate table = `k'
    keep table group variable p50
    append using `stack'
    save `stack', replace
}
replace p50 = p50 * 1e6 if variable == "co2_per_va"
replace variable = cond(variable == "co2_total", "med_co2_total", "med_co2_per_va_x1e6")
reshape wide p50, i(table group) j(variable) string
rename p50* *
sort table group
generate order = _n
export excel using "$B17_XLSX", sheet("fig06_11_data", replace) firstrow(variables)
graph hbar (asis) med_co2_total, over(group, sort(order) label(labsize(small))) ///
    ytitle("Median CO2 total (t)") title("CO2 level") ///
    graphregion(color(white)) name(g1, replace)
graph hbar (asis) med_co2_per_va_x1e6, over(group, sort(order) label(labsize(small))) ///
    ytitle("Median CO2 per VA (x 1,000,000)") title("CO2 intensity") ///
    graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Median emissions by firm group (pooled)") ///
    note("FDI excludes 2020, exporter excludes 2022, R&D is 2017-2022 only.") ///
    graphregion(color(white)) xsize(10) ysize(5)
graph export "$B17_OUT/fig06_11_group_medians.png", replace width(2400)
graph drop _all

* ---- fig09: CO2 per GJ by year (line 9) ----
import excel using "$B17_XLSX", sheet("t09_energy_stats") firstrow clear
keep if variable == "co2_per_gj" & period != "pool"
generate year = real(period)
rename p50 median_co2_per_gj
rename mean mean_co2_per_gj
keep year median_co2_per_gj mean_co2_per_gj
order year
export excel using "$B17_XLSX", sheet("fig09_data", replace) firstrow(variables)
twoway (connected median_co2_per_gj year) (connected mean_co2_per_gj year, lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Tonnes CO2 per GJ") ylabel(, angle(0) format(%4.2f)) legend(order(1 "Median" 2 "Mean") rows(1)) ///
    title("CO2 per unit of energy") subtitle("Scope 1 fuels + purchased electricity") ///
    note("Moves with the fuel mix and the grid factor.") graphregion(color(white))
graph export "$B17_OUT/fig09_co2_per_gj.png", replace width(2000)
