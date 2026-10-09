/*==========================================================================
  (No figures line in the to-do list; added as file 12, runs last.)
  Every other file writes its tables to output/b2_09_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).

  Charts (output/):
    fig02_ci_by_group.png       median ln(CO2/VA) per year, by group
    fig03_change_by_group.png   median ln change of every outcome, by group
    fig04_workers_by_year.png   median workers per year, by group
    fig09_va_pw_by_year.png     median VA per worker per year, by group
    fig10_cap_pw_by_year.png    median capital per worker per year, by group
==========================================================================*/
if "$B209" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: carbon intensity of the 3 groups over time (line 2) ----
import excel using "$B209_XLSX", sheet("t02_ci_by_year") firstrow clear
keep if variable == "ln_co2_per_va" & period != "pool"
generate year = real(period)
generate g = "falling" if group == "Rapidly falling"
replace  g = "stable"  if group == "Stable"
replace  g = "rising"  if group == "Rapidly rising"
keep year g p50
rename p50 median_ln_ci_
reshape wide median_ln_ci_, i(year) j(g) string
order year median_ln_ci_falling median_ln_ci_stable median_ln_ci_rising
export excel using "$B209_XLSX", sheet("fig02_data", replace) firstrow(variables)
twoway (connected median_ln_ci_falling year) ///
       (connected median_ln_ci_stable year, lpattern(dash)) ///
       (connected median_ln_ci_rising year, lpattern(shortdash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Median ln(CO2 / value added)") ylabel(, angle(0)) ///
    legend(order(1 "Rapidly falling" 2 "Stable" 3 "Rapidly rising") rows(1)) ///
    title("Carbon intensity of the three groups") ///
    note("Groups = terciles of each firm's change in ln(CO2/VA), first to last year." ///
         "Dashed line at 2016: reporting change, not a trend. Firm links fictional in the dev data.") ///
    graphregion(color(white))
graph export "$B209_OUT/fig02_ci_by_group.png", replace width(2000)

* ---- fig03: change in every outcome, by group (line 3) ----
import excel using "$B209_XLSX", sheet("t03_overview") firstrow clear
keep if !missing(med_dln)
generate pct = 100 * med_dln                      // ln change x100 ~ % change
generate g = "falling" if group == "Rapidly falling"
replace  g = "stable"  if group == "Stable"
replace  g = "rising"  if group == "Rapidly rising"
generate label = outcome
replace label = "Workers"                if outcome == "workers"
replace label = "Production workers"     if outcome == "prod_workers"
replace label = "Non-production workers" if outcome == "nonprod_workers"
replace label = "VA per worker"          if outcome == "va_pw"
replace label = "Capital per worker"     if outcome == "cap_pw"
preserve
keep outcome label g pct
rename pct med_pct_change_
reshape wide med_pct_change_, i(outcome label) j(g) string
order outcome label med_pct_change_falling med_pct_change_stable med_pct_change_rising
export excel using "$B209_XLSX", sheet("fig03_data", replace) firstrow(variables)
restore
generate lorder = 1 if outcome == "workers"
replace  lorder = 2 if outcome == "prod_workers"
replace  lorder = 3 if outcome == "nonprod_workers"
replace  lorder = 4 if outcome == "va_pw"
replace  lorder = 5 if outcome == "cap_pw"
generate gorder = 1 if g == "falling"
replace  gorder = 2 if g == "stable"
replace  gorder = 3 if g == "rising"
label define gorder 1 "Rapidly falling" 2 "Stable" 3 "Rapidly rising"
label values gorder gorder
graph hbar (asis) pct, over(gorder) over(label, sort(lorder) label(labsize(small))) asyvars ///
    ytitle("Median change, first to last year (ln x 100, ~%)") ///
    legend(rows(1)) title("Change from first to last year") ///
    subtitle("Median per group of carbon-intensity trend") ///
    note("Workers are whole numbers, so the median firm often shows no change (0)." ///
         "Firm links fictional in the dev data. Values nominal.") graphregion(color(white))
graph export "$B209_OUT/fig03_change_by_group.png", replace width(2000)

* ---- fig04, fig09, fig10: medians per year, by group (lines 4, 9, 10) ----
foreach n in 04 09 10 {
    if "`n'" == "04" {
        local v "workers"
        local name "workers_by_year"
        local yt "Median number of workers"
        local tt "Workers"
        local nt ""
    }
    if "`n'" == "09" {
        local v "va_pw"
        local name "va_pw_by_year"
        local yt "Median VA per worker (nominal)"
        local tt "Value added per worker"
        local nt ""
    }
    if "`n'" == "10" {
        local v "cap_pw"
        local name "cap_pw_by_year"
        local yt "Median capital per worker (nominal)"
        local tt "Capital per worker"
        local nt "Many firms report zero capital. "
    }
    import excel using "$B209_XLSX", sheet("t`n'_levels") firstrow clear
    keep if variable == "`v'" & period != "pool"
    generate year = real(period)
    generate g = "falling" if group == "Rapidly falling"
    replace  g = "stable"  if group == "Stable"
    replace  g = "rising"  if group == "Rapidly rising"
    keep year g p50
    rename p50 median_`v'_
    reshape wide median_`v'_, i(year) j(g) string
    order year median_`v'_falling median_`v'_stable median_`v'_rising
    export excel using "$B209_XLSX", sheet("fig`n'_data", replace) firstrow(variables)
    twoway (connected median_`v'_falling year) ///
           (connected median_`v'_stable year, lpattern(dash)) ///
           (connected median_`v'_rising year, lpattern(shortdash)), ///
        xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
        ytitle("`yt'") ylabel(, angle(0) format(%12.0fc)) ///
        legend(order(1 "Rapidly falling" 2 "Stable" 3 "Rapidly rising") rows(1)) ///
        title("`tt'") subtitle("Median per year, by carbon-intensity trend") ///
        note("`nt'Dashed line at 2016: reporting change." "Firm links fictional in the dev data.") ///
        graphregion(color(white))
    graph export "$B209_OUT/fig`n'_`name'.png", replace width(2000)
}
graph drop _all
