/*==========================================================================
  Line 7 (no figures line in the to-do; added, runs last)
  Draws the charts FROM the tables in output/b2_04_tables.xlsx, so a chart
  always matches its table. The exact points of every chart are also written
  to a sheet figNN_data (graph-ready, e.g. to redraw in Excel/PowerPoint).

  All bars are in % of the start-year intensity (e.g. -5 = the component
  lowered the aggregate CO2/VA by 5% of its 2010 value).

  Charts (output/):
    fig02a_components.png  2010-2022, FHK and MP, CO2/VA and GJ/VA
    fig02b_periods.png     FHK by period (2010-15, 2017-22, 2010-22)
    fig06a_groups.png      FHK by exporter / FDI / importer group
    fig06b_sectors.png     FHK by KBLI 2-digit sector, CO2/VA

  NOTE: firm links are FICTIONAL in the development data, so the split into
        within / reallocation / entry-exit only means something on BPS data.
==========================================================================*/
if "$B204" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local note "Firm links are fictional in the development data: components only meaningful on BPS data."

* ---- fig02a: the three parts, both methods, 2010-2022 (lines 2-5) ----
import excel using "$B204_XLSX", sheet("t02_05_summary") firstrow clear
keep if period == "2010-2022"
generate short = "within"
replace  short = "realloc"   if part == "Reallocation toward cleaner firms"
replace  short = "entryexit" if part == "Entry/exit"
keep indicator method short pct_of_start
reshape wide pct_of_start, i(indicator method) j(short) string
rename pct_of_start* pct_*
order indicator method pct_within pct_realloc pct_entryexit
export excel using "$B204_XLSX", sheet("fig02a_data", replace) firstrow(variables)
graph bar (asis) pct_within pct_realloc pct_entryexit, over(method) ///
    by(indicator, title("Who drove the change in intensity, 2010-2022?") ///
       note("`note'", size(vsmall)) graphregion(color(white))) ///
    yline(0, lcolor(gs8)) ytitle("% of 2010 intensity") ///
    legend(order(1 "Within firm" 2 "Reallocation" 3 "Entry/exit") rows(1)) ///
    bar(1, color(navy)) bar(2, color(teal)) bar(3, color(orange)) ///
    xsize(10) ysize(5)
graph export "$B204_OUT/fig02a_components.png", replace width(2400)

* ---- fig02b: FHK by period (lines 2-5) ----
import excel using "$B204_XLSX", sheet("t02_05_summary") firstrow clear
keep if method == "FHK (2001)"
generate short = "within"
replace  short = "realloc"   if part == "Reallocation toward cleaner firms"
replace  short = "entryexit" if part == "Entry/exit"
keep indicator period short pct_of_start
reshape wide pct_of_start, i(indicator period) j(short) string
rename pct_of_start* pct_*
order indicator period pct_within pct_realloc pct_entryexit
export excel using "$B204_XLSX", sheet("fig02b_data", replace) firstrow(variables)
generate order = cond(period == "2010-2015", 1, cond(period == "2017-2022", 2, 3))
graph bar (asis) pct_within pct_realloc pct_entryexit, over(period, sort(order)) ///
    by(indicator, title("FHK decomposition by period") ///
       note("2016 has no survey; the questionnaire changed between 2015 and 2017." "`note'", size(vsmall)) ///
       graphregion(color(white))) ///
    yline(0, lcolor(gs8)) ytitle("% of start-year intensity") ///
    legend(order(1 "Within firm" 2 "Reallocation" 3 "Entry/exit") rows(1)) ///
    bar(1, color(navy)) bar(2, color(teal)) bar(3, color(orange)) ///
    xsize(10) ysize(5)
graph export "$B204_OUT/fig02b_periods.png", replace width(2400)

* ---- fig06a: FHK by exporter / FDI / importer group (line 6) ----
import excel using "$B204_XLSX", sheet("t06_summary") firstrow clear
keep if dimension != "Sector (KBLI 2-digit)"
keep indicator group period n_continuers change_pct fhk_within_pct fhk_realloc_pct fhk_entexit_pct
export excel using "$B204_XLSX", sheet("fig06a_data", replace) firstrow(variables)
generate order = 1
replace order = 2 if inlist(group, "Exporter", "Non-exporter")
replace order = 3 if inlist(group, "Domestic", "FDI")
replace order = 4 if inlist(group, "Importer", "Non-importer")
replace group = group + " (" + period + ")"
graph hbar (asis) fhk_within_pct fhk_realloc_pct fhk_entexit_pct, ///
    over(group, sort(order) label(labsize(small))) ///
    by(indicator, title("FHK decomposition by group") ///
       note("% of the group's start-year intensity. Exporter groups end in 2021 (no 2022 export flag)." "`note'", size(vsmall)) ///
       graphregion(color(white))) ///
    yline(0, lcolor(gs8)) ytitle("% of start-year intensity") ///
    legend(order(1 "Within firm" 2 "Reallocation" 3 "Entry/exit") rows(1)) ///
    bar(1, color(navy)) bar(2, color(teal)) bar(3, color(orange)) ///
    xsize(10) ysize(6)
graph export "$B204_OUT/fig06a_groups.png", replace width(2400)

* ---- fig06b: FHK by KBLI 2-digit sector, CO2/VA (line 6) ----
import excel using "$B204_XLSX", sheet("t06_summary") firstrow clear
keep if dimension == "Sector (KBLI 2-digit)" & indicator == "CO2 / VA (carbon intensity)"
keep group period n_continuers change_pct fhk_within_pct fhk_realloc_pct fhk_entexit_pct
export excel using "$B204_XLSX", sheet("fig06b_data", replace) firstrow(variables)
graph hbar (asis) fhk_within_pct fhk_realloc_pct fhk_entexit_pct, ///
    over(group, label(labsize(vsmall))) ///
    yline(0, lcolor(gs8)) ytitle("% of the sector's 2010 CO2/VA") ///
    legend(order(1 "Within firm" 2 "Reallocation" 3 "Entry/exit") rows(1) size(small)) ///
    bar(1, color(navy)) bar(2, color(teal)) bar(3, color(orange)) ///
    title("CO2/VA by sector: FHK, 2010-2022", size(medium)) ///
    note("Sectors with few continuers (see n_continuers in fig06b_data) are noisy." "`note'", size(vsmall)) ///
    graphregion(color(white)) xsize(9) ysize(11)
graph export "$B204_OUT/fig06b_sectors.png", replace width(2000)
graph drop _all
