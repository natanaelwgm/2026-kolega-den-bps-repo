/*==========================================================================
  Line 5 (added, the row has no figures line): charts for lines 2-4
  Every other file writes its tables to output/b1_21b_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_region_share.png      % of export value by destination region,
                                pool / 2021 / 2022
    fig02_region_by_sector.png  region mix of export value per KBLI 2-digit
                                (pool, sectors with 10+ exporting firms)
    fig03_n_destinations.png    % of exporting firms by number of destinations
    fig04_eu_efta_vs_other.png  median size, VA per worker, CO2/VA and GJ/VA
                                of SI firms, EU+EFTA vs other markets
==========================================================================*/
if "$B21B" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: region shares (line 2) ----
import excel using "$B21B_XLSX", sheet("t02_region_share") firstrow clear
keep region period share_value_pct
replace period = "y" + period if period != "pool"
reshape wide share_value_pct, i(region) j(period) string
rename share_value_pct* share_*
* keep the region order of the to-do line
generate order = 1
local i 0
foreach r in EU US China ASEAN Japan India Others {
    local ++i
    replace order = `i' if region == "`r'"
}
sort order
drop order
order region share_pool share_y2021 share_y2022
export excel using "$B21B_XLSX", sheet("fig02_data", replace) firstrow(variables)
generate order = _n
graph hbar (asis) share_pool share_y2021 share_y2022, over(region, sort(order)) ///
    bar(1, color(navy)) bar(2, color(eltblue)) bar(3, color(orange)) ///
    ytitle("% of export value with a named destination") ///
    legend(order(1 "2021-2022 pooled" 2 "2021" 3 "2022") rows(1)) ///
    title("Where do exports go?") ///
    subtitle("Main destination of each exported product, Proman roster") ///
    note("Others includes Australia, Korea, Taiwan, UK, Middle East and the BPS 'other' aggregates.") ///
    graphregion(color(white))
graph export "$B21B_OUT/fig02_region_share.png", replace width(2000)

* ---- fig02b: region mix by sector (line 2) ----
import excel using "$B21B_XLSX", sheet("t02_region_by_kbli2") firstrow clear
keep if period == "pool"
bysort kbli2: egen sector_firms = total(n_firms)   // firm x region count; used only to drop tiny sectors
keep kbli2 region share_in_sector_pct sector_firms
reshape wide share_in_sector_pct, i(kbli2 sector_firms) j(region) string
rename share_in_sector_pct* *
foreach r in EU US China ASEAN Japan India Others {
    capture generate `r' = 0
    replace `r' = 0 if missing(`r')
}
keep if sector_firms >= 10
drop sector_firms
order kbli2 EU US China ASEAN Japan India Others
export excel using "$B21B_XLSX", sheet("fig02b_data", replace) firstrow(variables)
graph hbar (asis) EU US China ASEAN Japan India Others, over(kbli2, label(labsize(small))) stack ///
    bar(1, color(navy)) bar(2, color(maroon)) bar(3, color(red)) bar(4, color(forest_green)) ///
    bar(5, color(orange)) bar(6, color(gold)) bar(7, color(gs11)) ///
    ytitle("% of the sector's export value") ///
    legend(order(1 "EU" 2 "US" 3 "China" 4 "ASEAN" 5 "Japan" 6 "India" 7 "Others") rows(2) size(small) symxsize(4)) ///
    title("Destination mix by sector (KBLI 2-digit)") ///
    subtitle("2021-2022 pooled; sectors with 10+ firm-region pairs") ///
    graphregion(color(white)) xsize(7) ysize(7)
graph export "$B21B_OUT/fig02_region_by_sector.png", replace width(2000)

* ---- fig03: number of destinations (line 3) ----
import excel using "$B21B_XLSX", sheet("t03_ndest_dist") firstrow clear
keep ndest_group period pct_firms
replace period = "y" + period if period != "pool"
reshape wide pct_firms, i(ndest_group) j(period) string
rename pct_firms* pct_*
generate order = real(substr(ndest_group, 1, 1))
sort order
drop order
order ndest_group pct_pool pct_y2021 pct_y2022
export excel using "$B21B_XLSX", sheet("fig03_data", replace) firstrow(variables)
graph bar (asis) pct_y2021 pct_y2022, over(ndest_group) ///
    bar(1, color(eltblue)) bar(2, color(orange)) ///
    b1title("Number of destination countries") ytitle("% of exporting firms") ///
    legend(order(1 "2021" 2 "2022") rows(1)) ///
    title("How many destinations does a firm export to?") ///
    note("Firm = year x province x KBLI5 cell (Kipb masked). One main destination per product.") ///
    graphregion(color(white))
graph export "$B21B_OUT/fig03_n_destinations.png", replace width(2000)

* ---- fig04: EU+EFTA vs other markets (line 4) ----
import excel using "$B21B_XLSX", sheet("t04_si_char") firstrow clear
keep if period == "pool" & inlist(variable, "workers", "va_pw", "co2_per_va", "gj_per_va")
keep variable group p50
* graph-ready sheet: 1 row per variable, 1 column per group
preserve
replace group = cond(group == "EU+EFTA", "eu_efta", "other")
reshape wide p50, i(variable) j(group) string
rename p50* median_*
export excel using "$B21B_XLSX", sheet("fig04_data", replace) firstrow(variables)
restore
replace group = "Other only" if group != "EU+EFTA"
local n 0
foreach v in workers va_pw co2_per_va gj_per_va {
    local ++n
    if "`v'" == "workers"    local t "Workers"
    if "`v'" == "va_pw"      local t "VA per worker"
    if "`v'" == "co2_per_va" local t "CO2 per VA"
    if "`v'" == "gj_per_va"  local t "GJ per VA"
    graph bar (asis) p50 if variable == "`v'", over(group) ///
        bar(1, color(navy)) ylabel(, angle(0) labsize(small) format(%9.2g)) ytitle("") ///
        title("`t'", size(medium)) graphregion(color(white)) name(g`n', replace)
}
graph combine g1 g2 g3 g4, cols(2) ///
    title("Exporting to EU+EFTA vs other markets only") ///
    subtitle("SI firms in the exporting cells, medians, 2021-2022 pooled") ///
    note("SI merged on year x province x KBLI5. Values nominal and masked.") ///
    graphregion(color(white)) xsize(8) ysize(7)
graph export "$B21B_OUT/fig04_eu_efta_vs_other.png", replace width(2000)
graph drop _all
