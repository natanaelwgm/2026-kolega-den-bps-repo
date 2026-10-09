/*==========================================================================
  Line 13: "Output: table dan graph, untuk total dan per sektor"
  The tables (total and per sector) are written by files 02-12 to
  output/b2_01_tables.xlsx. This file draws the charts FROM those tables, so
  a chart always matches its table. The exact points of every chart are also
  written to a sheet figNN_data (graph-ready, e.g. to redraw the chart in
  Excel or PowerPoint). Runs LAST in 00_run.do.

  Charts (output/):
    fig03_output_va.png            output and VA, index 2010 = 100
    fig04_energy_use.png           energy use: scope 1 fuels, electricity, total
    fig05_emissions.png            scope 1, scope 2, total CO2
    fig05_by_sector.png            each sector's % of total CO2, 2010 vs 2022
    fig06_energy_intensity.png     GJ/VA and GJ/output, index 2010 = 100
    fig07_carbon_intensity.png     CO2/VA and CO2/output, index 2010 = 100
    fig08_energy_productivity.png  VA/GJ, index 2010 = 100
    fig09_carbon_productivity.png  VA/CO2, index 2010 = 100
    fig10_12_scale_intensity.png   scale vs intensity effect, step by step
    fig10_12_by_sector.png         scale vs intensity effect per sector, 2010-2022
  Time charts: the dashed line at 2016 marks the questionnaire change (and
  the missing 2016 survey), not a trend.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local brk  "xline(2016, lpattern(dash) lcolor(gs10))"
local look `"xlabel(2010(2)2022) xtitle("") graphregion(color(white))"'

* ---- fig03: output and VA (line 3) ----
import excel using "$B201_XLSX", sheet("t03_total") firstrow clear
keep year idx_output idx_va
export excel using "$B201_XLSX", sheet("fig03_data", replace) firstrow(variables)
twoway (connected idx_output year) (connected idx_va year, lpattern(dash)), ///
    `brk' `look' yline(100, lcolor(gs12)) ytitle("Index, 2010 = 100") ///
    legend(order(1 "Gross output" 2 "Value added")) ///
    title("Total output and value added (nominal)") ///
    note("Sum over surveyed firms (clean records). Nominal and masked values." ///
         "Dashed line at 2016: questionnaire change, no 2016 survey.")
graph export "$B201_OUT/fig03_output_va.png", replace width(2000)

* ---- fig04: energy use (line 4) ----
import excel using "$B201_XLSX", sheet("t04_total") firstrow clear
foreach v in gj_s1 gj_s2 gj_total gj_total_wide {
    replace `v' = `v' / 1e6           // million GJ
}
keep year gj_s1 gj_s2 gj_total gj_total_wide
export excel using "$B201_XLSX", sheet("fig04_data", replace) firstrow(variables)
twoway (connected gj_total year) (connected gj_s1 year) (connected gj_s2 year) ///
       (line gj_total_wide year, lpattern(dash) lcolor(gs8)), ///
    `brk' `look' ytitle("Million GJ") ///
    legend(order(1 "Total" 2 "Fuels (scope 1)" 3 "Purchased electricity" ///
                 4 "Total incl. 9 fuels + 2020-form fuels") cols(2)) ///
    title("Total energy use") ///
    note("Headline fuels: diesel, petrol, coal, LPG (asked every year)." ///
         "Dashed grey: adds the other fuels; from 2020 mostly natural gas.")
graph export "$B201_OUT/fig04_energy_use.png", replace width(2000)

* ---- fig05: emissions (line 5) ----
import excel using "$B201_XLSX", sheet("t05_total") firstrow clear
foreach v in co2_s1 co2_s2 co2_total co2_total_wide {
    replace `v' = `v' / 1e6           // million tonnes
}
keep year co2_s1 co2_s2 co2_total co2_total_wide
export excel using "$B201_XLSX", sheet("fig05_data", replace) firstrow(variables)
twoway (connected co2_total year) (connected co2_s1 year) (connected co2_s2 year) ///
       (line co2_total_wide year, lpattern(dash) lcolor(gs8)), ///
    `brk' `look' ytitle("Million tonnes CO2") ///
    legend(order(1 "Total" 2 "Scope 1 (fuels)" 3 "Scope 2 (electricity)" ///
                 4 "Total incl. 9 fuels + 2020-form fuels") cols(2)) ///
    title("Scope 1, scope 2 and total CO2 emissions") ///
    note("Scope 1: diesel, petrol, coal, LPG. Scope 2: block 0 grid factor (2014 value after 2014)." ///
         "Dashed grey: adds the other fuels; from 2020 mostly natural gas.")
graph export "$B201_OUT/fig05_emissions.png", replace width(2000)

* ---- fig05_by_sector: sector shares of CO2, 2010 vs 2022 (line 5) ----
import excel using "$B201_XLSX", sheet("t05_by_kbli2") firstrow clear
keep if inlist(year, 2010, 2022)
keep kbli2 year pct_of_all_co2
reshape wide pct_of_all_co2, i(kbli2) j(year)
rename (pct_of_all_co22010 pct_of_all_co22022) (pct_co2_2010 pct_co2_2022)
export excel using "$B201_XLSX", sheet("fig05s_data", replace) firstrow(variables)
graph hbar (asis) pct_co2_2010 pct_co2_2022, ///
    over(kbli2, sort(pct_co2_2022) descending label(labsize(vsmall))) ///
    legend(order(1 "2010" 2 "2022")) ytitle("% of manufacturing CO2") ///
    title("Share of total CO2 by sector", size(medium)) ///
    graphregion(color(white) margin(l+2 r+4)) xsize(8) ysize(9)
graph export "$B201_OUT/fig05_by_sector.png", replace width(2000)

* ---- fig06-fig09: intensity and productivity (lines 6-9) ----
* one loop: sheet, the index variable(s), legend labels, title
foreach n in 06 07 08 09 {
    import excel using "$B201_XLSX", sheet("t`n'_total") firstrow clear
    drop if period == "pool"
    generate year = real(period)
    if "`n'" == "06" {
        keep year idx_gj_per_va idx_gj_per_out
        local plot "(connected idx_gj_per_va year) (connected idx_gj_per_out year, lpattern(dash))"
        local leg  `"legend(order(1 "GJ / VA" 2 "GJ / output"))"'
        local ttl  "Energy intensity"
        local file "fig06_energy_intensity"
    }
    if "`n'" == "07" {
        keep year idx_co2_per_va idx_co2_per_out
        local plot "(connected idx_co2_per_va year) (connected idx_co2_per_out year, lpattern(dash))"
        local leg  `"legend(order(1 "CO2 / VA" 2 "CO2 / output"))"'
        local ttl  "Carbon intensity"
        local file "fig07_carbon_intensity"
    }
    if "`n'" == "08" {
        keep year idx_va_per_gj
        local plot "(connected idx_va_per_gj year)"
        local leg  "legend(off)"
        local ttl  "Energy productivity (VA / GJ)"
        local file "fig08_energy_productivity"
    }
    if "`n'" == "09" {
        keep year idx_va_per_co2
        local plot "(connected idx_va_per_co2 year)"
        local leg  "legend(off)"
        local ttl  "Carbon productivity (VA / CO2)"
        local file "fig09_carbon_productivity"
    }
    order year
    export excel using "$B201_XLSX", sheet("fig`n'_data", replace) firstrow(variables)
    twoway `plot', `brk' `look' yline(100, lcolor(gs12)) ytitle("Index, 2010 = 100") ///
        `leg' title("`ttl'") ///
        note("Ratio of totals over surveyed firms (clean records). VA and output are nominal," ///
             "so price inflation alone lowers intensity and raises productivity." ///
             "Dashed line at 2016: questionnaire change, no 2016 survey.")
    graph export "$B201_OUT/`file'.png", replace width(2000)
}

* ---- fig10_12: scale vs intensity, step by step (lines 10-12) ----
import excel using "$B201_XLSX", sheet("t10_12_total") firstrow clear
keep if step != "window"
sort year_from
generate x = _n
keep x period d_ln_co2 scale_effect intensity_effect
order x period
export excel using "$B201_XLSX", sheet("fig10_12_data", replace) firstrow(variables)
generate x1 = x - 0.18                // bars side by side
generate x2 = x + 0.18
* x-axis labels = the period of each step
capture label drop steps
forvalues i = 1/`=_N' {
    label define steps `i' "`=period[`i']'", add
}
label values x x1 steps
twoway (bar scale_effect x1, barwidth(0.36) color(navy%70)) ///
       (bar intensity_effect x2, barwidth(0.36) color(orange%80)) ///
       (scatter d_ln_co2 x, msymbol(D) mcolor(black)), ///
    yline(0, lcolor(gs8)) xlabel(1(1)`=_N', valuelabel angle(45) labsize(small)) xtitle("") ///
    ytitle("Change in ln") ylabel(, angle(0)) ///
    legend(order(1 "Scale effect (VA)" 2 "Intensity effect (CO2/VA)" 3 "Total change in CO2") cols(1)) ///
    title("Change in CO2: scale vs intensity effect") ///
    note("Scale + intensity = total change in ln CO2. VA is nominal: inflation sits in the scale effect." ///
         "2015-2017 is a two-year step across the questionnaire change.") ///
    graphregion(color(white))
graph export "$B201_OUT/fig10_12_scale_intensity.png", replace width(2000)

* ---- fig10_12_by_sector: per sector, 2010-2022 (lines 10-12) ----
import excel using "$B201_XLSX", sheet("t10_12_by_kbli2") firstrow clear
keep if period == "2010-2022" & !missing(d_ln_co2)
keep kbli2 d_ln_co2 scale_effect intensity_effect
export excel using "$B201_XLSX", sheet("fig10_12s_data", replace) firstrow(variables)
graph hbar (asis) scale_effect intensity_effect, ///
    over(kbli2, sort(d_ln_co2) descending label(labsize(vsmall))) ///
    legend(order(1 "Scale effect (VA)" 2 "Intensity effect (CO2/VA)") cols(1)) ///
    ytitle("Change in ln, 2010-2022") ///
    title("Scale vs intensity effect per sector, 2010-2022", size(medium)) ///
    note("Sorted by the total change in ln CO2. VA is nominal." ///
         "Sectors with no CO2 in 2010 or 2022 are left out.") ///
    graphregion(color(white) margin(l+2 r+4)) xsize(8) ysize(9)
graph export "$B201_OUT/fig10_12_by_sector.png", replace width(2000)
graph drop _all
