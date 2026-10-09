/*==========================================================================
  Line 6 (added; the row has no figures line): charts for lines 2-5
  Every other file writes its tables to output/b2_02_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_decomposition.png    cumulative change since 2010: CO2/VA = GJ/VA x CO2/GJ,
                               and the same per worker (lines 1-2)
    fig03_energy_intensity.png aggregate GJ/VA and GJ per worker, by year (line 3)
    fig04_co2_per_gj.png       CO2/GJ for scope 1, scope 2, total, total with
                               a static grid factor, by year (line 4)
    fig05a_split.png           change in total CO2 2010-2022 split into scale,
                               energy intensity and carbon content (line 5)
    fig05b_sectors.png         each sector: energy intensity change vs CO2
                               change, 2010-2022 (line 5)
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: the decomposition over time (lines 1-2) ----
import excel using "$B202_XLSX", sheet("t02_cumulative") firstrow clear
keep year d_co2_per_va d_gj_per_va d_co2_per_gj d_co2_pw d_gj_pw
export excel using "$B202_XLSX", sheet("fig02_data", replace) firstrow(variables)
twoway (connected d_co2_per_va year) ///
       (connected d_gj_per_va year, lpattern(dash)) ///
       (connected d_co2_per_gj year, lpattern(shortdash)), ///
    yline(0, lcolor(gs10)) xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Change since 2010 (log points)") ///
    legend(order(1 "CO2/VA" 2 "GJ/VA (energy use)" 3 "CO2/GJ (carbon content)") rows(1) size(small)) ///
    title("Per unit of value added (nominal)") graphregion(color(white)) name(g1, replace)
twoway (connected d_co2_pw year) ///
       (connected d_gj_pw year, lpattern(dash)) ///
       (connected d_co2_per_gj year, lpattern(shortdash)), ///
    yline(0, lcolor(gs10)) xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Change since 2010 (log points)") ///
    legend(order(1 "CO2/worker" 2 "GJ/worker (energy use)" 3 "CO2/GJ (carbon content)") rows(1) size(small)) ///
    title("Per worker (physical)") graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Carbon intensity = energy intensity x carbon content of energy") ///
    note("All manufacturing, clean records. Dashed line at 2016: reporting change, not a trend.") ///
    graphregion(color(white)) xsize(11) ysize(4.5)
graph export "$B202_OUT/fig02_decomposition.png", replace width(2400)
graph drop _all

* ---- fig03: energy intensity (line 3) ----
import excel using "$B202_XLSX", sheet("t03_by_year") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year gj_per_va gj_pw pct_reporting_energy
order year
export excel using "$B202_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected gj_per_va year, yaxis(1)) ///
       (connected gj_pw year, yaxis(2) lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("GJ per unit of VA (nominal)", axis(1)) ytitle("GJ per worker", axis(2)) ///
    legend(order(1 "GJ / VA" 2 "GJ / worker")) ///
    title("Do firms use less energy?") subtitle("All manufacturing, total GJ / total VA and / total workers") ///
    note("Dashed line at 2016: reporting change, not a trend. VA is nominal and masked.") ///
    graphregion(color(white))
graph export "$B202_OUT/fig03_energy_intensity.png", replace width(2000)

* ---- fig04: carbon content of energy, by scope (line 4) ----
import excel using "$B202_XLSX", sheet("t04_by_scope") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year co2_per_gj_s1 co2_per_gj_s2 co2_per_gj_total co2_per_gj_static gj_share_fuel
order year
export excel using "$B202_XLSX", sheet("fig04_data", replace) firstrow(variables)
twoway (connected co2_per_gj_total year) ///
       (connected co2_per_gj_s1 year) ///
       (connected co2_per_gj_s2 year) ///
       (connected co2_per_gj_static year, lpattern(dash) lcolor(gs6) mcolor(gs6)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xlabel(2010(2)2022) xtitle("") ///
    ytitle("Tonnes CO2 per GJ") ///
    legend(order(1 "Total (scope 1 + 2)" 2 "Scope 1 (4 fuels)" 3 "Scope 2 (purchased electricity)" ///
                 4 "Total, grid factor held constant") cols(2) size(small)) ///
    title("Did energy become cleaner?") ///
    note("Scope 2 = block 0 grid factor, held flat from 2014 (an assumption after 2014)." ///
         "Dashed line at 2016: reporting change, not a trend.") ///
    graphregion(color(white))
graph export "$B202_OUT/fig04_co2_per_gj.png", replace width(2000)

* ---- fig05a: three-way split of the change in total CO2 (line 5) ----
import excel using "$B202_XLSX", sheet("t05_synthesis") firstrow clear
keep if unit == "All manufacturing"
keep window d_co2 d_va d_gj_per_va d_co2_per_gj
export excel using "$B202_XLSX", sheet("fig05a_data", replace) firstrow(variables)
graph bar (asis) d_va d_gj_per_va d_co2_per_gj d_co2, over(window) ///
    legend(order(1 "Scale (VA, nominal)" 2 "Energy intensity (GJ/VA)" ///
                 3 "Carbon content (CO2/GJ)" 4 "Total CO2") rows(2) size(small)) ///
    ytitle("Change (log points)") ylabel(, angle(0)) yline(0, lcolor(gs10)) ///
    title("Change in total CO2 = scale + energy intensity" "+ carbon content", size(medium)) ///
    note("All manufacturing. 2010-2015 and 2017-2022 avoid the 2016 reporting change.") ///
    graphregion(color(white))
graph export "$B202_OUT/fig05a_split.png", replace width(2000)

* ---- fig05b: sectors, energy intensity vs emissions (line 5) ----
import excel using "$B202_XLSX", sheet("t05_synthesis") firstrow clear
keep if unit != "All manufacturing"
generate kbli2 = substr(unit, 1, 2)
keep unit kbli2 d_gj_per_va d_co2 reading_energy
export excel using "$B202_XLSX", sheet("fig05b_data", replace) firstrow(variables)
twoway (scatter d_co2 d_gj_per_va, mlabel(kbli2) mlabsize(small) mlabposition(3)), ///
    xline(0, lcolor(gs10)) yline(0, lcolor(gs10)) ///
    xtitle("Change in energy intensity GJ/VA, 2010-2022 (log points)") ///
    ytitle("Change in total CO2, 2010-2022 (log points)") ///
    title("Efficiency improvement without decarbonisation?") ///
    subtitle("One point per KBLI 2-digit sector. Top-left = intensity down, CO2 up") ///
    note("VA is nominal: price inflation moves sectors to the left.") ///
    legend(off) graphregion(color(white))
graph export "$B202_OUT/fig05b_sectors.png", replace width(2000)
