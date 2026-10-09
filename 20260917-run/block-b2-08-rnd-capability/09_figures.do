/*==========================================================================
  (no figures line in the to-do list; added as line 9)
  Every other file writes its tables to output/b2_08_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_availability.png    % of firms answering each question, by year
    fig03_rnd.png             % R&D and % external R&D funding, by year
    fig04_rnd_intensity.png   % with positive R&D expense; median R&D/VA
    fig05_innovation.png      % innovating, by year
    fig06_env_docs.png        % holding AMDAL / UKL-UPL / SPPL, by year
    fig07_waste.png           waste treatment and waste types (pooled)
    fig08a_by_group.png       R&D, innovation, env. document by exporter /
                              importer / FDI / size (pooled)
    fig08b_by_carbon_prod.png same by quintile of carbon productivity
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: which question is answered in which year (line 2) ----
import excel using "$B208_XLSX", sheet("t02_availability") firstrow clear
keep if inlist(variable, "rnd", "innov", "amdal", "waste_any") & period != "pool"
generate year = real(period)
keep year variable pct_answered
reshape wide pct_answered, i(year) j(variable) string
rename pct_answered* pct_answered_*
order year pct_answered_rnd pct_answered_innov pct_answered_amdal pct_answered_waste_any
export excel using "$B208_XLSX", sheet("fig02_data", replace) firstrow(variables)
graph bar (asis) pct_answered_rnd pct_answered_innov pct_answered_amdal pct_answered_waste_any, ///
    over(year, label(labsize(small))) ytitle("% of firms answering") ylabel(0(20)100, angle(horizontal)) ///
    legend(order(1 "R&D" 2 "Innovation" 3 "AMDAL" 4 "Waste types") rows(1)) ///
    title("When is each capability question answered?") ///
    note("No bar = question not in that year's form (there is no 2016 survey)." ///
         "Blanks are not counted as 'no'.") ///
    graphregion(color(white)) xsize(9) ysize(5)
graph export "$B208_OUT/fig02_availability.png", replace width(2000)

* ---- fig03: R&D incidence (line 3) ----
import excel using "$B208_XLSX", sheet("t03_rnd_by_year") firstrow clear
keep if n_answered > 0 & period != "pool"
keep period variable pct_yes
reshape wide pct_yes, i(period) j(variable) string
rename pct_yes* pct_*
export excel using "$B208_XLSX", sheet("fig03_data", replace) firstrow(variables)
graph bar (asis) pct_rnd pct_rnd_ext, over(period) ///
    ytitle("% of firms that answered") ///
    legend(order(1 "R&D activity" 2 "External R&D funding") rows(1)) ///
    title("Incidence of R&D") ///
    note("Asked in 2011 and 2017-2022 only; about 45% of firms leave it blank.") ///
    graphregion(color(white))
graph export "$B208_OUT/fig03_rnd.png", replace width(2000)

* ---- fig04: R&D expense / VA (line 4) ----
import excel using "$B208_XLSX", sheet("t04_ratio_spenders") firstrow clear
keep if variable == "rnd_va" & period != "pool"
keep period p25 p50 p75
tempfile ratio
save `ratio'
import excel using "$B208_XLSX", sheet("t04_coverage") firstrow clear
keep if period != "pool"
keep period pct_cost_pos
merge 1:1 period using `ratio', nogenerate
generate year = real(period)
rename (p25 p50 p75) (p25_rnd_va p50_rnd_va p75_rnd_va)
order year pct_cost_pos p25_rnd_va p50_rnd_va p75_rnd_va
drop period
export excel using "$B208_XLSX", sheet("fig04_data", replace) firstrow(variables)
twoway (bar pct_cost_pos year, barwidth(0.7)), xlabel(2017(1)2022) xtitle("") ///
    ytitle("% of firms") title("Positive R&D expense reported") ///
    graphregion(color(white)) name(g1, replace)
twoway (rcap p25_rnd_va p75_rnd_va year, lcolor(gs10)) (connected p50_rnd_va year), ///
    xlabel(2017(1)2022) xtitle("") ytitle("R&D expense / VA") ///
    legend(order(2 "Median" 1 "25th-75th pct") rows(1)) ///
    title("R&D / VA among spenders") graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("R&D expenditure / value added") ///
    note("2018-2019: ~47% report a positive expense vs 3-5% in other years (likely a field change, not behaviour).") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B208_OUT/fig04_rnd_intensity.png", replace width(2400)
graph drop _all

* ---- fig05: innovation (line 5) ----
import excel using "$B208_XLSX", sheet("t05_innov_by_year") firstrow clear
keep if variable == "innov" & n_answered > 0 & period != "pool"
keep period pct_yes n_answered
rename pct_yes pct_innov
export excel using "$B208_XLSX", sheet("fig05_data", replace) firstrow(variables)
graph bar (asis) pct_innov, over(period) ///
    ytitle("% of firms that answered") title("Any innovation") ///
    note("Not asked in 2012-2016 or 2019. The 2017-2018 form lists four innovation types;" ///
         "the drop after 2018 is a questionnaire change, not a trend.") ///
    graphregion(color(white))
graph export "$B208_OUT/fig05_innovation.png", replace width(2000)

* ---- fig06: environmental documents (line 6) ----
import excel using "$B208_XLSX", sheet("t06_env_by_year") firstrow clear
keep if n_answered > 0 & period != "pool"
keep period variable pct_yes
reshape wide pct_yes, i(period) j(variable) string
rename pct_yes* pct_*
order period pct_amdal pct_ukl_upl pct_sppl pct_env_doc
export excel using "$B208_XLSX", sheet("fig06_data", replace) firstrow(variables)
graph bar (asis) pct_amdal pct_ukl_upl pct_sppl pct_env_doc, over(period) ///
    ytitle("% of firms that answered") ///
    ylabel(, angle(horizontal)) ///
    legend(order(1 "AMDAL" 2 "UKL/UPL" 3 "SPPL" 4 "Any") rows(1)) ///
    title("Environmental management documents") ///
    note("Asked in 2020-2022 only; about 45% of firms leave it blank.") ///
    graphregion(color(white))
graph export "$B208_OUT/fig06_env_docs.png", replace width(2000)

* ---- fig07: waste (line 7) ----
import excel using "$B208_XLSX", sheet("t07_waste_by_year") firstrow clear
keep if period == "pool"
generate str30 item = ""
replace item = "Waste treatment (2020-22)"  if variable == "waste_treat"
replace item = "Solid waste (2022)"         if variable == "waste_solid"
replace item = "Liquid waste (2022)"        if variable == "waste_liquid"
replace item = "Hazardous B3 waste (2022)"  if variable == "waste_haz"
replace item = "Any waste type (2022)"      if variable == "waste_any"
keep item variable pct_yes n_answered
export excel using "$B208_XLSX", sheet("fig07_data", replace) firstrow(variables)
graph hbar (asis) pct_yes, over(item, sort(1) descending) ///
    ytitle("% of firms that answered") title("Waste management (pooled)") ///
    note("Waste types: 2022 only, answered by ~26% of firms." ///
         "They show the kind of waste reported, not how it is managed.") ///
    graphregion(color(white))
graph export "$B208_OUT/fig07_waste.png", replace width(2000)

* ---- fig08a: capability by exporter / importer / FDI / size (line 8) ----
tempfile stack
clear
save `stack', emptyok
foreach s in exporter importer fdi large {
    import excel using "$B208_XLSX", sheet("t08_by_`s'") firstrow clear
    keep if period == "pool"
    rename `s' group
    keep group pct_rnd pct_innov pct_env_doc
    append using `stack'
    save `stack', replace
}
export excel using "$B208_XLSX", sheet("fig08a_data", replace) firstrow(variables)
graph hbar (asis) pct_rnd pct_innov pct_env_doc, over(group, sort(1) descending) ///
    ytitle("% of firms that answered") ///
    legend(order(1 "R&D" 2 "Innovation" 3 "Env. document") rows(1)) ///
    title("Capability by firm type (pooled)") graphregion(color(white))
graph export "$B208_OUT/fig08a_by_group.png", replace width(2000)

* ---- fig08b: capability by carbon productivity quintile (line 8) ----
import excel using "$B208_XLSX", sheet("t08_by_q_cprod") firstrow clear
keep if period == "pool"
keep q_cprod pct_rnd pct_innov pct_env_doc
export excel using "$B208_XLSX", sheet("fig08b_data", replace) firstrow(variables)
graph bar (asis) pct_rnd pct_innov pct_env_doc, over(q_cprod) ///
    ytitle("% of firms that answered") ///
    legend(order(1 "R&D" 2 "Innovation" 3 "Env. document") rows(1)) ///
    title("Capability by carbon productivity (VA / tCO2)") ///
    subtitle("Quintiles within each year, pooled") graphregion(color(white))
graph export "$B208_OUT/fig08b_by_carbon_prod.png", replace width(2000)
