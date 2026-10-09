/*==========================================================================
  Line 11 (no figures line in the to-do; added for every block)
  Every other file writes its tables to output/b2_07_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_groups_by_year.png     clean firms per group by year, incl. not classified
    fig09_shares.png             each group's share of firms, workers, VA,
                                 output, energy and CO2 (pooled)
    fig10_productivity.png       median TFP (LP), energy productivity and
                                 carbon productivity by group (pooled)
==========================================================================*/
if "$B207" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: firms per group, by year (lines 2-8) ----
import excel using "$B207_XLSX", sheet("t02_counts") firstrow clear
drop if period == "pool"
generate year = real(period)
generate code = real(substr(group7, 1, 1))
replace  code = 0 if group7 == "Not classified"
keep year code n_firms
reshape wide n_firms, i(year) j(code)
rename n_firms0 n_not_classified
forvalues g = 1/7 {
    capture generate n_firms`g' = 0          // a group with no firm that year
    replace n_firms`g' = 0 if missing(n_firms`g')
    rename n_firms`g' n_g`g'
}
replace n_not_classified = 0 if missing(n_not_classified)
order year n_g1 n_g2 n_g3 n_g4 n_g5 n_g6 n_g7 n_not_classified
export excel using "$B207_XLSX", sheet("fig02_data", replace) firstrow(variables)
graph bar (asis) n_g1 n_g2 n_g3 n_g4 n_g5 n_g6 n_g7 n_not_classified, ///
    over(year, label(labsize(small))) stack ///
    bar(8, color(gs13)) ytitle("Number of firms (clean)", size(small) margin(r=4)) ylabel(, angle(0) format(%9.0fc) labsize(small)) ///
    legend(order(1 "1 Domestic only" 2 "2 Exporter only" 3 "3 Importer only" ///
                 4 "4 Exporter + importer" 5 "5 FDI, domestic market" 6 "6 FDI, exporter" ///
                 7 "7 FDI, exporter + importer" 8 "Not classified") cols(2) size(small)) ///
    title("Internationalisation gradient: firms per group") ///
    note("2020: FDI missing; 2022: export flag missing, so no firm can be classified." ///
         "Other years: firms with a missing export or import answer are not classified." ///
         "There is no 2016 survey; the import question changes between 2015 and 2017.", size(small)) graphregion(color(white))
graph export "$B207_OUT/fig02_groups_by_year.png", replace width(2000)

* ---- fig09: shares by group, pooled (line 9) ----
import excel using "$B207_XLSX", sheet("t09_shares") firstrow clear
keep if period == "pool"
keep group7 sh_firms sh_workers sh_va sh_output sh_gj_total sh_co2_total
export excel using "$B207_XLSX", sheet("fig09_data", replace) firstrow(variables)
graph hbar (asis) sh_firms sh_workers sh_va sh_output sh_gj_total sh_co2_total, ///
    over(group7, label(labsize(small))) ///
    ytitle("% of the classified firms' total") ///
    legend(order(1 "Firms" 2 "Workers" 3 "Value added" 4 "Output" 5 "Energy (GJ)" 6 "CO2") ///
           rows(2) size(small)) ///
    title("Share of each group (pooled)", size(medium)) ///
    subtitle("Pooled: 2010-2015, 2017-2019, 2021 (the years that can be classified)", size(small)) ///
    note("Denominator: clean, classified firms (groups 1-7). VA and output nominal.", size(small)) ///
    graphregion(color(white)) xsize(9) ysize(7)
graph export "$B207_OUT/fig09_shares.png", replace width(2000)

* ---- fig10: productivity by group, pooled (line 10) ----
import excel using "$B207_XLSX", sheet("t10_medians") firstrow clear
keep if period == "pool"
keep group7 n_firms med_tfp_lp med_va_per_gj med_va_per_co2
export excel using "$B207_XLSX", sheet("fig10_data", replace) firstrow(variables)
graph hbar (asis) med_tfp_lp, over(group7, label(labsize(small))) ///
    ytitle("Median TFP (LP, log residual)") title("TFP (LP)") ///
    graphregion(color(white)) name(g1, replace)
graph hbar (asis) med_va_per_gj, over(group7, label(labsize(small))) ///
    ytitle("Median VA per GJ") title("Energy productivity") ///
    graphregion(color(white)) name(g2, replace)
graph hbar (asis) med_va_per_co2, over(group7, label(labsize(small))) ///
    ytitle("Median VA per tonne CO2") title("Carbon productivity") ///
    graphregion(color(white)) name(g3, replace)
graph combine g1 g2 g3, cols(3) ///
    title("Productivity along the internationalisation gradient (pooled medians)") ///
    note("Clean, classified firms; 2020 and 2022 cannot be classified. VA nominal." ///
         "Other TFP methods (OP, ACF, Wooldridge): see sheet t10_medians.") ///
    graphregion(color(white)) xsize(12) ysize(4.5)
graph export "$B207_OUT/fig10_productivity.png", replace width(2400)
graph drop _all
