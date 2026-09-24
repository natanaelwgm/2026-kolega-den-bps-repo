/*==========================================================================
  R1-01  Each survey year, what share of firms export, import, or have a
         foreign owner - and how many firms are in, not in, or of unknown
         status for each group? Every later R1 comparison rests on these counts.
  Answers Deasy R1: "Do they adjust their energi use, emisi, dan juga
         internationalization strategy-nya?" and the per-year groups of
         "Matching per year: export vs non export, import vs non import,
         fdi vs non fdi".
  Output : figures/01_group_shares_support.png (+ .pdf)
           tables/01_group_shares_support.csv  (numbers in the figure; foreign
                                              ownership drawn at 10% or more)
           tables/01_group_support_cells.csv   (support counts for later files)
  Development data - obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
args data_arg outdir_arg        // optional: 00_run.do passes the two paths
clear all
set more off
set varabbrev off
set linesize 120

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r1-paris-internationalisation"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/01_group_shares_support.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-01] STARTING: share of firms that export, import or have foreign owners, by year ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta. There is no 2016 annual file."

*---------------------------------------------------------------------------
display "Step 1/5: load the status flags and the fields later exhibits divide by"
*---------------------------------------------------------------------------
* export_flag        = any export activity (1 yes, 0 no, missing = unknown)
* export_direct_flag = direct exports; asked only in 2022
* import_flag        = imports reported above zero (never missing)
* fdi_any_flag       = any foreign ownership (> 0%); fdi_10_flag = 10% or more
use firm_id year export_flag export_direct_flag import_flag fdi_any_flag fdi_10_flag ///
    foreign_ownership_pct value_added_nominal total_gj_s1 gj_fuel_s1 gj_electricity ///
    co2_total_s1 co2_scope1_s1 co2_scope2_s1 elec_owngen_kwh using "$DATA", clear
isid firm_id year
local N_all = _N                  // number of firm-year records in the file
assert year != 2016
assert value_added_nominal > 0
assert !missing(import_flag)
assert fdi_any_flag == (foreign_ownership_pct > 0) if !missing(fdi_any_flag)
foreach v in export_flag export_direct_flag import_flag fdi_any_flag fdi_10_flag {
    assert inlist(`v', 0, 1, .)
}

* Positive-value markers: later exhibits divide by these, so they need them above zero.
gen byte one                 = 1
gen byte va_pos              = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte energy_total_pos    = total_gj_s1    > 0 & !missing(total_gj_s1)
gen byte energy_scope1_pos   = gj_fuel_s1     > 0 & !missing(gj_fuel_s1)
gen byte energy_scope2_pos   = gj_electricity > 0 & !missing(gj_electricity)
gen byte co2_total_pos       = co2_total_s1   > 0 & !missing(co2_total_s1)
gen byte co2_scope1_pos      = co2_scope1_s1  > 0 & !missing(co2_scope1_s1)
gen byte co2_scope2_pos      = co2_scope2_s1  > 0 & !missing(co2_scope2_s1)
gen byte selfgen_known       = !missing(elec_owngen_kwh)
gen byte selfgen_pos         = elec_owngen_kwh > 0 & !missing(elec_owngen_kwh)
tempfile base cells
save `base'

*---------------------------------------------------------------------------
display "Step 2/5: count firms in / not in / unknown for each group and year"
*---------------------------------------------------------------------------
* status_code: 1 = in the group, 0 = not in the group, 9 = unknown (never read as 0)
local first 1
foreach m in export_any export_direct import fdi_any fdi_10 {
    use `base', clear
    if "`m'" == "export_any"    local v export_flag
    if "`m'" == "export_direct" local v export_direct_flag
    if "`m'" == "import"        local v import_flag
    if "`m'" == "fdi_any"       local v fdi_any_flag
    if "`m'" == "fdi_10"        local v fdi_10_flag
    if "`m'" == "export_direct" keep if year == 2022      // the question exists only in 2022
    gen byte status_code = `v'
    replace status_code = 9 if missing(`v')
    levelsof year, local(yrs)
    collapse (sum) n_firms = one n_va_pos = va_pos ///
        n_energy_total_pos = energy_total_pos n_energy_scope1_pos = energy_scope1_pos ///
        n_energy_scope2_pos = energy_scope2_pos n_co2_total_pos = co2_total_pos ///
        n_co2_scope1_pos = co2_scope1_pos n_co2_scope2_pos = co2_scope2_pos ///
        n_selfgen_known = selfgen_known n_selfgen_pos = selfgen_pos, by(year status_code)
    * Make sure all three status rows exist for every year (an empty group shows as 0).
    tempfile col
    save `col'
    clear
    local ny : word count `yrs'
    set obs `=3 * `ny''
    gen int year = real(word("`yrs'", ceil(_n / 3)))
    gen byte status_code = cond(mod(_n, 3) == 1, 1, cond(mod(_n, 3) == 2, 0, 9))
    merge 1:1 year status_code using `col', nogenerate
    foreach c of varlist n_* {
        replace `c' = 0 if missing(`c')
    }
    gen str13 measure = "`m'"
    if !`first' append using `cells'
    save `cells', replace
    local first 0
}

* Plain labels for each status row.
gen str24 status_label = "Unknown" if status_code == 9
replace status_label = cond(status_code == 1, "Exporter", "Non-exporter")                   if measure == "export_any"    & status_code != 9
replace status_label = cond(status_code == 1, "Direct exporter", "No direct exports")        if measure == "export_direct" & status_code != 9
replace status_label = cond(status_code == 1, "Importer", "Non-importer")                   if measure == "import"        & status_code != 9
replace status_label = cond(status_code == 1, "Foreign-owned", "No foreign owner")          if measure == "fdi_any"       & status_code != 9
replace status_label = cond(status_code == 1, "Foreign share 10%+", "Foreign share under 10%") if measure == "fdi_10"      & status_code != 9
gen byte morder = 1*(measure == "export_any") + 2*(measure == "export_direct") + 3*(measure == "import") ///
                + 4*(measure == "fdi_any") + 5*(measure == "fdi_10")
gen byte sorder = 1*(status_code == 1) + 2*(status_code == 0) + 3*(status_code == 9)
sort morder year sorder
foreach c of varlist n_* {
    assert `c' <= n_firms
}
order measure year status_code status_label n_firms n_va_pos n_energy_total_pos n_energy_scope1_pos ///
      n_energy_scope2_pos n_co2_total_pos n_co2_scope1_pos n_co2_scope2_pos n_selfgen_known n_selfgen_pos
format n_* %9.0f
export delimited measure-n_selfgen_pos using "tables/01_group_support_cells.csv", datafmt replace

*---------------------------------------------------------------------------
display "Step 3/5: shares by year -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
keep measure morder year status_code n_firms
reshape wide n_firms, i(measure morder year) j(status_code)
rename (n_firms1 n_firms0 n_firms9) (n_in_group n_not_in_group n_unknown)
gen long firms_in_year = n_in_group + n_not_in_group + n_unknown
gen long n_known       = n_in_group + n_not_in_group
* Per measure, all records are counted exactly once (export_direct: 2022 only).
bysort measure: egen long tot = total(firms_in_year)
assert tot == `N_all' if measure != "export_direct"     // every firm-year record counted once
drop tot
* Share among firms whose status is known; blank when one of the two groups is empty.
gen double share_in_group_pct = 100 * n_in_group / n_known if n_in_group > 0 & n_not_in_group > 0
gen double unknown_pct        = 100 * n_unknown / firms_in_year
gen byte plotted = inlist(measure, "export_any", "import", "fdi_10")   // foreign ownership: 10% or more, as in R2 and the previous paper

* 2016: one explicit empty row per yearly measure (no annual file), never zeros.
preserve
keep if measure != "export_direct"
bysort measure: keep if _n == 1
keep measure morder plotted
gen int year = 2016
tempfile y2016
save `y2016'
restore
append using `y2016'

gen str60 note = ""
replace note = "No annual file" if year == 2016
replace note = "No firm known to be a non-exporter: share not computed" if measure == "export_any" & year == 2022
replace note = "2022 form asks only about direct exports" if measure == "export_direct"
replace note = "Possible recording change: jump from 2015" if measure == "import" & year == 2017
replace note = "Possible recording change: one-year spike" if inlist(measure, "fdi_any", "fdi_10") & year == 2020
replace note = "Ownership unknown for some firms" if inlist(measure, "fdi_any", "fdi_10") & year == 2021
gen str60 measure_label = ""
replace measure_label = "Firms with any exports"              if measure == "export_any"
replace measure_label = "Firms with direct exports (2022 only)" if measure == "export_direct"
replace measure_label = "Firms that report any imports"       if measure == "import"
replace measure_label = "Firms with any foreign ownership"    if measure == "fdi_any"
replace measure_label = "Firms with foreign ownership of 10% or more" if measure == "fdi_10"
gen str20 source_variable = ""
replace source_variable = "export_flag"        if measure == "export_any"
replace source_variable = "export_direct_flag" if measure == "export_direct"
replace source_variable = "import_flag"        if measure == "import"
replace source_variable = "fdi_any_flag"       if measure == "fdi_any"
replace source_variable = "fdi_10_flag"        if measure == "fdi_10"
sort morder year
order measure measure_label source_variable year firms_in_year n_in_group n_not_in_group n_unknown n_known ///
      share_in_group_pct unknown_pct plotted note
format firms_in_year n_in_group n_not_in_group n_unknown n_known %9.0f
format share_in_group_pct unknown_pct %6.2f
export delimited measure-note using "tables/01_group_shares_support.csv", datafmt replace

display "   Shares not computed (one group empty), outside 2016:"
list measure year n_in_group n_not_in_group n_unknown if missing(share_in_group_pct) & year != 2016, noobs sep(0)
* Smallest group sizes behind the plotted shares (later comparisons rest on these).
quietly summarize n_in_group if plotted & !missing(share_in_group_pct)
display "   Smallest in-group count over plotted cells: " r(min)
if r(min) < 30 display as error "   WARNING: an in-group cell has fewer than 30 firms"
quietly summarize n_not_in_group if plotted & !missing(share_in_group_pct)
display "   Smallest not-in-group count over plotted cells: " r(min)
if r(min) < 30 display as error "   WARNING: a not-in-group cell has fewer than 30 firms"

*---------------------------------------------------------------------------
display "Step 4/5: numbers for the notes and the log (read from the table, never typed)"
*---------------------------------------------------------------------------
quietly summarize unknown_pct if measure == "export_any" & year <= 2021
local exu_lo : display %4.1f r(min)
local exu_hi : display %4.1f r(max)
foreach s in in_group not_in_group unknown {
    quietly summarize n_`s' if measure == "export_direct" & year == 2022
    local dx_`s' : display %9.0fc r(sum)
    local dx_`s' = strtrim("`dx_`s''")
}
quietly summarize share_in_group_pct if measure == "import" & year == 2015
local im15 : display %4.1f r(mean)
quietly summarize share_in_group_pct if measure == "import" & year == 2017
local im17 : display %4.1f r(mean)
quietly summarize share_in_group_pct if measure == "fdi_10" & year == 2020
local fd20 : display %4.1f r(mean)
quietly summarize share_in_group_pct if measure == "fdi_10" & year != 2020
local fd_lo : display %4.1f r(min)
local fd_hi : display %4.1f r(max)
quietly summarize n_unknown if measure == "fdi_10" & year == 2021
local fdu21 : display %9.0fc r(sum)
foreach l in exu_lo exu_hi im15 im17 fd20 fd_lo fd_hi fdu21 {
    local `l' = strtrim("``l''")
}
* Only the export-unknown range is quoted in the notes; the rest are logged for reference.
display "   2022 direct exports: `dx_in_group' yes, `dx_not_in_group' no, `dx_unknown' unknown"
display "   Import share: `im15'% in 2015, `im17'% in 2017"
display "   Foreign-owned (10%+) share: `fd20'% in 2020, `fd_lo'-`fd_hi'% in other years; unknown in 2021: `fdu21' firms"

*---------------------------------------------------------------------------
display "Step 5/5: draw three small panels on one shared 0-100 scale"
*---------------------------------------------------------------------------
keep if plotted
gen byte panel = 1*(measure == "export_any") + 2*(measure == "import") + 3*(measure == "fdi_10")
label define panel 1 "(a) Exporters: firms with any exports" ///
                   2 "(b) Importers: firms that report any imports" ///
                   3 "(c) Foreign-owned: firms with 10% or more foreign ownership"
label values panel panel
sort panel year

* Endpoint labels: first and last year with a share (same variable that is drawn).
bysort panel: egen fy = min(cond(!missing(share_in_group_pct), year, .))
bysort panel: egen ly = max(cond(!missing(share_in_group_pct), year, .))
gen str8 lab_first = string(share_in_group_pct, "%4.1f") if year == fy
gen str8 lab_last  = string(share_in_group_pct, "%4.1f") if year == ly

* Count rows printed under each panel: in group / not in group / unknown.
gen double y_r1 = -13
gen double y_r2 = -24
gen double y_r3 = -35
gen str8 s_in  = string(n_in_group,     "%9.0fc") if !missing(n_in_group)
gen str8 s_out = string(n_not_in_group, "%9.0fc") if !missing(n_not_in_group)
gen str8 s_unk = string(n_unknown,      "%9.0fc") if !missing(n_unknown)
gen double xh = 2009.5 if year == 2010
gen str20 h1 = cond(panel == 1, "Exporters",     cond(panel == 2, "Importers",     "Foreign-owned"))    if year == 2010
gen str24 h2 = cond(panel == 1, "Non-exporters", cond(panel == 2, "Non-importers", "Under 10% foreign")) if year == 2010
gen str20 h3 = "Unknown" if year == 2010

* Short in-panel pointers to the data breaks explained in the notes.
gen str45 ann = ""
gen double ann_x = .
gen double ann_y = .
gen byte ann_pos = .
replace ann = "No 2022 share: see Notes"            if panel == 1 & year == 2022
replace ann_x = 2022.4 if panel == 1 & year == 2022
replace ann_y = 45     if panel == 1 & year == 2022
replace ann_pos = 9    if panel == 1 & year == 2022
replace ann = "2017 jump: possible recording change" if panel == 2 & year == 2017
replace ann_x = 2017   if panel == 2 & year == 2017
replace ann_y = 82     if panel == 2 & year == 2017
replace ann_pos = 3    if panel == 2 & year == 2017
replace ann = "2020 spike: possible recording change" if panel == 3 & year == 2020
replace ann_x = 2020   if panel == 3 & year == 2020
replace ann_y = 64     if panel == 3 & year == 2020
replace ann_pos = 0    if panel == 3 & year == 2020

gen double band_hi = 100 if year == 2016          // "No annual file" band
gen double band_lo = -40 if year == 2016

twoway ///
    (rbar band_hi band_lo year, barwidth(0.8) fcolor(gs15) lcolor(gs15) lwidth(none)) ///
    (connected share_in_group_pct year, cmissing(n) lcolor(black) lwidth(medthin) lpattern(solid) ///
        msymbol(O) msize(small) mcolor(black)) ///
    (scatter share_in_group_pct year if lab_first != "", msymbol(none) mlabel(lab_first) mlabpos(9) ///
        mlabcolor(black) mlabsize(vsmall)) ///
    (scatter share_in_group_pct year if lab_last != "", msymbol(none) mlabel(lab_last) mlabpos(3) ///
        mlabcolor(black) mlabsize(vsmall)) ///
    (scatter y_r1 year if s_in  != "", msymbol(none) mlabel(s_in)  mlabpos(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter y_r2 year if s_out != "", msymbol(none) mlabel(s_out) mlabpos(0) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter y_r3 year if s_unk != "", msymbol(none) mlabel(s_unk) mlabpos(0) mlabcolor(gs7)   mlabsize(vsmall)) ///
    (scatter y_r1 xh if h1 != "", msymbol(none) mlabel(h1) mlabpos(9) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter y_r2 xh if h2 != "", msymbol(none) mlabel(h2) mlabpos(9) mlabcolor(black) mlabsize(vsmall)) ///
    (scatter y_r3 xh if h3 != "", msymbol(none) mlabel(h3) mlabpos(9) mlabcolor(gs7)   mlabsize(vsmall)) ///
    (scatter ann_y ann_x if ann != "", msymbol(none) mlabel(ann) mlabvposition(ann_pos) mlabgap(0) ///
        mlabcolor(gs6) mlabsize(vsmall)), ///
    by(panel, cols(1) ixaxes graphregion(color(white) lcolor(white) ilcolor(white)) legend(position(6)) ///
        title("Figure R1-01. Share of firms that export, import or have foreign owners, by year", size(small) pos(11) span) ///
        note("Notes: Each line shows the percent of firms in the group among firms whose status is known; the rows" ///
             "below count the firms. Export status is unknown for `exu_lo'–`exu_hi'% of firms in 2010–2021. The 2022 file" ///
             "records only direct exports, and firms without them may still export through traders, so no firm" ///
             "is known to be a non-exporter and no 2022 share is drawn. The import jump after 2015 and the one-year" ///
             "foreign-ownership spike in 2020 more likely reflect changes in how the survey recorded these items than" ///
             "in firm behaviour; the data cannot tell which. The set of firms surveyed changes from year to year, and" ///
             "the figure does not follow individual firms, so it cannot show which firms started or stopped exporting," ///
             "importing or having foreign owners. The Paris climate agreement was adopted in December 2015." ///
             "`srcnote'" "`devnote'", size(vsmall) span linegap(0.6))) ///
    subtitle(, pos(11) ring(1) nobox fcolor(none) lcolor(none) size(small)) ///
    ylabel(0(25)100, angle(0) grid glcolor(gs14) glwidth(vthin) tlength(0) labsize(vsmall)) ///
    yscale(range(-40 100) noline) ytitle("Percent of firms", size(vsmall)) ///
    xlabel(2010(1)2022, tlength(0) labsize(vsmall) nogrid) xscale(range(2007.2 2023.3) noline) xtitle("") ///
    legend(order(2 "Firms in the group, % of firms whose status is known" 1 "No annual file") ///
        rows(1) size(vsmall) region(lstyle(none)) symxsize(6) keygap(1) colgap(8)) ///
    plotregion(lstyle(none) margin(small)) xsize(7.5) ysize(11)

graph export "figures/01_group_shares_support.png", width(2250) replace
graph export "figures/01_group_shares_support.pdf", replace

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/01_group_shares_support.png (elapsed `elapsed' s)"
quietly log close
