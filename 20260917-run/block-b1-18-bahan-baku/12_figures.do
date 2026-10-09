/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk table
            atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_18_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig03_who_imports.png          % importers and median import share, by year
    fig04_importer_by_group.png    % importers by FDI / exporter / size / Java
    fig11_import_origin.png        top 10 origin countries
    fig18_industry_dependence.png  import share per KBLI 2-digit
    fig19_importer_gap.png         VA per worker and CO2 per VA, importers vs not
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig03: who imports (line 3) ----
import excel using "$B18_XLSX", sheet("t03_si_by_year") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year pct_importer med_share_mat
order year
export excel using "$B18_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected pct_importer year, yaxis(1)) ///
       (connected med_share_mat year, yaxis(2) lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("% of firms importing", axis(1)) ytitle("Median imports / raw materials", axis(2)) ///
    legend(order(1 "% importers" 2 "Median imports / raw materials (importers)")) ///
    title("Who imports raw materials?") ///
    note("Dashed line at 2016: reporting change, not a trend.") graphregion(color(white))
graph export "$B18_OUT/fig03_who_imports.png", replace width(2000)

* ---- fig04: importer rate by group (lines 5, 6, 7, 9) ----
* take the pooled row of each group table and stack them
tempfile stack
clear
save `stack', emptyok
foreach s in t05_by_fdi t06_by_exporter t07_by_size t09_by_java {
    import excel using "$B18_XLSX", sheet("`s'") firstrow clear
    keep if period == "pool"
    unab allvars : _all
    local cat : word 1 of `allvars'         // first column = the group (fdi, exporter, ...)
    rename `cat' group
    keep group pct_importer
    append using `stack'
    save `stack', replace
}
export excel using "$B18_XLSX", sheet("fig04_data", replace) firstrow(variables)
graph hbar (asis) pct_importer, over(group, sort(1) descending) ///
    ytitle("% of firms importing raw materials") ///
    title("Who imports? (pooled 2010-2022)") graphregion(color(white))
graph export "$B18_OUT/fig04_importer_by_group.png", replace width(2000)

* ---- fig11: origin countries (line 11) ----
import excel using "$B18_XLSX", sheet("t11_origin") firstrow clear
keep if period == "pool"
gsort -share_pct
keep in 1/10
keep origin_name share_pct val_import
export excel using "$B18_XLSX", sheet("fig11_data", replace) firstrow(variables)
graph hbar (asis) share_pct, over(origin_name, sort(1) descending) ///
    ytitle("% of imported raw material value") ///
    title("Where do imported raw materials come from? (2021-2022)") ///
    note("Only rows with a reported origin country.") graphregion(color(white))
graph export "$B18_OUT/fig11_import_origin.png", replace width(2000)

* ---- fig18: industry dependence (line 18) ----
import excel using "$B18_XLSX", sheet("t18_bb_sector") firstrow clear
keep if period == "pool"
keep kbli2 import_share pct_firms_import n_firms
export excel using "$B18_XLSX", sheet("fig18_data", replace) firstrow(variables)
graph hbar (asis) import_share, over(kbli2, sort(1) descending label(labsize(vsmall))) ///
    ytitle("Imported / total raw material value") ///
    title("Industry dependence on imported raw materials") ///
    subtitle("KBLI 2-digit, roster 2021-2022") graphregion(color(white))
graph export "$B18_OUT/fig18_industry_dependence.png", replace width(2000)

* ---- fig19: importers vs non-importers (line 19) ----
import excel using "$B18_XLSX", sheet("t19_productivity") firstrow clear
keep if variable == "va_pw"
tempfile va
save `va'
import excel using "$B18_XLSX", sheet("t19_energy_carbon") firstrow clear
keep if variable == "co2_per_va"
append using `va'
drop if period == "pool"
generate year = real(period)
preserve
keep year variable group p50
replace group = cond(group == "Importer", "imp", "nonimp")
generate column = "median_" + variable + "_" + group
drop variable group
reshape wide p50, i(year) j(column) string
rename p50* *
export excel using "$B18_XLSX", sheet("fig19_data", replace) firstrow(variables)
restore
twoway (connected p50 year if variable == "va_pw" & group == "Importer") ///
       (connected p50 year if variable == "va_pw" & group == "Non-importer", lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    legend(order(1 "Importer" 2 "Non-importer")) ytitle("Median VA per worker (nominal)") ///
    title("VA per worker") graphregion(color(white)) name(g1, replace)
twoway (connected p50 year if variable == "co2_per_va" & group == "Importer") ///
       (connected p50 year if variable == "co2_per_va" & group == "Non-importer", lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    legend(order(1 "Importer" 2 "Non-importer")) ytitle("Median CO2 per VA") ///
    title("CO2 per VA") graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Importers vs non-importers") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B18_OUT/fig19_importer_gap.png", replace width(2400)
graph drop _all
