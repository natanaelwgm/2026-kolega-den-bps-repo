/*==========================================================================
  Line 11 (added; the row has no figures line)
  Every other file writes its tables to output/b2_10_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig03_java_shares.png       Java's share of national VA, energy and CO2, by year
    fig06_co2_per_va_prov.png   CO2 per VA per province, pooled (ranked provinces)
    fig07_exporters_prov.png    % exporters per province, pooled
    fig08_fdi_prov.png          % FDI firms per province, pooled
    fig09_mix_prov.png          energy mix per province, pooled
    fig10_quadrant.png          CO2 per VA vs share of national VA, per province
  Provinces with fewer than 50 firm-years (firms asked, for 07/08) are left
  out of the province charts; they are still in the tables.
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig03: Java's share of VA, energy and CO2 (lines 3-5) ----
import excel using "$B210_XLSX", sheet("t02_overview_java") firstrow clear
keep if java == "Java" & period != "pool"
generate year = real(period)
keep year va_share_pct gj_share_pct co2_share_pct
order year
export excel using "$B210_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected va_share_pct year) (connected gj_share_pct year, lpattern(dash)) ///
       (connected co2_share_pct year, lpattern(shortdash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ylabel(0(20)100) ///
    ytitle("Java, % of national total") ///
    legend(order(1 "Value added" 2 "Energy (GJ)" 3 "CO2") rows(1)) ///
    title("Java's share of manufacturing VA, energy and CO2") ///
    note("Dashed line at 2016: no data and a questionnaire change, not a trend.") ///
    graphregion(color(white))
graph export "$B210_OUT/fig03_java_shares.png", replace width(2000)

* ---- fig06: CO2 per VA per province (line 6, ranking of line 10) ----
import excel using "$B210_XLSX", sheet("t10_rank_prov") firstrow clear
keep if ranked == 1
generate co2_per_bn_va = co2_per_va * 1e6        // t CO2 per Rp billion (VA is in Rp000)
generate national = national_co2_per_va * 1e6
keep region co2_per_bn_va national
export excel using "$B210_XLSX", sheet("fig06_data", replace) firstrow(variables)
local nat = national[1]
graph hbar (asis) co2_per_bn_va, over(region, sort(1) descending label(labsize(vsmall))) ///
    yline(`nat', lpattern(dash) lcolor(cranberry)) ///
    ytitle("t CO2 per Rp billion of VA (nominal)", size(small)) ///
    title("Carbon intensity by province, pooled 2010-2022", size(medium) span) ///
    note("Dashed line: national CO2 per VA." "Provinces with at least 50 firm-years." ///
         "VA is nominal and masked: read the ranking, not the level.", size(vsmall) span) ///
    graphregion(color(white) margin(l+6 r+10)) xsize(9) ysize(9)
graph export "$B210_OUT/fig06_co2_per_va_prov.png", replace width(2000)

* ---- fig07 / fig08: exporters and FDI per province (lines 7, 8) ----
foreach num in 07 08 {
    if "`num'" == "07" {
        import excel using "$B210_XLSX", sheet("t07_exp_prov") firstrow clear
        keep if period == "pool" & n_asked >= 50
        keep prov n_asked pct_exporters exp_output_share
        rename (pct_exporters exp_output_share) (pct_firms pct_output)
        local name "exporters"
        local what "Exporters"
    }
    else {
        import excel using "$B210_XLSX", sheet("t08_fdi_prov") firstrow clear
        keep if period == "pool" & n_asked >= 50
        keep prov n_asked pct_fdi fdi_output_share
        rename (pct_fdi fdi_output_share) (pct_firms pct_output)
        local name "fdi"
        local what "FDI firms"
    }
    export excel using "$B210_XLSX", sheet("fig`num'_data", replace) firstrow(variables)
    graph hbar (asis) pct_firms pct_output, over(prov, sort(1) descending label(labsize(vsmall))) ///
        bar(1, color(navy)) bar(2, color(eltblue)) ///
        legend(order(1 "% of firms" 2 "% of output") rows(1) size(vsmall)) ytitle("%", size(small)) ///
        title("`what' by province, pooled", size(medium) span) ///
        note("Firms with an answer only;" "provinces with at least 50 of them.", size(vsmall) span) ///
        graphregion(color(white) margin(l+6 r+10)) xsize(9) ysize(9)
    graph export "$B210_OUT/fig`num'_`name'_prov.png", replace width(2000)
}

* ---- fig09: energy mix per province (line 9) ----
import excel using "$B210_XLSX", sheet("t09_mix_prov") firstrow clear
keep if period == "pool" & n_firms >= 50
keep prov sh_coal sh_oil sh_gas sh_pln sh_nonpln
export excel using "$B210_XLSX", sheet("fig09_data", replace) firstrow(variables)
graph hbar (asis) sh_coal sh_oil sh_gas sh_pln sh_nonpln, ///
    over(prov, sort(1) descending label(labsize(vsmall))) stack ///
    bar(1, color(black)) bar(2, color(sienna)) bar(3, color(orange)) ///
    bar(4, color(navy)) bar(5, color(eltblue)) ///
    legend(order(1 "Coal" 2 "Oil" 3 "Gas/LPG" 4 "Electricity PLN" 5 "Electricity non-PLN") cols(2) size(vsmall)) ///
    ytitle("% of energy (GJ)", size(small)) title("Energy mix by province, pooled 2010-2022", size(medium) span) ///
    note("Sorted by coal share." "Own generation and biomass not in the mix (see t09).", size(vsmall) span) ///
    graphregion(color(white) margin(l+6 r+10)) xsize(9) ysize(9)
graph export "$B210_OUT/fig09_mix_prov.png", replace width(2000)

* ---- fig10: cleaner vs carbon intensive, by economic weight (line 10) ----
import excel using "$B210_XLSX", sheet("t10_rank_prov") firstrow clear
keep if ranked == 1
generate code = substr(region, 1, 2)
generate co2_per_bn_va = co2_per_va * 1e6
keep region code va_share_pct co2_per_bn_va national_co2_per_va quadrant
export excel using "$B210_XLSX", sheet("fig10_data", replace) firstrow(variables)
local nat = national_co2_per_va[1] * 1e6
summarize va_share_pct, detail
local med = r(p50)
twoway (scatter co2_per_bn_va va_share_pct, mlabel(code) mlabsize(vsmall) msymbol(O)), ///
    xscale(log) yscale(log) xlabel(0.01 0.1 1 10 50) ylabel(5 10 20 50 100 200 400) ///
    xline(`med', lpattern(dash) lcolor(gs10)) yline(`nat', lpattern(dash) lcolor(cranberry)) ///
    xtitle("Share of national value added, % (log scale)") ///
    ytitle("t CO2 per Rp billion of VA (log scale)") ///
    title("Which provinces are cleaner, which carbon intensive?") ///
    note("Red line: national CO2 per VA. Grey line: median VA share. Labels = BPS province code." ///
         "Pooled 2010-2022, provinces with at least 50 firm-years. Quadrants in t10_quadrant_prov.") ///
    legend(off) graphregion(color(white))
graph export "$B210_OUT/fig10_quadrant.png", replace width(2000)
graph drop _all
