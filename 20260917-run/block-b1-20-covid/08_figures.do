/*==========================================================================
  Line 8: "Elaborate bs dengan output stats/stylish facts dalam bentuk table
           atau dengan graph, atau table yg ready untuk dibuat graph"
  Every other file writes its tables to output/b1_20_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_before_after.png     median workers / VA / output, 2017-2022, 2019 = 100
    fig03_sector_change.png    % change in firms per sector, 2020 and 2021-22 vs 2017-19
    fig04_entry_exit.png       % new and % exit firms by year
    fig07_group_profile.png    FDI / import / export / large / Java: new, survivor, exit
    fig09_trajectories.png     the 2019 cohort by covid trajectory
    fig15_pre_covid.png        2019 characteristics by trajectory
    fig16_recovery.png         median workers and VA of the 2019 cohort, 2019 = 100
  Charts 04, 07, 09, 15 and 16 use FICTIONAL firm links in the development
  data: they only mean something on the real BPS data.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: before / after covid (line 2) ----
import excel using "$B20_XLSX", sheet("t02_by_period") firstrow clear
drop if year == "period"
destring year, replace
keep year med_workers med_va med_output
foreach v in med_workers med_va med_output {
    summarize `v' if year == 2019, meanonly
    generate idx_`v' = 100 * `v' / r(mean)
}
keep year idx_*
sort year
export excel using "$B20_XLSX", sheet("fig02_data", replace) firstrow(variables)
twoway (connected idx_med_workers year) ///
       (connected idx_med_va year, lpattern(dash)) ///
       (connected idx_med_output year, lpattern(shortdash)), ///
    xline(2019.5, lpattern(dash) lcolor(gs10)) yline(100, lcolor(gs12)) ///
    xlabel(2017(1)2022) xtitle("") ytitle("Median, 2019 = 100") ///
    legend(order(1 "Workers" 2 "Value added" 3 "Output") rows(1)) ///
    title("The median firm before and after covid") ///
    note("All firms in each year (no firm links). VA and output are nominal.") ///
    graphregion(color(white))
graph export "$B20_OUT/fig02_before_after.png", replace width(2000)

* ---- fig03: firms per sector (line 3) ----
import excel using "$B20_XLSX", sheet("t03_covid_change") firstrow clear
tostring kbli2, replace
* sectors with at least 20 firms a year before covid (small sectors swing a lot)
keep if firms_pre_avg >= 20
keep kbli2 firms_pre_avg pct_chg_2020 pct_chg_rec
export excel using "$B20_XLSX", sheet("fig03_data", replace) firstrow(variables)
graph hbar (asis) pct_chg_2020 pct_chg_rec, over(kbli2, sort(1) label(labsize(small))) ///
    ytitle("% change in number of firms vs 2017-19 average") ///
    legend(order(1 "2020" 2 "2021-22 average") rows(1)) ///
    title("Number of firms by sector (KBLI 2-digit)") ///
    note("Sectors with 20+ firms a year in 2017-19." "Survey counts, not closures.") ///
    graphregion(color(white)) ysize(6)
graph export "$B20_OUT/fig03_sector_change.png", replace width(2000)

* ---- fig04: entry and exit (lines 4-6) ----
import excel using "$B20_XLSX", sheet("t04_flows_by_year") firstrow clear
drop if period == "pool"
generate year = real(period)
keep year pct_new pct_survivor pct_exit
order year
export excel using "$B20_XLSX", sheet("fig04_data", replace) firstrow(variables)
twoway (connected pct_new year) (connected pct_exit year, lpattern(dash)), ///
    xline(2016, lpattern(dash) lcolor(gs10)) xline(2019.5, lcolor(cranberry)) ///
    xlabel(2010(2)2022) xtitle("") ytitle("% of the year's firms") ///
    legend(order(1 "New (not in previous year)" 2 "Exit (never seen again)") rows(1)) ///
    title("New and exiting firms by year") ///
    note("FICTIONAL firm links in the development data: only meaningful on the real data." ///
         "No 2016 wave (dashed line): 2017 new firms include any 2016 entrants.") ///
    graphregion(color(white))
graph export "$B20_OUT/fig04_entry_exit.png", replace width(2000)

* ---- fig07: who are the new, survivor and exit firms (line 7) ----
import excel using "$B20_XLSX", sheet("t07_profile") firstrow clear
keep if period == "pool"
keep firm_group pct_fdi pct_importer pct_exporter pct_large pct_java
generate order = _n
export excel using "$B20_XLSX", sheet("fig07_data", replace) firstrow(variables)
graph bar (asis) pct_fdi pct_importer pct_exporter pct_large pct_java, ///
    over(firm_group, sort(order)) ///
    ytitle("% of firms") ylabel(, angle(horizontal)) ///
    legend(order(1 "FDI" 2 "Importer" 3 "Exporter" 4 "Large (>100)" 5 "Java") rows(1) size(small)) ///
    title("Characteristics of new, survivor and exit firms") ///
    note("Pooled 2010-2022, each firm in its own year. FICTIONAL firm links in the development data.") ///
    graphregion(color(white))
graph export "$B20_OUT/fig07_group_profile.png", replace width(2000)

* ---- fig09: trajectories (lines 9-14) ----
import excel using "$B20_XLSX", sheet("t09_trajectories") firstrow clear
keep traj n_firms pct_of_cohort
generate order = _n
export excel using "$B20_XLSX", sheet("fig09_data", replace) firstrow(variables)
graph hbar (asis) pct_of_cohort, over(traj, sort(order) label(labsize(small))) ///
    blabel(bar, format(%4.1f)) ytitle("% of firms present in 2019") ///
    title("What happened to the 2019 firms?") ///
    note("Size = workers, 2019 vs 2022." "FICTIONAL firm links in the development data. The group 'disappear temporarily'" "is empty because the simulated links have no gaps.", size(small)) ///
    graphregion(color(white)) xsize(9) ysize(6)
graph export "$B20_OUT/fig09_trajectories.png", replace width(2000)

* ---- fig15: pre-covid characteristics by trajectory (line 15) ----
import excel using "$B20_XLSX", sheet("t15_profile") firstrow clear
keep traj pct_exporter pct_importer pct_fdi pct_large pct_java pct_owngen
generate order = _n
export excel using "$B20_XLSX", sheet("fig15_data", replace) firstrow(variables)
graph hbar (asis) pct_exporter pct_importer pct_fdi pct_large pct_owngen, ///
    over(traj, sort(order) label(labsize(small))) ///
    ytitle("% of the group's firms, in 2019") ///
    legend(order(1 "Exporter" 2 "Importer" 3 "FDI" 4 "Large (>100)" 5 "Own generation") ///
           rows(2) size(small)) ///
    title("Pre-covid (2019) characteristics", size(medium)) ///
    note("FICTIONAL firm links in the development data:" "only meaningful on the real data.", size(small)) ///
    graphregion(color(white) margin(l+4 r+4)) xsize(11) ysize(7)
graph export "$B20_OUT/fig15_pre_covid.png", replace width(2000)

* ---- fig16: following the 2019 cohort (line 16) ----
import excel using "$B20_XLSX", sheet("t16_index") firstrow clear
generate key = ""
replace key = "all"    if traj == "All 2019 cohort"
replace key = "shrink" if traj == "Survive but shrink"
replace key = "grow"   if traj == "Survive and grow"
keep if key != ""
keep year key idx_med_workers idx_med_va
reshape wide idx_med_workers idx_med_va, i(year) j(key) string
order year idx_med_workers* idx_med_va*
export excel using "$B20_XLSX", sheet("fig16_data", replace) firstrow(variables)
twoway (connected idx_med_workersall year) (connected idx_med_workersshrink year, lpattern(dash)) ///
       (connected idx_med_workersgrow year, lpattern(shortdash)), ///
    xline(2019.5, lcolor(cranberry)) yline(100, lcolor(gs12)) xlabel(2017(1)2022) xtitle("") ///
    ytitle("Median, 2019 = 100") legend(order(1 "All 2019 firms" 2 "Survive but shrink" 3 "Survive and grow") rows(1) size(small)) ///
    title("Workers") graphregion(color(white)) name(g1, replace)
twoway (connected idx_med_vaall year) (connected idx_med_vashrink year, lpattern(dash)) ///
       (connected idx_med_vagrow year, lpattern(shortdash)), ///
    xline(2019.5, lcolor(cranberry)) yline(100, lcolor(gs12)) xlabel(2017(1)2022) xtitle("") ///
    ytitle("Median, 2019 = 100") legend(order(1 "All 2019 firms" 2 "Survive but shrink" 3 "Survive and grow") rows(1) size(small)) ///
    title("Value added (nominal)") graphregion(color(white)) name(g2, replace)
graph combine g1 g2, cols(2) title("Following the 2019 firms to 2022") ///
    note("FICTIONAL firm links in the development data: only meaningful on the real data.") ///
    graphregion(color(white)) xsize(10) ysize(4.5)
graph export "$B20_OUT/fig16_recovery.png", replace width(2400)
graph drop _all
