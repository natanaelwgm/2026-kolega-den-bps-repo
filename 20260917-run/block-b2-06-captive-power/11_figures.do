/*==========================================================================
  Line 11 (added; the row has no figures line): charts for B2-06
  Every other file writes its tables to output/b2_06_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig03_own_generation.png     % own-generators and % buying non-PLN power, by year
    fig06_share_bands.png        own-generators by own share of electricity, by year
    fig08a_owngen_by_group.png   % own-generators by size / FDI / exporter / importer / Java
    fig08b_owngen_by_sector.png  % own-generators per KBLI 2-digit
    fig09a_java.png              % own-generators, Java vs outside Java, by year
    fig09b_province.png          % own-generators per province (pooled)
    fig09c_output_change.png     median output change 2018-19 vs 2019-20, own-gen vs not
    fig10_scope1.png             median scope 1 CO2 per worker, own-gen vs not, by year
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig03: own generation by year (line 3) ----
import excel using "$B206_XLSX", sheet("t03_by_year") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year pct_owngen pct_nonpln
order year
export excel using "$B206_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected pct_owngen year) (connected pct_nonpln year, lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("% of firms asked") ///
    legend(order(1 "Generates own electricity" 2 "Buys non-PLN electricity") rows(1)) ///
    title("Captive power in Indonesian manufacturing") ///
    note("Dashed line at 2016: reporting change, not a trend. 2014-2015: firms not asked are left out.") ///
    graphregion(color(white))
graph export "$B206_OUT/fig03_own_generation.png", replace width(2000)

* ---- fig06: share bands by year (line 6) ----
import excel using "$B206_XLSX", sheet("t06_share_bands") firstrow clear
drop if period == "pool"
keep period n_owngen pct_lt10 pct_10_50 pct_50_90 pct_ge90
export excel using "$B206_XLSX", sheet("fig06_data", replace) firstrow(variables)
graph bar (asis) pct_lt10 pct_10_50 pct_50_90 pct_ge90, over(period, label(labsize(small))) stack ///
    ytitle("% of own-generators") ylabel(0(20)100, angle(horizontal)) ///
    legend(order(1 "<10% own" 2 "10-50%" 3 "50-90%" 4 ">=90% own") rows(1) size(small)) ///
    title("How much of their electricity do own-generators make?") ///
    note("Own-generated kWh / (own-generated + purchased kWh), own-generators only.") ///
    graphregion(color(white))
graph export "$B206_OUT/fig06_share_bands.png", replace width(2000)

* ---- fig08a: own-generation rate by group (line 8 + Java from line 9) ----
* take the pooled row of each group table and stack them
tempfile stack
clear
save `stack', emptyok
foreach s in t08_by_size t08_by_fdi t08_by_exporter t08_by_importer t09a_by_java {
    import excel using "$B206_XLSX", sheet("`s'") firstrow clear
    keep if period == "pool"
    unab allvars : _all
    local cat : word 1 of `allvars'         // first column = the group (large, fdi, ...)
    rename `cat' group
    keep group pct_owngen n_firms
    append using `stack'
    save `stack', replace
}
export excel using "$B206_XLSX", sheet("fig08a_data", replace) firstrow(variables)
graph hbar (asis) pct_owngen, over(group, sort(1) descending) ///
    ytitle("% of firms generating own electricity") ///
    title("Who generates its own electricity?") subtitle("Pooled 2010-2022") ///
    note("FDI excludes 2020; exporter excludes 2022.") graphregion(color(white))
graph export "$B206_OUT/fig08a_owngen_by_group.png", replace width(2000)

* ---- fig08b: own-generation rate by sector (line 8) ----
import excel using "$B206_XLSX", sheet("t08_by_kbli2") firstrow clear
keep if period == "pool"
keep kbli2 pct_owngen n_firms med_share
export excel using "$B206_XLSX", sheet("fig08b_data", replace) firstrow(variables)
graph hbar (asis) pct_owngen, over(kbli2, sort(1) descending label(labsize(small))) ///
    ytitle("% of firms generating own electricity") ///
    title("Own generation by sector") subtitle("KBLI 2-digit, pooled 2010-2022") ///
    graphregion(color(white)) ysize(6)
graph export "$B206_OUT/fig08b_owngen_by_sector.png", replace width(2000)

* ---- fig09a: Java vs outside Java by year (line 9a) ----
import excel using "$B206_XLSX", sheet("t09a_by_java") firstrow clear
drop if period == "pool"
generate year = real(period)
generate col = cond(java == "Java", "java", "outside")
keep year col pct_owngen med_share
reshape wide pct_owngen med_share, i(year) j(col) string
export excel using "$B206_XLSX", sheet("fig09a_data", replace) firstrow(variables)
twoway (connected pct_owngenoutside year) (connected pct_owngenjava year, lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("% of firms asked") ///
    legend(order(1 "Outside Java" 2 "Java") rows(1)) ///
    title("Own generation: Java vs outside Java") ///
    note("Outside Java has the weaker grid. Dashed line at 2016: reporting change.") ///
    graphregion(color(white))
graph export "$B206_OUT/fig09a_java.png", replace width(2000)

* ---- fig09b: by province, pooled (line 9a) ----
import excel using "$B206_XLSX", sheet("t09a_by_province") firstrow clear
keep if period == "pool"
generate province = string(prov) + cond(java == "Java", " (Java)", "")
keep province prov java pct_owngen n_firms
export excel using "$B206_XLSX", sheet("fig09b_data", replace) firstrow(variables)
graph hbar (asis) pct_owngen, over(province, sort(1) descending label(labsize(vsmall))) ///
    ytitle("% of firms generating own electricity") ///
    title("Own generation by province") subtitle("Pooled 2010-2022") ///
    note("Province code (BPS). Small provinces have few firms.") ///
    graphregion(color(white)) ysize(7)
graph export "$B206_OUT/fig09b_province.png", replace width(2000)

* ---- fig09c: output change around 2020 (line 9b) ----
import excel using "$B206_XLSX", sheet("t09b_output_change") firstrow clear
generate col = cond(has_owngen == "Own generation", "owngen", "none")
keep change col med_dln_output
reshape wide med_dln_output, i(change) j(col) string
export excel using "$B206_XLSX", sheet("fig09c_data", replace) firstrow(variables)
graph bar (asis) med_dln_outputnone med_dln_outputowngen, over(change) ///
    ytitle("Median change in ln output") yline(0, lcolor(gs8)) ///
    legend(order(1 "No own generation" 2 "Own generation") rows(1)) ///
    title("Did own generators lose less output in 2020?") ///
    note("Own-generation status in the base year. Firm links are fictional in the development data.") ///
    graphregion(color(white))
graph export "$B206_OUT/fig09c_output_change.png", replace width(2000)

* ---- fig10: scope 1 per worker, own-gen vs not (line 10) ----
import excel using "$B206_XLSX", sheet("t10_s1_by_owngen") firstrow clear
keep if variable == "co2_s1_pw"
drop if period == "pool"
generate year = real(period)
generate col = cond(group == "Own generation", "owngen", "none")
keep year col p50
reshape wide p50, i(year) j(col) string
rename (p50none p50owngen) (median_co2_s1_pw_none median_co2_s1_pw_owngen)
export excel using "$B206_XLSX", sheet("fig10_data", replace) firstrow(variables)
twoway (connected median_co2_s1_pw_owngen year) (connected median_co2_s1_pw_none year, lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Median scope 1 CO2 per worker (t)") ///
    legend(order(1 "Own generation" 2 "No own generation") rows(1)) ///
    title("Do own-generators emit more scope 1?") ///
    note("Scope 1 = diesel, petrol, coal, LPG. Generator fuel cannot be separated from other fuel use.") ///
    graphregion(color(white))
graph export "$B206_OUT/fig10_scope1.png", replace width(2000)
graph drop _all
