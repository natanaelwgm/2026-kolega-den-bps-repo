/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk table
            atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_19_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig03_who_exports.png          % exporters and median export share, by year
    fig04_exporter_by_group.png    % exporters by FDI / importer / size / Java
    fig08_sector_export_share.png  roster: exported / production value per KBLI 2-digit
    fig10_exporter_gap.png         VA and capital per worker, exporters vs not
    fig11_export_destination.png   top 10 destination countries
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig03: who exports (line 3) ----
import excel using "$B19_XLSX", sheet("t03_si_by_year") firstrow clear
drop if period == "pool"
generate year = real(period)
* a median from fewer than 30 exporters is not shown in the chart
replace med_exp_share = . if n_share < 30
keep year pct_exporter med_exp_share n_share
order year
export excel using "$B19_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected pct_exporter year, yaxis(1)) ///
       (connected med_exp_share year, yaxis(2) lpattern(dash) cmissing(n)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("% of firms exporting", axis(1)) ytitle("Median export share of output (%)", axis(2)) ///
    legend(order(1 "% exporters" 2 "Median export share (exporters)")) ///
    title("Who exports?") ///
    note("Firms asked the export question. 2022: no exporter flag (direct exports only)." ///
         "Median share hidden where fewer than 30 exporters report it (2013, 2015, 2017)." ///
         "Dashed line at 2016: no survey file / reporting change.") graphregion(color(white))
graph export "$B19_OUT/fig03_who_exports.png", replace width(2000)

* ---- fig04: exporter rate by group (lines 5, 6, 7, 9) ----
* take the pooled row of each group table and stack them
tempfile stack
clear
save `stack', emptyok
foreach s in t05_by_fdi t06_by_importer t07_by_size t09_by_java {
    import excel using "$B19_XLSX", sheet("`s'") firstrow clear
    keep if period == "pool"
    unab allvars : _all
    local cat : word 1 of `allvars'         // first column = the group (fdi, importer, ...)
    rename `cat' group
    keep group pct_exporter
    append using `stack'
    save `stack', replace
}
export excel using "$B19_XLSX", sheet("fig04_data", replace) firstrow(variables)
graph hbar (asis) pct_exporter, over(group, sort(1) descending) ///
    ytitle("% of firms exporting") ///
    title("Who exports? (pooled 2010-2021)") graphregion(color(white))
graph export "$B19_OUT/fig04_exporter_by_group.png", replace width(2000)

* ---- fig08: export share of production by sector (line 8, roster) ----
import excel using "$B19_XLSX", sheet("t08_pm_by_kbli2") firstrow clear
keep if period == "pool"
keep kbli2 agg_export_share pct_firms_export n_firms
export excel using "$B19_XLSX", sheet("fig08_data", replace) firstrow(variables)
graph hbar (asis) agg_export_share, over(kbli2, sort(1) descending label(labsize(vsmall))) ///
    ytitle("Exported / production value (%)") ///
    title("Export share of production by sector") ///
    subtitle("KBLI 2-digit, Proman roster 2021-2022") graphregion(color(white))
graph export "$B19_OUT/fig08_sector_export_share.png", replace width(2000)

* ---- fig10: exporters vs non-exporters (line 10) ----
import excel using "$B19_XLSX", sheet("t10_char_exporter") firstrow clear
keep if inlist(variable, "va_pw", "cap_pw")
drop if period == "pool"
generate year = real(period)
preserve
keep year variable group p50
replace group = cond(group == "Exporter", "exp", "nonexp")
generate column = "median_" + variable + "_" + group
drop variable group
reshape wide p50, i(year) j(column) string
rename p50* *
export excel using "$B19_XLSX", sheet("fig10_data", replace) firstrow(variables)
restore
twoway (connected p50 year if variable == "va_pw" & group == "Exporter") ///
       (connected p50 year if variable == "va_pw" & group == "Non-exporter", lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2020) xtitle("") ///
    legend(order(1 "Exporter" 2 "Non-exporter")) ytitle("Median VA per worker (nominal)") ///
    title("VA per worker") graphregion(color(white)) name(g1, replace)
twoway (connected p50 year if variable == "cap_pw" & group == "Exporter") ///
       (connected p50 year if variable == "cap_pw" & group == "Non-exporter", lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2020) xtitle("") ///
    legend(order(1 "Exporter" 2 "Non-exporter")) ytitle("Median capital per worker (nominal)") ///
    title("Capital per worker") graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Exporters vs non-exporters, 2010-2021") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B19_OUT/fig10_exporter_gap.png", replace width(2400)
graph drop _all

* ---- fig11: destination countries (line 11) ----
import excel using "$B19_XLSX", sheet("t11_destination") firstrow clear
keep if period == "pool"
gsort -share_pct
keep in 1/10
keep dest_name share_pct val_export
export excel using "$B19_XLSX", sheet("fig11_data", replace) firstrow(variables)
graph hbar (asis) share_pct, over(dest_name, sort(1) descending) ///
    ytitle("% of exported production value") ///
    title("Where do exports go? (2021-2022)") ///
    note("Main destination per product (Proman roster); rows with a named destination only.", span size(small)) ///
    graphregion(color(white))
graph export "$B19_OUT/fig11_export_destination.png", replace width(2000)
