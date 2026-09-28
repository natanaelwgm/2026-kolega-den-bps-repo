/*==========================================================================
  R1-07  Year by year: do exporters, importers and foreign-owned firms buy
         more or less electricity per unit of value added than other firms,
         and are they more likely to make their own electricity? Did these
         gaps change after the Paris Agreement (December 2015)?
  Answers Deasy R1: outcomes "Electricity" and "Self generation" (and
         "Energi use ... scope 2" = bought electricity); groups "export vs
         non export, import vs non import, fdi vs non fdi"; "Did
         internationally engaged firms change their environmental behaviour
         more strongly after the Paris Agreement?"
  Foreign-owned = 10% or more of the firm's capital held abroad
         (fdi_10_flag), the definition used in every R1-R3 exhibit.
  Output : figures/07_electricity_own_generation.png (+ .pdf)
           tables/07_electricity_own_generation.csv  (3 groupings x year x 6 measures)
           tables/07_electricity_own_generation_table.pdf (every plotted point)
  Runtime: about 1-2 minutes (999 random redraws per grouping and year).
  Development data — obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
args data_arg outdir_arg        // optional: 00_run.do passes the two paths
clear all
set more off
set varabbrev off
set linesize 120
set type double                 // new variables keep full precision

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

* ---- THE GROUPS AND THE YEARS IN DOUBT (why: INDEX.md, paragraph "07") -----------------
* One column of panels per grouping. Unknown status is left out, never counted as "no".
local gvars  "export_flag import_flag fdi_10_flag"
local g1_1 "Exporters"
local g0_1 "Non-exporters"
local g1_2 "Importers"
local g0_2 "Non-importers"
local g1_3 "Foreign-owned"
local g0_3 "Other firms"
* Years NOT drawn (numbers stay in the table). Exporters 2022 drop out by themselves:
* the 2022 file records no firm as a non-exporter.
local skip_1 ""
local skip_2 ""
local skip_3 "2020"                      // far more firms marked foreign-owned that year (R1-01, R1-04)
* Years drawn hollow gray: the group's energy records are in doubt (same years as R1-03, R1-04)
local flag_1 ""
local flag_2 "2017 2019 2020 2021 2022"  // importers: energy jumps in 2017, falls to about a fifth from 2019
local flag_3 "2017 2019 2021 2022"       // foreign-owned: many firms' energy records jump or drop
local flag0_1 ""                         // "yes" = the other firms' marks are light gray in those years too
local flag0_2 ""
local flag0_3 "yes"
local min_n  30        // a group's yearly value is used only if at least 30 firms have it
local og_min 75        // own-electricity rows use a year only if at least 75% of BOTH groups' firms
                       // have own electricity recorded (2014-15: 57-60% of all firms; the unrecorded
                       // firms are mostly firms making none, so dividing by recorded firms inflates it)
local ref_yrs "2013 2014"   // reference years of the "far below" record check (Deasy's pre-Paris years)
local reps   999       // random redraws of each year's firms for the 95% ranges
* ------------------------------------------------------------------------------------------

cap log close
log using "logs/07_electricity_own_generation.log", replace text
timer clear 1
timer on 1
display _newline "=== [R1-07] STARTING: bought and own electricity by year, three groupings vs other firms ==="

* ---- chart style (identical block in every file) ----
set scheme s1mono
capture graph set window fontface "Times New Roman"   // GUI Stata; console Stata keeps its default font
* Note: this changes your Stata graph font permanently; undo with: graph set window fontface default
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."
* graph combine rescales relative text sizes, so text is set in points (as in R3-06):
* 13pt = "small" and 10pt = "vsmall" in the other R1 figures.
local sm "13pt"
local vs "10pt"

*---------------------------------------------------------------------------
display "Step 1/8: load electricity, energy, value added and the three group flags"
*---------------------------------------------------------------------------
* elec_purchased_kwh = electricity bought from PLN and other suppliers (kWh); never missing
* elec_owngen_kwh    = electricity the firm makes itself (kWh); missing = not recorded
* gj_electricity     = bought electricity in GJ (kWh x 0.0036); total_gj_s1 = nine fuels + bought electricity
* Own electricity is NOT inside total_gj_s1 (the fuel burnt to make it is, if it is one of the nine fuels).
use firm_id year export_flag import_flag fdi_10_flag elec_purchased_kwh elec_owngen_kwh own_gen_unknown ///
    gj_electricity total_gj_s1 value_added_nominal using "$DATA", clear
isid firm_id year
assert year != 2016
assert inlist(export_flag, 0, 1, .) & inlist(import_flag, 0, 1, .) & inlist(fdi_10_flag, 0, 1, .)
assert !missing(elec_purchased_kwh) & elec_purchased_kwh >= 0
assert own_gen_unknown == missing(elec_owngen_kwh)          // "not recorded" means exactly "missing"
assert elec_owngen_kwh >= 0 if !missing(elec_owngen_kwh)
assert abs(gj_electricity - 0.0036 * elec_purchased_kwh) <= 1e-9 * max(1, gj_electricity)

*---------------------------------------------------------------------------
display "Step 2/8: one value per firm and year for each measure"
*---------------------------------------------------------------------------
* "Absent is not zero": a firm with no bought electricity recorded is left out of the
* per-value-added measure, not counted as zero. Value added must be above zero to divide by it.
gen byte va_ok = value_added_nominal > 0 & !missing(value_added_nominal)
gen byte bought = va_ok & elec_purchased_kwh > 0
gen byte rec    = !missing(elec_owngen_kwh)                  // own electricity recorded (yes or no)
gen byte maker  = rec & elec_owngen_kwh > 0                  // makes some of its own electricity
* drawn:
gen double m1 = 1e3 * elec_purchased_kwh / value_added_nominal if bought  // thousand kWh per million of value added
gen double m2 = 100 * maker if rec                                        // 100 = makes some, 0 = none (share of firms)
gen double m3 = 100 * elec_owngen_kwh / (elec_owngen_kwh + elec_purchased_kwh) if maker  // own, % of electricity used
* table only:
gen double m4 = 100 * gj_electricity / total_gj_s1 if va_ok & total_gj_s1 > 0 & !missing(total_gj_s1) // bought, % of energy
gen double m5 = elec_purchased_kwh / 1e3 if bought           // bought electricity, thousand kWh per firm
gen double m6 = elec_owngen_kwh / 1e3 if maker               // own electricity, thousand kWh per firm making some
local K 6
* Record check that does not use any group flag: bought electricity per unit of value added
* below a fifth of the all-firm median of the reference years (flags records that fall away).
local ref_in = subinstr("`ref_yrs'", " ", ",", .)
quietly summarize m1 if inlist(year, `ref_in'), detail
local m1ref = r(p50)
gen double far_below = 100 * (m1 < `m1ref' / 5) if !missing(m1)
display "   all-firm median of bought electricity per unit of value added in `ref_yrs': " %6.2f `m1ref' " thousand kWh per million"
gen byte one = 1
keep firm_id year export_flag import_flag fdi_10_flag rec one far_below m1-m`K'
tempfile base
save `base'

*---------------------------------------------------------------------------
display "Step 3/8: yearly values and counts for each group"
*---------------------------------------------------------------------------
* m2 is a share of firms, so its yearly value is the average of 0/100; the others are medians
* (the middle firm), because the ratios have extreme tails.
local i 0
foreach g of local gvars {
    local ++i
    use `base', clear
    gen byte grp = `g'
    preserve
    gen byte unk = missing(grp)
    collapse (sum) firms_unknown_status = unk, by(year)
    tempfile unk`i'
    save `unk`i''
    restore
    drop if missing(grp)
    local cnt ""
    forvalues k = 1/`K' {
        local cnt "`cnt' n`k' = m`k'"
    }
    collapse (p50) m1 m3 m4 m5 m6 (mean) m2 far_below (count) `cnt' (sum) firms = one n_rec = rec, by(year grp)
    gen double pct_rec = 100 * n_rec / firms
    gen str12 grouping = "`g'"
    gen byte gi = `i'
    merge m:1 year using `unk`i'', nogenerate assert(match)
    tempfile yr`i'
    save `yr`i''
}
use `yr1', clear
append using `yr2' `yr3'
reshape long m n, i(grouping gi year grp) j(k)
reshape wide m n firms n_rec pct_rec far_below, i(grouping gi year k) j(grp)
* a group with no firm in a year (exporters 2022: no known non-exporters) counts 0 firms, not missing
foreach v in n0 n1 firms0 firms1 n_rec0 n_rec1 {
    replace `v' = 0 if missing(`v')
}
tempfile yearly
save `yearly'

*---------------------------------------------------------------------------
display "Step 4/8: gaps between each group and the other firms, with `reps' random redraws"
*---------------------------------------------------------------------------
* Gap (1) = group's median as % of the other firms' median (100 = same).
* Gap (2), (3) = group minus other firms, in percentage points (0 = same).
* The 95% range: redraw each year's firms at random within each group (bootstrap, percentile).
capture program drop r107gap
program define r107gap, rclass
    args ok1 ok2 ok3
    foreach k in 1 3 {
        if `ok`k'' {
            quietly _pctile m`k' if grp == 1, p(50)
            local a = r(r1)
            quietly _pctile m`k' if grp == 0, p(50)
            local b = r(r1)
            return scalar gap`k' = cond(`k' == 1, 100 * `a' / `b', `a' - `b')
        }
        else return scalar gap`k' = 0
    }
    if `ok2' {
        quietly summarize m2 if grp == 1, meanonly
        local a = r(mean)
        quietly summarize m2 if grp == 0, meanonly
        return scalar gap2 = `a' - r(mean)
    }
    else return scalar gap2 = 0
end
tempname h
tempfile gaps
postfile `h' byte gi int year byte k double(gap gap_lo95 gap_hi95) using `gaps', replace
local i 0
foreach g of local gvars {
    local ++i
    use `base', clear
    gen byte grp = `g'
    drop if missing(grp)
    levelsof year, local(yrs)
    foreach y of local yrs {
        * a measure's gap is computed only if both groups have at least min_n firms with it
        local any 0
        forvalues k = 1/3 {
            quietly count if year == `y' & grp == 1 & !missing(m`k')
            local c1 = r(N)
            quietly count if year == `y' & grp == 0 & !missing(m`k')
            local ok`k' = `c1' >= `min_n' & r(N) >= `min_n'
            if `ok`k'' local any 1
        }
        if !`any' continue
        preserve
        quietly keep if year == `y'
        quietly bootstrap gap1 = r(gap1) gap2 = r(gap2) gap3 = r(gap3), reps(`reps') seed(20260925) ///
            strata(grp) double nodots: r107gap `ok1' `ok2' `ok3'
        matrix b  = e(b)
        quietly estat bootstrap, percentile
        matrix ci = e(ci_percentile)
        forvalues k = 1/3 {
            if `ok`k'' post `h' (`i') (`y') (`k') (b[1,`k']) (ci[1,`k']) (ci[2,`k'])
        }
        restore
    }
    display "   `g': gaps done"
}
postclose `h'

*---------------------------------------------------------------------------
display "Step 5/8: table -> CSV (numbers written before drawing)"
*---------------------------------------------------------------------------
use `yearly', clear
merge 1:1 gi year k using `gaps', nogenerate assert(master match)
* point gap from the yearly values (the bootstrap's own point estimate must agree)
gen double gap_chk = cond(k == 1, 100 * m1 / m0, m1 - m0) if inlist(k, 1, 2, 3)
assert reldif(gap, gap_chk) < 1e-9 if !missing(gap)
drop gap_chk
assert gap_lo95 <= gap + 1e-9 & gap <= gap_hi95 + 1e-9 if !missing(gap)
* one explicit empty row per grouping and measure for 2016 (no annual file), never zeros
preserve
bysort gi k: keep if _n == 1
keep grouping gi k
gen int year = 2016
tempfile y2016
save `y2016'
restore
append using `y2016'
gen byte annual_file = year != 2016
* drawn: measures 1-3, both groups supported, not a skipped year, own-electricity recorded enough
gen byte in_figure = inrange(k, 1, 3)
gen byte drawn = in_figure & annual_file & n1 >= `min_n' & n0 >= `min_n' & !missing(m1, m0)
replace drawn = 0 if inlist(k, 2, 3) & (pct_rec1 < `og_min' | pct_rec0 < `og_min')
gen byte skipped = 0
gen byte flagged = 0
gen byte flag_other = 0
forvalues i = 1/3 {
    foreach y of local skip_`i' {
        replace skipped = 1 if gi == `i' & year == `y' & drawn
        replace drawn = 0   if gi == `i' & year == `y'
    }
    foreach y of local flag_`i' {
        replace flagged = 1 if gi == `i' & year == `y' & drawn
        if "`flag0_`i''" == "yes" replace flag_other = 1 if gi == `i' & year == `y' & drawn
    }
}
gen byte clear = cond(k == 1, gap_lo95 > 100 | gap_hi95 < 100, gap_lo95 > 0 | gap_hi95 < 0) if !missing(gap)
* labels: what each row is
gen str20 group_variable = word("`gvars'", gi)
gen str20 grp1_label = ""
gen str20 grp0_label = ""
forvalues i = 1/3 {
    replace grp1_label = "`g1_`i''" if gi == `i'
    replace grp0_label = "`g0_`i''" if gi == `i'
}
gen str60 measure = ""
gen str60 unit = ""
gen str30 statistic = "median of firms"
gen str50 deasy_item = ""
replace measure = "Bought electricity per unit of value added"          if k == 1
replace measure = "Firms making some of their own electricity"          if k == 2
replace measure = "Own electricity, % of electricity used (makers)"     if k == 3
replace measure = "Bought electricity, % of energy used"                if k == 4
replace measure = "Bought electricity per firm"                         if k == 5
replace measure = "Own electricity per firm making some"                if k == 6
replace unit = "thousand kWh per million of value added (current prices)" if k == 1
replace unit = "% of firms with own electricity recorded"                 if k == 2
replace unit = "% of kWh used (own + bought)"                             if k == 3
replace unit = "% of GJ (nine fuels + bought electricity)"                if k == 4
replace unit = "thousand kWh"                                             if inlist(k, 5, 6)
replace statistic = "share of firms (average of 0/100)" if k == 2
replace deasy_item = "Electricity; Energi use scope 2 (per unit of VA)" if k == 1
replace deasy_item = "Self generation (whether)"                        if k == 2
replace deasy_item = "Self generation (how much)"                       if inlist(k, 3, 6)
replace deasy_item = "Electricity (share of energy)"                    if k == 4
replace deasy_item = "Electricity (amount); Energi use scope 2"         if k == 5
gen str40 gap_unit = cond(k == 1, "group as % of other firms (100 = same)", "percentage points (0 = same)") if in_figure
* equivalent in GJ (1 kWh = 0.0036 GJ), to compare with the scope-2 rows of R1-05
gen double gj_per_mva_grp1 = 3.6 * m1 if k == 1
gen double gj_per_mva_grp0 = 3.6 * m0 if k == 1
replace far_below1 = . if k != 1
replace far_below0 = . if k != 1
gen str100 note = ""
replace note = "No annual file" if year == 2016
replace note = "Table only" if annual_file & !in_figure
replace note = "Not drawn: fewer than `min_n' firms with a value in a group" if in_figure & annual_file & (n1 < `min_n' | n0 < `min_n' | missing(m1, m0))
replace note = "Not drawn: own electricity recorded for under `og_min'% of a group's firms" ///
    if inlist(k, 2, 3) & annual_file & note == "" & (pct_rec1 < `og_min' | pct_rec0 < `og_min')
replace note = "Not drawn: foreign ownership flag spikes that year (likely a recording change)" if skipped == 1
replace note = "Drawn hollow gray: the group's energy records are in doubt (see R1-03, R1-04)" if flagged == 1
rename (m1 m0 n1 n0 firms1 firms0 n_rec1 n_rec0 pct_rec1 pct_rec0 far_below1 far_below0 k) ///
       (value_grp1 value_grp0 n_grp1 n_grp0 firms_grp1 firms_grp0 n_recorded_grp1 n_recorded_grp0 ///
        pct_recorded_grp1 pct_recorded_grp0 pct_far_below_grp1 pct_far_below_grp0 measure_id)
order grouping group_variable grp1_label grp0_label measure_id measure unit statistic deasy_item in_figure ///
      year annual_file drawn flagged flag_other firms_grp1 firms_grp0 firms_unknown_status ///
      n_recorded_grp1 n_recorded_grp0 pct_recorded_grp1 pct_recorded_grp0 n_grp1 n_grp0 ///
      value_grp1 value_grp0 gap gap_lo95 gap_hi95 gap_unit clear gj_per_mva_grp1 gj_per_mva_grp0 ///
      pct_far_below_grp1 pct_far_below_grp0 note
sort gi measure_id year
format firms_* n_* %9.0f
format value_* gj_per_* %12.4f
format gap gap_lo95 gap_hi95 pct_* %8.2f
export delimited grouping-note using "tables/07_electricity_own_generation.csv", datafmt replace
tempfile table
save `table'
list grouping measure_id year n_grp1 n_grp0 value_grp1 value_grp0 gap gap_lo95 gap_hi95 drawn ///
    if in_figure & annual_file, noobs clean abbreviate(24)

* For the log (and INDEX): average gap before Paris (drawn years up to 2015) vs 2018
display "   average gap in drawn years before Paris vs in 2018 (ratio gaps averaged in logs):"
forvalues i = 1/3 {
    forvalues k = 1/3 {
        quietly summarize gap if gi == `i' & measure_id == `k' & drawn & year <= 2015
        local pre = r(mean)
        if `k' == 1 {
            tempvar lg
            quietly gen double `lg' = ln(gap) if gi == `i' & measure_id == `k' & drawn & year <= 2015
            quietly summarize `lg'
            local pre = exp(r(mean))
            drop `lg'
        }
        quietly summarize gap if gi == `i' & measure_id == `k' & year == 2018
        display "      " word("`gvars'", `i') ", measure `k': before " %7.1f `pre' "   2018 " %7.1f r(mean)
    }
}

*---------------------------------------------------------------------------
display "Step 6/8: numbers for the notes (read from the data, never typed)"
*---------------------------------------------------------------------------
* own electricity recorded, % of all firms, in the years left out of (d)-(i)
use `base', clear
collapse (mean) rec, by(year)
quietly summarize rec if rec < `og_min' / 100
local rec_lo = strtrim(string(100 * r(min), "%4.0f"))
local rec_hi = strtrim(string(100 * r(max), "%4.0f"))
levelsof year if rec < `og_min' / 100, local(lowyrs)
local ly1 : word 1 of `lowyrs'
local nly : word count `lowyrs'
local ly2 : word `nly' of `lowyrs'
local lowtxt = cond(`nly' > 1, "`ly1'–`ly2'", "`ly1'")
display "   own electricity recorded for `rec_lo'–`rec_hi'% of firms in `lowtxt'"
* the notes mention left-out years only if there are any (on complete records there are none)
local recrng = cond("`rec_lo'" == "`rec_hi'", "`rec_lo'", "`rec_lo'–`rec_hi'")
local lowsent ""
if `nly' > 0 local lowsent "; `lowtxt' left out (recorded for only `recrng'% of firms, mostly those making none)"
* makers' own share of their electricity, all firms: middle value before vs after Paris,
* using only the years drawn in (g)-(i) (the low-recorded years above are left out here too)
use `base', clear
gen byte lowyr = 0
foreach y of local lowyrs {
    quietly replace lowyr = 1 if year == `y'
}
quietly summarize year if year > 2016
local post1 = r(min)                                  // first annual file after the 2016 gap
quietly summarize m3 if year < 2016 & !lowyr, detail
local own_pre = strtrim(string(r(p50), "%4.0f"))
quietly summarize m3 if year > 2016 & !lowyr, detail
local own_post = strtrim(string(r(p50), "%4.0f"))
display "   makers' own share of their electricity (all makers): `own_pre'% before Paris, `own_post'% after"
* firms with no export answer, first file after the gap: share of importers, and how often
* they make their own electricity (they are left out of the exporter panels, not the others)
quietly count if year == `post1' & import_flag == 1
local nimp = r(N)
quietly count if year == `post1' & import_flag == 1 & missing(export_flag)
local imp_unk = strtrim(string(100 * r(N) / `nimp', "%4.0f"))
quietly summarize m2 if year == `post1' & missing(export_flag)
local unk_mk = strtrim(string(r(mean), "%4.0f"))
quietly summarize m2 if year == `post1' & !missing(export_flag)
local kn_mk = strtrim(string(r(mean), "%4.0f"))
display "   `post1': `imp_unk'% of importers have no export answer; `unk_mk'% of such firms make own electricity, `kn_mk'% of firms with an answer"

*---------------------------------------------------------------------------
display "Step 7/8: draw three rows of three panels, then combine"
*---------------------------------------------------------------------------
* Each row is one plain twoway: the three groups sit side by side, shifted by `sh' years
* (graph combine handles plain graphs better than by() graphs; same method as R3-06).
local sh = 17
local ytl1 "thousand kWh"
local ytl2 "% of firms"
local ytl3 "% of electricity used"
local row1 "Bought electricity: thousand kWh per million of value added, middle firm"
local row2 "Firms making some of their own electricity, % of firms"
local row3 "Own electricity as % of the electricity used, middle firm among those making some"
local letters "a b c d e f g h i"
forvalues r = 1/3 {
    use `table', clear
    keep if measure_id == `r'
    keep gi year drawn flagged flag_other value_grp1 value_grp0
    gen double x = year + (gi - 1) * `sh'
    gen double y1  = value_grp1 if drawn & !flagged
    gen double y1f = value_grp1 if drawn & flagged
    gen double y0  = value_grp0 if drawn & !flag_other
    gen double y0f = value_grp0 if drawn & flag_other
    * one empty row after each panel, so no line runs from one panel into the next
    local n0 = _N
    set obs `=_N + 3'
    forvalues i = 1/3 {
        replace gi = `i' in `=`n0' + `i''
        replace x = 2023.5 + (`i' - 1) * `sh' in `=`n0' + `i''
    }
    * shared scale for the row: a round number above the highest mark
    egen double pmax = rowmax(y1 y1f y0 y0f)
    quietly summarize pmax
    local top = r(max)
    local mag = 10^floor(log10(`top'))
    local step = cond(`top' / `mag' < 2, `mag' / 5, cond(`top' / `mag' < 5, `mag' / 2, `mag'))
    if `top' / `step' > 5 local step = 2 * `step'        // at most about five steps per axis
    local top = `step' * ceil(1.02 * `top' / `step')
    if `r' == 2 {
        local top 100
        local step 25
    }
    * endpoint labels: first and last drawn year of each line in each panel; higher line above
    gen double v1 = cond(!missing(y1), y1, y1f)
    gen double v0 = cond(!missing(y0), y0, y0f)
    bysort gi: egen fy = min(cond(!missing(v1), year, .))
    bysort gi: egen ly = max(cond(!missing(v1), year, .))
    gen byte endpt = inlist(year, fy, ly) & !missing(v1)
    local fmt = cond(`r' == 1, "%9.1f", "%9.0f")
    gen str8 l1  = string(y1,  "`fmt'") if endpt & !missing(y1)
    gen str8 l1f = string(y1f, "`fmt'") if endpt & !missing(y1f)
    gen str8 l0  = string(y0,  "`fmt'") if endpt & !missing(y0)
    gen str8 l0f = string(y0f, "`fmt'") if endpt & !missing(y0f)
    gen byte p1 = cond(year == fy, cond(v1 >= v0, 10, 8), cond(v1 >= v0, 2, 4)) if endpt
    gen byte p0 = cond(year == fy, cond(v0 >  v1, 10, 8), cond(v0 >  v1, 2, 4)) if endpt
    sort x
    * per panel: gridlines, 2016 band, Paris line, title, x labels, "not drawn" line
    local grid ""
    local band ""
    local paris ""
    local txt ""
    local xl ""
    local xm ""
    forvalues i = 1/3 {
        local o = (`i' - 1) * `sh'
        forvalues gv = `step'(`step')`top' {
            local grid `grid' `gv' `=2009.2 + `o'' `gv' `=2022.8 + `o''
        }
        local band  `band' `top' `=2016 + `o'' 0 `=2016 + `o''
        local paris `paris' 0 `=2015.5 + `o'' `top' `=2015.5 + `o''
        local li = (`r' - 1) * 3 + `i'
        local lt : word `li' of `letters'
        local txt `"`txt' text(`=1.13 * `top'' `=2008.6 + `o'' "(`lt') `g1_`i''", place(e) size(`sm'))"'
        foreach y in 2010 2013 2016 2019 2022 {
            local xl `"`xl' `=`y' + `o'' "`y'""'
        }
        * years with an annual file that this panel does not draw, listed under its axis
        quietly levelsof year if gi == `i' & !drawn & year != 2016 & !missing(year), local(nd)
        if "`nd'" != "" {
            local ndt ""
            local start ""
            local prev ""
            foreach y of local nd {
                if "`prev'" == "" local start `y'
                else if `y' != `prev' + 1 {
                    local run = cond(`start' == `prev', "`start'", "`start'–`prev'")
                    local ndt = cond("`ndt'" == "", "`run'", "`ndt', `run'")
                    local start `y'
                }
                local prev `y'
            }
            local run = cond(`start' == `prev', "`start'", "`start'–`prev'")
            local ndt = cond("`ndt'" == "", "`run'", "`ndt', `run'")
            local xm `"`xm' `=2016 + `o'' "Not drawn: `ndt'""'
        }
    }
    if `"`xm'"' != "" local xm `"xmlabel(`xm', noticks tlength(0) labsize(`vs') labcolor(gs6) labgap(15pt))"'
    * flagged layers only where such years exist in this row
    local fl ""
    local fk ""
    local hasg 0
    quietly count if !missing(y1f)
    if r(N) > 0 {
        local hasg 1
        local fl `"`fl' (connected y1f x, cmissing(n) lcolor(gs8) lpattern(solid) lwidth(0.6pt) msymbol(Oh) msize(4.5pt) mcolor(gs8) mlabel(l1f) mlabvposition(p1) mlabsize(`vs') mlabcolor(gs6))"'
        local fk `"`fk' 6 "Records in doubt: the panel's group""'
    }
    quietly count if !missing(y0f)
    if r(N) > 0 {
        local nf = 6 + `hasg'
        local fl `"`fl' (connected y0f x, cmissing(n) lcolor(gs11) lpattern(shortdash) lwidth(0.6pt) msymbol(Sh) msize(4.5pt) mcolor(gs11) mlabel(l0f) mlabvposition(p0) mlabsize(`vs') mlabcolor(gs9))"'
        local fk `"`fk' `nf' "Records in doubt: other firms""'
    }
    local leg "legend(off)"
    local fys 30
    if `r' == 3 {
        local leg `"legend(order(4 "Exporters, importers or foreign-owned (panel title)" 5 "Other firms whose status is known" `fk' 3 "Paris Agreement adopted (December 2015)" 2 "No annual file") pos(6) cols(2) region(lcolor(none)) size(`vs') symxsize(8) keygap(1) colgap(4) rowgap(0.3))"'
        local fys 47
    }
    twoway (pci `grid', lcolor(gs15) lwidth(vthin)) ///
        (pci `band', lcolor(gs14) lwidth(9pt)) ///
        (pci `paris', lcolor(gs4) lpattern(shortdash) lwidth(0.5pt)) ///
        (connected y1 x, cmissing(n) lcolor(black) lpattern(solid) lwidth(0.8pt) msymbol(O) msize(4.5pt) mcolor(black) ///
            mlabel(l1) mlabvposition(p1) mlabsize(`vs') mlabcolor(black)) ///
        (connected y0 x, cmissing(n) lcolor(gs6) lpattern(shortdash) lwidth(0.8pt) msymbol(Sh) msize(4.5pt) mcolor(gs6) ///
            mlabel(l0) mlabvposition(p0) mlabsize(`vs') mlabcolor(gs6)) ///
        `fl', ///
        `txt' ///
        subtitle("`row`r''", size(`sm') pos(11) nobox) ///
        ytitle("`ytl`r''", size(`vs')) ///
        ylabel(0(`step')`top', angle(0) noticks tlength(0) nogrid labsize(`vs') format(%9.0f)) ///
        yscale(noline range(0 `=1.18 * `top'')) ///
        xlabel(`xl', noticks tlength(0) labsize(`vs')) `xm' ///
        xscale(noline range(2008 `=2024 + 2 * `sh'')) xtitle("") ///
        `leg' graphregion(color(white) lcolor(white)) plotregion(style(none)) ///
        fysize(`fys') name(row`r', replace) nodraw
}

* Notes: one text, wrapped here into lines of at most 120 characters (8-inch figure; the PDF
* runs wider than the PNG, so check the PDF's right edge after any wording change)
local ntext "Notes: Middle firm = median. (a)–(c): electricity bought from the grid or other suppliers; value added = output value minus materials, energy and services bought, at current prices, so price rises alone push (a)–(c) down. (d)–(i): firms whose own electricity is recorded`lowsent'. (g)–(i): from `post1' makers record a far smaller share of their own electricity in every group (middle value `own_pre'% before Paris, `own_post'% after), likely a change in recording, so compare groups within a year. From `post1' the files count far more firms as importers, `imp_unk'% of them with no export answer. In `post1', `unk_mk'% of firms with no export answer make some of their own electricity (`kn_mk'% of firms with one): they are left out of (a), (d), (g) but lift the lines in (e) and (f). Hollow gray = the group's energy records are in doubt that year (Figures R1-03, R1-04). Foreign-owned = 10%+ of capital held abroad. Firms differ each year (none is followed) and groups differ in size and industry: this shows gaps, not their cause. Each gap and its 95% range is in the table."
local notelines ""
local line ""
foreach w of local ntext {
    if ustrlen("`line' `w'") > 120 & "`line'" != "" {
        local notelines `"`notelines' "`line'""'
        local line "`w'"
    }
    else local line = strtrim("`line' `w'")
}
local notelines `"`notelines' "`line'""'
display `"   note lines: `notelines'"'

graph combine row1 row2 row3, cols(1) iscale(1) imargin(0 0 1 1) ///
    title("Figure R1-07. Electricity bought and electricity made by the firm, by year and group", size(`sm') pos(11) span) ///
    note(`notelines' "`srcnote'" "`devnote'", size(`vs') span linegap(0.6)) ///
    graphregion(color(white) lcolor(white) margin(r+2)) xsize(8) ysize(11.5)

graph export "figures/07_electricity_own_generation.png", width(2400) replace
graph export "figures/07_electricity_own_generation.pdf", replace

*---------------------------------------------------------------------------
display "Step 8/8: companion table: every plotted point"
*---------------------------------------------------------------------------
* ==== COMPANION TABLE (pattern for all exhibits) =============================
* Owner rule, 28 Sep 2026: every chart gets a table of every plotted point, and
* every chart of regression coefficients also gets a regression table, written
* by the same do-file (spec: TABLE_BRIEF.md). This step runs AFTER the graph
* export, so the chart and the CSV stay byte-identical.
*
* How to use it in another exhibit file:
*   PART 1 (the writer, program ctable_pdf) is copied UNCHANGED.
*   PART 2 is the only exhibit-specific part: put the numbers in memory (the
*   tempfile saved right after the CSV export, or the CSV itself), build one
*   STRING variable per table column, one row per plotted point in chart order
*   (years not drawn included, with the reason in a status column), then call
*   ctable_pdf. Format numbers with string(x, "%9.1f") etc. so the table shows
*   exactly the rounding of the chart labels.
*
* ctable_pdf strvars using "tables/NN_name_table.pdf",
*     title("Table R1-02. ...: every plotted point")    first line, bold
*     header("Col 1" "Col 2" ...)       one text per column; "|" = line break
*     [right(numlist)]                  columns right-aligned (numbers)
*     [norepeat(numlist)]               columns whose repeated text is shown
*                                       only on the first row of a run
*     [rules(numlist)]                  thin gray line under these data rows
*     [notes("line 1" "line 2" ...)]    footer paragraphs (Notes, Source, dev line)
*     [subtitle(text)] [fontsize(#)] [perpage(#)] [landscape|portrait]
* Landscape is chosen automatically when there are more than 6 columns. Long
* tables continue on a new page with the header repeated ("(continued)"); a page
* never breaks inside a block whose first column is empty (e.g. an SE row).
* --- PART 1: the writer (identical in every file; do not edit) ---------------
capture program drop ctable_pdf
program define ctable_pdf
    version 17
    syntax varlist(string) using/, TItle(string) HEADer(string asis) ///
        [RIGHT(numlist integer >0) NOREPeat(numlist integer >0) RULES(numlist integer >0) ///
         NOTEs(string asis) SUBtitle(string) FONTsize(real 9.5) PERpage(integer 0) ///
         LANDscape PORTrait]
    local nc : word count `varlist'
    local nh : word count `header'
    if `nh' != `nc' {
        display as error "ctable_pdf: `nc' columns but `nh' header texts"
        exit 198
    }
    local orient = cond(`nc' > 6, "landscape", "")
    if "`landscape'" != "" local orient "landscape"
    if "`portrait'"  != "" local orient ""
    * rows per page: a conservative guess for 9-10 pt text (wrapped cells take more)
    if `perpage' == 0 local perpage = cond("`orient'" == "landscape", 24, 40)
    preserve
    quietly {
        keep `varlist'
        rename (`varlist') (__c#), addnumber      // __c1 __c2 ... in the order given
        forvalues j = 1/`nc' {
            replace __c`j' = strtrim(__c`j')
        }
        local N = _N
        gen long row = _n
        * page chunks: fill up to perpage rows; prefer to end a page at a rule,
        * never start a page on a row whose first column is empty
        gen int chunk = .
        local start 1
        local k 0
        while `start' <= `N' {
            local ++k
            local end = min(`start' + `perpage' - 1, `N')
            if `end' < `N' {
                local best 0
                foreach r of local rules {
                    if `r' >= `start' + floor(`perpage' / 2) & `r' <= `end' & `r' > `best' local best `r'
                }
                if `best' > 0 local end `best'
                else {
                    while `end' > `start' & __c1[`end' + 1] == "" {
                        local --end
                    }
                }
            }
            replace chunk = `k' in `start'/`end'
            local start = `end' + 1
        }
        local nk `k'
        * blank repeated labels inside each page; a column is blanked only while the
        * norepeat columns to its left are unchanged too (a new panel shows its series)
        gen byte same = _n > 1 & chunk == chunk[_n - 1]
        foreach j of local norepeat {
            gen strL o`j' = __c`j'
            replace same = same & o`j' == o`j'[_n - 1]
            replace __c`j' = "" if same
            drop o`j'
        }
        drop same
        * column widths (% of the page), from the longest text in each column;
        * long text columns are capped so they wrap instead of squeezing numbers
        matrix W = J(1, `nc', 0)
        local tot 0
        forvalues j = 1/`nc' {
            gen long L`j' = udstrlen(__c`j')
            summarize L`j', meanonly
            local w = max(r(max), 3)
            local h : word `j' of `header'
            local h = subinstr(`"`h'"', "|", " ", .)
            foreach hw of local h {
                local w = max(`w', udstrlen(`"`hw'"'))
            }
            local w = min(`w', 34) + 2          // + 2 = room for the cell margins
            matrix W[1, `j'] = `w'
            local tot = `tot' + `w'
            drop L`j'
        }
        local used 0
        forvalues j = 1/`nc' {
            if `j' < `nc' {
                matrix W[1, `j'] = max(floor(100 * W[1, `j'] / `tot'), 3)
                local used = `used' + W[1, `j']
            }
            else matrix W[1, `j'] = 100 - `used'
        }
    }
    putpdf clear
    putpdf begin, pagesize(A4) `orient' font("Times New Roman", `fontsize') ///
        margin(left, 0.8in) margin(right, 0.8in) margin(top, 0.5in) margin(bottom, 0.5in)
    forvalues k = 1/`nk' {
        if `k' > 1 putpdf pagebreak
        putpdf paragraph, spacing(after, 4pt)
        local tt = cond(`k' == 1, `"`title'"', `"`title' (continued)"')
        putpdf text (`"`tt'"'), bold font("Times New Roman", `=`fontsize' + 1.5')
        if `k' == 1 & `"`subtitle'"' != "" {
            putpdf paragraph, spacing(after, 4pt)
            putpdf text (`"`subtitle'"')
        }
        quietly count if chunk == `k'
        local nr = r(N) + 1
        quietly putpdf table T`k' = data(__c1-__c`nc') if chunk == `k', varnames border(all, nil) width(W)
        forvalues j = 1/`nc' {
            * header text; "|" starts a new line inside the cell
            local rest : word `j' of `header'
            local opt ""
            while `"`rest'"' != "" {
                gettoken part rest : rest, parse("|")
                if `"`part'"' == "|" {
                    putpdf table T`k'(1, `j') = (""), linebreak append
                    continue
                }
                putpdf table T`k'(1, `j') = (`"`part'"'), valign(bottom) `opt'
                local opt "append"
            }
            local al = cond(`: list j in right', "right", "left")
            putpdf table T`k'(., `j'), halign(`al') margin(top, 0pt) margin(bottom, 0pt)
        }
        putpdf table T`k'(1, .), border(top, single, black) border(bottom, single, black)
        putpdf table T`k'(`nr', .), border(bottom, single, black)
        foreach r of local rules {
            quietly summarize row if chunk == `k', meanonly
            if `r' >= r(min) & `r' < r(max) {
                putpdf table T`k'(`=`r' - r(min) + 2', .), border(bottom, single, "A6A6A6")
            }
        }
    }
    local first 1
    foreach n of local notes {
        putpdf paragraph, spacing(before, `=cond(`first', 6, 1)'pt)
        putpdf text (`"`n'"'), font("Times New Roman", `=`fontsize' - 0.5')
        local first 0
    }
    putpdf save `"`using'"', replace
    restore
end
* --- end of PART 1 ------------------------------------------------------------

* --- PART 2: the rows of this exhibit (the only part that changes per file) ---
* Source: the table saved right after the CSV export in Step 5 (full precision,
* same run as the chart). One row per point, in chart order: rows of panels
* (bought electricity, making own electricity, own share), within a row the
* panels left to right, within a panel the group's line then the other firms'
* line, every year of the axis, so years not drawn appear with the reason.
use `table', clear
keep if in_figure
local ncsv = _N                         // CSV rows of the drawn measures (both lines in one row)
quietly count if drawn
local ndrawn = r(N)
expand 2
bysort gi measure_id year: gen byte s = _n        // 1 = the panel's group, 2 = the other firms
gen byte pl = 3 * (measure_id - 1) + gi           // panel number: (a) to (i)
sort pl s year
* panel and series names as on the chart (panel title + the row's heading)
gen str90 t_panel = "(" + word("`letters'", pl) + ") " + "`g1_1'"
forvalues i = 1/3 {
    replace t_panel = "(" + word("`letters'", pl) + ") `g1_`i''" if gi == `i'
}
replace t_panel = t_panel + ": thousand kWh bought per million of VA, middle firm" if measure_id == 1
replace t_panel = t_panel + ": firms making some of their own electricity, %"     if measure_id == 2
replace t_panel = t_panel + ": own electricity, % of electricity used, middle maker" if measure_id == 3
gen str30 t_series = cond(s == 1, grp1_label, grp0_label)
gen str8  t_year   = string(year)
* the plotted number: rounded as the chart labels ((a)-(c) one decimal, (d)-(i) whole numbers)
gen double v = cond(s == 1, value_grp1, value_grp0)
gen str12 t_v = string(v, cond(measure_id == 1, "%9.1f", "%9.0f")) if !missing(v)
* firms with a value behind the point (the group's, or the other firms')
gen double nf = cond(s == 1, n_grp1, n_grp0)
gen str12 t_n = string(nf, "%12.0fc") if year != 2016
* the gap and its 95% range (table only), on the group's row: (a)-(c) group as % of the other
* firms (100 = same), whole numbers; (d)-(i) group minus other firms, points, one decimal
gen str12 t_g  = string(gap,      cond(measure_id == 1, "%9.0f", "%9.1f")) if s == 1 & !missing(gap)
gen str12 t_lo = string(gap_lo95, cond(measure_id == 1, "%9.0f", "%9.1f")) if s == 1 & !missing(gap)
gen str12 t_hi = string(gap_hi95, cond(measure_id == 1, "%9.0f", "%9.1f")) if s == 1 & !missing(gap)
* status: how (and whether) the point is drawn
gen str90 t_status = ""
replace t_status = "drawn: black dot"              if drawn & s == 1 & !flagged
replace t_status = "hollow gray: records in doubt" if drawn & s == 1 & flagged
replace t_status = "drawn: gray square"            if drawn & s == 2 & !flag_other
replace t_status = "light gray: records in doubt"  if drawn & s == 2 & flag_other
replace t_status = "not drawn: < `min_n' firms in a group"   if !drawn & strpos(note, "fewer than `min_n' firms")
replace t_status = "not drawn: under `og_min'% recorded"     if !drawn & strpos(note, "under `og_min'% of a group")
replace t_status = "not drawn: foreign flag spikes"         if !drawn & skipped == 1
replace t_status = "not drawn: no annual file" if year == 2016
* two no-break spaces keep the status text off the numbers to its left
replace t_status = uchar(160) + uchar(160) + t_status if t_status != ""
* checks: every drawn point is one row with a number; two rows per CSV row
assert t_status != ""
quietly count if !strpos(t_status, "not drawn")
assert r(N) == 2 * `ndrawn'
assert t_v != "" if !strpos(t_status, "not drawn")
assert _N == 2 * `ncsv'
local ntext_t = itrim(`"`ntext'"')
local tnote "Table: every point of Figure R1-07 in chart order, with the years not drawn and why (their numbers are shown when they exist)."
local tnote "`tnote' Values rounded as the chart labels. Firms = firms with a value behind the point. Gap (on the group's row; not drawn):"
local tnote "`tnote' (a)–(c) the group's median as % of the other firms' (100 = same); (d)–(i) group minus other firms, percentage"
local tnote "`tnote' points; 95% range from `reps' redraws of each year's firms. Not drawn: < `min_n' firms = fewer than `min_n' firms with a value"
local tnote "`tnote' in a group; under `og_min'% recorded = own electricity recorded for under `og_min'% of a group's firms; foreign flag spikes ="
local tnote "`tnote' far more firms marked foreign-owned that year (likely a recording change). Full precision: tables/07_electricity_own_generation.csv."
local rl ""
forvalues r = 13(13)`=_N - 1' {
    local rl "`rl' `r'"
}
ctable_pdf t_panel t_series t_year t_v t_n t_g t_lo t_hi t_status using "tables/07_electricity_own_generation_table.pdf", ///
    title("Table R1-07. Electricity bought and electricity made by the firm, by year and group: every plotted point") ///
    header("Panel" "Series" "Year" "Plotted|value" "Firms" "Gap to|other firms" "95%|low" "95%|high" "Status") ///
    right(3 4 5 6 7 8) norepeat(1 2) fontsize(8) rules(`rl') perpage(26) subtitle("`tnote'") ///
    notes("`ntext_t'" "`srcnote'" "`devnote'")
display "table -> tables/07_electricity_own_generation_table.pdf"
* --- end of PART 2 ------------------------------------------------------------

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
display "FINISHED: figure -> figures/07_electricity_own_generation.png (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
