/*==========================================================================
  Line 12: "Elaborate bs dengan output stats/stylish facts dalam bentuk
           table atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_16_tables.xlsx. This
  file draws the charts FROM those tables (helper _charts.do), so a chart
  always matches its table. The exact points of every chart, and the label
  printed next to each point, are written to a sheet figNN_data.
  Runs LAST in 00_run.do.

  Charts (output/):
    fig01_energy_by_year.png       total GJ scope 1, scope 2, total, by year
    fig02_main_energy_source.png   % of firm-years per main energy source
    fig03_sector_share.png         share of all GJ per KBLI 2-digit
    fig04_tfp_quintiles.png        energy use by TFP quintile, 4 methods
    fig05_scale_quintiles.png      energy use by quintile of VA/worker, output, capital
    fig06_11_group_medians.png     median GJ by size, FDI, export, import, Java, R&D
    fig09_co2_per_gj.png           CO2 per GJ by year

  Chart rules (repo consensus): see _charts.do.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
global FIG_XLSX "$B16_XLSX"
global FIG_OUT  "$B16_OUT"
do "$B16/_charts.do"

* ---- fig01: energy use by year (line 1) ----
import excel using "$B16_XLSX", sheet("t01_totals") firstrow clear
drop if period == "pool"
generate year = real(period)
generate total_mgj = gj_total / 1e6
generate s1_mgj    = gj_s1 / 1e6
generate s2_mgj    = gj_s2 / 1e6
keep year total_mgj s1_mgj s2_mgj
ch_lines total_mgj s1_mgj s2_mgj, labels("Total" "Scope 1 (4 fuels)" "Scope 2 (purchased electricity)") fmt(%5.2f) ///
    ytitle("Million GJ (sum over firms)") title("Energy use of manufacturing firms") ///
    note("Notes: sum over firm-years in the file; energy reporting changes between 2015 and 2017 (questionnaire)." "$FIG_SRC") ///
    sheet(fig01_data) file(fig01_energy_by_year)

* ---- fig02: main energy source (line 2) ----
ch_shares, sheet(t02_main_src_share) title("Main energy source of firms (pooled)") ///
    note("Notes: main source = largest energy use (GJ). Sources marked 2020+ exist only on the 2020-2022 form." "$FIG_SRC") ///
    outsheet(fig02_data) file(fig02_main_energy_source)

* ---- fig03: sector share of energy use (line 3) ----
import excel using "$B16_XLSX", sheet("t03_kbli2_share") firstrow clear
keep if period == "pool"
gsort -share_of_gj_pct
generate order = _n
generate str16 lab = strtrim(string(share_of_gj_pct, "%4.1f"))
generate str16 sector = "KBLI " + string(kbli2)
keep order sector n_firms gj_total share_of_gj_pct lab
export excel using "$B16_XLSX", sheet("fig03_data", replace) firstrow(variables)
summarize share_of_gj_pct, meanonly
local hi = r(max) * 1.15
graph hbar (asis) share_of_gj_pct, over(sector, sort(order) label(labsize(vsmall))) ///
    bar(1, color("$C1")) blabel(bar, format(%4.1f) size(vsmall)) ///
    legend(on order(1 "% of all GJ (pooled)") size(small) region(lcolor(white))) ///
    ytitle("% of all GJ (scope 1 + 2)", size(small)) yscale(range(0 `hi')) ylabel(, labsize(small)) ///
    title("Which sectors use the energy? (pooled)", size(medsmall)) ///
    note("Notes: codes as reported; no bridge between classification versions." "$FIG_SRC", size(tiny)) ///
    scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(8)
graph export "$B16_OUT/fig03_sector_share.png", replace width(2200)

* ---- fig04: TFP quintiles (line 4) ----
tempfile stack
clear
save `stack', emptyok
foreach t in tfp_op tfp_lp tfp_acf tfp_wrdg {
    import excel using "$B16_XLSX", sheet("t04_by_`t'_q") firstrow clear
    keep if period == "pool" & variable == "ln_gj_total"
    generate quintile = real(substr(group, 2, 1))
    generate str8 method = "`t'"
    keep quintile method mean
    append using `stack'
    save `stack', replace
}
reshape wide mean, i(quintile) j(method) string
ch_qlines meantfp_op meantfp_lp meantfp_acf meantfp_wrdg, labels("OP" "LP" "ACF" "WRDG") fmt(%4.2f) ///
    ytitle("Mean ln GJ total") xtitle("TFP quintile (within year)") title("Energy use by TFP quintile (pooled)") ///
    note("Notes: TFP = block 0 nominal development residuals; OP has only 672 firm-years." "$FIG_SRC") ///
    sheet(fig04_data) file(fig04_tfp_quintiles)

* ---- fig05: productivity and scale quintiles (line 5) ----
clear
save `stack', emptyok replace
foreach v in va_pw output capital {
    import excel using "$B16_XLSX", sheet("t05_by_`v'_q") firstrow clear
    keep if period == "pool" & variable == "ln_gj_total"
    generate quintile = real(substr(group, 2, 1))
    drop if missing(quintile)                 // the "Zero or negative" group
    generate str8 measure = "`v'"
    keep quintile measure mean
    append using `stack'
    save `stack', replace
}
reshape wide mean, i(quintile) j(measure) string
ch_qlines meanva_pw meanoutput meancapital, labels("VA per worker" "Output" "Capital") fmt(%4.2f) ///
    ytitle("Mean ln GJ total") xtitle("Quintile (within year)") title("Energy use by productivity and scale quintile (pooled)") ///
    note("Notes: quintiles among firms with a positive value; nominal, masked values." ///
         "VA, output per worker and capital per worker are in the t05 sheets." "$FIG_SRC") ///
    sheet(fig05_data) file(fig05_scale_quintiles)

* ---- fig06_11: median energy use by group (lines 6, 7, 8, 10, 11) ----
clear
save `stack', emptyok replace
local k 0
foreach s in t06_by_large t07_by_fdi t08_by_exporter t08_by_importer t10_by_java t11_by_rnd {
    local ++k
    import excel using "$B16_XLSX", sheet("`s'") firstrow clear
    keep if period == "pool" & variable == "gj_total"
    generate table = `k'
    keep table group n p50
    append using `stack'
    save `stack', replace
}
sort table group
generate order = _n
rename p50 median_gj_total
generate str16 lab = strtrim(string(median_gj_total, "%9.0fc"))
export excel using "$B16_XLSX", sheet("fig06_11_data", replace) firstrow(variables)
summarize median_gj_total, meanonly
local hi = r(max) * 1.15
graph hbar (asis) median_gj_total, over(group, sort(order) label(labsize(vsmall))) ///
    bar(1, color("$C1")) blabel(bar, format(%9.0fc) size(vsmall)) ///
    legend(on order(1 "Median GJ per firm-year (pooled)") size(small) region(lcolor(white))) ///
    ytitle("Median GJ total", size(small)) yscale(range(0 `hi')) ylabel(, labsize(small) format(%9.0fc)) ///
    title("Median energy use by firm group (pooled)", size(medsmall)) ///
    note("Notes: FDI excludes 2020, exporter excludes 2022, R&D is 2017-2022 only." "$FIG_SRC", size(tiny)) ///
    scheme(s1color) graphregion(color(white)) plotregion(color(white)) xsize(7) ysize(6)
graph export "$B16_OUT/fig06_11_group_medians.png", replace width(2200)

* ---- fig09: CO2 per GJ by year (line 9) ----
import excel using "$B16_XLSX", sheet("t09_emissions_stats") firstrow clear
keep if variable == "co2_per_gj" & period != "pool"
generate year = real(period)
rename p50 median_co2_per_gj
rename mean mean_co2_per_gj
keep year median_co2_per_gj mean_co2_per_gj
ch_lines median_co2_per_gj mean_co2_per_gj, labels("Median" "Mean") fmt(%5.3f) ///
    ytitle("Tonnes CO2 per GJ") title("CO2 per unit of energy") ///
    note("Notes: scope 1 fuels + purchased electricity; moves with the fuel mix and the grid factor." "$FIG_SRC") ///
    sheet(fig09_data) file(fig09_co2_per_gj)

graph drop _all
display as result "Figures written to $FIG_OUT"
