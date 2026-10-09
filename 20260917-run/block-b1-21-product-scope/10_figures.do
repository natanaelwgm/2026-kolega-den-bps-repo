/*==========================================================================
  Figures (no figures line in this row; added as the line after the last)
  Every other file writes its tables to output/b1_21_tables.xlsx. This file
  draws the charts FROM those tables, so a chart always matches its table.
  The exact points of every chart are also written to a sheet figNN_data
  (graph-ready, e.g. to redraw the chart in Excel or PowerPoint).
  Runs LAST in 00_run.do.

  Charts (output/):
    fig02_n_products.png    % of firms by number of products, 2021 vs 2022
    fig04_entry_exit.png    continuing firms by product entry/exit status
    fig05_core_share.png    % of firms by core-product share, 2021 vs 2022
    fig06_export_share.png  exported product lines by export share
    fig07_destinations.png  top 10 destinations by export value
    fig08_compare.png       n products, HHI, core share: internationalised
                            vs comparison firms
  Roster data: 2021-2022 only, firm = cell (province x KBLI5) while Kipb
  is masked.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- fig02: number of products (line 2) ----
import excel using "$B21_XLSX", sheet("t02_dist") firstrow clear
keep if period != "pool"
keep period n_products pct_firms
generate ord = _n
bysort n_products (ord): replace ord = ord[1]
reshape wide pct_firms, i(n_products ord) j(period) string
sort ord
rename pct_firms* pct_firms_*
export excel using "$B21_XLSX", sheet("fig02_data", replace) firstrow(variables)
graph bar (asis) pct_firms_2021 pct_firms_2022, over(n_products, sort(ord)) ///
    legend(order(1 "2021" 2 "2022")) ytitle("% of firms") b1title("Number of products") ///
    title("How many products does a firm make?") ///
    note("Proman roster. Firm = province x KBLI5 cell while Kipb is masked.") ///
    graphregion(color(white))
graph export "$B21_OUT/fig02_n_products.png", replace width(2000)

* ---- fig04: product entry and exit (line 4) ----
import excel using "$B21_XLSX", sheet("t04_status") firstrow clear
keep status n_firms pct_firms
generate ord = _n
export excel using "$B21_XLSX", sheet("fig04_data", replace) firstrow(variables)
graph hbar (asis) pct_firms, over(status, sort(ord)) ///
    ytitle("% of continuing firms") ///
    title("Product entry and exit, 2021 to 2022") ///
    note("Products by KBKI code. Firm = province x KBLI5 cell while Kipb is masked:" ///
         "plants entering or leaving a cell also count as entry/exit.") ///
    graphregion(color(white))
graph export "$B21_OUT/fig04_entry_exit.png", replace width(2000)

* ---- fig05: core product share (line 5) ----
import excel using "$B21_XLSX", sheet("t05_core_bins") firstrow clear
keep if period != "pool"
keep period core_bin pct_firms
generate ord = _n
bysort core_bin (ord): replace ord = ord[1]
reshape wide pct_firms, i(core_bin ord) j(period) string
sort ord
rename pct_firms* pct_firms_*
export excel using "$B21_XLSX", sheet("fig05_data", replace) firstrow(variables)
graph bar (asis) pct_firms_2021 pct_firms_2022, over(core_bin, sort(ord)) ///
    legend(order(1 "2021" 2 "2022")) ytitle("% of firms") ///
    b1title("Largest product's share of production value") ///
    title("How important is the core product?") ///
    note("Proman roster. Firm = province x KBLI5 cell while Kipb is masked.") ///
    graphregion(color(white))
graph export "$B21_OUT/fig05_core_share.png", replace width(2000)

* ---- fig06: export share per product (line 6) ----
import excel using "$B21_XLSX", sheet("t06_share_bins") firstrow clear
keep if period != "pool"
keep period share_bin pct_lines
generate ord = _n
bysort share_bin (ord): replace ord = ord[1]
reshape wide pct_lines, i(share_bin ord) j(period) string
sort ord
rename pct_lines* pct_lines_*
export excel using "$B21_XLSX", sheet("fig06_data", replace) firstrow(variables)
graph bar (asis) pct_lines_2021 pct_lines_2022, over(share_bin, sort(ord)) ///
    legend(order(1 "2021" 2 "2022")) ytitle("% of exported product lines") ///
    b1title("Share of the product's production that is exported") ///
    title("Export share per product (exported products only)") ///
    graphregion(color(white))
graph export "$B21_OUT/fig06_export_share.png", replace width(2000)

* ---- fig07: export destinations (line 7) ----
import excel using "$B21_XLSX", sheet("t07_dest") firstrow clear
keep if period == "pool"
gsort -share_pct
keep in 1/10
keep dest_name share_pct val_export n_lines
export excel using "$B21_XLSX", sheet("fig07_data", replace) firstrow(variables)
graph hbar (asis) share_pct, over(dest_name, sort(1) descending label(labsize(small))) ///
    ytitle("% of export value (2021-2022)") ///
    title("Main export destinations") ///
    note("Main destination of each exported product line." ///
         "Lines without a destination are left out.") ///
    graphregion(color(white))
graph export "$B21_OUT/fig07_destinations.png", replace width(2000)

* ---- fig08: internationalised vs other firms (lines 8-9) ----
import excel using "$B21_XLSX", sheet("t09_synthesis") firstrow clear
keep if substr(evidence, 1, 7) == "Lines 2" & inlist(variable, "n_products", "hhi", "core_share")
keep comparison variable mean_0 mean_1
sort variable comparison
export excel using "$B21_XLSX", sheet("fig08_data", replace) firstrow(variables)
local i 0
foreach v in n_products hhi core_share {
    local ++i
    if "`v'" == "n_products" local t "Number of products"
    if "`v'" == "hhi"        local t "Product HHI (0-1)"
    if "`v'" == "core_share" local t "Core product share (0-1)"
    graph hbar (asis) mean_0 mean_1 if variable == "`v'", over(comparison) ///
        bar(1, color(gs11)) bar(2, color(navy)) legend(off) ///
        ytitle("Mean, 2021-2022 pooled") title("`t'") graphregion(color(white)) name(g`i', replace)
}
graph combine g1 g2 g3, cols(3) ///
    title("Do internationalised firms produce differently?") ///
    note("Grey bar = non-exporter / non-importer / domestic; blue bar = exporter / importer / FDI." ///
         "Proman roster; importer and FDI status from the SI plants in the same province x KBLI5 cell.") ///
    graphregion(color(white)) xsize(12) ysize(4.5)
graph export "$B21_OUT/fig08_compare.png", replace width(2400)
graph drop _all
